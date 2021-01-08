CREATE TABLE [dbo].[Requests]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [Package] NVARCHAR(50) NULL, 
    [Environment] NVARCHAR(50) NULL, 
    [DateComplete] DATETIME NULL
)
