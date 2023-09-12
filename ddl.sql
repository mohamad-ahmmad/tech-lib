
CREATE DATABASE tech_lib;
GO
USE tech_lib;
GO


/****** Object:  Table [dbo].[Genre]    Script Date: 9/7/2023 3:50:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[GenreID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/***************************************************************************************/

/****** Object:  Table [dbo].[ShelfLocations]    Script Date: 9/7/2023 4:00:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ShelfLocations](
	[ShelfLocationID] [int] IDENTITY(1,1) NOT NULL,
	[Aisle] [nvarchar](256) NOT NULL,
	[Section] [nvarchar](256) NOT NULL,
	[Row] [int] NOT NULL,
	[Shelf] [int] NOT NULL,
 CONSTRAINT [PK_ShelfLocations] PRIMARY KEY CLUSTERED 
(
	[ShelfLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/***************************************************************************************/

/****** Object:  Table [dbo].[Books]    Script Date: 9/7/2023 4:09:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Books](
	[BookID] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](128) NOT NULL,
	[Author] [nvarchar](128) NOT NULL,
	[ISBN] [nvarchar](13) NOT NULL,
	[PublishedDate] [date] NOT NULL,
	[GenreID] [tinyint] NOT NULL,
	[ShelfLocationID] [int] NOT NULL,
	[CurrentStatus] [bit] NOT NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Books]
ADD CONSTRAINT fk_books_genres
FOREIGN KEY (GenreID)
REFERENCES [dbo].[Genres](GenreID);
GO

ALTER TABLE [dbo].[Books]
ADD CONSTRAINT fk_books_ShelfLocations
FOREIGN KEY (ShelfLocationID)
REFERENCES [dbo].[ShelfLocations](ShelfLocationID);
GO

/********************************************************************************/

/****** Object:  Table [dbo].[Borrowers]    Script Date: 9/7/2023 4:16:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[Borrowers](
	[BorrowerID] [bigint] IDENTITY(1,1) NOT NULL,
	[FName] [nvarchar](64) NOT NULL,
	[LName] [nvarchar](64) NOT NULL,
	[Email] [nvarchar](256) UNIQUE NOT NULL,
	[Birthdate] [date] NOT NULL,
	[MembershipDate] [date] NOT NULL,
 CONSTRAINT [PK_Borrowers] PRIMARY KEY CLUSTERED 
(
	[BorrowerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/********************************************************************************/

/****** Object:  Table [dbo].[Loans]    Script Date: 9/7/2023 4:21:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Loans](
	[LoanID] [bigint] IDENTITY(1,1) NOT NULL,
	[BorrowerID] [bigint] NOT NULL,
	[BookID] [bigint] NOT NULL,
	[BorrowedDate] [date] NOT NULL,
	[DueDate] [date] NOT NULL,
	[DateReturned] [date] NULL,
 CONSTRAINT [PK_Loans] PRIMARY KEY CLUSTERED 
(
	[LoanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].Loans
ADD CONSTRAINT fk_loans_borrowers
FOREIGN KEY (BorrowerID)
REFERENCES [dbo].[Borrowers](BorrowerID);
GO

ALTER TABLE [dbo].Loans
ADD CONSTRAINT fk_loans_books
FOREIGN KEY (BookID)
REFERENCES [dbo].[Books](BookID);
GO

/*******************************************************************/

/****** Object:  Table [dbo].[AuditLog]    Script Date: 9/12/2023 11:09:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AuditLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[BookID] [bigint] NOT NULL,
	[StatusChange] [bit] NOT NULL,
	[ChangeDate] [date] NOT NULL,
 CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AuditLog]
ADD CONSTRAINT fk_auditlog_books
FOREIGN KEY (BookID) REFERENCES Books(BookID);
