MERGE INTO Person AS P
USING (
    SELECT *
    FROM  OPENJSON(@json)
          WITH (id int, firstName nvarchar(50), lastName nvarchar(50),
                age int, dateOfBirth datetime2) InputJSON
   ON (P.id = InputJSON.id)
WHEN MATCHED THEN
    UPDATE SET P.firstName = InputJSON.firstName,
               P.lastName = InputJSON.lastName,
               P.age = InputJSON.age,
               P.dateOfBirth = InputJSON.dateOfBirth
WHEN NOT MATCHED THEN
    INSERT (firstName, lastName, age, dateOfBirth)
    VALUES (InputJSON.firstName, InputJSON.lastName, InputJSON.age, InputJSON.dateOfBirth);




select
    col.name as ColumnName,
    column_id ColumnId,
    typ.name as ColumnType,
 -- create type with size based on type name and size
 case typ.name
  when 'char' then '(' + cast(col.max_length as varchar(10))+ ')'
        when 'nchar' then '(' + cast(col.max_length as varchar(10))+ ')'
        when 'nvarchar' then (IIF(col.max_length=-1, '(MAX)', '(' + cast(col.max_length as varchar(10))+ ')'))
        when 'varbinary' then (IIF(col.max_length=-1, '(MAX)', '(' + cast(col.max_length as varchar(10))+ ')'))
        when 'varchar' then (IIF(col.max_length=-1, '(MAX)', '(' + cast(col.max_length as varchar(10))+ ')'))
  else ''
 end as StringSize,
 -- if column is not nullable, add Strict mode in JSON
    case
        when col.is_nullable = 1 then '$.' else 'strict $.'
    end Mode,
 CHARINDEX(col.name, @JsonColumns,0) as IsJson
from sys.columns col
    join sys.types typ on
        col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
   LEFT JOIN dbo.syscomments SM ON col.default_object_id = SM.id 
where object_id = object_id(QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName))
-- Do not insert identity, computed columns, hidden columns, rowguid columns, generated always columns
-- Skip columns that cannot be parsed by JSON, e.g. text, sql_variant, etc.
and col.is_identity = 0
and col.is_computed = 0
and col.is_hidden = 0
and col.is_rowguidcol = 0
and generated_always_type = 0
and (sm.text IS NULL OR sm.text NOT LIKE '(NEXT VALUE FOR%')
and LOWER(typ.name) NOT IN ('text', 'ntext', 'sql_variant', 'image','hierarchyid','geometry','geography')
and col.name NOT IN (SELECT value FROM STRING_SPLIT(@IgnoredColumns, ','))
