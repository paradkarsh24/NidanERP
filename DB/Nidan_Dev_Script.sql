USE [master]
GO
/****** Object:  Database [Nidan_Dev]    Script Date: 08/02/2017 5:54:52 PM ******/
CREATE DATABASE [Nidan_Dev]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Nidan_Dev', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Nidan_Dev.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Nidan_Dev_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Nidan_Dev_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Nidan_Dev] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Nidan_Dev].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Nidan_Dev] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Nidan_Dev] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Nidan_Dev] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Nidan_Dev] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Nidan_Dev] SET ARITHABORT OFF 
GO
ALTER DATABASE [Nidan_Dev] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Nidan_Dev] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Nidan_Dev] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Nidan_Dev] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Nidan_Dev] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Nidan_Dev] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Nidan_Dev] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Nidan_Dev] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Nidan_Dev] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Nidan_Dev] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Nidan_Dev] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Nidan_Dev] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Nidan_Dev] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Nidan_Dev] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Nidan_Dev] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Nidan_Dev] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Nidan_Dev] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Nidan_Dev] SET RECOVERY FULL 
GO
ALTER DATABASE [Nidan_Dev] SET  MULTI_USER 
GO
ALTER DATABASE [Nidan_Dev] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Nidan_Dev] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Nidan_Dev] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Nidan_Dev] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Nidan_Dev] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Nidan_Dev', N'ON'
GO
USE [Nidan_Dev]
GO
/****** Object:  User [IIS APPPOOL\Nidan]    Script Date: 08/02/2017 5:54:53 PM ******/
CREATE USER [IIS APPPOOL\Nidan] FOR LOGIN [IIS APPPOOL\Nidan] WITH DEFAULT_SCHEMA=[db_accessadmin]
GO
/****** Object:  Table [dbo].[Absence]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Absence](
	[AbsenceId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelAbsenceEntitlementId] [int] NOT NULL,
	[AbsenceTypeId] [int] NOT NULL,
	[AbsenceStatusId] [int] NOT NULL,
	[AbsenceStatusByUser] [nvarchar](128) NULL,
	[AbsenceStatusDateTimeUtc] [datetime2](7) NULL,
	[Description] [nvarchar](max) NULL,
	[ReturnToWorkCompleted] [bit] NULL,
	[DoctorsNoteSupplied] [bit] NULL,
 CONSTRAINT [PK_Absence] PRIMARY KEY CLUSTERED 
(
	[AbsenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsenceDay]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsenceDay](
	[AbsenceDayId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsenceId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[AM] [bit] NOT NULL CONSTRAINT [DF_AbsenceDay_AM]  DEFAULT ((0)),
	[PM] [bit] NOT NULL CONSTRAINT [DF_AbsenceDay_PM]  DEFAULT ((0)),
	[Duration] [float] NOT NULL,
 CONSTRAINT [PK_AbsenceDay] PRIMARY KEY CLUSTERED 
(
	[AbsenceDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePeriod]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePeriod](
	[AbsencePeriodId] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_AbsencePeriod] PRIMARY KEY CLUSTERED 
(
	[AbsencePeriodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicy]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicy](
	[AbsencePolicyId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[WorkingPatternId] [int] NULL,
 CONSTRAINT [PK_AbsencePolicy] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicyEntitlement]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicyEntitlement](
	[AbsencePolicyEntitlementId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsenceTypeId] [int] NOT NULL,
	[FrequencyId] [int] NOT NULL,
	[Entitlement] [float] NOT NULL,
	[MaximumCarryForward] [float] NOT NULL,
	[IsUnplanned] [bit] NOT NULL,
	[IsPaid] [bit] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[HasEntitlement] [bit] NOT NULL,
 CONSTRAINT [PK_AbsencePolicyEntitlement] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyEntitlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicyPeriod]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicyPeriod](
	[AbsencePolicyPeriodId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[AbsencePeriodId] [int] NOT NULL,
 CONSTRAINT [PK_AbsencePolicyPeriod] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyPeriodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsenceStatus]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AbsenceStatus](
	[AbsenceStatusId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AbsenceStatus] PRIMARY KEY CLUSTERED 
(
	[AbsenceStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AbsenceType]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsenceType](
	[AbsenceTypeId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_AbsenceType] PRIMARY KEY CLUSTERED 
(
	[AbsenceTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Alert]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alert](
	[AlertId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Alert] PRIMARY KEY CLUSTERED 
(
	[AlertId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AreaOfInterest]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AreaOfInterest](
	[AreaOfInterestId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_AreaOfInterest] PRIMARY KEY CLUSTERED 
(
	[AreaOfInterestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Discriminator] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[OrganisationId] [int] NULL,
	[PersonnelId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsersAlertSchedule]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsersAlertSchedule](
	[AspnetUsersAlertScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[AspNetUsersId] [nvarchar](128) NOT NULL,
	[AlertId] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsersAlertSchedule] PRIMARY KEY CLUSTERED 
(
	[AspnetUsersAlertScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Building]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Building](
	[BuildingId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[OrganisationId] [int] NOT NULL,
	[SiteId] [int] NOT NULL,
	[Address1] [nvarchar](100) NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[BuildingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CasteCategory]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CasteCategory](
	[CasteCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Caste] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CasteCategory] PRIMARY KEY CLUSTERED 
(
	[CasteCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Centre]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Centre](
	[CentreId] [int] IDENTITY(1,1) NOT NULL,
	[CentreCode] [varchar](100) NULL,
	[Name] [varchar](500) NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Centre] PRIMARY KEY CLUSTERED 
(
	[CentreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Colour]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Colour](
	[ColourId] [int] NOT NULL,
	[Hex] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ColourId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Company]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanyBuilding]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyBuilding](
	[CompanyBuildingId] [int] IDENTITY(1,1) NOT NULL,
	[BuildingId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CompanyBuilding] PRIMARY KEY CLUSTERED 
(
	[CompanyBuildingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Course]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmergencyContact]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmergencyContact](
	[EmergencyContactId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[Relationship] [varchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Forenames] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[CountryId] [int] NULL,
	[Address1] [nvarchar](100) NULL,
	[Address2] [nvarchar](100) NULL,
	[Address3] [nvarchar](100) NULL,
	[Address4] [nvarchar](100) NULL,
	[Postcode] [nvarchar](12) NULL,
	[Telephone] [varchar](15) NOT NULL,
	[Mobile] [varchar](15) NULL,
 CONSTRAINT [PK_EmergencyContact] PRIMARY KEY CLUSTERED 
(
	[EmergencyContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employment]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employment](
	[EmploymentId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NULL,
	[TerminationDate] [datetime2](7) NULL,
	[BuildingId] [int] NOT NULL,
	[ReportsToPersonnelId] [int] NULL,
	[JobTitle] [nvarchar](100) NULL,
	[JobDescription] [nvarchar](max) NULL,
	[EndEmploymentReasonId] [int] NULL,
	[WorkingPatternId] [int] NULL,
	[PublicHolidayPolicyId] [int] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
 CONSTRAINT [PK_Employment] PRIMARY KEY CLUSTERED 
(
	[EmploymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmploymentDepartment]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmploymentDepartment](
	[EmploymentDepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[EmploymentId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EmploymentDepartment] PRIMARY KEY CLUSTERED 
(
	[EmploymentDepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmploymentTeam]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmploymentTeam](
	[EmploymentTeamId] [int] IDENTITY(1,1) NOT NULL,
	[EmploymentId] [int] NOT NULL,
	[TeamId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EmploymentTeam] PRIMARY KEY CLUSTERED 
(
	[EmploymentTeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Enquiry]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Enquiry](
	[EnquiryId] [int] IDENTITY(1,1) NOT NULL,
	[CandidateName] [varchar](500) NOT NULL,
	[ContactNo] [bigint] NOT NULL,
	[EmailId] [varchar](500) NULL,
	[Age] [int] NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[GuardianName] [varchar](500) NULL,
	[GuardianContactNo] [bigint] NULL,
	[OccupationId] [int] NOT NULL,
	[ReligionId] [int] NOT NULL,
	[CasteCategoryId] [int] NOT NULL,
	[Gender] [varchar](100) NOT NULL,
	[EducationalQualificationId] [int] NOT NULL,
	[YearOFPassOut] [varchar](100) NULL,
	[Marks] [varchar](100) NULL,
	[IntrestedCourseId] [int] NOT NULL,
	[HowDidYouKnowAboutId] [int] NOT NULL,
	[PreTrainingStatus] [varchar](100) NULL,
	[EmploymentStatus] [varchar](100) NULL,
	[Promotional] [varchar](100) NULL,
	[EnquiryDate] [date] NULL,
	[Place] [varchar](100) NOT NULL,
	[CounselledBy] [varchar](500) NOT NULL,
	[CourseOfferedId] [int] NOT NULL,
	[PreferTiming] [datetime] NULL,
	[Remarks] [varchar](max) NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[FollowUpDate] [date] NULL,
	[EnquiryStatus] [varchar](100) NULL,
	[EmployerName] [varchar](500) NULL,
	[EmployerContactNo] [varchar](50) NULL,
	[EmployerAddress] [varchar](max) NULL,
	[AnnualIncome] [int] NULL,
 CONSTRAINT [PK_Enquiry] PRIMARY KEY CLUSTERED 
(
	[EnquiryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Event]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[CreatedBy] [varchar](200) NULL,
	[CreatedDateTime] [datetime] NULL,
	[ApprovedBy] [int] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Event1] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FollowUp]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FollowUp](
	[FollowUpId] [int] IDENTITY(1,1) NOT NULL,
	[FollowUpDateTime] [datetime] NULL,
	[MobilizationId] [int] NULL,
	[EnquiryId] [int] NULL,
	[Remark] [nvarchar](max) NULL,
	[Closed] [bit] NULL,
	[ReadDateTime] [datetime] NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[Name] [varchar](500) NULL,
	[Mobile] [bigint] NULL,
	[IntrestedCourseId] [int] NOT NULL,
 CONSTRAINT [PK_FollowUp] PRIMARY KEY CLUSTERED 
(
	[FollowUpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Frequency]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Frequency](
	[FrequencyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Periods] [int] NOT NULL,
 CONSTRAINT [PK_Frequency] PRIMARY KEY CLUSTERED 
(
	[FrequencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Host]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Host](
	[HostId] [smallint] IDENTITY(1,1) NOT NULL,
	[HostName] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Host] PRIMARY KEY CLUSTERED 
(
	[HostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HowDidYouKnowAbout]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HowDidYouKnowAbout](
	[HowDidYouKnowAboutId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_HowDidYouKnowAboutUs] PRIMARY KEY CLUSTERED 
(
	[HowDidYouKnowAboutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Mobilization]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mobilization](
	[MobilizationId] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[InterestedCourseId] [int] NOT NULL,
	[QualificationId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[FollowUpDate] [date] NULL,
	[Remark] [varchar](max) NULL,
	[MobilizerStatus] [varchar](100) NULL,
	[StudentLocation] [varchar](500) NULL,
	[OtherInterestedCourse] [varchar](1000) NULL,
	[GeneratedDate] [date] NOT NULL,
	[MobilizationTypeId] [int] NOT NULL,
	[PersonnelId] [int] NULL,
 CONSTRAINT [PK_Mobilization] PRIMARY KEY CLUSTERED 
(
	[MobilizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MobilizationType]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MobilizationType](
	[MobilizationTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_MobilizationType] PRIMARY KEY CLUSTERED 
(
	[MobilizationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Occupation]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Occupation](
	[OccupationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Occupation] PRIMARY KEY CLUSTERED 
(
	[OccupationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Organisation]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organisation](
	[OrganisationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Organisation_1] PRIMARY KEY CLUSTERED 
(
	[OrganisationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Personnel]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Personnel](
	[PersonnelId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Forenames] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[DOB] [datetime2](7) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Address1] [nvarchar](100) NOT NULL,
	[Address2] [nvarchar](100) NULL,
	[Address3] [nvarchar](100) NULL,
	[Address4] [nvarchar](100) NULL,
	[Postcode] [nvarchar](12) NOT NULL,
	[Telephone] [varchar](15) NOT NULL,
	[Mobile] [varchar](15) NULL,
	[NINumber] [varchar](10) NOT NULL,
	[BankAccountNumber] [varchar](10) NULL,
	[BankSortCode] [varchar](6) NULL,
	[BankAccountName] [nvarchar](100) NULL,
	[BankAddress1] [nvarchar](100) NULL,
	[BankAddress2] [nvarchar](100) NULL,
	[BankAddress3] [nvarchar](100) NULL,
	[BankAddress4] [nvarchar](100) NULL,
	[BankPostcode] [nvarchar](12) NULL,
	[BankTelephone] [varchar](15) NULL,
	[Email] [varchar](256) NOT NULL,
	[CurrentEmploymentId] [int] NULL,
 CONSTRAINT [PK_Personnel] PRIMARY KEY CLUSTERED 
(
	[PersonnelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonnelAbsenceEntitlement]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonnelAbsenceEntitlement](
	[PersonnelAbsenceEntitlementId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[AbsencePolicyPeriodId] [int] NOT NULL,
	[AbsenceTypeId] [int] NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[Entitlement] [float] NULL,
	[CarriedOver] [float] NULL,
	[Used] [float] NULL,
	[Remaining] [float] NULL,
	[MaximumCarryForward] [float] NULL,
	[FrequencyId] [int] NOT NULL,
	[EmploymentId] [int] NOT NULL,
 CONSTRAINT [PK_PersonnelAbsenceEntitlement] PRIMARY KEY CLUSTERED 
(
	[PersonnelAbsenceEntitlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PublicHoliday]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicHoliday](
	[PublicHolidayId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PublicHolidayPolicyId] [int] NOT NULL,
 CONSTRAINT [PK_PublicHoliday] PRIMARY KEY CLUSTERED 
(
	[PublicHolidayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PublicHolidayPolicy]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicHolidayPolicy](
	[PublicHolidayPolicyId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_PublicHolidayPolicy] PRIMARY KEY CLUSTERED 
(
	[PublicHolidayPolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Qualification]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Qualification](
	[QualificationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Qualification] PRIMARY KEY CLUSTERED 
(
	[QualificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Religion]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Religion](
	[ReligionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Religion] PRIMARY KEY CLUSTERED 
(
	[ReligionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Site](
	[SiteId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CountryId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Site] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Team]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkingPattern]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkingPattern](
	[WorkingPatternId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_WorkingPattern] PRIMARY KEY CLUSTERED 
(
	[WorkingPatternId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkingPatternDay]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkingPatternDay](
	[WorkingPatternDayId] [int] IDENTITY(1,1) NOT NULL,
	[WorkingPatternId] [int] NOT NULL,
	[DayOfWeek] [smallint] NOT NULL,
	[AM] [bit] NOT NULL,
	[PM] [bit] NOT NULL,
 CONSTRAINT [PK_WorkingPatternDay] PRIMARY KEY CLUSTERED 
(
	[WorkingPatternDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[EnquirySearchField]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[EnquirySearchField]
AS 
SELECT 
E.EnquiryId,
E.CandidateName,
E.ContactNo,
E.EmailId,
E.Age,
E.Address,
E.GuardianName,
E.GuardianContactNo,
E.OccupationId,
E.ReligionId,
E.CasteCategoryId,
E.Gender,
E.EducationalQualificationId,
E.YearOFPassOut,
E.Marks,
E.IntrestedCourseId,
E.HowDidYouKnowAboutId,
E.PreTrainingStatus,
E.EmploymentStatus,
E.Promotional,
E.EnquiryDate,
E.Place,
E.CounselledBy,
E.CourseOfferedId,
E.PreferTiming,
E.Remarks,
E.CentreId,
E.OrganisationId,
E.FollowUpDate,
E.EnquiryStatus,
		ISNULL(E.CandidateName, '')+ISNULL(E.CounselledBy, '')+ISNULL(E.EmailId, '')+ISNULL(E.Address, '')+ISNULL(R.Name, '') + ISNULL(CONVERT(varchar,E.EnquiryDate, 101), '') + ISNULL(CONVERT(varchar,E.EnquiryDate, 103), '') + ISNULL(CONVERT(varchar,E.EnquiryDate, 105), '') + ISNULL(CONVERT(varchar,E.EnquiryDate, 126), '') + ISNULL(Q.Name, '') + ISNULL(E.Place, '') + CONVERT(varchar, E.ContactNo ) AS SearchField
FROM 
	Enquiry E  WITH (NOLOCK) left join Religion  R WITH (NOLOCK)
	on E.ReligionId = R.ReligionId join Course C WITH (NOLOCK)
	ON C.CourseId = E.IntrestedCourseId join Qualification Q WITH (NOLOCK)
	ON Q.QualificationId = E.EducationalQualificationId


GO
/****** Object:  View [dbo].[MobilizationSearchField]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[MobilizationSearchField]
AS 
SELECT 
		M.MobilizationId,
		M.EventId,
		M.OrganisationId,
		M.CentreId,
		M.Name,
		M.Mobile,
		M.InterestedCourseId,
		M.QualificationId,
		M.CreatedDate,
		M.FollowUpDate,
		M.Remark,
		M.MobilizerStatus,
		M.MobilizedBy,
		M.StudentLocation,
		M.OtherInterestedCourse,
		M.GeneratedDate,
		ISNULL(M.Name, '')+ISNULL(E.Name, '')+ISNULL(C.Name, '')+ISNULL(M.MobilizedBy, '')+ISNULL(M.StudentLocation, '') + ISNULL(CONVERT(varchar,M.GeneratedDate, 101), '') + ISNULL(CONVERT(varchar,GeneratedDate, 103), '') + ISNULL(CONVERT(varchar,GeneratedDate, 105), '') + ISNULL(CONVERT(varchar,GeneratedDate, 126), '') + ISNULL(StudentLocation, '') + ISNULL(Q.Name, '') + CONVERT(varchar, Mobile ) AS SearchField
FROM 
	Mobilization M  WITH (NOLOCK) left join Event E WITH (NOLOCK)
	on M.Eventid = E.EventId join Course C WITH (NOLOCK)
	ON C.CourseId = m.InterestedCourseId join Qualification Q WITH (NOLOCK)
	ON Q.QualificationId = M.QualificationId



GO
/****** Object:  View [dbo].[PersonnelSearchField]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[PersonnelSearchField]
AS 
SELECT 
		PersonnelId,
		OrganisationId,
		Title,
		Forenames,
		Surname,
		DOB,
		CountryId,
		Address1,
		Address2,
		Address3,
		Address4,
		Postcode,
		Telephone,
		Mobile,
		NINumber,
		BankAccountNumber,
		BankSortCode,
		BankAccountName,
		BankAddress1,
		BankAddress2,
		BankAddress3,
		BankAddress4,
		BankPostcode,
		BankTelephone,
		Email,
	
		ISNULL(Surname, '') + ISNULL(Forenames, '') + ISNULL(Surname, '') + ISNULL(CONVERT(varchar,DOB, 101), '') + ISNULL(CONVERT(varchar,DOB, 103), '') + ISNULL(CONVERT(varchar,DOB, 105), '') + ISNULL(CONVERT(varchar,DOB, 126), '') + ISNULL(EMail, '') + ISNULL(Postcode, '') + ISNULL(Mobile, '') AS SearchField
FROM 
	Personnel  WITH (NOLOCK)



GO
/****** Object:  View [dbo].[UserAuthorisationFilter]    Script Date: 08/02/2017 5:54:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserAuthorisationFilter]
AS 
SELECT 
	ROW_NUMBER() OVER(ORDER BY p.PersonnelId, ur.RoleId) AS Id,
	p.PersonnelId,
	u.Id AS AspNetUsersId, 
	u.OrganisationId,
	ur.RoleId,
	r.Name AS RoleName
FROM
	AspNetUsers u
INNER JOIN
	AspNetUserRoles ur
		ON u.Id = ur.UserId
INNER JOIN
	AspNetRoles r 
		on ur.RoleId = r.Id
LEFT JOIN
	Personnel p 
		ON u.PersonnelId = p.PersonnelId


GO
SET IDENTITY_INSERT [dbo].[Absence] ON 

INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (65, 4, 1, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-04 14:49:09.9854584' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (69, 4, 47, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:29:42.0016821' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (71, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:39:14.5242644' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (72, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:41:31.5815424' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (73, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:48:45.7573640' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (75, 4, 45, 2, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 12:00:05.8472758' AS DateTime2), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Absence] OFF
SET IDENTITY_INSERT [dbo].[AbsenceDay] ON 

INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (85, 4, 65, CAST(N'2017-01-04' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (89, 4, 69, CAST(N'2017-04-11' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (91, 4, 71, CAST(N'2017-01-16' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (92, 4, 72, CAST(N'2017-01-09' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (93, 4, 73, CAST(N'2017-01-10' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (95, 4, 75, CAST(N'2017-01-11' AS Date), 1, 1, 1)
SET IDENTITY_INSERT [dbo].[AbsenceDay] OFF
SET IDENTITY_INSERT [dbo].[AbsencePeriod] ON 

INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (18, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 4)
INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (19, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 4)
INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (20, CAST(N'2016-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4)
SET IDENTITY_INSERT [dbo].[AbsencePeriod] OFF
SET IDENTITY_INSERT [dbo].[AbsencePolicy] ON 

INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (11, 4, N'Permanent', 39)
INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (36, 4, N'General', 57)
INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (38, 4, N'Test General', 56)
SET IDENTITY_INSERT [dbo].[AbsencePolicy] OFF
SET IDENTITY_INSERT [dbo].[AbsencePolicyEntitlement] ON 

INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (16, 4, 3, 1, 10, 4, 1, 1, 11, 1)
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (33, 4, 2, 2, 10, 5, 0, 0, 11, 1)
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (40, 4, 3, 1, 15, 7, 0, 1, 38, 1)
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (46, 4, 3, 1, 12, 8, 1, 1, 36, 1)
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (50, 4, 2, 2, 3, 2, 1, 1, 36, 1)
SET IDENTITY_INSERT [dbo].[AbsencePolicyEntitlement] OFF
SET IDENTITY_INSERT [dbo].[AbsencePolicyPeriod] ON 

INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (15, 4, 11, 20)
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (29, 4, 38, 18)
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (44, 4, 36, 18)
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (45, 4, 36, 19)
SET IDENTITY_INSERT [dbo].[AbsencePolicyPeriod] OFF
SET IDENTITY_INSERT [dbo].[AbsenceStatus] ON 

INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (1, N'Unapproved')
INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (2, N'Approved')
INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (3, N'Declined')
SET IDENTITY_INSERT [dbo].[AbsenceStatus] OFF
SET IDENTITY_INSERT [dbo].[AbsenceType] ON 

INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (2, 4, N'Casual', 9)
INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (3, 4, N'Earned', 27)
INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (4, 4, N'Doctor''s Appointment', 27)
SET IDENTITY_INSERT [dbo].[AbsenceType] OFF
SET IDENTITY_INSERT [dbo].[AreaOfInterest] ON 

INSERT [dbo].[AreaOfInterest] ([AreaOfInterestId], [Name], [OrganisationId]) VALUES (0, N'IT', 4)
INSERT [dbo].[AreaOfInterest] ([AreaOfInterestId], [Name], [OrganisationId]) VALUES (1, N'ITEs', 4)
SET IDENTITY_INSERT [dbo].[AreaOfInterest] OFF
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'1', N'SuperAdmin', N'ApplicationRole')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'2', N'Admin', N'ApplicationRole')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'3', N'User', N'ApplicationRole')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'01b40bcf-c599-473c-854c-4effa911ec1e', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'032c1e43-fba7-47f8-a477-9a09dcf82daa', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'04ee5f8b-e018-4a17-aac9-b6019cfce276', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'06586b59-4429-436d-9b26-800d880483df', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0a6b1e2b-4ac3-414e-8738-9e5a4d9b6e36', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0b23dc04-f364-45ba-b98e-fb0a49f94656', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0f13e616-a95a-47a5-9995-60cbc592c3d1', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0f7a08f6-1a5a-4319-a5fd-1f2fa719634d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'10f5e02b-c762-4565-8b2d-0f43aa081319', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'116fc575-4a86-4f13-b997-fe9f32d305ff', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1700c28e-d342-4959-bb7d-641d66f6719f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1b4ec15b-abff-46c0-a029-df405b2d4ffb', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1ca4f2bf-dd06-44a4-aa09-2b4dcf5b4a79', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1f2db86c-81fb-4eec-9d5f-0c780eafb590', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20c83ae9-a47c-4122-8b00-2a14e98db983', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'246e2f76-68bd-486a-8468-c54851c87541', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'24b0530f-ce19-4004-be38-a6cc1533e322', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2992313b-87d5-4229-8c3a-6578d222e293', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2ac20a85-a6dc-4429-92e1-15b00f08adb8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2b9a1443-fa62-4cb0-aec7-b7b5770436ac', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2c4ebd78-f541-440c-b9de-fad81a0f5a98', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2d921f72-b892-4cca-b294-210592790854', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2f4ebcc1-5ff9-4f9f-a31d-66c47aee5894', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2fd4cd69-4a25-46e0-af8c-2ed5d28f610f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'30ee0b23-785a-4d06-a95d-0f7b6d9ce31f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'316f648b-6ca2-4d98-9f93-c7afdd943789', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'320ac667-ee90-48a2-9b53-fb9c10ec0d61', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'33bb0ae7-2832-4072-8622-fec97b97b71b', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'368eb845-84c0-4b41-a3fe-4b8e17566012', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'38279ad7-91c8-4968-932c-0a5a05ab495c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3deed64b-69ec-49fc-905f-a73cd5582f3c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'40ee8af2-4d7c-4a93-af2b-118d78db6b81', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'424193a9-7b3f-43cc-9806-b27db02c5db4', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'431aa089-ac08-48d6-b671-e1087f85bcb8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4741b301-d9dc-4c8e-b029-a8688a0a0308', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'475e52f8-bb3b-4834-ae84-17842b12b0c8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4836e102-343b-4c9f-ba96-00461f4893f3', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'491e3deb-c570-47f1-aec9-b649ac239db2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4cdce9f5-89a3-4680-a211-1c0913bf58bf', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'50b3a684-5599-4a40-9f0f-47a5c37e8e15', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'52abb99d-d48a-4d32-ba55-bbb89bece8de', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'552b29ce-8872-4f8c-b8dd-747ae4333e4e', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'55a1f00f-cd0b-491f-b04b-57803b0db161', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'58bfb3ef-4949-4d43-8c89-a1409d16a08a', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'594e3477-339d-4749-8b89-58d75936a640', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5f4dd0b1-b3e8-4203-bc10-1df868bf5963', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'648b8178-35bf-4223-8ebf-7649977683c7', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6ef120ae-6041-4314-86ee-884093da1a68', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'777e2ec6-d74a-4707-a1ef-16c96f73248d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'77ec2e78-ed30-4b70-8fdf-7498a3f85492', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7d585050-8a4a-4d9a-960b-2228875ddc46', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8157d325-2c95-4811-82b3-b215fd49afa4', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'817cad52-7b2e-4bf3-994d-2c9c91e03cd2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'81c6963a-e6b6-40f2-8ff7-ab17a033d95f', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'87731cf8-8a27-4efe-8f6a-7ed3b2b5f255', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'87856032-423b-4815-aeb8-69b7e4683a22', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'88450232-24c3-4cba-919b-7c1c4c64f4f2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8acf06ba-e517-4b6e-abcb-359024cc2ad9', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9126ad61-924c-4ec3-8eaf-05386fb9a999', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9349a8cd-5b5d-4ab5-80bf-9b178a0629cd', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'995a714c-8876-41ab-8e48-1c79b01d459f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9b923fee-8028-493a-b54d-666fb6397a75', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9bb0610e-788e-4dfc-93b6-82af4c016765', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a4110fcf-efe0-4055-986e-02e1d2affbc4', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a4a988b5-e38b-4c70-a20b-bed97a8db4cb', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a79cb6fc-1cba-4f32-96f9-e1e4e9890ee5', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aab6fc24-4f57-4de7-9979-3b790eef72c9', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ae397432-e4aa-44a6-80a6-dc9bea2a251e', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aed476a0-3739-44a0-bd2f-b11a3287689c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'afcf5153-7257-4d0e-9095-2d2286c0abbe', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'afdca75e-d51d-410b-abfc-a3fb0b61a198', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b38dc1bf-0691-4edf-9428-7b205a07f80d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b7ca56c6-e0b1-4d0c-8657-01ee818a377f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'baa66088-ea1b-43ab-b8b0-ee75523e613a', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bb141879-1336-4a91-8640-506a9d1f71bf', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bbe75a61-9216-4c97-8e5c-2a85ec3b6885', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c1a636b0-4939-4da5-8e76-bbb2c876d82b', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c2971d39-34ae-4165-89dc-78fedde57f81', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c42d62c2-1c0b-4f32-8c0f-c13ab60e3073', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c7ef57ec-c373-49bc-bbcb-f677b6dea483', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ca1a33e0-4455-484c-a494-2d6ee9921359', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ccd7d6ea-f514-40a8-9530-dd7744c5706c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cd588053-3088-4ad2-b26d-22b0822fe855', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cded29f3-f32f-4143-86b9-30cce601d2db', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ceddcad2-e6ab-4046-a109-11c1c8b5ffa3', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd9ceb6d0-4ade-4d87-ae3c-c829206620d5', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'db5f88be-4018-4647-8776-01e9cd07753a', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e2ae65fc-51f3-4d01-8c0c-063c4abd0da2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e3482627-f15f-4d8d-b347-572e78e41dae', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ea78e966-60fc-42d3-8fd2-68e826d1c56d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f1e97402-9a85-4dbc-8919-fcaf4318f7c7', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f6295d2a-12ee-4d1e-ab0b-707716a24d6a', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f72d0864-d72f-468b-940c-1a3deb3b3250', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fa4c3ca7-d0d6-4c09-9dd7-22af3c5d6abe', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fbe3dde3-c2da-4337-9667-0d363bfac5c5', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fdd6d9a2-1d33-4e76-a4e5-7988effb6d81', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fe861a67-db8e-401f-95f3-9142300a7e84', N'1')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'fe861a67-db8e-401f-95f3-9142300a7e84', N'superadmin@itsupportlimited.com', 1, N'AFAer9GyepjQA5csPi4JDIGT/8xTLOOISoUgP76GyRR4ovNixtJPGeYPJ4aoWAXhqw==', N'dac1f363-20c6-4593-a998-f35725ba23c9', NULL, 0, 0, NULL, 0, 0, N'superadmin@itsupportlimited.com', NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'f6295d2a-12ee-4d1e-ab0b-707716a24d6a', N'admin1@itsupportlimited.com', 1, N'AKx/BlAAgt0InFnzYZGtOlEmZLDyeRPCG8dT9pQF6EHLo5tBitvfQVUdE27RXmiZ6Q==', N'62873593-517e-4f95-9f64-0490e940528a', NULL, 0, 0, NULL, 0, 0, N'admin1@itsupportlimited.com', 1, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'24b0530f-ce19-4004-be38-a6cc1533e322', N'admin2@itsupportlimited.com', 1, N'ACVfIh0mQ5oH9pdcSc6ERNl7qQCkqRoD7QRygwJbfypaJn0kgM1gT14pb94Zimmi2g==', N'e34fdba4-6bec-417f-923f-8d95dda829b2', NULL, 0, 0, NULL, 0, 0, N'admin2@itsupportlimited.com', 2, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'afcf5153-7257-4d0e-9095-2d2286c0abbe', N'employee@itsupportlimited.com', 1, N'APKaRU8mmaEDb4qhGZtULX9+BL7P3egWUXbAmBLNaWdRzsJT0CIk+heD4A7sWhp/sw==', N'cf421afd-9c38-457c-a6af-c521e1d602d9', NULL, 0, 0, NULL, 0, 0, N'employee@itsupportlimited.com', NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'81c6963a-e6b6-40f2-8ff7-ab17a033d95f', N'admindevuk@itsupportlimited.com', 1, N'AOZ7eoPANrypxjGJqhmnnz6qbbgFbu4Jv1Wi2hvT+v1R6xkP9cvS5PVG6AdYH3f+ow==', N'87edef0d-7230-4a5e-81a5-00e45867c9b7', NULL, 0, 0, NULL, 0, 0, N'admindevuk@itsupportlimited.com', 3, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'baa66088-ea1b-43ab-b8b0-ee75523e613a', N'admindevmumbai@nidantech.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'2638a07d-1d70-4d9d-aea8-9fa592ebd519', NULL, 0, 0, NULL, 0, 0, N'admindevmumbai@nidantech.com', 4, 20)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'cded29f3-f32f-4143-86b9-30cce601d2db', N'boss@hr.com', 0, N'AH0vO+3MP8kkdVm8IoZS19v5APLypj2uwHMLSBA1Xg+cxyk8G/S3aCz/fdoJx9199Q==', N'88943326-3aac-4de3-9952-aef532cb151b', NULL, 0, 0, NULL, 1, 0, N'boss@hr.com', 1, 3)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'4836e102-343b-4c9f-ba96-00461f4893f3', N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 0, N'ACW3/ceaJjW9e/oT2nxn9v/Q/FQLglKBTSEXAEf6GtbX831WzerA27uYY/arFe1GPw==', N'cbfb458c-0f8d-4bf8-883d-0e46c5c4426b', NULL, 0, 0, NULL, 1, 0, N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 4, 20)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'd9ceb6d0-4ade-4d87-ae3c-c829206620d5', N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', 0, N'AFEVc/Uq8gzgcuTE6uu4EgmUacvJ6yn4lMPXbQEPWxYSCbfQXzLozvx1THt0RZZBSw==', N'f0d27bfc-9683-4dfc-8bb4-9a8353c3ebe9', NULL, 0, 0, NULL, 1, 0, N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', 4, 21)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'88450232-24c3-4cba-919b-7c1c4c64f4f2', N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', 0, N'ABI2FZg+m6jGqaF+a9PzyRA0NtNQJvQFyrvpnyCqNHNlKgKAo78ZTsmGYtZD2+dU3w==', N'd29730e8-04fe-4e86-be51-b6de06e173db', NULL, 0, 0, NULL, 1, 0, N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', 4, 22)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'1b4ec15b-abff-46c0-a029-df405b2d4ffb', N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', 0, N'AKZSMVcBzYBL5MvtUqrlWLei3szf+J8rSyAiPKbTScYZIkf00qT7mdY+P249RKHj1Q==', N'6bdbe6e5-2109-4d58-b54c-e4212315465d', NULL, 0, 0, NULL, 1, 0, N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', 4, 23)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'20c83ae9-a47c-4122-8b00-2a14e98db983', N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', 0, N'AKEElUtJj4jzXaVb5qcqf7xo+Ls2NTE87DPT9idHHzXfB6ugj441QFSUBcRjAALkSA==', N'19e19041-015f-45d4-a2dd-5c486e2b3736', NULL, 0, 0, NULL, 1, 0, N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', 4, 24)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'424193a9-7b3f-43cc-9806-b27db02c5db4', N'sunjayp88456@gmail.com', 0, N'APXT4xqBxCurHbok+PAUdMusq3T/p/xzPmveyktk2rArdB839VKgIYuO5kOlJKYA6g==', N'47e90459-e1cf-41b2-a0b4-e88cc4f5266b', NULL, 0, 0, NULL, 1, 0, N'sunjayp88456@gmail.com', 4, 13)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'9349a8cd-5b5d-4ab5-80bf-9b178a0629cd', N'panontonganm@andersongroup.uk.com', 0, N'AHb5jEpgZ7ShIv8B2Zv4FAn+2lgmWPln9RtYpw1xDx0Ey+DhYZHWQa3O1hbqzeGR9Q==', N'1108f492-9cba-4934-b5fb-652b97e11f90', NULL, 0, 0, NULL, 1, 0, N'panontonganm@andersongroup.uk.com', 1, 13)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'db5f88be-4018-4647-8776-01e9cd07753a', N'johhpaulc@andersongroup.uk.com', 0, N'AM11d49o06Uwshg0Hpv2rCz+vijUPCc/+nnPLyZE/qgvsaSO1NP1i0sAmUvmTVgNSQ==', N'904bfac7-a8bc-48a3-a551-7fa0e779b464', NULL, 0, 0, NULL, 1, 0, N'johhpaulc@andersongroup.uk.com', 1, 14)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'aed476a0-3739-44a0-bd2f-b11a3287689c', N'kristineg@andersongroup.uk.com', 0, N'APhV2jacwogv2QAq3UrhGLgA8lt/2gdQisiXdywnniGP5ghSA2aa09P1mT/WbM39gQ==', N'4fbc5e0a-e3d2-4622-bd35-04a8502f5268', NULL, 0, 0, NULL, 1, 0, N'kristineg@andersongroup.uk.com', 1, 15)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'06586b59-4429-436d-9b26-800d880483df', N'dev@andersongroup.uk.com', 0, N'ACLi7xxARxrTXxaCT/JIfbHKp/JGdpx/UHpyBFUVpbxMADpVgUMJSNBTddvqvG6dQw==', N'e56d3f92-2be7-4ecf-8a0f-f6118507987a', NULL, 0, 0, NULL, 1, 0, N'christophers@andersongroup.uk.com', 1, 16)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'ccd7d6ea-f514-40a8-9530-dd7744c5706c', N'dikshas@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'2ddce434-0ca5-4fa4-ae56-e49b62937034', NULL, 0, 0, NULL, 1, 0, N'dikshas@andersongroup.uk.com', 4, 16)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'77ec2e78-ed30-4b70-8fdf-7498a3f85492', N'67f677f3-a905-483e-afd9-b3932e14e8ba@hr.com', 0, N'ANwvgwTLoftcqxSF4dsBMzOfwYLOTpMOoP+N57CfGFndV18O5rSsA/Jp32ej2dzakA==', N'c5549f22-06e2-4870-9cb8-65b062d5b575', NULL, 0, 0, NULL, 1, 0, N'67f677f3-a905-483e-afd9-b3932e14e8ba@hr.com', 4, 14)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'817cad52-7b2e-4bf3-994d-2c9c91e03cd2', N'pankajc1@andersongroup.uk.com', 0, N'APIIejJ9I2pM84fLCCOuM+4DUSDGZuFyN42kQq46lSNk+lWVybANRPyNlLCLVyrvUQ==', N'7a1cdaa8-6e74-431e-ba28-63ee84ab43a7', NULL, 0, 0, NULL, 1, 0, N'pankajc1@andersongroup.uk.com', 4, 15)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId]) VALUES (N'a4a988b5-e38b-4c70-a20b-bed97a8db4cb', N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', 0, N'AFI8mkZeZf9zGkVljOewgYDJWV3tFDJ63H/OqR5LGIX6gjoAZbotFUG8V2ATfHlOAA==', N'3d770f21-d1c7-44a7-a221-11e5cbcfa887', NULL, 0, 0, NULL, 1, 0, N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', 4, 25)
SET IDENTITY_INSERT [dbo].[Building] ON 

INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (1, N'PankajBuilding', 4, 12, N'Mumbai')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (2, N'PankajBuilding2', 4, 13, N'Mumbai2')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (3, N'PankajBuilding3', 4, 12, N'Mumbai3')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (4, N'PankajBuilding4', 4, 14, N'TestBuilding')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (5, N'test1building', 4, 12, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (7, N't2building', 4, 12, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (8, N'test new', 4, 16, NULL)
SET IDENTITY_INSERT [dbo].[Building] OFF
SET IDENTITY_INSERT [dbo].[CasteCategory] ON 

INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (1, N'SC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (2, N'ST', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (3, N'OBC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (4, N'MBC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (5, N'GEN', 4)
SET IDENTITY_INSERT [dbo].[CasteCategory] OFF
SET IDENTITY_INSERT [dbo].[Centre] ON 

INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [OrganisationId]) VALUES (1, N'thane', N'nest thane', 4)
SET IDENTITY_INSERT [dbo].[Centre] OFF
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (1, N'ff8000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (2, N'FF0000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (3, N'808080')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (4, N'708090')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (5, N'000000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (6, N'FFFFE0')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (7, N'FFD700')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (8, N'FFC0CB')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (9, N'FF69B4')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (10, N'FFA07A')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (11, N'FA8072')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (12, N'DC143C')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (13, N'B22222')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (14, N'FF0000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (15, N'FF4500')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (16, N'FF8C00')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (17, N'FFA500')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (18, N'DEB887')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (19, N'F4A460')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (20, N'B8860B')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (21, N'CD853F')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (22, N'8B4513')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (23, N'A52A2A')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (24, N'800000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (25, N'556B2F')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (26, N'6B8E23')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (27, N'32CD32')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (28, N'00FF00')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (29, N'00FF7F')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (30, N'008000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (31, N'006400')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (32, N'00FFFF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (33, N'E0FFFF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (34, N'AFEEEE')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (35, N'40E0D0')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (36, N'20B2AA')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (37, N'008080')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (38, N'B0C4DE')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (39, N'87CEEB')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (40, N'00BFFF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (41, N'1E90FF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (42, N'0000FF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (43, N'000080')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (44, N'DDA0DD')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (45, N'EE82EE')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (46, N'FF00FF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (47, N'9400D3')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (48, N'800080')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (49, N'4B0082')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (50, N'6A5ACD')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (51, N'6699CC')
SET IDENTITY_INSERT [dbo].[Company] ON 

INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (7, N'ITSK DS', 4, 1)
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (8, N'PankajCompany', 4, 45)
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (11, N'Test1', 4, 41)
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (13, N'test12345', 4, 17)
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (14, N'Test123454', 4, 48)
SET IDENTITY_INSERT [dbo].[Company] OFF
SET IDENTITY_INSERT [dbo].[CompanyBuilding] ON 

INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (3, 2, 8, 4)
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (4, 3, 8, 4)
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (10, 5, 8, 4)
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (12, 1, 7, 4)
SET IDENTITY_INSERT [dbo].[CompanyBuilding] OFF
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (24, N'PankajCountry', 4)
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (25, N'PankajCountry2', 4)
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (29, N'Test', 4)
SET IDENTITY_INSERT [dbo].[Country] OFF
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId]) VALUES (1, N'MIS', 4)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId]) VALUES (2, N'.Net', 4)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId]) VALUES (3, N'Java', 4)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId]) VALUES (4, N'OST', 4)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId]) VALUES (5, N'Hardware & Networking', 4)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId]) VALUES (6, N'Logistics', 4)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId]) VALUES (7, N'Financial Accounting', 4)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId]) VALUES (8, N'Others', 4)
SET IDENTITY_INSERT [dbo].[Course] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentId], [Name], [OrganisationId], [ColourId]) VALUES (24, N'IT', 4, 19)
INSERT [dbo].[Department] ([DepartmentId], [Name], [OrganisationId], [ColourId]) VALUES (25, N'Testing', 4, 32)
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[EmergencyContact] ON 

INSERT [dbo].[EmergencyContact] ([EmergencyContactId], [OrganisationId], [PersonnelId], [Relationship], [Title], [Forenames], [Surname], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile]) VALUES (2, 4, 20, N'Friend', N'mr', N'sanjay', N'prajapati', 25, N'krishna Paradise1', NULL, NULL, NULL, NULL, N'98213113344', NULL)
SET IDENTITY_INSERT [dbo].[EmergencyContact] OFF
SET IDENTITY_INSERT [dbo].[Employment] ON 

INSERT [dbo].[Employment] ([EmploymentId], [OrganisationId], [PersonnelId], [StartDate], [EndDate], [TerminationDate], [BuildingId], [ReportsToPersonnelId], [JobTitle], [JobDescription], [EndEmploymentReasonId], [WorkingPatternId], [PublicHolidayPolicyId], [AbsencePolicyId], [CompanyId]) VALUES (2, 4, 20, CAST(N'2016-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-01-06 00:00:00.0000000' AS DateTime2), NULL, 5, NULL, N'Test', N'Test', NULL, 56, 30, 38, 8)
INSERT [dbo].[Employment] ([EmploymentId], [OrganisationId], [PersonnelId], [StartDate], [EndDate], [TerminationDate], [BuildingId], [ReportsToPersonnelId], [JobTitle], [JobDescription], [EndEmploymentReasonId], [WorkingPatternId], [PublicHolidayPolicyId], [AbsencePolicyId], [CompanyId]) VALUES (6, 4, 21, CAST(N'2016-10-10 00:00:00.0000000' AS DateTime2), NULL, NULL, 5, NULL, N'Test', N'Test', NULL, 57, 30, 36, 8)
SET IDENTITY_INSERT [dbo].[Employment] OFF
SET IDENTITY_INSERT [dbo].[EmploymentDepartment] ON 

INSERT [dbo].[EmploymentDepartment] ([EmploymentDepartmentId], [EmploymentId], [DepartmentId], [OrganisationId]) VALUES (1, 2, 24, 4)
INSERT [dbo].[EmploymentDepartment] ([EmploymentDepartmentId], [EmploymentId], [DepartmentId], [OrganisationId]) VALUES (2, 2, 25, 4)
SET IDENTITY_INSERT [dbo].[EmploymentDepartment] OFF
SET IDENTITY_INSERT [dbo].[EmploymentTeam] ON 

INSERT [dbo].[EmploymentTeam] ([EmploymentTeamId], [EmploymentId], [TeamId], [OrganisationId]) VALUES (1, 2, 1, 4)
SET IDENTITY_INSERT [dbo].[EmploymentTeam] OFF
SET IDENTITY_INSERT [dbo].[Enquiry] ON 

INSERT [dbo].[Enquiry] ([EnquiryId], [CandidateName], [ContactNo], [EmailId], [Age], [Address], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOFPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [Place], [CounselledBy], [CourseOfferedId], [PreferTiming], [Remarks], [CentreId], [OrganisationId], [FollowUpDate], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome]) VALUES (1, N'Vijay Raut', 8989898, N'63e8752d-84bb-4fa3-a7ce-d263bc9416fa@hr.com', 24, N'KALEKAR CHAWL ONGC BLDG,12/13/3 FLR,DHARAVI,  SANT ROHIDAS MARG', NULL, 123, 1, 6, 1, N'Female', 1, NULL, NULL, 1, 1, NULL, NULL, NULL, CAST(N'2017-01-28' AS Date), N'Thane', N'Deepali', 1, NULL, NULL, 1, 4, CAST(N'2017-01-28' AS Date), NULL, NULL, NULL, NULL, 100000)
INSERT [dbo].[Enquiry] ([EnquiryId], [CandidateName], [ContactNo], [EmailId], [Age], [Address], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOFPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [Place], [CounselledBy], [CourseOfferedId], [PreferTiming], [Remarks], [CentreId], [OrganisationId], [FollowUpDate], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome]) VALUES (2, N'Vijay Test', 351454, N'0871e154-1879-44b5-b067-3cbf7f608cc6@hr.com', 24, N'KALEKAR CHAWL ONGC BLDG,12/13/3 FLR,DHARAVI,  SANT ROHIDAS MARG', NULL, 123, 1, 1, 1, N'Female', 1, NULL, NULL, 1, 1, NULL, NULL, NULL, CAST(N'2017-01-28' AS Date), N'Thane', N'Deepali', 1, NULL, NULL, 1, 4, CAST(N'2017-01-28' AS Date), NULL, NULL, NULL, NULL, 100000)
INSERT [dbo].[Enquiry] ([EnquiryId], [CandidateName], [ContactNo], [EmailId], [Age], [Address], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOFPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [Place], [CounselledBy], [CourseOfferedId], [PreferTiming], [Remarks], [CentreId], [OrganisationId], [FollowUpDate], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome]) VALUES (3, N'Poonam Shete', 9814256423, N'poonamsp@gmail.com', 21, N'Koperkhairane', N'Anili Shete', 7845123698, 1, 1, 5, N'Female', 3, N'2015', N'50', 1, 8, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-02-05' AS Date), N'Thane', N'Deepali', 1, NULL, N'after one week', 1, 4, CAST(N'2017-02-03' AS Date), NULL, NULL, NULL, NULL, 100000)
SET IDENTITY_INSERT [dbo].[Enquiry] OFF
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (3, N'Seminar', N'Amit Sir', CAST(N'2016-11-05 00:00:00.000' AS DateTime), 1, 4, 1)
SET IDENTITY_INSERT [dbo].[Event] OFF
SET IDENTITY_INSERT [dbo].[FollowUp] ON 

INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (1, CAST(N'2017-01-23 00:00:00.000' AS DateTime), 2008, NULL, N'Follow Up Update', NULL, NULL, CAST(N'2017-01-21 15:14:54.000' AS DateTime), 4, 1, N'Follow Up', 9870754355, 2)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (2, CAST(N'2017-01-21 00:00:00.000' AS DateTime), 2009, NULL, N'Shraddha Follow Up', NULL, NULL, CAST(N'2017-01-21 15:16:27.247' AS DateTime), 4, 1, N'Shraddha Follow Up', 9870754355, 2)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (1002, CAST(N'2017-01-26 00:00:00.000' AS DateTime), 2, NULL, N'-', NULL, NULL, CAST(N'2017-01-24 12:46:16.800' AS DateTime), 4, 1, N'Shraddha', 9870754355, 2)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (1003, CAST(N'2017-01-26 00:00:00.000' AS DateTime), 3, NULL, N'will come', NULL, NULL, CAST(N'2017-01-24 16:01:50.143' AS DateTime), 4, 1, N'Vijay Raut', 9773606038, 2)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (1004, CAST(N'2017-02-15 00:00:00.000' AS DateTime), 4, NULL, N'yes', NULL, NULL, CAST(N'2017-01-24 19:01:58.000' AS DateTime), 4, 1, N'Shr', 9870754355, 6)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (1005, CAST(N'2017-01-28 00:00:00.000' AS DateTime), NULL, 2, NULL, NULL, NULL, CAST(N'2017-01-28 16:18:04.317' AS DateTime), 4, 1, N'Vijay Test', 351454, 1)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (1006, CAST(N'2017-02-08 00:00:00.000' AS DateTime), 8, NULL, NULL, NULL, NULL, CAST(N'2017-01-31 14:02:27.000' AS DateTime), 4, 1, N'Shraddha', 9870754355, 1)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (1007, CAST(N'2017-02-02 00:00:00.000' AS DateTime), 9, NULL, NULL, NULL, NULL, CAST(N'2017-01-31 14:03:01.167' AS DateTime), 4, 1, N'Shraddha123', 9870754355, 1)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (1008, CAST(N'2017-02-02 00:00:00.000' AS DateTime), 10, NULL, NULL, NULL, NULL, CAST(N'2017-01-31 14:09:45.820' AS DateTime), 4, 1, N'yogini', 9870754355, 1)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (2006, CAST(N'2017-02-05 00:00:00.000' AS DateTime), 1002, NULL, N'She will decide & let us know', NULL, NULL, CAST(N'2017-02-03 14:12:39.653' AS DateTime), 4, 1, N'Poonam Anili Shete', 9814256423, 1)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Name], [Mobile], [IntrestedCourseId]) VALUES (2007, CAST(N'2017-02-10 00:00:00.000' AS DateTime), NULL, NULL, N'after one week', NULL, NULL, CAST(N'2017-02-03 14:29:25.000' AS DateTime), 4, 1, N'Poonam Anili Shete', 9814256423, 1)
SET IDENTITY_INSERT [dbo].[FollowUp] OFF
SET IDENTITY_INSERT [dbo].[Frequency] ON 

INSERT [dbo].[Frequency] ([FrequencyId], [Name], [Periods]) VALUES (1, N'Yearly', 1)
INSERT [dbo].[Frequency] ([FrequencyId], [Name], [Periods]) VALUES (2, N'Quarterly', 2)
SET IDENTITY_INSERT [dbo].[Frequency] OFF
SET IDENTITY_INSERT [dbo].[Host] ON 

INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (1, N'hr-uat', 1)
INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (2, N'org2-hr-uat', 2)
INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (4, N'org3-hr-uat', 3)
INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (6, N'org4-hr-uat', 4)
INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (7, N'localhost', 4)
INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (8, N'org1-hr-uat', 1)
INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (9, N'', 4)
SET IDENTITY_INSERT [dbo].[Host] OFF
SET IDENTITY_INSERT [dbo].[HowDidYouKnowAbout] ON 

INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (1, N'Walk-In', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (2, N'Tele-In', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (3, N'Banner', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (4, N'News Paper', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (5, N'Reference', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (6, N'Internet', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (7, N'Pamphlet', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (8, N'Event', 4)
SET IDENTITY_INSERT [dbo].[HowDidYouKnowAbout] OFF
SET IDENTITY_INSERT [dbo].[Mobilization] ON 

INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1, 3, 4, 1, N'Shraddha', 9870754355, 1, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (2, 3, 4, 1, N'vijay', 9870754355, 1, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 2, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (3, 3, 4, 1, N'Apurva Khaire', 9870754355, 1, 1, CAST(N'2017-02-03' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (4, 3, 4, 1, N'Shubham', 9870754355, 3, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (5, 3, 4, 1, N'Neha', 9870754355, 6, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (6, 3, 4, 1, N'Shraddha', 9870754355, 1, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (7, 3, 4, 1, N'Shraddha', 9870754355, 1, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (8, 3, 4, 1, N'Shraddha', 9870754355, 1, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (9, 3, 4, 1, N'Shraddha123', 9870754355, 1, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (10, 3, 4, 1, N'yogini', 9870754355, 1, 1, CAST(N'2017-01-31' AS Date), CAST(N'2017-02-02' AS Date), NULL, N'Open', NULL, NULL, CAST(N'2017-01-31' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1002, 3, 4, 1, N'Poonam Anili Shete', 9814256423, 1, 3, CAST(N'2017-02-03' AS Date), CAST(N'2017-02-05' AS Date), N'She will decide & let us know', N'Open', N'Koperkhairane', NULL, CAST(N'2017-02-03' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1005, 3, 4, 1, N'Ramesh', 9870245680, 8, 1, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'thane', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1006, 3, 4, 1, N'Suresh', 8702458790, 8, 2, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'sion', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1007, 3, 4, 1, N'Hema', 7895425481, 8, 3, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'belapur', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1008, 3, 4, 1, N'Reshma', 8715724520, 8, 5, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'vashi', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1009, 3, 4, 1, N'Mahesh', 9714725415, 8, 6, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'mulund', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1010, 3, 4, 1, N'Ramesh', 9870245680, 8, 1, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'thane', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1011, 3, 4, 1, N'Suresh', 8702458790, 8, 2, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'sion', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1012, 3, 4, 1, N'Hema', 7895425481, 8, 3, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'belapur', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1013, 3, 4, 1, N'Reshma', 8715724520, 8, 5, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'vashi', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1014, 3, 4, 1, N'Mahesh', 9714725415, 8, 6, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'mulund', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1015, 3, 4, 1, N'Ramesh', 9870245680, 8, 1, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'thane', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1016, 3, 4, 1, N'Suresh', 8702458790, 8, 2, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'sion', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1017, 3, 4, 1, N'Hema', 7895425481, 8, 3, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'belapur', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1018, 3, 4, 1, N'Reshma', 8715724520, 8, 5, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'vashi', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1019, 3, 4, 1, N'Mahesh', 9714725415, 8, 6, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'mulund', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1020, 3, 4, 1, N'Ramesh', 9870245680, 8, 1, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'thane', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1021, 3, 4, 1, N'Suresh', 8702458790, 8, 2, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'sion', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1022, 3, 4, 1, N'Hema', 7895425481, 8, 3, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'belapur', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1023, 3, 4, 1, N'Reshma', 8715724520, 8, 5, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'vashi', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1024, 3, 4, 1, N'Mahesh', 9714725415, 8, 6, CAST(N'2017-02-04' AS Date), NULL, NULL, NULL, N'mulund', NULL, CAST(N'2017-02-04' AS Date), 3, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1027, 3, 4, 1, N'Ramesh', 9870245680, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'thane', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1028, 3, 4, 1, N'Suresh', 8702458790, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'sion', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1029, 3, 4, 1, N'Hema', 7895425481, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'belapur', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1030, 3, 4, 1, N'Reshma', 8715724520, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'vashi', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1031, 3, 4, 1, N'Mahesh', 9714725415, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'mulund', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1032, 3, 4, 1, N'Ramesh', 9870245680, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'thane', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1033, 3, 4, 1, N'Suresh', 8702458790, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'sion', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1034, 3, 4, 1, N'Hema', 7895425481, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'belapur', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1035, 3, 4, 1, N'Reshma', 8715724520, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'vashi', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [CentreId], [Name], [Mobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId]) VALUES (1036, 3, 4, 1, N'Mahesh', 9714725415, 8, 11, CAST(N'2017-02-07' AS Date), NULL, NULL, NULL, N'mulund', NULL, CAST(N'2017-02-07' AS Date), 1, 20)
SET IDENTITY_INSERT [dbo].[Mobilization] OFF
SET IDENTITY_INSERT [dbo].[MobilizationType] ON 

INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (1, N'Walk-In', 4)
INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (2, N'Telephonic', 4)
INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (3, N'Event', 4)
SET IDENTITY_INSERT [dbo].[MobilizationType] OFF
SET IDENTITY_INSERT [dbo].[Occupation] ON 

INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (1, N'Business', 4)
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (2, N'Govt-Employee', 4)
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (3, N'Farmer', 4)
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (4, N'Doctor', 4)
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (5, N'Other', 4)
SET IDENTITY_INSERT [dbo].[Occupation] OFF
SET IDENTITY_INSERT [dbo].[Organisation] ON 

INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (1, N'Fynn Holdings')
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (2, N'Test Org 2')
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (3, N'Dev UK Organisation')
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (4, N'Dev Mumbai Organisation')
SET IDENTITY_INSERT [dbo].[Organisation] OFF
SET IDENTITY_INSERT [dbo].[Personnel] ON 

INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId]) VALUES (20, 4, N'Mr', N'TEst', N'Test', CAST(N'2017-01-04 00:00:00.0000000' AS DateTime2), 24, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 2)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId]) VALUES (21, 4, N'Mr', N'Abc', N'B', CAST(N'2017-01-05 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId]) VALUES (22, 4, N'Mr', N'x', N'z', CAST(N'2017-01-12 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId]) VALUES (23, 4, N'Mr', N'test1', N'B', CAST(N'2017-01-12 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId]) VALUES (24, 4, N'Mr', N'Vijay', N'Raut', CAST(N'1993-01-27 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId]) VALUES (25, 4, N'Mr', N'Nidan', N'B', CAST(N'2017-02-04 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', NULL)
SET IDENTITY_INSERT [dbo].[Personnel] OFF
SET IDENTITY_INSERT [dbo].[PersonnelAbsenceEntitlement] ON 

INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (1, 4, 20, 29, 3, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 15, 0, 1, 14, 7, 1, 2)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (43, 4, 21, 44, 3, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 5.5, 0, 3, 2.5, 8, 1, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (44, 4, 21, 44, 2, CAST(N'2016-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 2.5, 0, 0, 2.5, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (45, 4, 21, 44, 2, CAST(N'2017-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 3, 0, 1, 2, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (46, 4, 21, 44, NULL, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, 0, 1, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (47, 4, 21, 45, 3, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 12, 0, 1, 11, 8, 1, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (48, 4, 21, 45, 2, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-06-30 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (49, 4, 21, 45, 2, CAST(N'2017-07-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-09-30 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (50, 4, 21, 45, 2, CAST(N'2017-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-12-31 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (51, 4, 21, 45, 2, CAST(N'2018-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (52, 4, 21, 45, NULL, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, 0, 1, 6)
SET IDENTITY_INSERT [dbo].[PersonnelAbsenceEntitlement] OFF
SET IDENTITY_INSERT [dbo].[PublicHoliday] ON 

INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (18, N'Guru', CAST(N'2017-02-23 00:00:00.0000000' AS DateTime2), 4, 4)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (25, N'Test', CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4, 4)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (42, N'Test1', CAST(N'2016-12-30 00:00:00.0000000' AS DateTime2), 4, 4)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (51, N'Guru', CAST(N'2017-02-23 00:00:00.0000000' AS DateTime2), 4, 30)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (52, N'Test', CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4, 30)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (53, N'Test1', CAST(N'2016-12-30 00:00:00.0000000' AS DateTime2), 4, 30)
SET IDENTITY_INSERT [dbo].[PublicHoliday] OFF
SET IDENTITY_INSERT [dbo].[PublicHolidayPolicy] ON 

INSERT [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId], [OrganisationId], [Name]) VALUES (4, 4, N'Test Policy')
INSERT [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId], [OrganisationId], [Name]) VALUES (30, 4, N'Test Policy 10:51:30')
SET IDENTITY_INSERT [dbo].[PublicHolidayPolicy] OFF
SET IDENTITY_INSERT [dbo].[Qualification] ON 

INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (1, N'SSC', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (2, N'HSC', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (3, N'Under Graduate', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (4, N'Graduate', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (5, N'Post Graduate', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (6, N'Masters', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (7, N'Diploma', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (9, N'BE', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (11, N'Others', 4)
SET IDENTITY_INSERT [dbo].[Qualification] OFF
SET IDENTITY_INSERT [dbo].[Religion] ON 

INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (1, N'Hindu', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (2, N'Muslim', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (3, N'Christen', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (4, N'Sikh', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (5, N'Jain', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (6, N'Buddha', 4)
SET IDENTITY_INSERT [dbo].[Religion] OFF
SET IDENTITY_INSERT [dbo].[Site] ON 

INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (12, N'PankajSite', 24, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (13, N'PankajSite2', 25, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (14, N'TestSite', 29, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (16, N'test', 29, 4)
SET IDENTITY_INSERT [dbo].[Site] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([TeamId], [Name], [OrganisationId], [ColourId]) VALUES (1, N'IT Team', 4, 36)
INSERT [dbo].[Team] ([TeamId], [Name], [OrganisationId], [ColourId]) VALUES (3, N'Testing Team', 4, 20)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[WorkingPattern] ON 

INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (28, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (29, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (30, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (31, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (32, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (33, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (34, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (35, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (36, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (37, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (38, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (39, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (40, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (41, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (42, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (43, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (44, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (45, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (46, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (47, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (48, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (49, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (50, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (51, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (52, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (53, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (54, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (55, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (56, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (57, 4)
SET IDENTITY_INSERT [dbo].[WorkingPattern] OFF
SET IDENTITY_INSERT [dbo].[WorkingPatternDay] ON 

INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (274, 33, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (275, 33, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (276, 33, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (277, 33, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (278, 33, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (279, 33, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (280, 33, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (281, 34, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (282, 34, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (283, 34, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (284, 34, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (285, 34, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (286, 34, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (287, 34, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (288, 35, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (289, 35, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (290, 35, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (291, 35, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (292, 35, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (293, 35, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (294, 35, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (295, 36, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (296, 36, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (297, 36, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (298, 36, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (299, 36, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (300, 36, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (301, 36, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (316, 37, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (317, 37, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (318, 37, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (319, 37, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (320, 37, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (321, 37, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (322, 37, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (323, 38, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (324, 38, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (325, 38, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (326, 38, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (327, 38, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (328, 38, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (329, 38, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (337, 39, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (338, 39, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (339, 39, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (340, 39, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (341, 39, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (342, 39, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (343, 39, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (344, 40, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (345, 40, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (346, 40, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (347, 40, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (348, 40, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (349, 40, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (350, 40, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (351, 41, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (352, 41, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (353, 41, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (354, 41, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (355, 41, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (356, 41, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (357, 41, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (358, 42, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (359, 42, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (360, 42, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (361, 42, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (362, 42, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (363, 42, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (364, 42, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (365, 43, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (366, 43, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (367, 43, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (368, 43, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (369, 43, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (370, 43, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (371, 43, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (372, 44, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (373, 44, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (374, 44, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (375, 44, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (376, 44, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (377, 44, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (378, 44, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (379, 45, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (380, 45, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (381, 45, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (382, 45, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (383, 45, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (384, 45, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (385, 45, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (386, 46, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (387, 46, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (388, 46, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (389, 46, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (390, 46, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (391, 46, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (392, 46, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (393, 47, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (394, 47, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (395, 47, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (396, 47, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (397, 47, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (398, 47, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (399, 47, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (400, 49, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (401, 48, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (402, 49, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (403, 48, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (404, 48, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (405, 49, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (406, 49, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (407, 48, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (408, 48, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (409, 49, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (410, 48, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (411, 49, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (412, 48, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (413, 49, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (414, 50, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (415, 50, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (416, 50, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (417, 50, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (418, 50, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (419, 50, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (420, 50, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (421, 51, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (422, 51, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (423, 51, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (424, 51, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (425, 51, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (426, 51, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (427, 51, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (428, 52, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (429, 52, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (430, 52, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (431, 52, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (432, 52, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (433, 52, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (434, 52, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (442, 53, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (443, 53, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (444, 53, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (445, 53, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (446, 53, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (447, 53, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (448, 53, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (449, 54, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (450, 54, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (451, 54, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (452, 54, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (453, 54, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (454, 54, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (455, 54, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (456, 55, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (457, 55, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (458, 55, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (459, 55, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (460, 55, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (461, 55, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (462, 55, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (463, 56, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (464, 56, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (465, 56, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (466, 56, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (467, 56, 5, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (468, 56, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (469, 56, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (470, 57, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (471, 57, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (472, 57, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (473, 57, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (474, 57, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (475, 57, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (476, 57, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[WorkingPatternDay] OFF
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_AbsenceStatus] FOREIGN KEY([AbsenceStatusId])
REFERENCES [dbo].[AbsenceStatus] ([AbsenceStatusId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_AbsenceStatus]
GO
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_Organisation]
GO
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_PersonnelAbsenceEntitlement] FOREIGN KEY([PersonnelAbsenceEntitlementId])
REFERENCES [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_PersonnelAbsenceEntitlement]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceDay_Absence] FOREIGN KEY([AbsenceId])
REFERENCES [dbo].[Absence] ([AbsenceId])
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [FK_AbsenceDay_Absence]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceDay_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [FK_AbsenceDay_Organisation]
GO
ALTER TABLE [dbo].[AbsencePeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePeriod_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePeriod] CHECK CONSTRAINT [FK_AbsencePeriod_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicy]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicy_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicy] CHECK CONSTRAINT [FK_AbsencePolicy_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicy]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicy_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[AbsencePolicy] CHECK CONSTRAINT [FK_AbsencePolicy_WorkingPattern]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_AbsencePolicy]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_AbsenceType] FOREIGN KEY([AbsenceTypeId])
REFERENCES [dbo].[AbsenceType] ([AbsenceTypeId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_AbsenceType]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_Frequency] FOREIGN KEY([FrequencyId])
REFERENCES [dbo].[Frequency] ([FrequencyId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_Frequency]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePeriod] FOREIGN KEY([AbsencePeriodId])
REFERENCES [dbo].[AbsencePeriod] ([AbsencePeriodId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePeriod]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePolicy]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_Organisation]
GO
ALTER TABLE [dbo].[AbsenceType]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceType_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[AbsenceType] CHECK CONSTRAINT [FK_AbsenceType_Colour]
GO
ALTER TABLE [dbo].[AbsenceType]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsenceType] CHECK CONSTRAINT [FK_AbsenceType_Organisation]
GO
ALTER TABLE [dbo].[AreaOfInterest]  WITH CHECK ADD  CONSTRAINT [FK_AreaOfInterest_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AreaOfInterest] CHECK CONSTRAINT [FK_AreaOfInterest_Organisation]
GO
ALTER TABLE [dbo].[AspNetUsersAlertSchedule]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsersAlertSchedule_Alert1] FOREIGN KEY([AlertId])
REFERENCES [dbo].[Alert] ([AlertId])
GO
ALTER TABLE [dbo].[AspNetUsersAlertSchedule] CHECK CONSTRAINT [FK_AspNetUsersAlertSchedule_Alert1]
GO
ALTER TABLE [dbo].[Building]  WITH CHECK ADD  CONSTRAINT [FK_Building_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Building] CHECK CONSTRAINT [FK_Building_Organisation]
GO
ALTER TABLE [dbo].[Building]  WITH CHECK ADD  CONSTRAINT [FK_Building_Site] FOREIGN KEY([SiteId])
REFERENCES [dbo].[Site] ([SiteId])
GO
ALTER TABLE [dbo].[Building] CHECK CONSTRAINT [FK_Building_Site]
GO
ALTER TABLE [dbo].[CasteCategory]  WITH CHECK ADD  CONSTRAINT [FK_CasteCategory_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CasteCategory] CHECK CONSTRAINT [FK_CasteCategory_Organisation]
GO
ALTER TABLE [dbo].[Centre]  WITH CHECK ADD  CONSTRAINT [FK_Centre_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Centre] CHECK CONSTRAINT [FK_Centre_Organisation]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Colour]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Organisation]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Building] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Building] ([BuildingId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Building]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Company]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Organisation]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Organisation]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Organisation]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK__Departmen__Colou__4F9CCB9E] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK__Departmen__Colou__4F9CCB9E]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Organisation]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Country]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Organisation]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Personnel]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_AbsencePolicy]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Building1] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Building] ([BuildingId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Building1]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Company]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Organisation]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Personnel]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_PublicHolidayPolicy] FOREIGN KEY([PublicHolidayPolicyId])
REFERENCES [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_PublicHolidayPolicy]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_WorkingPattern]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([DepartmentId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Department]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Employment]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Organisation]
GO
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Employment]
GO
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Organisation]
GO
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Team] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Team] ([TeamId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Team]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_CasteCategory] FOREIGN KEY([CasteCategoryId])
REFERENCES [dbo].[CasteCategory] ([CasteCategoryId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_CasteCategory]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Centre]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Course] FOREIGN KEY([IntrestedCourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Course]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Course2] FOREIGN KEY([CourseOfferedId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Course2]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Enquiry]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_HowDidYouKnowAbout] FOREIGN KEY([HowDidYouKnowAboutId])
REFERENCES [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_HowDidYouKnowAbout]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Occupation] FOREIGN KEY([OccupationId])
REFERENCES [dbo].[Occupation] ([OccupationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Occupation]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Organisation]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Qualification] FOREIGN KEY([EducationalQualificationId])
REFERENCES [dbo].[Qualification] ([QualificationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Qualification]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Religion] FOREIGN KEY([ReligionId])
REFERENCES [dbo].[Religion] ([ReligionId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Religion]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Centre]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Organisation]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_Course] FOREIGN KEY([IntrestedCourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_Course]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_FollowUp] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_FollowUp]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_FollowUp1] FOREIGN KEY([FollowUpId])
REFERENCES [dbo].[FollowUp] ([FollowUpId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_FollowUp1]
GO
ALTER TABLE [dbo].[Host]  WITH CHECK ADD  CONSTRAINT [FK_Host_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Host] CHECK CONSTRAINT [FK_Host_Organisation]
GO
ALTER TABLE [dbo].[HowDidYouKnowAbout]  WITH CHECK ADD  CONSTRAINT [FK_HowDidYouKnowAboutUs_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[HowDidYouKnowAbout] CHECK CONSTRAINT [FK_HowDidYouKnowAboutUs_Organisation]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Centre] FOREIGN KEY([InterestedCourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Centre]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Event]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Mobilization] FOREIGN KEY([MobilizationId])
REFERENCES [dbo].[Mobilization] ([MobilizationId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Mobilization]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_MobilizationType] FOREIGN KEY([MobilizationTypeId])
REFERENCES [dbo].[MobilizationType] ([MobilizationTypeId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_MobilizationType]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Organisation]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Personnel]
GO
ALTER TABLE [dbo].[MobilizationType]  WITH CHECK ADD  CONSTRAINT [FK_MobilizationType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[MobilizationType] CHECK CONSTRAINT [FK_MobilizationType_Organisation]
GO
ALTER TABLE [dbo].[Occupation]  WITH CHECK ADD  CONSTRAINT [FK_Occupation_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Occupation] CHECK CONSTRAINT [FK_Occupation_Organisation]
GO
ALTER TABLE [dbo].[Personnel]  WITH CHECK ADD  CONSTRAINT [FK_Personnel_Employment] FOREIGN KEY([CurrentEmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[Personnel] CHECK CONSTRAINT [FK_Personnel_Employment]
GO
ALTER TABLE [dbo].[Personnel]  WITH CHECK ADD  CONSTRAINT [FK_Personnel_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Personnel] CHECK CONSTRAINT [FK_Personnel_Organisation]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsencePolicyPeriod] FOREIGN KEY([AbsencePolicyPeriodId])
REFERENCES [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsencePolicyPeriod]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsenceType] FOREIGN KEY([AbsenceTypeId])
REFERENCES [dbo].[AbsenceType] ([AbsenceTypeId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsenceType]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Employment]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Frequency] FOREIGN KEY([FrequencyId])
REFERENCES [dbo].[Frequency] ([FrequencyId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Frequency]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Organisation]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Personnel]
GO
ALTER TABLE [dbo].[PublicHoliday]  WITH CHECK ADD  CONSTRAINT [FK_PublicHoliday_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PublicHoliday] CHECK CONSTRAINT [FK_PublicHoliday_Organisation]
GO
ALTER TABLE [dbo].[PublicHoliday]  WITH CHECK ADD  CONSTRAINT [FK_PublicHoliday_PublicHolidayPolicy] FOREIGN KEY([PublicHolidayPolicyId])
REFERENCES [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId])
GO
ALTER TABLE [dbo].[PublicHoliday] CHECK CONSTRAINT [FK_PublicHoliday_PublicHolidayPolicy]
GO
ALTER TABLE [dbo].[PublicHolidayPolicy]  WITH CHECK ADD  CONSTRAINT [FK_PublicHolidayPolicy_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PublicHolidayPolicy] CHECK CONSTRAINT [FK_PublicHolidayPolicy_Organisation]
GO
ALTER TABLE [dbo].[Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Qualification_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Qualification] CHECK CONSTRAINT [FK_Qualification_Organisation]
GO
ALTER TABLE [dbo].[Religion]  WITH CHECK ADD  CONSTRAINT [FK_Religion_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Religion] CHECK CONSTRAINT [FK_Religion_Organisation]
GO
ALTER TABLE [dbo].[Site]  WITH CHECK ADD  CONSTRAINT [FK_Site_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Country]
GO
ALTER TABLE [dbo].[Site]  WITH CHECK ADD  CONSTRAINT [FK_Site_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Organisation]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_Colour]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_Organisation]
GO
ALTER TABLE [dbo].[WorkingPattern]  WITH CHECK ADD  CONSTRAINT [FK_WorkingPattern_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[WorkingPattern] CHECK CONSTRAINT [FK_WorkingPattern_Organisation]
GO
ALTER TABLE [dbo].[WorkingPatternDay]  WITH CHECK ADD  CONSTRAINT [FK_WorkingPatternDay_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[WorkingPatternDay] CHECK CONSTRAINT [FK_WorkingPatternDay_WorkingPattern]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [CK_AbsenceDay_AMPMDuration] CHECK  ((([AM]=(1) OR [PM]=(1)) AND ([Duration]=(0.5) OR [Duration]=(1))))
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [CK_AbsenceDay_AMPMDuration]
GO
/****** Object:  StoredProcedure [dbo].[SearchEnquiry]    Script Date: 08/02/2017 5:54:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SearchEnquiry]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
	EnquiryId,
	CandidateName,
	ContactNo,
	EmailId,
	Age,
	Address,
	GuardianName,
	GuardianContactNo,
	OccupationId,
	ReligionId,
	CasteCategoryId,
	Gender,
	EducationalQualificationId,
	YearOFPassOut,
	Marks,
	IntrestedCourseId,
	HowDidYouKnowAboutId,
	PreTrainingStatus,
	EmploymentStatus,
	Promotional,
	EnquiryDate,
	Place,
	CounselledBy,
	CourseOfferedId,
	PreferTiming,
	Remarks,
	CentreId,
	OrganisationId,
	FollowUpDate,
	EnquiryStatus,
	SearchField
	FROM 
		[EnquirySearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END



GO
/****** Object:  StoredProcedure [dbo].[SearchMobilization]    Script Date: 08/02/2017 5:54:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SearchMobilization]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
		MobilizationId,
		EventId,
		OrganisationId,
		CentreId,
		Name,
		Mobile,
		InterestedCourseId,
		QualificationId,
		CreatedDate,
		FollowUpDate,
		Remark,
		MobilizerStatus,
		MobilizedBy,
		StudentLocation,
		OtherInterestedCourse,
		GeneratedDate,
		SearchField
	FROM 
		[MobilizationSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END


GO
/****** Object:  StoredProcedure [dbo].[SearchPersonnel]    Script Date: 08/02/2017 5:54:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchPersonnel]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
		PersonnelId,
		OrganisationId,
		Title,
		Forenames,
		Surname,
		DOB,
		CountryId,
		Address1,
		Address2,
		Address3,
		Address4,
		Postcode,
		Telephone,
		Mobile,
		NINumber,
		BankAccountNumber,
		BankSortCode,
		BankAccountName,
		BankAddress1,
		BankAddress2,
		BankAddress3,
		BankAddress4,
		BankPostcode,
		BankTelephone,
		Email,
		SearchField
	FROM 
		[PersonnelSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END






GO
USE [master]
GO
ALTER DATABASE [Nidan_Dev] SET  READ_WRITE 
GO
