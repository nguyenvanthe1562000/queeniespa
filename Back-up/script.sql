USE [master]
GO
/****** Object:  Database [ShopVT]    Script Date: 03/05/2022 10:41:40 PM ******/
CREATE DATABASE [ShopVT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ShopVT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER\MSSQL\DATA\ShopVT.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ShopVT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER\MSSQL\DATA\ShopVT_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ShopVT] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShopVT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShopVT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShopVT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShopVT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShopVT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShopVT] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShopVT] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ShopVT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShopVT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShopVT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShopVT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShopVT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShopVT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShopVT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShopVT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShopVT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ShopVT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShopVT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShopVT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShopVT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShopVT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShopVT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShopVT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShopVT] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ShopVT] SET  MULTI_USER 
GO
ALTER DATABASE [ShopVT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShopVT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShopVT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShopVT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ShopVT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ShopVT] SET QUERY_STORE = OFF
GO
USE [ShopVT]
GO
/****** Object:  Table [dbo].[B00Command]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00Command](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[TableName] [varchar](48) NOT NULL,
	[Description] [nvarchar](128) NOT NULL,
	[FunctionType] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_B00DmFileLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00PermissionData]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00PermissionData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CommandId] [int] NOT NULL,
	[Description] [nvarchar](128) NOT NULL,
	[Permission] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_B00PermisionData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vB00PermisionData]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vB00PermisionData]
AS
SELECT dt.UserId, cm.TableName, cm.Description AS DescriptionTable, dt.Permission, dt.Description AS PermisionDescription
FROM B00PermissionData dt INNER  JOIN  B00Command cm ON dt.CommandId = cm.Id
WHERE dt.IsActive = 1 AND cm.IsActive = 1
GO
/****** Object:  Table [dbo].[B00AppUser]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00AppUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](256) NOT NULL,
	[username] [varchar](24) NOT NULL,
	[PassWord] [varchar](8) NOT NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
	[EmployeeCode] [varchar](24) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00CommandLog]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00CommandLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Command] [varchar](6) NOT NULL,
	[UserIp] [varchar](15) NOT NULL,
	[AppUserCode] [varchar](24) NOT NULL,
	[LastWriteAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00Contact]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00Contact](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](256) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[PhoneNumber] [varchar](10) NOT NULL,
	[Facebook] [nvarchar](256) NOT NULL,
	[address] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00EventLog]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00EventLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [varchar](66) NOT NULL,
	[LastValue] [nvarchar](256) NOT NULL,
	[Command] [varchar](30) NOT NULL,
	[NewValue] [nvarchar](256) NOT NULL,
	[TableName] [varchar](20) NOT NULL,
	[LastWriteAt] [datetime] NOT NULL,
	[LastWriteBy] [int] NOT NULL,
	[RowId] [int] NULL,
	[ColumnName] [varchar](24) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00Footer]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00Footer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](24) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00Function]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00Function](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[Code] [varchar](24) NOT NULL,
	[CategoryFunc] [int] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Url] [nvarchar](256) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00Permision]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00Permision](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](24) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00PermisionDetail]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00PermisionDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PermisionCode] [varchar](24) NOT NULL,
	[functionCode] [varchar](24) NOT NULL,
	[CanCreate] [bit] NOT NULL,
	[CanRead] [bit] NOT NULL,
	[Canupdate] [bit] NOT NULL,
	[Candelete] [bit] NOT NULL,
	[CanReport] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00PermissionFunction]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00PermissionFunction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Description] [nvarchar](128) NOT NULL,
	[Permision] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_B00PermisionFunction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B00UserPermision]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B00UserPermision](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[userCode] [varchar](24) NOT NULL,
	[PermisionCode] [varchar](24) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10Customer]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[email] [nvarchar](256) NOT NULL,
	[phone] [varchar](10) NOT NULL,
	[gender] [int] NOT NULL,
	[BirthDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
	[Code] [varchar](24) NOT NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[UserName] [varchar](24) NOT NULL,
	[PassWord] [varchar](8) NOT NULL,
 CONSTRAINT [PK__B10Custo__3214EC27E87F2A5D] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10CustomerAddress]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10CustomerAddress](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[UserName] [varchar](24) NOT NULL,
	[PassWord] [varchar](8) NOT NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[Note] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
	[CustomerCode] [varchar](24) NOT NULL,
 CONSTRAINT [PK__B10Custo__3214EC277392CE15] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10Employee]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](24) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Name2] [nvarchar](256) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Address] [nvarchar](256) NOT NULL,
	[IdCardNo] [int] NOT NULL,
	[IdCardDate] [date] NOT NULL,
	[IdCardIssuePlace] [nvarchar](256) NOT NULL,
	[BankAccount] [int] NOT NULL,
	[BankName] [nvarchar](256) NOT NULL,
	[Tel1] [varchar](10) NOT NULL,
	[Tel2] [varchar](10) NOT NULL,
	[MarriageStatus] [int] NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Gender] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10HomePage]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10HomePage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[code] [varchar](24) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[imagePath] [nvarchar](500) NOT NULL,
	[ProductCode] [varchar](24) NOT NULL,
	[PostCode] [varchar](24) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10Post]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10Post](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Alias] [varchar](500) NOT NULL,
	[PostCategoryCode] [varchar](24) NOT NULL,
	[Image] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[MetaDescription] [nvarchar](500) NOT NULL,
	[MetaKeyword] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10PostCategory]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10PostCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[code] [varchar](24) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Alias] [varchar](500) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[MetaDescription] [nvarchar](500) NOT NULL,
	[MetaKeyword] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10PostTag]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10PostTag](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [varchar](24) NOT NULL,
	[TagId] [varchar](24) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10Product]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](24) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Alias] [varchar](256) NOT NULL,
	[ProductCategoryCode] [varchar](24) NOT NULL,
	[UnitCost] [numeric](18, 2) NOT NULL,
	[UnitPrice] [numeric](18, 2) NOT NULL,
	[Warranty] [int] NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[Content] [nvarchar](256) NOT NULL,
	[Information] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10ProductCategory]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10ProductCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[code] [varchar](24) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Alias] [varchar](256) NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10ProductImg]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10ProductImg](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[code] [varchar](24) NOT NULL,
	[ProductCode] [varchar](24) NOT NULL,
	[ImagePath] [nvarchar](256) NOT NULL,
	[Caption] [nvarchar](256) NOT NULL,
	[ImageDefault] [nvarchar](256) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[ImglengthSize] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10ProductInformation]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10ProductInformation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[code] [varchar](24) NOT NULL,
	[name] [nvarchar](256) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10ProductTag]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10ProductTag](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](24) NOT NULL,
	[TagId] [varchar](24) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10Slide]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10Slide](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[code] [varchar](24) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[Image] [nvarchar](500) NOT NULL,
	[Url] [nvarchar](500) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B10Tag]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B10Tag](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Type] [nvarchar](256) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20Announcement]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20Announcement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](256) NOT NULL,
	[content] [nvarchar](256) NOT NULL,
	[HasRead] [bit] NOT NULL,
	[UserCode] [varchar](24) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20Chats]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20Chats](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Type] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20ChatUser]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20ChatUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserCode] [varchar](24) NOT NULL,
	[customerCode] [varchar](24) NOT NULL,
	[IpAddress] [varchar](24) NOT NULL,
	[ChatId] [int] NOT NULL,
	[Role] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20Flashsale]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20Flashsale](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](24) NOT NULL,
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20FlashSaleDetail]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20FlashSaleDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Flashsalecode] [varchar](24) NOT NULL,
	[ApplyForAll] [bit] NOT NULL,
	[ProductCategoryCode] [varchar](24) NOT NULL,
	[ProductCode] [varchar](24) NOT NULL,
	[DiscountPercent] [decimal](5, 2) NOT NULL,
	[UnitPrice] [numeric](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20message]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20message](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[ChatsId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20OpenInventory]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20OpenInventory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ItemCode] [varchar](24) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[Month] [varchar](4) NOT NULL,
	[DocDate] [smalldatetime] NOT NULL,
	[OriginalUnitCost] [numeric](15, 4) NOT NULL,
	[UnitCost] [numeric](18, 2) NOT NULL,
	[Unit] [nvarchar](20) NOT NULL,
	[Quantity] [int] NOT NULL,
	[rate] [numeric](15, 4) NOT NULL,
	[OriginalExpenseAmount] [numeric](18, 2) NOT NULL,
	[ExpenseAmount] [numeric](18, 2) NOT NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20Order]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](24) NOT NULL,
	[CustomerName] [nvarchar](256) NOT NULL,
	[CustomerAddress] [nvarchar](256) NOT NULL,
	[CustomerEmail] [nvarchar](256) NOT NULL,
	[CustomerMobile] [varchar](10) NOT NULL,
	[IdCardNo] [int] NOT NULL,
	[note] [nvarchar](256) NOT NULL,
	[PaymentMethod] [nvarchar](256) NOT NULL,
	[PaymentStatus] [nvarchar](max) NOT NULL,
	[OrderStatus] [int] NOT NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20OrderDetail]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20OrderDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderCode] [varchar](24) NOT NULL,
	[ProductCode] [varchar](24) NOT NULL,
	[Quantitty] [int] NOT NULL,
	[UnitPrice] [numeric](18, 2) NOT NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20ProductPromotion]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20ProductPromotion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PromotionCode] [varchar](24) NOT NULL,
	[ProductCode] [varchar](24) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20ProductReturn]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20ProductReturn](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderCode] [varchar](24) NOT NULL,
	[CustomerName] [nvarchar](256) NOT NULL,
	[CustomerAddress] [nvarchar](256) NOT NULL,
	[CustomerEmail] [nvarchar](256) NOT NULL,
	[CustomerMobile] [varchar](10) NOT NULL,
	[IdCardNo] [int] NOT NULL,
	[ProductCode] [varchar](24) NOT NULL,
	[ProductPrice] [numeric](18, 2) NOT NULL,
	[Quantity] [numeric](15, 4) NOT NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[note] [nvarchar](256) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20Promotion]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20Promotion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[code] [varchar](24) NOT NULL,
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[ProductCode] [varchar](24) NOT NULL,
	[Price] [numeric](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[B20StockLedger]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[B20StockLedger](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DocGroup] [bit] NOT NULL,
	[DocDate] [smalldatetime] NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[Unit] [nvarchar](8) NOT NULL,
	[Quantity] [numeric](15, 4) NOT NULL,
	[UnitCost] [numeric](18, 2) NOT NULL,
	[OriginalUnitCost] [numeric](18, 2) NOT NULL,
	[Warranty] [numeric](18, 2) NOT NULL,
	[Unitprice] [numeric](18, 2) NOT NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[OriginalAmount] [numeric](18, 2) NOT NULL,
	[ExpenseAmount] [numeric](18, 2) NOT NULL,
	[transportationcosts] [numeric](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[B00AppUser] ON 

INSERT [dbo].[B00AppUser] ([ID], [code], [username], [PassWord], [FullName], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt], [EmployeeCode]) VALUES (1, N'abc', N'abc', N'abc', N'', 1, -1, CAST(N'2021-10-10T09:31:31.887' AS DateTime), -1, CAST(N'2021-10-10T09:31:31.887' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[B00AppUser] OFF
SET IDENTITY_INSERT [dbo].[B00Command] ON 

INSERT [dbo].[B00Command] ([Id], [ParentId], [IsGroup], [TableName], [Description], [FunctionType], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, -1, 0, N'B10Post', N'Tin Tức ', 1, 1, -1, CAST(N'2022-02-13T05:17:39.627' AS DateTime), -1, CAST(N'2022-02-13T05:17:39.627' AS DateTime))
INSERT [dbo].[B00Command] ([Id], [ParentId], [IsGroup], [TableName], [Description], [FunctionType], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, -1, 0, N'B10PostCategory', N'Loại tin tức', 1, 1, -1, CAST(N'2022-02-13T05:17:39.627' AS DateTime), -1, CAST(N'2022-02-13T05:17:39.627' AS DateTime))
INSERT [dbo].[B00Command] ([Id], [ParentId], [IsGroup], [TableName], [Description], [FunctionType], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, -1, 0, N'B10Product', N'Sản phẩm', 1, 1, -1, CAST(N'2022-02-13T05:17:39.627' AS DateTime), -1, CAST(N'2022-02-13T05:17:39.627' AS DateTime))
SET IDENTITY_INSERT [dbo].[B00Command] OFF
SET IDENTITY_INSERT [dbo].[B00CommandLog] ON 

INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1, N'LOGIN', N'abc', N'', CAST(N'2021-10-10T09:47:03.150' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2, N'LOGIN', N'abc', N'', CAST(N'2021-10-10T09:47:24.123' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (3, N'LOGIN', N'abc', N'', CAST(N'2021-10-10T09:48:48.647' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (4, N'LOGIN', N'abc', N'', CAST(N'2021-10-10T13:13:50.260' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1004, N'LOGIN', N'', N'', CAST(N'2021-10-11T07:27:24.553' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1005, N'LOGIN', N'', N'', CAST(N'2021-10-11T07:29:05.180' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1006, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T07:31:31.047' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1007, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T08:46:38.030' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1008, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T08:51:00.423' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1009, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T08:51:17.280' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1010, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T08:51:45.380' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1011, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T08:53:52.680' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1012, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:00:57.133' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1013, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:03:35.967' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1014, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:04:26.833' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1015, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:04:43.813' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1016, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:21:24.480' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1017, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:21:28.530' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1018, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:23:05.333' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1019, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:23:05.343' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1020, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:24:16.153' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1021, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:24:16.187' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1022, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:27:00.713' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1023, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:27:00.723' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1024, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:27:11.193' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1025, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:27:11.200' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1026, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:29:58.397' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1027, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:30:26.960' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1028, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:36:03.130' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1029, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:36:03.143' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1030, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:37:20.327' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1031, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:37:20.333' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1032, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:40:26.243' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1033, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:40:26.467' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1034, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:47:40.500' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1035, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T09:47:40.697' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1036, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:02:02.537' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1037, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:02:02.717' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1038, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:03:52.703' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1039, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:03:52.963' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1040, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:08:09.310' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1041, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:08:09.523' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1042, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:09:44.123' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1043, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:09:44.293' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1044, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:11:38.083' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1045, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:11:38.223' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1046, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:20:06.230' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1047, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:20:21.073' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1048, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:20:21.950' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1049, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:20:23.037' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1050, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:21:03.773' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1051, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:21:12.967' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1052, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:21:13.563' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1053, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:21:43.547' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1054, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:21:44.150' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1055, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:21:46.847' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1056, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:21:47.397' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1057, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:23:53.300' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1058, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:24:02.820' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1059, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:24:09.570' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1060, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:25:22.120' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1061, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:25:22.603' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1062, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:41:08.820' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1063, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:41:26.100' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1064, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:41:59.340' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1065, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:41:59.920' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1066, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:42:09.300' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1067, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:42:09.763' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1068, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:42:16.180' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (1069, N'LOGIN', N'', N'abc', CAST(N'2021-10-11T10:42:16.630' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2004, N'LOGIN', N'', N'abc', CAST(N'2022-02-16T14:35:55.790' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2005, N'LOGIN', N'', N'abc', CAST(N'2022-02-16T14:36:58.233' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2006, N'LOGIN', N'', N'abc', CAST(N'2022-02-17T13:11:26.527' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2007, N'LOGIN', N'', N'abc', CAST(N'2022-02-17T15:17:12.263' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2008, N'LOGIN', N'', N'abc', CAST(N'2022-02-18T01:38:05.290' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2009, N'LOGIN', N'', N'abc', CAST(N'2022-02-28T09:20:03.720' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2010, N'LOGIN', N'', N'abc', CAST(N'2022-02-28T13:58:30.850' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2011, N'LOGIN', N'', N'abc', CAST(N'2022-03-04T08:20:04.583' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2012, N'LOGIN', N'', N'abc', CAST(N'2022-03-04T11:10:46.150' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2013, N'LOGIN', N'', N'abc', CAST(N'2022-03-04T11:10:57.003' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2014, N'LOGIN', N'', N'abc', CAST(N'2022-03-04T12:48:51.530' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2015, N'LOGIN', N'', N'abc', CAST(N'2022-03-04T16:12:45.243' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2016, N'LOGIN', N'', N'abc', CAST(N'2022-03-05T06:56:01.250' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2017, N'LOGIN', N'', N'abc', CAST(N'2022-03-05T10:10:32.300' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2018, N'LOGIN', N'', N'abc', CAST(N'2022-03-05T10:37:25.690' AS DateTime))
INSERT [dbo].[B00CommandLog] ([Id], [Command], [UserIp], [AppUserCode], [LastWriteAt]) VALUES (2019, N'LOGIN', N'', N'abc', CAST(N'2022-03-05T10:37:38.717' AS DateTime))
SET IDENTITY_INSERT [dbo].[B00CommandLog] OFF
SET IDENTITY_INSERT [dbo].[B00EventLog] ON 

INSERT [dbo].[B00EventLog] ([ID], [SessionId], [LastValue], [Command], [NewValue], [TableName], [LastWriteAt], [LastWriteBy], [RowId], [ColumnName]) VALUES (1, N'FAB3588295584BDCB3C46FF5A127FC29-56-721391', N'', N'DELETE', N'', N'B10Product', CAST(N'2021-10-08T14:24:01.283' AS DateTime), 1102, 1, N'')
INSERT [dbo].[B00EventLog] ([ID], [SessionId], [LastValue], [Command], [NewValue], [TableName], [LastWriteAt], [LastWriteBy], [RowId], [ColumnName]) VALUES (2, N'7A5450BADD614417A542044AA7C0A6A7-52-821508', N'', N'INSERT', N'', N'B10Product', CAST(N'2021-10-08T15:42:06.333' AS DateTime), 123, 2, N'')
INSERT [dbo].[B00EventLog] ([ID], [SessionId], [LastValue], [Command], [NewValue], [TableName], [LastWriteAt], [LastWriteBy], [RowId], [ColumnName]) VALUES (3, N'7A5450BADD614417A542044AA7C0A6A7-52-822419', N'', N'INSERT', N'', N'B10Product', CAST(N'2021-10-08T15:44:08.587' AS DateTime), 123, 3, N'')
INSERT [dbo].[B00EventLog] ([ID], [SessionId], [LastValue], [Command], [NewValue], [TableName], [LastWriteAt], [LastWriteBy], [RowId], [ColumnName]) VALUES (4, N'7A5450BADD614417A542044AA7C0A6A7-52-823233', N'', N'INSERT', N'', N'B10Product', CAST(N'2021-10-08T15:46:12.247' AS DateTime), 123, 4, N'')
SET IDENTITY_INSERT [dbo].[B00EventLog] OFF
SET IDENTITY_INSERT [dbo].[B00Function] ON 

INSERT [dbo].[B00Function] ([ID], [IsGroup], [ParentId], [Code], [CategoryFunc], [Name], [Url], [DisplayOrder], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 0, -1, N'PRODUCT', -1, N'S?n ph?m', N'', 1, 1, -1, CAST(N'2021-10-11T07:20:24.357' AS DateTime), -1, CAST(N'2021-10-11T07:20:24.357' AS DateTime))
SET IDENTITY_INSERT [dbo].[B00Function] OFF
SET IDENTITY_INSERT [dbo].[B00Permision] ON 

INSERT [dbo].[B00Permision] ([ID], [Code], [Name], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, N'NV', N'Nhân viên', 1, -1, CAST(N'2021-10-11T07:24:23.803' AS DateTime), -1, CAST(N'2021-10-11T07:24:23.803' AS DateTime))
SET IDENTITY_INSERT [dbo].[B00Permision] OFF
SET IDENTITY_INSERT [dbo].[B00PermisionDetail] ON 

INSERT [dbo].[B00PermisionDetail] ([ID], [PermisionCode], [functionCode], [CanCreate], [CanRead], [Canupdate], [Candelete], [CanReport], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, N'NV', N'PRODUCT', 1, 1, 1, 1, 1, 1, -1, CAST(N'2021-10-11T07:26:16.623' AS DateTime), -1, CAST(N'2021-10-11T07:26:16.623' AS DateTime))
SET IDENTITY_INSERT [dbo].[B00PermisionDetail] OFF
SET IDENTITY_INSERT [dbo].[B00PermissionData] ON 

INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 1, 1, N'Edit', 40000, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, 1, 1, N'EditOther', 500000, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, 1, 2, N'View', 10100, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, 1, 2, N'Add', 20000, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (5, 1, 2, N'Update', 30000, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (6, 1, 2, N'Delete', 40000, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (7, 1, 2, N'Restore', 50100, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (8, 1, 2, N'EditOther', 30100, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (9, 1, 3, N'ViewOther', 10100, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (10, 1, 3, N'Add', 20000, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (11, 1, 3, N'Update', 30000, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (12, 1, 3, N'Delete', 40000, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (13, 1, 3, N'Restore', 50100, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
INSERT [dbo].[B00PermissionData] ([Id], [UserId], [CommandId], [Description], [Permission], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (14, 1, 3, N'EditOther', 30100, 1, -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime), -1, CAST(N'2022-02-13T06:56:35.717' AS DateTime))
SET IDENTITY_INSERT [dbo].[B00PermissionData] OFF
SET IDENTITY_INSERT [dbo].[B00PermissionFunction] ON 

INSERT [dbo].[B00PermissionFunction] ([Id], [UserId], [Description], [Permision], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 1, N'Danh Mục', 100000000, 1, -1, CAST(N'2022-02-17T13:16:56.823' AS DateTime), -1, CAST(N'2022-02-17T13:16:56.823' AS DateTime))
INSERT [dbo].[B00PermissionFunction] ([Id], [UserId], [Description], [Permision], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, 1, N'Danh Mục', 200000000, 1, -1, CAST(N'2022-02-17T13:16:56.823' AS DateTime), -1, CAST(N'2022-02-17T13:16:56.823' AS DateTime))
INSERT [dbo].[B00PermissionFunction] ([Id], [UserId], [Description], [Permision], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, 1, N'Danh Mục', 0, 1, -1, CAST(N'2022-02-17T13:16:56.823' AS DateTime), -1, CAST(N'2022-02-17T13:16:56.823' AS DateTime))
SET IDENTITY_INSERT [dbo].[B00PermissionFunction] OFF
SET IDENTITY_INSERT [dbo].[B00UserPermision] ON 

INSERT [dbo].[B00UserPermision] ([ID], [userCode], [PermisionCode], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, N'abc', N'NV', 1, -1, CAST(N'2021-10-11T07:25:53.783' AS DateTime), -1, CAST(N'2021-10-11T07:25:53.783' AS DateTime))
SET IDENTITY_INSERT [dbo].[B00UserPermision] OFF
SET IDENTITY_INSERT [dbo].[B10Post] ON 

INSERT [dbo].[B10Post] ([ID], [Name], [Alias], [PostCategoryCode], [Image], [Description], [Content], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (63, N'stringtêttest', N'string', N'uerwer', N'string', N'string', N'string', N'string', N'string', 1, 0, CAST(N'2022-02-28T09:20:24.050' AS DateTime), 0, CAST(N'2022-02-28T09:20:24.050' AS DateTime))
INSERT [dbo].[B10Post] ([ID], [Name], [Alias], [PostCategoryCode], [Image], [Description], [Content], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (67, N'string', N'string', N'string', N'string', N'string', N'string', N'string', N'string', 1, 0, CAST(N'2022-03-05T10:42:34.140' AS DateTime), 0, CAST(N'2022-03-05T10:42:34.140' AS DateTime))
SET IDENTITY_INSERT [dbo].[B10Post] OFF
SET IDENTITY_INSERT [dbo].[B10PostCategory] ON 

INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 1, -1, N'Test1', N'string test', N'string', N'string', 0, N'string', N'string', 1, -1, CAST(N'2022-02-13T16:35:56.717' AS DateTime), 1, CAST(N'2022-02-28T21:08:44.720' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, 1, 1, N'Test', N'Test', N'', N'', -1, N'', N'', 1, 1, CAST(N'2022-02-13T16:35:56.717' AS DateTime), -1, CAST(N'2022-02-13T16:35:56.717' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, 1, 1, N'Test2', N'Test2', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-02-13T16:35:56.717' AS DateTime), -1, CAST(N'2022-02-13T16:35:56.717' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, 1, 2, N'Test3', N'Test3', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-02-13T16:35:56.717' AS DateTime), -1, CAST(N'2022-02-13T16:35:56.717' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (5, 1, 3, N'abc', N'', N'', N'', -1, N'', N'', 1, 1, CAST(N'2022-02-13T18:11:00.307' AS DateTime), 1, CAST(N'2022-02-17T21:29:51.973' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (6, 1, 0, N'string', N'string', N'string', N'string', 0, N'string', N'string', 1, -1, CAST(N'2022-02-16T15:39:26.590' AS DateTime), 1, CAST(N'2022-03-05T17:42:34.130' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (15, 1, 0, N'string', N'string', N'string', N'string', 0, N'string', N'string', 1, 1, CAST(N'2022-02-28T14:09:50.557' AS DateTime), -1, CAST(N'2022-02-28T14:09:50.557' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (16, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.687' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.687' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (17, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.733' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.733' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (18, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.763' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.763' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (19, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.793' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.793' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (20, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.823' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.823' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (21, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.853' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.853' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (22, 1, 0, N'string', N'string', N'string', N'string', 0, N'string', N'string', 1, 1, CAST(N'2022-02-28T14:09:50.557' AS DateTime), -1, CAST(N'2022-02-28T14:09:50.557' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (23, 1, 0, N'string', N'string test', N'string', N'string', 0, N'string', N'string', 1, -1, CAST(N'2022-02-16T15:39:26.590' AS DateTime), 1, CAST(N'2022-02-28T21:20:32.987' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (24, 1, 0, N'string', N'string', N'string', N'string', 0, N'string', N'string', 1, 1, CAST(N'2022-02-28T14:09:50.557' AS DateTime), -1, CAST(N'2022-02-28T14:09:50.557' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (25, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.687' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.687' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (26, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.733' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.733' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (27, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.763' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.763' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (28, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.793' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.793' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (29, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.823' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.823' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (30, 0, -1, N'', N'', N'', N'', -1, N'', N'', 1, -1, CAST(N'2022-03-04T11:33:23.853' AS DateTime), -1, CAST(N'2022-03-04T11:33:23.853' AS DateTime))
INSERT [dbo].[B10PostCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [MetaDescription], [MetaKeyword], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (31, 1, 0, N'string', N'string', N'string', N'string', 0, N'string', N'string', 1, 1, CAST(N'2022-02-28T14:09:50.557' AS DateTime), -1, CAST(N'2022-02-28T14:09:50.557' AS DateTime))
SET IDENTITY_INSERT [dbo].[B10PostCategory] OFF
SET IDENTITY_INSERT [dbo].[B10Product] ON 

INSERT [dbo].[B10Product] ([ID], [code], [Name], [Alias], [ProductCategoryCode], [UnitCost], [UnitPrice], [Warranty], [Description], [Content], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, N'string', N'string', N'string', N'string', CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 0, N'string', N'string', N'string', 1, -1, CAST(N'2021-10-08T15:42:05.957' AS DateTime), -1, CAST(N'2021-10-08T15:42:05.957' AS DateTime))
INSERT [dbo].[B10Product] ([ID], [code], [Name], [Alias], [ProductCategoryCode], [UnitCost], [UnitPrice], [Warranty], [Description], [Content], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, N'test23', N'string', N'string', N'string', CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 0, N'string', N'string', N'string', 1, -1, CAST(N'2021-10-08T15:44:08.437' AS DateTime), -1, CAST(N'2021-10-08T15:44:08.437' AS DateTime))
INSERT [dbo].[B10Product] ([ID], [code], [Name], [Alias], [ProductCategoryCode], [UnitCost], [UnitPrice], [Warranty], [Description], [Content], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, N'test123', N'string', N'string', N'string', CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 0, N'string', N'string', N'string', 1, 123, CAST(N'2021-10-08T15:46:12.037' AS DateTime), -1, CAST(N'2021-10-08T15:46:12.037' AS DateTime))
INSERT [dbo].[B10Product] ([ID], [code], [Name], [Alias], [ProductCategoryCode], [UnitCost], [UnitPrice], [Warranty], [Description], [Content], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1002, N'12022030529dc0a0ea729', N'3123tret', N'que', N'ue', CAST(3123.00 AS Numeric(18, 2)), CAST(123.00 AS Numeric(18, 2)), 123, N'23', N'', N'', 1, 1, CAST(N'2022-03-05T07:03:52.443' AS DateTime), 1, CAST(N'2022-03-05T17:34:39.950' AS DateTime))
SET IDENTITY_INSERT [dbo].[B10Product] OFF
SET IDENTITY_INSERT [dbo].[B10ProductCategory] ON 

INSERT [dbo].[B10ProductCategory] ([ID], [IsGroup], [ParentId], [code], [Name], [Alias], [Description], [DisplayOrder], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 0, -1, N'code1', N'tin nóng', N'tin-nong', N'', 0, 1, -1, CAST(N'2022-02-28T08:53:17.713' AS DateTime), -1, CAST(N'2022-02-28T08:53:17.713' AS DateTime))
SET IDENTITY_INSERT [dbo].[B10ProductCategory] OFF
SET IDENTITY_INSERT [dbo].[B10ProductImg] ON 

INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 0, -1, N'', N'code1', N'', N'tin nóng hổi', N'', -1, -1, 1, -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime), -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime))
INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, 0, -1, N'', N'code1', N'', N'tin nóng hổi', N'', -1, -1, 1, -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime), -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime))
INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, 0, -1, N'', N'code1', N'', N'tin nóng hổi', N'', -1, -1, 1, -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime), -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime))
INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, 0, -1, N'', N'code1', N'', N'tin nóng hổi', N'', -1, -1, 1, -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime), -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime))
INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (5, 0, -1, N'', N'code1', N'', N'tin nóng hổi', N'', -1, -1, 1, -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime), -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime))
INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (6, 0, -1, N'', N'code1', N'', N'tin nóng hổi', N'', -1, -1, 1, -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime), -1, CAST(N'2022-02-28T08:53:34.113' AS DateTime))
INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (22, 0, -1, N'', N'12022030529dc0a0ea729', N'/user-content/df70d70b-e0d9-4f39-9e1d-c571a8d86bde.jpg', N'qưe', N'true', 0, 0, 0, 0, CAST(N'2022-03-05T10:34:39.953' AS DateTime), 0, CAST(N'2022-03-05T10:34:39.953' AS DateTime))
INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (23, 0, -1, N'', N'12022030529dc0a0ea729', N'/user-content/f21a80a3-f4a4-4b4e-bc88-16fadda211e5.jpg', N'qưe', N'false', 0, 60653, 0, 0, CAST(N'2022-03-05T10:34:39.953' AS DateTime), 0, CAST(N'2022-03-05T10:34:39.953' AS DateTime))
INSERT [dbo].[B10ProductImg] ([ID], [IsGroup], [ParentId], [code], [ProductCode], [ImagePath], [Caption], [ImageDefault], [SortOrder], [ImglengthSize], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (24, 0, -1, N'', N'12022030529dc0a0ea729', N'/user-content/0da5f87b-3d21-449a-9218-994bacb87471.jpg', N'qưe', N'false', 0, 60653, 0, 0, CAST(N'2022-03-05T10:34:39.953' AS DateTime), 0, CAST(N'2022-03-05T10:34:39.953' AS DateTime))
SET IDENTITY_INSERT [dbo].[B10ProductImg] OFF
SET IDENTITY_INSERT [dbo].[B10ProductInformation] ON 

INSERT [dbo].[B10ProductInformation] ([ID], [IsGroup], [ParentId], [code], [name], [DisplayOrder], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 0, -1, N'LAPTOP', N'Máy tính', 1, 1, -1, CAST(N'2021-12-20T09:45:41.960' AS DateTime), -1, CAST(N'2021-12-20T09:45:41.960' AS DateTime))
SET IDENTITY_INSERT [dbo].[B10ProductInformation] OFF
SET IDENTITY_INSERT [dbo].[B10Tag] ON 

INSERT [dbo].[B10Tag] ([ID], [Name], [Type], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, N'string1234', N'string', 1, -1, CAST(N'2022-02-09T16:21:53.620' AS DateTime), -1, CAST(N'2022-02-09T16:21:53.620' AS DateTime))
INSERT [dbo].[B10Tag] ([ID], [Name], [Type], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, N'string', N'string', 1, -1, CAST(N'2022-02-09T16:39:04.780' AS DateTime), -1, CAST(N'2022-02-09T16:39:04.780' AS DateTime))
INSERT [dbo].[B10Tag] ([ID], [Name], [Type], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, N'string', N'string', 1, -1, CAST(N'2022-02-09T16:51:22.080' AS DateTime), -1, CAST(N'2022-02-09T16:51:22.080' AS DateTime))
INSERT [dbo].[B10Tag] ([ID], [Name], [Type], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, N'string', N'string', 1, -1, CAST(N'2022-02-09T17:27:59.023' AS DateTime), -1, CAST(N'2022-02-09T17:27:59.023' AS DateTime))
INSERT [dbo].[B10Tag] ([ID], [Name], [Type], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (5, N'string', N'string', 1, -1, CAST(N'2022-02-10T16:53:24.210' AS DateTime), -1, CAST(N'2022-02-10T16:53:24.210' AS DateTime))
INSERT [dbo].[B10Tag] ([ID], [Name], [Type], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (6, N'string', N'string', 1, -1, CAST(N'2022-02-10T16:54:02.687' AS DateTime), -1, CAST(N'2022-02-10T16:54:02.687' AS DateTime))
INSERT [dbo].[B10Tag] ([ID], [Name], [Type], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (7, N'string123123232', N'string', 1, -1, CAST(N'2022-02-10T16:54:21.100' AS DateTime), -1, CAST(N'2022-02-10T16:54:21.100' AS DateTime))
SET IDENTITY_INSERT [dbo].[B10Tag] OFF
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT ('') FOR [username]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT ('') FOR [PassWord]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT ('') FOR [FullName]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00AppUser] ADD  DEFAULT ('') FOR [EmployeeCode]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00DmFileLog_ParentId]  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00DmFileLog_IsGroup]  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00DmFileLog_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00Command_CreatedBy1]  DEFAULT ((-1)) FOR [FunctionType]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00DmFileLog_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00DmFileLog_CreatedBy]  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00DmFileLog_CreatedAt]  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00DmFileLog_ModifiedBy]  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00Command] ADD  CONSTRAINT [DF_B00DmFileLog_ModifiedAt]  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00CommandLog] ADD  DEFAULT ('') FOR [Command]
GO
ALTER TABLE [dbo].[B00CommandLog] ADD  DEFAULT ('') FOR [UserIp]
GO
ALTER TABLE [dbo].[B00CommandLog] ADD  DEFAULT ('') FOR [AppUserCode]
GO
ALTER TABLE [dbo].[B00CommandLog] ADD  DEFAULT (getutcdate()) FOR [LastWriteAt]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ('') FOR [Email]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ('') FOR [PhoneNumber]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ('') FOR [Facebook]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00Contact] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ('') FOR [SessionId]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ('') FOR [LastValue]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ('') FOR [Command]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ('') FOR [NewValue]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ('') FOR [TableName]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ('') FOR [LastWriteAt]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ((-1)) FOR [LastWriteBy]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ((-1)) FOR [RowId]
GO
ALTER TABLE [dbo].[B00EventLog] ADD  DEFAULT ('') FOR [ColumnName]
GO
ALTER TABLE [dbo].[B00Footer] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B00Footer] ADD  DEFAULT ('') FOR [Content]
GO
ALTER TABLE [dbo].[B00Footer] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00Footer] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00Footer] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00Footer] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00Footer] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ('') FOR [Code]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ((-1)) FOR [CategoryFunc]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ('') FOR [Url]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ((1)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00Function] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00Permision] ADD  DEFAULT ('') FOR [Code]
GO
ALTER TABLE [dbo].[B00Permision] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B00Permision] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00Permision] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00Permision] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00Permision] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00Permision] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ('') FOR [PermisionCode]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ('') FOR [functionCode]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ((1)) FOR [CanCreate]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ((1)) FOR [CanRead]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ((1)) FOR [Canupdate]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ((1)) FOR [Candelete]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ((1)) FOR [CanReport]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00PermisionDetail] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_Table_2_CommandId1]  DEFAULT ((-1)) FOR [UserId]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_Table_2_FunctionType1]  DEFAULT ((-1)) FOR [CommandId]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_B00PermisionData_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_Table_2_FunctionType]  DEFAULT ((-1)) FOR [Permission]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_B00PermisionData_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_B00PermisionData_CreatedBy]  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_B00PermisionData_CreatedAt]  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_B00PermisionData_ModifiedBy]  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00PermissionData] ADD  CONSTRAINT [DF_B00PermisionData_ModifiedAt]  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00PermissionFunction] ADD  CONSTRAINT [DF_B00PermisionFunction_UserId]  DEFAULT ((-1)) FOR [UserId]
GO
ALTER TABLE [dbo].[B00PermissionFunction] ADD  CONSTRAINT [DF_B00PermisionFunction_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B00PermissionFunction] ADD  CONSTRAINT [DF_B00PermisionFunction_Permision]  DEFAULT ((-1)) FOR [Permision]
GO
ALTER TABLE [dbo].[B00PermissionFunction] ADD  CONSTRAINT [DF_B00PermisionFunction_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00PermissionFunction] ADD  CONSTRAINT [DF_B00PermisionFunction_CreatedBy]  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00PermissionFunction] ADD  CONSTRAINT [DF_B00PermisionFunction_CreatedAt]  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00PermissionFunction] ADD  CONSTRAINT [DF_B00PermisionFunction_ModifiedBy]  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00PermissionFunction] ADD  CONSTRAINT [DF_B00PermisionFunction_ModifiedAt]  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B00UserPermision] ADD  DEFAULT ('') FOR [userCode]
GO
ALTER TABLE [dbo].[B00UserPermision] ADD  DEFAULT ('') FOR [PermisionCode]
GO
ALTER TABLE [dbo].[B00UserPermision] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B00UserPermision] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B00UserPermision] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B00UserPermision] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B00UserPermision] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custome__Name__42E1EEFE]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__email__43D61337]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__phone__44CA3770]  DEFAULT ('') FOR [phone]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__gende__45BE5BA9]  DEFAULT ((-1)) FOR [gender]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__Birth__46B27FE2]  DEFAULT ('') FOR [BirthDate]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__IsAct__47A6A41B]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__Creat__489AC854]  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__Creat__498EEC8D]  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__Modif__4A8310C6]  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custom__Modif__4B7734FF]  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF__B10Custome__Code__4C6B5938]  DEFAULT ('') FOR [Code]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF_B10Customer_FullName]  DEFAULT ('') FOR [FullName]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF_B10Customer_UserName]  DEFAULT ('') FOR [UserName]
GO
ALTER TABLE [dbo].[B10Customer] ADD  CONSTRAINT [DF_B10Customer_PassWord]  DEFAULT ('') FOR [PassWord]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custom__Addre__57DD0BE4]  DEFAULT ('') FOR [Address]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custome__Name__58D1301D]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custom__Phone__59C55456]  DEFAULT ('') FOR [Phone]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF_B10CustomerAddress_username]  DEFAULT ('') FOR [UserName]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF_B10CustomerAddress_PassWord]  DEFAULT ('') FOR [PassWord]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF_B10CustomerAddress_FullName]  DEFAULT ('') FOR [FullName]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custome__Note__5AB9788F]  DEFAULT ('') FOR [Note]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custom__IsAct__5BAD9CC8]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custom__Creat__5CA1C101]  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custom__Creat__5D95E53A]  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custom__Modif__5E8A0973]  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF__B10Custom__Modif__5F7E2DAC]  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10CustomerAddress] ADD  CONSTRAINT [DF_B10CustomerAddress_CustomerCode]  DEFAULT ('') FOR [CustomerCode]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [Name2]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [BirthDate]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [Address]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ((-1)) FOR [IdCardNo]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [IdCardDate]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [IdCardIssuePlace]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ((-1)) FOR [BankAccount]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [BankName]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [Tel1]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [Tel2]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ((-1)) FOR [MarriageStatus]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ('') FOR [Email]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ((-1)) FOR [Gender]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10Employee] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ('') FOR [imagePath]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ('') FOR [PostCode]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10HomePage] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ('') FOR [Alias]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ('') FOR [PostCategoryCode]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ('') FOR [Image]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ('') FOR [Content]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ('') FOR [MetaDescription]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ('') FOR [MetaKeyword]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10Post] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ('') FOR [Alias]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ((-1)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ('') FOR [MetaDescription]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ('') FOR [MetaKeyword]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10PostCategory] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10PostTag] ADD  DEFAULT ('') FOR [PostId]
GO
ALTER TABLE [dbo].[B10PostTag] ADD  DEFAULT ('') FOR [TagId]
GO
ALTER TABLE [dbo].[B10PostTag] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10PostTag] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10PostTag] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10PostTag] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10PostTag] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ('') FOR [Alias]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ('') FOR [ProductCategoryCode]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ((0)) FOR [UnitCost]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ((1)) FOR [Warranty]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ('') FOR [Content]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ('') FOR [Information]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10Product] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ('') FOR [Alias]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ((0)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10ProductCategory] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ('') FOR [ImagePath]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ('') FOR [Caption]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ('') FOR [ImageDefault]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ((-1)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ((-1)) FOR [ImglengthSize]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10ProductImg] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT ('') FOR [name]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT ((1)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10ProductInformation] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10ProductTag] ADD  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[B10ProductTag] ADD  DEFAULT ('') FOR [TagId]
GO
ALTER TABLE [dbo].[B10ProductTag] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10ProductTag] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10ProductTag] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10ProductTag] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10ProductTag] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ('') FOR [Image]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ('') FOR [Url]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ((0)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10Slide] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B10Tag] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B10Tag] ADD  DEFAULT ('') FOR [Type]
GO
ALTER TABLE [dbo].[B10Tag] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B10Tag] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B10Tag] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B10Tag] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B10Tag] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT ('') FOR [content]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT ((1)) FOR [HasRead]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT ('') FOR [UserCode]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20Announcement] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20Chats] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B20Chats] ADD  DEFAULT ((-1)) FOR [Type]
GO
ALTER TABLE [dbo].[B20Chats] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20Chats] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20ChatUser] ADD  DEFAULT ('') FOR [UserCode]
GO
ALTER TABLE [dbo].[B20ChatUser] ADD  DEFAULT ('') FOR [customerCode]
GO
ALTER TABLE [dbo].[B20ChatUser] ADD  DEFAULT ('') FOR [IpAddress]
GO
ALTER TABLE [dbo].[B20ChatUser] ADD  DEFAULT ((-1)) FOR [ChatId]
GO
ALTER TABLE [dbo].[B20ChatUser] ADD  DEFAULT ((-1)) FOR [Role]
GO
ALTER TABLE [dbo].[B20ChatUser] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20ChatUser] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20ChatUser] ADD  DEFAULT ((-1)) FOR [UserId]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT (getutcdate()) FOR [FromDate]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT (getutcdate()) FOR [ToDate]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20Flashsale] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ('') FOR [Flashsalecode]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ((1)) FOR [ApplyForAll]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ('') FOR [ProductCategoryCode]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ((0)) FOR [DiscountPercent]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20FlashSaleDetail] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20message] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[B20message] ADD  DEFAULT ('') FOR [Text]
GO
ALTER TABLE [dbo].[B20message] ADD  DEFAULT ((-1)) FOR [ChatsId]
GO
ALTER TABLE [dbo].[B20message] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20message] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20message] ADD  DEFAULT ((-1)) FOR [UserId]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ('') FOR [ItemCode]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ('') FOR [Year]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ('') FOR [Month]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ('') FOR [DocDate]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((0)) FOR [OriginalUnitCost]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((0)) FOR [UnitCost]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ('') FOR [Unit]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((0)) FOR [rate]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((0)) FOR [OriginalExpenseAmount]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((0)) FOR [ExpenseAmount]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20OpenInventory] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ('') FOR [CustomerName]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ('') FOR [CustomerAddress]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ('') FOR [CustomerEmail]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ('') FOR [CustomerMobile]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ((-1)) FOR [IdCardNo]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ('') FOR [note]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ('') FOR [PaymentMethod]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ('') FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ((1)) FOR [OrderStatus]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20Order] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT ('') FOR [OrderCode]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT ((1)) FOR [Quantitty]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20OrderDetail] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20ProductPromotion] ADD  DEFAULT ('') FOR [PromotionCode]
GO
ALTER TABLE [dbo].[B20ProductPromotion] ADD  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[B20ProductPromotion] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20ProductPromotion] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20ProductPromotion] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20ProductPromotion] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20ProductPromotion] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ('') FOR [OrderCode]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ('') FOR [CustomerName]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ('') FOR [CustomerAddress]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ('') FOR [CustomerEmail]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ('') FOR [CustomerMobile]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ((-1)) FOR [IdCardNo]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ((0)) FOR [ProductPrice]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ('') FOR [note]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20ProductReturn] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT ((0)) FOR [IsGroup]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT ((-1)) FOR [ParentId]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT (getutcdate()) FOR [FromDate]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT (getutcdate()) FOR [ToDate]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20Promotion] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((1)) FOR [DocGroup]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT (getutcdate()) FOR [DocDate]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ('') FOR [Unit]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [UnitCost]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [OriginalUnitCost]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [Warranty]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [Unitprice]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [OriginalAmount]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [ExpenseAmount]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((0)) FOR [transportationcosts]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((-1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT ((-1)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[B20StockLedger] ADD  DEFAULT (getutcdate()) FOR [ModifiedAt]
GO
/****** Object:  StoredProcedure [dbo].[B10Product_create]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[B10Product_create]
	(@code varchar(24), @Name nvarchar(256), @Alias varchar(256), @ProductCategoryCode varchar(24), @UnitCost numeric, @UnitPrice numeric, @Warranty int, @Description nvarchar(256), @Content nvarchar(256), @Information nvarchar(MAX) , @user_id int)


AS
    BEGIN
	BEGIN TRY	
	IF(EXISTS
	(
		SELECT 1
		FROM B10Product
		 WHERE B10Product.code = @code  
	))
	BEGIN
		SELECT 'MESSAGE.B10Product_exist';
	END;
	ELSE
		BEGIN
		EXEC sp_set_session_context 'user_id', @user_id; 
		INSERT INTO B10Product
		(
code,
			Name,
			Alias,
			ProductCategoryCode,
			UnitCost,
			UnitPrice,
			Warranty,
			Description,
			Content,
			Information,
createdBy
		)
		VALUES
		(
@code,
			@Name,
			@Alias,
			@ProductCategoryCode,
			@UnitCost,
			@UnitPrice,
			@Warranty,
			@Description,
			@Content,
			@Information,
			@user_id
		);
		END;
	END TRY

	-- If any error
	BEGIN CATCH
		SELECT 'MESSAGE. failed';
	END CATCH
    END;


GO
/****** Object:  StoredProcedure [dbo].[B10Product_delete]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[B10Product_delete]
	(@code varchar(24), @user_id int)

AS
    BEGIN
        IF(NOT EXISTS
        (
            SELECT 1
            FROM B10Product
            WHERE B10Product.code = @code  
        ))
            BEGIN
                SELECT 'MESSAGE.not_exist';
        END;
            ELSE
            BEGIN
	EXEC sp_set_session_context 'user_id', 1102; 
	DELETE FROM B10Product 
	WHERE B10Product.code = @code  
             END;
    END;

GO
/****** Object:  StoredProcedure [dbo].[B10Product_get_all]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[B10Product_get_all]
AS
    BEGIN
        SELECT 
            code, Name, Alias, ProductCategoryCode, UnitCost, UnitPrice, Warranty, Description, Content, Information, IsActive, CreatedBy, CreatedAt, ModifiedBy, ModifiedAt
        FROM B10Product 

    END;

GO
/****** Object:  StoredProcedure [dbo].[B10Product_get_by_id]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [dbo].[B10Product_get_by_id]
	( @code varchar(24) )
AS
    BEGIN
        SELECT 
            code, Name, Alias, ProductCategoryCode, UnitCost, UnitPrice, Warranty, Description, Content, Information, IsActive, CreatedBy, CreatedAt, ModifiedBy, ModifiedAt
        FROM B10Product 
        WHERE B10Product.code = @code  
	
    END;

GO
/****** Object:  StoredProcedure [dbo].[B10Product_search]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






--CREATE PROCEDURE [dbo].[B10Product_search] 
--	( @Name nvarchar(256) )
--AS
--    BEGIN 
--		IF(@lang = 'e')
--			BEGIN	
--				SELECT code, Name, Alias, ProductCategoryCode, UnitCost, UnitPrice, Warranty, Description, Content, Information, IsActive, CreatedBy, CreatedAt, ModifiedBy, ModifiedAt
--				FROM B10Product
--				WHERE  WHERE B10Product.Name = @Name   
--				
--			END
--		ELSE
--			BEGIN
--				SELECT code, Name, Alias, ProductCategoryCode, UnitCost, UnitPrice, Warranty, Description, Content, Information, IsActive, CreatedBy, CreatedAt, ModifiedBy, ModifiedAt
--				FROM  B10Product
--				WHERE  WHERE B10Product.Name = @Name   
--				
--			END
--    END;
--
CREATE PROCEDURE [dbo].[B10Product_search] 
	( @Name nvarchar(256) )
AS
BEGIN	
SELECT code, Name, Alias, ProductCategoryCode, UnitCost, UnitPrice, Warranty, Description, Content, Information, IsActive, CreatedBy, CreatedAt, ModifiedBy, ModifiedAt
FROM B10Product
 WHERE B10Product.Name =@Name
    END;

GO
/****** Object:  StoredProcedure [dbo].[B10Product_update]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [dbo].[B10Product_update]
	( @code varchar(24), @Name nvarchar(256), @Alias varchar(256), @ProductCategoryCode varchar(24), @UnitCost numeric, @UnitPrice numeric, @Warranty int, @Description nvarchar(256), @Content nvarchar(256), @Information nvarchar(MAX), @IsActive bit , @user_id int)


AS
    BEGIN
        IF(NOT EXISTS
        (
            SELECT 1
            FROM B10Product
             WHERE B10Product.code = @code  
        ))
            BEGIN
                SELECT 'MESSAGE.not_exist';
        END;
            ELSE
            BEGIN
	EXEC sp_set_session_context 'user_id', @user_id; 
                UPDATE B10Product
                  SET 
B10Product.code=@code,
			B10Product.Name=@Name,
			B10Product.Alias=@Alias,
			B10Product.ProductCategoryCode=@ProductCategoryCode,
			B10Product.UnitCost=@UnitCost,
			B10Product.UnitPrice=@UnitPrice,
			B10Product.Warranty=@Warranty,
			B10Product.Description=@Description,
			B10Product.Content=@Content,
			B10Product.Information=@Information,
			B10Product.IsActive=@IsActive
                WHERE B10Product.code = @code  ;
              
        END;
    END;

GO
/****** Object:  StoredProcedure [dbo].[usp_GetPermissionData]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetPermissionData] 
 @UserId int
 
AS
BEGIN
	SELECT Permision
	FROM B00PermissionFunction
	WHERE UserId=@UserId AND IsActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetPermissionFunction]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetPermissionFunction] 
 @UserId int
 
AS
BEGIN
	SELECT DISTINCT Permision
	FROM B00PermissionFunction
	WHERE UserId=@UserId AND IsActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Login] 
 @userName varchar(24), 
 @password varchar(8)
AS
BEGIN
	DECLARE @_userName VARCHAR(32)
	DECLARE @_passWord VARCHAR(32)
	SET @_userName=CONVERT(VARCHAR(32), HashBytes('MD5',@userName), 2)
	SET @_passWord=CONVERT(VARCHAR(32), HashBytes('MD5',@password), 2)

	SELECT TOP 1 id, code, fullname, EmployeeCode, Cast(SPACE(5000) AS VARCHAR(5000)) AS Roles INTO #result
	FROM B00AppUser
	WHERE IsActive=1 
			AND (CONVERT(VARCHAR(32), HashBytes('MD5',username), 2) =@_userName) 
			AND (CONVERT(VARCHAR(32), HashBytes('MD5',[PassWord]), 2) =@_passWord)

	IF 1 = (SELECT COUNT(*) FROM #result)
	BEGIN
		UPDATE #result
		SET Roles= (
						SELECT pd.FunctionCode, CanCreate, CanRead, CanUpdate, CanDelete, CanReport
						FROM B00UserPermision up
							 LEFT JOIN b00Permision p ON p.Code= up.PermisionCode AND p.IsActive=1
							 LEFT JOIN B00PermisionDetail pd ON pd.permisionCode= p.code AND pd.IsActive=1
							 LEFT JOIN B00Function f ON f.Code = pd.FunctionCode AND f.IsActive = 1
						WHERE UP.IsActive=1 AND up.userCode=(SELECT code FROM #result)
						FOR JSON AUTO
					)

		INSERT INTO B00CommandLog (Command, AppUserCode)
		SELECT 'LOGIN', code
		FROM #result

		SELECT * FROM #result

		DROP TABLE #result
	END
	ELSE
	BEGIN
		SELECT N'TÀI KHOẢN KHÔNG TỒN TẠI';
		DROP TABLE #result
		RETURN;
	END
END








GO
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorAdd]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/** Thêm dữ liệu theo bảng**/
/** tạo: 02/09/2022 **/
/** Nguyễn văn thể **/

CREATE PROCEDURE [dbo].[usp_sys_DataEditorAdd]
		 @userId  int, 
		 @table varchar(15),
		 @columnArray varchar(1000), 
		 @data nvarchar(max),
		 @isRequired varchar(1),
		 @requiredColumnPrimeryKey nvarchar(MAX)
AS
BEGIN				
		DECLARE @_str nvarchar(MAX), @_userId varchar(10)
		IF LEN(ISNULL(@table,''))<3
			BEGIN SELECT '@table is not validate' RETURN; END

		IF LEN(ISNULL(@columnArray,''))<3
			BEGIN SELECT '@columnArray is not validate' RETURN; END
		
		IF LEN(ISNULL(@data,''))<3 
			BEGIN
				SELECT '@data is not validate' RETURN;
			END
				
		EXEC sp_set_session_context 'user_id', @userId; 

		SET @_userId= CAST(@userId AS varchar)
		SET @_str=  
		N'IF (NOT EXISTS(SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+ @table +''' AND Permission = 0000020000)) ' + SPACE(3) +
		N'			BEGIN '  + SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền thêm dữ liệu  '+ @table+'''' + SPACE(3) +
		N'				return;'  + SPACE(3) +
		N'			END' + SPACE(3) +
		N'BEGIN TRY'														    + SPACE(3) +
		N'IF( '+@isRequired+' = 1'+')'											+ SPACE(3) +
		N'BEGIN'																+ SPACE(3) +
		N'			 '+ @requiredColumnPrimeryKey								+ SPACE(3) +
		N'END'																	+ SPACE(3) +
		N'	ELSE'																+ SPACE(3) +
		N'		BEGIN'															+ SPACE(3) +
		N'		INSERT INTO '+ @table 										    + SPACE(3) +
		N'		( '+@columnArray +')'											+ SPACE(3) +
		N'		VALUES'															+ SPACE(3) +
		N'		('+ @data +');'													+ SPACE(3) +
		N'		END;'															+ SPACE(3) +
		N'	END TRY'															+ SPACE(3) +
		N'	BEGIN CATCH'														+ SPACE(3) +
		N'		SELECT ''MESSAGE. failed'';'									+ SPACE(3) +
		N'	END CATCH'
	
		EXEC(@_str)
		
END;



	
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorAddMultiple]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/** Thêm dữ liệu theo bảng**/
/** tạo: 02/09/2022 **/
/** Nguyễn văn thể **/

CREATE PROCEDURE [dbo].[usp_sys_DataEditorAddMultiple]
		 @userId  int, 
		 @table varchar(15),
		 @columnArray varchar(1000), 
		 @data nvarchar(max),
		 @InsertChild nvarchar(max),
		 @isRequired varchar(1),
		 @requiredColumnPrimeryKey nvarchar(MAX)
AS
BEGIN				
		DECLARE @_str nvarchar(max), @_userId varchar(10)
		IF LEN(ISNULL(@table,''))<3
			BEGIN SELECT '@table is not validate' RETURN; END

		IF LEN(ISNULL(@columnArray,''))<3
			BEGIN SELECT '@columnArray is not validate' RETURN; END
		
		IF LEN(ISNULL(@data,''))<3 
			BEGIN
				SELECT '@data is not validate' RETURN;
			END
				
		EXEC sp_set_session_context 'user_id', @userId; 

		SET @_userId= CAST(@userId AS varchar)
		SET @_str=  
		N'IF (NOT EXISTS(SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+ @table +''' AND Permission = 0000020000)) ' + SPACE(3) +
		N'			BEGIN '  + SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền thêm dữ liệu  '+ @table+'''' + SPACE(3) +
		N'				return;'  + SPACE(3) +
		N'			END' + SPACE(3) +
		N'BEGIN TRY'														    + SPACE(3) +
		N'IF( '+@isRequired+' = 1'+')'											+ SPACE(3) +
		N'BEGIN'																+ SPACE(3) +
		N'			 '+ @requiredColumnPrimeryKey								+ SPACE(3) +
		N'END'																	+ SPACE(3) +
		N'	ELSE'																+ SPACE(3) +
		N'		BEGIN'															+ SPACE(3) +
		N'		INSERT INTO '+ @table 										    + SPACE(3) +
		N'		( '+@columnArray +')'											+ SPACE(3) +
		N'		VALUES'															+ SPACE(3) +
		N'		('+ @data +');'													+ SPACE(3) +
		N''																		+ SPACE(100) +
		N'			'+@InsertChild												+ SPACE(3) +
		N'		END;'															+ SPACE(3) +
		N'	END TRY'															+ SPACE(3) +
		N'	BEGIN CATCH'														+ SPACE(3) +
		N'		SELECT ERROR_MESSAGE() + ''--'' + CAST(ERROR_LINE() AS NVARCHAR) AS MESSAGE;'+ SPACE(3) +
		N'	END CATCH'
	
		EXEC( @_str)
		
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorDelete]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/** Thêm dữ liệu theo bảng**/
/** tạo: 02/09/2022 **/
/** Nguyễn văn thể **/
-- update dữ liệu động theo bảng
CREATE PROCEDURE [dbo].[usp_sys_DataEditorDelete]
		 @userId  int, 
		 @table varchar(50),		
		 @rowId int = -1,
		 @isRequired varchar(1) =0,
		 @requiredColumnPrimeryKey nvarchar(Max)='SELECT ''MESSAGE.No MESSAGE;''; RETURN;'
AS
BEGIN				
		DECLARE @_rowId varchar(100), @_userId varchar(10)
		DECLARE @_str nvarchar(MAX);
		EXEC sp_set_session_context 'user_id', @userId; 
		IF LEN(ISNULL(@table,''))<3
			BEGIN SELECT '@table is null' RETURN; END
		--check quyền sửa dữ liệu, dữ liệu là owner hay others
		SET @_rowId= CONVERT(varchar,@rowId)
		SET @_userId= CAST(@userId AS varchar)
		SET @_str=
		N'IF (EXISTS(SELECT TOP 1 CreatedBy FROM '+@Table+' WHERE id = ' + CAST(@RowId AS VARCHAR) + '  AND CreatedBy = '+CAST(@_userId AS VARCHAR)+'))'	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND (Permission = 0000040000 OR Permission = 0000040100)))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền Xóa dữ liệu '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END'+ SPACE(3) +
		N'ELSE '	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 0000040100))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền Xóa dữ liệu người khác '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END' + SPACE(3) +
		N'BEGIN TRY'														    + SPACE(3) +
		N'IF( '+@isRequired+' = 1'+')'											+ SPACE(3) +
		N'BEGIN'																+ SPACE(3) +
		N'			 '+ @requiredColumnPrimeryKey								+ SPACE(3) +
		N'END'																	+ SPACE(3) +
		N'		UPDATE '+ @table 												+ SPACE(3) +
		N'		SET IsActive = 0, modifiedat= GETDATE(), modifiedby = '+@_userId+ SPACE(3) +
		N'		WHERE id = '+@_rowId 											+ SPACE(3) +
		N'	END TRY'															+ SPACE(3) +
		N'	BEGIN CATCH'														+ SPACE(3) +
		N'		SELECT ''MESSAGE. failed'';'									+ SPACE(3) +
		N'	END CATCH'
		EXEC( @_str)
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorRestore]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/** Thêm dữ liệu theo bảng**/
/** tạo: 02/09/2022 **/
/** Nguyễn văn thể **/
-- update dữ liệu động theo bảng
CREATE PROCEDURE [dbo].[usp_sys_DataEditorRestore]
		 @userId  int, 
		 @table varchar(50),		
		 @rowId int = -1,
		 @isRequired varchar(1) =0,
		 @requiredColumnPrimeryKey nvarchar(Max)='SELECT ''MESSAGE.No MESSAGE;''; RETURN;'
AS
BEGIN				
		DECLARE @_rowId varchar(100), @_userId varchar(10)
		DECLARE @_str nvarchar(MAX);
		EXEC sp_set_session_context 'user_id', @userId; 
		IF LEN(ISNULL(@table,''))<3
			BEGIN SELECT '@table is null' RETURN; END
		--check quyền sửa dữ liệu, dữ liệu là owner hay others
		SET @_rowId= CONVERT(varchar,@rowId)
		SET @_userId= CAST(@userId AS varchar)
		SET @_str=
		N'IF (EXISTS(SELECT TOP 1 CreatedBy FROM '+@Table+' WHERE id = ' + CAST(@RowId AS VARCHAR) + '  AND CreatedBy = '+CAST(@_userId AS VARCHAR)+'))'	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND (Permission = 0000050000 OR Permission = 0000050100)))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền phục hồi dữ liệu '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END'+ SPACE(3) +
		N'ELSE '	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 0000050100))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền phục hồi dữ liệu người khác '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END' + SPACE(3) +
		N'BEGIN TRY'														    + SPACE(3) +
		N'IF( '+@isRequired+' = 1'+')'											+ SPACE(3) +
		N'BEGIN'																+ SPACE(3) +
		N'			 '+ @requiredColumnPrimeryKey								+ SPACE(3) +
		N'END'																	+ SPACE(3) +
		N'		UPDATE '+ @table 												+ SPACE(3) +
		N'		SET IsActive = 1, modifiedat= GETDATE(), modifiedby = '+@_userId+ SPACE(3) +
		N'		WHERE id= '+@_rowId 											+ SPACE(3) +
		N'	END TRY'															+ SPACE(3) +
		N'	BEGIN CATCH'														+ SPACE(3) +
		N'		SELECT ''MESSAGE. failed'';'									+ SPACE(3) +
		N'	END CATCH'
		
		EXEC( @_str)
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorUpdateMultiRow]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/** Thêm dữ liệu theo bảng**/
/** tạo: 02/09/2022 **/
/** Nguyễn văn thể **/
-- update dữ liệu động cho nhiều bảng theo quy tắc 1 cha nhiều con
CREATE PROCEDURE [dbo].[usp_sys_DataEditorUpdateMultiRow]
		 @userId  int, 
		 @table varchar(50),		
		 @queryUpdateData nvarchar(max),
		 @rowId int,
		 @isRequired varchar(1) = 0,
		 @requiredColumnPrimeryKey nvarchar(max)='SELECT ''MESSAGE.No MESSAGE;''; RETURN;',
		 @JsonTableChild		nvarchar(Max),
		 @QueryUpdate		nvarchar(4000),
		 @QueryDelete		nvarchar(4000),
		 @QueryInsert		nvarchar(4000),
		 @TempTable			nvarchar(4000),
		 @QueryDropTempTable nvarchar(4000)
AS
BEGIN				
		DECLARE @_rowId varchar(100), @_userId varchar(10)
		DECLARE @_str nvarchar(MAX);
		EXEC sp_set_session_context 'user_id', @userId; 
		IF LEN(ISNULL(@table,''))<3
			BEGIN	SELECT '@table is null' RETURN; END

		IF LEN(ISNULL(@queryUpdateData,''))<3
			BEGIN	SELECT '@queryUpdateData is null' RETURN;END
		--check quyền sửa dữ liệu, dữ liệu là owner hay others
		SET @_rowId= CONVERT(varchar,@rowId)
		SET @_userId= CAST(@userId AS varchar)
		SET @_str=
		N'IF (EXISTS(SELECT TOP 1 CreatedBy FROM '+@Table+' WHERE id = ' + CAST(@RowId AS VARCHAR) + '  AND CreatedBy = '+CAST(@_userId AS VARCHAR)+'))'	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND (Permission = 30000 OR Permission = 30100)))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền update dữ liệu '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END'+ SPACE(3) +
		N'ELSE '	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 30100))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền update dữ liệu người khác '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END' + SPACE(3) +
		N'BEGIN TRY'																			+ SPACE(3) +
		N'IF( '+@isRequired+' = 1'+')'															+ SPACE(3) +
		N'BEGIN'																				+ SPACE(3) +
		N'			 '+ @requiredColumnPrimeryKey												+ SPACE(3) +
		N'END'																					+ SPACE(3) +
		N'	BEGIN TRANSACTION'																	+ SPACE(3) +
		N'		UPDATE '+ @table 																+ SPACE(3) +
		N'		SET modifiedat = GETDATE(), modifiedby = '+@_userId +', '+ @queryUpdateData		+ SPACE(3) +
		N'		WHERE id= '+@_rowId 															+ SPACE(3) +
		N'		 '+@TempTable 																	+ SPACE(3) +
		N'		 '+@QueryDelete 																+ SPACE(3) +
		N'		 '+@QueryUpdate 																+ SPACE(3) +
		N'		 '+@QueryInsert 																+ SPACE(3) +
		N'		 '+@QueryDropTempTable 															+ SPACE(3) +
		N'	COMMIT TRANSACTION'																	+ SPACE(3) +
		N'	END TRY'																			+ SPACE(3) +
		N'	BEGIN CATCH'																		+ SPACE(3) +
		N'	ROLLBACK TRANSACTION  '																+ SPACE(3) +
		N'		SELECT ERROR_MESSAGE() + ''--'' + CAST(ERROR_LINE() AS NVARCHAR) AS MESSAGE;'	+ SPACE(3) +
		N'	END CATCH'

		--SELECT @_str
		EXEC sp_executesql @_str,N'@JsonTableChild NVARCHAR(MAX)', @JsonTableChild
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorUpdateOneRow]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/** Thêm dữ liệu theo bảng**/
/** tạo: 02/09/2022 **/
/** Nguyễn văn thể **/
-- update dữ liệu động theo bảng
CREATE PROCEDURE [dbo].[usp_sys_DataEditorUpdateOneRow]
		 @userId  int, 
		 @table varchar(50),		
		 @queryUpdateData nvarchar(max),
		 @rowId int,
		 @isRequired varchar(1) = 0,
		 @requiredColumnPrimeryKey nvarchar(max)='SELECT ''MESSAGE.No MESSAGE;''; RETURN;'
AS
BEGIN				
		DECLARE @_rowId varchar(100), @_userId varchar(10)
		DECLARE @_str nvarchar(MAX);
		EXEC sp_set_session_context 'user_id', @userId; 
		IF LEN(ISNULL(@table,''))<3
			BEGIN	SELECT '@table is null' RETURN; END

		IF LEN(ISNULL(@queryUpdateData,''))<3
			BEGIN	SELECT '@queryUpdateData is null' RETURN;END
		--check quyền sửa dữ liệu, dữ liệu là owner hay others
		SET @_rowId= CONVERT(varchar,@rowId)
		SET @_userId= CAST(@userId AS varchar)
		SET @_str=
		N'IF (EXISTS(SELECT TOP 1 CreatedBy FROM '+@Table+' WHERE id = ' + CAST(@RowId AS VARCHAR) + '  AND CreatedBy = '+CAST(@_userId AS VARCHAR)+'))'	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND (Permission = 30000 OR Permission = 30100)))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền update dữ liệu '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END'+ SPACE(3) +
		N'ELSE '	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 30100))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền update dữ liệu người khác '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END' + SPACE(3) +
		N'BEGIN TRY'														    + SPACE(3) +
		N'IF( '+@isRequired+' = 1'+')'											+ SPACE(3) +
		N'BEGIN'																+ SPACE(3) +
		N'			 '+ @requiredColumnPrimeryKey								+ SPACE(3) +
		N'END'																	+ SPACE(3) +
		N'		UPDATE '+ @table 												+ SPACE(3) +
		N'		SET modifiedat = GETDATE(), modifiedby = '+@_userId +', '+ @queryUpdateData											+ SPACE(3) +
		N'		WHERE id= '+@_rowId 											+ SPACE(3) +
		N'	END TRY'															+ SPACE(3) +
		N'	BEGIN CATCH'														+ SPACE(3) +
		N'		SELECT ''MESSAGE. failed'';'									+ SPACE(3) +
		N'	END CATCH'

		EXEC( @_str)
		
END;

GO
/****** Object:  StoredProcedure [dbo].[usp_sys_GetData]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_sys_GetData]
		@UserId int = -1,
		@PageSize  int= 10, 
		@PageIndex  int=0, 
		@Table varchar(50)='',
		@Filter nvarchar(max)='',
		@TypeData bit =0,
		@Orderby varchar(10)='id', 
		@OrderDesc bit =0
AS
BEGIN
		DECLARE @_column nvarchar(4000), @_userId varchar(10);;
		DECLARE @_index nvarchar(10);
		DECLARE @_str nvarchar(max);
		SET @_userId= CAST(@userId AS varchar)
		IF @PageIndex>1
			BEGIN 
				SET @_index=(@PageIndex-1) * @PageSize
			END
		ELSE
			BEGIN 
				SET @_index=0
			END
		SELECT @_column= STRING_AGG (COLUMN_NAME, ',')   
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME =@table;
		SET @_str=  
					N'IF ( EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 0000010100 ))'+ SPACE(3) +
					N'BEGIN '+ SPACE(3) +
						N'DECLARE @result1 table
						(
							PageSize int,
							PageIndex int,
							TotalRecords  int,
							[PageCount] int,
							Items nvarchar(max)
						);'+ SPACE(3) +
						N'INSERT INTO @result1(PageSize, PageIndex, TotalRecords, [PageCount])'+ SPACE(3) +
						N'SELECT '+CAST(@PageSize AS VARCHAR(10))+', '+CAST(@PageIndex AS VARCHAR(10))+ ', COUNT(ID), CEILING(CAST(COUNT(ID) AS FLOAT)/'+ CAST(@PageSize AS VARCHAR(10))+')'+ SPACE(3) +
						N'FROM '+ @table + SPACE(3) +
						N'WHERE IsActive= ' + CASE WHEN @TypeData = 0 THEN '0' ELSE '1' END	+ SPACE(3) +
						N'UPDATE @result1'+ SPACE(3) +
						N'SET Items = ('+ SPACE(3) +
						N'					SELECT '+ @_column + SPACE(3) +
						N'					FROM '+ @table + SPACE(3) +
						N'					WHERE IsActive= ' + CASE WHEN @TypeData=0 THEN '0' ELSE '1' END	 + SPACE(3) + CASE WHEN ISNULL(@Filter, '') != ''  THEN 'AND '+@Filter ELSE SPACE(3) END + SPACE(3) +
						N'					ORDER BY '+ @orderby 	+ SPACE(3)  + CASE WHEN @OrderDesc=1 THEN 'DESC' ELSE 'ASC' END	+ SPACE(3) +
						N'					OFFSET '+ @_index +' ROWS FETCH NEXT ' + CAST(@PageSize AS VARCHAR(10)) + ' ROWS ONLY '+ SPACE(3) +
						N'					FOR JSON AUTO'+ SPACE(3) +
						N'				)'+ SPACE(3) +
						N'SELECT * FROM @result1 ' + SPACE(3) +
						N'RETURN;' + SPACE(3) +
					N'END'+ SPACE(3) +
					N'ELSE IF ( EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 0000010000 ))'+ SPACE(3) +
					N'BEGIN'+ SPACE(3) +
							N'DECLARE @result table
							(
								PageSize int,
								PageIndex int,
								TotalRecords  int,
								[PageCount] int,
								Items nvarchar(max)
							);'+ SPACE(3) +
							N'INSERT INTO @result(PageSize, PageIndex, TotalRecords, [PageCount])'+ SPACE(3) +
							N'SELECT '+CAST(@PageSize AS VARCHAR(10))+', '+CAST(@PageIndex AS VARCHAR(10))+ ', COUNT(ID), CEILING(CAST(COUNT(ID) AS FLOAT)/'+ CAST(@PageSize AS VARCHAR(10))+')'+ SPACE(3) +
							N'FROM '+ @table + SPACE(3) +
							N'WHERE IsActive= ' + CASE WHEN @TypeData = 0 THEN '0' ELSE '1' END	+ SPACE(3) +
							N'UPDATE @result'+ SPACE(3) +
							N'SET Items = ('+ SPACE(3) +
							N'					SELECT '+ @_column + SPACE(3) +
							N'					FROM '+ @table + SPACE(3) +
							N'					WHERE CreatedBy= ' + @_userId +' AND IsActive= ' + CASE WHEN @TypeData=0 THEN '0' ELSE '1' END	 + SPACE(3) + CASE WHEN ISNULL(@Filter, '') != ''  THEN 'AND '+@Filter ELSE SPACE(3) END + SPACE(3) +
							N'					ORDER BY '+ @orderby 	+ SPACE(3)  + CASE WHEN @OrderDesc=1 THEN 'DESC' ELSE 'ASC' END	+ SPACE(3) +
							N'					OFFSET '+ @_index +' ROWS FETCH NEXT ' + CAST(@PageSize AS VARCHAR(10)) + ' ROWS ONLY '+ SPACE(3) +
							N'					FOR JSON AUTO'+ SPACE(3) +
							N'				)'+ SPACE(3) +
							N'SELECT * FROM @result' + SPACE(3) +
							N'RETURN;' + SPACE(3) +
					N'END'+ SPACE(3) +
					N'ELSE ' + SPACE(3) +
					N'BEGIN'+ SPACE(3) +
							N'SELECT N''MESSAGE.  Bạn không có quyền xem'''+ SPACE(3) +
							N'RETURN;' + SPACE(3) +
					N'END'
					
--select @_str
		EXEC ( @_str)
END


GO
/****** Object:  StoredProcedure [dbo].[usp_sys_GetDataByGroup]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/** truy vấn lấy dữ liệu  explore **/
/** truy vấn lấy dữ liệu **/
/** truy vấn lấy dữ liệu **/
/** truy vấn lấy dữ liệu **/
CREATE PROCEDURE [dbo].[usp_sys_GetDataByGroup]
		 @UserId int,
		 @PageSize  int= 10, 
		 @PageIndex  int=0, 
		 @Table varchar(15),
		 @ParentId int,
		 @Filter nvarchar(max)='',
		 @Orderby varchar(10)='id', 
		 @OrderDesc bit=0
AS
BEGIN
		DECLARE @_column nvarchar(4000), @_userId varchar(10), @_IsError nvarchar(1000);
		DECLARE @_index nvarchar(1000);
		DECLARE @_str nvarchar(max);
		SET @_userId= CAST(@userId AS varchar)
		IF @PageIndex>0
			BEGIN 
				SET @_index=(@PageIndex-1) * @PageSize
			END
		ELSE
			BEGIN 
				SET @_index=@PageSize
			END
		SELECT @_column= STRING_AGG (COLUMN_NAME, ',')   
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME =@table;
		
		SET @_str=
			N'IF COL_LENGTH('''+@Table+ ''', ''ParentId'') IS  NULL'+ SPACE(3) +
			N'BEGIN										'+ SPACE(3) +
			N'	SELECT @error=''MESSAGE. ParentId IS NOT EXIST '''+ SPACE(3) +
			N'	RETURN;'+ SPACE(3) +
			N'END'+ SPACE(3) +
			N'IF COL_LENGTH('''+@Table+ ''', ''IsGroup'') IS  NULL'+ SPACE(3) +
			N'BEGIN										'+ SPACE(3) +
			N'	SELECT @error=''MESSAGE. IsGroup IS NOT EXIST '''+ SPACE(3) +
			N'	RETURN;'+ SPACE(3) +
			N'END'
			EXECUTE sp_executesql @_str, N'@error nvarchar(1000) OUTPUT',  @error = @_IsError OUTPUT
			IF( LEN(ISNULL(@_IsError,''))>0)
			BEGIN
				SELECT @_IsError 
				RETURN;
			END
		
			SET @_str=  N'IF COL_LENGTH('''+@Table+ ''', ''ParentId'') IS  NULL'+ SPACE(3) +
			N'BEGIN										'+ SPACE(3) +
			N'	SELECT ''MESSAGE. ParentId IS NOT EXIST '''+ SPACE(3) +
			N'	RETURN;'+ SPACE(3) +
			N'END'+ SPACE(3) +
			N'IF COL_LENGTH('''+@Table+ ''', ''IsGroup'') IS  NULL'+ SPACE(3) +
			N'BEGIN										'+ SPACE(3) +
			N'	SELECT ''MESSAGE. IsGroup IS NOT EXIST '''+ SPACE(3) +
			N'	RETURN;'+ SPACE(3) +
			N'END'+ SPACE(3) +
					N'IF ( EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 0000010100 ))'+ SPACE(3) +
					N'BEGIN '+ SPACE(3) +
						N'DECLARE @result1 table
						(
							PageSize int,
							PageIndex int,
							TotalRecords  int,
							[PageCount] int,
							ListObj nvarchar(max)
						);'+ SPACE(3) +
						N'INSERT INTO @result1(PageSize, PageIndex, TotalRecords, [PageCount])'+ SPACE(3) +
						N'SELECT '+CAST(@PageSize AS VARCHAR(10))+', '+CAST(@PageIndex AS VARCHAR(10))+ ', COUNT(ID), CEILING(CAST(COUNT(ID) AS FLOAT)/'+ CAST(@PageSize AS VARCHAR(10))+')'+ SPACE(3) +
						N'FROM '+ @table + SPACE(3) +
						N'WHERE IsActive= 1 AND ParentId = ' 	+ CAST(@ParentId AS varchar) 	+ SPACE(3) +
						N'UPDATE @result1'+ SPACE(3) +
						N'SET ListObj = ('+ SPACE(3) +
						N'					SELECT '+ @_column + SPACE(3) +
						N'					FROM '+ @table + SPACE(3) +
						N'					WHERE IsActive= 1 AND ParentId = ' 	+ CAST(@ParentId AS varchar) + SPACE(3) + CASE WHEN ISNULL(@Filter, '') != ''  THEN 'AND '+@Filter ELSE '' END + SPACE(3) +
						N'					ORDER BY '+ @orderby 	+ SPACE(3)  + CASE WHEN @OrderDesc=1 THEN 'DESC' ELSE 'ASC' END	+ SPACE(3) +
						N'					OFFSET '+ @_index +' ROWS FETCH NEXT ' + CAST(@PageSize AS VARCHAR(10)) + ' ROWS ONLY '+ SPACE(3) +
						N'					FOR JSON AUTO'+ SPACE(3) +
						N'				)'+ SPACE(3) +
						N'SELECT * FROM @result1 ' + SPACE(3) +
						N'RETURN;' + SPACE(3) +
					N'END'+ SPACE(3) +
					N'ELSE IF ( EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 0000010000 ))'+ SPACE(3) +
					N'BEGIN'+ SPACE(3) +
							N'DECLARE @result table
							(
								PageSize int,
								PageIndex int,
								TotalRecords  int,
								[PageCount] int,
								ListObj nvarchar(max)
							);'+ SPACE(3) +
							N'INSERT INTO @result(PageSize, PageIndex, TotalRecords, [PageCount])'+ SPACE(3) +
							N'SELECT '+CAST(@PageSize AS VARCHAR(10))+', '+CAST(@PageIndex AS VARCHAR(10))+ ', COUNT(ID), CEILING(CAST(COUNT(ID) AS FLOAT)/'+ CAST(@PageSize AS VARCHAR(10))+')'+ SPACE(3) +
							N'FROM '+ @table + SPACE(3) +
							N'WHERE IsActive= 1 AND ParentId = ' + CAST(@ParentId AS varchar) 	+ SPACE(3) +
							N'UPDATE @result'+ SPACE(3) +
							N'SET ListObj = ('+ SPACE(3) +
							N'					SELECT '+ @_column + SPACE(3) +
							N'					FROM '+ @table + SPACE(3) +
							N'					WHERE CreatedBy= ' + @_userId +' AND IsActive= 1' + CAST(@ParentId AS varchar)	 + SPACE(3) + CASE WHEN ISNULL(@Filter, '') != ''  THEN 'AND '+@Filter ELSE '' END + SPACE(3) +
							N'					ORDER BY '+ @orderby 	+ SPACE(3)  + CASE WHEN @OrderDesc=1 THEN 'DESC' ELSE 'ASC' END	+ SPACE(3) +
							N'					OFFSET '+ @_index +' ROWS FETCH NEXT ' + CAST(@PageSize AS VARCHAR(10)) + ' ROWS ONLY '+ SPACE(3) +
							N'					FOR JSON AUTO'+ SPACE(3) +
							N'				)'+ SPACE(3) +
							N'SELECT * FROM @result' + SPACE(3) +
							N'RETURN;' + SPACE(3) +
					N'END'+ SPACE(3) +
					N'ELSE ' + SPACE(3) +
					N'BEGIN'+ SPACE(3) +
							N'SELECT N''MESSAGE.  Bạn không có quyền xem'''+ SPACE(3) +
							N'RETURN;' + SPACE(3) +
					N'END'
					

		EXEC ( @_str)
END

GO
/****** Object:  StoredProcedure [dbo].[usp_sys_GetDataById]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_sys_GetDataById]
		 @userId  int, 
		 @Table varchar(50),
		 @RowId int
AS
BEGIN
		DECLARE @_column varchar(1000), @_userId varchar(10);
		DECLARE @_index varchar(1000);
		DECLARE @_str nvarchar(MAX);
		IF LEN(ISNULL(@table,''))<3
		BEGIN
			SELECT '@table không đúng' RETURN;
		END
	

		SELECT @_column= STRING_AGG (COLUMN_NAME, ',')   
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @Table;
		
		SET @_userId= CAST(@userId AS varchar)
		SET @_str=
		N'IF (EXISTS(SELECT TOP 1 CreatedBy FROM '+@Table+' WHERE id = ' + CAST(@RowId AS VARCHAR) + '  AND CreatedBy = '+CAST(@_userId AS VARCHAR)+'))'	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND (Permission = 0000010000 OR Permission = 0000010100)))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền xem dữ liệu '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END'+ SPACE(3) +
		N'ELSE '	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+@Table+''' AND Permission = 0000010100))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền xem dữ liệu người khác '+@table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END' + SPACE(3) +
		N'SELECT '+ @_column + SPACE(3) +
		N'FROM '+ @table + SPACE(3) +
		N'WHERE Id=  ' + CAST(@RowId AS VARCHAR)
		EXEC ( @_str)
END


GO
/****** Object:  StoredProcedure [dbo].[usp_sys_GetDataByIdMultipleTalbe]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_sys_GetDataByIdMultipleTalbe]
		 @userId  int, 
		 @Table varchar(50),
		 @RowId int,
		 @SubTable nvarchar(max)
AS
BEGIN
		DECLARE @_column varchar(1000), @_userId varchar(10);
		DECLARE @_index varchar(1000);
		DECLARE @_str nvarchar(MAX);

		IF LEN(ISNULL(@table,''))<3
		BEGIN
			SELECT '@table không đúng' RETURN;
		END	

		SELECT @_column= STRING_AGG (COLUMN_NAME, ',')   
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @Table;

		
		SET @_userId= CAST(@userId AS varchar)
		SET @_str=
		N'IF (EXISTS(SELECT TOP 1 CreatedBy FROM '+@Table+' WHERE id = ' + CAST(@RowId AS VARCHAR) + '  AND CreatedBy = '+CAST(@_userId AS VARCHAR)+'))'	+ SPACE(3) +
		N'BEGIN'+ SPACE(3) +
		N'IF (NOT EXISTS(	SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+ @_userId +' AND TableName= ''' + @Table +''' AND (Permission = 0000010000 OR Permission = 0000010100)))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền xem dữ liệu '+ @table +'''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'        + SPACE(3) +
		N'END'   + SPACE(3) +
		N'ELSE ' + SPACE(3) +
		N'BEGIN' + SPACE(3) +
		N'IF (NOT EXISTS( SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = ' + @_userId + ' AND TableName= ''' + @Table +''' AND Permission = 0000010100))'+ SPACE(3) +
		N'			BEGIN '+ SPACE(3) +
		N'				SELECT N''MESSAGE.Không có quyền xem dữ liệu người khác ' + @table + '''' + SPACE(3) +
		N'				RETURN;'+ SPACE(3) +
		N'			END'+ SPACE(3) +
		N'END' + SPACE(3) +
		N'SELECT '+ @_column + @SubTable + SPACE(3) +
		N'FROM '+ @table + SPACE(3) +
		N'WHERE Id=  ' + CAST(@RowId AS VARCHAR)
		EXEC ( @_str)
		--SELECT @_str
END


GO
/****** Object:  StoredProcedure [dbo].[usp_sys_GetGroup]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/** lấy dữ liệu nhóm **/
/** tạo: 02/08/2022 **/
/** Nguyễn văn thể **/
/** truy vấn lấy dữ liệu **/
CREATE PROCEDURE [dbo].[usp_sys_GetGroup]
		 @UserId int,
		 @Table varchar(50),
		 @ColumnCaption varchar(50),
		 @Orderby varchar(50)='id', 
		 @OrderDesc bit =0
AS
BEGIN
		DECLARE @_column varchar(1000), @_userId varchar(10), @_IsError nvarchar(1000);
		DECLARE @_index varchar(1000);
		DECLARE @_str nvarchar(MAX);
		SET @_userId= CAST(@userId AS varchar)
		SET @_str=
			N'IF COL_LENGTH('''+@Table+ ''', ''ParentId'') IS  NULL'+ SPACE(3) +
			N'BEGIN										'+ SPACE(3) +
			N'	SELECT @error=''MESSAGE. ParentId IS NOT EXIST '''+ SPACE(3) +
			N'	RETURN;'+ SPACE(3) +
			N'END'+ SPACE(3) +
			N'IF COL_LENGTH('''+@Table+ ''', ''IsGroup'') IS  NULL'+ SPACE(3) +
			N'BEGIN										'+ SPACE(3) +
			N'	SELECT @error=''MESSAGE. IsGroup IS NOT EXIST '''+ SPACE(3) +
			N'	RETURN;'+ SPACE(3) +
			N'END'
			EXECUTE sp_executesql @_str, N'@error nvarchar(1000) OUTPUT',  @error = @_IsError OUTPUT
			IF( LEN(ISNULL(@_IsError,''))>0)
			BEGIN
				SELECT @_IsError 
				RETURN;
			END
		SET @_str=
		
		N'IF (EXISTS(SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+ @table +''' AND Permission = 0000010100)) ' + SPACE(3) +
		N'	BEGIN '  + SPACE(3) +
		N'		SELECT DISTINCT Id, ParentId, '+@ColumnCaption+' AS Title'  + SPACE(3) +
		N'		FROM '+ @table + SPACE(3) +
		N'		WHERE   IsGroup = 1 AND IsActive = 1'+ SPACE(3) +
		N'		ORDER BY ' +@Orderby+ CASE WHEN @OrderDesc = 1 THEN ' DESC ' ELSE '' END  + SPACE(3) +
		N'	END'  + SPACE(3) +
		N'ELSE IF (EXISTS(SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+ @table +''' AND Permission = 0000010100)) ' + SPACE(3) +
		N'BEGIN'  + SPACE(3) +
		N'	SELECT DISTINCT Id, ParentId, '+@ColumnCaption+' AS Title'  + SPACE(3) +
		N'	FROM '+ @table + SPACE(3) +
		N'	WHERE   IsGroup = 1 AND IsActive = 1 AND CreatedBy = ' +@_userId + SPACE(3) +
		N'	ORDER BY ' +@Orderby+ CASE WHEN @OrderDesc = 1 THEN ' DESC ' ELSE '' END + SPACE(3) +
		N'END'  + SPACE(3) +
		N'ELSE '  + SPACE(3) +
		N'	BEGIN '  + SPACE(3) +
		N'	SELECT N''MESSAGE. không có quyền xem '+@table+''''  + SPACE(3) +
		N'	END; '  
		EXEC ( @_str)
END
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_PagingForTable]    Script Date: 03/05/2022 10:41:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_sys_PagingForTable]
		 @PageSize  int= 10, 
		 @PageIndex  int=0, 
		 @orderby varchar(10)='id', 
		 @table varchar(10)
AS
BEGIN
		DECLARE @_column varchar(1000);
		DECLARE @_index varchar(1000);
		DECLARE @_str varchar(5000);

		IF @PageIndex>0
			BEGIN 
				SET @_index=(@PageIndex-1) * @PageSize
			END
		ELSE
			BEGIN 
				SET @_index=@PageSize
			END
		SELECT @_column= STRING_AGG (COLUMN_NAME, ',')   
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME =@table;


		SET @_str=  N'DECLARE @result table
					(
						PageSize int,
						PageIndex int,
						TotalRecords  int,
						[PageCount] int,
						ListObj nvarchar(max)
				    );'+ SPACE(3) +
					N'INSERT INTO @result(PageSize, PageIndex, TotalRecords, [PageCount])'+ SPACE(3) +
					N'SELECT '+CAST(@PageSize AS VARCHAR(10))+', '+CAST(@PageIndex AS VARCHAR(10))+ ', COUNT(ID), CEILING(CAST(COUNT(ID) AS FLOAT)/'+ CAST(@PageSize AS VARCHAR(10))+')'+ SPACE(3) +
					N'FROM '+ @table + SPACE(3) +
					N'UPDATE @result'+ SPACE(3) +
					N'SET ListObj = ('+ SPACE(3) +
					N'					SELECT '+ @_column + SPACE(3) +
					N'					FROM '+ @table + SPACE(3) +
					N'					WHERE IsActive=  1' + SPACE(3) +
					N'					ORDER BY '+ @orderby + SPACE(3) +
					N'					OFFSET '+ @_index +' ROWS FETCH NEXT ' + CAST(@PageSize AS VARCHAR(10)) + ' ROWS ONLY '+ SPACE(3) +
					N'					FOR JSON AUTO'+ SPACE(3) +
					N'				)'+ SPACE(3) +
					N'SELECT * FROM @result';

		EXEC ( @_str)
END

GO
USE [master]
GO
ALTER DATABASE [ShopVT] SET  READ_WRITE 
GO
