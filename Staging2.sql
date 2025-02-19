select *
from dbo.dp_config_table ct
inner join dbo.dp_config_group g
on ct.group_Id = g.group_Id
where Group_Name = 'DEV_CIMS';

