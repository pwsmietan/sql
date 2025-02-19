select * from Eligibility where note is NULL
select * from Eligibility where [system part number]='172686-01' 
select * from Eligibility

delete from Eligibility where remarks is null and [system part number] is null and [sup #] is null


/* In the case where the NOTE field is NULL (usually after DTS process where we import the raw Excel data) */
/* we reset the NOTE field so that it is properly numbered {1..n}. */
declare @New_Id int
set @New_Id = 0
declare note_cursor cursor for select * from Eligibility

open note_cursor
fetch next from note_cursor
set @New_Id = @New_Id + 1	    
update Eligibility set NOTE=@New_Id where current of note_cursor 
while @@FETCH_STATUS = 0
	begin
		fetch next from note_cursor
		set @New_Id = @New_Id + 1	    
		update Eligibility set NOTE=@New_Id where current of note_cursor 
	end  

close note_cursor
deallocate note_cursor

/* Add ID numbers to Parts table */
declare @New_Id int
set @New_Id = 0
declare id_cursor cursor for select * from Parts

open id_cursor
fetch next from id_cursor
set @New_Id = @New_Id + 1	    
update Parts set ID=@New_Id where current of id_cursor 
while @@FETCH_STATUS = 0
	begin
		fetch next from id_cursor
		set @New_Id = @New_Id + 1	    
		update Parts set ID=@New_Id where current of id_cursor 
	end  

close id_cursor
deallocate id_cursor

select * from Parts where partnumber like '2485%'

SELECT     *
FROM         merge
WHERE     ([PART NUMBER] IN
                          (SELECT     PartNumber
                            FROM          Parts))

select * from Parts where PartNumber='178075-2700'

delete from Parts
WHERE     ([PARTNUMBER] IN
                          (SELECT     [Part Number]
                            FROM          merge))
