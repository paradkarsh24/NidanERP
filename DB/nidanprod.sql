USE [master]
GO
/****** Object:  Database [NidanERP]    Script Date: 29/05/2017 06:05:06 PM ******/
CREATE DATABASE [NidanERP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NidanERP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\NidanERP.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NidanERP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\NidanERP_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NidanERP] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NidanERP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NidanERP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NidanERP] SET ARITHABORT OFF 
GO
ALTER DATABASE [NidanERP] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [NidanERP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NidanERP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NidanERP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NidanERP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NidanERP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NidanERP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NidanERP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NidanERP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NidanERP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NidanERP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NidanERP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NidanERP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NidanERP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NidanERP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NidanERP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NidanERP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NidanERP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NidanERP] SET  MULTI_USER 
GO
ALTER DATABASE [NidanERP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NidanERP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NidanERP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NidanERP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [NidanERP] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NidanERP', N'ON'
GO
USE [NidanERP]
GO
/****** Object:  Table [dbo].[Absence]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AbsenceDay]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AbsencePeriod]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AbsencePolicy]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AbsencePolicyEntitlement]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AbsencePolicyPeriod]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AbsenceStatus]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AbsenceType]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Admission]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admission](
	[AdmissionId] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationId] [int] NOT NULL,
	[BatchId] [int] NULL,
	[CentreId] [int] NOT NULL,
	[AdmissionDate] [date] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NULL,
 CONSTRAINT [PK_Admission] PRIMARY KEY CLUSTERED 
(
	[AdmissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Alert]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AreaOfInterest]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 29/05/2017 06:05:06 PM ******/
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
	[PersonnelId] [int] NULL,
	[CentreId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsersAlertSchedule]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Batch]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Batch](
	[BatchId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Intake] [int] NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[BatchStartDate] [date] NOT NULL,
	[BatchEndDate] [date] NOT NULL,
	[NumberOfHolidays] [int] NOT NULL,
	[NumberOfHoursDaily] [int] NOT NULL,
	[BatchStartTimeHours] [int] NOT NULL,
	[BatchStartTimeMinutes] [int] NOT NULL,
	[BatchStartTimeSpan] [varchar](10) NOT NULL,
	[BatchEndTimeHours] [int] NOT NULL,
	[BatchEndTimeMinutes] [int] NOT NULL,
	[BatchEndTimeSpan] [varchar](10) NOT NULL,
	[AssessmentDate] [date] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[Remarks] [varchar](1000) NULL,
	[Month] [int] NOT NULL,
	[NumberOfInstallment] [int] NOT NULL,
	[FirstInstallment] [int] NULL,
	[SecondInstallment] [int] NULL,
	[ThirdInstallment] [int] NULL,
	[FourthInstallment] [int] NULL,
	[FifthInstallment] [int] NULL,
	[SixthInstallment] [int] NULL,
	[SeventhInstallment] [int] NULL,
	[EighthInstallment] [int] NULL,
	[NinethInstallment] [int] NULL,
	[TenthInstallment] [int] NULL,
	[EleventhInstallment] [int] NULL,
	[TwelvethInstallment] [int] NULL,
	[RoomId] [int] NULL,
 CONSTRAINT [PK_Batch] PRIMARY KEY CLUSTERED 
(
	[BatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchDay]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatchDay](
	[BatchDayId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[IsMonday] [bit] NOT NULL,
	[IsTuesday] [bit] NOT NULL,
	[IsWednesday] [bit] NOT NULL,
	[IsThursday] [bit] NOT NULL,
	[IsFriday] [bit] NOT NULL,
	[IsSaturday] [bit] NOT NULL,
	[IsSunday] [bit] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_BatchDay] PRIMARY KEY CLUSTERED 
(
	[BatchDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BatchTimePrefer]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchTimePrefer](
	[BatchTimePreferId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_BatchTimePrefer] PRIMARY KEY CLUSTERED 
(
	[BatchTimePreferId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchTrainer]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatchTrainer](
	[BatchTrainerId] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_BatchTrainer] PRIMARY KEY CLUSTERED 
(
	[BatchTrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Brainstorming]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Brainstorming](
	[BrainstormingId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Brainstorming] PRIMARY KEY CLUSTERED 
(
	[BrainstormingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Budget]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Budget](
	[BudgetId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Building]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[CandidateFee]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CandidateFee](
	[CandidateFeeId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentDate] [datetime] NULL,
	[CandidateInstallmentId] [int] NULL,
	[PaidAmount] [decimal](18, 2) NULL,
	[PaymentModeId] [int] NOT NULL,
	[FeeTypeId] [int] NOT NULL,
	[ChequeNumber] [varchar](50) NULL,
	[ChequeDate] [datetime] NULL,
	[BankName] [varchar](1000) NULL,
	[Penalty] [decimal](18, 2) NULL,
	[InstallmentDate] [datetime] NULL,
	[StudentCode] [varchar](50) NULL,
	[InstallmentNumber] [int] NULL,
	[InstallmentAmount] [decimal](18, 2) NULL,
	[BalanceInstallmentAmount] [decimal](18, 2) NULL,
	[Particulars] [varchar](max) NULL,
	[FiscalYear] [varchar](50) NULL,
	[FollowUpDate] [datetime] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[IsPaymentDone] [bit] NOT NULL,
	[PersonnelId] [int] NULL,
 CONSTRAINT [PK_CandidateFee] PRIMARY KEY CLUSTERED 
(
	[CandidateFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CandidateFeeDetail]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidateFeeDetail](
	[CandidateFeeDetailId] [int] IDENTITY(1,1) NOT NULL,
	[CandidateInstallmentId] [int] NOT NULL,
	[AdmissionId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[TotalFee] [int] NOT NULL,
	[InstallmentNumber] [int] NOT NULL,
 CONSTRAINT [PK_CandidateFeeDetail] PRIMARY KEY CLUSTERED 
(
	[CandidateFeeDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CandidateInstallment]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CandidateInstallment](
	[CandidateInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [varchar](50) NULL,
	[CourseFee] [int] NULL,
	[DownPayment] [int] NULL,
	[DiscountAmount] [int] NULL,
	[NumberOfInstallment] [int] NULL,
	[LumpsumAmount] [int] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[IsPercentageDiscount] [bit] NOT NULL,
	[IsTotalAmountDiscount] [bit] NOT NULL,
	[PaymentMethod] [varchar](100) NULL,
 CONSTRAINT [PK_CandidateInstallment] PRIMARY KEY CLUSTERED 
(
	[CandidateInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CasteCategory]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Centre]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Centre](
	[CentreId] [int] IDENTITY(1,1) NOT NULL,
	[CentreCode] [varchar](100) NULL,
	[Name] [varchar](500) NOT NULL,
	[Address1] [varchar](500) NOT NULL,
	[Address2] [varchar](500) NULL,
	[Address3] [varchar](500) NULL,
	[Address4] [varchar](500) NULL,
	[TalukaId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[PinCode] [int] NOT NULL,
	[EmailId] [varchar](500) NOT NULL,
	[Telephone] [bigint] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Centre] PRIMARY KEY CLUSTERED 
(
	[CentreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CentreCourse]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreCourse](
	[CentreCourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreCourse] PRIMARY KEY CLUSTERED 
(
	[CentreCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreCourseInstallment]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreCourseInstallment](
	[CentreCourseInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreCourseInstallment] PRIMARY KEY CLUSTERED 
(
	[CentreCourseInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreScheme]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreScheme](
	[CentreSchemeId] [int] IDENTITY(1,1) NOT NULL,
	[SchemeId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreScheme] PRIMARY KEY CLUSTERED 
(
	[CentreSchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreSector]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreSector](
	[CentreSectorId] [int] IDENTITY(1,1) NOT NULL,
	[SectorId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreSector] PRIMARY KEY CLUSTERED 
(
	[CentreSectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Colour]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Company]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[CompanyBuilding]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Counselling]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Counselling](
	[CounsellingId] [int] IDENTITY(1,1) NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[Title] [varchar](50) NULL,
	[FirstName] [varchar](100) NULL,
	[MiddleName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[CourseOfferedId] [int] NOT NULL,
	[PreferTiming] [varchar](500) NULL,
	[Remarks] [varchar](max) NULL,
	[FollowUpDate] [date] NULL,
	[RemarkByBranchManager] [varchar](max) NULL,
	[SectorId] [int] NULL,
	[PsychomatricTest] [varchar](100) NULL,
	[ConversionProspect] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[RemarkByBm] [varchar](max) NULL,
	[IsRegistrationDone] [bit] NOT NULL,
 CONSTRAINT [PK_Counselling] PRIMARY KEY CLUSTERED 
(
	[CounsellingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 29/05/2017 06:05:06 PM ******/
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
	[SectorId] [int] NOT NULL,
	[SchemeId] [int] NULL,
	[CourseTypeId] [int] NULL,
	[Description] [varchar](1000) NULL,
	[Duration] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseInstallment]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseInstallment](
	[CourseInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[CourseId] [int] NOT NULL,
	[Fee] [int] NOT NULL,
	[DownPayment] [int] NOT NULL,
	[LumpsumAmount] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[NumberOfInstallment] [int] NULL,
	[CentreId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
 CONSTRAINT [PK_CourseInstallment] PRIMARY KEY CLUSTERED 
(
	[CourseInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseSubject]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseSubject](
	[CourseSubjectId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[SubjectId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CourseSubject] PRIMARY KEY CLUSTERED 
(
	[CourseSubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CourseType]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseType](
	[CourseTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[CourseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[District]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[District](
	[DistrictId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Document]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Document](
	[DocumentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [varchar](100) NOT NULL,
	[StudentName] [varchar](500) NULL,
	[FileName] [varchar](4000) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Location] [varchar](max) NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DownloadedDateTime] [datetime] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED 
(
	[DocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentType]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentType](
	[DocumentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[BasePath] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED 
(
	[DocumentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmergencyContact]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Employment]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[EmploymentDepartment]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[EmploymentTeam]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Enquiry]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Enquiry](
	[EnquiryId] [int] IDENTITY(100,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[AlternateMobile] [bigint] NULL,
	[EmailId] [varchar](500) NOT NULL,
	[DateOfBirth] [date] NULL,
	[Age] [int] NOT NULL,
	[Address1] [varchar](500) NOT NULL,
	[Address2] [varchar](500) NULL,
	[Address3] [varchar](500) NULL,
	[Address4] [varchar](500) NULL,
	[TalukaId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[PinCode] [int] NOT NULL,
	[GuardianName] [varchar](500) NULL,
	[GuardianContactNo] [bigint] NULL,
	[OccupationId] [int] NOT NULL,
	[ReligionId] [int] NOT NULL,
	[CasteCategoryId] [int] NOT NULL,
	[Gender] [varchar](100) NOT NULL,
	[EducationalQualificationId] [int] NOT NULL,
	[YearOfPassOut] [varchar](100) NULL,
	[Marks] [varchar](100) NULL,
	[IntrestedCourseId] [int] NOT NULL,
	[HowDidYouKnowAboutId] [int] NOT NULL,
	[PreTrainingStatus] [varchar](100) NULL,
	[EmploymentStatus] [varchar](100) NULL,
	[Promotional] [varchar](100) NULL,
	[EnquiryDate] [date] NULL,
	[StudentCode] [varchar](100) NULL,
	[EnquiryStatus] [varchar](100) NULL,
	[EmployerName] [varchar](500) NULL,
	[EmployerContactNo] [varchar](50) NULL,
	[EmployerAddress] [varchar](max) NULL,
	[AnnualIncome] [int] NULL,
	[SchemeId] [int] NULL,
	[EnquiryTypeId] [int] NOT NULL,
	[StudentTypeId] [int] NOT NULL,
	[SectorId] [int] NOT NULL,
	[BatchTimePreferId] [int] NOT NULL,
	[AppearingQualification] [varchar](500) NULL,
	[YearOfExperience] [int] NULL,
	[PlacementNeeded] [varchar](100) NULL,
	[Remarks] [varchar](max) NULL,
	[FollowUpDate] [datetime] NULL,
	[PreferredMonthForJoining] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[ConversionProspect] [int] NULL,
	[OtherInterestedCourse] [varchar](500) NULL,
	[RemarkByBranchManager] [varchar](max) NULL,
	[IsCounsellingDone] [bit] NOT NULL,
	[IsRegistrationDone] [bit] NOT NULL,
	[IsAdmissionDone] [bit] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Enquiry] PRIMARY KEY CLUSTERED 
(
	[EnquiryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EnquiryCourse]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryCourse](
	[EnquiryCourseId] [int] IDENTITY(1,1) NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EnquiryCourse] PRIMARY KEY CLUSTERED 
(
	[EnquiryCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EnquiryType]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EnquiryType](
	[EnquiryTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EnquiryType] PRIMARY KEY CLUSTERED 
(
	[EnquiryTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Event]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Eventday]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Eventday](
	[EventdayId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Eventday] PRIMARY KEY CLUSTERED 
(
	[EventdayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventFunctionType]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventFunctionType](
	[EventFunctionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EventFunctionType] PRIMARY KEY CLUSTERED 
(
	[EventFunctionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FeeType]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FeeType](
	[FeeTypeId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FeeType] PRIMARY KEY CLUSTERED 
(
	[FeeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FollowUp]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FollowUp](
	[FollowUpId] [int] IDENTITY(1,1) NOT NULL,
	[FollowUpDateTime] [datetime] NULL CONSTRAINT [DF_FollowUp_FollowUpDateTime]  DEFAULT (((1900)-(1))-(1)),
	[MobilizationId] [int] NULL,
	[EnquiryId] [int] NULL,
	[CounsellingId] [int] NULL,
	[RegistrationId] [int] NULL,
	[Title] [varchar](50) NULL,
	[FirstName] [varchar](100) NULL,
	[MiddleName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Remark] [varchar](max) NULL,
	[Closed] [bit] NULL,
	[ReadDateTime] [datetime] NOT NULL CONSTRAINT [DF_FollowUp_ReadDateTime]  DEFAULT (((1900)-(1))-(1)),
	[CreatedDateTime] [datetime] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[Mobile] [bigint] NULL,
	[IntrestedCourseId] [int] NOT NULL,
	[FollowUpType] [varchar](200) NULL,
	[AlternateMobile] [bigint] NULL,
	[FollowUpURL] [varchar](2000) NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[AdmissionId] [int] NULL,
 CONSTRAINT [PK_FollowUp] PRIMARY KEY CLUSTERED 
(
	[FollowUpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FollowUpHistory]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FollowUpHistory](
	[FollowUpHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[FollowUpId] [int] NOT NULL,
	[FollowUpType] [varchar](200) NOT NULL,
	[Remarks] [varchar](max) NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemarks] [varchar](max) NULL,
	[FollowUpDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_FollowUpHistory] PRIMARY KEY CLUSTERED 
(
	[FollowUpHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Frequency]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Holiday]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Holiday](
	[HolidayId] [int] IDENTITY(1,1) NOT NULL,
	[HolidayDate] [date] NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[WeekDay] [varchar](100) NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Holiday] PRIMARY KEY CLUSTERED 
(
	[HolidayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Host]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[HowDidYouKnowAbout]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Mobilization]    Script Date: 29/05/2017 06:05:06 PM ******/
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
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[CentreId] [int] NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[AlternateMobile] [bigint] NULL,
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
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
 CONSTRAINT [PK_Mobilization] PRIMARY KEY CLUSTERED 
(
	[MobilizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MobilizationType]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Occupation]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Organisation]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[PaymentMode]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentMode](
	[PaymentModeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_PaymentMode] PRIMARY KEY CLUSTERED 
(
	[PaymentModeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Personnel]    Script Date: 29/05/2017 06:05:06 PM ******/
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
	[Telephone] [varchar](15) NULL,
	[Mobile] [varchar](15) NULL,
	[NINumber] [varchar](10) NULL,
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
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Personnel] PRIMARY KEY CLUSTERED 
(
	[PersonnelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonnelAbsenceEntitlement]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Planning]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Planning](
	[PlanningId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Planning] PRIMARY KEY CLUSTERED 
(
	[PlanningId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Postevent]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Postevent](
	[PosteventId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Postevent] PRIMARY KEY CLUSTERED 
(
	[PosteventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PublicHoliday]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[PublicHolidayPolicy]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Qualification]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Question]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[EventFunctionTypeId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Registration](
	[RegistrationId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [varchar](50) NULL,
	[EnquiryId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[CandidateFeeId] [int] NOT NULL,
	[CandidateInstallmentId] [int] NOT NULL,
	[Remarks] [varchar](max) NULL,
	[FollowupDate] [datetime] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[IsAdmissionDone] [bit] NOT NULL,
	[RegistrationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[RegistrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RegistrationPaymentReceipt]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RegistrationPaymentReceipt](
	[RegistrationPaymentReceiptId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[CounsellingId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Fees] [int] NOT NULL,
	[ChequeNo] [varchar](100) NOT NULL,
	[ChequeDate] [date] NOT NULL,
	[BankName] [varchar](500) NOT NULL,
	[Particulars] [varchar](500) NOT NULL,
	[PaymentModeId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[RegistrationDate] [date] NOT NULL,
	[FollowUpDate] [date] NULL,
	[Remarks] [varchar](max) NULL,
	[FinancialYear] [varchar](100) NOT NULL,
 CONSTRAINT [PK_RegistrationPaymentReceipt] PRIMARY KEY CLUSTERED 
(
	[RegistrationPaymentReceiptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Religion]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Room]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](max) NULL,
	[Number] [int] NOT NULL,
	[Floor] [int] NOT NULL,
	[OccupiedStartDate] [date] NULL,
	[OccupiedEndDate] [date] NULL,
	[OccupiedStartTime] [varchar](50) NULL,
	[OccupiedEndTime] [varchar](50) NULL,
	[RoomTypeId] [int] NOT NULL,
	[Capacity] [int] NOT NULL,
	[SquareFeet] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoomAvailable]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoomAvailable](
	[RoomAvailableId] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NOT NULL,
	[Day] [varchar](10) NOT NULL,
	[StartTimeHours] [int] NOT NULL,
	[StartTimeMinutes] [int] NOT NULL,
	[StartTimeSpan] [varchar](10) NOT NULL,
	[EndTimeHours] [int] NOT NULL,
	[EndTimeMinutes] [int] NOT NULL,
	[EndTimeSpan] [varchar](10) NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoomType](
	[RoomTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED 
(
	[RoomTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Scheme]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Scheme](
	[SchemeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Scheme] PRIMARY KEY CLUSTERED 
(
	[SchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sector]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sector](
	[SectorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[SchemeId] [int] NOT NULL,
 CONSTRAINT [PK_Sector] PRIMARY KEY CLUSTERED 
(
	[SectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Session]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Session](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Duration] [varchar](500) NOT NULL,
	[CourseTypeId] [int] NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[State]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudentType]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentType](
	[StudentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_StudentType] PRIMARY KEY CLUSTERED 
(
	[StudentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[CourseId] [int] NULL,
	[TrainerId] [int] NULL,
	[CourseTypeId] [int] NOT NULL,
	[TotalMarks] [int] NOT NULL,
	[PassingMarks] [int] NOT NULL,
	[NoOfAttemptsAllowed] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubjectCourse]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectCourse](
	[SubjectCourseId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_SubjectCourse] PRIMARY KEY CLUSTERED 
(
	[SubjectCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubjectTrainer]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectTrainer](
	[SubjectTrainerId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_SubjectTrainer] PRIMARY KEY CLUSTERED 
(
	[SubjectTrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Taluka]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Taluka](
	[TalukaId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[DistrictId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Taluka] PRIMARY KEY CLUSTERED 
(
	[TalukaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Team]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[Template]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Template](
	[TemplateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FileName] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Template] PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trainer]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trainer](
	[TrainerId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Address1] [varchar](100) NOT NULL,
	[Address2] [varchar](100) NULL,
	[Address3] [varchar](100) NULL,
	[Address4] [varchar](100) NULL,
	[TalukaId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[PinCode] [nvarchar](12) NOT NULL,
	[Gender] [varchar](100) NULL,
	[AadharNo] [bigint] NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[EmailId] [varchar](500) NOT NULL,
	[Certified] [varchar](100) NULL,
	[CertificationNo] [varchar](500) NULL,
	[SectorId] [int] NOT NULL,
	[CourseId] [int] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NULL,
	[CreatedDate] [date] NOT NULL,
 CONSTRAINT [PK_Trainer] PRIMARY KEY CLUSTERED 
(
	[TrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainerAvailable]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainerAvailable](
	[TrainerAvailableId] [int] IDENTITY(1,1) NOT NULL,
	[TrainerId] [int] NOT NULL,
	[Day] [varchar](10) NOT NULL,
	[StartTimeHours] [int] NOT NULL,
	[StartTimeMinutes] [int] NOT NULL,
	[StartTimeSpan] [varchar](10) NOT NULL,
	[EndTimeHours] [int] NOT NULL,
	[EndTimeMinutes] [int] NOT NULL,
	[EndTimeSpan] [varchar](10) NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_TrainerAvailable] PRIMARY KEY CLUSTERED 
(
	[TrainerAvailableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainerDocument]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainerDocument](
	[TrainerDocumentId] [int] IDENTITY(1,1) NOT NULL,
	[TrainerId] [int] NOT NULL,
	[TrainerName] [varchar](500) NULL,
	[FileName] [varchar](4000) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Location] [varchar](max) NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DownloadedDateTime] [datetime] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_TrainerDocument] PRIMARY KEY CLUSTERED 
(
	[TrainerDocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WorkingPattern]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  Table [dbo].[WorkingPatternDay]    Script Date: 29/05/2017 06:05:06 PM ******/
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
/****** Object:  View [dbo].[AdmissionGrid]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[AdmissionGrid]
AS 
Select
CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
BatchName=B.Name,
TotalFee=CI.CourseFee,
PaidAmount=sum(CF.PaidAmount),
PendingAmount = CI.CourseFee - sum(CF.PaidAmount),
A.AdmissionDate,
A.AdmissionId,
CentreName=C.Name,
C.CentreId
from Admission A
INNER JOIN REGISTRATION R ON R.RegistrationId =  A.RegistrationId
INNER JOIN ENQUIRY E ON E.EnquiryId = R.EnquiryId
INNER JOIN BATCH B ON B.BatchId = A.BatchId
INNER JOIN CandidateInstallment CI on CI.StudentCode = E.StudentCode
INNER JOIN CandidateFee CF on CF.CandidateInstallmentId = CI.CandidateInstallmentId
INNER JOIN Centre C on C.CentreId = A.CentreId
group by
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.Name,
CI.CourseFee,
A.AdmissionDate,
C.CentreId,
C.Name,
A.AdmissionId



GO
/****** Object:  View [dbo].[AdmissionSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[AdmissionSearchField]
AS 
SELECT 

	 CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
BatchName=B.Name,
TotalFee=CI.CourseFee,
PaidAmount=sum(CF.PaidAmount),
PendingAmount = CI.CourseFee - sum(CF.PaidAmount),
A.AdmissionDate,
A.AdmissionId,
CentreName=C.Name,
C.CentreId,

 ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
	  +ISNULL(C.Name, '')+ISNULL(B.Name, '')
	  + ISNULL(CONVERT(varchar,AdmissionDate, 101), '') 
	  + ISNULL(CONVERT(varchar,AdmissionDate, 103), '') 
	  + ISNULL(CONVERT(varchar,AdmissionDate, 105), '') 
	  + ISNULL(CONVERT(varchar,AdmissionDate, 126), '') AS SearchField

from Admission A
INNER JOIN REGISTRATION R ON R.RegistrationId =  A.RegistrationId
INNER JOIN ENQUIRY E ON E.EnquiryId = R.EnquiryId
INNER JOIN BATCH B ON B.BatchId = A.BatchId
INNER JOIN CandidateInstallment CI on CI.StudentCode = E.StudentCode
INNER JOIN CandidateFee CF on CF.CandidateInstallmentId = CI.CandidateInstallmentId
INNER JOIN Centre C on C.CentreId = A.CentreId
group by
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.Name,
CI.CourseFee,
A.AdmissionDate,
C.CentreId,
C.Name,
A.AdmissionId

  

GO
/****** Object:  View [dbo].[CandidateFeeGrid]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CandidateFeeGrid]
AS 
Select
C.CandidateInstallmentId,
CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
BatchName=B.Name,
TotalFee=CI.CourseFee,
PaidAmount=sum(PaidAmount),
PendingAmount = CI.CourseFee - sum(PaidAmount),
A.AdmissionDate,
A.AdmissionId,
CentreName=CE.Name,
CE.CentreId

from CandidateFee C
INNER JOIN CandidateInstallment CI ON CI.CandidateInstallmentId =  C.CandidateInstallmentId
INNER JOIN Enquiry E ON E.StudentCode = CI.StudentCode
INNER JOIN Registration R ON R.StudentCode = CI.StudentCode
INNER JOIN Admission A ON A.RegistrationId = R.RegistrationId
INNER JOIN BATCH B ON B.BatchId = A.BatchId
INNER JOIN Centre CE on CE.CentreId = A.CentreId
group by
C.CandidateInstallmentId,
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.Name,
CI.CourseFee,
A.AdmissionDate,
CE.CentreId,
CE.Name,
A.AdmissionId

GO
/****** Object:  View [dbo].[CandidateFeeSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[CandidateFeeSearchField]
AS 
SELECT 

	  CF.[CandidateFeeId],
      CF.[PaymentDate],
      CF.[CandidateInstallmentId],
      CF.[PaidAmount],
      CF.[PaymentModeId],
      CF.[FeeTypeId],
      CF.[ChequeNumber],
      CF.[ChequeDate],
      CF.[BankName],
      CF.[Penalty],
      CF.[InstallmentDate],
      CF.[StudentCode],
      CF.[InstallmentAmount],
      CF.[BalanceInstallmentAmount],
      CF.[Particulars],
      CF.[FiscalYear],
      CF.[FollowUpDate],
      CF.[CentreId],
      CF.[OrganisationId],
      CF.[IsPaymentDone],
      CF.[PersonnelId],

      ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
	  AS SearchField
FROM 
	CandidateFee CF  WITH (NOLOCK) inner join CandidateInstallment CA WITH (NOLOCK)
	on CF.CandidateInstallmentId=CA.CandidateInstallmentId join Registration R WITH(NOLOCK)
	on R.StudentCode=CF.StudentCode join Enquiry E WITH(NOLOCK)
	on E.StudentCode=CF.StudentCode
	where CF.StudentCode=R.StudentCode
	




GO
/****** Object:  View [dbo].[CandidateInstallmentSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[CandidateInstallmentSearchField]
AS 
SELECT 

      C.CandidateInstallmentId,
      C.StudentCode,
      C.CourseFee,
      C.DownPayment,
      C.DiscountAmount,
      C.NumberOfInstallment,
      C.LumpsumAmount,
      C.CentreId,
      C.OrganisationId,
      C.CourseInstallmentId,
      C.IsPercentageDiscount,
      C.IsTotalAmountDiscount,
      C.PaymentMethod,

	  ISNULL(E.Title, '')++ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '') AS SearchField


	  FROM 
	CandidateInstallment C  WITH (NOLOCK) join Registration R WITH (NOLOCK)
	on C.CandidateInstallmentId = R.CandidateInstallmentId join Enquiry E WITH(NOLOCK)
	on R.EnquiryId=E.EnquiryId


GO
/****** Object:  View [dbo].[CounsellingSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[CounsellingSearchField]
AS 
SELECT 

       C.CounsellingId,
      C.EnquiryId,
      C.Title,
      C.FirstName,
      C.MiddleName,
      C.LastName,
      C.CentreId,
      C.OrganisationId,
      C.PersonnelId,
      C.CourseOfferedId,
      C.PreferTiming,
      C.Remarks,
      C.FollowUpDate,
      C.RemarkByBranchManager,
      C.SectorId,
      C.PsychomatricTest,
      C.ConversionProspect,
      C.[Close],
      C.ClosingRemark,
      C.RemarkByBm,
      C.IsRegistrationDone,

	  ISNULL(C.Title, '')+ISNULL(C.FirstName, '')+ISNULL(C.MiddleName, '')+ISNULL(C.LastName, '')
	  +ISNULL(CO.Name, '')
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 101), '') 
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 103), '') 
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 105), '') 
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 126), '') as SearchField
		

	  from Counselling C WITH (NOLOCK) left join Course CO WITH (NOLOCK)
	on C.CourseOfferedId = CO.CourseId
	where C.IsRegistrationDone=0



GO
/****** Object:  View [dbo].[CourseInstallmentSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[CourseInstallmentSearchField]
AS 
SELECT 

		C.CourseInstallmentId,
      C.Name,
      C.CourseId,
      C.Fee,
      C.DownPayment,
      C.LumpsumAmount,
      C.OrganisationId,
      C.NumberOfInstallment,
      C.CentreId,
      C.CreatedDate,

	  ISNULL(C.Name, '')+ISNULL(CO.Name, '')+CONVERT(varchar, C.Fee )+ISNULL(CE.Name, '')AS SearchField



	  FROM 
	CourseInstallment C  WITH (NOLOCK) left join Course CO WITH (NOLOCK)
	on C.CourseId = CO.CourseId join Centre CE WITH(NOLOCk)
	on C.CentreId=CE.CentreId


GO
/****** Object:  View [dbo].[CourseSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[CourseSearchField]
AS 
SELECT 

		C.CourseId,
		C.Name,
		C.OrganisationId,
		C.SectorId,
		C.SchemeId,
		C.CourseTypeId,
		C.Description,
		C.Duration,

ISNULL(C.Name, '')+ISNULL(S.Name, '')+ISNULL(SC.Name, '') AS SearchField
FROM 
	Course C  WITH (NOLOCK) left join Sector S WITH (NOLOCK)
	on C.SectorId = S.SectorId join Scheme SC WITH (NOLOCK)
	on C.SchemeId=SC.SchemeId











GO
/****** Object:  View [dbo].[EnquirySearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE VIEW [dbo].[EnquirySearchField]
AS 
SELECT 

		E.EnquiryId,
      E.Title,
      E.FirstName,
      E.MiddleName,
      E.LastName,
      E.Mobile,
      E.AlternateMobile,
      E.EmailId,
      E.DateOfBirth,
      E.Age,
      E.Address1,
      E.Address2,
      E.Address3,
      E.Address4,
      E.TalukaId,
      E.StateId,
      E.DistrictId,
      E.PinCode,
      E.GuardianName,
      E.GuardianContactNo,
      E.OccupationId,
      E.ReligionId,
      E.CasteCategoryId,
      E.Gender,
      E.EducationalQualificationId,
      E.YearOfPassOut,
      E.Marks,
      E.IntrestedCourseId,
      E.HowDidYouKnowAboutId,
      E.PreTrainingStatus,
      E.EmploymentStatus,
      E.Promotional,
      E.EnquiryDate,
      E.StudentCode,
      E.EnquiryStatus,
      E.EmployerName,
      E.EmployerContactNo,
      E.EmployerAddress,
      E.AnnualIncome,
      E.SchemeId,
      E.EnquiryTypeId,
      E.StudentTypeId,
      E.SectorId,
      E.BatchTimePreferId,
      E.AppearingQualification,
      E.YearOfExperience,
      E.PlacementNeeded,
      E.Remarks,
      E.FollowUpDate,
      E.PreferredMonthForJoining,
      E.[Close],
      E.ClosingRemark,
      E.ConversionProspect,
      E.OtherInterestedCourse,
      E.RemarkByBranchManager,
      E.IsCounsellingDone,
      E.IsRegistrationDone,
      E.IsAdmissionDone,
      E.CentreId,
      E.OrganisationId,

	  ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
		+CONVERT(varchar, E.Mobile )+ISNULL(T.Name, '')+ISNULL(S.Name, '')+ISNULL(D.Name, '')
		+ISNULL(R.Name, '')+ISNULL(CC.Caste, '')+ISNULL(E.Gender, '')+ISNULL(Q.Name, '')
		+ISNULL(H.Name, '')+ISNULL(SC.Name, '')+ISNULL(SE.Name, '')+ISNULL(CE.Name, '') AS SearchField

	  from Enquiry E left join Taluka T WITH (NOLOCK)
	on E.TalukaId = T.TalukaId join State S WITH (NOLOCK)
	on E.StateId=S.StateId join District D WITH (NOLOCK)
	on E.DistrictId=D.DistrictId join Religion R WITH (NOLOCK)
	on E.ReligionId=R.ReligionId join CasteCategory CC WITH(NOLOCK)
	on E.CasteCategoryId=CC.CasteCategoryId join HowDidYouKnowAbout H WITH(NOLOCK)
	on E.HowDidYouKnowAboutId=H.HowDidYouKnowAboutId join Scheme SC WITH(NOLOCK)
	on E.SchemeId=SC.SchemeId join Sector SE WITH(NOLOCK)
	on E.SectorId=SE.SectorId join Qualification Q WITH(NOLOCK)
	on E.EducationalQualificationId=Q.QualificationId join Centre CE WITH(NOLOCK)
	on E.CentreId=CE.CentreId
	where E.[Close]='No' and E.IsRegistrationDone=0 and E.IsAdmissionDone=0





GO
/****** Object:  View [dbo].[FollowUpSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[FollowUpSearchField]
AS 
SELECT 

		F.FollowUpId,
      F.FollowUpDateTime,
      F.MobilizationId,
      F.EnquiryId,
      F.CounsellingId,
      F.RegistrationId,
      F.Title,
      F.FirstName,
      F.MiddleName,
      F.LastName,
      F.Remark,
      F.Closed,
      F.ReadDateTime,
      F.CreatedDateTime,
      F.OrganisationId,
      F.CentreId,
      F.Mobile,
      F.IntrestedCourseId,
      F.FollowUpType,
      F.AlternateMobile,
      F.FollowUpURL,
      F.[Close],
      F.ClosingRemark,

	  ISNULL(F.Title, '')+ISNULL(F.FirstName, '')+ISNULL(F.MiddleName, '')+ISNULL(F.LastName, '')
		+CONVERT(varchar, F.Mobile )+ISNULL(C.Name, '')+ISNULL(F.FollowUpType, '') AS SearchField

	  from 
	  FollowUp F WITH (NOLOCK) left join Course C WITH (NOLOCK)
	  on F.IntrestedCourseId = C.CourseId 
	  where F.[Close]='No'



GO
/****** Object:  View [dbo].[MobilizationSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
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
		M.Title,
		M.FirstName,
		M.MiddleName,
		M.LastName,
		M.Mobile,
		M.AlternateMobile,
		M.InterestedCourseId,
		M.QualificationId,
		M.CreatedDate,
		M.FollowUpDate,
		M.Remark,
		M.MobilizerStatus,
		p.Forenames[Mobilized By],
		M.StudentLocation,
		M.OtherInterestedCourse,
		M.MobilizationTypeId,
		M.GeneratedDate,
		M.PersonnelId,
        M.[Close],
        M.ClosingRemark,
		ISNULL(M.Title, '')+ISNULL(M.FirstName, '')+ISNULL(M.MiddleName, '')+ISNULL(M.LastName, '')+ISNULL(E.Name, '')+ISNULL(C.Name, '')+ISNULL(p.Forenames, '')+ISNULL(M.StudentLocation, '')+ISNULL(Mo.Name, '') + ISNULL(CONVERT(varchar,M.GeneratedDate, 101), '') + ISNULL(CONVERT(varchar,GeneratedDate, 103), '') + ISNULL(CONVERT(varchar,GeneratedDate, 105), '') + ISNULL(CONVERT(varchar,GeneratedDate, 126), '') + ISNULL(StudentLocation, '') + ISNULL(Q.Name, '') + CONVERT(varchar, m.Mobile ) AS SearchField
FROM 
	Mobilization M  WITH (NOLOCK) left join Event E WITH (NOLOCK)
	on M.Eventid = E.EventId join Course C WITH (NOLOCK)
	ON C.CourseId = m.InterestedCourseId join Qualification Q WITH (NOLOCK)
	ON Q.QualificationId = M.QualificationId join Personnel P WITH (NOLOCK)
	on m.PersonnelId=p.PersonnelId join MobilizationType Mo WITH (NOLOCK)
	on M.MobilizationTypeId=Mo.MobilizationTypeId
	where M.[Close]='No'








GO
/****** Object:  View [dbo].[PersonnelSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
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
		CurrentEmploymentId,
      CentreId,
	
		ISNULL(Surname, '') + ISNULL(Forenames, '') + ISNULL(Surname, '') + ISNULL(CONVERT(varchar,DOB, 101), '') + ISNULL(CONVERT(varchar,DOB, 103), '') + ISNULL(CONVERT(varchar,DOB, 105), '') + ISNULL(CONVERT(varchar,DOB, 126), '') + ISNULL(EMail, '') + ISNULL(Postcode, '') + ISNULL(Mobile, '') AS SearchField
FROM 
	Personnel  WITH (NOLOCK)















GO
/****** Object:  View [dbo].[RegistrationSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[RegistrationSearchField]
AS 
SELECT

       R.RegistrationId,
      R.StudentCode,
      R.EnquiryId,
      R.CourseId,
      R.CourseInstallmentId,
      R.CandidateFeeId,
      R.CandidateInstallmentId,
      R.Remarks,
      R.FollowupDate,
      R.CentreId,
      R.OrganisationId,
      R.IsAdmissionDone,
      R.RegistrationDate,

	  ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
	  +ISNULL(C.Name,'')+ ISNULL(CONVERT(varchar,R.RegistrationDate, 101), '') 
	  + ISNULL(CONVERT(varchar,R.RegistrationDate, 103), '') 
	  + ISNULL(CONVERT(varchar,R.RegistrationDate, 105), '') 
	  + ISNULL(CONVERT(varchar,R.RegistrationDate, 126), '')  AS SearchField

	  FROM 
	Registration R  WITH (NOLOCK) left join Course C WITH (NOLOCK)
	on R.CourseId = C.CourseId join Enquiry E WITH(NOLOCK)
	on R.EnquiryId=E.EnquiryId
	where R.IsAdmissionDone=0



GO
/****** Object:  View [dbo].[TrainerSearchField]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[TrainerSearchField]
AS 
SELECT 
		T.TrainerId,
		T.Title,
		T.FirstName,
		T.MiddleName,
		T.LastName,
		T.DateOfBirth,
		T.Address1,
		T.Address2,
		T.Address3,
		T.Address4,
		T.PinCode,
		T.TalukaId,
		T.DistrictId,
		T.StateId,
		T.Gender,
		T.AadharNo,
		T.Mobile,
		T.EmailId,
		T.Certified,
		T.CertificationNo,
		T.SectorId,
		T.CourseId,
		T.CentreId,
		T.OrganisationId,
		T.PersonnelId,
		T.CreatedDate,
		
		ISNULL(T.Title, '')+ISNULL(T.FirstName, '')+ISNULL(T.MiddleName, '')+ISNULL(T.LastName, '')
		+CONVERT(varchar, T.Mobile )+ISNULL(S.Name, '')
		+ ISNULL(CONVERT(varchar,T.DateOfBirth, 101), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 103), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 105), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 126), '')
	  +ISNULL(TL.Name, '')+ISNULL(ST.Name, '')+ISNULL(D.Name, '') AS SearchField
FROM 
	Trainer T  WITH (NOLOCK) left join Sector S WITH (NOLOCK)
	on T.SectorId = S.SectorId join Taluka TL WITH(NOLOCk)
	on T.TalukaId=TL.TalukaId join District D WITH(NOLOCk)
	on T.DistrictId=D.DistrictId join State ST WITH(NOLOCk)
	on T.StateId=ST.StateId













GO
/****** Object:  View [dbo].[UserAuthorisationFilter]    Script Date: 29/05/2017 06:05:06 PM ******/
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
SET IDENTITY_INSERT [dbo].[Admission] ON 

INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (17, 11, 9, 1, CAST(N'2017-05-18' AS Date), 4, 56)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (18, 12, 9, 1, CAST(N'2017-05-19' AS Date), 4, 57)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (19, 13, 9, 1, CAST(N'2017-05-20' AS Date), 4, 59)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (20, 14, 9, 1, CAST(N'2017-05-22' AS Date), 4, 20)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (21, 16, 9, 1, CAST(N'0001-01-01' AS Date), 4, 20)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (22, 17, NULL, 1, CAST(N'2017-05-23' AS Date), 4, NULL)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (23, 18, 10, 1, CAST(N'2017-05-23' AS Date), 4, 20)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (24, 19, NULL, 1, CAST(N'2017-05-23' AS Date), 4, 63)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (25, 20, NULL, 1, CAST(N'2017-05-25' AS Date), 4, NULL)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (26, 20, NULL, 1, CAST(N'2017-05-25' AS Date), 4, NULL)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (27, 15, 9, 1, CAST(N'2017-05-25' AS Date), 4, NULL)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (28, 21, 9, 1, CAST(N'2017-05-25' AS Date), 4, NULL)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (29, 22, 12, 1, CAST(N'2017-05-26' AS Date), 4, 64)
SET IDENTITY_INSERT [dbo].[Admission] OFF
SET IDENTITY_INSERT [dbo].[AreaOfInterest] ON 

INSERT [dbo].[AreaOfInterest] ([AreaOfInterestId], [Name], [OrganisationId]) VALUES (0, N'IT', 4)
INSERT [dbo].[AreaOfInterest] ([AreaOfInterestId], [Name], [OrganisationId]) VALUES (1, N'ITEs', 4)
SET IDENTITY_INSERT [dbo].[AreaOfInterest] OFF
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'1', N'SuperAdmin', N'ApplicationRole')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'2', N'Admin', N'ApplicationRole')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'3', N'User', N'ApplicationRole')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'4', N'Trainer', N'ApplicationRole')
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
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1dc202d7-839a-48f8-baf9-552cbd40fd3c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1f2db86c-81fb-4eec-9d5f-0c780eafb590', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'209a9149-18d6-47e5-b880-53cc8aeb856f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20c83ae9-a47c-4122-8b00-2a14e98db983', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'246e2f76-68bd-486a-8468-c54851c87541', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'24b0530f-ce19-4004-be38-a6cc1533e322', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'269ee34f-44b5-4374-9d16-ee31c8de0974', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2985709c-33d3-4bcf-879e-0db5da198c77', N'4')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2992313b-87d5-4229-8c3a-6578d222e293', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2ac20a85-a6dc-4429-92e1-15b00f08adb8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2b9a1443-fa62-4cb0-aec7-b7b5770436ac', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2c4ebd78-f541-440c-b9de-fad81a0f5a98', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2d921f72-b892-4cca-b294-210592790854', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2f4ebcc1-5ff9-4f9f-a31d-66c47aee5894', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2fd4cd69-4a25-46e0-af8c-2ed5d28f610f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'30ee0b23-785a-4d06-a95d-0f7b6d9ce31f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3121bc35-ec6b-4963-888b-014b83f47fe8', N'4')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'316f648b-6ca2-4d98-9f93-c7afdd943789', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'320ac667-ee90-48a2-9b53-fb9c10ec0d61', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'33bb0ae7-2832-4072-8622-fec97b97b71b', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'34ab16e8-1e47-4561-8998-aa9bda9451cd', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'368eb845-84c0-4b41-a3fe-4b8e17566012', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'38279ad7-91c8-4968-932c-0a5a05ab495c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3deed64b-69ec-49fc-905f-a73cd5582f3c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'40ee8af2-4d7c-4a93-af2b-118d78db6b81', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'424193a9-7b3f-43cc-9806-b27db02c5db4', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'42aa16da-0fb1-4701-ba6d-a545ff4f36a7', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'431aa089-ac08-48d6-b671-e1087f85bcb8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4741b301-d9dc-4c8e-b029-a8688a0a0308', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'475e52f8-bb3b-4834-ae84-17842b12b0c8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4836e102-343b-4c9f-ba96-00461f4893f3', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'491e3deb-c570-47f1-aec9-b649ac239db2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4cdce9f5-89a3-4680-a211-1c0913bf58bf', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'50b3a684-5599-4a40-9f0f-47a5c37e8e15', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'52abb99d-d48a-4d32-ba55-bbb89bece8de', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'52f41cd9-bc88-42d4-8d34-90b259d6fd46', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'552b29ce-8872-4f8c-b8dd-747ae4333e4e', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'55a1f00f-cd0b-491f-b04b-57803b0db161', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'58bfb3ef-4949-4d43-8c89-a1409d16a08a', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'594e3477-339d-4749-8b89-58d75936a640', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5f4dd0b1-b3e8-4203-bc10-1df868bf5963', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'634bc7d0-dca0-42be-9321-d854d5d3ec69', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'648b8178-35bf-4223-8ebf-7649977683c7', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6cabb6dd-2875-4589-8ab7-923610c62349', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6cf75ade-561f-4fdc-a1e5-fa57cd9ef8ce', N'2')
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
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8c0cfdcc-0375-4dd0-8456-605f8b8d8b8a', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9126ad61-924c-4ec3-8eaf-05386fb9a999', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9349a8cd-5b5d-4ab5-80bf-9b178a0629cd', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'995a714c-8876-41ab-8e48-1c79b01d459f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9b923fee-8028-493a-b54d-666fb6397a75', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9bb0610e-788e-4dfc-93b6-82af4c016765', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a0946d24-c935-4070-88c7-e660445eda5d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a4110fcf-efe0-4055-986e-02e1d2affbc4', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a4a988b5-e38b-4c70-a20b-bed97a8db4cb', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a79cb6fc-1cba-4f32-96f9-e1e4e9890ee5', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aab6fc24-4f57-4de7-9979-3b790eef72c9', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ae397432-e4aa-44a6-80a6-dc9bea2a251e', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aed476a0-3739-44a0-bd2f-b11a3287689c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'afcf5153-7257-4d0e-9095-2d2286c0abbe', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'afdca75e-d51d-410b-abfc-a3fb0b61a198', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b38dc1bf-0691-4edf-9428-7b205a07f80d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b3a394ff-5146-4cfd-8e1d-16d0d38b466d', N'3')
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
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'da0c5b44-3ebd-4fcd-af2d-3e7a0aaf95b0', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'db5f88be-4018-4647-8776-01e9cd07753a', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e2ae65fc-51f3-4d01-8c0c-063c4abd0da2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e3482627-f15f-4d8d-b347-572e78e41dae', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ea78e966-60fc-42d3-8fd2-68e826d1c56d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f1e97402-9a85-4dbc-8919-fcaf4318f7c7', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f6295d2a-12ee-4d1e-ab0b-707716a24d6a', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f68428ff-8dd1-49fb-8a1a-8655f3bf076d', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f72d0864-d72f-468b-940c-1a3deb3b3250', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fa4c3ca7-d0d6-4c09-9dd7-22af3c5d6abe', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fbe3dde3-c2da-4337-9667-0d363bfac5c5', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fdd6d9a2-1d33-4e76-a4e5-7988effb6d81', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fe861a67-db8e-401f-95f3-9142300a7e84', N'1')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'fe861a67-db8e-401f-95f3-9142300a7e84', N'superadmin@nidantech.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'dac1f363-20c6-4593-a998-f35725ba23c9', NULL, 0, 0, NULL, 0, 0, N'superadmin@nidantech.com', 4, NULL, -1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'f6295d2a-12ee-4d1e-ab0b-707716a24d6a', N'admin1@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'62873593-517e-4f95-9f64-0490e940528a', NULL, 0, 0, NULL, 0, 0, N'admin1@itsupportlimited.com', 1, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'24b0530f-ce19-4004-be38-a6cc1533e322', N'admin2@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'e34fdba4-6bec-417f-923f-8d95dda829b2', NULL, 0, 0, NULL, 0, 0, N'admin2@itsupportlimited.com', 2, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'afcf5153-7257-4d0e-9095-2d2286c0abbe', N'employee@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'cf421afd-9c38-457c-a6af-c521e1d602d9', NULL, 0, 0, NULL, 0, 0, N'employee@itsupportlimited.com', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'81c6963a-e6b6-40f2-8ff7-ab17a033d95f', N'admindevuk@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'87edef0d-7230-4a5e-81a5-00e45867c9b7', NULL, 0, 0, NULL, 0, 0, N'admindevuk@itsupportlimited.com', 3, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'baa66088-ea1b-43ab-b8b0-ee75523e613a', N'admindevmumbai@nidantech.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'2638a07d-1d70-4d9d-aea8-9fa592ebd519', NULL, 0, 0, NULL, 0, 0, N'admindevmumbai@nidantech.com', 4, 20, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'cded29f3-f32f-4143-86b9-30cce601d2db', N'boss@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'88943326-3aac-4de3-9952-aef532cb151b', NULL, 0, 0, NULL, 1, 0, N'boss@hr.com', 1, 3, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'4836e102-343b-4c9f-ba96-00461f4893f3', N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'cbfb458c-0f8d-4bf8-883d-0e46c5c4426b', NULL, 0, 0, NULL, 1, 0, N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 4, NULL, 2)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'd9ceb6d0-4ade-4d87-ae3c-c829206620d5', N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'f0d27bfc-9683-4dfc-8bb4-9a8353c3ebe9', NULL, 0, 0, NULL, 1, 0, N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', 4, 21, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'88450232-24c3-4cba-919b-7c1c4c64f4f2', N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'd29730e8-04fe-4e86-be51-b6de06e173db', NULL, 0, 0, NULL, 1, 0, N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', 4, 22, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'1b4ec15b-abff-46c0-a029-df405b2d4ffb', N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'6bdbe6e5-2109-4d58-b54c-e4212315465d', NULL, 0, 0, NULL, 1, 0, N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', 4, 23, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'20c83ae9-a47c-4122-8b00-2a14e98db983', N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'19e19041-015f-45d4-a2dd-5c486e2b3736', NULL, 0, 0, NULL, 1, 0, N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', 4, 24, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'424193a9-7b3f-43cc-9806-b27db02c5db4', N'sunjayp88456@gmail.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'47e90459-e1cf-41b2-a0b4-e88cc4f5266b', NULL, 0, 0, NULL, 1, 0, N'sunjayp88456@gmail.com', 4, 13, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'9349a8cd-5b5d-4ab5-80bf-9b178a0629cd', N'panontonganm@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'1108f492-9cba-4934-b5fb-652b97e11f90', NULL, 0, 0, NULL, 1, 0, N'panontonganm@andersongroup.uk.com', 1, 13, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'db5f88be-4018-4647-8776-01e9cd07753a', N'johhpaulc@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'904bfac7-a8bc-48a3-a551-7fa0e779b464', NULL, 0, 0, NULL, 1, 0, N'johhpaulc@andersongroup.uk.com', 1, 14, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'3121bc35-ec6b-4963-888b-014b83f47fe8', N'ragini@gmail.com', 0, N'AKRsm8LbO6Tcb3Ad61T/haXXlPGgzd1yS17M4b92xNwKzrAGpJCv44rziAgflPNXgw==', N'800b9c9e-a637-4563-98fb-7b6533bcf203', NULL, 0, 0, NULL, 1, 0, N'ragini@gmail.com', 4, 55, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'42aa16da-0fb1-4701-ba6d-a545ff4f36a7', N'shubham@gmail.com', 0, N'ADD4o279xQ7AW8w/yftLYvFKwbHiV3TLg0adpyNasZsbIsPWL8qYF0cCDLHlzlG7Xw==', N'32a21b2f-3eef-4fa0-9be5-49ac5f1c8016', NULL, 0, 0, NULL, 1, 0, N'shubham@gmail.com', 4, 57, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'1dc202d7-839a-48f8-baf9-552cbd40fd3c', N'sanjay@gmail.com', 0, N'AGJTI/tI7CY3LpKCviq+c50ePowYrmk2dmy+4yZfl3dyMkvVW25cZ2gk2Uqkju8DXA==', N'51dfa334-522f-4493-974f-607982be99ea', NULL, 0, 0, NULL, 1, 0, N'sanjay@gmail.com', 4, 59, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'aed476a0-3739-44a0-bd2f-b11a3287689c', N'kristineg@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'4fbc5e0a-e3d2-4622-bd35-04a8502f5268', NULL, 0, 0, NULL, 1, 0, N'kristineg@andersongroup.uk.com', 1, 15, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'06586b59-4429-436d-9b26-800d880483df', N'dev@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'e56d3f92-2be7-4ecf-8a0f-f6118507987a', NULL, 0, 0, NULL, 1, 0, N'christophers@andersongroup.uk.com', 1, 16, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'ccd7d6ea-f514-40a8-9530-dd7744c5706c', N'dikshas@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'2ddce434-0ca5-4fa4-ae56-e49b62937034', NULL, 0, 0, NULL, 1, 0, N'dikshas@andersongroup.uk.com', 4, 16, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'77ec2e78-ed30-4b70-8fdf-7498a3f85492', N'67f677f3-a905-483e-afd9-b3932e14e8ba@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'c5549f22-06e2-4870-9cb8-65b062d5b575', NULL, 0, 0, NULL, 1, 0, N'67f677f3-a905-483e-afd9-b3932e14e8ba@hr.com', 4, 14, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'817cad52-7b2e-4bf3-994d-2c9c91e03cd2', N'pankajc1@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'7a1cdaa8-6e74-431e-ba28-63ee84ab43a7', NULL, 0, 0, NULL, 1, 0, N'pankajc1@andersongroup.uk.com', 4, 15, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'a4a988b5-e38b-4c70-a20b-bed97a8db4cb', N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'3d770f21-d1c7-44a7-a221-11e5cbcfa887', NULL, 0, 0, NULL, 1, 0, N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', 4, 25, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'f68428ff-8dd1-49fb-8a1a-8655f3bf076d', N'bmthane@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'21f0007e-2cc7-4f38-8449-94e44f47ec9c', NULL, 0, 0, NULL, 1, 0, N'bmthane@nidantech.com', 4, 26, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'634bc7d0-dca0-42be-9321-d854d5d3ec69', N'ci_jbp@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'08ff6cf4-678c-4140-8959-6fe39bb0ae04', NULL, 0, 0, NULL, 1, 0, N'ci_jbp@nidantech.com', 4, 28, 4)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'52f41cd9-bc88-42d4-8d34-90b259d6fd46', N'ci_ngp@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'746807cd-ed15-42b6-96c2-6557b0963800', NULL, 0, 0, NULL, 1, 0, N'ci_ngp@nidantech.com', 4, 29, 3)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'6cabb6dd-2875-4589-8ab7-923610c62349', N'bmvaishali@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'0096d556-9a7a-4330-aaaf-868b50d53a1f', NULL, 0, 0, NULL, 1, 0, N'bmvaishali@nidantech.com', 4, 30, 5)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'a0946d24-c935-4070-88c7-e660445eda5d', N'vijayraut33@gmail.com', 0, N'ANhlQmE4Q95ROt2XXA68NutPWCppMkcxWv4v0sk2CLeZRWZjLKRxGDxol2PpJlg4gw==', N'5355d9ab-3f7c-48d6-a738-f90dce48bd4e', NULL, 0, 0, NULL, 1, 0, N'vijayraut33@gmail.com', 4, 56, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'2985709c-33d3-4bcf-879e-0db5da198c77', N'mohsin@gmail.com', 0, N'ALITgYNVCBeUvjTTEZDKlvJwYVe9O8lXPcayvXXX11maNqZ98V6XOQ3YzkgnteP22g==', N'1fc565f6-a527-481a-a363-3c2bab24866e', NULL, 0, 0, NULL, 1, 0, N'mohsin@gmail.com', 4, 58, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'b3a394ff-5146-4cfd-8e1d-16d0d38b466d', N'vasudha@gmail.com', 0, N'APJTT6QgVxeftHiFqE8WRcZMtXokvqgTEm/aD0jUdWJMsxvDUwyzfPyB0sGVbgPoIQ==', N'e87e85d7-3c00-47a4-a449-cfc2e78f07c1', NULL, 0, 0, NULL, 1, 0, N'vasudha@gmail.com', 4, 60, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'8c0cfdcc-0375-4dd0-8456-605f8b8d8b8a', N'aditya@gmail.com', 0, N'AGjskpM2R3Ve1W6oJkZx1cpHyOX/gleCAONP60jzBI9lNPU1pDQINa+r/anXJgHQuA==', N'8477f734-1554-4749-b493-bcad96122de5', NULL, 0, 0, NULL, 1, 0, N'aditya@gmail.com', 4, 63, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'da0c5b44-3ebd-4fcd-af2d-3e7a0aaf95b0', N'pooja@gmail.com', 0, N'ACopobDS13oPodjeqtYmzzYOXPsr2GcRSRVeReKWk95l8kq6U0BWIcqDpkFj0ONaGQ==', N'02afe43a-9ea1-47cd-b3e7-89816108f5da', NULL, 0, 0, NULL, 1, 0, N'pooja@gmail.com', 4, 64, 1)
SET IDENTITY_INSERT [dbo].[Batch] ON 

INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (9, N'.Net MWF Morning Batch', 10, 4, 2, 0, CAST(N'2017-05-23' AS Date), CAST(N'2017-05-23' AS Date), 10, 3, 9, 0, N'AM', 12, 0, N'AM', CAST(N'2017-05-23' AS Date), 1, 4, CAST(N'2017-05-18' AS Date), NULL, 6, 4, 10000, 10000, 10000, 10000, 5714, 5714, 5714, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (10, N'Java Morning TTS Batch', 20, 5, 5, 0, CAST(N'2017-05-23' AS Date), CAST(N'2017-05-23' AS Date), 10, 2, 9, 30, N'AM', 11, 30, N'AM', CAST(N'2017-05-23' AS Date), 1, 4, CAST(N'2017-05-23' AS Date), NULL, 6, 4, 10000, 10000, 10000, 10000, 5714, 5714, 5714, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (11, N'.net endtime test', 10, 4, 2, 0, CAST(N'2017-05-24' AS Date), CAST(N'2017-05-24' AS Date), 5, 2, 9, 0, N'AM', 11, 0, N'PM', CAST(N'2017-05-24' AS Date), 1, 4, CAST(N'2017-05-24' AS Date), NULL, 6, 4, 10000, 10000, 10000, 10000, 5714, 5714, 5714, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (12, N'Transport Consolidator Morning Batch', 10, 6, 15, 0, CAST(N'2017-05-26' AS Date), CAST(N'2017-05-26' AS Date), 10, 2, 8, 30, N'AM', 10, 30, N'AM', CAST(N'2017-05-26' AS Date), 1, 4, CAST(N'2017-05-26' AS Date), NULL, 4, 2, 2250, 2250, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (13, N'Transport Consolidator Afternoon Batch', 10, 6, 15, 0, CAST(N'2017-05-27' AS Date), CAST(N'2017-05-27' AS Date), 10, 2, 1, 30, N'AM', 3, 30, N'PM', CAST(N'2017-05-27' AS Date), 1, 4, CAST(N'2017-05-27' AS Date), NULL, 4, 2, 2250, 2250, 900, 900, 900, 409, 409, 409, 409, 409, 409, NULL, 5)
INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (16, N'.Net MTW', 10, 4, 2, 0, CAST(N'2017-05-27' AS Date), CAST(N'2017-05-27' AS Date), 10, 2, 1, 15, N'AM', 3, 15, N'PM', CAST(N'2017-05-27' AS Date), 1, 4, CAST(N'2017-05-27' AS Date), NULL, 6, 4, 10000, 10000, 10000, 10000, 5714, 5714, 5714, NULL, NULL, NULL, NULL, NULL, 5)
SET IDENTITY_INSERT [dbo].[Batch] OFF
SET IDENTITY_INSERT [dbo].[BatchDay] ON 

INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (8, 4, 9, 1, 0, 1, 0, 0, 0, 0, 1)
INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (9, 4, 10, 0, 1, 0, 1, 0, 1, 0, 1)
INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (10, 4, 11, 0, 1, 1, 1, 0, 0, 0, 1)
INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (11, 4, 12, 1, 1, 1, 0, 0, 0, 0, 1)
INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (12, 4, 13, 1, 1, 1, 0, 0, 0, 0, 1)
INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (15, 4, 16, 1, 1, 1, 0, 0, 0, 0, 1)
SET IDENTITY_INSERT [dbo].[BatchDay] OFF
SET IDENTITY_INSERT [dbo].[BatchTimePrefer] ON 

INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (1, N'8 am To 12 pm', 4)
INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (2, N'12 pm To 4 pm', 4)
INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (3, N'4 pm To 8 pm', 4)
SET IDENTITY_INSERT [dbo].[BatchTimePrefer] OFF
SET IDENTITY_INSERT [dbo].[BatchTrainer] ON 

INSERT [dbo].[BatchTrainer] ([BatchTrainerId], [BatchId], [TrainerId], [OrganisationId], [CentreId]) VALUES (4, 9, 1, 4, 1)
INSERT [dbo].[BatchTrainer] ([BatchTrainerId], [BatchId], [TrainerId], [OrganisationId], [CentreId]) VALUES (5, 10, 1, 4, 1)
INSERT [dbo].[BatchTrainer] ([BatchTrainerId], [BatchId], [TrainerId], [OrganisationId], [CentreId]) VALUES (6, 11, 2, 4, 1)
INSERT [dbo].[BatchTrainer] ([BatchTrainerId], [BatchId], [TrainerId], [OrganisationId], [CentreId]) VALUES (7, 12, 2, 4, 1)
INSERT [dbo].[BatchTrainer] ([BatchTrainerId], [BatchId], [TrainerId], [OrganisationId], [CentreId]) VALUES (12, 12, 1, 4, 1)
INSERT [dbo].[BatchTrainer] ([BatchTrainerId], [BatchId], [TrainerId], [OrganisationId], [CentreId]) VALUES (15, 16, 1, 4, 1)
SET IDENTITY_INSERT [dbo].[BatchTrainer] OFF
SET IDENTITY_INSERT [dbo].[Building] ON 

INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (1, N'PankajBuilding', 4, 12, N'Mumbai')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (2, N'PankajBuilding2', 4, 13, N'Mumbai2')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (3, N'PankajBuilding3', 4, 12, N'Mumbai3')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (4, N'PankajBuilding4', 4, 14, N'TestBuilding')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (5, N'test1building', 4, 12, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (7, N't2building', 4, 12, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (8, N'test new', 4, 16, NULL)
SET IDENTITY_INSERT [dbo].[Building] OFF
SET IDENTITY_INSERT [dbo].[CandidateFee] ON 

INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (124, CAST(N'2017-05-17 18:27:15.770' AS DateTime), 17, CAST(1000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-17 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'115', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (125, CAST(N'2017-05-17 18:33:38.377' AS DateTime), 18, CAST(1000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-17 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'115', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (126, CAST(N'2017-05-18 09:00:19.750' AS DateTime), 18, CAST(4000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-18 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'115', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (127, CAST(N'2017-05-25 10:40:53.240' AS DateTime), 18, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'115', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (128, NULL, 18, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'115', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (129, NULL, 18, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'115', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (130, NULL, 18, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'115', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (131, CAST(N'2017-05-19 14:33:00.020' AS DateTime), 19, CAST(1000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'114', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (132, CAST(N'2017-05-19 09:04:33.387' AS DateTime), 19, CAST(4000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'114', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (133, CAST(N'2017-05-20 07:04:20.610' AS DateTime), 19, CAST(9750.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'114', NULL, CAST(9750.00 AS Decimal(18, 2)), NULL, NULL, N'2017-18', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (134, CAST(N'2017-05-20 07:04:19.953' AS DateTime), 19, CAST(9750.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'114', NULL, CAST(9750.00 AS Decimal(18, 2)), NULL, NULL, N'2017-18', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (135, CAST(N'2017-05-23 07:04:29.117' AS DateTime), 19, CAST(9750.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'114', NULL, CAST(9750.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (136, CAST(N'2017-05-23 07:07:20.857' AS DateTime), 19, CAST(9750.00 AS Decimal(18, 2)), 2, 3, NULL, NULL, NULL, NULL, NULL, N'114', NULL, CAST(9750.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (137, CAST(N'2017-05-20 13:55:45.893' AS DateTime), 20, CAST(1000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-20 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'117', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (138, CAST(N'2017-05-20 08:30:17.670' AS DateTime), 20, CAST(5000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-20 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'117', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (139, CAST(N'2017-05-23 06:45:58.477' AS DateTime), 20, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'117', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-18', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (140, CAST(N'2017-05-23 06:47:22.730' AS DateTime), 20, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'117', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-18', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (141, NULL, 20, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'117', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (142, NULL, 20, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'117', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (143, CAST(N'2017-05-20 15:56:49.053' AS DateTime), 21, CAST(1000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-20 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'116', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (144, CAST(N'2017-05-22 07:13:51.027' AS DateTime), 21, CAST(4000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'116', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (145, CAST(N'2017-05-22 14:09:54.747' AS DateTime), 22, CAST(500.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'118', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (146, CAST(N'2017-05-22 17:00:36.910' AS DateTime), 23, CAST(1000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'119', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (147, CAST(N'2017-05-22 11:38:00.860' AS DateTime), 23, CAST(4000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'119', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (148, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (149, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (150, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (151, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (152, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (153, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (154, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (155, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (156, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (157, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (158, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (159, NULL, 23, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'119', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (160, CAST(N'2017-05-24 06:57:12.170' AS DateTime), 21, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'116', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-18 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (161, CAST(N'2017-05-23 12:03:35.867' AS DateTime), 24, CAST(2000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-23 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'120', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (162, CAST(N'2017-05-23 06:34:35.053' AS DateTime), 24, CAST(3000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-23 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'120', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (163, CAST(N'2017-05-23 12:08:27.047' AS DateTime), 25, CAST(2000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-23 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'121', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (164, CAST(N'2017-05-23 06:39:09.427' AS DateTime), 25, CAST(3000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-23 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'121', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (165, CAST(N'2017-05-23 12:19:44.487' AS DateTime), 26, CAST(3000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-23 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'122', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (166, CAST(N'2017-05-23 06:50:14.993' AS DateTime), 26, CAST(2000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-23 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'122', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (167, CAST(N'2017-05-24 06:55:53.510' AS DateTime), 25, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'121', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (168, CAST(N'2017-05-24 06:58:36.217' AS DateTime), 25, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'121', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (169, CAST(N'2017-05-24 07:00:42.243' AS DateTime), 25, CAST(10000.00 AS Decimal(18, 2)), 2, 3, NULL, NULL, NULL, NULL, NULL, N'121', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (170, NULL, 25, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'121', NULL, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (171, CAST(N'2017-05-25 16:30:28.173' AS DateTime), 27, CAST(2000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'125', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (172, CAST(N'2017-05-25 11:35:00.557' AS DateTime), 27, CAST(3000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'125', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (173, CAST(N'2017-05-25 11:38:20.033' AS DateTime), 27, CAST(1000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'125', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (174, CAST(N'2017-05-25 12:32:03.453' AS DateTime), 22, CAST(4500.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'118', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (175, CAST(N'2017-05-25 12:41:38.913' AS DateTime), 22, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (176, NULL, 22, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, 2, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (177, NULL, 22, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, 3, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (178, NULL, 22, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, 4, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (179, CAST(N'2017-05-25 18:14:35.823' AS DateTime), 28, CAST(2000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'124', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (180, CAST(N'2017-05-25 12:48:52.487' AS DateTime), 28, CAST(3000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'124', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (181, CAST(N'2017-05-25 12:54:08.743' AS DateTime), 28, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, NULL, N'124', 1, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (182, NULL, 28, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'124', 2, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (183, NULL, 28, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'124', 3, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (184, NULL, 28, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'124', 4, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-23 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (185, CAST(N'2017-05-26 11:40:49.743' AS DateTime), 29, CAST(1000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-26 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'126', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (186, CAST(N'2017-05-26 06:45:33.747' AS DateTime), 29, CAST(4000.00 AS Decimal(18, 2)), 1, 2, NULL, CAST(N'2017-05-26 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'126', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 1, 4, 1, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (187, NULL, 29, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'126', 1, CAST(2250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-07-26 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (188, NULL, 29, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'126', 2, CAST(2250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-07-26 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (189, NULL, 29, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'126', 1, CAST(2250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-07-26 00:00:00.000' AS DateTime), 1, 4, 0, 20)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId]) VALUES (190, NULL, 29, NULL, 1, 3, NULL, NULL, NULL, NULL, NULL, N'126', 2, CAST(2250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-07-26 00:00:00.000' AS DateTime), 1, 4, 0, 20)
SET IDENTITY_INSERT [dbo].[CandidateFee] OFF
SET IDENTITY_INSERT [dbo].[CandidateInstallment] ON 

INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (17, N'115', 45000, 5000, NULL, NULL, 40000, 1, 4, 4, 0, 0, NULL)
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (18, N'115', 45000, 5000, NULL, 4, 40000, 1, 4, 4, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (19, N'114', 44000, 5000, 1000, 4, NULL, 1, 4, 4, 0, 1, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (20, N'117', 45000, 5000, NULL, 4, 40000, 1, 4, 4, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (21, N'116', 45000, 5000, NULL, 1, 40000, 1, 4, 4, 0, 0, NULL)
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (22, N'118', 45000, 5000, NULL, 4, 40000, 1, 4, 4, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (23, N'119', 45000, 5000, NULL, 4, 40000, 1, 4, 4, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (24, N'120', 45000, 5000, NULL, NULL, 40000, 1, 4, 5, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (25, N'121', 45000, 5000, NULL, 4, 40000, 1, 4, 5, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (26, N'122', 45000, 5000, NULL, NULL, 40000, 1, 4, 5, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (27, N'125', 45000, 5000, NULL, NULL, 40000, 1, 4, 5, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (28, N'124', 45000, 5000, NULL, 4, 40000, 1, 4, 4, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (29, N'126', 9500, 5000, NULL, 2, 9500, 1, 4, 6, 0, 0, N'MonthlyInstallment')
SET IDENTITY_INSERT [dbo].[CandidateInstallment] OFF
SET IDENTITY_INSERT [dbo].[CasteCategory] ON 

INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (1, N'SC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (2, N'ST', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (3, N'OBC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (4, N'MBC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (5, N'GEN', 4)
SET IDENTITY_INSERT [dbo].[CasteCategory] OFF
SET IDENTITY_INSERT [dbo].[Centre] ON 

INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (1, N'thane', N'NEST Thane', N'Thane', NULL, NULL, NULL, 1, 1, 1, 400602, N'bmthane@nidantech.com', 241314501, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (2, NULL, N'test', N'test', NULL, NULL, NULL, 1, 1, 1, 123456, N'test', 1234567890, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (3, NULL, N'NEST Nagpur', N'Nagpur', NULL, NULL, NULL, 1, 1, 1, 440004, N'bmngp@nidantech.com', 9689040418, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (4, NULL, N'NEST Jabalpur', N'Jabalpur', NULL, NULL, NULL, 1, 1, 1, 482002, N'bmjbp@nidantech.com', 7583833555, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (5, NULL, N'NEST Delhi', N'Vaishali, Delhi', NULL, NULL, NULL, 1, 1, 1, 201010, N'bmvaishali@nidantech.com', 8268105386, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (6, NULL, N'NEST Pune', N'Pune', NULL, NULL, NULL, 1, 15, 1, 123456, N'bmpune@nidantech.com', 12345678, 4)
SET IDENTITY_INSERT [dbo].[Centre] OFF
SET IDENTITY_INSERT [dbo].[CentreCourse] ON 

INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (6, 22, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (7, 2, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (8, 3, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (9, 5, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (11, 6, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (12, 15, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (13, 22, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (14, 6, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (15, 3, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (17, 8, 5, 4)
SET IDENTITY_INSERT [dbo].[CentreCourse] OFF
SET IDENTITY_INSERT [dbo].[CentreCourseInstallment] ON 

INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (6, 5, 1, 4)
INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (7, 4, 1, 4)
SET IDENTITY_INSERT [dbo].[CentreCourseInstallment] OFF
SET IDENTITY_INSERT [dbo].[CentreScheme] ON 

INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (12, 2, 5, 4)
INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (13, 1, 5, 4)
INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (17, 1, 1, 4)
INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (18, 2, 1, 4)
SET IDENTITY_INSERT [dbo].[CentreScheme] OFF
SET IDENTITY_INSERT [dbo].[CentreSector] ON 

INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (5, 4, 1, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (7, 1, 1, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (8, 2, 5, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (9, 11, 5, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (10, 2, 1, 4)
SET IDENTITY_INSERT [dbo].[CentreSector] OFF
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
SET IDENTITY_INSERT [dbo].[Counselling] ON 

INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (13, 115, N'Mr.', N'Vijay', N'Nanasaheb', N'Raut', 1, 4, 20, 2, N'4 pm', NULL, CAST(N'2017-05-19' AS Date), NULL, 0, N'No', 90, NULL, NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (14, 114, N'Mrs.', N'Shubham', N'Vijay', N'Paradkar', 1, 4, 20, 2, N'9 am', N'.net mvc', CAST(N'2017-05-19' AS Date), NULL, 0, N'No', 90, NULL, NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (15, 114, N'Mrs.', N'Shubham', N'Vijay', N'Paradkar', 1, 4, 20, 2, N'9 am', N'.net mvc', CAST(N'2017-05-19' AS Date), NULL, 0, N'No', 90, NULL, NULL, NULL, 0)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (16, 114, N'Mrs.', N'Shubham', N'Vijay', N'Paradkar', 1, 4, 20, 2, N'9 am', NULL, CAST(N'2017-05-19' AS Date), NULL, 0, N'No', 90, NULL, NULL, NULL, 0)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (17, 116, N'Mrs.', N'Vasudha', N'Nagesh', N'Patil', 1, 4, 20, 2, NULL, NULL, CAST(N'2017-05-22' AS Date), NULL, 0, N'No', 80, NULL, NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (18, 117, N'Mr.', N'Sanjay', N'S', N'Prajapati', 1, 4, 20, 2, NULL, NULL, CAST(N'2017-05-22' AS Date), NULL, 0, N'No', 90, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Counselling] OFF
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (24, N'PankajCountry', 4)
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (25, N'PankajCountry2', 4)
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (29, N'Test', 4)
SET IDENTITY_INSERT [dbo].[Country] OFF
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (1, N'NSDC-LSC-CILT - DIPLOMA IN LOGISTICS OPERATIONS
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (2, N'NEST-IT-NIDAN CERTIFIED - .NET Software Development Program', 4, 2, 1, NULL, NULL, 144)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (3, N'NEST-IT-NIDAN CERTIFIED - Accounting Professional
', 4, 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (4, N'NSDC-ESSCI-NIDAN CERTIFIED - Computer Hardware & Networking
', 4, 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (5, N'NEST-IT-NIDAN CERTIFIED - Java Software Development Program
', 4, 2, 1, NULL, NULL, 144)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (6, N'NEST-IT-NIDAN CERTIFIED - Open Source Application Development Program
', 4, 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (7, N'NSDC-LSC-Transport Coordinator
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (8, N'NSDC-LSC-Consignment Booking Assistant
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (9, N'NSDC-LSC-Consignment Tracking Executive
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (10, N'NSDC-LSC-Warehouse Supervisor
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (11, N'NSDC-LSC-Warehouse Picker
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (12, N'NSDC-LSC-Warehouse Binner
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (13, N'NSDC-LSC-Inventory Clerk
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (14, N'NSDC-LSC-Warehouse Packer
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (15, N'NSDC-LSC-Transport Consolidator
', 4, 1, 1, NULL, NULL, 104)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (16, N'NSDC-ESSCI-Field Technician Computing & Peripherals
', 4, 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (17, N'NSDC-ESSCI-Field Technician Network & Storage
', 4, 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (18, N'NSDC-Apparel-Sewing Machine Operator
', 4, 4, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (19, N'NSDC-Retail-Sales Associate
', 4, 5, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (20, N'NSDC-Telecom-Customer Care Executive
', 4, 6, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (21, N'NSDC-LSC-Transport Operation Assistant
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (22, N'NEST-IT-MIS
', 4, 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (23, N'PMKVY2.0-LSC-Consignment Booking Assistant', 4, 11, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (24, N'PMKVY2.0-LSC-Documentation Assistant', 4, 11, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (25, N'PMKVY2.0-NASSCOM-Domestic Data Entry Operator', 4, 7, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (26, N'PMKVY2.0-Apparel-Sewing  Machine Operator ', 4, 13, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (27, N'PMKVY2.0-Apparel-Hand Embroiderer', 4, 13, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (28, N'PMKVY2.0-Apparel-Self Employed Tailor ', 4, 13, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (29, N'PMKVY2.0-ESSCI-Field Technician Computing and Peripherals', 4, 14, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (30, N'PMKVY2.0-ESSCI-Field Technician Networking and Storage', 4, 14, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (31, N'PMKVY2.0-ESSCI-Mobile Phone Hardware Repair Technician', 4, 14, 2, NULL, NULL, 144)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (32, N'PMKVY2.0-ESSCI-Field Engineer RACW', 4, 14, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (33, N'PMKVY2.0-ESSCI-LED Light Repair Technician', 4, 14, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (34, N'PMKVY2.0-BEAUTY & WELLNEES-Assistant Beauty Therapist', 4, 8, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (35, N'PMKVY2.0-BEAUTY & WELLNEES-Assistant Hair Stylist
', 4, 8, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (36, N'PMKVY2.0-BEAUTY & WELLNEES-Pedicurist & Manicurist
', 4, 8, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (37, N'PMKVY2.0-Life Sciences-Medical Sales Representative
', 4, 9, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (39, N'Others', 4, 10, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (42, N'Others', 4, 15, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (44, N'test', 4, 1, 1, 1, N'test', NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (45, N'test duration', 4, 2, 1, 1, N'test duration', 144)
SET IDENTITY_INSERT [dbo].[Course] OFF
SET IDENTITY_INSERT [dbo].[CourseInstallment] ON 

INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (4, N'.Net Course Installment', 2, 45000, 5000, 40000, 4, NULL, 1, CAST(N'2017-05-17' AS Date))
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (5, N'Java Course Installment', 5, 45000, 5000, 40000, 4, NULL, 1, CAST(N'2017-05-23' AS Date))
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (6, N'Transport Consolidator', 15, 9500, 5000, 9500, 4, NULL, 1, CAST(N'2017-05-26' AS Date))
SET IDENTITY_INSERT [dbo].[CourseInstallment] OFF
SET IDENTITY_INSERT [dbo].[CourseType] ON 

INSERT [dbo].[CourseType] ([CourseTypeId], [Name], [OrganisationId]) VALUES (1, N'Theory', 4)
INSERT [dbo].[CourseType] ([CourseTypeId], [Name], [OrganisationId]) VALUES (2, N'Lab', 4)
SET IDENTITY_INSERT [dbo].[CourseType] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentId], [Name], [OrganisationId], [ColourId]) VALUES (24, N'IT', 4, 19)
INSERT [dbo].[Department] ([DepartmentId], [Name], [OrganisationId], [ColourId]) VALUES (25, N'Testing', 4, 32)
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[District] ON 

INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (1, N'Anantapur', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (2, N'Chittoor', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (3, N'East Godavari', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (4, N'Guntur', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (5, N'Kadapa', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (6, N'Krishna', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (7, N'Kurnool', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (8, N'Nellore', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (9, N'Prakasam', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (10, N'Srikakulam', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (11, N'Visakhapatnam', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (12, N'Vizianagaram', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (13, N'West Godavari', 4, 1)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (14, N'Tawang', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (15, N'West Kameng', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (16, N'East Kameng', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (17, N'Papum Pare', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (18, N'Kurung Kumey', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (19, N'Kra Daadi', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (20, N'Lower Subansiri', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (21, N'Upper Subansiri', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (22, N'West Siang', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (23, N'East Siang', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (24, N'Central Siang', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (25, N'Upper Siang', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (26, N'Lower Dibang Valley', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (27, N'Upper Dibang Valley', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (28, N'Anjaw', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (29, N'Lohit', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (30, N'Namsai', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (31, N'Changlang', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (32, N'Tirap', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (33, N'Longding', 4, 2)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (34, N'Baksa', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (35, N'Barpeta', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (36, N'Biswanath', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (37, N'Bongaigaon', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (38, N'Cachar', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (39, N'Charaideo', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (40, N'Chirang', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (41, N'Darrang', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (42, N'Dhemaji', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (43, N'Dhubri', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (44, N'Dibrugarh', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (45, N'Goalpara', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (46, N'Golaghat', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (47, N'Hailakandi', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (48, N'Hojai', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (49, N'Jorhat', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (50, N'Kamrup Metropolitan', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (51, N'Kamrup', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (52, N'Karbi Anglong', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (53, N'Karimganj', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (54, N'Kokrajhar', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (55, N'Lakhimpur', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (56, N'Majuli', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (57, N'Morigaon', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (58, N'Nagaon', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (59, N'Nalbari', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (60, N'Dima Hasao', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (61, N'Sivasagar', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (62, N'Sonitpur', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (63, N'South Salmara-Mankachar', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (64, N'Tinsukia', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (65, N'Udalguri', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (66, N'West Karbi Anglong', 4, 3)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (67, N'Araria', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (68, N'Arwal', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (69, N'Aurangabad', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (70, N'Banka', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (71, N'Begusarai', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (72, N'Bhagalpur', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (73, N'Bhojpur', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (74, N'Buxar', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (75, N'Darbhanga', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (76, N'East Champaran', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (77, N'Gaya', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (78, N'Gopalganj', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (79, N'Jamui', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (81, N'Jehanabad', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (83, N'Khagaria', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (84, N'Kishanganj', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (85, N'Kaimur', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (86, N'Katihar', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (87, N'Lakhisarai', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (88, N'Madhubani', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (89, N'Munger', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (90, N'Madhepura', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (91, N'Muzaffarpur', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (92, N'Nalanda', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (93, N'Nawada', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (94, N'Patna', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (95, N'Purnia', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (96, N'Rohtas', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (97, N'Saharsa', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (98, N'Samastipur', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (99, N'Sheohar', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (100, N'Sheikhpura', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (101, N'Saran', 4, 4)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (102, N'Sitamarhi', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (103, N'Supaul', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (104, N'Siwan', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (105, N'Vaishali', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (106, N'West Champaran', 4, 4)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (107, N'Balod', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (108, N'Baloda Bazar', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (109, N'Balrampur', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (110, N'Bemetara', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (111, N'	Bijapur', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (112, N'Bilaspur', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (113, N'Dantewada', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (114, N'Dhamtari', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (115, N'Durg', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (116, N'Gariaband', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (117, N'Jagdalpur (Madhya Bastar)', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (118, N'Janjgir-Champa', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (119, N'Jashpur', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (120, N'Kabirdham', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (121, N'Kanker', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (122, N'Kondagaon', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (123, N'Korba', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (124, N'Koriya', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (125, N'Mahasamund', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (126, N'Mungeli', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (127, N'Narayanpur', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (128, N'Raigarh', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (129, N'Raipur', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (130, N'Rajnandgaon', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (131, N'Sukma', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (132, N'Surajpur', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (133, N'Surguja', 4, 5)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (134, N'North Goa(Panaji)', 4, 6)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (135, N'South Goa(Margao)', 4, 6)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (136, N'Ahmedabad', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (137, N'Amreli', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (138, N'Anand', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (139, N'Aravalli', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (140, N'Banaskantha', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (141, N'Bharuch', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (142, N'Bhavnagar', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (143, N'Botad', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (144, N'Chhota Udaipur', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (145, N'Dahod', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (146, N'Dang', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (147, N'Devbhoomi Dwarka', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (148, N'Gandhinagar', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (149, N'Gir Somnath', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (150, N'Jamnagar', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (151, N'Junagadh', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (152, N'Kutch', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (153, N'Kheda', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (154, N'Mahisagar', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (155, N'Mehsana', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (156, N'Morbi', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (157, N'Narmada', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (158, N'Navsari', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (159, N'Panchmahal', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (160, N'Patan', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (161, N'Porbandar', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (162, N'Rajkot', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (163, N'Sabarkantha', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (164, N'Surat', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (165, N'Surendranagar', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (166, N'Tapi', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (167, N'Vadodara', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (168, N'Valsad', 4, 7)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (169, N'Ambala', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (170, N'Bhiwani', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (171, N'Faridabad', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (172, N'Fatehabad', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (173, N'Gurugram', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (174, N'Hisar', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (175, N'Jhajjar', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (176, N'Jind', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (177, N'Karnal', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (178, N'Kaithal', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (179, N'Kurukshetra', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (180, N'Mahendragarh', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (181, N'Mewat', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (182, N'Panchkula', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (183, N'Palwal', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (184, N'Panipat', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (185, N'Rewari', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (186, N'Rohtak', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (187, N'Sirsa', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (188, N'Sonipat', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (189, N'Yamuna Nagar', 4, 8)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (190, N'Bilaspur', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (191, N'Chamba', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (192, N'Hamirpur', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (193, N'Kangra', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (194, N'Kinnaur', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (195, N'Kullu', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (196, N'Lahaul and Spiti', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (197, N'Mandi', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (198, N'Shimla', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (199, N'Sirmaur', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (200, N'Solan', 4, 9)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (201, N'Una', 4, 9)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (202, N'Doda', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (203, N'Jammu', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (204, N'Kathua', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (205, N'Kishtwar', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (206, N'Poonch', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (207, N'Rajouri', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (208, N'Ramban', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (209, N'Reasi', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (210, N'Samba', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (211, N'Udhampur', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (212, N'Anantnag', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (213, N'Bandipora', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (214, N'Baramulla', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (215, N'Budgam', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (216, N'Ganderbal', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (217, N'Kulgam', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (218, N'Kupwara', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (219, N'Pulwama', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (220, N'Shopian', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (221, N'Srinagar', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (222, N'Kargil', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (223, N'Leh', 4, 10)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (224, N'Garhwa', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (225, N'Palamu', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (226, N'Latehar', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (227, N'Chatra', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (228, N'Hazaribagh', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (229, N'Koderma', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (230, N'Giridih', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (231, N'Ramgarh', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (232, N'Bokaro', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (233, N'Dhanbad', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (234, N'Lohardaga', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (235, N'Gumla', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (236, N'Simdega', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (237, N'Ranchi', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (238, N'Khunti', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (239, N'West Singhbhum', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (240, N'Saraikela Kharsawan', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (241, N'East Singhbhum', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (242, N'Jamtara', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (243, N'Deoghar', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (244, N'Dumka', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (245, N'Pakur', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (246, N'Godda', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (247, N'Sahebganj', 4, 11)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (248, N'Bagalkot', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (249, N'Bangalore', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (250, N'Bangalore Rural', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (251, N'Belgaum', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (252, N'Bellary', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (253, N'Bidar', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (254, N'Bijapur', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (255, N'Chamarajanagar', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (256, N'Chikkaballapura', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (257, N'Chikmagalur', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (258, N'Chitradurga', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (259, N'Dakshina Kannada', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (260, N'Davanagere', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (261, N'Dharwad', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (262, N'Gadag', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (263, N'Gulbarga', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (264, N'Hassan', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (265, N'Haveri', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (266, N'Kodagu', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (267, N'Kolar', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (268, N'Koppal', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (269, N'Mandya', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (270, N'Mysore', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (271, N'Raichur', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (272, N'Ramanagara', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (273, N'Shimoga', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (274, N'Tumkur', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (275, N'Udupi', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (276, N'Uttara Kannada', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (277, N'Yadgir', 4, 12)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (278, N'Alappuzha', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (279, N'Ernakulam', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (280, N'Idukki', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (281, N'Kannur', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (282, N'Kasaragod', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (283, N'Kollam', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (284, N'Kottayam', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (285, N'Kozhikode', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (286, N'Malappuram', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (287, N'Palakkad', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (288, N'Pathanamthitta', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (289, N'Thiruvananthapuram', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (290, N'Thrissur', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (291, N'Wayanad', 4, 13)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (292, N'Agar', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (293, N'Alirajpur', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (294, N'Anuppur', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (295, N'Ashok Nagar', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (296, N'Balaghat', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (297, N'Barwani', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (298, N'Betul', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (299, N'Bhind', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (300, N'Bhopal', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (301, N'Burhanpur', 4, 14)
GO
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (302, N'Chhatarpur', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (303, N'Chhindwara', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (304, N'Damoh', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (305, N'Datia', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (306, N'Dewas', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (307, N'Dhar', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (308, N'Dindori', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (309, N'Guna', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (310, N'Gwalior', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (311, N'Harda', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (312, N'Hoshangabad', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (313, N'Indore', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (314, N'Jabalpur', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (315, N'Jhabua', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (316, N'Katni', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (317, N'Khandwa(East Nimar)', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (318, N'Khargone(West Nimar)', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (319, N'Mandla', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (320, N'Mandsaur', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (321, N'Morena', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (322, N'Narsinghpur', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (323, N'Neemuch', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (324, N'Panna', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (325, N'Raisen', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (326, N'Rajgarh', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (327, N'Ratlam', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (328, N'Rewa', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (329, N'Sagar', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (330, N'Satna', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (331, N'Sehore', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (332, N'Seoni', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (333, N'Shahdol', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (334, N'Shajapur', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (335, N'Sheopur', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (336, N'Shivpuri', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (337, N'Sidhi', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (338, N'Singrauli', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (339, N'Tikamgarh', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (340, N'Ujjain', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (341, N'Umaria', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (342, N'Vidisha', 4, 14)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (343, N'Ahmadnagar', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (344, N'Akola', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (345, N'Amravati', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (346, N'Aurangabad', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (347, N'Bhandara', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (348, N'Bid', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (349, N'Buldana', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (350, N'Chandrapur', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (351, N'Dhule', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (352, N'Gadchiroli', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (353, N'Gondiya', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (354, N'Hingoli', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (355, N'Jalgaon', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (356, N'Jalna', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (357, N'Kolhapur', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (358, N'Latur', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (359, N'Mumbai City', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (360, N'Mumbai Suburban', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (361, N'Nagpur', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (362, N'Nanded', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (363, N'Nandurbar', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (364, N'Nashik', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (365, N'Osmanabad', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (366, N'Palghar', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (367, N'Parbhani', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (368, N'Pune', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (369, N'Raigarh', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (370, N'Ratnagiri', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (371, N'Sangli', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (372, N'Satara', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (373, N'Sindhudurg', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (374, N'Solapur', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (375, N'Thane', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (376, N'Wardha', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (377, N'Washim', 4, 15)
INSERT [dbo].[District] ([DistrictId], [Name], [OrganisationId], [StateId]) VALUES (378, N'Yavatmal', 4, 15)
SET IDENTITY_INSERT [dbo].[District] OFF
SET IDENTITY_INSERT [dbo].[Document] ON 

INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1023, N'116', N'Vasudha', N'Abbreviations.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Vasudha_116\Counselling History\Counselling History_4f22d629-eb72-4bdc-ab0a-c582f74f183b_Abbreviations.pdf', 6, N'4f22d629-eb72-4bdc-ab0a-c582f74f183b', CAST(N'2017-05-20 00:00:00.000' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1024, N'117', N'Sanjay', N'5-10-vol-3-2-14-gjedt.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Sanjay_117\psychometric\psychometric_eb153f3f-5e94-492c-83e0-9912be98d31c_5-10-vol-3-2-14-gjedt.pdf', 2, N'eb153f3f-5e94-492c-83e0-9912be98d31c', CAST(N'2017-05-20 00:00:00.000' AS DateTime), NULL, 4, 1)
SET IDENTITY_INSERT [dbo].[Document] OFF
SET IDENTITY_INSERT [dbo].[DocumentType] ON 

INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (2, N'psychometric', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (6, N'Counselling History', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (9, N'Trainer Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
SET IDENTITY_INSERT [dbo].[DocumentType] OFF
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

INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (114, N'Mrs.', N'Shubham', N'Vijay', N'Paradkar', 9870245680, NULL, N'shubham@gmail.com', NULL, 21, N'thane', NULL, NULL, NULL, 1, 1, 1, 400709, N'Vijay Paradkar', NULL, 1, 1, 5, N'Male', 2, NULL, NULL, 0, 1, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-17' AS Date), N'114', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-21 00:00:00.000' AS DateTime), 1, N'Yes', N'Admission Done', 70, NULL, NULL, 1, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (115, N'Mr.', N'Vijay', N'Nanasaheb', N'Raut', 9773606038, NULL, N'vijayraut33@gmail.com', CAST(N'1993-01-27' AS Date), 25, N'KALEKAR CHAWL ONGC BLDG,12/13/3 FLR,DHARAVI,  SANT ROHIDAS MARG', NULL, NULL, NULL, 1, 1, 1, 400017, N'Nanasaheb Raut', NULL, 1, 1, 3, N'Male', 4, NULL, NULL, 0, 3, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-17' AS Date), N'115', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), 5, N'Yes', N'Admission Done', 70, NULL, NULL, 1, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (116, N'Mrs.', N'Vasudha', N'Nagesh', N'Patil', 4545454545, NULL, N'vasudha@gmail.com', CAST(N'2017-05-26' AS Date), 23, N'201,SAI PRERANA,SECTOR 19,KOPAR KHAIRNE', NULL, NULL, NULL, 1, 15, 343, 400709, NULL, NULL, 3, 4, 1, N'Female', 1, NULL, NULL, 0, 2, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-20' AS Date), N'116', N'Registration', NULL, NULL, NULL, 0, 1, 3, 1, 2, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-05-22 05:26:53.507' AS DateTime), 1, N'Yes', N'Admission Done', 90, NULL, NULL, 1, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (117, N'Mr.', N'Sanjay', N'S', N'Prajapati', 8097537537, NULL, N'sanjay@gmail.com', NULL, 28, N'201,SAI PRERANA,SECTOR 19,KOPAR KHAIRNE', NULL, NULL, NULL, 1, 1, 1, 421306, NULL, NULL, 5, 1, 5, N'Male', 4, NULL, NULL, 0, 1, N'Fresher', N'UnEmployed', N'No', CAST(N'2017-05-20' AS Date), N'117', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-22 08:12:39.997' AS DateTime), 1, N'Yes', N'Admission Done', 90, NULL, NULL, 1, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (118, N'Mr.', N'Vinayak', N'Maruti', N'Mane', 9999999999, NULL, N'vinayak@gmail.com', NULL, 20, N'sion', NULL, NULL, NULL, 1, 1, 1, 400017, NULL, NULL, 5, 1, 1, N'Male', 4, NULL, NULL, 0, 3, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-20' AS Date), N'118', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-22 10:45:44.007' AS DateTime), 6, N'Yes', N'Admission Done', 90, NULL, NULL, 0, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (119, N'Mr.', N'Test', N'Enquiry', N'Admission', 1111111111, NULL, N'abc@gmail.com', NULL, 21, N'Vashi', NULL, NULL, NULL, 1, 1, 1, 123456, NULL, NULL, 1, 1, 5, N'Male', 4, NULL, NULL, 0, 5, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-22' AS Date), N'119', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-24 11:30:13.077' AS DateTime), 6, N'No', NULL, 70, NULL, NULL, 0, 1, 0, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (120, N'Ms.', N'Divya', N'Badal', N'Thorat', 9870475011, NULL, N'divyathorat@gmail.com', NULL, 21, N'Thane', NULL, NULL, NULL, 1, 1, 1, 123456, NULL, NULL, 1, 1, 5, N'Female', 7, NULL, NULL, 0, 3, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-23' AS Date), N'120', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-25 06:31:05.973' AS DateTime), 5, N'Yes', N'Admission Done', 80, NULL, NULL, 0, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (121, N'Mrs.', N'D', N'E', N'F', 8702458790, NULL, N'def@gmail.com', NULL, 20, N'sion', NULL, NULL, NULL, 1, 1, 1, 123456, NULL, NULL, 2, 1, 1, N'Female', 2, NULL, NULL, 0, 4, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-23' AS Date), N'121', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-25 06:38:09.027' AS DateTime), 2, N'Yes', N'Admission Done', 70, NULL, NULL, 0, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (122, N'Mr.', N'Aditya', N'Ganesh', N'Gade', 8888888888, NULL, N'aditya@gmail.com', NULL, 24, N'Digha', NULL, NULL, NULL, 1, 1, 1, 123456, NULL, NULL, 5, 1, 5, N'Male', 4, NULL, NULL, 0, 6, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-23' AS Date), N'122', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-25 06:49:27.273' AS DateTime), 9, N'Yes', N'Admission Done', 40, NULL, NULL, 0, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (123, N'Mr.', N'Aditya', N'Vilas', N'BHosale', 5555555555, NULL, N'aditya@gmail.com', CAST(N'2017-05-10' AS Date), 25, N'201,SAI PRERANA,SECTOR 19,KOPAR KHAIRNE', NULL, NULL, NULL, 1, 15, 343, 421306, NULL, NULL, 1, 1, 5, N'Male', 1, NULL, NULL, 0, 2, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-23' AS Date), N'123', N'Enquiry', NULL, NULL, NULL, 0, 1, 1, 1, 1, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-25 08:33:40.827' AS DateTime), 1, N'No', NULL, 90, NULL, NULL, 0, 0, 0, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (124, N'Mr.', N'Neha', N'Paresh', N'Joshi', 5465465465, 4546546546, N'neha@gmail.com', CAST(N'2017-05-23' AS Date), 24, N'Panvel', NULL, NULL, NULL, 1, 1, 1, 123456, NULL, NULL, 1, 1, 1, N'Female', 1, NULL, NULL, 0, 6, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-23' AS Date), N'124', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), 4, N'Yes', N'Admission Done', 80, NULL, NULL, 0, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (125, N'Mr.', N'test', N'r', N't', 7777777777, NULL, N'swapnil@gmail.com', CAST(N'2017-05-25' AS Date), 77, N'201,SAI PRERANA,SECTOR 19,KOPAR KHAIRNE', NULL, NULL, NULL, 1, 1, 1, 442424, NULL, NULL, 1, 1, 1, N'Male', 1, NULL, NULL, 0, 1, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-25' AS Date), N'125', N'Registration', NULL, NULL, NULL, 0, 1, 2, 3, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-27 00:00:00.000' AS DateTime), 1, N'Yes', N'Admission Done', 90, NULL, NULL, 0, 1, 1, 1, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (126, N'Ms.', N'Pooja', N'Vasudev', N'Patil', 7845452121, NULL, N'pooja@gmail.com', CAST(N'2017-06-22' AS Date), 22, N'Nerul', NULL, NULL, NULL, 1, 1, 1, 400708, NULL, NULL, 1, 1, 5, N'Female', 2, NULL, NULL, 0, 2, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-26' AS Date), N'126', N'Registration', NULL, NULL, NULL, 0, 1, 3, 3, 1, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-05-28 05:52:20.533' AS DateTime), 1, N'Yes', N'Admission Done', 80, NULL, NULL, 0, 1, 1, 1, 4)
SET IDENTITY_INSERT [dbo].[Enquiry] OFF
SET IDENTITY_INSERT [dbo].[EnquiryCourse] ON 

INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (48, 114, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (49, 115, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (50, 115, 5, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (51, 115, 6, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (52, 116, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (53, 117, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (54, 118, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (55, 118, 5, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (56, 119, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (57, 119, 5, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (58, 120, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (59, 120, 6, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (60, 120, 5, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (61, 121, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (62, 121, 5, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (63, 121, 6, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (64, 122, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (65, 122, 5, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (66, 122, 6, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (67, 123, 15, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (68, 124, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (69, 125, 2, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (70, 125, 3, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (71, 125, 22, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (72, 125, 5, 1, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (73, 126, 15, 1, 4)
SET IDENTITY_INSERT [dbo].[EnquiryCourse] OFF
SET IDENTITY_INSERT [dbo].[EnquiryType] ON 

INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (1, N'Walk-In', 4)
INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (2, N'Tele-In', 4)
INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (3, N'Event', 4)
SET IDENTITY_INSERT [dbo].[EnquiryType] OFF
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (3, N'Seminar', N'Amit Sir', CAST(N'2016-11-05 00:00:00.000' AS DateTime), 1, 4, 1)
INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (12, N'Test', NULL, CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (14, N'Job Fair Mumbai', NULL, NULL, NULL, 4, 1)
SET IDENTITY_INSERT [dbo].[Event] OFF
SET IDENTITY_INSERT [dbo].[EventFunctionType] ON 

INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (1, N'Brain Storming', 4)
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (2, N'Planning', 4)
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (3, N'Budget', 4)
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (4, N'Event Day', 4)
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (5, N'Post Event', 4)
SET IDENTITY_INSERT [dbo].[EventFunctionType] OFF
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (1, N'Registration')
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (2, N'Admission')
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (3, N'Installment')
SET IDENTITY_INSERT [dbo].[FollowUp] ON 

INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (31, CAST(N'2017-05-19 00:00:00.000' AS DateTime), 45, NULL, NULL, NULL, N'Mrs.', N'Shubham', N'Vijay', N'Paradkar', NULL, NULL, CAST(N'1917-05-17 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 4, 1, 9870245680, 39, N'Mobilization', NULL, N'/Mobilization/Edit/45', N'Yes', N'Converted To Enquiry', NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (32, CAST(N'2017-05-19 00:00:00.000' AS DateTime), 46, NULL, NULL, NULL, N'Mrs.', N'D', N'E', N'F', N'Converted To Enquiry', NULL, CAST(N'1917-05-17 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 4, 1, 8702458790, 39, N'Mobilization', NULL, N'/Mobilization/Edit/46', N'Yes', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (33, CAST(N'2017-05-19 00:00:00.000' AS DateTime), 47, NULL, NULL, NULL, N'Mrs.', N'G', N'H', N'I', NULL, NULL, CAST(N'1917-05-17 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 4, 1, 7895425481, 39, N'Mobilization', NULL, N'/Mobilization/Edit/47', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (34, CAST(N'2017-05-19 00:00:00.000' AS DateTime), 48, NULL, NULL, NULL, N'Mrs.', N'J', N'K', N'L', NULL, NULL, CAST(N'1917-05-17 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 4, 1, 8715724520, 39, N'Mobilization', NULL, N'/Mobilization/Edit/48', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (35, CAST(N'2017-05-19 00:00:00.000' AS DateTime), 49, NULL, NULL, NULL, N'Mrs.', N'M', N'N', N'O', NULL, NULL, CAST(N'1917-05-17 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 4, 1, 9714725415, 39, N'Mobilization', NULL, N'/Mobilization/Edit/49', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (36, CAST(N'2017-05-21 00:00:00.000' AS DateTime), NULL, 114, 16, 12, N'Mrs.', N'Shubham', N'Vijay', N'Paradkar', NULL, NULL, CAST(N'1917-05-17 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 4, 1, 9870245680, 2, N'Admission', NULL, N'/Registration/Edit/12', N'Yes', N'Admission Done', NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (37, CAST(N'2017-05-22 00:00:00.000' AS DateTime), NULL, 115, 13, 11, N'Mr.', N'Vijay', N'Nanasaheb', N'Raut', NULL, NULL, CAST(N'1917-05-17 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 4, 1, 9773606038, 2, N'Admission', NULL, N'/Registration/Edit/11', N'Yes', N'Admission Done', NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (38, CAST(N'2017-05-22 00:00:00.000' AS DateTime), NULL, 116, 17, 14, N'Mrs.', N'Vasudha', N'Nagesh', N'Patil', NULL, NULL, CAST(N'1917-05-20 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 4, 1, 4545454545, 2, N'Admission', NULL, N'/Registration/Edit/14', N'Yes', N'Admission Done', NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (39, CAST(N'2017-05-22 00:00:00.000' AS DateTime), 50, NULL, NULL, NULL, N'Mr.', N'Sanjay', N'S', N'Prajapati', N'Converted To Enquiry', NULL, CAST(N'1917-05-20 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 4, 1, 8097537537, 2, N'Mobilization', NULL, N'/Mobilization/Edit/50', N'Yes', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (40, CAST(N'2017-05-22 00:00:00.000' AS DateTime), NULL, 117, 18, 13, N'Mr.', N'Sanjay', N'S', N'Prajapati', NULL, NULL, CAST(N'1917-05-20 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 4, 1, 8097537537, 2, N'Admission', NULL, N'/Registration/Edit/13', N'Yes', N'Admission Done', NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (41, CAST(N'2017-05-22 00:00:00.000' AS DateTime), NULL, 118, NULL, 15, N'Mr.', N'Vinayak', N'Maruti', N'Mane', NULL, NULL, CAST(N'1917-05-20 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 4, 1, 9999999999, 2, N'Registration', NULL, N'/Registration/Edit/15', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (42, CAST(N'2017-05-24 00:00:00.000' AS DateTime), NULL, 119, NULL, 16, N'Mr.', N'Test', N'Enquiry', N'Admission', NULL, NULL, CAST(N'1917-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-22 00:00:00.000' AS DateTime), 4, 1, 1111111111, 2, N'Registration', NULL, N'/Registration/Edit/16', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (43, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, 120, NULL, 17, N'Ms.', N'Divya', N'Badal', N'Thorat', NULL, NULL, CAST(N'1917-05-23 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 4, 1, 9870475011, 5, N'Admission', NULL, N'/Registration/Edit/17', N'Yes', N'Admission Done', NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (44, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, 121, NULL, 18, N'Mrs.', N'D', N'E', N'F', NULL, NULL, CAST(N'1917-05-23 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 4, 1, 8702458790, 5, N'Admission', NULL, N'/Registration/Edit/18', N'Yes', N'Admission Done', NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (45, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, 122, NULL, 19, N'Mr.', N'Aditya', N'Ganesh', N'Gade', NULL, NULL, CAST(N'1917-05-23 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 4, 1, 8888888888, 5, N'Admission', NULL, N'/Registration/Edit/19', N'Yes', N'Admission Done', NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (46, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, 123, NULL, NULL, N'Mr.', N'Aditya', N'Vilas', N'BHosale', NULL, NULL, CAST(N'1917-05-23 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 4, 5, 5555555555, 0, N'Enquiry', NULL, N'/Enquiry/Edit/123', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (47, CAST(N'2017-05-25 00:00:00.000' AS DateTime), NULL, 124, NULL, 21, N'Mr.', N'Neha', N'Paresh', N'Joshi', NULL, NULL, CAST(N'1917-05-23 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 4, 1, 5465465465, 2, N'Registration', 4546546546, N'/Registration/Edit/21', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (48, CAST(N'2017-05-27 00:00:00.000' AS DateTime), NULL, 125, NULL, 20, N'Mr.', N'test', N'r', N't', NULL, NULL, CAST(N'1917-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-25 00:00:00.000' AS DateTime), 4, 1, 7777777777, 5, N'Registration', NULL, N'/Registration/Edit/20', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (49, CAST(N'2017-05-28 00:00:00.000' AS DateTime), NULL, 126, NULL, 22, N'Ms.', N'Pooja', N'Vasudev', N'Patil', NULL, NULL, CAST(N'1917-05-26 00:00:00.000' AS DateTime), CAST(N'2017-05-26 00:00:00.000' AS DateTime), 4, 1, 7845452121, 15, N'Admission', NULL, N'/Registration/Edit/22', N'Yes', N'Admission Done', 29)
SET IDENTITY_INSERT [dbo].[FollowUp] OFF
SET IDENTITY_INSERT [dbo].[FollowUpHistory] ON 

INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (1, 31, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (2, 32, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (3, 33, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (4, 34, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (5, 35, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (6, 31, N'Mobilization', NULL, N'Yes', N'Converted To Enquiry', CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (7, 36, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (8, 36, N'Enquiry', N'he will come with parents on 21st may', N'No', NULL, CAST(N'2017-05-21 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (9, 37, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (10, 37, N'Enquiry', N'Confused Between courses', N'No', NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (11, 37, N'Counselling', NULL, N'No', NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (12, 36, N'Counselling', NULL, N'No', NULL, CAST(N'2017-05-19 12:47:33.670' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (13, 37, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-19 13:02:53.943' AS DateTime), CAST(N'2017-05-17 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (14, 37, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-18 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (15, 36, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-21 09:02:59.837' AS DateTime), CAST(N'2017-05-19 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (16, 36, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-05-21 00:00:00.000' AS DateTime), CAST(N'2017-05-19 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (17, 38, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (18, 38, N'Counselling', NULL, N'No', NULL, CAST(N'2017-05-22 05:27:50.427' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (19, 39, N'Mobilization', N'Interested in .net course', N'No', NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (20, 39, N'Mobilization', N'Converted To Enquiry', N'Yes', NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (21, 40, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (22, 40, N'Counselling', NULL, N'No', NULL, CAST(N'2017-05-22 08:18:53.690' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (23, 40, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-22 08:25:45.677' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (24, 40, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (25, 38, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-22 10:26:47.957' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (26, 41, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-20 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (27, 38, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-05-22 00:00:00.000' AS DateTime), CAST(N'2017-05-22 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (28, 41, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-24 08:39:54.577' AS DateTime), CAST(N'2017-05-22 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (29, 42, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-24 00:00:00.000' AS DateTime), CAST(N'2017-05-22 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (30, 42, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-24 11:30:36.897' AS DateTime), CAST(N'2017-05-22 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (31, 43, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (32, 43, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-25 06:33:35.777' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (33, 43, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (34, 32, N'Mobilization', N'Converted To Enquiry', N'Yes', NULL, CAST(N'2017-05-19 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (35, 44, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (36, 44, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-25 06:38:27.027' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (37, 44, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (38, 45, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (39, 45, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-25 06:49:44.467' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (40, 45, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (41, 46, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (42, 47, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-25 00:00:00.000' AS DateTime), CAST(N'2017-05-23 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (43, 48, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-27 00:00:00.000' AS DateTime), CAST(N'2017-05-25 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (44, 48, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-27 11:00:28.157' AS DateTime), CAST(N'2017-05-25 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (45, 47, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-27 12:44:35.797' AS DateTime), CAST(N'2017-05-25 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (46, 49, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-05-28 00:00:00.000' AS DateTime), CAST(N'2017-05-26 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (47, 49, N'Registration', NULL, N'No', NULL, CAST(N'2017-05-28 06:10:49.657' AS DateTime), CAST(N'2017-05-26 00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (48, 49, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-05-28 00:00:00.000' AS DateTime), CAST(N'2017-05-26 00:00:00.000' AS DateTime), 1, 4)
SET IDENTITY_INSERT [dbo].[FollowUpHistory] OFF
SET IDENTITY_INSERT [dbo].[Frequency] ON 

INSERT [dbo].[Frequency] ([FrequencyId], [Name], [Periods]) VALUES (1, N'Yearly', 1)
INSERT [dbo].[Frequency] ([FrequencyId], [Name], [Periods]) VALUES (2, N'Quarterly', 2)
SET IDENTITY_INSERT [dbo].[Frequency] OFF
SET IDENTITY_INSERT [dbo].[Holiday] ON 

INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (1, CAST(N'2017-01-14' AS Date), N'Makar Sankranti / Pongal', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (2, CAST(N'2017-01-26' AS Date), N'Republic Day', 4, N'Thursday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (3, CAST(N'2017-02-24' AS Date), N'Maha Shivaratri/Shivaratri', 4, N'Friday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (4, CAST(N'2017-03-13' AS Date), N'Holi', 4, N'Monday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (5, CAST(N'2017-04-04' AS Date), N'Rama Navami', 4, N'Tuesday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (6, CAST(N'2017-04-09' AS Date), N'Mahavir Jayanti', 4, N'Sunday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (7, CAST(N'2017-04-14' AS Date), N'Good Friday/Ambedkar Jayanti', 4, N'Friday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (8, CAST(N'2017-05-10' AS Date), N'Buddha Purnima/Vesak', 4, N'Wednesday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (9, CAST(N'2017-08-07' AS Date), N'Raksha Bandhan (Rakhi)', 4, N'Monday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (10, CAST(N'2017-08-15' AS Date), N'Independence Day/Janmashtami', 4, N'Tuesday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (11, CAST(N'2017-08-25' AS Date), N'Ganesh Chaturthi/Vinayaka Chaturthi', 4, N'Friday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (12, CAST(N'2017-09-02' AS Date), N'Bakr Id/Eid ul-Adha', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (13, CAST(N'2017-09-30' AS Date), N'Dussehra (Maha Navami)', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (14, CAST(N'2017-10-01' AS Date), N'Muharram/Ashura', 4, N'Sunday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (15, CAST(N'2017-10-02' AS Date), N'Mahatma Gandhi Jayanti', 4, N'Monday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (16, CAST(N'2017-10-19' AS Date), N'Diwali/Deepavali', 4, N'Thursday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (17, CAST(N'2017-11-04' AS Date), N'Guru Nanak Jayanti', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (18, CAST(N'2017-12-02' AS Date), N'Milad un-Nabi/Id-e-Milad', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (19, CAST(N'2017-12-25' AS Date), N'Christmas', 4, N'Monday', 1)
SET IDENTITY_INSERT [dbo].[Holiday] OFF
SET IDENTITY_INSERT [dbo].[Host] ON 

INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (7, N'nidanserver', 4)
SET IDENTITY_INSERT [dbo].[Host] OFF
SET IDENTITY_INSERT [dbo].[HowDidYouKnowAbout] ON 

INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (1, N'Web Site', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (2, N'SMS', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (3, N'Banner', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (4, N'News Paper', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (5, N'Reference', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (6, N'Internet', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (7, N'Pamphlet', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (8, N'Event', 4)
SET IDENTITY_INSERT [dbo].[HowDidYouKnowAbout] OFF
SET IDENTITY_INSERT [dbo].[Mobilization] ON 

INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (45, 14, 4, N'Mrs.', N'Shubham', N'Vijay', N'Paradkar', 1, 9870245680, NULL, 2, 2, CAST(N'2017-05-17' AS Date), CAST(N'2017-05-19' AS Date), NULL, NULL, N'thane', NULL, CAST(N'2017-05-17' AS Date), 3, 20, N'Yes', N'Converted To Enquiry')
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (46, 14, 4, N'Mrs.', N'D', N'E', N'F', 1, 8702458790, NULL, 39, 2, CAST(N'2017-05-17' AS Date), CAST(N'2017-05-19' AS Date), NULL, NULL, N'sion', NULL, CAST(N'2017-05-17' AS Date), 3, 20, N'Yes', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (47, 14, 4, N'Mrs.', N'G', N'H', N'I', 1, 7895425481, NULL, 39, 3, CAST(N'2017-05-17' AS Date), CAST(N'2017-05-19' AS Date), NULL, NULL, N'belapur', NULL, CAST(N'2017-05-17' AS Date), 3, 20, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (48, 14, 4, N'Mrs.', N'J', N'K', N'L', 1, 8715724520, NULL, 39, 5, CAST(N'2017-05-17' AS Date), CAST(N'2017-05-19' AS Date), NULL, NULL, N'vashi', NULL, CAST(N'2017-05-17' AS Date), 3, 20, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (49, 14, 4, N'Mrs.', N'M', N'N', N'O', 1, 9714725415, NULL, 39, 6, CAST(N'2017-05-17' AS Date), CAST(N'2017-05-19' AS Date), NULL, NULL, N'mulund', NULL, CAST(N'2017-05-17' AS Date), 3, 20, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (50, 14, 4, N'Mr.', N'Sanjay', N'S', N'Prajapati', 1, 8097537537, NULL, 2, 4, CAST(N'2017-05-20' AS Date), CAST(N'2017-05-22' AS Date), N'Interested in .net course', NULL, NULL, NULL, CAST(N'2017-05-20' AS Date), 1, 20, N'Yes', NULL)
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
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (4, N'NEST')
SET IDENTITY_INSERT [dbo].[Organisation] OFF
SET IDENTITY_INSERT [dbo].[PaymentMode] ON 

INSERT [dbo].[PaymentMode] ([PaymentModeId], [Name], [OrganisationId]) VALUES (1, N'Cash', 4)
INSERT [dbo].[PaymentMode] ([PaymentModeId], [Name], [OrganisationId]) VALUES (2, N'Cheque', 4)
SET IDENTITY_INSERT [dbo].[PaymentMode] OFF
SET IDENTITY_INSERT [dbo].[Personnel] ON 

INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (20, 4, N'Mr', N'TEst', N'Test', CAST(N'2017-01-04 00:00:00.0000000' AS DateTime2), 24, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 2, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (21, 4, N'Mr', N'Abc', N'B', CAST(N'2017-01-05 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', NULL, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (22, 4, N'Mr', N'x', N'z', CAST(N'2017-01-12 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', NULL, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (23, 4, N'Mr', N'test1', N'B', CAST(N'2017-01-12 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', NULL, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (25, 4, N'Mr', N'Nidan', N'B', CAST(N'2017-02-04 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', NULL, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (26, 4, N'Mr', N'ThaneUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'bmthane@nidantech.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (28, 4, N'Mr', N'JabalpurUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ci_jbp@nidantech.com', NULL, 4)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (29, 4, N'Mr', N'NagpurUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ci_ngp@nidantech.com', NULL, 3)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (30, 4, N'Mr', N'DelhiUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'bmvaishali@nidantech.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (55, 4, N'Ms.', N'Ragini', N'Singh', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, N'Shahapur', NULL, NULL, NULL, N'123456', N'12345678', N'7558445874', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ragini@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (56, 4, N'Mr.', N'Vijay', N'Raut', CAST(N'1993-01-27 00:00:00.0000000' AS DateTime2), 0, N'KALEKAR CHAWL ONGC BLDG,12/13/3 FLR,DHARAVI,  SANT ROHIDAS MARG', NULL, NULL, NULL, N'400017', N'12345678', N'9773606038', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'vijayraut33@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (57, 4, N'Mrs.', N'Shubham', N'Paradkar', CAST(N'2017-05-19 09:04:33.4914320' AS DateTime2), 0, N'thane', NULL, NULL, NULL, N'400709', N'12345678', N'9870245680', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'shubham@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (58, 4, N'Mr.', N'Mohsin', N'Koltharkar', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, N'Kalwa', NULL, NULL, NULL, N'123456', N'12345678', N'9727810545', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'mohsin@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (59, 4, N'Mr.', N'Sanjay', N'Prajapati', CAST(N'2017-05-20 08:30:18.9608090' AS DateTime2), 0, N'201,SAI PRERANA,SECTOR 19,KOPAR KHAIRNE', NULL, NULL, NULL, N'421306', N'12345678', N'8097537537', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'sanjay@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (60, 4, N'Mrs.', N'Vasudha', N'Patil', CAST(N'2017-05-26 00:00:00.0000000' AS DateTime2), 0, N'201,SAI PRERANA,SECTOR 19,KOPAR KHAIRNE', NULL, NULL, NULL, N'400709', N'12345678', N'4545454545', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'vasudha@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (61, 4, N'Ms.', N'Divya', N'Thorat', CAST(N'2017-05-23 06:34:35.1144136' AS DateTime2), 0, N'Thane', NULL, NULL, NULL, N'123456', N'12345678', N'9870475011', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'divyathorat@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (62, 4, N'Mrs.', N'D', N'F', CAST(N'2017-05-23 06:39:44.1853688' AS DateTime2), 0, N'sion', NULL, NULL, NULL, N'123456', N'12345678', N'8702458790', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'def@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (63, 4, N'Mr.', N'Aditya', N'Gade', CAST(N'2017-05-23 06:50:17.4726822' AS DateTime2), 0, N'Digha', NULL, NULL, NULL, N'123456', N'12345678', N'8888888888', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'aditya@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (64, 4, N'Ms.', N'Pooja', N'Patil', CAST(N'2017-06-22 00:00:00.0000000' AS DateTime2), 0, N'Nerul', NULL, NULL, NULL, N'400708', N'12345678', N'7845452121', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'pooja@gmail.com', NULL, 1)
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
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionId], [Description], [EventFunctionTypeId], [OrganisationId]) VALUES (7, N'test edit', 1, 4)
INSERT [dbo].[Question] ([QuestionId], [Description], [EventFunctionTypeId], [OrganisationId]) VALUES (8, N'What is your name ?', 2, 4)
SET IDENTITY_INSERT [dbo].[Question] OFF
SET IDENTITY_INSERT [dbo].[Registration] ON 

INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (11, N'115', 115, 2, 4, 125, 18, NULL, CAST(N'2017-05-19 13:02:53.943' AS DateTime), 1, 4, 1, CAST(N'2017-05-17 13:02:57.427' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (12, N'114', 114, 2, 4, 131, 19, NULL, CAST(N'2017-05-21 09:02:59.837' AS DateTime), 1, 4, 1, CAST(N'2017-05-19 09:02:59.837' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (13, N'117', 117, 2, 4, 137, 20, NULL, CAST(N'2017-05-22 08:25:45.677' AS DateTime), 1, 4, 1, CAST(N'2017-05-20 08:25:45.677' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (14, N'116', 116, 2, 4, 143, 21, NULL, CAST(N'2017-05-22 10:26:47.957' AS DateTime), 1, 4, 1, CAST(N'2017-05-20 10:26:47.957' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (15, N'118', 118, 2, 4, 145, 22, NULL, CAST(N'2017-05-24 08:39:54.577' AS DateTime), 1, 4, 1, CAST(N'2017-05-22 08:39:54.577' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (16, N'119', 119, 2, 4, 146, 23, NULL, CAST(N'2017-05-24 11:30:36.897' AS DateTime), 1, 4, 1, CAST(N'2017-05-22 11:30:36.897' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (17, N'120', 120, 5, 5, 161, 24, NULL, CAST(N'2017-05-25 06:33:35.777' AS DateTime), 1, 4, 1, CAST(N'2017-05-23 06:33:35.777' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (18, N'121', 121, 5, 5, 163, 25, NULL, CAST(N'2017-05-25 06:38:27.027' AS DateTime), 1, 4, 1, CAST(N'2017-05-23 06:38:27.027' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (19, N'122', 122, 5, 5, 165, 26, NULL, CAST(N'2017-05-25 06:49:44.467' AS DateTime), 1, 4, 1, CAST(N'2017-05-23 06:49:44.467' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (20, N'125', 125, 5, 5, 171, 27, NULL, CAST(N'2017-05-27 11:00:28.157' AS DateTime), 1, 4, 1, CAST(N'2017-05-25 11:00:28.157' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (21, N'124', 124, 2, 4, 179, 28, NULL, CAST(N'2017-05-27 12:44:35.797' AS DateTime), 1, 4, 1, CAST(N'2017-05-25 12:44:35.797' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (22, N'126', 126, 15, 6, 185, 29, NULL, CAST(N'2017-05-28 06:10:49.657' AS DateTime), 1, 4, 1, CAST(N'2017-05-26 06:10:49.657' AS DateTime))
SET IDENTITY_INSERT [dbo].[Registration] OFF
SET IDENTITY_INSERT [dbo].[Religion] ON 

INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (1, N'Hindu', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (2, N'Muslim', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (3, N'Christen', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (4, N'Sikh', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (5, N'Jain', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (6, N'Buddha', 4)
SET IDENTITY_INSERT [dbo].[Religion] OFF
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([RoomId], [Description], [Number], [Floor], [OccupiedStartDate], [OccupiedEndDate], [OccupiedStartTime], [OccupiedEndTime], [RoomTypeId], [Capacity], [SquareFeet], [OrganisationId], [CentreId]) VALUES (5, N'NEST Thane Room - 1', 1, 0, NULL, NULL, NULL, NULL, 1, 10, 150, 4, 1)
SET IDENTITY_INSERT [dbo].[Room] OFF
SET IDENTITY_INSERT [dbo].[RoomAvailable] ON 

INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (1, 5, N'Monday', 1, 15, N'AM', 3, 15, N'PM', 1, 4)
INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (2, 5, N'Tuesday', 1, 15, N'AM', 3, 15, N'PM', 1, 4)
INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (3, 5, N'Wednesday', 1, 15, N'AM', 3, 15, N'PM', 1, 4)
SET IDENTITY_INSERT [dbo].[RoomAvailable] OFF
SET IDENTITY_INSERT [dbo].[RoomType] ON 

INSERT [dbo].[RoomType] ([RoomTypeId], [Name], [OrganisationId]) VALUES (1, N'Lab', 4)
INSERT [dbo].[RoomType] ([RoomTypeId], [Name], [OrganisationId]) VALUES (2, N'Theory', 4)
SET IDENTITY_INSERT [dbo].[RoomType] OFF
SET IDENTITY_INSERT [dbo].[Scheme] ON 

INSERT [dbo].[Scheme] ([SchemeId], [Name], [OrganisationId]) VALUES (1, N'Commercial', 4)
INSERT [dbo].[Scheme] ([SchemeId], [Name], [OrganisationId]) VALUES (2, N'Government', 4)
SET IDENTITY_INSERT [dbo].[Scheme] OFF
SET IDENTITY_INSERT [dbo].[Sector] ON 

INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (1, N'Logistics Sector Skill Council', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (2, N'IT', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (3, N'Electronics Sector Skills Council of India', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (4, N'Apparel Made-Ups Home Furnishing Sector Skill Council', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (5, N'Retailers Association''s Skill Council of India', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (6, N'Telecom Sector Skill Council', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (7, N'IT-ITeS Sector Skill Council | NASSCOM', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (8, N'Beauty & Wellness Sector Skill Council', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (9, N'Life Sciences Sector Skill Development Council', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (10, N'Others', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (11, N'Logistics Sector Skill Council', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (13, N'Apparel Made-Ups Home Furnishing Sector Skill Council', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (14, N'Electronics Sector Skills Council of India', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (15, N'Others', 4, 2)
SET IDENTITY_INSERT [dbo].[Sector] OFF
SET IDENTITY_INSERT [dbo].[Session] ON 

INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (92, N'Introduction to SQL', N'2 hrs', 1, N'Understanding SQL', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (93, N'Normalization', N'2 hrs', 1, N'Understanding Normalization', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (94, N'DML', N'2 hrs', 1, N'Understanding DML', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (95, N'DML', N'2 hrs', 2, N'Understanding DML', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (96, N'DDL', N'2 hrs', 1, N'Understanding DDL', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (97, N'DDL', N'2 hrs', 2, N'Understanding DDL', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (98, N'DCL', N'2 hrs', 1, N'Understanding DCL', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (99, N'DCL', N'2 hrs', 2, N'Understanding DCL', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (100, N'DQL', N'1 hr', 1, N'Understanding DQL', 6, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (101, N'DQL', N'1 hr', 2, N'Understanding DQL', 6, 4)
SET IDENTITY_INSERT [dbo].[Session] OFF
SET IDENTITY_INSERT [dbo].[Site] ON 

INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (12, N'PankajSite', 24, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (13, N'PankajSite2', 25, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (14, N'TestSite', 29, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (16, N'test', 29, 4)
SET IDENTITY_INSERT [dbo].[Site] OFF
SET IDENTITY_INSERT [dbo].[State] ON 

INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (1, N'Andhra Pradesh', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (2, N'Arunachal Pradesh', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (3, N'Assam', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (4, N'Bihar', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (5, N'Chhattisgarh', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (6, N'Goa', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (7, N'Gujarat', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (8, N'Haryana', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (9, N'Himachal Pradesh', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (10, N'Jammu and Kashmir', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (11, N'Jharkhand', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (12, N'Karnataka', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (13, N'Kerala', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (14, N'Madhya Pradesh', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (15, N'Maharashtra', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (16, N'Manipur', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (17, N'Meghalaya', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (18, N'Mizoram', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (19, N'Nagaland', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (20, N'Odisha', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (21, N'Punjab', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (22, N'Rajasthan', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (23, N'Sikkim', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (24, N'Tamil Nadu', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (25, N'Tripura', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (26, N'Uttar Pradesh', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (27, N'Uttarakhand', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (28, N'West Bengal', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (29, N'Telangana', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (30, N'Andaman and Nicobar', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (31, N'Chandigarh', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (32, N'Dadra and Nagar Haveli', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (33, N'Daman and Diu', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (34, N'Lakshadweep', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (35, N'NCT Delhi', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (36, N'Puducherry', 4)
SET IDENTITY_INSERT [dbo].[State] OFF
SET IDENTITY_INSERT [dbo].[StudentType] ON 

INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (1, N'Student', 4)
INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (2, N'Working Professional', 4)
INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (3, N'Searching For Job', 4)
SET IDENTITY_INSERT [dbo].[StudentType] OFF
SET IDENTITY_INSERT [dbo].[Subject] ON 

INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (6, N'SQL', NULL, NULL, 1, 100, 40, 2, 4)
SET IDENTITY_INSERT [dbo].[Subject] OFF
SET IDENTITY_INSERT [dbo].[SubjectCourse] ON 

INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (35, 6, 2, 4)
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (36, 6, 5, 4)
SET IDENTITY_INSERT [dbo].[SubjectCourse] OFF
SET IDENTITY_INSERT [dbo].[SubjectTrainer] ON 

INSERT [dbo].[SubjectTrainer] ([SubjectTrainerId], [SubjectId], [TrainerId], [OrganisationId]) VALUES (2, 6, 1, 4)
SET IDENTITY_INSERT [dbo].[SubjectTrainer] OFF
SET IDENTITY_INSERT [dbo].[Taluka] ON 

INSERT [dbo].[Taluka] ([TalukaId], [Name], [DistrictId], [StateId], [OrganisationId]) VALUES (1, N'Test', 1, 1, 4)
SET IDENTITY_INSERT [dbo].[Taluka] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([TeamId], [Name], [OrganisationId], [ColourId]) VALUES (1, N'IT Team', 4, 36)
INSERT [dbo].[Team] ([TeamId], [Name], [OrganisationId], [ColourId]) VALUES (3, N'Testing Team', 4, 20)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[Template] ON 

INSERT [dbo].[Template] ([TemplateId], [Name], [FileName], [Type], [OrganisationId]) VALUES (1, N'Registration', N'Registration.html', N'html', 4)
INSERT [dbo].[Template] ([TemplateId], [Name], [FileName], [Type], [OrganisationId]) VALUES (2, N'Installment', N'Installment.html', N'html', 4)
INSERT [dbo].[Template] ([TemplateId], [Name], [FileName], [Type], [OrganisationId]) VALUES (3, N'Admission', N'Admission.html', N'html', 4)
SET IDENTITY_INSERT [dbo].[Template] OFF
SET IDENTITY_INSERT [dbo].[Trainer] ON 

INSERT [dbo].[Trainer] ([TrainerId], [Title], [FirstName], [MiddleName], [LastName], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [Gender], [AadharNo], [Mobile], [DateOfBirth], [EmailId], [Certified], [CertificationNo], [SectorId], [CourseId], [CentreId], [OrganisationId], [PersonnelId], [CreatedDate]) VALUES (1, N'Ms.', N'Ragini', N'Ramesh', N'Singh', N'Shahapur', NULL, NULL, NULL, 1, 1, 1, N'123456', N'Female', 1111111111111111, 7558445874, CAST(N'0001-01-01' AS Date), N'ragini@gmail.com', N'No', NULL, 2, NULL, 1, 4, 55, CAST(N'2017-05-18' AS Date))
INSERT [dbo].[Trainer] ([TrainerId], [Title], [FirstName], [MiddleName], [LastName], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [Gender], [AadharNo], [Mobile], [DateOfBirth], [EmailId], [Certified], [CertificationNo], [SectorId], [CourseId], [CentreId], [OrganisationId], [PersonnelId], [CreatedDate]) VALUES (2, N'Mr.', N'Mohsin', N'Aslam', N'Koltharkar', N'Mumbra', NULL, NULL, NULL, 1, 1, 1, N'123456', N'Male', 2222222222222222, 9769961406, CAST(N'0001-01-01' AS Date), N'mohsin@gmail.com', N'Yes', N'1234', 1, NULL, 1, 4, NULL, CAST(N'0001-01-01' AS Date))
SET IDENTITY_INSERT [dbo].[Trainer] OFF
SET IDENTITY_INSERT [dbo].[TrainerAvailable] ON 

INSERT [dbo].[TrainerAvailable] ([TrainerAvailableId], [TrainerId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (1, 1, N'Monday', 1, 15, N'AM', 3, 15, N'PM', 1, 4)
INSERT [dbo].[TrainerAvailable] ([TrainerAvailableId], [TrainerId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (2, 1, N'Tuesday', 1, 15, N'AM', 3, 15, N'PM', 1, 4)
INSERT [dbo].[TrainerAvailable] ([TrainerAvailableId], [TrainerId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (3, 1, N'Wednesday', 1, 15, N'AM', 3, 15, N'PM', 1, 4)
SET IDENTITY_INSERT [dbo].[TrainerAvailable] OFF
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
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Batch]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Centre]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Organisation]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Personnel]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Registration] FOREIGN KEY([RegistrationId])
REFERENCES [dbo].[Registration] ([RegistrationId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Registration]
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
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Centre]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Course]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_CourseInstallment]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Organisation]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Room]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Batch]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Centre]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Organisation]
GO
ALTER TABLE [dbo].[BatchTimePrefer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTimePrefer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchTimePrefer] CHECK CONSTRAINT [FK_BatchTimePrefer_Organisation]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Batch]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Centre]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Organisation]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Trainer] FOREIGN KEY([TrainerId])
REFERENCES [dbo].[Trainer] ([TrainerId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Trainer]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Centre]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Event]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Organisation]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Question]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Centre]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Event]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Organisation]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Question]
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
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_CandidateInstallment] FOREIGN KEY([CandidateInstallmentId])
REFERENCES [dbo].[CandidateInstallment] ([CandidateInstallmentId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_CandidateInstallment]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_Centre]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_FeeType] FOREIGN KEY([FeeTypeId])
REFERENCES [dbo].[FeeType] ([FeeTypeId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_FeeType]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_Organisation]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_PaymentMode] FOREIGN KEY([PaymentModeId])
REFERENCES [dbo].[PaymentMode] ([PaymentModeId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_PaymentMode]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_Personnel]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_Centre]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_CourseInstallment]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_Organisation]
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
ALTER TABLE [dbo].[CentreCourse]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourse_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreCourse] CHECK CONSTRAINT [FK_CentreCourse_Centre]
GO
ALTER TABLE [dbo].[CentreCourse]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourse_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreCourse] CHECK CONSTRAINT [FK_CentreCourse_Organisation]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_Centre]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_CourseInstallment]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_Organisation]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Centre]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Organisation]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Scheme]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Centre]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Organisation]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Sector]
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
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Centre]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Course] FOREIGN KEY([CourseOfferedId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Course]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Enquiry]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Organisation]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Personnel]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Organisation]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_CourseType] FOREIGN KEY([CourseTypeId])
REFERENCES [dbo].[CourseType] ([CourseTypeId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_CourseType]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Organisation]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Scheme]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Sector]
GO
ALTER TABLE [dbo].[CourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstallment_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[CourseInstallment] CHECK CONSTRAINT [FK_CourseInstallment_Course]
GO
ALTER TABLE [dbo].[CourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstallment_CourseInstallment] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseInstallment] CHECK CONSTRAINT [FK_CourseInstallment_CourseInstallment]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Course]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Organisation]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Subject]
GO
ALTER TABLE [dbo].[CourseType]  WITH CHECK ADD  CONSTRAINT [FK_CourseType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseType] CHECK CONSTRAINT [FK_CourseType_Organisation]
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
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_Organisation]
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_State]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_DocumentType] FOREIGN KEY([DocumentTypeId])
REFERENCES [dbo].[DocumentType] ([DocumentTypeId])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_DocumentType]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_Organisation]
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
ALTER TABLE [dbo].[FollowUpHistory]  WITH CHECK ADD  CONSTRAINT [FK_FollowUpHistory_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[FollowUpHistory] CHECK CONSTRAINT [FK_FollowUpHistory_Centre]
GO
ALTER TABLE [dbo].[FollowUpHistory]  WITH CHECK ADD  CONSTRAINT [FK_FollowUpHistory_FollowUp] FOREIGN KEY([FollowUpId])
REFERENCES [dbo].[FollowUp] ([FollowUpId])
GO
ALTER TABLE [dbo].[FollowUpHistory] CHECK CONSTRAINT [FK_FollowUpHistory_FollowUp]
GO
ALTER TABLE [dbo].[FollowUpHistory]  WITH CHECK ADD  CONSTRAINT [FK_FollowUpHistory_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[FollowUpHistory] CHECK CONSTRAINT [FK_FollowUpHistory_Organisation]
GO
ALTER TABLE [dbo].[RoomAvailable]  WITH CHECK ADD  CONSTRAINT [FK_RoomAvailable_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[RoomAvailable] CHECK CONSTRAINT [FK_RoomAvailable_Centre]
GO
ALTER TABLE [dbo].[RoomAvailable]  WITH CHECK ADD  CONSTRAINT [FK_RoomAvailable_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[RoomAvailable] CHECK CONSTRAINT [FK_RoomAvailable_Organisation]
GO
ALTER TABLE [dbo].[RoomAvailable]  WITH CHECK ADD  CONSTRAINT [FK_RoomAvailable_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[RoomAvailable] CHECK CONSTRAINT [FK_RoomAvailable_Room]
GO
ALTER TABLE [dbo].[TrainerAvailable]  WITH CHECK ADD  CONSTRAINT [FK_TrainerAvailable_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[TrainerAvailable] CHECK CONSTRAINT [FK_TrainerAvailable_Centre]
GO
ALTER TABLE [dbo].[TrainerAvailable]  WITH CHECK ADD  CONSTRAINT [FK_TrainerAvailable_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[TrainerAvailable] CHECK CONSTRAINT [FK_TrainerAvailable_Organisation]
GO
ALTER TABLE [dbo].[TrainerAvailable]  WITH CHECK ADD  CONSTRAINT [FK_TrainerAvailable_Trainer] FOREIGN KEY([TrainerId])
REFERENCES [dbo].[Trainer] ([TrainerId])
GO
ALTER TABLE [dbo].[TrainerAvailable] CHECK CONSTRAINT [FK_TrainerAvailable_Trainer]
GO
/****** Object:  StoredProcedure [dbo].[SearchAdmission]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SearchAdmission]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	  CandidateName,
BatchName,
TotalFee,
PaidAmount,
PendingAmount,
AdmissionDate,
AdmissionId,
CentreName,
CentreId,
SearchField

	  FROM 
		[AdmissionSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END






GO
/****** Object:  StoredProcedure [dbo].[SearchCandidateFee]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SearchCandidateFee]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	  CandidateFeeId,
      PaymentDate,
      CandidateInstallmentId,
      PaidAmount,
      PaymentModeId,
      FeeTypeId,
      ChequeNumber,
      ChequeDate,
      BankName,
      Penalty,
      InstallmentDate,
      StudentCode,
      InstallmentAmount,
      BalanceInstallmentAmount,
      Particulars,
      FiscalYear,
      FollowUpDate,
      CentreId,
      OrganisationId,
      IsPaymentDone,
      PersonnelId,
	  SearchField

	  FROM 
		[CandidateFeeSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END






GO
/****** Object:  StoredProcedure [dbo].[SearchCandidateInstallment]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SearchCandidateInstallment]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	  CandidateInstallmentId,
      StudentCode,
      CourseFee,
      DownPayment,
      DiscountAmount,
      NumberOfInstallment,
      LumpsumAmount,
      CentreId,
      OrganisationId,
      CourseInstallmentId,
      IsPercentageDiscount,
      IsTotalAmountDiscount,
      PaymentMethod,
	  SearchField

	  FROM 
		[CandidateInstallmentSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
/****** Object:  StoredProcedure [dbo].[SearchCounselling]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SearchCounselling]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	CounsellingId,
      EnquiryId,
      Title,
      FirstName,
      MiddleName,
      LastName,
      CentreId,
      OrganisationId,
      PersonnelId,
      CourseOfferedId,
      PreferTiming,
      Remarks,
      FollowUpDate,
      RemarkByBranchManager,
      SectorId,
      PsychomatricTest,
      ConversionProspect,
      [Close],
      ClosingRemark,
      RemarkByBm,
      IsRegistrationDone,
	  SearchField

	  FROM 
		[CounsellingSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END




GO
/****** Object:  StoredProcedure [dbo].[SearchCourse]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SearchCourse]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
	   CourseId,
      Name,
      OrganisationId,
      SectorId,
      SchemeId,
      CourseTypeId,
      Description,
      Duration,
	SearchField

	  FROM 
		[CourseSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END
GO
/****** Object:  StoredProcedure [dbo].[SearchCourseInstallment]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SearchCourseInstallment]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	  CourseInstallmentId,
      Name,
      CourseId,
      Fee,
      DownPayment,
      LumpsumAmount,
      OrganisationId,
      NumberOfInstallment,
      CentreId,
      CreatedDate,
	  SearchField

	  FROM 
		[CourseInstallmentSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
/****** Object:  StoredProcedure [dbo].[SearchEnquiry]    Script Date: 29/05/2017 06:05:06 PM ******/
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
      Title,
      FirstName,
      MiddleName,
      LastName,
      Mobile,
      AlternateMobile,
      EmailId,
	  DateOfBirth,
      Age,
      Address1,
      Address2,
      Address3,
      Address4,
      TalukaId,
      StateId,
      DistrictId,
      PinCode,
      GuardianName,
      GuardianContactNo,
      OccupationId,
      ReligionId,
      CasteCategoryId,
      Gender,
      EducationalQualificationId,
      YearOfPassOut,
      Marks,
      IntrestedCourseId,
      HowDidYouKnowAboutId,
      PreTrainingStatus,
      EmploymentStatus,
      Promotional,
      EnquiryDate,
      StudentCode,
      EnquiryStatus,
      EmployerName,
      EmployerContactNo,
      EmployerAddress,
      AnnualIncome,
      SchemeId,
      EnquiryTypeId,
      StudentTypeId,
      SectorId,
      BatchTimePreferId,
      AppearingQualification,
      YearOfExperience,
      PlacementNeeded,
      Remarks,
      FollowUpDate,
      PreferredMonthForJoining,
      [Close],
      ClosingRemark,
      ConversionProspect,
      OtherInterestedCourse,
      RemarkByBranchManager,
      IsCounsellingDone,
      IsRegistrationDone,
      IsAdmissionDone,
      CentreId,
      OrganisationId,
	  SearchField

	  FROM 
		[EnquirySearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END



GO
/****** Object:  StoredProcedure [dbo].[SearchFollowUp]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SearchFollowUp]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	FollowUpId,
      FollowUpDateTime,
      MobilizationId,
      EnquiryId,
      CounsellingId,
      RegistrationId,
      Title,
      FirstName,
      MiddleName,
      LastName,
      Remark,
      Closed,
      ReadDateTime,
      CreatedDateTime,
      OrganisationId,
      CentreId,
      Mobile,
      IntrestedCourseId,
      FollowUpType,
      AlternateMobile,
      FollowUpURL,
      [Close],
      ClosingRemark,
	  SearchField

	  FROM 
		[FollowUpSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END


GO
/****** Object:  StoredProcedure [dbo].[SearchMobilization]    Script Date: 29/05/2017 06:05:06 PM ******/
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
      Title,
      FirstName,
      MiddleName,
      LastName,
      CentreId,
      Mobile,
      AlternateMobile,
      InterestedCourseId,
      QualificationId,
      CreatedDate,
      FollowUpDate,
      Remark,
      MobilizerStatus,
      StudentLocation,
      OtherInterestedCourse,
      GeneratedDate,
      MobilizationTypeId,
      PersonnelId,
      [Close],
      ClosingRemark,
	  SearchField

	  FROM 
		[MobilizationSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END



GO
/****** Object:  StoredProcedure [dbo].[SearchPersonnel]    Script Date: 29/05/2017 06:05:06 PM ******/
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
      CurrentEmploymentId,
      CentreId,
	  SearchField

	  FROM 
		[PersonnelSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
/****** Object:  StoredProcedure [dbo].[SearchRegistration]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SearchRegistration]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	RegistrationId,
      StudentCode,
      EnquiryId,
      CourseId,
      CourseInstallmentId,
      CandidateFeeId,
      CandidateInstallmentId,
      Remarks,
      FollowupDate,
      CentreId,
      OrganisationId,
      IsAdmissionDone,
      RegistrationDate,
	  SearchField

	  FROM 
		[RegistrationSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
/****** Object:  StoredProcedure [dbo].[SearchTrainer]    Script Date: 29/05/2017 06:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SearchTrainer]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	TrainerId,
      Title,
      FirstName,
      MiddleName,
      LastName,
      Address1,
      Address2,
      Address3,
      Address4,
      TalukaId,
      StateId,
      DistrictId,
      PinCode,
      Gender,
      AadharNo,
      Mobile,
      DateOfBirth,
      EmailId,
      Certified,
      CertificationNo,
      SectorId,
      CourseId,
      CentreId,
      OrganisationId,
      PersonnelId,
      CreatedDate,
	   SearchField

	  FROM 
		[TrainerSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END




GO
USE [master]
GO
ALTER DATABASE [NidanERP] SET  READ_WRITE 
GO
