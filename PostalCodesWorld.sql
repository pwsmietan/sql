/*
   Saturday, July 10, 202112:15:45
   User: sa
   Server: dev.conceivetech.com,60005
   Database: Common
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_PostalCodesWorld
	(
	PCID int NOT NULL IDENTITY (1, 1),
	CountryCode text NULL,
	PostalCode text NULL,
	PlaceName text NULL,
	AdminName1 text NULL,
	AdminCode1 text NULL,
	AdminName2 text NULL,
	AdminCode2 text NULL,
	AdminName3 text NULL,
	AdminCode3 text NULL,
	Lattitude text NULL,
	Longitude text NULL,
	Accuracy text NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_PostalCodesWorld SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_PostalCodesWorld OFF
GO
IF EXISTS(SELECT * FROM dbo.PostalCodesWorld)
	 EXEC('INSERT INTO dbo.Tmp_PostalCodesWorld (CountryCode, PostalCode, PlaceName, AdminName1, AdminCode1, AdminName2, AdminCode2, AdminName3, AdminCode3, Lattitude, Longitude, Accuracy)
		SELECT CountryCode, PostalCode, PlaceName, AdminName1, AdminCode1, AdminName2, AdminCode2, AdminName3, AdminCode3, Lattitude, Longitude, Accuracy FROM dbo.PostalCodesWorld WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.PostalCodesWorld
GO
EXECUTE sp_rename N'dbo.Tmp_PostalCodesWorld', N'PostalCodesWorld', 'OBJECT' 
GO
ALTER TABLE dbo.PostalCodesWorld ADD CONSTRAINT
	PK_PostalCodesWorld PRIMARY KEY CLUSTERED 
	(
	PCID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.PostalCodesWorld', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.PostalCodesWorld', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.PostalCodesWorld', 'Object', 'CONTROL') as Contr_Per 