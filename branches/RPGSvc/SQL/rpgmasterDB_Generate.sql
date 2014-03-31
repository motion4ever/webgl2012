USE [rpgmaster]
GO
/****** Object:  StoredProcedure [dbo].[GetPlayerByPlayerID]    Script Date: 3/31/2014 9:19:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPlayerByPlayerID]
   @PlayerID INT
AS
BEGIN
Select p.playerID, p.Name
From Player P
where p.playerID = @PlayerID

END
GO
/****** Object:  StoredProcedure [dbo].[GetSkillsByPlayerID]    Script Date: 3/31/2014 9:19:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSkillsByPlayerID]
   @PlayerID INT
AS
BEGIN
Select s.SkillID, s.Name, s.Description, ps.Value
From Skill s
inner join PlayerSkill ps on ps.skillID = s.skillID
inner join Player p on p.playerID = ps.PlayerID
where ps.playerID = @PlayerID

END
GO
/****** Object:  StoredProcedure [dbo].[GetStatsByPlayerID]    Script Date: 3/31/2014 9:19:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStatsByPlayerID]
   @PlayerID INT
AS
BEGIN
Select s.StatID, s.Name, s.Description, ps.Value
From Stat s
inner join PlayerStat ps on ps.statID = s.statID
inner join Player p on p.playerID = ps.PlayerID
where ps.playerID = @PlayerID

END
GO
/****** Object:  Table [dbo].[Player]    Script Date: 3/31/2014 9:19:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[PlayerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NULL,
 CONSTRAINT [pk_player_pid] PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlayerSkill]    Script Date: 3/31/2014 9:19:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerSkill](
	[PlayerSkillID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [int] NULL,
	[SkillID] [int] NULL,
	[Value] [decimal](18, 0) NULL,
 CONSTRAINT [pk_playerSkill_psid] PRIMARY KEY CLUSTERED 
(
	[PlayerSkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlayerStat]    Script Date: 3/31/2014 9:19:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerStat](
	[PlayerStatID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [int] NULL,
	[StatID] [int] NULL,
	[Value] [float] NULL,
 CONSTRAINT [pk_playerStat_psid] PRIMARY KEY CLUSTERED 
(
	[PlayerStatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Skill]    Script Date: 3/31/2014 9:19:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skill](
	[SkillID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [pk_skill_sid] PRIMARY KEY CLUSTERED 
(
	[SkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Stat]    Script Date: 3/31/2014 9:19:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stat](
	[StatID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [pk_stat_sid] PRIMARY KEY CLUSTERED 
(
	[StatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[PlayerSkill]  WITH CHECK ADD  CONSTRAINT [fk_productSkill_psid] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO
ALTER TABLE [dbo].[PlayerSkill] CHECK CONSTRAINT [fk_productSkill_psid]
GO
ALTER TABLE [dbo].[PlayerStat]  WITH CHECK ADD  CONSTRAINT [fk_productStat_psid] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO
ALTER TABLE [dbo].[PlayerStat] CHECK CONSTRAINT [fk_productStat_psid]
GO
