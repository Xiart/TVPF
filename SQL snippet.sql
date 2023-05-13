USE [CTS_JSMU]
GO
/****** Object:  StoredProcedure [dbo].[System_AddNecessaryColumnsToTable]    Script Date: 2/20/2023 13:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Ziyad>
-- Create date: <18072019 1204>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[System_AddNecessaryColumnsToTable]
	@TableName nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Statement nvarchar(500) = 'ALTER TABLE '+ @TableName +' ADD TenantId int NULL, AppId nvarchar(100) NULL, CreatedBy int NULL, ModifiedBy int NULL, CreatedOn datetime NULL DEFAULT GETDATE(), ModifiedOn datetime NULL DEFAULT GETDATE(), [Status] int DEFAULT 1';
    EXEC (@Statement)
END
GO
/****** Object:  StoredProcedure [dbo].[System_AfterAlterTableImplementation]    Script Date: 2/20/2023 13:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:  <Ziyad Sanaullah>
-- Create date: <01092019>
-- Description: <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[System_AfterAlterTableImplementation]
@TableName varchar(300),
@TVPName varchar(300)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

    DECLARE @QuerySave varchar(MAX), @QueryGetAll varchar(MAX), @QueryGetById varchar(MAX), @QueryUpdate varchar(MAX), @QueryTVPDrop varchar(MAX) ;
SELECT @QuerySave = 'DROP Procedure ' + @TVPName + 'Save'
SELECT @QueryUpdate = 'DROP Procedure ' + @TVPName + 'Update'
SELECT @QueryGetAll = 'DROP Procedure ' + @TVPName + 'GetAll'
SELECT @QueryGetById = 'DROP Procedure ' + @TVPName + 'GetById'
SELECT @QueryTVPDrop = 'DROP TYPE ' + @TVPName;
EXEC (@QuerySave);
EXEC (@QueryUpdate);
EXEC (@QueryGetAll);
EXEC (@QueryGetById);
EXEC (@QueryTVPDrop)


EXEC [dbo].[System_CreateTVPForTable] @TableName, @TVPName
EXEC [dbo].[System_CreateUpdateProcedureWithValidation] @TableName, @TVPName
EXEC [dbo].[System_CreateGetRowByIdProcedure] @TableName, @TVPName
EXEC [dbo].[System_CreateGetAllProcedure] @TableName, @TVPName
EXEC [dbo].[System_CreateSaveProcedureWithValidation] @TableName, @TVPName
END


GO
/****** Object:  StoredProcedure [dbo].[System_CreateGetAllProcedure]    Script Date: 2/20/2023 13:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Ziyad>
-- Create date: <18072019 1204>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[System_CreateGetAllProcedure]
	@TableName	nvarchar(100),
	@TVPName	nvarchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--Adding Necessary 5 Columns to the Provided Table
	
	DECLARE @Select_Query nvarchar(MAX) ;
	SELECT @Select_Query = 'SELECT ';
	DECLARE @Counter int;
	SELECT @Counter = 2;

	WHILE @Counter <= ((SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName)  - 7)
	BEGIN 
		SELECT @Select_Query = @Select_Query + 't.' + COLUMN_NAME + ','   
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @TableName) cols WHERE cols.Sr = @Counter;
		SELECT @Counter = @Counter + 1; 
	END
	SELECT @Select_Query = SUBSTRING(@Select_Query, 0, LEN(@Select_Query))
	SELECT @Select_Query = @Select_Query + ' FROM ' +@TableName+ ' t WHERE t.TenantId = @ParamTable2 AND t.AppId = @ParamTable3 AND t.Status = 1'

	DECLARE @FQuery varchar(1000);
	SET @FQuery = 'CREATE PROCEDURE ['+ @TVPName+ 'GetAll' +'] ' + CHAR(13)  + '
		@ParamTable1	int,' + CHAR(13)  + '
		@ParamTable2	int, '+CHAR(13)+'
		@ParamTable3	nvarchar(100)'+CHAR(13)+'
	AS' + CHAR(13)  + '
	BEGIN ' + CHAR(13)  + '
		'+ @Select_Query +'
	END'

	EXEC  (@FQuery)

END
GO
/****** Object:  StoredProcedure [dbo].[System_CreateGetRowByIdProcedure]    Script Date: 2/20/2023 13:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Ziyad>
-- Create date: <18072019 1204>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[System_CreateGetRowByIdProcedure]
	@TableName	nvarchar(100),
	@TVPName	nvarchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--Adding Necessary 5 Columns to the Provided Table
	
	DECLARE @Select_Query nvarchar(MAX) ;
	SELECT @Select_Query = 'SELECT ';
	DECLARE @Counter int;
	SELECT @Counter = 2;

	WHILE @Counter <= ((SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName)  - 7)
	BEGIN 
		SELECT @Select_Query = @Select_Query + 't.' + COLUMN_NAME + ','   
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @TableName) cols WHERE cols.Sr = @Counter;
		SELECT @Counter = @Counter + 1; 
	END
	SELECT @Select_Query = SUBSTRING(@Select_Query, 0, LEN(@Select_Query))
	SELECT @Select_Query = @Select_Query + ' FROM ' +@TableName+ ' t WHERE t.'+ (SELECT COLUMN_NAME FROM  (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName ) abc WHERE abc.Sr = 1) +' = @ParamTable4 AND t.TenantId = @ParamTable2 AND t.AppId = @ParamTable3 AND t.Status = 1'

	DECLARE @FQuery varchar(1000);
	SET @FQuery = 'CREATE PROCEDURE ['+ @TVPName + 'GetById] ' + CHAR(13)  + '
		@ParamTable1	int,' + CHAR(13)  + '
		@ParamTable2	int, '+CHAR(13)+'
		@ParamTable3	nvarchar(100),'+CHAR(13)+'
		@ParamTable4	int
	AS' + CHAR(13)  + '
	BEGIN ' + CHAR(13)  + '
		'+ @Select_Query +'
	END'
	--SELECT @FQuery
	EXEC  (@FQuery)
END
GO
/****** Object:  StoredProcedure [dbo].[System_CreateSaveProcedureWithValidation]    Script Date: 2/20/2023 13:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Ziyad>
-- Create date: <18072019 1204>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[System_CreateSaveProcedureWithValidation]
	@TableName nvarchar(100),
	@TVPName	nvarchar(100)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--Adding Necessary 5 Columns to the Provided Table
	
	DECLARE @Insert_Query nvarchar(MAX) ;
	DECLARE @Validation_Query nvarchar(MAX) ;
	SELECT @Insert_Query = 'INSERT INTO '+ @TableName +' SELECT ';
	SET @Validation_Query = 'SELECT * FROM ' +@TableName+ ' WHERE ';
	DECLARE @Counter int;
	SELECT @Counter = 2;

	WHILE @Counter <= ((SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName)  - 3)
	BEGIN 
		SELECT @Insert_Query = @Insert_Query + COLUMN_NAME + ','   
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @TableName) cols WHERE cols.Sr = @Counter;
		
		--For Validation of Data
		SELECT @Validation_Query = @Validation_Query + 'LOWER('+ COLUMN_NAME +') = (SELECT LOWER(p.'+ COLUMN_NAME +') FROM @ParamTable1 p) AND ' 
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @TableName) cols WHERE cols.Sr = @Counter;
		SELECT @Counter = @Counter + 1; 
	END

	SELECT @Insert_Query = @Insert_Query + 'GETDATE(), GETDATE(), 1 FROM  @ParamTable1'
	SELECT @Validation_Query = SUBSTRING(@Validation_Query, 0, LEN(@Validation_Query) - 3)


	DECLARE @FQuery varchar(MAX);
	SET @FQuery = 'CREATE PROCEDURE [' + @TVPName + 'Save] ' + CHAR(13)  + '
		@ParamTable1	'+ @TVPName +' READONLY' + CHAR(13)  + '
	AS' + CHAR(13)  + '
	BEGIN ' + CHAR(13)  + '
		IF EXISTS ( '+ @Validation_Query +' )
		BEGIN
			SELECT ''Record Already Exists'' [ReturnMessage]
		END
		ELSE
		BEGIN
		'+  @Insert_Query +' ' + CHAR(13)  + '
			SELECT ''OK'' [ReturnMessage]
		END
	END'
	EXEC  (@FQuery)

END
GO
/****** Object:  StoredProcedure [dbo].[System_CreateTableBasicImplmentation]    Script Date: 2/20/2023 13:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Ziyad Sanaullah>
-- Creation Date <18072019 1204>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[System_CreateTableBasicImplmentation]
	@TableName		varchar(MAX),
	@TVPName		varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			-- Insert statements for procedure here
			--For Addition of Necessary COlumns in Table
			EXEC [System_AddNecessaryColumnsToTable] @TableName
	
			--For Creation of TVP
			EXEC [System_CreateTVPForTable] @TableName, @TVPName

			--For Save Stored Procedure
			EXEC [System_CreateSaveProcedureWithValidation] @TableName, @TVPName

			--For GetAll Stored Procedure
			EXEC [System_CreateGetAllProcedure] @TableName, @TVPName

			--For Single Record By Id StoreProcedure
			EXEC [System_CreateGetRowByIdProcedure] @TableName, @TVPName

			--For Update rows by ID StoredProcedure
			EXEC [System_CreateUpdateProcedureWithValidation] @TableName, @TVPName
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK TRAN
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[System_CreateTVPForTable]    Script Date: 2/20/2023 13:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Ziyad Sanaullah>
-- Create date: <18-11-2017>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[System_CreateTVPForTable] 
	@TableName			nvarchar(100),
	@TVPName			nvarchar(100),
	@ExcludedColumns	nvarchar(500) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @excludedcolumns IS NOT NULL
	BEGIN
		DECLARE @CTable TABLE (columner nvarchar(50));
	END
	--DECLARE @TableName nvarchar(100) = @TableName;
	--DECLARE @TVPName nvarchar(100) = @TVPName;
	DECLARE @ColumnTable TABLE (RNumber int, CNames nvarchar(40), CTypes nvarchar(40));
	INSERT INTO @ColumnTable
	SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)), c.name, [ColumnType] = 
	CASE WHEN t.name = 'nvarchar' OR t.name = 'varchar'  THEN t.name+'('+ CASE WHEN c.max_length < 0 THEN 'MAX' ELSE CONVERT(nvarchar(10),c.max_length) END +')' ELSE t.name END
	FROM sys.columns c
	INNER JOIN sys.types t ON t.user_type_id = c.user_type_id
	LEFT OUTER JOIN 
    sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
	LEFT OUTER JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
	WHERE
    c.object_id = OBJECT_ID(@TableName) 	
	

	DECLARE @FinalQuery nvarchar(MAX) = ''; 
	DECLARE @count int = 0;
	WHILE @count < ((SELECT COUNT(*) FROM @ColumnTable) - 3)
	BEGIN
		SELECT @FinalQuery = @FinalQuery + ',' + CNames +' '+ CTypes FROM @ColumnTable WHERE RNumber  = (@count+1);
		SELECT @count = @count + 1;
	END
	
	SELECT @FinalQuery = SUBSTRING(@FinalQuery, 2, LEN(@FinalQuery))
	
		--EXECUTE ('CREATE TYPE TVPTable AS TABLE ' + '(' + @FinalQuery+ ')')
	EXECUTE ('CREATE TYPE ' + @TVPName +  ' AS TABLE ' + '(' + @FinalQuery + ')')
END
GO
/****** Object:  StoredProcedure [dbo].[System_CreateUpdateProcedureWithValidation]    Script Date: 2/20/2023 13:34:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Ziyad>
--Creation Date <18072019 1204>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[System_CreateUpdateProcedureWithValidation]
	@TableName nvarchar(100),
	@TVPName	nvarchar(100)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--Adding Necessary 5 Columns to the Provided Table
	
	DECLARE @Update_Query nvarchar(MAX) ;
	DECLARE @Validation_Query nvarchar(MAX) ;
	SELECT @Update_Query = 'UPDATE t SET ';
	SET @Validation_Query = 'SELECT * FROM ' +@TableName+ ' WHERE ';
	DECLARE @Counter int;
	SELECT @Counter = 2;

	WHILE @Counter <= ((SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName)  - 7)
	BEGIN 
		SELECT @Update_Query = @Update_Query + 't.'+COLUMN_NAME + ' = p.'+ COLUMN_NAME +','   
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @TableName) cols WHERE cols.Sr = @Counter;
		
		--For Validation of Data
		SELECT @Validation_Query = @Validation_Query + 'LOWER('+ COLUMN_NAME +') = (SELECT LOWER(p.'+ COLUMN_NAME +') FROM @ParamTable1 p) AND ' 
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @TableName) cols WHERE cols.Sr = @Counter;
		SELECT @Counter = @Counter + 1; 
	END

	SELECT @Update_Query = SUBSTRING(@Update_Query, 0, LEN(@Update_Query))
	SELECT @Update_Query = @Update_Query + ' FROM '+ @TableName +' t INNER JOIN @ParamTable1 p ON t.'+ (SELECT COLUMN_NAME FROM  (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName ) abc WHERE abc.Sr = 1) +' = p.'+ (SELECT COLUMN_NAME FROM  (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 100)) [Sr],COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName ) abc WHERE abc.Sr = 1) +' AND t.TenantId = p.TenantId AND t.AppId = t.AppId'
	SELECT @Validation_Query = SUBSTRING(@Validation_Query, 0, LEN(@Validation_Query) - 3)


	DECLARE @FQuery varchar(MAX);
	SET @FQuery = 'CREATE PROCEDURE ['+ @TVPName + 'Update] ' + CHAR(13)  + '
		@ParamTable1	'+ @TVPName +' READONLY' + CHAR(13)  + '
	AS' + CHAR(13)  + '
	BEGIN ' + CHAR(13)  + '
		IF EXISTS ( '+ @Validation_Query +' )
		BEGIN
			SELECT ''Record Already Exists'' [ReturnMessage]
		END
		ELSE
		BEGIN
		'+  @Update_Query +' ' + CHAR(13)  + '
			SELECT ''OK'' [ReturnMessage]
		END
	END'
	EXEC  (@FQuery)

END
GO
