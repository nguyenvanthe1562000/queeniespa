USE [ShopVT]
GO
/****** Object:  StoredProcedure [dbo].[B10Product_create]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[B10Product_delete]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[B10Product_get_all]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[B10Product_get_by_id]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[B10Product_search]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[B10Product_update]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetPermissionData]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetPermissionFunction]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorAdd]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorAddMultiple]    Script Date: 02/22/2022 11:44:25 PM ******/
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
		N'		IF(LEN(ISNULL('+@InsertChild+','''')))>0	'					+ SPACE(3) +
		N'		BEGIN;'															+ SPACE(3) +
		N'			'+@InsertChild												+ SPACE(3) +
		N'		END;'															+ SPACE(3) +
		N'		END;'															+ SPACE(3) +
		N'	END TRY'															+ SPACE(3) +
		N'	BEGIN CATCH'														+ SPACE(3) +
		N'		SELECT ''MESSAGE. failed'';'									+ SPACE(3) +
		N'	END CATCH'
	
		EXEC(@_str)
		
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorDelete]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorRestore]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_sys_DataEditorUpdateOneRow]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_sys_GetData]    Script Date: 02/22/2022 11:44:25 PM ******/
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
						N'WHERE IsActive= ' + CASE WHEN @TypeData = 0 THEN '0' ELSE '1' END	+ SPACE(3) +
						N'UPDATE @result1'+ SPACE(3) +
						N'SET ListObj = ('+ SPACE(3) +
						N'					SELECT '+ @_column + SPACE(3) +
						N'					FROM '+ @table + SPACE(3) +
						N'					WHERE IsActive= ' + CASE WHEN @TypeData=0 THEN '0' ELSE '1' END	 + SPACE(3) + CASE WHEN ISNULL(@Filter, '') != ''  THEN 'AND '+@Filter ELSE '' END + SPACE(3) +
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
							N'WHERE IsActive= ' + CASE WHEN @TypeData = 0 THEN '0' ELSE '1' END	+ SPACE(3) +
							N'UPDATE @result'+ SPACE(3) +
							N'SET ListObj = ('+ SPACE(3) +
							N'					SELECT '+ @_column + SPACE(3) +
							N'					FROM '+ @table + SPACE(3) +
							N'					WHERE CreatedBy= ' + @_userId +' AND IsActive= ' + CASE WHEN @TypeData=0 THEN '0' ELSE '1' END	 + SPACE(3) + CASE WHEN ISNULL(@Filter, '') != ''  THEN 'AND '+@Filter ELSE '' END + SPACE(3) +
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
/****** Object:  StoredProcedure [dbo].[usp_sys_GetDataByGroup]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_sys_GetDataById]    Script Date: 02/22/2022 11:44:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_sys_GetGroup]    Script Date: 02/22/2022 11:44:25 PM ******/
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
		N'		SELECT Id, ParentId, IsGroup, '+@ColumnCaption+' AS Caption'  + SPACE(3) +
		N'		FROM '+ @table + SPACE(3) +
		N'		WHERE IsGroup = 1 AND IsActive = 1'+ SPACE(3) +
		N'		ORDER BY ' +@Orderby+ CASE WHEN @OrderDesc = 1 THEN ' DESC ' ELSE '' END  + SPACE(3) +
		N'	END'  + SPACE(3) +
		N'ELSE IF (EXISTS(SELECT TOP 1 * FROM vB00PermisionData WHERE UserId = '+@_userId+' AND TableName= '''+ @table +''' AND Permission = 0000010100)) ' + SPACE(3) +
		N'BEGIN'  + SPACE(3) +
		N'	SELECT Id, ParentId, '+@ColumnCaption+' AS Caption'  + SPACE(3) +
		N'	FROM '+ @table + SPACE(3) +
		N'	WHERE IsGroup = 1 AND IsActive = 1 AND CreatedBy = ' +@_userId + SPACE(3) +
		N'	ORDER BY ' +@Orderby+ CASE WHEN @OrderDesc = 1 THEN ' DESC ' ELSE '' END + SPACE(3) +
		N'END'  + SPACE(3) +
		N'ELSE '  + SPACE(3) +
		N'	BEGIN '  + SPACE(3) +
		N'	SELECT N''MESSAGE. không có quyền xem '+@table+''''  + SPACE(3) +
		N'	END; '  
		EXEC ( @_str)
END
GO
/****** Object:  StoredProcedure [dbo].[usp_sys_PagingForTable]    Script Date: 02/22/2022 11:44:25 PM ******/
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
