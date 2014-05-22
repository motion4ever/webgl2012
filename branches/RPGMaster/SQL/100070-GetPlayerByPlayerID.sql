IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPlayerByPlayerID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetPlayerByPlayerID]
GO

CREATE PROCEDURE dbo.GetPlayerByPlayerID
   @PlayerID INT
AS
BEGIN
Select p.playerID, p.Name
From Player P
where p.playerID = @PlayerID

END