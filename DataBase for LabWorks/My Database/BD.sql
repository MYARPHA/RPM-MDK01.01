USE [ispp3511]
GO
/****** Object:  User [user1]    Script Date: 05.11.2024 14:18:26 ******/
CREATE USER [user1] FOR LOGIN [login1] WITH DEFAULT_SCHEMA=[user1]
GO
/****** Object:  User [user2]    Script Date: 05.11.2024 14:18:26 ******/
CREATE USER [user2] FOR LOGIN [login2] WITH DEFAULT_SCHEMA=[user2]
GO
/****** Object:  User [user3]    Script Date: 05.11.2024 14:18:26 ******/
CREATE USER [user3] FOR LOGIN [login3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [user4]    Script Date: 05.11.2024 14:18:26 ******/
CREATE USER [user4] FOR LOGIN [login4] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [user2]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [user2]
GO
/****** Object:  Schema [user1]    Script Date: 05.11.2024 14:18:26 ******/
CREATE SCHEMA [user1]
GO
/****** Object:  Schema [user2]    Script Date: 05.11.2024 14:18:26 ******/
CREATE SCHEMA [user2]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAvgPrice]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- средняя цена игры по категории
CREATE FUNCTION [dbo].[GetAvgPrice]
(
	@idCategory INT
)
RETURNS DECIMAL(16,2)
AS
BEGIN
	DECLARE @avgPrice DECIMAL(16,2);

	SET @avgPrice = (SELECT AVG(Price)
						FROM Game
						WHERE @idCategory = CategoryId);

	RETURN @avgPrice;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetSum]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-- 1
SELECT имяФункции(параметры); -- SELECT GetDate();

-- 2
SET имяПеременной = имяФункции(параметры);

-- 3
SELECT имяФункции(имяСтолбца)
FROM ...;

SELECT Name, Price, ROUND(Price, -2)
FROM Game;

SELECT...
FROM имяФункции(параметры);
*/
-- сумма двух чисел
CREATE FUNCTION [dbo].[GetSum]
(
	@a INT,
	@b INT = 1 -- значение по умолчанию
)
RETURNS INT
AS
BEGIN
	RETURN @a+@b;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetTicketPrice]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetTicketPrice]
(
	@sessionId INT,
	@visitorId INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @ticketCheck DECIMAL(10, 2)

SELECT @ticketCheck = Price
FROM Session
WHERE SessionId = @sessionId

RETURN @ticketCheck
END


GO
/****** Object:  Table [dbo].[Film]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Film](
	[FilmId] [int] IDENTITY(1,1) NOT NULL,
	[FilmTitle] [nvarchar](100) NOT NULL,
	[FilmSession] [smallint] NOT NULL,
	[Date] [smallint] NOT NULL,
	[Description] [nvarchar](500) NULL,
	[FilmPoster] [varchar](max) NULL,
	[AgeRating] [varchar](10) NULL,
	[RentalBeginning] [date] NULL,
	[RentalEnd] [date] NULL,
	[Genre] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Film] PRIMARY KEY CLUSTERED 
(
	[FilmId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hall]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hall](
	[HallId] [tinyint] IDENTITY(1,1) NOT NULL,
	[RowPlaceAmount] [tinyint] NOT NULL,
	[RowsAmount] [tinyint] NOT NULL,
	[CinemaName] [nvarchar](50) NOT NULL,
	[HallNumber] [tinyint] NOT NULL,
	[IsVIP] [bit] NOT NULL,
 CONSTRAINT [PK_Hall] PRIMARY KEY CLUSTERED 
(
	[HallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Session]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Session](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[Price] [decimal](4, 0) NOT NULL,
	[DateTime] [datetime2](7) NOT NULL,
	[Is3D] [bit] NOT NULL,
	[FilmId] [int] NOT NULL,
	[HallId] [tinyint] NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_2]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_2]
AS
SELECT        CAST(dbo.Hall.RowPlaceAmount AS int) AS Expr1
FROM            dbo.Film INNER JOIN
                         dbo.Session ON dbo.Film.FilmId = dbo.Session.FilmId INNER JOIN
                         dbo.Hall ON dbo.Session.HallId = dbo.Hall.HallId
GO
/****** Object:  Table [dbo].[Category]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Game]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Game](
	[GameId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Price] [decimal](16, 2) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[GameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT UPDATE ON [dbo].[Game] ([Name]) TO [guest] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Game] ([Price]) TO [guest] AS [dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[GetGamesByCategory]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- список игр по категории
CREATE FUNCTION [dbo].[GetGamesByCategory]
(
	@name NVARCHAR(100)
)
RETURNS TABLE 
AS
	RETURN 
	(
		SELECT Game.*
		FROM Game JOIN Category ON Game.CategoryId=Category.CategoryId
		WHERE Category.Name = @name
	)

GO
/****** Object:  View [dbo].[games1000]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[games1000]
WITH  VIEW_METADATA
AS
SELECT        GameId, CategoryId, Name, Price, Description
FROM            dbo.Game
WHERE        (Price < 1000)
WITH CHECK OPTION
GO
/****** Object:  View [dbo].[View_1]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        dbo.Game.Price, dbo.Game.Name AS Category, dbo.Game.GameId, dbo.Category.Name
FROM            dbo.Category INNER JOIN
                         dbo.Game ON dbo.Category.CategoryId = dbo.Game.CategoryId
WHERE        (dbo.Category.Name = N'RPG')
GO
/****** Object:  Table [dbo].[ClientUser]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientUser](
	[UserId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__ClientUs__1788CC4C57693DE4] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagerUser]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerUser](
	[UserId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__Managern__1788CC4CCA9C90E6] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminUser]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminUser](
	[UserId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__AdminUse__1788CC4CB227E0AC] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[UsersView]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UsersView]
AS
SELECT *
FROM AdminUser
UNION ALL
SELECT *
FROM ClientUser
UNION ALL
SELECT *
FROM ManagerUser

GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category2]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category2](
	[Id] [float] NULL,
	[Name] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeletedCategory]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeletedCategory](
	[CategoryId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DeletedDate] [datetime2](7) NOT NULL,
	[Login] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeletedVisitors]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeletedVisitors](
	[VisitorId] [int] NOT NULL,
	[PhoneNumber] [char](10) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[BirthDay] [datetime2](7) NULL,
	[Email] [varchar](150) NULL,
	[ChangingDate] [datetime2](7) NOT NULL,
	[DeletedOriginalLogin] [nvarchar](100) NULL,
 CONSTRAINT [PK_DeletedVisitors] PRIMARY KEY CLUSTERED 
(
	[VisitorId] ASC,
	[ChangingDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Game2]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Game2](
	[GameId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[IsDeleted] [bit] NULL,
	[TotalKeys] [int] NULL,
 CONSTRAINT [PK_Game2] PRIMARY KEY CLUSTERED 
(
	[GameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GamePrice]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GamePrice](
	[GameId] [int] NOT NULL,
	[Price] [decimal](16, 2) NOT NULL,
	[ChangingDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_GamePrice] PRIMARY KEY CLUSTERED 
(
	[GameId] ASC,
	[ChangingDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[Genre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Genre_1] PRIMARY KEY CLUSTERED 
(
	[Genre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HashUser]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HashUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](32) NOT NULL,
	[HashedPassword] [nvarchar](32) NOT NULL,
	[HashedPasswordBinary] [binary](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import1_OrderList]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import1_OrderList](
	[IdOrder] [float] NULL,
	[IdPizza] [float] NULL,
	[Quantity] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import1_Orders]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import1_Orders](
	[IdOrder] [float] NULL,
	[DateOfOrder] [datetime] NULL,
	[IdPromocode] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import1_Pizza]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import1_Pizza](
	[IdPizza] [float] NULL,
	[Name] [nvarchar](255) NULL,
	[Ingredients] [nvarchar](255) NULL,
	[Weight] [float] NULL,
	[Price] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import1_Promocodes]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import1_Promocodes](
	[IdPromocode] [float] NULL,
	[Name] [nvarchar](255) NULL,
	[Percent] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import1_User]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import1_User](
	[id] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[login] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[ip] [varchar](50) NULL,
	[lastenter] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import1_users]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import1_users](
	[id] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[login] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[ip] [varchar](50) NULL,
	[lastenter] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import2_PizzaIngredients]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import2_PizzaIngredients](
	[IdPizza] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Ingredients] [nvarchar](255) NULL,
	[Mass] [float] NULL,
	[Price] [float] NULL,
 CONSTRAINT [PK_Import2_PizzaIngredients] PRIMARY KEY CLUSTERED 
(
	[IdPizza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[SaleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [int] NOT NULL,
	[SaledKeys] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SaleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Age] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[Place] [tinyint] NOT NULL,
	[Row] [tinyint] NOT NULL,
	[SessionId] [int] NOT NULL,
	[VisitorId] [int] NOT NULL,
 CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Ticket] TO [user3] AS [dbo]
GO
GRANT INSERT ON [dbo].[Ticket] TO [user3] AS [dbo]
GO
/****** Object:  Table [dbo].[Visitor]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visitor](
	[VisitorId] [int] IDENTITY(1,1) NOT NULL,
	[PhoneNumber] [char](20) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[BirthDay] [datetime2](7) NULL,
	[Email] [varchar](150) NULL,
 CONSTRAINT [PK_Visitor] PRIMARY KEY CLUSTERED 
(
	[VisitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisitorInfo]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisitorInfo](
	[VisitorId] [int] NOT NULL,
	[Email] [varchar](150) NULL,
	[ChangingDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_VisitorInfo] PRIMARY KEY CLUSTERED 
(
	[VisitorId] ASC,
	[ChangingDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241101085134_InitialCreate', N'8.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241101085624_CreateGroup', N'8.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241101085724_CreateGroupFK', N'8.0.10')
GO
INSERT [dbo].[AdminUser] ([UserId], [Name], [Role]) VALUES (1, N'⍵⫆랽豢鵚辭�엘䃀㕥㇥ꎨ譴깬~', N'Админ')
INSERT [dbo].[AdminUser] ([UserId], [Name], [Role]) VALUES (2, N'Смиронов', N'Админ')
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (1, N'Симулятор')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (2, N'Шутер')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (3, N'РПГ')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (6, N'аркада')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (7, N'рогалик')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (8, N'test1')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (9, N'test1')
INSERT [dbo].[Category] ([CategoryId], [Name]) VALUES (10, N'test1')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[Category2] ([Id], [Name]) VALUES (1, N'Симулятор')
INSERT [dbo].[Category2] ([Id], [Name]) VALUES (2, N'Шутер')
INSERT [dbo].[Category2] ([Id], [Name]) VALUES (3, N'RPG')
INSERT [dbo].[Category2] ([Id], [Name]) VALUES (5, NULL)
GO
INSERT [dbo].[ClientUser] ([UserId], [Name], [Role]) VALUES (1, N'Иванов', N'Клиент')
INSERT [dbo].[ClientUser] ([UserId], [Name], [Role]) VALUES (2, N'Петров', N'Клиент')
GO
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (4, N'arcada', CAST(N'2024-09-30T12:39:49.0433333' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (5, N'', CAST(N'2024-10-28T12:00:57.2000000' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (11, N'test1', CAST(N'2024-11-05T14:10:32.9133333' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (12, N'test1', CAST(N'2024-11-05T14:10:32.9133333' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (13, N'test1', CAST(N'2024-11-05T14:10:32.9133333' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (14, N'test1', CAST(N'2024-11-05T14:10:32.9133333' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (15, N'test1', CAST(N'2024-11-05T14:10:32.9133333' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (16, N'test1', CAST(N'2024-11-05T14:10:32.9133333' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (22, N'qwerty6', CAST(N'2024-11-05T14:10:32.9133333' AS DateTime2), N'ispp3511')
INSERT [dbo].[DeletedCategory] ([CategoryId], [Name], [DeletedDate], [Login]) VALUES (23, N'qwerty6', CAST(N'2024-11-05T14:10:32.9133333' AS DateTime2), N'ispp3511')
GO
INSERT [dbo].[DeletedVisitors] ([VisitorId], [PhoneNumber], [Name], [BirthDay], [Email], [ChangingDate], [DeletedOriginalLogin]) VALUES (4, N'8902191424', N'fkbyf', CAST(N'2005-09-12T00:00:00.0000000' AS DateTime2), N'afadeevaa0011@gmail.com', CAST(N'2024-10-01T10:10:59.7833333' AS DateTime2), N'ispp3511')
GO
SET IDENTITY_INSERT [dbo].[Film] ON 

INSERT [dbo].[Film] ([FilmId], [FilmTitle], [FilmSession], [Date], [Description], [FilmPoster], [AgeRating], [RentalBeginning], [RentalEnd], [Genre], [IsDeleted]) VALUES (1, N'Собиратель душ ', 90, 2024, N'1990-е годы, штат Орегон. Агент ФБР Ли Харкер, обладающая чем-то вроде дара ясновидения, начинает заниматься глухим делом без единой зацепки.', N'1', N'18', CAST(N'2024-07-25' AS Date), CAST(N'2024-09-25' AS Date), N'Триллер', 0)
INSERT [dbo].[Film] ([FilmId], [FilmTitle], [FilmSession], [Date], [Description], [FilmPoster], [AgeRating], [RentalBeginning], [RentalEnd], [Genre], [IsDeleted]) VALUES (2, N'Криминальное чтиво', 90, 1994, N'Двое бандитов Винсент Вега и Джулс Винфилд ведут философские беседы в перерывах между разборками и решением проблем с должниками криминального босса Марселласа Уоллеса.', N'1', N'18', CAST(N'2024-07-26' AS Date), CAST(N'2024-10-15' AS Date), N'Детектив', 0)
INSERT [dbo].[Film] ([FilmId], [FilmTitle], [FilmSession], [Date], [Description], [FilmPoster], [AgeRating], [RentalBeginning], [RentalEnd], [Genre], [IsDeleted]) VALUES (3, N'Убить Билла', 247, 2004, N'В беременную наёмную убийцу по кличке Чёрная Мамба во время бракосочетания стреляет человек по имени Билл. Но голова у женщины оказалась крепкой — пролежав четыре года в коме, бывшая невеста приходит в себя.', N'1', N'18', CAST(N'2024-07-27' AS Date), CAST(N'2024-11-16' AS Date), N'Боевик', 0)
INSERT [dbo].[Film] ([FilmId], [FilmTitle], [FilmSession], [Date], [Description], [FilmPoster], [AgeRating], [RentalBeginning], [RentalEnd], [Genre], [IsDeleted]) VALUES (4, N'Бойцовский клуб', 139, 1999, N'Сотрудник страховой компании страдает хронической бессонницей и отчаянно пытается вырваться из мучительно скучной жизни. Однажды в очередной командировке он встречает некоего Тайлера Дёрдена — харизматического торговца мылом с извращенной философией', N'1', N'18', CAST(N'2024-07-30' AS Date), CAST(N'2024-12-31' AS Date), N'Боевик', 1)
INSERT [dbo].[Film] ([FilmId], [FilmTitle], [FilmSession], [Date], [Description], [FilmPoster], [AgeRating], [RentalBeginning], [RentalEnd], [Genre], [IsDeleted]) VALUES (5, N'Леон', 133, 1994, N'Профессиональный убийца Леон неожиданно для себя самого решает помочь 12-летней соседке Матильде, семью которой убили коррумпированные полицейские. ', N'1', N'18', CAST(N'2024-02-12' AS Date), CAST(N'2024-06-15' AS Date), N'Драма', 0)
INSERT [dbo].[Film] ([FilmId], [FilmTitle], [FilmSession], [Date], [Description], [FilmPoster], [AgeRating], [RentalBeginning], [RentalEnd], [Genre], [IsDeleted]) VALUES (6, N'Мальчик в полосатой пижаме', 94, 2008, N'История, происходящая во время Второй мировой войны и показанная сквозь глаза невинного и ничего не подозревающего о происходящих событиях Бруно, восьмилетнего сына коменданта концентрационного лагеря.', N'1', N'12', CAST(N'2024-05-24' AS Date), CAST(N'2024-10-06' AS Date), N'Драма', 1)
INSERT [dbo].[Film] ([FilmId], [FilmTitle], [FilmSession], [Date], [Description], [FilmPoster], [AgeRating], [RentalBeginning], [RentalEnd], [Genre], [IsDeleted]) VALUES (7, N'Страх и ненависть в Лас-Вегасе', 118, 1998, N'Два приятеля отправляются в Лас-Вегас. Спортивный обозреватель Рауль Дюк едет осветить знаменитую гонку «Минт 400». Его спутника зовут Доктор Гонзо, и он адвокат. Обзор «Минт 400» из-за непогоды и отсутствия интереса у рецензента оборачивается полным провалом, поэтому Дюк и Гонзо отправляются в казино.', N'1', N'18', CAST(N'2024-06-24' AS Date), CAST(N'2024-08-10' AS Date), N'Комедия', 0)
INSERT [dbo].[Film] ([FilmId], [FilmTitle], [FilmSession], [Date], [Description], [FilmPoster], [AgeRating], [RentalBeginning], [RentalEnd], [Genre], [IsDeleted]) VALUES (8, N'Борат', 84, 2006, N'Сюжет: телеведущий из Казахстана Борат отправляется в США, чтобы сделать репортаж об этой «величайшей в мире стране». Однако по прибытии оказывается, что главная цель его визита — поиски Памелы Андерсон с целью жениться на ней, а вовсе не съёмки документального фильма.', N'1', N'18', CAST(N'2024-07-30' AS Date), CAST(N'2024-10-11' AS Date), NULL, 0)
SET IDENTITY_INSERT [dbo].[Film] OFF
GO
SET IDENTITY_INSERT [dbo].[Game] ON 

INSERT [dbo].[Game] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted]) VALUES (3, 1, N'SimCity', CAST(150.00 AS Decimal(16, 2)), N'Градостроительный симулятор снова с вами! Создайте город своей мечты', 0)
INSERT [dbo].[Game] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted]) VALUES (4, 2, N'TITANFALL', CAST(2301.00 AS Decimal(16, 2)), N'Эта игра перенесет вас во вселенную, где малое противопоставляется большому, природа – индустрии, а человек – машине', 0)
INSERT [dbo].[Game] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted]) VALUES (5, 2, N'Battlefield 4', CAST(901.40 AS Decimal(16, 2)), N'Battlefield 4 – это определяющий для жанра, полный экшена боевик, известный своей разрушаемостью, равных которой нет', 0)
INSERT [dbo].[Game] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted]) VALUES (6, 1, N'The Sims 4', CAST(1233.00 AS Decimal(16, 2)), N'В реальности каждому человеку дано прожить лишь одну жизнь. Но с помощью The Sims 4 это ограничение можно снять! 
		Вам решать — где, как и с кем жить, чем заниматься, чем украшать и обустраивать свой дом', 0)
INSERT [dbo].[Game] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted]) VALUES (7, 3, N'Dark Souls 2', CAST(213132.00 AS Decimal(16, 2)), N'Продолжение знаменитого ролевого экшена вновь заставит игроков пройти через сложнейшие испытания. Dark Souls II предложит 
		нового героя, новую историю и новый мир. Лишь одно неизменно – выжить в мрачной вселенной Dark Souls очень непросто.', 0)
INSERT [dbo].[Game] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted]) VALUES (8, 3, N'The Elder Scrolls V: Skyrim', CAST(1401.00 AS Decimal(16, 2)), N'После убийства короля Скайрима империя оказалась на грани катастрофы. Вокруг претендентов на престол сплотились новые союзы, 
		и разгорелся конфликт. К тому же, как предсказывали древние свитки, в мир вернулись жестокие и беспощадные драконы. Теперь будущее Скайрима и всей 
		империи зависит от драконорожденного — человека, в жилах которого течет кровь легендарных существ.', 0)
SET IDENTITY_INSERT [dbo].[Game] OFF
GO
INSERT [dbo].[Game2] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted], [TotalKeys]) VALUES (3, 1, N'SimCity', CAST(1501.00 AS Decimal(18, 2)), N'Градостроительный симулятор снова с вами! Создайте город своей мечты', 0, NULL)
INSERT [dbo].[Game2] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted], [TotalKeys]) VALUES (4, 2, N'TITANFALL', CAST(2301.00 AS Decimal(18, 2)), N'Эта игра перенесет вас во вселенную, где малое противопоставляется большому, природа – индустрии, а человек – машине', 0, NULL)
INSERT [dbo].[Game2] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted], [TotalKeys]) VALUES (5, 2, N'Battlefield 4', CAST(901.40 AS Decimal(18, 2)), N'Battlefield 4 – это определяющий для жанра, полный экшена боевик, известный своей разрушаемостью, равных которой нет', 0, NULL)
INSERT [dbo].[Game2] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted], [TotalKeys]) VALUES (6, 1, N'The Sims 4', CAST(1233.00 AS Decimal(18, 2)), N'В реальности каждому человеку дано прожить лишь одну жизнь. Но с помощью The Sims 4 это ограничение можно снять! 
		Вам решать — где, как и с кем жить, чем заниматься, чем украшать и обустраивать свой дом', 0, NULL)
INSERT [dbo].[Game2] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted], [TotalKeys]) VALUES (7, 3, N'Dark Souls 2', CAST(213132.00 AS Decimal(18, 2)), N'Продолжение знаменитого ролевого экшена вновь заставит игроков пройти через сложнейшие испытания. Dark Souls II предложит 
		нового героя, новую историю и новый мир. Лишь одно неизменно – выжить в мрачной вселенной Dark Souls очень непросто.', 0, NULL)
INSERT [dbo].[Game2] ([GameId], [CategoryId], [Name], [Price], [Description], [IsDeleted], [TotalKeys]) VALUES (8, 3, N'The Elder Scrolls V: Skyrim', CAST(1401.00 AS Decimal(18, 2)), N'После убийства короля Скайрима империя оказалась на грани катастрофы. Вокруг претендентов на престол сплотились новые союзы, 
		и разгорелся конфликт. К тому же, как предсказывали древние свитки, в мир вернулись жестокие и беспощадные драконы. Теперь будущее Скайрима и всей 
		империи зависит от драконорожденного — человека, в жилах которого течет кровь легендарных существ.', 0, NULL)
GO
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(1501.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:15:58.2100000' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:20:48.6133333' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:20:48.6233333' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:21:31.1700000' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:21:31.1800000' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:23:15.1000000' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:23:15.1100000' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:23:42.8500000' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:23:42.8600000' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:23:58.1133333' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:23:58.1233333' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:24:28.1200000' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (3, CAST(150.00 AS Decimal(16, 2)), CAST(N'2024-10-25T14:24:28.1266667' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (6, CAST(17.00 AS Decimal(16, 2)), CAST(N'2024-09-30T12:29:42.7333333' AS DateTime2))
INSERT [dbo].[GamePrice] ([GameId], [Price], [ChangingDate]) VALUES (7, CAST(951.00 AS Decimal(16, 2)), CAST(N'2024-09-30T12:29:44.9133333' AS DateTime2))
GO
INSERT [dbo].[Genre] ([Genre]) VALUES (N'Боевик')
INSERT [dbo].[Genre] ([Genre]) VALUES (N'Детектив')
INSERT [dbo].[Genre] ([Genre]) VALUES (N'Драма')
INSERT [dbo].[Genre] ([Genre]) VALUES (N'Комедия')
INSERT [dbo].[Genre] ([Genre]) VALUES (N'Мелодрама')
INSERT [dbo].[Genre] ([Genre]) VALUES (N'Роман')
INSERT [dbo].[Genre] ([Genre]) VALUES (N'Трагикомедия')
INSERT [dbo].[Genre] ([Genre]) VALUES (N'Триллер')
GO
SET IDENTITY_INSERT [dbo].[Hall] ON 

INSERT [dbo].[Hall] ([HallId], [RowPlaceAmount], [RowsAmount], [CinemaName], [HallNumber], [IsVIP]) VALUES (1, 40, 4, N'Мираж', 3, 0)
INSERT [dbo].[Hall] ([HallId], [RowPlaceAmount], [RowsAmount], [CinemaName], [HallNumber], [IsVIP]) VALUES (3, 60, 5, N'Русь', 1, 1)
INSERT [dbo].[Hall] ([HallId], [RowPlaceAmount], [RowsAmount], [CinemaName], [HallNumber], [IsVIP]) VALUES (4, 10, 10, N'Титан-Арена', 10, 0)
SET IDENTITY_INSERT [dbo].[Hall] OFF
GO
SET IDENTITY_INSERT [dbo].[HashUser] ON 

INSERT [dbo].[HashUser] ([UserId], [Name], [Password], [HashedPassword], [HashedPasswordBinary]) VALUES (1, N'admin', N'123', N'斦妤䈠鴯繁杈�롏䪠㼟῿纠躙ꋷ', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3)
INSERT [dbo].[HashUser] ([UserId], [Name], [Password], [HashedPassword], [HashedPasswordBinary]) VALUES (2, N'admin', N'123', N'斦妤䈠鴯繁杈�롏䪠㼟῿纠躙ꋷ', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3)
INSERT [dbo].[HashUser] ([UserId], [Name], [Password], [HashedPassword], [HashedPasswordBinary]) VALUES (3, N'admin', N'123', N'斦妤䈠鴯繁杈�롏䪠㼟῿纠躙ꋷ', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3)
INSERT [dbo].[HashUser] ([UserId], [Name], [Password], [HashedPassword], [HashedPasswordBinary]) VALUES (4, N'admin', N'123', N'斦妤䈠鴯繁杈�롏䪠㼟῿纠躙ꋷ', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3)
INSERT [dbo].[HashUser] ([UserId], [Name], [Password], [HashedPassword], [HashedPasswordBinary]) VALUES (5, N'admin', N'123', N'斦妤䈠鴯繁杈�롏䪠㼟῿纠躙ꋷ', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3)
SET IDENTITY_INSERT [dbo].[HashUser] OFF
GO
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (1, 3, 5)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (1, 4, 1)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (1, 6, 2)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (2, 8, 18)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (3, 9, 24)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (3, 4, 1)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (3, 7, 12)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (4, 8, 16)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (4, 5, 13)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (4, 1, 2)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (5, 9, 10)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (5, 5, 18)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (5, 7, 1)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (5, 10, 2)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (6, 2, 21)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (6, 1, 1)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (7, 3, 25)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (8, 1, 1)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (9, 3, 27)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (10, 5, 21)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (11, 5, 24)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (12, 2, 17)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (13, 9, 3)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (14, 7, 21)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (15, 7, 17)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (16, 5, 28)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (17, 6, 2)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (18, 4, 6)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (19, 8, 18)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (20, 9, 12)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (21, 1, 13)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (22, 1, 25)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (23, 1, 22)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (24, 6, 25)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (25, 5, 15)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (26, 4, 23)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (27, 3, 10)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (28, 1, 24)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (29, 3, 18)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (30, 5, 2)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (31, 9, 7)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (32, 9, 18)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (33, 1, 20)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (34, 5, 18)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (35, 3, 13)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (36, 10, 20)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (37, 2, 28)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (38, 10, 18)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (39, 1, 24)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (40, 8, 26)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (41, 4, 25)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (42, 7, 23)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (43, 6, 9)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (44, 3, 29)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (45, 2, 14)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (46, 2, 11)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (47, 5, 25)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (48, 9, 11)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (49, 8, 1)
INSERT [dbo].[Import1_OrderList] ([IdOrder], [IdPizza], [Quantity]) VALUES (50, 1, 28)
GO
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (1, CAST(N'2020-03-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (2, CAST(N'2018-04-11T16:38:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (3, CAST(N'2019-03-24T10:34:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (4, CAST(N'2018-04-10T09:10:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (5, CAST(N'2018-04-03T08:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (6, CAST(N'2019-03-29T13:50:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (7, CAST(N'2018-04-04T11:23:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (8, CAST(N'2019-02-09T16:24:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (9, CAST(N'2019-03-28T10:27:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (10, CAST(N'2019-02-06T13:22:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (11, CAST(N'2019-03-29T08:21:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (12, CAST(N'2019-04-02T12:05:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (13, CAST(N'2019-03-24T11:30:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (14, CAST(N'2019-03-30T14:39:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (15, CAST(N'2019-03-26T08:56:00.000' AS DateTime), 29)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (16, CAST(N'2019-01-19T14:18:00.000' AS DateTime), 40)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (17, CAST(N'2019-04-01T15:21:00.000' AS DateTime), 1)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (18, CAST(N'2019-03-27T12:33:00.000' AS DateTime), 16)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (19, CAST(N'2019-04-02T14:11:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (20, CAST(N'2019-03-25T09:03:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (21, CAST(N'2018-06-06T00:00:00.000' AS DateTime), 48)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (22, CAST(N'2018-06-23T00:00:00.000' AS DateTime), 50)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (23, CAST(N'2018-10-25T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (24, CAST(N'2018-08-08T00:00:00.000' AS DateTime), 34)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (25, CAST(N'2018-11-15T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (26, CAST(N'2018-09-27T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (27, CAST(N'2019-02-16T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (28, CAST(N'2019-02-05T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (29, CAST(N'2019-02-08T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (30, CAST(N'2018-03-24T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (31, CAST(N'2018-11-13T00:00:00.000' AS DateTime), 43)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (32, CAST(N'2019-02-27T00:00:00.000' AS DateTime), 30)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (33, CAST(N'2018-06-30T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (34, CAST(N'2018-06-15T00:00:00.000' AS DateTime), 17)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (35, CAST(N'2018-10-16T00:00:00.000' AS DateTime), 40)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (36, CAST(N'2018-09-12T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (37, CAST(N'2018-04-19T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (38, CAST(N'2018-11-07T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (39, CAST(N'2018-06-16T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (40, CAST(N'2018-06-29T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (41, CAST(N'2019-01-29T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (42, CAST(N'2019-03-16T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (43, CAST(N'2019-01-05T00:00:00.000' AS DateTime), 49)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (44, CAST(N'2018-08-02T00:00:00.000' AS DateTime), 32)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (45, CAST(N'2018-05-23T00:00:00.000' AS DateTime), 47)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (46, CAST(N'2018-10-11T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (47, CAST(N'2019-03-19T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (48, CAST(N'2019-01-24T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (49, CAST(N'2018-05-25T00:00:00.000' AS DateTime), 35)
INSERT [dbo].[Import1_Orders] ([IdOrder], [DateOfOrder], [IdPromocode]) VALUES (50, CAST(N'2018-12-29T00:00:00.000' AS DateTime), 44)
GO
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (1, N'Микс', N'Соус томатный, сыр моцарелла, ветчина, салями, сосиски баварские с зеленью, помидоры, перец болгарский', 520, 580)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (2, N'Сырная', N'Соус ранч, сыр моцарелла, сыр гауда, сыр пармезан, салат руккола', 460, 550)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (3, N'Грибнaя', N'Соус грибной, сыр, шампиньоны, опята маринованные, грибы шиитаке, микс салат', 735, 610)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (4, N'Мясная', N'Соус ранч, сыр моцарелла, колбаса п/к, куриное филе, кусочки поджарки из свинины, пепперони, салат руккола', 530, 580)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (5, N'Рыбная', N'Соус фирменный, сыр моцарелла, семга, креветки, лук красный, салат руккола', 510, 750)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (6, N'Маргарита', N'Томатный соус, сыр, помидоры, базиилик', 820, 590)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (7, N'Барбекю', N'Томатный соус, сыр, мясной топинг, сосиски баварские с зеленью, помидоры, перец болгарский, лук красный, соус барбекю', 590, 970)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (8, N'Итальянская', N'Томатный соус, сыр, ветчина, салями, куриная грудка, болгарский перец, шампиньоны, помидоры', 710, 990)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (9, N'С копченостями', N'Томатный соус, сыр, ветчина, бекон, салями, охотничьи колбаски, шампиньоны', 520, 430)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (10, N'Пепперони', N'Томатный соус, сыр, пепперони', 740, 570)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (11, N'Золотая рыбка', N'Фирменный соус, сыр, семга, креветки, красный лучок', 740, 590)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (12, N'Жюльен', N'Соус Цезарь, куриная грудка, сыр моцарелла, сыр пармезан, сливки, шампиньоны, помидоры, микс салат', 500, 620)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (13, N'Баварская', N'Томатный соус, сыр, бастурма, колбаски пепперони, колбаски охотничьи, чеснок, перчик халапеньо', 820, 790)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (14, N'Четыре сыра', N'Томатный соус, сыр моцарелла, сыр пармезан, сыр гауда, сыр с плесенью', 790, 760)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (15, N'Цезарь', N'Соус Цезарь, сыр пармезан, сыр моцарелла, куриная грудка, салат айсберг, помидоры черри', 800, 630)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (16, N'Ветчина и грибы', N'Томатный соус, сыр, много ветчины, шампиньоны, помидоры', 600, 480)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (17, N'Деревенская', N'Фирменный соус, сыр, колбаса п/к, ветчина, шампиньоны, помидоры, маринованные огурчики, перец болгарский, красный лук', 970, 870)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (18, N'Дон Бекон', N'Томатный соус, сыр, много бекона, помидорки черри', 420, 860)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (19, N'Гавайская', N'Томатный соус, сыр, много ветчины, ананасы кубиком', 650, 790)
INSERT [dbo].[Import1_Pizza] ([IdPizza], [Name], [Ingredients], [Weight], [Price]) VALUES (20, N'Студенческая', N'Фирменный соус, майонез, сыр, колбаса студенческая, помидоры', 550, 480)
GO
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (1, N'mart2020', 13)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (2, N'd12345', 5)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (3, N'promo', 10)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (4, N'abcde', 7)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (5, N'PIZZA', 10)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (6, N'NY2020', 20)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (7, N'GoodDay', 3)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (8, N'MegaSale', 15)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (9, N'SuperSale', 6)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (10, N'sale', 1)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (11, N'promo1', 13)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (12, N'promo2', 8)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (13, N'promo3', 12)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (14, N'promo4', 8)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (15, N'promo5', 12)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (16, N'promo6', 13)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (17, N'promo7', 17)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (18, N'promo8', 10)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (19, N'promo9', 17)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (20, N'promo10', 3)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (21, N'promo11', 19)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (22, N'promo12', 19)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (23, N'promo13', 4)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (24, N'promo14', 14)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (25, N'promo15', 18)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (26, N'promo16', 15)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (27, N'promo17', 16)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (28, N'promo18', 1)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (29, N'promo19', 13)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (30, N'promo20', 20)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (31, N'promo21', 1)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (32, N'promo22', 17)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (33, N'promo23', 14)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (34, N'promo24', 8)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (35, N'promo25', 5)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (36, N'promo26', 12)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (37, N'promo27', 13)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (38, N'promo28', 15)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (39, N'promo29', 5)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (40, N'promo30', 11)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (41, N'promo31', 14)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (42, N'promo32', 10)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (43, N'promo33', 1)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (44, N'promo34', 5)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (45, N'promo35', 6)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (46, N'promo36', 15)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (47, N'promo37', 9)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (48, N'promo38', 9)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (49, N'promo39', 10)
INSERT [dbo].[Import1_Promocodes] ([IdPromocode], [Name], [Percent]) VALUES (50, N'promo40', 7)
GO
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'1', N'Clareta Hacking', N'chacking0', N'4tzqHdkqzo4', N'147.231.50.234', N'02.10.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'2', N'Northrop Mably', N'nmably1', N'ukM0e6', N'22.32.15.211', N'20.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'3', N'Fabian Rolf', N'frolf2', N'7QpCwac0yi', N'113.92.142.29', N'19.05.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'4', N'Lauree Raden', N'lraden3', N'5Ydp2mz', N'39.24.146.52', N'22.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'5', N'Barby Follos', N'bfollos4', N'ckmAJPQV', N'87.232.97.3', N'18.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'6', N'Mile Enterle', N'menterle5', N'0PRom6i', N'85.121.209.6', N'07.04.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'7', N'Midge Peaker', N'mpeaker6', N'0Tc5oRc', N'196.39.132.128', N'09.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'8', N'Manon Robichon', N'mrobichon7', N'LEwEjMlmE5X', N'143.159.207.105', N'31.08.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'9', N'Stavro Robken', N'srobken8', N'Cbmj3Yi', N'12.154.73.196', N'22.05.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'10', N'Bryan Tidmas', N'btidmas9', N'dYDHbBQfK', N'24.42.134.21', N'06.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'11', N'Jeannette Fussie', N'jfussiea', N'EGxXuLQ9', N'98.194.112.137', N'21.08.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'12', N'Stephen Antonacci', N'santonaccib', N'YcXAhY3Pja', N'198.146.255.15', N'10.03.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'13', N'Niccolo Bountiff', N'nbountiffc', N'5xfyjS9ZULGA', N'231.78.246.229', N'22.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'14', N'Clemente Benjefield', N'cbenjefieldd', N'tQOsP0ei9TuD', N'88.126.93.246', N'07.09.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'15', N'Orlan Corbyn', N'ocorbyne', N'bG1ZIzwIoU', N'232.175.48.179', N'24.04.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'16', N'Coreen Stickins', N'cstickinsf', N'QRYADbgNj', N'64.30.175.158', N'20.04.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'17', N'Daveta Clarage', N'dclarageg', N'Yp59ZIDnWe', N'139.88.229.111', N'06.09.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'18', N'Javier McCawley', N'jmccawleyh', N'g58zLcmCYON', N'14.199.67.32', N'20.04.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'19', N'Daile Band', N'dbandi', N'yFAaYuVW', N'206.105.148.56', N'12.02.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'20', N'Angil Buttery', N'abutteryj', N'ttOFbWWGtD', N'192.158.7.138', N'21.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'21', N'Kyla Kinman', N'kkinmank', N'qUr6fdWP6L5G', N'134.99.243.113', N'11.08.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'22', N'Selena Skepper', N'sskepperl', N'jHYN0v3', N'52.90.89.126', N'28.04.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'23', N'Alyson Yeoland', N'ayeolandm', N'QQezRBV9', N'239.7.55.187', N'31.05.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'24', N'Claudie Speeding', N'cspeedingn', N'UCLYITfw2Vo', N'127.37.194.127', N'15.11.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'25', N'Alaric Scarisbrick', N'ascarisbricko', N'fzBcv6GbyCp', N'97.227.15.172', N'19.02.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'26', N'Marie Thurby', N'mthurbyp', N'wg0uIskqei', N'94.70.148.135', N'18.09.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'27', N'Cloe Roxbrough', N'croxbroughq', N'67CVVym', N'185.110.201.36', N'01.11.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'28', N'Pegeen McCotter', N'pmccotterr', N'QG5tdzRpGZJ2', N'22.179.187.229', N'22.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'29', N'Iggie Calleja', N'icallejas', N'aeDvZk8o9', N'67.237.123.227', N'19.07.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'30', N'Nelle Brosch', N'nbroscht', N'DmPJt2', N'251.1.59.65', N'17.12.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'31', N'Shae Allsepp', N'sallseppu', N't0ko0854Cpvv', N'88.20.74.85', N'08.09.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'32', N'Eldridge Abbatucci', N'eabbatucciv', N'gUtNdsDu', N'52.44.134.126', N'29.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'33', N'Skip Garnham', N'sgarnhamw', N'eml6RqbK', N'100.17.131.54', N'29.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'34', N'Ric Kitchenside', N'rkitchensidex', N'xaa7miQ7yB', N'29.100.76.146', N'14.12.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'35', N'Urbanus Di Meo', N'udiy', N'dHqu78cU6NOP', N'90.30.202.251', N'25.12.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'36', N'Monty Beidebeke', N'mbeidebekez', N'F5T5spAU9A4O', N'3.32.202.92', N'02.05.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'37', N'Byrann Savins', N'bsavins10', N'l6sYf29NLN', N'123.187.14.103', N'23.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'38', N'Sonnie Riby', N'sriby11', N'Va34LYqFh', N'16.81.16.23', N'17.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'39', N'Sherill Birney', N'sbirney12', N'Ggygo2ePsETs', N'144.76.193.237', N'27.12.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'40', N'Indira Kleanthous', N'ikleanthous13', N'3H0GS7a', N'169.108.108.88', N'29.12.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'41', N'Maison Skerme', N'mskerme14', N'wy1HWA', N'143.177.136.232', N'02.10.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'42', N'Hanan Cahey', N'hcahey15', N'NSXcG9khd', N'18.127.87.158', N'13.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'43', N'Tore Rusling', N'trusling16', N'abol9dYC8e', N'142.216.95.251', N'19.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'44', N'Jeddy De Souza', N'jde17', N'gK6Hsl8Q', N'229.104.255.175', N'17.10.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'45', N'Flossi McLeoid', N'fmcleoid18', N'B9zr0N7cJw', N'90.207.38.179', N'26.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'46', N'Nikoletta Megainey', N'nmegainey19', N'gph7QurFf', N'172.249.218.50', N'22.05.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'47', N'Adan Bliven', N'abliven1a', N'vVxlf94KpeX', N'49.101.94.118', N'17.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'48', N'Mohandis Rossoni', N'mrossoni1b', N'nLXj2lS', N'161.5.132.42', N'16.11.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'49', N'Nappie Redington', N'nredington1c', N'DCbOb1SX', N'174.42.8.3', N'05.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'50', N'Lenka Francie', N'lfrancie1d', N'DoGeHWuAAM', N'182.2.128.34', N'30.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'51', N'Ashley Blowin', N'ablowin1e', N'aQygVtMjN', N'73.212.243.168', N'24.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'52', N'Vale Goroni', N'vgoroni1f', N'bWr0QU', N'93.126.120.134', N'19.08.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'53', N'Suki Grafom', N'sgrafom1g', N'JcNcVDAouYzA', N'9.26.5.107', N'17.12.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'54', N'Justis Gianneschi', N'jgianneschi1h', N'oieX5u3sUfpD', N'139.241.156.87', N'14.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'55', N'Emilie Collett', N'ecollett1i', N'Y0uMyKB0W', N'47.0.240.7', N'10.07.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'56', N'Byrom Terrell', N'bterrell1j', N'hswseW', N'157.21.33.53', N'25.02.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'57', N'Daphne Bifield', N'dbifield1k', N'oYAQ4URihIA', N'24.185.229.169', N'29.07.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'58', N'Blanca Staig', N'bstaig1l', N'MygqEtjMtUbC', N'171.78.28.229', N'19.02.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'59', N'Adriaens Kennsley', N'akennsley1m', N'CTUdBfJsy6qF', N'208.81.128.179', N'15.07.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'60', N'Emlyn Bartak', N'ebartak1n', N'y3t4H1', N'130.247.20.138', N'20.12.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'61', N'Victoria Willshire', N'vwillshire1o', N'VFSLc2t', N'243.230.165.161', N'09.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'62', N'Egon Savin', N'esavin1p', N'axnJY9s', N'40.140.160.210', N'31.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'63', N'Phillie Elsom', N'pelsom1q', N'OXzMECG', N'253.7.8.82', N'01.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'64', N'Adan Semaine', N'asemaine1r', N'MdJRkHor5SP', N'76.252.15.218', N'10.05.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'65', N'Constantino Northrop', N'cnorthrop1s', N'UIwCvTA7MRS0', N'119.130.24.85', N'10.12.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'66', N'Rodie Easson', N'reasson1t', N'3J0jgg9RWlXs', N'212.248.119.232', N'14.08.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'67', N'Alida Boleyn', N'aboleyn1u', N'3q2mQdDRmtr', N'181.14.56.184', N'26.05.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'68', N'Hill Scholfield', N'hscholfield1v', N'1Pbs3K6qXYB', N'15.7.205.224', N'23.02.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'69', N'Cordell Cowpe', N'ccowpe1w', N'VHr417Ft0', N'237.236.173.63', N'17.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'70', N'Alexandro Eldon', N'aeldon1x', N'rrywOQRmFKyh', N'4.174.11.210', N'12.04.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'71', N'Kayle Collin', N'kcollin1y', N'Q0ZV21vew0', N'52.19.142.168', N'30.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'72', N'Inesita Larkins', N'ilarkins1z', N'DEFNpHtU', N'3.26.42.188', N'12.05.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'73', N'Waylin Lound', N'wlound20', N'a2G4Ihh2o', N'31.243.68.215', N'26.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'74', N'Mechelle Gillogley', N'mgillogley21', N'EjUHfCUFqF', N'79.38.53.53', N'05.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'75', N'Donal Muccino', N'dmuccino22', N'E4okVgx', N'109.138.101.234', N'04.02.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'76', N'Joye Leadbetter', N'jleadbetter23', N'ZNsaKdgb', N'51.245.190.167', N'05.02.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'77', N'Gianina Trump', N'gtrump24', N'6XXY7IS26Ci', N'11.191.37.17', N'08.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'78', N'Read LeEstut', N'rleestut25', N'zq3C4rUR', N'119.247.100.162', N'09.11.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'79', N'Jill Anscott', N'janscott26', N'5maCRrCZLu', N'104.85.178.46', N'28.04.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'80', N'Bud Douch', N'bdouch27', N'KAkwrli', N'72.132.101.188', N'02.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'81', N'Cicily Ossenna', N'cossenna28', N'vfKJkCeohOzZ', N'230.85.180.186', N'01.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'82', N'Hew Izzat', N'hizzat29', N'Uifdtu', N'143.246.125.169', N'20.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'83', N'Eddie Gimeno', N'egimeno2a', N'oF1hbmKlZ', N'60.57.115.125', N'18.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'84', N'Sybyl Fierro', N'sfierro2b', N'VjUrQ2', N'250.233.247.215', N'22.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'85', N'Nicol Troup', N'ntroup2c', N'KmDDYf1Pu', N'121.7.142.165', N'25.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'86', N'Bondy Pattenden', N'bpattenden2d', N'IOUkHpOn', N'45.121.26.90', N'15.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'87', N'Angus Cockman', N'acockman2e', N'fDKhK7OK', N'167.9.255.77', N'01.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'88', N'Mord Hanscome', N'mhanscome2f', N'xBHzpa7eP0u', N'121.181.10.230', N'07.10.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'89', N'Susy Leblanc', N'sleblanc2g', N'T2et1U5M', N'118.164.120.202', N'16.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'90', N'Gerard Ciccoloi', N'gciccoloi2h', N'w4dZ3hxiCiAg', N'71.235.27.27', N'02.03.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'91', N'Seamus Sayburn', N'ssayburn2i', N'1hTM7EVKaS', N'75.194.92.114', N'24.01.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'92', N'Washington Gentiry', N'wgentiry2j', N'z2X9UH5', N'188.49.78.185', N'04.10.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'93', N'Rebekkah Westall', N'rwestall2k', N'xLgunbO9x6', N'212.150.81.93', N'02.02.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'94', N'Court Kulic', N'ckulic2l', N'FLHYRN', N'154.121.193.131', N'26.06.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'95', N'Lorilee Roux', N'lroux2m', N'98cCxHeeK31', N'229.187.60.106', N'06.12.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'96', N'Modestine Rolinson', N'mrolinson2n', N'faGzyW8hEca', N'9.203.185.188', N'30.10.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'97', N'Shelbi Ellgood', N'sellgood2o', N'3do5MME', N'199.226.26.7', N'31.08.2023')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'98', N'Barbabra Retchless', N'bretchless2p', N'WraGihh', N'86.66.23.203', N'11.09.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'99', N'Robinetta Jerzak', N'rjerzak2q', N'hAp8jki', N'205.158.144.210', N'12.11.2022')
INSERT [dbo].[Import1_User] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'100', N'Vance Boots', N'vboots2r', N'bgJfSDEVEQm6', N'91.73.40.29', N'09.07.2023')
GO
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'1', N'Clareta Hacking', N'chacking0', N'4tzqHdkqzo4', N'147.231.50.234', N'02.10.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'2', N'Northrop Mably', N'nmably1', N'ukM0e6', N'22.32.15.211', N'6/20/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'3', N'Fabian Rolf', N'frolf2', N'7QpCwac0yi', N'113.92.142.29', N'5/19/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'4', N'Lauree Raden', N'lraden3', N'5Ydp2mz', N'39.24.146.52', N'6/22/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'5', N'Barby Follos', N'bfollos4', N'ckmAJPQV', N'87.232.97.3', N'3/18/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'6', N'Mile Enterle', N'menterle5', N'0PRom6i', N'85.121.209.6', N'07.04.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'7', N'Midge Peaker', N'mpeaker6', N'0Tc5oRc', N'196.39.132.128', N'09.03.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'8', N'Manon Robichon', N'mrobichon7', N'LEwEjMlmE5X', N'143.159.207.105', N'8/31/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'9', N'Stavro Robken', N'srobken8', N'Cbmj3Yi', N'12.154.73.196', N'5/22/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'10', N'Bryan Tidmas', N'btidmas9', N'dYDHbBQfK', N'24.42.134.21', N'06.06.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'11', N'Jeannette Fussie', N'jfussiea', N'EGxXuLQ9', N'98.194.112.137', N'8/21/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'12', N'Stephen Antonacci', N'santonaccib', N'YcXAhY3Pja', N'198.146.255.15', N'10.03.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'13', N'Niccolo Bountiff', N'nbountiffc', N'5xfyjS9ZULGA', N'231.78.246.229', N'1/22/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'14', N'Clemente Benjefield', N'cbenjefieldd', N'tQOsP0ei9TuD', N'88.126.93.246', N'07.09.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'15', N'Orlan Corbyn', N'ocorbyne', N'bG1ZIzwIoU', N'232.175.48.179', N'4/24/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'16', N'Coreen Stickins', N'cstickinsf', N'QRYADbgNj', N'64.30.175.158', N'4/20/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'17', N'Daveta Clarage', N'dclarageg', N'Yp59ZIDnWe', N'139.88.229.111', N'06.09.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'18', N'Javier McCawley', N'jmccawleyh', N'g58zLcmCYON', N'14.199.67.32', N'4/20/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'19', N'Daile Band', N'dbandi', N'yFAaYuVW', N'206.105.148.56', N'12.02.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'20', N'Angil Buttery', N'abutteryj', N'ttOFbWWGtD', N'192.158.7.138', N'6/21/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'21', N'Kyla Kinman', N'kkinmank', N'qUr6fdWP6L5G', N'134.99.243.113', N'11.08.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'22', N'Selena Skepper', N'sskepperl', N'jHYN0v3', N'52.90.89.126', N'4/28/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'23', N'Alyson Yeoland', N'ayeolandm', N'QQezRBV9', N'239.7.55.187', N'5/31/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'24', N'Claudie Speeding', N'cspeedingn', N'UCLYITfw2Vo', N'127.37.194.127', N'11/15/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'25', N'Alaric Scarisbrick', N'ascarisbricko', N'fzBcv6GbyCp', N'97.227.15.172', N'2/19/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'26', N'Marie Thurby', N'mthurbyp', N'wg0uIskqei', N'94.70.148.135', N'9/18/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'27', N'Cloe Roxbrough', N'croxbroughq', N'67CVVym', N'185.110.201.36', N'01.11.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'28', N'Pegeen McCotter', N'pmccotterr', N'QG5tdzRpGZJ2', N'22.179.187.229', N'3/22/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'29', N'Iggie Calleja', N'icallejas', N'aeDvZk8o9', N'67.237.123.227', N'7/19/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'30', N'Nelle Brosch', N'nbroscht', N'DmPJt2', N'251.1.59.65', N'12/17/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'31', N'Shae Allsepp', N'sallseppu', N't0ko0854Cpvv', N'88.20.74.85', N'08.09.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'32', N'Eldridge Abbatucci', N'eabbatucciv', N'gUtNdsDu', N'52.44.134.126', N'3/29/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'33', N'Skip Garnham', N'sgarnhamw', N'eml6RqbK', N'100.17.131.54', N'1/29/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'34', N'Ric Kitchenside', N'rkitchensidex', N'xaa7miQ7yB', N'29.100.76.146', N'12/14/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'35', N'Urbanus Di Meo', N'udiy', N'dHqu78cU6NOP', N'90.30.202.251', N'12/25/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'36', N'Monty Beidebeke', N'mbeidebekez', N'F5T5spAU9A4O', N'3.32.202.92', N'02.05.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'37', N'Byrann Savins', N'bsavins10', N'l6sYf29NLN', N'123.187.14.103', N'1/23/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'38', N'Sonnie Riby', N'sriby11', N'Va34LYqFh', N'16.81.16.23', N'6/17/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'39', N'Sherill Birney', N'sbirney12', N'Ggygo2ePsETs', N'144.76.193.237', N'12/27/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'40', N'Indira Kleanthous', N'ikleanthous13', N'3H0GS7a', N'169.108.108.88', N'12/29/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'41', N'Maison Skerme', N'mskerme14', N'wy1HWA', N'143.177.136.232', N'02.10.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'42', N'Hanan Cahey', N'hcahey15', N'NSXcG9khd', N'18.127.87.158', N'6/13/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'43', N'Tore Rusling', N'trusling16', N'abol9dYC8e', N'142.216.95.251', N'3/19/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'44', N'Jeddy De Souza', N'jde17', N'gK6Hsl8Q', N'229.104.255.175', N'10/17/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'45', N'Flossi McLeoid', N'fmcleoid18', N'B9zr0N7cJw', N'90.207.38.179', N'1/26/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'46', N'Nikoletta Megainey', N'nmegainey19', N'gph7QurFf', N'172.249.218.50', N'5/22/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'47', N'Adan Bliven', N'abliven1a', N'vVxlf94KpeX', N'49.101.94.118', N'6/17/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'48', N'Mohandis Rossoni', N'mrossoni1b', N'nLXj2lS', N'161.5.132.42', N'11/16/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'49', N'Nappie Redington', N'nredington1c', N'DCbOb1SX', N'174.42.8.3', N'05.06.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'50', N'Lenka Francie', N'lfrancie1d', N'DoGeHWuAAM', N'182.2.128.34', N'3/30/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'51', N'Ashley Blowin', N'ablowin1e', N'aQygVtMjN', N'73.212.243.168', N'6/24/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'52', N'Vale Goroni', N'vgoroni1f', N'bWr0QU', N'93.126.120.134', N'8/19/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'53', N'Suki Grafom', N'sgrafom1g', N'JcNcVDAouYzA', N'9.26.5.107', N'12/17/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'54', N'Justis Gianneschi', N'jgianneschi1h', N'oieX5u3sUfpD', N'139.241.156.87', N'3/14/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'55', N'Emilie Collett', N'ecollett1i', N'Y0uMyKB0W', N'47.0.240.7', N'10.07.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'56', N'Byrom Terrell', N'bterrell1j', N'hswseW', N'157.21.33.53', N'2/25/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'57', N'Daphne Bifield', N'dbifield1k', N'oYAQ4URihIA', N'24.185.229.169', N'7/29/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'58', N'Blanca Staig', N'bstaig1l', N'MygqEtjMtUbC', N'171.78.28.229', N'2/19/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'59', N'Adriaens Kennsley', N'akennsley1m', N'CTUdBfJsy6qF', N'208.81.128.179', N'7/15/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'60', N'Emlyn Bartak', N'ebartak1n', N'y3t4H1', N'130.247.20.138', N'12/20/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'61', N'Victoria Willshire', N'vwillshire1o', N'VFSLc2t', N'243.230.165.161', N'09.03.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'62', N'Egon Savin', N'esavin1p', N'axnJY9s', N'40.140.160.210', N'1/31/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'63', N'Phillie Elsom', N'pelsom1q', N'OXzMECG', N'253.7.8.82', N'01.01.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'64', N'Adan Semaine', N'asemaine1r', N'MdJRkHor5SP', N'76.252.15.218', N'10.05.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'65', N'Constantino Northrop', N'cnorthrop1s', N'UIwCvTA7MRS0', N'119.130.24.85', N'10.12.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'66', N'Rodie Easson', N'reasson1t', N'3J0jgg9RWlXs', N'212.248.119.232', N'8/14/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'67', N'Alida Boleyn', N'aboleyn1u', N'3q2mQdDRmtr', N'181.14.56.184', N'5/26/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'68', N'Hill Scholfield', N'hscholfield1v', N'1Pbs3K6qXYB', N'15.7.205.224', N'2/23/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'69', N'Cordell Cowpe', N'ccowpe1w', N'VHr417Ft0', N'237.236.173.63', N'6/17/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'70', N'Alexandro Eldon', N'aeldon1x', N'rrywOQRmFKyh', N'4.174.11.210', N'12.04.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'71', N'Kayle Collin', N'kcollin1y', N'Q0ZV21vew0', N'52.19.142.168', N'6/30/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'72', N'Inesita Larkins', N'ilarkins1z', N'DEFNpHtU', N'3.26.42.188', N'12.05.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'73', N'Waylin Lound', N'wlound20', N'a2G4Ihh2o', N'31.243.68.215', N'1/26/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'74', N'Mechelle Gillogley', N'mgillogley21', N'EjUHfCUFqF', N'79.38.53.53', N'05.01.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'75', N'Donal Muccino', N'dmuccino22', N'E4okVgx', N'109.138.101.234', N'04.02.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'76', N'Joye Leadbetter', N'jleadbetter23', N'ZNsaKdgb', N'51.245.190.167', N'05.02.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'77', N'Gianina Trump', N'gtrump24', N'6XXY7IS26Ci', N'11.191.37.17', N'08.03.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'78', N'Read LeEstut', N'rleestut25', N'zq3C4rUR', N'119.247.100.162', N'09.11.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'79', N'Jill Anscott', N'janscott26', N'5maCRrCZLu', N'104.85.178.46', N'4/28/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'80', N'Bud Douch', N'bdouch27', N'KAkwrli', N'72.132.101.188', N'02.06.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'81', N'Cicily Ossenna', N'cossenna28', N'vfKJkCeohOzZ', N'230.85.180.186', N'01.06.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'82', N'Hew Izzat', N'hizzat29', N'Uifdtu', N'143.246.125.169', N'1/20/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'83', N'Eddie Gimeno', N'egimeno2a', N'oF1hbmKlZ', N'60.57.115.125', N'3/18/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'84', N'Sybyl Fierro', N'sfierro2b', N'VjUrQ2', N'250.233.247.215', N'1/22/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'85', N'Nicol Troup', N'ntroup2c', N'KmDDYf1Pu', N'121.7.142.165', N'6/25/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'86', N'Bondy Pattenden', N'bpattenden2d', N'IOUkHpOn', N'45.121.26.90', N'6/15/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'87', N'Angus Cockman', N'acockman2e', N'fDKhK7OK', N'167.9.255.77', N'01.06.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'88', N'Mord Hanscome', N'mhanscome2f', N'xBHzpa7eP0u', N'121.181.10.230', N'07.10.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'89', N'Susy Leblanc', N'sleblanc2g', N'T2et1U5M', N'118.164.120.202', N'6/16/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'90', N'Gerard Ciccoloi', N'gciccoloi2h', N'w4dZ3hxiCiAg', N'71.235.27.27', N'02.03.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'91', N'Seamus Sayburn', N'ssayburn2i', N'1hTM7EVKaS', N'75.194.92.114', N'1/24/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'92', N'Washington Gentiry', N'wgentiry2j', N'z2X9UH5', N'188.49.78.185', N'04.10.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'93', N'Rebekkah Westall', N'rwestall2k', N'xLgunbO9x6', N'212.150.81.93', N'02.02.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'94', N'Court Kulic', N'ckulic2l', N'FLHYRN', N'154.121.193.131', N'6/26/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'95', N'Lorilee Roux', N'lroux2m', N'98cCxHeeK31', N'229.187.60.106', N'06.12.2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'96', N'Modestine Rolinson', N'mrolinson2n', N'faGzyW8hEca', N'9.203.185.188', N'10/30/2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'97', N'Shelbi Ellgood', N'sellgood2o', N'3do5MME', N'199.226.26.7', N'8/31/2023')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'98', N'Barbabra Retchless', N'bretchless2p', N'WraGihh', N'86.66.23.203', N'11.09.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'99', N'Robinetta Jerzak', N'rjerzak2q', N'hAp8jki', N'205.158.144.210', N'12.11.2022')
INSERT [dbo].[Import1_users] ([id], [name], [login], [password], [ip], [lastenter]) VALUES (N'100', N'Vance Boots', N'vboots2r', N'bgJfSDEVEQm6', N'91.73.40.29', N'09.07.2023')
GO
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (1, N'Микс', N'Соус томатный, сыр моцарелла, ветчина, салями, сосиски баварские с зеленью, помидоры, перец болгарский', 520, 580)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (2, N'Сырная', N'Соус ранч, сыр моцарелла, сыр гауда, сыр пармезан, салат руккола', 460, 550)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (3, N'Грибнaя', N'Соус грибной, сыр, шампиньоны, опята маринованные, грибы шиитаке, микс салат', 735, 610)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (4, N'Мясная', N'Соус ранч, сыр моцарелла, колбаса п/к, куриное филе, кусочки поджарки из свинины, пепперони, салат руккола', 530, 580)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (5, N'Рыбная', N'Соус фирменный, сыр моцарелла, семга, креветки, лук красный, салат руккола', 510, 750)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (6, N'Маргарита', N'Томатный соус, сыр, помидоры, базиилик', 820, 590)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (7, N'Барбекю', N'Томатный соус, сыр, мясной топинг, сосиски баварские с зеленью, помидоры, перец болгарский, лук красный, соус барбекю', 590, 970)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (8, N'Итальянская', N'Томатный соус, сыр, ветчина, салями, куриная грудка, болгарский перец, шампиньоны, помидоры', 710, 990)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (9, N'С копченостями', N'Томатный соус, сыр, ветчина, бекон, салями, охотничьи колбаски, шампиньоны', 520, 430)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (10, N'Пепперони', N'Томатный соус, сыр, пепперони', 740, 570)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (11, N'Золотая рыбка', N'Фирменный соус, сыр, семга, креветки, красный лучок', 740, 590)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (12, N'Жюльен', N'Соус Цезарь, куриная грудка, сыр моцарелла, сыр пармезан, сливки, шампиньоны, помидоры, микс салат', 500, 620)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (13, N'Баварская', N'Томатный соус, сыр, бастурма, колбаски пепперони, колбаски охотничьи, чеснок, перчик халапеньо', 820, 790)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (14, N'Четыре сыра', N'Томатный соус, сыр моцарелла, сыр пармезан, сыр гауда, сыр с плесенью', 790, 760)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (15, N'Цезарь', N'Соус Цезарь, сыр пармезан, сыр моцарелла, куриная грудка, салат айсберг, помидоры черри', 800, 630)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (16, N'Ветчина и грибы', N'Томатный соус, сыр, много ветчины, шампиньоны, помидоры', 600, 480)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (17, N'Деревенская', N'Фирменный соус, сыр, колбаса п/к, ветчина, шампиньоны, помидоры, маринованные огурчики, перец болгарский, красный лук', 970, 870)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (18, N'Дон Бекон', N'Томатный соус, сыр, много бекона, помидорки черри', 420, 860)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (19, N'Гавайская', N'Томатный соус, сыр, много ветчины, ананасы кубиком', 650, 790)
INSERT [dbo].[Import2_PizzaIngredients] ([IdPizza], [Name], [Ingredients], [Mass], [Price]) VALUES (20, N'Студенческая', N'Фирменный соус, майонез, сыр, колбаса студенческая, помидоры', 550, 480)
GO
INSERT [dbo].[ManagerUser] ([UserId], [Name], [Role]) VALUES (1, N'Федоров', N'Менеджер')
GO
SET IDENTITY_INSERT [dbo].[Sale] ON 

INSERT [dbo].[Sale] ([SaleId], [Name], [SaledKeys]) VALUES (1, 2, 4)
INSERT [dbo].[Sale] ([SaleId], [Name], [SaledKeys]) VALUES (2, 3, 155)
INSERT [dbo].[Sale] ([SaleId], [Name], [SaledKeys]) VALUES (3, 3, 22)
INSERT [dbo].[Sale] ([SaleId], [Name], [SaledKeys]) VALUES (4, 6, 111)
INSERT [dbo].[Sale] ([SaleId], [Name], [SaledKeys]) VALUES (5, 7, 11)
SET IDENTITY_INSERT [dbo].[Sale] OFF
GO
SET IDENTITY_INSERT [dbo].[Session] ON 

INSERT [dbo].[Session] ([SessionId], [Price], [DateTime], [Is3D], [FilmId], [HallId]) VALUES (1, CAST(100 AS Decimal(4, 0)), CAST(N'2024-02-10T00:00:00.0000000' AS DateTime2), 0, 1, 3)
INSERT [dbo].[Session] ([SessionId], [Price], [DateTime], [Is3D], [FilmId], [HallId]) VALUES (2, CAST(200 AS Decimal(4, 0)), CAST(N'2024-09-23T10:04:39.1933333' AS DateTime2), 1, 3, 1)
SET IDENTITY_INSERT [dbo].[Session] OFF
GO
SET IDENTITY_INSERT [dbo].[Visitor] ON 

INSERT [dbo].[Visitor] ([VisitorId], [PhoneNumber], [Name], [BirthDay], [Email]) VALUES (1, N'89021914244         ', N'Alina', CAST(N'2005-09-12T00:00:00.0000000' AS DateTime2), N'afadeeva011@gmail.com')
INSERT [dbo].[Visitor] ([VisitorId], [PhoneNumber], [Name], [BirthDay], [Email]) VALUES (2, N'89023045698         ', N'test1', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Visitor] OFF
GO
INSERT [dbo].[VisitorInfo] ([VisitorId], [Email], [ChangingDate]) VALUES (4, N'afadeevaa011@gmail.com', CAST(N'2024-10-01T09:27:03.6200000' AS DateTime2))
INSERT [dbo].[VisitorInfo] ([VisitorId], [Email], [ChangingDate]) VALUES (4, N'afadeevaa0011@gmail.com', CAST(N'2024-10-01T09:27:33.0900000' AS DateTime2))
INSERT [dbo].[VisitorInfo] ([VisitorId], [Email], [ChangingDate]) VALUES (4, N'afadeevaa0011@gmail.com', CAST(N'2024-10-01T09:29:34.2166667' AS DateTime2))
INSERT [dbo].[VisitorInfo] ([VisitorId], [Email], [ChangingDate]) VALUES (5, N'chtotakoe444@gmail.com', CAST(N'2024-10-01T09:29:34.2166667' AS DateTime2))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Cinema]    Script Date: 05.11.2024 14:18:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Cinema] ON [dbo].[Hall]
(
	[CinemaName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_HallNumber]    Script Date: 05.11.2024 14:18:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_HallNumber] ON [dbo].[Hall]
(
	[HallNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_SessionId]    Script Date: 05.11.2024 14:18:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_SessionId] ON [dbo].[Session]
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Students_GroupId]    Script Date: 05.11.2024 14:18:26 ******/
CREATE NONCLUSTERED INDEX [IX_Students_GroupId] ON [dbo].[Students]
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Place]    Script Date: 05.11.2024 14:18:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Place] ON [dbo].[Ticket]
(
	[Place] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Row]    Script Date: 05.11.2024 14:18:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Row] ON [dbo].[Ticket]
(
	[Row] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_VisitorEmail]    Script Date: 05.11.2024 14:18:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_VisitorEmail] ON [dbo].[Visitor]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_VisitorPhone]    Script Date: 05.11.2024 14:18:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_VisitorPhone] ON [dbo].[Visitor]
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DeletedVisitors] ADD  DEFAULT (getdate()) FOR [ChangingDate]
GO
ALTER TABLE [dbo].[Film] ADD  CONSTRAINT [DF_Film_FilmSession]  DEFAULT ((90)) FOR [FilmSession]
GO
ALTER TABLE [dbo].[Film] ADD  CONSTRAINT [DF_Film_Date]  DEFAULT (datepart(year,getdate())) FOR [Date]
GO
ALTER TABLE [dbo].[Film] ADD  CONSTRAINT [DF_Film_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Game] ADD  CONSTRAINT [DF_Game_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[GamePrice] ADD  DEFAULT (getdate()) FOR [ChangingDate]
GO
ALTER TABLE [dbo].[Hall] ADD  CONSTRAINT [DF_Hall_CinemaName]  DEFAULT (N'Макси') FOR [CinemaName]
GO
ALTER TABLE [dbo].[Hall] ADD  CONSTRAINT [DF_Hall_VIP]  DEFAULT ((0)) FOR [IsVIP]
GO
ALTER TABLE [dbo].[Session] ADD  CONSTRAINT [DF_Session_Price]  DEFAULT ((200)) FOR [Price]
GO
ALTER TABLE [dbo].[Session] ADD  CONSTRAINT [DF_Session_DateTime]  DEFAULT (getdate()) FOR [DateTime]
GO
ALTER TABLE [dbo].[Session] ADD  CONSTRAINT [DF_Session_3D]  DEFAULT ((0)) FOR [Is3D]
GO
ALTER TABLE [dbo].[Students] ADD  DEFAULT ((0)) FOR [GroupId]
GO
ALTER TABLE [dbo].[VisitorInfo] ADD  DEFAULT (getdate()) FOR [ChangingDate]
GO
ALTER TABLE [dbo].[Film]  WITH CHECK ADD  CONSTRAINT [FK_Film_Genre] FOREIGN KEY([Genre])
REFERENCES [dbo].[Genre] ([Genre])
GO
ALTER TABLE [dbo].[Film] CHECK CONSTRAINT [FK_Film_Genre]
GO
ALTER TABLE [dbo].[Game]  WITH CHECK ADD  CONSTRAINT [FK_Games_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Game] CHECK CONSTRAINT [FK_Games_Categories]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FKFilmID] FOREIGN KEY([FilmId])
REFERENCES [dbo].[Film] ([FilmId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FKFilmID]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FKHallId] FOREIGN KEY([HallId])
REFERENCES [dbo].[Hall] ([HallId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FKHallId]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Groups_GroupId] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([GroupId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Groups_GroupId]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Session] FOREIGN KEY([SessionId])
REFERENCES [dbo].[Session] ([SessionId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Session]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FKVisitorId] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitor] ([VisitorId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FKVisitorId]
GO
ALTER TABLE [dbo].[AdminUser]  WITH CHECK ADD  CONSTRAINT [CK_AdminUser] CHECK  (([Role]='Админ'))
GO
ALTER TABLE [dbo].[AdminUser] CHECK CONSTRAINT [CK_AdminUser]
GO
ALTER TABLE [dbo].[ClientUser]  WITH CHECK ADD  CONSTRAINT [CK_ClientUser] CHECK  (([Role]='Клиент'))
GO
ALTER TABLE [dbo].[ClientUser] CHECK CONSTRAINT [CK_ClientUser]
GO
ALTER TABLE [dbo].[ManagerUser]  WITH CHECK ADD  CONSTRAINT [CK_ManagerUser] CHECK  (([Role]='Менеджер'))
GO
ALTER TABLE [dbo].[ManagerUser] CHECK CONSTRAINT [CK_ManagerUser]
GO
/****** Object:  StoredProcedure [dbo].[AddCategory]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCategory] 
    @name NVARCHAR(100),
    @id INT OUTPUT 
AS
BEGIN
    INSERT INTO Category(name) VALUES(@name);
	SET @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[AddCinema]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCinema]
	@cinema NVARCHAR(50)='Титан-Арена',
	@hallNumber tinyint,
	@seatsAmount tinyint,
	@rowsAmount tinyint
AS
	INSERT INTO dbo.Hall
		(CinemaName,
		HallNumber,
		RowsAmount,
		RowPlaceAmount)
	VALUES
		(@cinema,
		@hallNumber,
		@seatsAmount,
		@rowsAmount)
GO
/****** Object:  Trigger [dbo].[trSaveCategory]    Script Date: 05.11.2024 14:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trSaveCategory]
ON [dbo].[Category]
AFTER DELETE
AS
BEGIN
		INSERT INTO DeletedCategory(CategoryId, Name,DeletedDate, Login)
		SELECT CategoryId, Name, GetDate(), ORIGINAL_LOGIN()
		FROM deleted;
END;
GO
ALTER TABLE [dbo].[Category] ENABLE TRIGGER [trSaveCategory]
GO
/****** Object:  Trigger [dbo].[trDeletedFilm]    Script Date: 05.11.2024 14:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trDeletedFilm]
ON [dbo].[Film]
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Film
	SET IsDeleted = 1
	WHERE FilmId IN (SELECT FilmId FROM deleted)
END;
GO
ALTER TABLE [dbo].[Film] ENABLE TRIGGER [trDeletedFilm]
GO
/****** Object:  Trigger [dbo].[trChangedGamesCount]    Script Date: 05.11.2024 14:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trChangedGamesCount]
ON [dbo].[Game]
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
    PRINT CONCAT_WS(' ', 'Изменено строк:',
	@@ROWCOUNT)
END
GO
ALTER TABLE [dbo].[Game] ENABLE TRIGGER [trChangedGamesCount]
GO
/****** Object:  Trigger [dbo].[trDeletedGame]    Script Date: 05.11.2024 14:18:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trDeletedGame]
ON [dbo].[Game]
INSTEAD OF DELETE
AS
BEGIN
		UPDATE Game 
		SET IsDeleted = 1
		WHERE GameId IN (SELECT GameId 
							FROM deleted)
END;
GO
ALTER TABLE [dbo].[Game] ENABLE TRIGGER [trDeletedGame]
GO
/****** Object:  Trigger [dbo].[trSavePrice]    Script Date: 05.11.2024 14:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trSavePrice]
ON [dbo].[Game]
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Price)
		INSERT INTO GamePrice(GameId, Price)
		SELECT GameId, Price
		FROM deleted;
END;
GO
ALTER TABLE [dbo].[Game] ENABLE TRIGGER [trSavePrice]
GO
/****** Object:  Trigger [dbo].[trSaveEmail]    Script Date: 05.11.2024 14:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trSaveEmail]
ON [dbo].[Visitor]
AFTER UPDATE
AS
BEGIN
	IF UPDATE(Email)
	INSERT INTO VisitorInfo
	(
		VisitorId, Email
	)
	SELECT VisitorId, Email
	FROM deleted
END;
GO
ALTER TABLE [dbo].[Visitor] ENABLE TRIGGER [trSaveEmail]
GO
/****** Object:  Trigger [dbo].[trSaveVisitor]    Script Date: 05.11.2024 14:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trSaveVisitor]
ON [dbo].[Visitor]
AFTER DELETE
AS
BEGIN
	INSERT INTO DeletedVisitors
	(
		VisitorId, Name, PhoneNumber, BirthDay, Email, ChangingDate, DeletedOriginalLogin
	)
	SELECT VisitorId, Name, PhoneNumber, BirthDay, Email, GetDate(), ORIGINAL_LOGIN()
	FROM deleted;
END;
GO
ALTER TABLE [dbo].[Visitor] ENABLE TRIGGER [trSaveVisitor]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Game"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'games1000'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'games1000'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Category"
            Begin Extent = 
               Top = 24
               Left = 21
               Bottom = 120
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Game"
            Begin Extent = 
               Top = 10
               Left = 385
               Bottom = 140
               Right = 559
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Session"
            Begin Extent = 
               Top = 87
               Left = 286
               Bottom = 299
               Right = 473
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Hall"
            Begin Extent = 
               Top = 80
               Left = 507
               Bottom = 286
               Right = 728
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Film"
            Begin Extent = 
               Top = 65
               Left = 32
               Bottom = 292
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
