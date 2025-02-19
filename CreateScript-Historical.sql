USE [repgen]
GO

/****** Object:  Table [dbo].[Historical]    Script Date: 11/15/2013 1:36:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Historical](
	[id] [int] NOT NULL,
	[Group] [nvarchar](255) NULL,
	[Incident] [nvarchar](255) NULL,
	[FY2009] [int] NULL,
	[FY2010] [int] NULL,
	[FY2011] [int] NULL,
	[FY2012] [int] NULL,
	[FY2013] [int] NULL,
	[Note] [nvarchar](255) NULL
) ON [PRIMARY]

GO

