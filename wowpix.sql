delete from PictureCatalog
delete from Transactions


select * from PictureCatalog
select * from Transactions




INSERT INTO Transactions (Name, Email, Address1, Address2, City, State, Zip, CCTokenID, ExecutionDate) VALUES('paul smietan', 'paul@smietan.com', 'po box 3127', '', 'blue jay', 'ca', '92317', '1234', GETDATE() )