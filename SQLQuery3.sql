USE [master]
GO
/****** Object:  Database [SiberianDB]    Script Date: 16/10/2021 0:04:14 ******/
CREATE DATABASE [SiberianDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SiberianDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SiberianDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SiberianDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SiberianDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SiberianDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SiberianDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SiberianDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SiberianDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SiberianDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SiberianDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SiberianDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SiberianDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SiberianDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SiberianDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SiberianDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SiberianDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SiberianDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SiberianDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SiberianDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SiberianDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SiberianDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SiberianDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SiberianDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SiberianDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SiberianDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SiberianDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SiberianDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SiberianDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SiberianDB] SET RECOVERY FULL 
GO
ALTER DATABASE [SiberianDB] SET  MULTI_USER 
GO
ALTER DATABASE [SiberianDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SiberianDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SiberianDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SiberianDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SiberianDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SiberianDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SiberianDB', N'ON'
GO
ALTER DATABASE [SiberianDB] SET QUERY_STORE = OFF
GO
USE [SiberianDB]
GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 16/10/2021 0:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
	[IDCiudad] [int] IDENTITY(1,1) NOT NULL,
	[NombreCiudad] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurantes]    Script Date: 16/10/2021 0:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurantes](
	[IDRestaurante] [int] IDENTITY(1,1) NOT NULL,
	[NombreRestaurante] [varchar](50) NOT NULL,
	[IDCiudad] [varchar](255) NOT NULL,
	[NumeroAforo] [varchar](5) NOT NULL,
	[Telefono] [varchar](15) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDRestaurante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ciudades]    Script Date: 16/10/2021 0:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Ciudades] 
    @codigo char(1),
	@IDCiudad varchar(50) NULL = '',
    @NombreCiudad varchar(50) NULL = ''
AS
    IF(@codigo = 1)
    INSERT INTO dbo.Ciudad (NombreCiudad, FechaCreacion)
	VALUES (@NombreCiudad, GETDATE());
	ELSE IF(@codigo = 2)
    UPDATE dbo.Ciudad
	SET NombreCiudad = @NombreCiudad
	WHERE IDCiudad = @IDCiudad;
	ELSE IF(@codigo = 3)
	SELECT * FROM dbo.Ciudad
	ELSE IF(@codigo = 4)
	SELECT * FROM dbo.Ciudad
	WHERE IDCiudad = @IDCiudad;
	ELSE IF(@codigo = 5)
    DELETE FROM dbo.Ciudad WHERE IDCiudad = @IDCiudad;
RETURN 0 
GO
/****** Object:  StoredProcedure [dbo].[Sp_Restaurantes]    Script Date: 16/10/2021 0:04:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Restaurantes] 
    @codigo char(1),
	@IDRestaurante varchar(50) NULL = '',
    @NombreRestaurante varchar(50) NULL = '', 
	@IDCiudad int NULL = '',
	@NumeroAforo varchar(10) NULL = '',
	@Telefono varchar(15) NULL = ''	
AS
	IF(@codigo = 1)
	SELECT * FROM dbo.Restaurantes
	INNER JOIN dbo.Ciudad ON Restaurantes.IDCiudad = Ciudad.IDCiudad; 
    ELSE IF(@codigo = 2)
    SELECT * FROM dbo.Restaurantes
	INNER JOIN dbo.Ciudad ON Restaurantes.IDCiudad = Ciudad.IDCiudad
	WHERE IDRestaurante = @IDRestaurante; 
	ELSE IF(@codigo = 3)
    INSERT INTO dbo.Restaurantes (NombreRestaurante, IDCiudad, NumeroAforo, Telefono, FechaCreacion)
	VALUES (@NombreRestaurante, @IDCiudad, @NumeroAforo, @Telefono, GETDATE());
	ELSE IF(@codigo = 4)
    UPDATE dbo.Restaurantes
	SET NombreRestaurante = @NombreRestaurante, IDCiudad = @IDCiudad, NumeroAforo = @NumeroAforo, Telefono = @Telefono
	WHERE IDRestaurante = @IDRestaurante;
	ELSE IF(@codigo = 5)
    DELETE FROM dbo.Restaurantes WHERE IDRestaurante = @IDRestaurante;
RETURN 0 
GO
USE [master]
GO
ALTER DATABASE [SiberianDB] SET  READ_WRITE 
GO
