select * from Parts where PartNumber like '0000-%'
select count(*) from Parts

select top 20 percent * from Parts
select * from Parts

delete from Parts where id is null

insert Parts select * from merge


declare @New_Id int
set @New_Id = 0
declare note_cursor cursor for select * from Parts

open note_cursor
fetch next from note_cursor
set @New_Id = @New_Id + 1	    
update Parts set ID=@New_Id where current of note_cursor 
while @@FETCH_STATUS = 0
	begin
		fetch next from note_cursor
		set @New_Id = @New_Id + 1	    
		update Parts set ID=@New_Id where current of note_cursor 
	end  

close note_cursor
deallocate note_cursor


select * from quoteraw order by TGID