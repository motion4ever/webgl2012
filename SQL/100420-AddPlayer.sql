use [rpgmaster]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CreateNewAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CreateNewAccount]
GO

CREATE PROCEDURE dbo.CreateNewAccount
   @Name NVARCHAR(25),
   @ImgSrc NVARCHAR(MAX),
   @PlayerTypeID INT,
   @ClassID INT,
   @RaceID INT,
   @GenderID INT,
   @AlignmentID INT,
   @Level INT,
   @Age INT,
   @History NVARCHAR(1024),
   @Height NVARCHAR(64),
   @Weight NVARCHAR(64),
   @Experience INT,
   @Money NVARCHAR(64),
   @MaxHitPoints INT,
   @InsertedPlayer INT
AS
BEGIN

INSERT INTO Player (Name, ImgSrc, PlayerTypeID, ClassID, RaceID, GenderID, AlignmentID, Level, Age, History, Height, Weight, Experience, Money, MaxHitPoints)
OUTPUT Inserted.PlayerID
VALUES (@Name, @ImgSrc, @PlayerTypeID, @ClassID, @RaceID, @GenderID, @AlignmentID, @Level, @Age, @History, @Height, @Weight, @Experience, @Money, @MaxHitPoints)


END