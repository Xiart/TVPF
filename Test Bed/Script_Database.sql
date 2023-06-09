USE [master]
GO
/****** Object:  Database [Testing]    Script Date: 11/8/2020 14:27:41 ******/
CREATE DATABASE [Testing]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Testing', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Testing.mdf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Testing_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Testing_log.ldf' , SIZE = 32448KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Testing] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Testing].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Testing] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Testing] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Testing] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Testing] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Testing] SET ARITHABORT OFF 
GO
ALTER DATABASE [Testing] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Testing] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Testing] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Testing] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Testing] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Testing] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Testing] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Testing] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Testing] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Testing] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Testing] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Testing] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Testing] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Testing] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Testing] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Testing] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Testing] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Testing] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Testing] SET RECOVERY FULL 
GO
ALTER DATABASE [Testing] SET  MULTI_USER 
GO
ALTER DATABASE [Testing] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Testing] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Testing] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Testing] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Testing', N'ON'
GO
USE [Testing]
GO
/****** Object:  UserDefinedTableType [dbo].[Student]    Script Date: 11/8/2020 14:27:41 ******/
CREATE TYPE [dbo].[Student] AS TABLE(
	[ID] [int] NULL,
	[Name] [varchar](100) NULL,
	[FName] [varchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[T_Entity]    Script Date: 11/8/2020 14:27:41 ******/
CREATE TYPE [dbo].[T_Entity] AS TABLE(
	[Id] [int] NULL,
	[Value] [varchar](100) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[ADO_Delete]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ADO_Delete] 
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Entity WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[ADO_DeleteBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ADO_DeleteBatch]
	-- Add the parameters for the stored procedure here
	@Value varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	EXEC (@Value);
END

GO
/****** Object:  StoredProcedure [dbo].[ADO_InsertBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ADO_InsertBatch] 
	-- Add the parameters for the stored procedure here
	@Vals varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here	
	EXEC ('INSERT INTO Entity SELECT * FROM (VALUES '+ @Vals + ') A(Col1, Col2)');
END

GO
/****** Object:  StoredProcedure [dbo].[ADO_InsertOne]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ADO_InsertOne] 
	-- Add the parameters for the stored procedure here
	@Id int,
	@Value varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Entity VALUES (@Id, @Value)
END

GO
/****** Object:  StoredProcedure [dbo].[ADO_Select]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ADO_Select]
	-- Add the parameters for the stored procedure here
	@ParamTable1	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	EXEC ('SELECT TOP ' + @ParamTable1 + ' * FROM Entity')
END

GO
/****** Object:  StoredProcedure [dbo].[ADO_Update]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ADO_Update]
	-- Add the parameters for the stored procedure here
	@Id	int,
	@Value	varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Entity 
	SET Value = @Value
	WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[ADO_UpdateBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ADO_UpdateBatch]
	-- Add the parameters for the stored procedure here
	@Value varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	EXEC (@Value)
END

GO
/****** Object:  StoredProcedure [dbo].[Dapper_Delete]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dapper_Delete] 
	-- Add the parameters for the stored procedure here
	@Id  int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Entity WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[Dapper_DeleteBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dapper_DeleteBatch] 
	-- Add the parameters for the stored procedure here
	@Id  int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Entity WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[Dapper_Insert]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dapper_Insert]
	-- Add the parameters for the stored procedure here
	@Id int,
	@Value varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Entity VALUES (@Id, @Value)
END

GO
/****** Object:  StoredProcedure [dbo].[Dapper_InsertBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dapper_InsertBatch]
	-- Add the parameters for the stored procedure here
	@Id int,
	@Value varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Entity VALUES (@Id, @Value)
END

GO
/****** Object:  StoredProcedure [dbo].[Dapper_Select]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dapper_Select] 
	-- Add the parameters for the stored procedure here
	@Counter int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	EXEC ('SELECT TOP ' + @Counter+ ' * FROM Entity')
END

GO
/****** Object:  StoredProcedure [dbo].[Dapper_Update]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dapper_Update] 
	-- Add the parameters for the stored procedure here
	@Id int,
	@Value varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Entity SET Value = @Value WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Dapper_UpdateBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dapper_UpdateBatch] 
	-- Add the parameters for the stored procedure here
	@Id int,
	@Value varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Entity SET Value = @Value WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[InsertStudent]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertStudent]
	-- Add the parameters for the stored procedure here
	@ParamTable1		dbo.Student READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Student SELECT * FROM @ParamTable1
END

GO
/****** Object:  StoredProcedure [dbo].[SaveStudent]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveStudent]
	@ParamTable1			int,
	@ParamTable2		varchar(100),
	@ParamTable3		varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO Student VALUES (@ParamTable1, @ParamTable2, @ParamTable3)
END

GO
/****** Object:  StoredProcedure [dbo].[ZTVP_Delete]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ZTVP_Delete]
	-- Add the parameters for the stored procedure here
	@ParamTable1	T_Entity READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Entity WHERE ID IN (SELECT p.Id FROm @ParamTable1 p)
END

GO
/****** Object:  StoredProcedure [dbo].[ZTVP_DeleteBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ZTVP_DeleteBatch]
	-- Add the parameters for the stored procedure here
	@ParamTable1	T_Entity READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Entity WHERE ID IN (SELECT p.Id FROm @ParamTable1 p)
END

GO
/****** Object:  StoredProcedure [dbo].[ZTVP_Insert]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ZTVP_Insert]
	-- Add the parameters for the stored procedure here
	@ParamTable1	T_Entity READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Entity SELECT * FROM @ParamTable1
END

GO
/****** Object:  StoredProcedure [dbo].[ZTVP_InsertBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ZTVP_InsertBatch]
	-- Add the parameters for the stored procedure here
	@ParamTable1	T_Entity READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Entity SELECT * FROM @ParamTable1
END

GO
/****** Object:  StoredProcedure [dbo].[ZTVP_Select]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ZTVP_Select]
	-- Add the parameters for the stored procedure here
	@ParamTable1	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	EXEC ('SELECT TOP ' + @ParamTable1 + ' * FROM Entity')
END

GO
/****** Object:  StoredProcedure [dbo].[ZTVP_Update]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ZTVP_Update]
	-- Add the parameters for the stored procedure here
	@ParamTable1	T_Entity READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE e
	SET
	e.Value = p.Value
	FROM Entity e INNER JOIN @ParamTable1 p ON p.Id = e.Id
END

GO
/****** Object:  StoredProcedure [dbo].[ZTVP_UpdateBatch]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ZTVP_UpdateBatch]
	-- Add the parameters for the stored procedure here
	@ParamTable1	T_Entity READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE e
	SET
	e.Value = p.Value
	FROM Entity e INNER JOIN @ParamTable1 p ON p.Id = e.Id
END

GO
/****** Object:  Table [dbo].[Employee]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[Fullname] [varchar](50) NULL,
	[EMPCodevarchar] [nchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[Position] [varchar](50) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Entity]    Script Date: 11/8/2020 14:27:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Entity](
	[Id] [int] NOT NULL,
	[Value] [varchar](100) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [Testing] SET  READ_WRITE 
GO
