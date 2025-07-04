USE [master]
GO
/****** Object:  Database [CEFEGEN]    Script Date: 04/07/2025 19:48:55 ******/
CREATE DATABASE [CEFEGEN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CEFEGEN_TEST', FILENAME = N'E:\BackupsBD\CEFEGEN.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CEFEGEN_TEST_log', FILENAME = N'E:\BackupsBD\CEFEGEN_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CEFEGEN] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CEFEGEN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CEFEGEN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CEFEGEN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CEFEGEN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CEFEGEN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CEFEGEN] SET ARITHABORT OFF 
GO
ALTER DATABASE [CEFEGEN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CEFEGEN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CEFEGEN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CEFEGEN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CEFEGEN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CEFEGEN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CEFEGEN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CEFEGEN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CEFEGEN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CEFEGEN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CEFEGEN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CEFEGEN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CEFEGEN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CEFEGEN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CEFEGEN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CEFEGEN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CEFEGEN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CEFEGEN] SET RECOVERY FULL 
GO
ALTER DATABASE [CEFEGEN] SET  MULTI_USER 
GO
ALTER DATABASE [CEFEGEN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CEFEGEN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CEFEGEN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CEFEGEN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CEFEGEN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CEFEGEN] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CEFEGEN', N'ON'
GO
ALTER DATABASE [CEFEGEN] SET QUERY_STORE = ON
GO
ALTER DATABASE [CEFEGEN] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CEFEGEN]
GO
/****** Object:  DatabaseRole [RolUsuario]    Script Date: 04/07/2025 19:48:55 ******/
CREATE ROLE [RolUsuario]
GO
/****** Object:  DatabaseRole [RolAnalista]    Script Date: 04/07/2025 19:48:55 ******/
CREATE ROLE [RolAnalista]
GO
USE [CEFEGEN]
GO
/****** Object:  Sequence [dbo].[SEQ_CodigoSolicitud]    Script Date: 04/07/2025 19:48:55 ******/
CREATE SEQUENCE [dbo].[SEQ_CodigoSolicitud] 
 AS [int]
 START WITH 20000
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  UserDefinedTableType [dbo].[LineaFacturaTipo]    Script Date: 04/07/2025 19:48:55 ******/
CREATE TYPE [dbo].[LineaFacturaTipo] AS TABLE(
	[IdPrueba] [int] NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[Importe] [decimal](10, 2) NOT NULL,
	[Cantidad] [int] NOT NULL
)
GO
/****** Object:  Table [dbo].[Solicitudes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitudes](
	[IdSolicitud] [int] IDENTITY(1,1) NOT NULL,
	[FechaSolicitud] [datetime] NOT NULL,
	[IdSolicitante] [int] NULL,
	[Observaciones] [nvarchar](max) NULL,
	[IdTipoPruebaConsumo] [int] NULL,
	[IdTipoMuestra] [int] NULL,
	[IdPlazoEntrega] [int] NOT NULL,
	[IdFormaPago] [int] NULL,
	[IdFormaEntrega] [int] NOT NULL,
	[CodigoSolicitud] [int] NOT NULL,
	[EstadoBit] [bit] NOT NULL,
	[EsForense] [bit] NOT NULL,
	[IdEstado] [int] NOT NULL,
	[EstadoResultados] [nvarchar](50) NULL,
	[IdUsuarioCreador] [int] NULL,
	[TotalPrecio] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Solicitudes_CodigoSolicitud] UNIQUE NONCLUSTERED 
(
	[CodigoSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PerfilesGeneticos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerfilesGeneticos](
	[IdPerfilGenetico] [int] IDENTITY(1,1) NOT NULL,
	[IdInterviniente] [int] NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Valido] [bit] NOT NULL,
	[IdUsuarioAnalista] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPerfilGenetico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intervinientes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intervinientes](
	[IdInterviniente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellidos] [nvarchar](150) NOT NULL,
	[NumeroDocumento] [nvarchar](20) NOT NULL,
	[FechaNacimiento] [date] NULL,
	[Sexo] [char](1) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[RepresentanteLegal] [nvarchar](255) NULL,
	[DocumentoRepresentante] [nvarchar](20) NULL,
	[Notas] [nvarchar](max) NULL,
	[IdSolicitud] [int] NULL,
	[IdSolicitante] [int] NULL,
	[IdTipoInterviniente] [char](4) NOT NULL,
	[IdDireccion] [int] NULL,
	[IdTipoDocumento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdInterviniente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Intervinientes_IdSolicitud_Nombre] UNIQUE NONCLUSTERED 
(
	[IdSolicitud] ASC,
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IndiceParentesco]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndiceParentesco](
	[IdIndiceParentesco] [int] IDENTITY(1,1) NOT NULL,
	[IdSolicitud] [int] NOT NULL,
	[IdPerfilGenetico1] [int] NOT NULL,
	[IdPerfilGenetico2] [int] NOT NULL,
	[TipoRelacion] [varchar](50) NOT NULL,
	[IndiceCombinadoParentesco] [decimal](18, 6) NULL,
	[LikelihoodRatio] [decimal](18, 6) NULL,
	[ProbabilidadParentesco] [decimal](5, 2) NULL,
	[MarcadoresGeneticos] [nvarchar](max) NULL,
	[NumeroMarcadores] [int] NULL,
	[Resultado] [varchar](100) NULL,
	[Observaciones] [nvarchar](1000) NULL,
	[FechaAnalisis] [datetime] NOT NULL,
	[IdUsuarioAnalista] [int] NOT NULL,
	[Estado] [varchar](20) NOT NULL,
	[IdResultadoParentesco] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIndiceParentesco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ReporteMadreHijo]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ReporteMadreHijo]
AS
SELECT
    s.IdSolicitud,
    s.FechaSolicitud,
    i1.Nombre AS NombreHijo,
    i2.Nombre AS NombreMadre,
    ip.IndiceCombinadoParentesco,
    ip.LikelihoodRatio,
    ip.ProbabilidadParentesco,
    ip.Resultado,
    ip.FechaAnalisis
FROM [dbo].[Solicitudes] s
JOIN [dbo].[IndiceParentesco] ip ON s.IdSolicitud = ip.IdSolicitud
JOIN [dbo].[PerfilesGeneticos] pg1 ON ip.IdPerfilGenetico1 = pg1.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i1 ON pg1.IdInterviniente = i1.IdInterviniente
JOIN [dbo].[PerfilesGeneticos] pg2 ON ip.IdPerfilGenetico2 = pg2.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i2 ON pg2.IdInterviniente = i2.IdInterviniente
WHERE ip.TipoRelacion = 'Madre-Hijo';
GO
/****** Object:  Table [dbo].[Direcciones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direcciones](
	[IdDireccion] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPais] [char](2) NOT NULL,
	[CodigoProvincia] [char](2) NULL,
	[CodigoMunicipio] [char](6) NULL,
	[CodigoPostal] [nvarchar](10) NULL,
	[ProvinciaTexto] [nvarchar](100) NULL,
	[MunicipioTexto] [nvarchar](100) NULL,
	[CodigoPostalTexto] [nvarchar](20) NULL,
	[Direccion] [nvarchar](255) NOT NULL,
	[Direccion2] [nvarchar](255) NULL,
	[FuenteDatos] [nvarchar](50) NULL,
	[EstadoNormalizacion] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[CodigoPais] [char](2) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincias](
	[CodigoProvincia] [char](2) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoProvincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Poblaciones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poblaciones](
	[CodigoMunicipio] [char](6) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[CodigoProvincia] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodigoMunicipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LaboratoriosColaboradores]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LaboratoriosColaboradores](
	[IdLaboratorioColaborador] [int] IDENTITY(1,1) NOT NULL,
	[NombreFiscal] [nvarchar](50) NOT NULL,
	[NombreComercial] [nvarchar](50) NULL,
	[CIF] [nvarchar](20) NOT NULL,
	[Contacto] [nvarchar](50) NOT NULL,
	[Telefono] [nvarchar](20) NOT NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Web] [nvarchar](100) NULL,
	[FechaAlta] [date] NOT NULL,
	[IdTipoClienteConsumo] [int] NULL,
	[IdActividad] [int] NULL,
	[IdTarifa] [int] NULL,
	[IdFormaPago] [int] NULL,
	[IdIVA] [int] NULL,
	[IdIdioma] [char](2) NULL,
	[IdBanco] [int] NULL,
	[IdPersonal] [int] NULL,
	[TipoCliente] [smallint] NULL,
	[Descuento] [float] NULL,
	[IRPF] [float] NULL,
	[DomiciliacionBanco] [smallint] NULL,
	[NombreBanco] [nvarchar](100) NULL,
	[CuentaBanco] [nvarchar](100) NULL,
	[SwiftBanco] [nvarchar](100) NULL,
	[FormaPago] [nvarchar](100) NULL,
	[DiaPagoFijo1] [smallint] NULL,
	[DiaPagoFijo2] [smallint] NULL,
	[DiaPagoFijo3] [smallint] NULL,
	[DiasAplazamiento] [smallint] NULL,
	[PagoDiario] [smallint] NULL,
	[ValidarPrecios] [smallint] NULL,
	[FechaInicial] [datetime2](7) NULL,
	[FechaFinal] [datetime2](7) NULL,
	[FechaInicialC] [datetime2](7) NULL,
	[FechaFinalC] [datetime2](7) NULL,
	[IdAvisoTecnico] [int] NULL,
	[IdAvisoAdmon] [int] NULL,
	[IdAvisoFacturacion] [int] NULL,
	[IdAvisoInternas] [int] NULL,
	[MembreteCliente] [smallint] NULL,
	[FormatoFactura] [smallint] NULL,
	[TipoReferencias] [smallint] NULL,
	[RefContrato] [nvarchar](500) NULL,
	[Horario] [nvarchar](100) NULL,
	[HorarioVerano] [nvarchar](100) NULL,
	[Concepto1] [nvarchar](max) NULL,
	[Concepto2] [nvarchar](max) NULL,
	[Concepto3] [nvarchar](max) NULL,
	[CarpetaFichero] [nvarchar](1000) NULL,
	[Bloquear] [bit] NOT NULL,
	[EstadoContrato] [bit] NOT NULL,
	[IdDireccion] [int] NULL,
	[IdIdiomaPreferido] [char](2) NULL,
	[PrefiereSMS] [bit] NOT NULL,
	[TelefonoSMS] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdLaboratorioColaborador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_LaboratoriosColaboradoresBasicos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Actualizar definiciones de todas las vistas
-- 2.1. vw_LaboratoriosColaboradoresBasicos (sin cambios)
CREATE   VIEW [dbo].[vw_LaboratoriosColaboradoresBasicos] AS
SELECT
    lc.IdLaboratorioColaborador,
    lc.NombreFiscal,
    lc.NombreComercial,
    d.Direccion,
    d.Direccion2,
    COALESCE(d.CodigoPostalTexto, d.CodigoPostal) AS CodigoPostal,
    COALESCE(d.MunicipioTexto, po.Nombre) AS Poblacion,
    COALESCE(d.ProvinciaTexto, pr.Nombre) AS Provincia,
    pa.Nombre AS Pais,
    lc.Telefono,
    lc.Telefono2,
    lc.Contacto,
    lc.Email
FROM dbo.LaboratoriosColaboradores lc
LEFT JOIN dbo.Direcciones d ON lc.IdDireccion = d.IdDireccion
LEFT JOIN dbo.Poblaciones po ON d.CodigoMunicipio = po.CodigoMunicipio
LEFT JOIN dbo.Provincias pr ON d.CodigoProvincia = pr.CodigoProvincia
LEFT JOIN dbo.Paises pa ON d.CodigoPais = pa.CodigoPais;
GO
/****** Object:  View [dbo].[vw_ReporteHermanos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ReporteHermanos]
AS
SELECT
    s.IdSolicitud,
    s.FechaSolicitud,
    i1.Nombre AS NombreHermano1,
    i2.Nombre AS NombreHermano2,
    ip.IndiceCombinadoParentesco,
    ip.LikelihoodRatio,
    ip.ProbabilidadParentesco,
    ip.Resultado,
    ip.FechaAnalisis
FROM [dbo].[Solicitudes] s
JOIN [dbo].[IndiceParentesco] ip ON s.IdSolicitud = ip.IdSolicitud
JOIN [dbo].[PerfilesGeneticos] pg1 ON ip.IdPerfilGenetico1 = pg1.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i1 ON pg1.IdInterviniente = i1.IdInterviniente
JOIN [dbo].[PerfilesGeneticos] pg2 ON ip.IdPerfilGenetico2 = pg2.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i2 ON pg2.IdInterviniente = i2.IdInterviniente
WHERE ip.TipoRelacion = 'Hermanos';
GO
/****** Object:  View [dbo].[vw_LaboratoriosActivos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.2. vw_LaboratoriosActivos (sin cambios)
CREATE   VIEW [dbo].[vw_LaboratoriosActivos] AS
SELECT
    lc.IdLaboratorioColaborador,
    lc.NombreFiscal,
    lc.NombreComercial,
    d.Direccion,
    lc.Contacto,
    lc.Telefono,
    lc.Email
FROM dbo.LaboratoriosColaboradores lc
LEFT JOIN dbo.Direcciones d ON lc.IdDireccion = d.IdDireccion
WHERE ISNULL(lc.Bloquear, 0) = 0;
GO
/****** Object:  View [dbo].[vw_ReporteAbueloNieto]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ReporteAbueloNieto]
AS
SELECT
    s.IdSolicitud,
    s.FechaSolicitud,
    i1.Nombre AS NombreNieto,
    i2.Nombre AS NombreAbuelo,
    ip.IndiceCombinadoParentesco,
    ip.LikelihoodRatio,
    ip.ProbabilidadParentesco,
    ip.Resultado,
    ip.FechaAnalisis
FROM [dbo].[Solicitudes] s
JOIN [dbo].[IndiceParentesco] ip ON s.IdSolicitud = ip.IdSolicitud
JOIN [dbo].[PerfilesGeneticos] pg1 ON ip.IdPerfilGenetico1 = pg1.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i1 ON pg1.IdInterviniente = i1.IdInterviniente
JOIN [dbo].[PerfilesGeneticos] pg2 ON ip.IdPerfilGenetico2 = pg2.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i2 ON pg2.IdInterviniente = i2.IdInterviniente
WHERE ip.TipoRelacion = 'Abuelo-Nieto';
GO
/****** Object:  Table [dbo].[ReferenciasPaciente]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenciasPaciente](
	[IdReferenciaPaciente] [int] IDENTITY(1,1) NOT NULL,
	[IdSolicitante] [int] NOT NULL,
	[IdTipoReferencia] [int] NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[FechaReferencia] [date] NOT NULL,
	[IdPersonalRegistro] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdReferenciaPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferenciaDetalles]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenciaDetalles](
	[IdReferenciaPaciente] [int] NOT NULL,
	[IdLaboratorioColaborador] [int] NULL,
	[IdMedico] [int] NULL,
	[IdAbogado] [int] NULL,
	[IdCampaniaMarketing] [int] NULL,
	[UrlLandingPage] [nvarchar](255) NULL,
	[Observaciones] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdReferenciaPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_LaboratoriosConReferenciasUltimoAno]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.3. vw_LaboratoriosConReferenciasUltimoAno (sin cambios)
CREATE   VIEW [dbo].[vw_LaboratoriosConReferenciasUltimoAno] AS
SELECT
    lc.IdLaboratorioColaborador,
    lc.NombreFiscal,
    lc.Contacto,
    lc.Telefono,
    lc.Email,
    COUNT(r.IdReferenciaPaciente) AS TotalReferencias,
    MIN(r.FechaReferencia) AS PrimeraReferencia,
    MAX(r.FechaReferencia) AS UltimaReferencia
FROM dbo.ReferenciasPaciente r
JOIN dbo.ReferenciaDetalles d ON r.IdReferenciaPaciente = d.IdReferenciaPaciente
JOIN dbo.LaboratoriosColaboradores lc ON d.IdLaboratorioColaborador = lc.IdLaboratorioColaborador
WHERE r.FechaReferencia >= DATEADD(YEAR, -1, GETDATE())
GROUP BY 
    lc.IdLaboratorioColaborador,
    lc.NombreFiscal,
    lc.Contacto,
    lc.Telefono,
    lc.Email;
GO
/****** Object:  Table [dbo].[ResultadosParentesco]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultadosParentesco](
	[IdResultadoParentesco] [int] IDENTITY(1,1) NOT NULL,
	[IdInterviniente] [int] NOT NULL,
	[Alelo1] [nvarchar](50) NULL,
	[Alelo2] [nvarchar](50) NULL,
	[Resultado] [nvarchar](255) NULL,
	[FechaRegistro] [date] NOT NULL,
	[IdPersonalRegistro] [int] NULL,
	[IdLineaPeticion] [int] NULL,
	[IdMarcador] [int] NOT NULL,
	[ValidadoPor] [int] NULL,
	[EstadoValidacion] [nvarchar](50) NULL,
	[FechaValidacion] [datetime] NULL,
	[IdDocumento] [int] NULL,
	[Notificado] [bit] NOT NULL,
	[EstadoValidacionFinal] [nvarchar](50) NULL,
	[FechaResultado] [datetime] NULL,
	[IdSolicitud] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdResultadoParentesco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MarcadoresGeneticos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarcadoresGeneticos](
	[IdMarcador] [int] IDENTITY(1,1) NOT NULL,
	[NombreMarcador] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Activo] [bit] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMarcador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NombreMarcador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ReportePaternidadDetallado]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[vw_ReportePaternidadDetallado]
AS
SELECT
    s.IdSolicitud,
    s.FechaSolicitud,
    i1.Nombre AS NombreHijo,
    i2.Nombre AS NombrePadre,
    ip.IndiceCombinadoParentesco,
    ip.LikelihoodRatio,
    ip.ProbabilidadParentesco,
    ip.Resultado,
    ip.FechaAnalisis,
    mg.NombreMarcador AS MarcadorGenetico,
    rp1.Alelo1 AS Alelo1_Hijo,
    rp1.Alelo2 AS Alelo2_Hijo,
    rp2.Alelo1 AS Alelo1_Padre,
    rp2.Alelo2 AS Alelo2_Padre
FROM [dbo].[Solicitudes] s
JOIN [dbo].[IndiceParentesco] ip ON s.IdSolicitud = ip.IdSolicitud
JOIN [dbo].[PerfilesGeneticos] pg1 ON ip.IdPerfilGenetico1 = pg1.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i1 ON pg1.IdInterviniente = i1.IdInterviniente
JOIN [dbo].[PerfilesGeneticos] pg2 ON ip.IdPerfilGenetico2 = pg2.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i2 ON pg2.IdInterviniente = i2.IdInterviniente
JOIN [dbo].[ResultadosParentesco] rp1 ON i1.IdInterviniente = rp1.IdInterviniente
JOIN [dbo].[ResultadosParentesco] rp2 ON i2.IdInterviniente = rp2.IdInterviniente AND rp1.IdMarcador = rp2.IdMarcador
JOIN [dbo].[MarcadoresGeneticos] mg ON rp1.IdMarcador = mg.IdMarcador
WHERE ip.TipoRelacion = 'Padre-Hijo';
GO
/****** Object:  View [dbo].[vw_RankingLaboratoriosPorReferencias]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.4. vw_RankingLaboratoriosPorReferencias (sin cambios)
CREATE   VIEW [dbo].[vw_RankingLaboratoriosPorReferencias] AS
SELECT
    lc.IdLaboratorioColaborador,
    lc.NombreFiscal,
    lc.Contacto,
    lc.Email,
    COUNT(r.IdReferenciaPaciente) AS TotalReferencias,
    MIN(r.FechaReferencia) AS PrimeraReferencia,
    MAX(r.FechaReferencia) AS UltimaReferencia
FROM dbo.ReferenciasPaciente r
JOIN dbo.ReferenciaDetalles d ON r.IdReferenciaPaciente = d.IdReferenciaPaciente
JOIN dbo.LaboratoriosColaboradores lc ON d.IdLaboratorioColaborador = lc.IdLaboratorioColaborador
GROUP BY 
    lc.IdLaboratorioColaborador,
    lc.NombreFiscal,
    lc.Contacto,
    lc.Email;
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [nvarchar](50) NOT NULL,
	[NombreCompleto] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[HashPassword] [nvarchar](255) NOT NULL,
	[Activo] [bit] NOT NULL,
	[CambiarPassword] [bit] NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[FechaUltimoAcceso] [datetime] NULL,
	[IdRol] [int] NOT NULL,
	[IdPersonal] [int] NULL,
	[Observaciones] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NombreUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditoriasCalidad]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditoriasCalidad](
	[IdAuditoria] [int] IDENTITY(1,1) NOT NULL,
	[TipoAuditoria] [nvarchar](50) NOT NULL,
	[FechaAuditoria] [datetime] NOT NULL,
	[Resultado] [nvarchar](100) NOT NULL,
	[Observaciones] [nvarchar](max) NULL,
	[Documento] [varbinary](max) NULL,
	[NombreArchivo] [nvarchar](255) NULL,
	[IdUsuarioResponsable] [int] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAuditoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Acreditaciones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Acreditaciones](
	[IdAcreditacion] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[EntidadAcreditadora] [nvarchar](100) NOT NULL,
	[FechaEmision] [date] NOT NULL,
	[FechaExpiracion] [date] NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[NombreArchivo] [nvarchar](100) NOT NULL,
	[IdUsuarioRegistro] [int] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[ArchivoReferencia] [nvarchar](50) NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[EsConfidencial] [bit] NOT NULL,
	[HashDocumento] [nvarchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAcreditacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValidacionesResultado]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValidacionesResultado](
	[IdValidacion] [int] IDENTITY(1,1) NOT NULL,
	[IdResultado] [int] NOT NULL,
	[TipoResultado] [nvarchar](50) NOT NULL,
	[IdUsuarioValidador] [int] NOT NULL,
	[EstadoValidacion] [nvarchar](50) NOT NULL,
	[Observaciones] [nvarchar](max) NULL,
	[FechaValidacion] [datetime] NOT NULL,
	[NivelValidacion] [int] NOT NULL,
	[EsFinal] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdValidacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_InformeCumplimientoCalidad]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_InformeCumplimientoCalidad]
AS
SELECT 
    'Auditorías' AS TipoRegistro,
    ac.IdAuditoria AS IdRegistro,
    ac.TipoAuditoria AS Descripcion,
    ac.FechaAuditoria AS Fecha,
    ac.Resultado AS Estado,
    u.NombreCompleto AS Responsable,
    ac.Observaciones
FROM [dbo].[AuditoriasCalidad] ac
JOIN [dbo].[Usuarios] u ON ac.IdUsuarioResponsable = u.IdUsuario
UNION ALL
SELECT 
    'Acreditaciones' AS TipoRegistro,
    a.IdAcreditacion AS IdRegistro,
    a.Nombre + ' (' + a.EntidadAcreditadora + ')' AS Descripcion,
    a.FechaEmision AS Fecha,
    a.Estado AS Estado,
    u.NombreCompleto AS Responsable,
    NULL AS Observaciones
FROM [dbo].[Acreditaciones] a
JOIN [dbo].[Usuarios] u ON a.IdUsuarioRegistro = u.IdUsuario
UNION ALL
SELECT 
    'Validaciones' AS TipoRegistro,
    vr.IdValidacion AS IdRegistro,
    vr.TipoResultado + ' (IdResultado: ' + CAST(vr.IdResultado AS NVARCHAR(10)) + ')' AS Descripcion,
    vr.FechaValidacion AS Fecha,
    vr.EstadoValidacion AS Estado,
    u.NombreCompleto AS Responsable,
    vr.Observaciones
FROM [dbo].[ValidacionesResultado] vr
JOIN [dbo].[Usuarios] u ON vr.IdUsuarioValidador = u.IdUsuario;
GO
/****** Object:  Table [dbo].[TiposDocumentos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposDocumentos](
	[IdTipoDocumento] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[RequiereAprobacion] [bit] NOT NULL,
	[FormatosPermitidos] [nvarchar](100) NULL,
	[TamanhoMaximoMB] [decimal](5, 2) NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entidades]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entidades](
	[IdEntidadTipo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEntidadTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solicitantes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitantes](
	[IdSolicitante] [int] IDENTITY(1,1) NOT NULL,
	[NumeroDocumento] [nvarchar](20) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellidos] [nvarchar](150) NOT NULL,
	[FechaNacimiento] [date] NULL,
	[Sexo] [char](1) NULL,
	[Telefono] [nvarchar](20) NOT NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[IdTipoReferencia] [int] NOT NULL,
	[DetalleReferencia] [nvarchar](255) NULL,
	[FechaAlta] [date] NOT NULL,
	[IdLaboratorioColaborador] [int] NULL,
	[IdMedico] [int] NULL,
	[CodigoAsegurado] [nvarchar](30) NULL,
	[IdTarifa] [int] NULL,
	[IdFormaPago] [int] NULL,
	[Descuento] [float] NULL,
	[AutorizaEnvioResultados] [bit] NOT NULL,
	[UrlPDFEnvioResultados] [nvarchar](255) NULL,
	[Bloquear] [bit] NOT NULL,
	[Nollamar] [bit] NOT NULL,
	[EnviarEmail] [bit] NOT NULL,
	[EnviarEmailPet] [bit] NOT NULL,
	[EnviarEmailFac] [bit] NOT NULL,
	[EnviarEmailNotif] [bit] NOT NULL,
	[IdDireccion] [int] NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[IdIdiomaPreferido] [char](2) NULL,
	[AutorizaPortal] [bit] NOT NULL,
	[PrefiereSMS] [bit] NOT NULL,
	[TelefonoSMS] [nvarchar](20) NULL,
	[RepresentanteLegal] [bit] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
 CONSTRAINT [PK_Solicitantes] PRIMARY KEY CLUSTERED 
(
	[IdSolicitante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Solicitantes] UNIQUE NONCLUSTERED 
(
	[NumeroDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Documentos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documentos](
	[IdDocumento] [int] IDENTITY(1,1) NOT NULL,
	[IdEntidad] [int] NOT NULL,
	[NombreArchivo] [nvarchar](255) NULL,
	[ArchivoReferencia] [nvarchar](50) NOT NULL,
	[Extension] [nvarchar](10) NULL,
	[TamanoKB] [int] NULL,
	[FechaSubida] [datetime] NOT NULL,
	[SubidoPor] [int] NULL,
	[Comentarios] [nvarchar](max) NULL,
	[IdTipoDocumento] [int] NULL,
	[IdEntidadTipo] [int] NULL,
	[EsConfidencial] [bit] NOT NULL,
	[FechaExpiracion] [datetime] NULL,
	[HashDocumento] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_DocumentosPorSolicitante]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.8. vw_DocumentosPorSolicitante (renombrada y actualizada)
CREATE   VIEW [dbo].[vw_DocumentosPorSolicitante] AS
SELECT
    d.IdDocumento,
    d.IdEntidad AS IdSolicitante,
    s.Nombre + ' ' + s.Apellidos AS NombreSolicitante,
    td.Nombre AS TipoDocumento,
    d.NombreArchivo,
    d.RutaArchivo,
    d.FechaSubida,
    d.Comentarios
FROM dbo.Documentos d
JOIN dbo.Entidades e ON d.IdEntidadTipo = e.IdEntidadTipo
JOIN dbo.TiposDocumentos td ON d.IdTipoDocumento = td.IdTipoDocumento
JOIN dbo.Solicitantes s ON e.Nombre = 'Solicitantes' AND d.IdEntidad = s.IdSolicitante;
GO
/****** Object:  Table [dbo].[Personal]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personal](
	[IdPersonal] [int] IDENTITY(1,1) NOT NULL,
	[NombrePersonal] [nvarchar](50) NOT NULL,
	[FechaNacimiento] [datetime] NULL,
	[LugarNacimiento] [nvarchar](100) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[TipoPersonal] [smallint] NULL,
	[IdCargo] [int] NULL,
	[FechaAlta] [datetime] NULL,
	[FechaBaja] [datetime] NULL,
	[Firma] [varbinary](max) NULL,
	[Imagen] [varbinary](max) NULL,
	[FirmaPdfTextoFirma] [nvarchar](max) NULL,
	[FirmaPdfSufijo] [nvarchar](100) NULL,
	[FirmaPdfTipoFirma] [smallint] NULL,
	[FirmaPdfImagenFirma] [nvarchar](1000) NULL,
	[FirmaPdfPosicion] [smallint] NULL,
	[FirmaPdfMargenes] [int] NULL,
	[FirmaPdfOrigenCertificado] [smallint] NULL,
	[FirmaPdfOrigenPfxFichero] [nvarchar](1000) NULL,
	[FirmaPdfOrigenPfxPasswd] [nvarchar](100) NULL,
	[FirmaPdfOrigenAlmacWinId] [nvarchar](100) NULL,
	[FirmaPdfConservarOriginales] [smallint] NULL,
	[Textovalidacion] [nvarchar](max) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasAdmon] [nvarchar](max) NULL,
	[NotasFacturacion] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Parametros] [nvarchar](max) NULL,
	[VidaLaboral] [nvarchar](max) NULL,
	[Vacaciones] [nvarchar](max) NULL,
	[FormacionAcademica] [nvarchar](max) NULL,
	[ExperienciaLaboral] [nvarchar](max) NULL,
	[CaracteristicasPersonales] [nvarchar](max) NULL,
	[TareasRealizar] [nvarchar](max) NULL,
	[Funciones] [nvarchar](max) NULL,
	[Responsabilidades] [nvarchar](max) NULL,
	[RequisitosPuesto] [nvarchar](max) NULL,
	[IdEspecialidad] [int] NULL,
	[PuestoAbreviado] [nvarchar](30) NULL,
	[IdRol] [int] NULL,
	[Bloquear] [bit] NOT NULL,
	[IdDireccion] [int] NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[NumeroDocumento] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPersonal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[IdRol] [int] IDENTITY(1,1) NOT NULL,
	[NombreRol] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NombreRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_UsuariosRoles]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_UsuariosRoles] AS
SELECT 
    u.IdUsuario, u.NombreUsuario, u.Email, u.Activo, u.FechaCreacion,
    r.NombreRol AS RolNombre,
    p.NombrePersonal AS NombrePersonal
FROM Usuarios u
INNER JOIN Roles r ON u.IdRol = r.IdRol
LEFT JOIN Personal p ON p.IdPersonal = u.IdUsuario;
GO
/****** Object:  Table [dbo].[Peticiones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peticiones](
	[IdPeticion] [int] IDENTITY(1,1) NOT NULL,
	[IdSolicitud] [int] NULL,
	[EstadoPeticion] [varchar](20) NULL,
	[FechaPeticion] [datetime] NULL,
	[IdTipoPrueba] [int] NULL,
	[IdSubTipoPrueba] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPeticion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[IdEstado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Activo] [bit] NULL,
	[DisparaNotificacion] [bit] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposPrueba]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposPrueba](
	[IdTipoPrueba] [int] IDENTITY(1,1) NOT NULL,
	[Activo] [bit] NULL,
	[Categoria] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoPrueba] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolicitudesSolicitantes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolicitudesSolicitantes](
	[IdSolicitudSolicitante] [int] IDENTITY(1,1) NOT NULL,
	[IdSolicitud] [int] NOT NULL,
	[IdSolicitante] [int] NOT NULL,
	[EsInterviniente] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdSolicitudSolicitante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_SolicitudSolicitante] UNIQUE NONCLUSTERED 
(
	[IdSolicitud] ASC,
	[IdSolicitante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_SolicitudesDetalladas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_SolicitudesDetalladas] AS
SELECT 
    s.IdSolicitud, s.CodigoSolicitud, s.FechaSolicitud, e.Nombre AS Estado,
    ss.IdSolicitante, sol.Nombre AS SolicitanteNombre,
    p.IdPeticion, tp.Categoria AS TipoPrueba
FROM Solicitudes s
JOIN Estados e ON s.IdEstado = e.IdEstado
JOIN SolicitudesSolicitantes ss ON s.IdSolicitud = ss.IdSolicitud
JOIN Solicitantes sol ON ss.IdSolicitante = sol.IdSolicitante
JOIN Peticiones p ON s.IdSolicitud = p.IdSolicitud
JOIN TiposPrueba tp ON p.IdTipoPrueba = tp.IdTipoPrueba;
GO
/****** Object:  Table [dbo].[NotificacionesSMS]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificacionesSMS](
	[IdNotificacionSMS] [int] IDENTITY(1,1) NOT NULL,
	[IdSolicitud] [int] NULL,
	[TelefonoDestinatario] [nvarchar](20) NOT NULL,
	[Mensaje] [nvarchar](160) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[FechaEnvio] [datetime] NOT NULL,
	[IdUsuario] [int] NULL,
	[IdExterno] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNotificacionSMS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Envios]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Envios](
	[IdEnvio] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime2](7) NOT NULL,
	[FechaEnviado] [datetime2](7) NULL,
	[Asunto] [nvarchar](100) NULL,
	[Cuerpo] [nvarchar](max) NULL,
	[CodLaboratorioColaborador] [int] NULL,
	[CodMedico] [int] NULL,
	[CodPaciente] [int] NULL,
	[TipoEnvio] [smallint] NOT NULL,
	[CodGrupoEnvio] [int] NULL,
	[RegistroEnvio] [nvarchar](max) NULL,
	[Relaciones] [nvarchar](max) NULL,
	[Parametros] [nvarchar](max) NULL,
	[Estado] [bit] NOT NULL,
	[TipoNotificacion] [nvarchar](50) NULL,
	[IdExterno] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEnvio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DestinatariosEnvio]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DestinatariosEnvio](
	[IdDestinatario] [int] IDENTITY(1,1) NOT NULL,
	[IdEnvio] [int] NOT NULL,
	[Email] [nvarchar](255) NULL,
	[Tipo] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDestinatario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_HistorialNotificaciones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[vw_HistorialNotificaciones]
AS
SELECT 
    'Email' AS Canal,
    e.IdEnvio AS IdRegistro,
    e.TipoNotificacion AS TipoNotificacion,
    e.Asunto,
    e.Cuerpo AS Mensaje,
    d.Email AS Destinatario,
    e.Fecha AS FechaCreacion,
    CASE 
        WHEN e.Estado = 1 THEN 'Enviado'
        WHEN e.Estado = 0 THEN 'Fallido'
        ELSE 'Unknown'
    END AS Estado, -- Cast bit to nvarchar
    s.IdSolicitud,
    NULL AS Responsable
FROM [dbo].[Envios] e
JOIN [dbo].[DestinatariosEnvio] d ON e.IdEnvio = d.IdEnvio
LEFT JOIN [dbo].[Solicitudes] s ON e.CodPaciente = s.IdSolicitante
UNION ALL
SELECT 
    'SMS' AS Canal,
    ns.IdNotificacionSMS AS IdRegistro,
    NULL AS TipoNotificacion,
    NULL AS Asunto,
    ns.Mensaje,
    ns.TelefonoDestinatario AS Destinatario,
    ns.FechaEnvio AS FechaCreacion,
    ns.Estado, -- Already nvarchar
    ns.IdSolicitud,
    u.NombreCompleto AS Responsable
FROM [dbo].[NotificacionesSMS] ns
LEFT JOIN [dbo].[Solicitudes] s ON ns.IdSolicitud = s.IdSolicitud
LEFT JOIN [dbo].[Usuarios] u ON ns.IdUsuario = u.IdUsuario;
GO
/****** Object:  Table [dbo].[Empresas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empresas](
	[IdEmpresa] [int] IDENTITY(1,1) NOT NULL,
	[NombreFiscal] [nvarchar](100) NOT NULL,
	[NombreComercial] [nvarchar](100) NOT NULL,
	[CIF] [nvarchar](20) NULL,
	[CodigoAlternativo] [nvarchar](30) NULL,
	[Contacto] [nvarchar](100) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Web] [nvarchar](100) NULL,
	[IdActividad] [int] NULL,
	[IdAvisoTecnico] [int] NULL,
	[IdAvisoAdmon] [int] NULL,
	[IdAvisoFacturacion] [int] NULL,
	[IdAvisoInternas] [int] NULL,
	[IdLaboratorioColaborador] [int] NULL,
	[CCC] [nvarchar](30) NULL,
	[EnviarEmailVarbinaryMax] [smallint] NOT NULL,
	[EnviarEmailNotifResNoConf] [smallint] NOT NULL,
	[Parametros] [nvarchar](max) NULL,
	[MembreteEmpresa] [smallint] NULL,
	[Bloquear] [bit] NOT NULL,
	[CrearFichero] [bit] NOT NULL,
	[ExportarWeb] [bit] NOT NULL,
	[EnviarEmail] [bit] NOT NULL,
	[EnviarEmailPet] [bit] NOT NULL,
	[EnviarEmailFac] [bit] NOT NULL,
	[EnviarEmailNotif] [bit] NOT NULL,
	[IdDireccion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEmpresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recibos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recibos](
	[IdRecibo] [int] IDENTITY(1,1) NOT NULL,
	[CodigoRecibo] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[DescripcionLarga] [nvarchar](max) NULL,
	[Importe] [decimal](18, 2) NOT NULL,
	[FechaRecibo] [date] NULL,
	[FechaPago] [date] NULL,
	[FechaVencimiento] [date] NULL,
	[EstadoRecibo] [nvarchar](50) NULL,
	[TipoRecibo] [nvarchar](50) NULL,
	[Pagado] [bit] NULL,
	[SepaMandatoId] [nvarchar](50) NULL,
	[SepaMandatoFecha] [date] NULL,
	[NombreDeudor] [nvarchar](255) NULL,
	[IdFactura] [int] NULL,
	[IdEmpresa] [int] NULL,
	[IdCliente] [int] NULL,
	[IdSolicitante] [int] NULL,
	[IdFormaPago] [int] NULL,
	[IdRemesa] [int] NULL,
	[CuentaBanco] [nvarchar](100) NULL,
	[SwiftBanco] [nvarchar](100) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Parametros] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRecibo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CodigoRecibo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecibosPagos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecibosPagos](
	[IdReciboPago] [int] IDENTITY(1,1) NOT NULL,
	[IdRecibo] [int] NOT NULL,
	[Importe] [decimal](18, 2) NOT NULL,
	[FechaPago] [datetime] NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[IdPersonalRegistro] [int] NULL,
	[IdFormaPago] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdReciboPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[IdFactura] [int] IDENTITY(1,1) NOT NULL,
	[IdSociedad] [int] NOT NULL,
	[EjercicioFactura] [int] NOT NULL,
	[IdSerieFactura] [int] NOT NULL,
	[NumeroFactura] [int] NOT NULL,
	[FechaFactura] [datetime2](7) NOT NULL,
	[IdLaboratorioColaborador] [int] NULL,
	[IdSolicitante] [int] NULL,
	[NombreFiscal] [nvarchar](100) NOT NULL,
	[NombreComercial] [nvarchar](100) NULL,
	[CIF] [nvarchar](20) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[IdEmpresa] [int] NULL,
	[IdTarifa] [int] NULL,
	[CoeficienteTarifa] [float] NOT NULL,
	[IdIVA1] [int] NULL,
	[IdIVA2] [int] NULL,
	[IdIVA3] [int] NULL,
	[IVA1] [float] NOT NULL,
	[IVA2] [float] NOT NULL,
	[IVA3] [float] NOT NULL,
	[Base1] [float] NOT NULL,
	[Base2] [float] NOT NULL,
	[Base3] [float] NOT NULL,
	[ImporteTotal] [float] NOT NULL,
	[Descuento] [float] NOT NULL,
	[Incremento] [float] NOT NULL,
	[IRPF] [float] NOT NULL,
	[PagoCuenta] [float] NOT NULL,
	[Tarifa] [float] NOT NULL,
	[IdFormaPago] [int] NULL,
	[Vencimientos] [nvarchar](max) NULL,
	[TipoCambio] [float] NOT NULL,
	[FechaCambio] [datetime2](7) NULL,
	[DescripcionAbono] [nvarchar](max) NULL,
	[Parametros] [nvarchar](max) NULL,
	[NotasFacturacion] [nvarchar](max) NULL,
	[IdAvisoFacturacion] [int] NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[IdAvisoInternas] [int] NULL,
	[IdDireccion] [int] NULL,
	[EstadoFactura] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Factura_Numero] UNIQUE NONCLUSTERED 
(
	[IdSociedad] ASC,
	[EjercicioFactura] ASC,
	[IdSerieFactura] ASC,
	[NumeroFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_FacturasImpagadas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.5. vw_FacturasImpagadas (sin cambio en el nombre, actualizada para Solicitantes)
CREATE   VIEW [dbo].[vw_FacturasImpagadas] AS
SELECT 
    f.IdFactura,
    f.NumeroFactura,
    f.FechaFactura,
    f.ImporteTotal,
    ISNULL(SUM(rp.Importe), 0) AS ImportePagado,
    (f.ImporteTotal - ISNULL(SUM(rp.Importe), 0)) AS SaldoPendiente,
    f.EstadoFactura,
    f.IdEmpresa,
    e.NombreComercial AS EmpresaEmisora,
    lc.NombreFiscal AS NombreCliente,
    s.Nombre + ' ' + s.Apellidos AS NombreSolicitante
FROM dbo.Facturas f
LEFT JOIN dbo.Recibos r ON f.IdFactura = r.IdFactura
LEFT JOIN dbo.RecibosPagos rp ON r.IdRecibo = rp.IdRecibo
LEFT JOIN dbo.Solicitantes s ON f.IdSolicitante = s.IdSolicitante
LEFT JOIN dbo.LaboratoriosColaboradores lc ON f.IdLaboratorioColaborador = lc.IdLaboratorioColaborador
LEFT JOIN dbo.Empresas e ON f.IdEmpresa = e.IdEmpresa
WHERE f.EstadoFactura <> 'Anulada'
GROUP BY 
    f.IdFactura, f.NumeroFactura, f.FechaFactura, f.ImporteTotal,
    f.EstadoFactura, f.IdEmpresa, e.NombreComercial,
    lc.NombreFiscal, s.Nombre, s.Apellidos
HAVING (f.ImporteTotal - ISNULL(SUM(rp.Importe), 0)) > 0;
GO
/****** Object:  View [dbo].[vw_ReportePaternidad]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ReportePaternidad]
AS
SELECT
    s.IdSolicitud,
    s.FechaSolicitud,
    i1.Nombre AS NombreHijo,
    i2.Nombre AS NombrePadre,
    ip.IndiceCombinadoParentesco,
    ip.LikelihoodRatio,
    ip.ProbabilidadParentesco,
    ip.Resultado,
    ip.FechaAnalisis
FROM [dbo].[Solicitudes] s
JOIN [dbo].[IndiceParentesco] ip ON s.IdSolicitud = ip.IdSolicitud
JOIN [dbo].[PerfilesGeneticos] pg1 ON ip.IdPerfilGenetico1 = pg1.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i1 ON pg1.IdInterviniente = i1.IdInterviniente
JOIN [dbo].[PerfilesGeneticos] pg2 ON ip.IdPerfilGenetico2 = pg2.IdPerfilGenetico
JOIN [dbo].[Intervinientes] i2 ON pg2.IdInterviniente = i2.IdInterviniente
WHERE ip.TipoRelacion = 'Padre-Hijo';
GO
/****** Object:  Table [dbo].[Medicos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicos](
	[IdMedico] [int] IDENTITY(1,1) NOT NULL,
	[NombreMedico] [nvarchar](100) NOT NULL,
	[NombreComercial] [nvarchar](100) NULL,
	[CIF] [nvarchar](20) NULL,
	[CodMedicoA] [nvarchar](30) NULL,
	[Contacto] [nvarchar](100) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Web] [nvarchar](100) NULL,
	[IdActividad] [int] NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasAdmon] [nvarchar](max) NULL,
	[NotasFacturacion] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Bloquear] [bit] NOT NULL,
	[EnviarEmail] [bit] NOT NULL,
	[EnviarEmailPet] [bit] NOT NULL,
	[EnviarEmailNotif] [bit] NOT NULL,
	[IdDireccion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposReferencia]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposReferencia](
	[IdTipoReferencia] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoReferencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Campanias]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campanias](
	[IdCampaniaMarketing] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Tipo] [nvarchar](50) NULL,
	[FechaInicio] [date] NULL,
	[FechaFin] [date] NULL,
	[Activa] [bit] NOT NULL,
	[Observaciones] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCampaniaMarketing] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Abogados]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abogados](
	[IdAbogado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[CIF] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[IdDireccion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAbogado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ReferenciasSolicitantePorPeriodo]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.7. vw_ReferenciasSolicitantePorPeriodo (renombrada y actualizada)
CREATE   VIEW [dbo].[vw_ReferenciasSolicitantePorPeriodo] AS
SELECT
    r.IdReferenciaPaciente,
    r.IdSolicitante,
    s.Nombre + ' ' + s.Apellidos AS NombreSolicitante,
    r.FechaReferencia,
    t.Nombre AS TipoReferencia,
    r.Descripcion,
    d.IdLaboratorioColaborador,
    l.NombreFiscal AS NombreLaboratorio,
    d.IdMedico,
    m.NombreMedico,
    d.IdCampaniaMarketing,
    c.Nombre AS NombreCampania,
    d.IdAbogado,
    a.Nombre AS NombreAbogado
FROM dbo.ReferenciasPaciente r
JOIN dbo.TiposReferencia t ON r.IdTipoReferencia = t.IdTipoReferencia
JOIN dbo.Solicitantes s ON r.IdSolicitante = s.IdSolicitante
LEFT JOIN dbo.ReferenciaDetalles d ON r.IdReferenciaPaciente = d.IdReferenciaPaciente
LEFT JOIN dbo.LaboratoriosColaboradores l ON d.IdLaboratorioColaborador = l.IdLaboratorioColaborador
LEFT JOIN dbo.Medicos m ON d.IdMedico = m.IdMedico
LEFT JOIN dbo.Campanias c ON d.IdCampaniaMarketing = c.IdCampaniaMarketing
LEFT JOIN dbo.Abogados a ON d.IdAbogado = a.IdAbogado;
GO
/****** Object:  View [dbo].[vw_OrigenGeograficoSolicitantes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2.6. vw_OrigenGeograficoSolicitantes (renombrada y actualizada)
CREATE   VIEW [dbo].[vw_OrigenGeograficoSolicitantes] AS
SELECT
    s.IdSolicitante,
    s.FechaAlta,
    COALESCE(d.ProvinciaTexto, pr.Nombre) AS Provincia,
    COALESCE(d.MunicipioTexto, po.Nombre) AS Municipio,
    COALESCE(d.CodigoPostalTexto, d.CodigoPostal) AS CodigoPostal,
    d.CodigoPais
FROM dbo.Solicitantes s
LEFT JOIN dbo.Direcciones d ON s.IdDireccion = d.IdDireccion
LEFT JOIN dbo.Provincias pr ON d.CodigoProvincia = pr.CodigoProvincia
LEFT JOIN dbo.Poblaciones po ON d.CodigoMunicipio = po.CodigoMunicipio;
GO
/****** Object:  Table [dbo].[PeticionesLin]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeticionesLin](
	[IdLineaPeticion] [int] IDENTITY(1,1) NOT NULL,
	[IdPeticion] [int] NOT NULL,
	[IdTipoPrueba] [int] NULL,
	[Descripcion] [nvarchar](200) NULL,
	[EstadoLinea] [varchar](20) NULL,
	[Resultado] [nvarchar](max) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
	[IdPlazoEntrega] [int] NULL,
	[IdTiposPruebasConsumo] [int] NOT NULL,
	[IdTipoMuestra] [int] NOT NULL,
	[NumIntervinientes] [int] NOT NULL,
	[NumMuestras] [int] NOT NULL,
	[IdPrecioConfigurado] [int] NOT NULL,
	[EstadoResultado] [nvarchar](50) NULL,
	[FechaCompletado] [datetime] NULL,
	[NumValidacionesCompletadas] [int] NOT NULL,
	[IdSolicitud] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdLineaPeticion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposPruebasConsumo]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposPruebasConsumo](
	[IdTipoPruebaConsumo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[IDTipoPrueba] [int] NOT NULL,
	[Nombre] [nvarchar](100) NULL,
	[Activo] [bit] NULL,
	[RequiereValidacion] [bit] NOT NULL,
	[IdDudaParienteCercano] [int] NULL,
	[Transfusiones] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoPruebaConsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LineasFactura]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LineasFactura](
	[IdLineaFactura] [int] IDENTITY(1,1) NOT NULL,
	[IdFactura] [int] NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[Importe] [decimal](10, 2) NOT NULL,
	[Cantidad] [int] NULL,
	[IdTarifa] [int] NULL,
	[IdLineaPeticion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdLineaFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_FacturacionPorTipoPrueba]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_FacturacionPorTipoPrueba] AS
SELECT
    tpc.Nombre AS TipoPrueba,
    COUNT(lf.IdLineaFactura) AS NumeroPruebas,
    SUM(lf.Importe) AS FacturacionTotal
FROM dbo.LineasFactura lf
JOIN dbo.PeticionesLin pl ON lf.IdLineaPeticion = pl.IdLineaPeticion
JOIN dbo.TiposPruebasConsumo tpc ON pl.IdTiposPruebasConsumo = tpc.IdTipoPruebaConsumo
JOIN dbo.Facturas f ON lf.IdFactura = f.IdFactura
WHERE f.EstadoFactura <> 'Anulada'
GROUP BY tpc.Nombre;
GO
/****** Object:  Table [dbo].[Actividades]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actividades](
	[IdActividad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Actividades] PRIMARY KEY CLUSTERED 
(
	[IdActividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdjuntosEnvio]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdjuntosEnvio](
	[IdAdjunto] [int] IDENTITY(1,1) NOT NULL,
	[IdEnvio] [int] NOT NULL,
	[NombreArchivo] [nvarchar](100) NOT NULL,
	[ArchivoReferencia] [nvarchar](50) NOT NULL,
	[IdTipoPlantilla] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAdjunto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articulos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articulos](
	[IdArticulo] [int] IDENTITY(1,1) NOT NULL,
	[CodigoArticulo] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[IdFamilia] [int] NULL,
	[IdProveedor] [int] NULL,
	[IdFabricante] [int] NULL,
	[Imagen] [varbinary](max) NULL,
	[Parametros] [nvarchar](max) NULL,
	[ControlLote] [bit] NOT NULL,
	[ControlCantidadEnvase] [bit] NOT NULL,
	[Precio] [float] NOT NULL,
	[Descuento] [float] NULL,
	[Stock] [decimal](15, 4) NOT NULL,
	[StockMinimo] [decimal](15, 4) NULL,
	[StockMaximo] [decimal](15, 4) NULL,
	[Ubicacion] [nvarchar](100) NULL,
	[ReferenciaProveedor] [nvarchar](50) NULL,
	[IdEnvase] [int] NULL,
	[IdUnidad] [int] NULL,
	[Unidades] [decimal](15, 4) NULL,
	[CantidadEnvase] [decimal](15, 4) NULL,
	[AlicuotasEnvase] [int] NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CodigoArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditoriaAcciones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditoriaAcciones](
	[IdAccion] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[FechaAccion] [datetime] NULL,
	[Tabla] [nvarchar](100) NULL,
	[Accion] [nvarchar](50) NULL,
	[Detalles] [nvarchar](max) NULL,
	[IdDocumento] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Avisos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Avisos](
	[IdAviso] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](100) NOT NULL,
	[Contenido] [nvarchar](max) NOT NULL,
	[TipoAviso] [nvarchar](50) NULL,
	[Prioridad] [int] NULL,
	[Activo] [bit] NOT NULL,
	[FechaAlta] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAviso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bancos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bancos](
	[IdBanco] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Swift] [nvarchar](20) NULL,
	[CodigoEntidad] [nvarchar](10) NULL,
	[CodPais] [char](2) NOT NULL,
	[IdDireccion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdBanco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cargos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargos](
	[IdCargo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Imagen] [varbinary](max) NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatalogoDeterminaciones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatalogoDeterminaciones](
	[IdDeterminacionCatalogo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[TipoDato] [nvarchar](20) NOT NULL,
	[Unidad] [nvarchar](50) NULL,
	[ValorReferencia] [nvarchar](255) NULL,
	[Area] [nvarchar](50) NULL,
	[Activo] [bit] NULL,
	[IdTipoResultado] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDeterminacionCatalogo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatalogoDeterminacionesAndrologia]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatalogoDeterminacionesAndrologia](
	[IdDeterminacionCatalogo] [int] IDENTITY(1,1) NOT NULL,
	[NombreDeterminacion] [nvarchar](100) NOT NULL,
	[Unidad] [nvarchar](50) NULL,
	[ValorReferencia] [nvarchar](100) NULL,
	[Activo] [bit] NULL,
	[TipoDato] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDeterminacionCatalogo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NombreDeterminacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Centros]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Centros](
	[IdCentro] [int] IDENTITY(1,1) NOT NULL,
	[NombreCentro] [nvarchar](50) NOT NULL,
	[CIF] [nvarchar](20) NULL,
	[Contacto] [nvarchar](50) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Web] [nvarchar](100) NULL,
	[IdAvisoTecnico] [int] NULL,
	[IdAvisoAdmon] [int] NULL,
	[IdAvisoFacturacion] [int] NULL,
	[IdAvisoInternas] [int] NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasAdmon] [nvarchar](max) NULL,
	[NotasFacturacion] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Parametros] [nvarchar](max) NULL,
	[MembreteCentro] [bit] NOT NULL,
	[IdDireccion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCentro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CodigosPostales]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CodigosPostales](
	[IdCP] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPostal] [nvarchar](10) NOT NULL,
	[CodigoMunicipio] [char](6) NULL,
	[NombreMunicipio] [nvarchar](100) NULL,
	[CodigoProvincia] [char](2) NULL,
	[CodigoPais] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CodigoPostal] ASC,
	[CodigoMunicipio] ASC,
	[CodigoPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConfiguracionesCodigos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfiguracionesCodigos](
	[IdConfiguracion] [int] IDENTITY(1,1) NOT NULL,
	[TipoCodigo] [varchar](20) NOT NULL,
	[Prefijo] [nvarchar](10) NULL,
	[Formato] [nvarchar](50) NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdConfiguracion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConfiguracionesPrecio]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfiguracionesPrecio](
	[IdConfiguracion] [int] IDENTITY(1,1) NOT NULL,
	[IdTiposPruebasConsumo] [int] NOT NULL,
	[EsLegal] [bit] NOT NULL,
	[EsColaborador] [bit] NOT NULL,
	[PrecioBase] [decimal](10, 2) NOT NULL,
	[IdRegla] [int] NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdConfiguracion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConfigValidaciones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigValidaciones](
	[IdConfigValidacion] [int] IDENTITY(1,1) NOT NULL,
	[TipoResultado] [nvarchar](50) NOT NULL,
	[NumValidacionesRequeridas] [int] NOT NULL,
	[RolRequerido] [int] NULL,
 CONSTRAINT [PK_ConfigValidaciones] PRIMARY KEY CLUSTERED 
(
	[IdConfigValidacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Consentimientos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Consentimientos](
	[IdConsentimiento] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoPruebaConsumo] [int] NOT NULL,
	[IdSolicitud] [int] NULL,
	[ArchivoReferencia] [nvarchar](50) NOT NULL,
	[EstadoConsentimiento] [nvarchar](50) NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[FechaActualizado] [datetime2](7) NULL,
	[FechaFirma] [datetime2](7) NOT NULL,
	[IdInterviniente] [int] NOT NULL,
	[IdPlantilla] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdConsentimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contactos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contactos](
	[IdContacto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Telefono] [nvarchar](20) NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Cargo] [nvarchar](50) NULL,
	[Notas] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdContacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactosEntidad]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactosEntidad](
	[IdContactoEntidad] [int] IDENTITY(1,1) NOT NULL,
	[IdContacto] [int] NOT NULL,
	[TipoEntidad] [nvarchar](50) NOT NULL,
	[IdEntidad] [int] NOT NULL,
	[Rol] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdContactoEntidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contratos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contratos](
	[IdContrato] [int] IDENTITY(1,1) NOT NULL,
	[TipoEntidad] [nvarchar](50) NOT NULL,
	[IdEntidad] [int] NOT NULL,
	[TipoContrato] [nvarchar](100) NULL,
	[Descripcion] [nvarchar](255) NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NULL,
	[Estado] [nvarchar](50) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[ArchivoContrato] [varbinary](max) NULL,
	[NombreArchivo] [nvarchar](255) NULL,
	[FechaAlta] [date] NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdContrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Descuentos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Descuentos](
	[IdDescuento] [int] IDENTITY(1,1) NOT NULL,
	[IdTarifa] [int] NOT NULL,
	[IdTipoClienteConsumo] [int] NOT NULL,
	[IdTipoPruebaConsumo] [int] NOT NULL,
	[Descuento] [float] NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDescuento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Descuento_TarifaClientePrueba] UNIQUE NONCLUSTERED 
(
	[IdTarifa] ASC,
	[IdTipoClienteConsumo] ASC,
	[IdTipoPruebaConsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detectives]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detectives](
	[IdDetective] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[CIF] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[IdDireccion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetective] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeterminacionesAndrologia]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeterminacionesAndrologia](
	[IdDeterminacion] [int] IDENTITY(1,1) NOT NULL,
	[IdDeterminacionCatalogo] [int] NOT NULL,
	[Resultado] [nvarchar](100) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[IdLineaPeticion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDeterminacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DudaParienteCercano]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DudaParienteCercano](
	[IdDudaParienteCercano] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDudaParienteCercano] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntidadMetadata]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntidadMetadata](
	[IdMetadata] [int] IDENTITY(1,1) NOT NULL,
	[IdEntidad] [int] NOT NULL,
	[TipoEntidad] [nvarchar](50) NOT NULL,
	[Clave] [nvarchar](50) NOT NULL,
	[Valor] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMetadata] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Envases]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Envases](
	[IdEnvase] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Descripcion2] [nvarchar](100) NULL,
	[TipoEnvase] [smallint] NOT NULL,
	[Bloquear] [smallint] NOT NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Parametros] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEnvase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipos](
	[IdEquipo] [int] IDENTITY(1,1) NOT NULL,
	[IdEquipoPadre] [int] NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Descripcion2] [nvarchar](255) NULL,
	[IdEspecialidad] [int] NULL,
	[IdProveedor] [int] NULL,
	[IdFabricante] [int] NULL,
	[Marca] [nvarchar](100) NULL,
	[Modelo] [nvarchar](100) NULL,
	[NumeroSerie] [nvarchar](100) NULL,
	[Certificado] [nvarchar](255) NULL,
	[IdPersonal] [int] NULL,
	[FechaCompra] [date] NULL,
	[FechaPuestaMarcha] [date] NULL,
	[FechaBaja] [date] NULL,
	[Info1] [nvarchar](255) NULL,
	[Info2] [nvarchar](255) NULL,
	[Info3] [nvarchar](255) NULL,
	[Info4] [nvarchar](255) NULL,
	[Bloquear] [bit] NULL,
	[Imagen] [varbinary](max) NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Capacidad] [decimal](10, 2) NULL,
	[Parametros] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Especialidades]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialidades](
	[IdEspecialidad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[Descripcion2] [nvarchar](255) NULL,
	[OrdenEspecialidad] [int] NULL,
	[SaltoDictamen] [varchar](2) NULL,
	[Imagen] [varbinary](max) NULL,
	[Bloquear] [bit] NULL,
	[Observaciones] [nvarchar](max) NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Parametros] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fabricantes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fabricantes](
	[IdFabricante] [int] IDENTITY(1,1) NOT NULL,
	[NombreFiscal] [nvarchar](100) NOT NULL,
	[NombreComercial] [nvarchar](100) NOT NULL,
	[CIF] [nvarchar](20) NULL,
	[Contacto] [nvarchar](100) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Telefono2] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Web] [nvarchar](100) NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasAdmon] [nvarchar](max) NULL,
	[NotasFacturacion] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Imagen] [varbinary](max) NULL,
	[Parametros] [nvarchar](max) NULL,
	[Bloquear] [bit] NOT NULL,
	[EstadoFactura] [bit] NOT NULL,
	[EstadoCobro] [bit] NOT NULL,
	[EstadoContable] [bit] NOT NULL,
	[IdDireccion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFabricante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Familias]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Familias](
	[IdFamilia] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Imagen] [varbinary](max) NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Nota1] [nvarchar](100) NULL,
	[Nota2] [nvarchar](100) NULL,
	[Parametros] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFamilia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormasEntrega]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormasEntrega](
	[IdFormaEntrega] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFormaEntrega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormasPago]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormasPago](
	[IdFormaPago] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[RequiereCuentaBanco] [bit] NOT NULL,
	[Activa] [bit] NOT NULL,
	[FechaAlta] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFormaPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorialImpresion]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialImpresion](
	[IdHistorial] [int] IDENTITY(1,1) NOT NULL,
	[IdImpresora] [int] NULL,
	[NombreDocumento] [nvarchar](255) NULL,
	[FechaImpresion] [datetime] NULL,
	[IdUsuario] [int] NULL,
	[Estado] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdHistorial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Idiomas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idiomas](
	[IdIdioma] [char](2) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
	[FechaAlta] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIdioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impresoras]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impresoras](
	[IdImpresora] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Modelo] [nvarchar](100) NULL,
	[Ubicacion] [nvarchar](255) NULL,
	[Tipo] [nvarchar](50) NULL,
	[DireccionRed] [nvarchar](255) NULL,
	[Activa] [bit] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdImpresora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncrementosIntervinientes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncrementosIntervinientes](
	[NumIntervinientes] [int] NOT NULL,
	[IncrementoFijo] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NumIntervinientes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IndiceParentesco_Resultados]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndiceParentesco_Resultados](
	[IdIndiceParentesco] [int] NOT NULL,
	[IdResultadoParentesco] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIndiceParentesco] ASC,
	[IdResultadoParentesco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InformesGenerados]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InformesGenerados](
	[IdInforme] [int] IDENTITY(1,1) NOT NULL,
	[IdSolicitud] [int] NOT NULL,
	[IdPlantilla] [int] NOT NULL,
	[IdDocumento] [int] NOT NULL,
	[FechaGeneracion] [datetime] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdInforme] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IVA]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IVA](
	[IdIVA] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Porcentaje] [decimal](5, 2) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Activo] [bit] NOT NULL,
	[FechaAlta] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdIVA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LaboratorioImportes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LaboratorioImportes](
	[IdImporte] [int] IDENTITY(1,1) NOT NULL,
	[IdLaboratorioColaborador] [int] NOT NULL,
	[Periodo] [date] NOT NULL,
	[Importe] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdImporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MarcadorComparisons]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarcadorComparisons](
	[IdComparison] [int] IDENTITY(1,1) NOT NULL,
	[IdResultadoParentesco1] [int] NOT NULL,
	[IdResultadoParentesco2] [int] NOT NULL,
	[Coincidencia] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdComparison] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MetodosAmplificacion]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetodosAmplificacion](
	[IdMetodo] [int] IDENTITY(1,1) NOT NULL,
	[NombreMetodo] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
	[FechaCreacion] [datetime] NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMetodo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_MetodoAmplificacion_Nombre] UNIQUE NONCLUSTERED 
(
	[NombreMetodo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MetodosExtraccion]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetodosExtraccion](
	[IdMetodo] [int] IDENTITY(1,1) NOT NULL,
	[NombreMetodo] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
	[FechaCreacion] [datetime] NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMetodo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientosMuestras]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientosMuestras](
	[IdMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[IdMuestra] [int] NOT NULL,
	[FechaMovimiento] [datetime] NOT NULL,
	[Ubicacion] [nvarchar](100) NULL,
	[IdUsuario] [int] NULL,
	[Observaciones] [nvarchar](500) NULL,
	[IdTipoMovimiento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Muestras]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Muestras](
	[IdMuestra] [int] IDENTITY(1,1) NOT NULL,
	[CodigoMuestra] [nvarchar](50) NOT NULL,
	[FechaExtraccion] [date] NULL,
	[Observaciones] [nvarchar](max) NULL,
	[IdSolicitante] [int] NULL,
	[IdInterviniente] [int] NULL,
	[TipoMuestra] [int] NULL,
	[IdPersonaTomaMuestras] [int] NULL,
	[IdMetodoExtraccion] [int] NULL,
	[IdMetodoAmplificacion] [int] NULL,
	[FechaAmplificacion] [date] NULL,
	[IdTecnicoAmplificacion] [int] NULL,
	[Posicion] [char](4) NULL,
	[Valida] [bit] NOT NULL,
	[FechaRecepcion] [date] NOT NULL,
	[IdCentroToma] [int] NOT NULL,
	[IdTecnicoExtraccion] [int] NOT NULL,
	[IdPeticion] [int] NULL,
	[IdSolicitud] [int] NOT NULL,
	[Intentos] [int] NOT NULL,
	[BarcodeQrCode] [nvarchar](100) NULL,
	[QrCodeContent] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMuestra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[QrCodeContent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[BarcodeQrCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notas](
	[IdNota] [int] IDENTITY(1,1) NOT NULL,
	[IdEntidad] [int] NOT NULL,
	[TipoEntidad] [nvarchar](50) NOT NULL,
	[TipoNota] [nvarchar](50) NOT NULL,
	[Contenido] [nvarchar](4000) NULL,
	[FechaCreacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PagosPaciente]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PagosPaciente](
	[IdPagoPaciente] [int] IDENTITY(1,1) NOT NULL,
	[IdSolicitante] [int] NOT NULL,
	[IdFormaPago] [int] NULL,
	[Importe] [decimal](10, 2) NOT NULL,
	[FechaPago] [date] NOT NULL,
	[Pagado] [bit] NOT NULL,
	[Observaciones] [nvarchar](max) NULL,
	[IdLineaPeticion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPagoPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permisos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permisos](
	[IdPermiso] [int] IDENTITY(1,1) NOT NULL,
	[NombrePermiso] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NombrePermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermisosDocumento]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermisosDocumento](
	[IdPermisoDocumento] [int] IDENTITY(1,1) NOT NULL,
	[IdDocumento] [int] NOT NULL,
	[IdUsuario] [int] NULL,
	[IdRol] [int] NULL,
	[Permiso] [nvarchar](50) NOT NULL,
	[FechaOtorgado] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPermisoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonasTomaMuestras]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonasTomaMuestras](
	[IdPersonaTomaMuestras] [int] IDENTITY(1,1) NOT NULL,
	[IdLaboratorioColaborador] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Cargo] [nvarchar](100) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[NumeroDocumento] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPersonaTomaMuestras] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plantillas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plantillas](
	[IdPlantilla] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoPruebaConsumo] [int] NULL,
	[IdTipoPlantilla] [int] NOT NULL,
	[IdIdioma] [char](2) NOT NULL,
	[Version] [nvarchar](10) NOT NULL,
	[ArchivoReferencia] [nvarchar](50) NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[Activa] [bit] NOT NULL,
 CONSTRAINT [PK_Plantillas] PRIMARY KEY CLUSTERED 
(
	[IdPlantilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_Plantillas_Active] UNIQUE NONCLUSTERED 
(
	[IdTipoPruebaConsumo] ASC,
	[IdTipoPlantilla] ASC,
	[IdIdioma] ASC,
	[Activa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantillasInforme]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantillasInforme](
	[IdPlantilla] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[TipoInforme] [nvarchar](50) NOT NULL,
	[IdIdioma] [char](2) NOT NULL,
	[Contenido] [nvarchar](max) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Activa] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPlantilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantillasNotificacion]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantillasNotificacion](
	[IdPlantilla] [int] IDENTITY(1,1) NOT NULL,
	[TipoNotificacion] [nvarchar](50) NOT NULL,
	[Canal] [nvarchar](10) NOT NULL,
	[IdIdioma] [char](2) NOT NULL,
	[Asunto] [nvarchar](255) NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Activa] [bit] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPlantilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlazosEntrega]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlazosEntrega](
	[IdPlazoEntrega] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Dias] [int] NOT NULL,
	[IncrementoFijo] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPlazoEntrega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrecioCache]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrecioCache](
	[IdCache] [int] IDENTITY(1,1) NOT NULL,
	[IdTiposPruebasConsumo] [int] NOT NULL,
	[EsLegal] [bit] NOT NULL,
	[EsColaborador] [bit] NOT NULL,
	[PrecioBase] [decimal](10, 2) NOT NULL,
	[IdRegla] [int] NOT NULL,
	[FechaActualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCache] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[CodigoProducto] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NOT NULL,
	[IdFamiliaProducto] [int] NULL,
	[IdMuestra] [int] NULL,
	[Bloquear] [char](1) NULL,
	[Imagen] [varbinary](max) NULL,
	[Parametros] [nvarchar](max) NULL,
	[Precio] [float] NOT NULL,
	[Descuento] [float] NOT NULL,
	[Stock] [decimal](15, 4) NOT NULL,
	[StockMinimo] [decimal](15, 4) NOT NULL,
	[StockMaximo] [decimal](15, 4) NOT NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[NombreFiscal] [nvarchar](255) NULL,
	[NombreComercial] [nvarchar](255) NULL,
	[CIF] [nvarchar](50) NULL,
	[Telefono] [nvarchar](50) NULL,
	[Telefono2] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[Email] [nvarchar](255) NULL,
	[Web] [nvarchar](255) NULL,
	[Contacto] [nvarchar](255) NULL,
	[TipoProveedor] [nvarchar](50) NULL,
	[Bloquear] [nvarchar](10) NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasAdmon] [nvarchar](max) NULL,
	[NotasFacturacion] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Imagen] [varbinary](max) NULL,
	[Latitud] [float] NULL,
	[Longitud] [float] NULL,
	[Parametros] [nvarchar](max) NULL,
	[IdActividad] [int] NULL,
	[IdFormaPago] [int] NULL,
	[IdProveedor] [int] IDENTITY(1,1) NOT NULL,
	[IdDireccion] [int] NULL,
 CONSTRAINT [PK_Proveedores_IdProveedor] PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proyectos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proyectos](
	[IdProyecto] [int] IDENTITY(1,1) NOT NULL,
	[CodigoProyecto] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[CodigoPeticion] [nvarchar](50) NULL,
	[CodigoProyectoRelacionado] [nvarchar](50) NULL,
	[ColorPlanificaciones] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CodigoProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReglasIncrementoPrecio]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReglasIncrementoPrecio](
	[IdRegla] [int] NOT NULL,
	[PorcentajeIntervinienteLegal] [decimal](5, 2) NOT NULL,
	[PorcentajeMuestraLegal] [decimal](5, 2) NOT NULL,
	[PorcentajeColaborador] [decimal](5, 2) NOT NULL,
	[Descripcion] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRegla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Remesas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Remesas](
	[IdRemesa] [int] IDENTITY(1,1) NOT NULL,
	[CodigoRemesa] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Tipo] [nvarchar](50) NULL,
	[IdBanco] [int] NULL,
	[CuentaBanco] [nvarchar](100) NULL,
	[SwiftBanco] [nvarchar](100) NULL,
	[NivelSEPA] [nvarchar](255) NULL,
	[NombreFichero] [nvarchar](255) NULL,
	[FechaFichero] [datetime] NULL,
	[ImporteTotal] [decimal](18, 2) NULL,
	[FechaRemesa] [date] NULL,
	[Parametros] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRemesa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CodigoRemesa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResultadosAndrologia]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultadosAndrologia](
	[IdResultadoAndrologia] [int] IDENTITY(1,1) NOT NULL,
	[IdDeterminacion] [int] NOT NULL,
	[Resultado] [nvarchar](255) NOT NULL,
	[Unidad] [nvarchar](50) NULL,
	[ValorReferencia] [nvarchar](255) NULL,
	[FechaRegistro] [date] NOT NULL,
	[IdPersonalRegistro] [int] NULL,
	[IdLineaPeticion] [int] NULL,
	[ValidadoPor] [int] NULL,
	[EstadoValidacion] [nvarchar](50) NULL,
	[FechaValidacion] [datetime] NULL,
	[IdDocumento] [int] NULL,
	[Notificado] [bit] NOT NULL,
	[EstadoValidacionFinal] [nvarchar](50) NULL,
	[FechaResultado] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdResultadoAndrologia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResultadosCitogenetica]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultadosCitogenetica](
	[IdResultadoCitogenetica] [int] IDENTITY(1,1) NOT NULL,
	[Cariotipo] [nvarchar](100) NULL,
	[Anomalias] [nvarchar](max) NULL,
	[Comentarios] [nvarchar](max) NULL,
	[FechaRegistro] [date] NOT NULL,
	[IdPersonalRegistro] [int] NULL,
	[IdLineaPeticion] [int] NULL,
	[ValidadoPor] [int] NULL,
	[EstadoValidacion] [nvarchar](50) NULL,
	[FechaValidacion] [datetime] NULL,
	[IdDocumento] [int] NULL,
	[Notificado] [bit] NOT NULL,
	[EstadoValidacionFinal] [nvarchar](50) NULL,
	[FechaResultado] [datetime] NULL,
	[Resultado] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdResultadoCitogenetica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResultadosGenetica]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultadosGenetica](
	[IdResultadoGenetica] [int] IDENTITY(1,1) NOT NULL,
	[Gen] [nvarchar](100) NULL,
	[Mutacion] [nvarchar](100) NULL,
	[Resultado] [nvarchar](255) NULL,
	[FechaRegistro] [date] NOT NULL,
	[IdPersonalRegistro] [int] NULL,
	[IdLineaPeticion] [int] NULL,
	[ValidadoPor] [int] NULL,
	[EstadoValidacion] [nvarchar](50) NULL,
	[FechaValidacion] [datetime] NULL,
	[IdDocumento] [int] NULL,
	[Notificado] [bit] NOT NULL,
	[EstadoValidacionFinal] [nvarchar](50) NULL,
	[FechaResultado] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdResultadoGenetica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResultadosPrueba]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultadosPrueba](
	[IdResultado] [int] IDENTITY(1,1) NOT NULL,
	[IdDeterminacionCatalogo] [int] NOT NULL,
	[Resultado] [nvarchar](255) NULL,
	[Unidad] [nvarchar](50) NULL,
	[ValorReferencia] [nvarchar](255) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[FechaRegistro] [datetime] NULL,
	[IdLineaPeticion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdResultado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolesPermisos]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolesPermisos](
	[IdRol] [int] NOT NULL,
	[IdPermiso] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC,
	[IdPermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tarifas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tarifas](
	[IdTarifa] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Coeficiente] [decimal](10, 2) NULL,
	[Observaciones] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTarifa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TarifasBase]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TarifasBase](
	[IdTarifa] [int] IDENTITY(1,1) NOT NULL,
	[PrecioPorInterviniente] [decimal](10, 2) NOT NULL,
	[PrecioPorMuestra] [decimal](10, 2) NOT NULL,
	[Descripcion] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTarifa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoInterviniente]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoInterviniente](
	[Codigo] [char](4) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposClientesConsumo]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposClientesConsumo](
	[IdTipoClienteConsumo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoClienteConsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposEntidad]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposEntidad](
	[IdEntidadTipo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TiposEntidad] PRIMARY KEY CLUSTERED 
(
	[IdEntidadTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposMovimiento]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposMovimiento](
	[IdTipoMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposMuestra]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposMuestra](
	[IdTipoMuestra] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[CodigoCorto] [nvarchar](20) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[CosteFijo] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoMuestra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposPlantillas]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposPlantillas](
	[IdTipoPlantilla] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[RequiereFirma] [bit] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_TiposPlantillas] PRIMARY KEY CLUSTERED 
(
	[IdTipoPlantilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposResultado]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposResultado](
	[IdTipoResultado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Codigo] [nvarchar](20) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[EsEstructurado] [bit] NOT NULL,
	[FormatoEsperado] [nvarchar](100) NULL,
	[ValidacionRegEx] [nvarchar](255) NULL,
	[UnidadSugerida] [nvarchar](50) NULL,
	[EsResultadoUnico] [bit] NOT NULL,
	[RequiereArchivo] [bit] NOT NULL,
	[RequiereValidacion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoResultado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TomasMuestra]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TomasMuestra](
	[IdTomaMuestra] [int] IDENTITY(1,1) NOT NULL,
	[IdMuestra] [int] NOT NULL,
	[IdInterviniente] [int] NULL,
	[IdPersonalToma] [int] NULL,
	[IdLugarToma] [int] NULL,
	[FechaToma] [datetime] NOT NULL,
	[MetodoToma] [nvarchar](100) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[IdPlantilla] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTomaMuestra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unidades]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unidades](
	[IdUnidad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[TipoUnidad] [nvarchar](50) NULL,
	[Bloquear] [nvarchar](50) NULL,
	[NotasTecnico] [nvarchar](max) NULL,
	[NotasInternas] [nvarchar](max) NULL,
	[Parametros] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUnidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuariosPortal]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuariosPortal](
	[IdUsuarioPortal] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[HashPassword] [nvarchar](255) NOT NULL,
	[IdEntidad] [int] NOT NULL,
	[IdTipoEntidad] [int] NOT NULL,
	[IdRol] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuarioPortal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[NombreUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_UsuariosPortal_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_UsuariosPortal_UserName] UNIQUE NONCLUSTERED 
(
	[NombreUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Direcciones_CodigoPais]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_Direcciones_CodigoPais] ON [dbo].[Direcciones]
(
	[CodigoPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Documentos_IdTipoDocumento]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_Documentos_IdTipoDocumento] ON [dbo].[Documentos]
(
	[IdTipoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_IndiceParentesco_IdSolicitud]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_IndiceParentesco_IdSolicitud] ON [dbo].[IndiceParentesco]
(
	[IdSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_IndiceParentesco_Perfiles]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_IndiceParentesco_Perfiles] ON [dbo].[IndiceParentesco]
(
	[IdPerfilGenetico1] ASC,
	[IdPerfilGenetico2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_IndiceParentesco_TipoRelacion]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_IndiceParentesco_TipoRelacion] ON [dbo].[IndiceParentesco]
(
	[TipoRelacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_LaboratorioImportes_IdLaboratorioColaborador_Periodo]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_LaboratorioImportes_IdLaboratorioColaborador_Periodo] ON [dbo].[LaboratorioImportes]
(
	[IdLaboratorioColaborador] ASC,
	[Periodo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Muestras_BarcodeQrCode]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_Muestras_BarcodeQrCode] ON [dbo].[Muestras]
(
	[BarcodeQrCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Notas_IdEntidad_TipoEntidad]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_Notas_IdEntidad_TipoEntidad] ON [dbo].[Notas]
(
	[IdEntidad] ASC,
	[TipoEntidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PerfilesGeneticos_IdInterviniente]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_PerfilesGeneticos_IdInterviniente] ON [dbo].[PerfilesGeneticos]
(
	[IdInterviniente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Plantillas_IdTipoPlantilla]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_Plantillas_IdTipoPlantilla] ON [dbo].[Plantillas]
(
	[IdTipoPlantilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PlantillasInforme_TipoIdioma]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_PlantillasInforme_TipoIdioma] ON [dbo].[PlantillasInforme]
(
	[TipoInforme] ASC,
	[IdIdioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ResultadosParentesco_IdInterviniente]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_ResultadosParentesco_IdInterviniente] ON [dbo].[ResultadosParentesco]
(
	[IdInterviniente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ResultadosParentesco_IdLineaPeticion]    Script Date: 04/07/2025 19:48:55 ******/
CREATE NONCLUSTERED INDEX [IX_ResultadosParentesco_IdLineaPeticion] ON [dbo].[ResultadosParentesco]
(
	[IdLineaPeticion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TiposPruebasConsumo_IdTipoPruebaConsumo]    Script Date: 04/07/2025 19:48:55 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TiposPruebasConsumo_IdTipoPruebaConsumo] ON [dbo].[TiposPruebasConsumo]
(
	[IdTipoPruebaConsumo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Acreditaciones] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Acreditaciones] ADD  DEFAULT ((0)) FOR [EsConfidencial]
GO
ALTER TABLE [dbo].[Articulos] ADD  DEFAULT ((0)) FOR [ControlLote]
GO
ALTER TABLE [dbo].[Articulos] ADD  DEFAULT ((0)) FOR [ControlCantidadEnvase]
GO
ALTER TABLE [dbo].[Articulos] ADD  DEFAULT ((0)) FOR [Descuento]
GO
ALTER TABLE [dbo].[Articulos] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[Articulos] ADD  DEFAULT ((0)) FOR [StockMinimo]
GO
ALTER TABLE [dbo].[Articulos] ADD  DEFAULT ((0)) FOR [StockMaximo]
GO
ALTER TABLE [dbo].[Articulos] ADD  DEFAULT ((1)) FOR [Unidades]
GO
ALTER TABLE [dbo].[AuditoriasCalidad] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Campanias] ADD  DEFAULT ((1)) FOR [Activa]
GO
ALTER TABLE [dbo].[Centros] ADD  DEFAULT ((0)) FOR [MembreteCentro]
GO
ALTER TABLE [dbo].[CodigosPostales] ADD  DEFAULT ('ES') FOR [CodigoPais]
GO
ALTER TABLE [dbo].[ConfiguracionesCodigos] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[ConfiguracionesPrecio] ADD  DEFAULT ((1)) FOR [IdRegla]
GO
ALTER TABLE [dbo].[Consentimientos] ADD  DEFAULT (newid()) FOR [ArchivoReferencia]
GO
ALTER TABLE [dbo].[Consentimientos] ADD  DEFAULT ('Pendiente') FOR [EstadoConsentimiento]
GO
ALTER TABLE [dbo].[Consentimientos] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Consentimientos] ADD  DEFAULT (getdate()) FOR [FechaFirma]
GO
ALTER TABLE [dbo].[Contratos] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Documentos] ADD  DEFAULT (getdate()) FOR [FechaSubida]
GO
ALTER TABLE [dbo].[Documentos] ADD  DEFAULT ((0)) FOR [EsConfidencial]
GO
ALTER TABLE [dbo].[Empresas] ADD  DEFAULT ((0)) FOR [Bloquear]
GO
ALTER TABLE [dbo].[Empresas] ADD  DEFAULT ((0)) FOR [CrearFichero]
GO
ALTER TABLE [dbo].[Empresas] ADD  DEFAULT ((0)) FOR [ExportarWeb]
GO
ALTER TABLE [dbo].[Empresas] ADD  DEFAULT ((1)) FOR [EnviarEmail]
GO
ALTER TABLE [dbo].[Empresas] ADD  DEFAULT ((0)) FOR [EnviarEmailPet]
GO
ALTER TABLE [dbo].[Empresas] ADD  DEFAULT ((0)) FOR [EnviarEmailFac]
GO
ALTER TABLE [dbo].[Empresas] ADD  DEFAULT ((0)) FOR [EnviarEmailNotif]
GO
ALTER TABLE [dbo].[Envios] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[Estados] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Estados] ADD  DEFAULT ((1)) FOR [DisparaNotificacion]
GO
ALTER TABLE [dbo].[Estados] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Fabricantes] ADD  DEFAULT ((0)) FOR [Bloquear]
GO
ALTER TABLE [dbo].[Fabricantes] ADD  DEFAULT ((0)) FOR [EstadoFactura]
GO
ALTER TABLE [dbo].[Fabricantes] ADD  DEFAULT ((0)) FOR [EstadoCobro]
GO
ALTER TABLE [dbo].[Fabricantes] ADD  DEFAULT ((0)) FOR [EstadoContable]
GO
ALTER TABLE [dbo].[HistorialImpresion] ADD  DEFAULT (getdate()) FOR [FechaImpresion]
GO
ALTER TABLE [dbo].[Impresoras] ADD  DEFAULT ((1)) FOR [Activa]
GO
ALTER TABLE [dbo].[Impresoras] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[IndiceParentesco] ADD  DEFAULT (getdate()) FOR [FechaAnalisis]
GO
ALTER TABLE [dbo].[IndiceParentesco] ADD  DEFAULT ('Activo') FOR [Estado]
GO
ALTER TABLE [dbo].[InformesGenerados] ADD  DEFAULT (getdate()) FOR [FechaGeneracion]
GO
ALTER TABLE [dbo].[InformesGenerados] ADD  DEFAULT ('Generado') FOR [Estado]
GO
ALTER TABLE [dbo].[Intervinientes] ADD  CONSTRAINT [DF_Intervinientes_IdTipoInterviniente]  DEFAULT ('PP') FOR [IdTipoInterviniente]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] ADD  DEFAULT (CONVERT([date],getdate())) FOR [FechaAlta]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] ADD  DEFAULT ((0)) FOR [Bloquear]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] ADD  DEFAULT ((1)) FOR [EstadoContrato]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] ADD  CONSTRAINT [DF_LaboratoriosColaboradores_IdIdiomaPreferido]  DEFAULT ('ES') FOR [IdIdiomaPreferido]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] ADD  DEFAULT ((0)) FOR [PrefiereSMS]
GO
ALTER TABLE [dbo].[LineasFactura] ADD  DEFAULT ((1)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[MarcadoresGeneticos] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[MarcadoresGeneticos] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Medicos] ADD  DEFAULT ((0)) FOR [Bloquear]
GO
ALTER TABLE [dbo].[Medicos] ADD  DEFAULT ((1)) FOR [EnviarEmail]
GO
ALTER TABLE [dbo].[Medicos] ADD  DEFAULT ((0)) FOR [EnviarEmailPet]
GO
ALTER TABLE [dbo].[Medicos] ADD  DEFAULT ((0)) FOR [EnviarEmailNotif]
GO
ALTER TABLE [dbo].[MetodosAmplificacion] ADD  CONSTRAINT [DF_MetodoAmplificacion_FechaCreacion]  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[MetodosAmplificacion] ADD  CONSTRAINT [DF_MetodoAmplificacion_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[MetodosExtraccion] ADD  CONSTRAINT [DF_MetodosExtraccion_FechaCreacion]  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[MetodosExtraccion] ADD  CONSTRAINT [DF_MetodosExtraccion_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[MovimientosMuestras] ADD  DEFAULT (getdate()) FOR [FechaMovimiento]
GO
ALTER TABLE [dbo].[Muestras] ADD  DEFAULT ((1)) FOR [Valida]
GO
ALTER TABLE [dbo].[Muestras] ADD  DEFAULT (getdate()) FOR [FechaRecepcion]
GO
ALTER TABLE [dbo].[Muestras] ADD  DEFAULT ((1)) FOR [IdCentroToma]
GO
ALTER TABLE [dbo].[Muestras] ADD  DEFAULT ((0)) FOR [IdSolicitud]
GO
ALTER TABLE [dbo].[Muestras] ADD  DEFAULT ((1)) FOR [Intentos]
GO
ALTER TABLE [dbo].[Notas] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[NotificacionesSMS] ADD  DEFAULT (getdate()) FOR [FechaEnvio]
GO
ALTER TABLE [dbo].[PagosPaciente] ADD  DEFAULT ((0)) FOR [Pagado]
GO
ALTER TABLE [dbo].[PerfilesGeneticos] ADD  DEFAULT ((1)) FOR [Valido]
GO
ALTER TABLE [dbo].[PermisosDocumento] ADD  DEFAULT (getdate()) FOR [FechaOtorgado]
GO
ALTER TABLE [dbo].[Personal] ADD  DEFAULT ((0)) FOR [Bloquear]
GO
ALTER TABLE [dbo].[Peticiones] ADD  DEFAULT ('pendiente') FOR [EstadoPeticion]
GO
ALTER TABLE [dbo].[Peticiones] ADD  DEFAULT (getdate()) FOR [FechaPeticion]
GO
ALTER TABLE [dbo].[PeticionesLin] ADD  DEFAULT ('pendiente') FOR [EstadoLinea]
GO
ALTER TABLE [dbo].[PeticionesLin] ADD  DEFAULT ((0)) FOR [PrecioUnitario]
GO
ALTER TABLE [dbo].[PeticionesLin] ADD  DEFAULT ('En Proceso') FOR [EstadoResultado]
GO
ALTER TABLE [dbo].[PeticionesLin] ADD  DEFAULT ((0)) FOR [NumValidacionesCompletadas]
GO
ALTER TABLE [dbo].[Plantillas] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Plantillas] ADD  DEFAULT ((1)) FOR [Activa]
GO
ALTER TABLE [dbo].[PlantillasInforme] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[PlantillasInforme] ADD  DEFAULT ((1)) FOR [Activa]
GO
ALTER TABLE [dbo].[PlantillasNotificacion] ADD  DEFAULT ((1)) FOR [Activa]
GO
ALTER TABLE [dbo].[PlantillasNotificacion] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[PlazosEntrega] ADD  DEFAULT ((0)) FOR [IncrementoFijo]
GO
ALTER TABLE [dbo].[PrecioCache] ADD  DEFAULT (getdate()) FOR [FechaActualizacion]
GO
ALTER TABLE [dbo].[Recibos] ADD  DEFAULT ((0)) FOR [Pagado]
GO
ALTER TABLE [dbo].[ReferenciasPaciente] ADD  DEFAULT ((1)) FOR [IdTipoReferencia]
GO
ALTER TABLE [dbo].[ReferenciasPaciente] ADD  DEFAULT (CONVERT([date],getdate())) FOR [FechaReferencia]
GO
ALTER TABLE [dbo].[ReglasIncrementoPrecio] ADD  DEFAULT ((0)) FOR [PorcentajeIntervinienteLegal]
GO
ALTER TABLE [dbo].[ReglasIncrementoPrecio] ADD  DEFAULT ((0)) FOR [PorcentajeMuestraLegal]
GO
ALTER TABLE [dbo].[ReglasIncrementoPrecio] ADD  DEFAULT ((0)) FOR [PorcentajeColaborador]
GO
ALTER TABLE [dbo].[ResultadosAndrologia] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[ResultadosAndrologia] ADD  DEFAULT ('Pendiente') FOR [EstadoValidacion]
GO
ALTER TABLE [dbo].[ResultadosAndrologia] ADD  DEFAULT ((0)) FOR [Notificado]
GO
ALTER TABLE [dbo].[ResultadosAndrologia] ADD  DEFAULT ('Pendiente') FOR [EstadoValidacionFinal]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] ADD  DEFAULT ('Pendiente') FOR [EstadoValidacion]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] ADD  DEFAULT ((0)) FOR [Notificado]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] ADD  DEFAULT ('Pendiente') FOR [EstadoValidacionFinal]
GO
ALTER TABLE [dbo].[ResultadosGenetica] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[ResultadosGenetica] ADD  DEFAULT ('Pendiente') FOR [EstadoValidacion]
GO
ALTER TABLE [dbo].[ResultadosGenetica] ADD  DEFAULT ((0)) FOR [Notificado]
GO
ALTER TABLE [dbo].[ResultadosGenetica] ADD  DEFAULT ('Pendiente') FOR [EstadoValidacionFinal]
GO
ALTER TABLE [dbo].[ResultadosParentesco] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[ResultadosParentesco] ADD  DEFAULT ('Pendiente') FOR [EstadoValidacion]
GO
ALTER TABLE [dbo].[ResultadosParentesco] ADD  DEFAULT ((0)) FOR [Notificado]
GO
ALTER TABLE [dbo].[ResultadosParentesco] ADD  DEFAULT ('Pendiente') FOR [EstadoValidacionFinal]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_IdTipo]  DEFAULT ((1)) FOR [IdTipoReferencia]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_Fecha]  DEFAULT (CONVERT([date],getdate())) FOR [FechaAlta]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_Autor]  DEFAULT ((0)) FOR [AutorizaEnvioResultados]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_Bloqueo]  DEFAULT ((0)) FOR [Bloquear]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_Nolla]  DEFAULT ((1)) FOR [Nollamar]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_Envio1]  DEFAULT ((1)) FOR [EnviarEmail]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_Envio2]  DEFAULT ((0)) FOR [EnviarEmailPet]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_Envio3]  DEFAULT ((0)) FOR [EnviarEmailFac]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_Envio4]  DEFAULT ((0)) FOR [EnviarEmailNotif]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  CONSTRAINT [DF_Solicitantes_IdIdiomaPreferido]  DEFAULT ('ES') FOR [IdIdiomaPreferido]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  DEFAULT ((0)) FOR [AutorizaPortal]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  DEFAULT ((0)) FOR [PrefiereSMS]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  DEFAULT ((1)) FOR [RepresentanteLegal]
GO
ALTER TABLE [dbo].[Solicitantes] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Solicitudes] ADD  DEFAULT (getdate()) FOR [FechaSolicitud]
GO
ALTER TABLE [dbo].[Solicitudes] ADD  CONSTRAINT [DF_Solicitudes_IdFormaEntrega]  DEFAULT ((1)) FOR [IdFormaEntrega]
GO
ALTER TABLE [dbo].[Solicitudes] ADD  CONSTRAINT [DF_Solicitudes_CodigoSolicitud]  DEFAULT (NEXT VALUE FOR [dbo].[SEQ_CodigoSolicitud]) FOR [CodigoSolicitud]
GO
ALTER TABLE [dbo].[Solicitudes] ADD  DEFAULT ((0)) FOR [EstadoBit]
GO
ALTER TABLE [dbo].[Solicitudes] ADD  DEFAULT ((0)) FOR [EsForense]
GO
ALTER TABLE [dbo].[Solicitudes] ADD  DEFAULT ((1)) FOR [IdEstado]
GO
ALTER TABLE [dbo].[Solicitudes] ADD  DEFAULT ('Pendiente') FOR [EstadoResultados]
GO
ALTER TABLE [dbo].[SolicitudesSolicitantes] ADD  DEFAULT ((0)) FOR [EsInterviniente]
GO
ALTER TABLE [dbo].[TarifasBase] ADD  DEFAULT ((0)) FOR [PrecioPorInterviniente]
GO
ALTER TABLE [dbo].[TarifasBase] ADD  DEFAULT ((0)) FOR [PrecioPorMuestra]
GO
ALTER TABLE [dbo].[TiposDocumentos] ADD  DEFAULT ((0)) FOR [RequiereAprobacion]
GO
ALTER TABLE [dbo].[TiposDocumentos] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TiposMovimiento] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TiposMuestra] ADD  DEFAULT ((0)) FOR [CosteFijo]
GO
ALTER TABLE [dbo].[TiposPlantillas] ADD  DEFAULT ((0)) FOR [RequiereFirma]
GO
ALTER TABLE [dbo].[TiposPlantillas] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TiposPruebasConsumo] ADD  DEFAULT ((1)) FOR [RequiereValidacion]
GO
ALTER TABLE [dbo].[TiposPruebasConsumo] ADD  CONSTRAINT [DF_TiposPruebasConsumo_IdDudaParienteCercano]  DEFAULT ((13)) FOR [IdDudaParienteCercano]
GO
ALTER TABLE [dbo].[TiposPruebasConsumo] ADD  DEFAULT ((0)) FOR [Transfusiones]
GO
ALTER TABLE [dbo].[TomasMuestra] ADD  DEFAULT (getdate()) FOR [FechaToma]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT ((0)) FOR [CambiarPassword]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[UsuariosPortal] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[UsuariosPortal] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[ValidacionesResultado] ADD  DEFAULT (getdate()) FOR [FechaValidacion]
GO
ALTER TABLE [dbo].[ValidacionesResultado] ADD  DEFAULT ((1)) FOR [NivelValidacion]
GO
ALTER TABLE [dbo].[ValidacionesResultado] ADD  DEFAULT ((0)) FOR [EsFinal]
GO
ALTER TABLE [dbo].[Abogados]  WITH CHECK ADD  CONSTRAINT [FK_Abogados_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Abogados] CHECK CONSTRAINT [FK_Abogados_Direcciones]
GO
ALTER TABLE [dbo].[Acreditaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Acreditaciones_TiposDocumentos] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
GO
ALTER TABLE [dbo].[Acreditaciones] NOCHECK CONSTRAINT [FK_Acreditaciones_TiposDocumentos]
GO
ALTER TABLE [dbo].[Acreditaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Acreditaciones_Usuarios] FOREIGN KEY([IdUsuarioRegistro])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[Acreditaciones] NOCHECK CONSTRAINT [FK_Acreditaciones_Usuarios]
GO
ALTER TABLE [dbo].[AdjuntosEnvio]  WITH NOCHECK ADD  CONSTRAINT [FK_AdjuntosEnvio_Envios] FOREIGN KEY([IdEnvio])
REFERENCES [dbo].[Envios] ([IdEnvio])
GO
ALTER TABLE [dbo].[AdjuntosEnvio] NOCHECK CONSTRAINT [FK_AdjuntosEnvio_Envios]
GO
ALTER TABLE [dbo].[AdjuntosEnvio]  WITH NOCHECK ADD  CONSTRAINT [FK_AdjuntosEnvio_TiposPlantillas] FOREIGN KEY([IdTipoPlantilla])
REFERENCES [dbo].[TiposPlantillas] ([IdTipoPlantilla])
GO
ALTER TABLE [dbo].[AdjuntosEnvio] NOCHECK CONSTRAINT [FK_AdjuntosEnvio_TiposPlantillas]
GO
ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Envase] FOREIGN KEY([IdEnvase])
REFERENCES [dbo].[Envases] ([IdEnvase])
GO
ALTER TABLE [dbo].[Articulos] NOCHECK CONSTRAINT [FK_Articulos_Envase]
GO
ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Fabricante] FOREIGN KEY([IdFabricante])
REFERENCES [dbo].[Fabricantes] ([IdFabricante])
GO
ALTER TABLE [dbo].[Articulos] NOCHECK CONSTRAINT [FK_Articulos_Fabricante]
GO
ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Familia] FOREIGN KEY([IdFamilia])
REFERENCES [dbo].[Familias] ([IdFamilia])
GO
ALTER TABLE [dbo].[Articulos] NOCHECK CONSTRAINT [FK_Articulos_Familia]
GO
ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Proveedor] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Articulos] NOCHECK CONSTRAINT [FK_Articulos_Proveedor]
GO
ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Unidad] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[Articulos] NOCHECK CONSTRAINT [FK_Articulos_Unidad]
GO
ALTER TABLE [dbo].[AuditoriaAcciones]  WITH NOCHECK ADD  CONSTRAINT [FK_AuditoriaAcciones_Documentos] FOREIGN KEY([IdDocumento])
REFERENCES [dbo].[Documentos] ([IdDocumento])
GO
ALTER TABLE [dbo].[AuditoriaAcciones] NOCHECK CONSTRAINT [FK_AuditoriaAcciones_Documentos]
GO
ALTER TABLE [dbo].[AuditoriasCalidad]  WITH NOCHECK ADD  CONSTRAINT [FK_AuditoriasCalidad_Usuarios] FOREIGN KEY([IdUsuarioResponsable])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[AuditoriasCalidad] NOCHECK CONSTRAINT [FK_AuditoriasCalidad_Usuarios]
GO
ALTER TABLE [dbo].[Bancos]  WITH CHECK ADD  CONSTRAINT [FK_Bancos_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Bancos] CHECK CONSTRAINT [FK_Bancos_Direcciones]
GO
ALTER TABLE [dbo].[Centros]  WITH NOCHECK ADD  CONSTRAINT [FK_Centros_AvisoAdmon] FOREIGN KEY([IdAvisoAdmon])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Centros] NOCHECK CONSTRAINT [FK_Centros_AvisoAdmon]
GO
ALTER TABLE [dbo].[Centros]  WITH NOCHECK ADD  CONSTRAINT [FK_Centros_AvisoFacturacion] FOREIGN KEY([IdAvisoFacturacion])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Centros] NOCHECK CONSTRAINT [FK_Centros_AvisoFacturacion]
GO
ALTER TABLE [dbo].[Centros]  WITH NOCHECK ADD  CONSTRAINT [FK_Centros_AvisoInternas] FOREIGN KEY([IdAvisoInternas])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Centros] NOCHECK CONSTRAINT [FK_Centros_AvisoInternas]
GO
ALTER TABLE [dbo].[Centros]  WITH NOCHECK ADD  CONSTRAINT [FK_Centros_AvisoTecnico] FOREIGN KEY([IdAvisoTecnico])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Centros] NOCHECK CONSTRAINT [FK_Centros_AvisoTecnico]
GO
ALTER TABLE [dbo].[Centros]  WITH CHECK ADD  CONSTRAINT [FK_Centros_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[Centros] CHECK CONSTRAINT [FK_Centros_Direcciones]
GO
ALTER TABLE [dbo].[CodigosPostales]  WITH NOCHECK ADD  CONSTRAINT [FK_CodigosPostales_Pais] FOREIGN KEY([CodigoPais])
REFERENCES [dbo].[Paises] ([CodigoPais])
GO
ALTER TABLE [dbo].[CodigosPostales] NOCHECK CONSTRAINT [FK_CodigosPostales_Pais]
GO
ALTER TABLE [dbo].[CodigosPostales]  WITH NOCHECK ADD  CONSTRAINT [FK_CodigosPostales_Poblacion] FOREIGN KEY([CodigoMunicipio])
REFERENCES [dbo].[Poblaciones] ([CodigoMunicipio])
GO
ALTER TABLE [dbo].[CodigosPostales] NOCHECK CONSTRAINT [FK_CodigosPostales_Poblacion]
GO
ALTER TABLE [dbo].[ConfiguracionesPrecio]  WITH NOCHECK ADD  CONSTRAINT [FK_ConfigPrecio_TipoPruebaConsumo] FOREIGN KEY([IdTiposPruebasConsumo])
REFERENCES [dbo].[TiposPruebasConsumo] ([IdTipoPruebaConsumo])
GO
ALTER TABLE [dbo].[ConfiguracionesPrecio] NOCHECK CONSTRAINT [FK_ConfigPrecio_TipoPruebaConsumo]
GO
ALTER TABLE [dbo].[ConfiguracionesPrecio]  WITH NOCHECK ADD  CONSTRAINT [FK_ConfiguracionesPrecio_Regla] FOREIGN KEY([IdRegla])
REFERENCES [dbo].[ReglasIncrementoPrecio] ([IdRegla])
GO
ALTER TABLE [dbo].[ConfiguracionesPrecio] NOCHECK CONSTRAINT [FK_ConfiguracionesPrecio_Regla]
GO
ALTER TABLE [dbo].[ConfigValidaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_ConfigValidaciones_Roles] FOREIGN KEY([RolRequerido])
REFERENCES [dbo].[Roles] ([IdRol])
GO
ALTER TABLE [dbo].[ConfigValidaciones] NOCHECK CONSTRAINT [FK_ConfigValidaciones_Roles]
GO
ALTER TABLE [dbo].[Consentimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Consentimientos_Intervinientes] FOREIGN KEY([IdInterviniente])
REFERENCES [dbo].[Intervinientes] ([IdInterviniente])
GO
ALTER TABLE [dbo].[Consentimientos] NOCHECK CONSTRAINT [FK_Consentimientos_Intervinientes]
GO
ALTER TABLE [dbo].[Consentimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Consentimientos_Plantillas] FOREIGN KEY([IdPlantilla])
REFERENCES [dbo].[Plantillas] ([IdPlantilla])
GO
ALTER TABLE [dbo].[Consentimientos] NOCHECK CONSTRAINT [FK_Consentimientos_Plantillas]
GO
ALTER TABLE [dbo].[Consentimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Consentimientos_Solicitudes] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[Consentimientos] NOCHECK CONSTRAINT [FK_Consentimientos_Solicitudes]
GO
ALTER TABLE [dbo].[Consentimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Consentimientos_TiposPruebasConsumo] FOREIGN KEY([IdTipoPruebaConsumo])
REFERENCES [dbo].[TiposPruebasConsumo] ([IdTipoPruebaConsumo])
GO
ALTER TABLE [dbo].[Consentimientos] NOCHECK CONSTRAINT [FK_Consentimientos_TiposPruebasConsumo]
GO
ALTER TABLE [dbo].[ContactosEntidad]  WITH CHECK ADD  CONSTRAINT [FK_ContactosEntidad_Contactos] FOREIGN KEY([IdContacto])
REFERENCES [dbo].[Contactos] ([IdContacto])
GO
ALTER TABLE [dbo].[ContactosEntidad] CHECK CONSTRAINT [FK_ContactosEntidad_Contactos]
GO
ALTER TABLE [dbo].[Detectives]  WITH CHECK ADD  CONSTRAINT [FK_Detectives_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Detectives] CHECK CONSTRAINT [FK_Detectives_Direcciones]
GO
ALTER TABLE [dbo].[DeterminacionesAndrologia]  WITH NOCHECK ADD FOREIGN KEY([IdLineaPeticion])
REFERENCES [dbo].[PeticionesLin] ([IdLineaPeticion])
GO
ALTER TABLE [dbo].[Documentos]  WITH NOCHECK ADD  CONSTRAINT [FK_Documentos_EntidadTipo] FOREIGN KEY([IdEntidadTipo])
REFERENCES [dbo].[Entidades] ([IdEntidadTipo])
GO
ALTER TABLE [dbo].[Documentos] NOCHECK CONSTRAINT [FK_Documentos_EntidadTipo]
GO
ALTER TABLE [dbo].[Documentos]  WITH NOCHECK ADD  CONSTRAINT [FK_Documentos_SubidoPor] FOREIGN KEY([SubidoPor])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[Documentos] NOCHECK CONSTRAINT [FK_Documentos_SubidoPor]
GO
ALTER TABLE [dbo].[Documentos]  WITH NOCHECK ADD  CONSTRAINT [FK_Documentos_TipoDocumento] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
GO
ALTER TABLE [dbo].[Documentos] NOCHECK CONSTRAINT [FK_Documentos_TipoDocumento]
GO
ALTER TABLE [dbo].[Documentos]  WITH NOCHECK ADD  CONSTRAINT [FK_Documentos_TiposDocumentos] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
GO
ALTER TABLE [dbo].[Documentos] NOCHECK CONSTRAINT [FK_Documentos_TiposDocumentos]
GO
ALTER TABLE [dbo].[Documentos]  WITH NOCHECK ADD  CONSTRAINT [FK_Documentos_TiposEntidad] FOREIGN KEY([IdEntidadTipo])
REFERENCES [dbo].[TiposEntidad] ([IdEntidadTipo])
GO
ALTER TABLE [dbo].[Documentos] NOCHECK CONSTRAINT [FK_Documentos_TiposEntidad]
GO
ALTER TABLE [dbo].[Empresas]  WITH NOCHECK ADD  CONSTRAINT [FK_Empresa_Actividad] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[Actividades] ([IdActividad])
GO
ALTER TABLE [dbo].[Empresas] NOCHECK CONSTRAINT [FK_Empresa_Actividad]
GO
ALTER TABLE [dbo].[Empresas]  WITH NOCHECK ADD  CONSTRAINT [FK_Empresa_AvisoAdmon] FOREIGN KEY([IdAvisoAdmon])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Empresas] NOCHECK CONSTRAINT [FK_Empresa_AvisoAdmon]
GO
ALTER TABLE [dbo].[Empresas]  WITH NOCHECK ADD  CONSTRAINT [FK_Empresa_AvisoFacturacion] FOREIGN KEY([IdAvisoFacturacion])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Empresas] NOCHECK CONSTRAINT [FK_Empresa_AvisoFacturacion]
GO
ALTER TABLE [dbo].[Empresas]  WITH NOCHECK ADD  CONSTRAINT [FK_Empresa_AvisoInternas] FOREIGN KEY([IdAvisoInternas])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Empresas] NOCHECK CONSTRAINT [FK_Empresa_AvisoInternas]
GO
ALTER TABLE [dbo].[Empresas]  WITH NOCHECK ADD  CONSTRAINT [FK_Empresa_AvisoTecnico] FOREIGN KEY([IdAvisoTecnico])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Empresas] NOCHECK CONSTRAINT [FK_Empresa_AvisoTecnico]
GO
ALTER TABLE [dbo].[Empresas]  WITH NOCHECK ADD  CONSTRAINT [FK_Empresa_Laboratorio] FOREIGN KEY([IdLaboratorioColaborador])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[Empresas] NOCHECK CONSTRAINT [FK_Empresa_Laboratorio]
GO
ALTER TABLE [dbo].[Empresas]  WITH CHECK ADD  CONSTRAINT [FK_Empresas_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[Empresas] CHECK CONSTRAINT [FK_Empresas_Direcciones]
GO
ALTER TABLE [dbo].[Equipos]  WITH NOCHECK ADD  CONSTRAINT [FK_Equipos_Especialidad] FOREIGN KEY([IdEspecialidad])
REFERENCES [dbo].[Especialidades] ([IdEspecialidad])
GO
ALTER TABLE [dbo].[Equipos] NOCHECK CONSTRAINT [FK_Equipos_Especialidad]
GO
ALTER TABLE [dbo].[Equipos]  WITH NOCHECK ADD  CONSTRAINT [FK_Equipos_Fabricante] FOREIGN KEY([IdFabricante])
REFERENCES [dbo].[Fabricantes] ([IdFabricante])
GO
ALTER TABLE [dbo].[Equipos] NOCHECK CONSTRAINT [FK_Equipos_Fabricante]
GO
ALTER TABLE [dbo].[Equipos]  WITH NOCHECK ADD  CONSTRAINT [FK_Equipos_Personal] FOREIGN KEY([IdPersonal])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[Equipos] NOCHECK CONSTRAINT [FK_Equipos_Personal]
GO
ALTER TABLE [dbo].[Equipos]  WITH NOCHECK ADD  CONSTRAINT [FK_Equipos_Proveedor] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Equipos] NOCHECK CONSTRAINT [FK_Equipos_Proveedor]
GO
ALTER TABLE [dbo].[Fabricantes]  WITH CHECK ADD  CONSTRAINT [FK_Fabricantes_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[Fabricantes] CHECK CONSTRAINT [FK_Fabricantes_Direcciones]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_AvisoFacturacion] FOREIGN KEY([IdAvisoFacturacion])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_AvisoFacturacion]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_AvisoInternas] FOREIGN KEY([IdAvisoInternas])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_AvisoInternas]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_Cliente] FOREIGN KEY([IdLaboratorioColaborador])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_Cliente]
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Direcciones]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresas] ([IdEmpresa])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_Empresa]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[FormasPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_FormaPago]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_IVA1] FOREIGN KEY([IdIVA1])
REFERENCES [dbo].[IVA] ([IdIVA])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_IVA1]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_IVA2] FOREIGN KEY([IdIVA2])
REFERENCES [dbo].[IVA] ([IdIVA])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_IVA2]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_IVA3] FOREIGN KEY([IdIVA3])
REFERENCES [dbo].[IVA] ([IdIVA])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_IVA3]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_Solicitantes] FOREIGN KEY([IdSolicitante])
REFERENCES [dbo].[Solicitantes] ([IdSolicitante])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_Solicitantes]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_Tarifa] FOREIGN KEY([IdTarifa])
REFERENCES [dbo].[Tarifas] ([IdTarifa])
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [FK_Facturas_Tarifa]
GO
ALTER TABLE [dbo].[HistorialImpresion]  WITH NOCHECK ADD FOREIGN KEY([IdImpresora])
REFERENCES [dbo].[Impresoras] ([IdImpresora])
GO
ALTER TABLE [dbo].[HistorialImpresion]  WITH NOCHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[IndiceParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_IndiceParentesco_Perfil1] FOREIGN KEY([IdPerfilGenetico1])
REFERENCES [dbo].[PerfilesGeneticos] ([IdPerfilGenetico])
GO
ALTER TABLE [dbo].[IndiceParentesco] NOCHECK CONSTRAINT [FK_IndiceParentesco_Perfil1]
GO
ALTER TABLE [dbo].[IndiceParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_IndiceParentesco_Perfil2] FOREIGN KEY([IdPerfilGenetico2])
REFERENCES [dbo].[PerfilesGeneticos] ([IdPerfilGenetico])
GO
ALTER TABLE [dbo].[IndiceParentesco] NOCHECK CONSTRAINT [FK_IndiceParentesco_Perfil2]
GO
ALTER TABLE [dbo].[IndiceParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_IndiceParentesco_ResultadosParentesco] FOREIGN KEY([IdResultadoParentesco])
REFERENCES [dbo].[ResultadosParentesco] ([IdResultadoParentesco])
GO
ALTER TABLE [dbo].[IndiceParentesco] NOCHECK CONSTRAINT [FK_IndiceParentesco_ResultadosParentesco]
GO
ALTER TABLE [dbo].[IndiceParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_IndiceParentesco_Solicitud] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[IndiceParentesco] NOCHECK CONSTRAINT [FK_IndiceParentesco_Solicitud]
GO
ALTER TABLE [dbo].[IndiceParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_IndiceParentesco_Usuario] FOREIGN KEY([IdUsuarioAnalista])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[IndiceParentesco] NOCHECK CONSTRAINT [FK_IndiceParentesco_Usuario]
GO
ALTER TABLE [dbo].[IndiceParentesco_Resultados]  WITH NOCHECK ADD  CONSTRAINT [FK_IndiceParentesco_Resultados_IndiceParentesco] FOREIGN KEY([IdIndiceParentesco])
REFERENCES [dbo].[IndiceParentesco] ([IdIndiceParentesco])
GO
ALTER TABLE [dbo].[IndiceParentesco_Resultados] NOCHECK CONSTRAINT [FK_IndiceParentesco_Resultados_IndiceParentesco]
GO
ALTER TABLE [dbo].[IndiceParentesco_Resultados]  WITH NOCHECK ADD  CONSTRAINT [FK_IndiceParentesco_Resultados_ResultadosParentesco] FOREIGN KEY([IdResultadoParentesco])
REFERENCES [dbo].[ResultadosParentesco] ([IdResultadoParentesco])
GO
ALTER TABLE [dbo].[IndiceParentesco_Resultados] NOCHECK CONSTRAINT [FK_IndiceParentesco_Resultados_ResultadosParentesco]
GO
ALTER TABLE [dbo].[InformesGenerados]  WITH NOCHECK ADD  CONSTRAINT [FK_InformesGenerados_Documentos] FOREIGN KEY([IdDocumento])
REFERENCES [dbo].[Documentos] ([IdDocumento])
GO
ALTER TABLE [dbo].[InformesGenerados] NOCHECK CONSTRAINT [FK_InformesGenerados_Documentos]
GO
ALTER TABLE [dbo].[InformesGenerados]  WITH NOCHECK ADD  CONSTRAINT [FK_InformesGenerados_Plantillas] FOREIGN KEY([IdPlantilla])
REFERENCES [dbo].[PlantillasInforme] ([IdPlantilla])
GO
ALTER TABLE [dbo].[InformesGenerados] NOCHECK CONSTRAINT [FK_InformesGenerados_Plantillas]
GO
ALTER TABLE [dbo].[InformesGenerados]  WITH NOCHECK ADD  CONSTRAINT [FK_InformesGenerados_Solicitudes] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[InformesGenerados] NOCHECK CONSTRAINT [FK_InformesGenerados_Solicitudes]
GO
ALTER TABLE [dbo].[InformesGenerados]  WITH NOCHECK ADD  CONSTRAINT [FK_InformesGenerados_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[InformesGenerados] NOCHECK CONSTRAINT [FK_InformesGenerados_Usuarios]
GO
ALTER TABLE [dbo].[Intervinientes]  WITH NOCHECK ADD FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[Intervinientes]  WITH CHECK ADD  CONSTRAINT [FK_Intervinientes_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[Intervinientes] CHECK CONSTRAINT [FK_Intervinientes_Direcciones]
GO
ALTER TABLE [dbo].[Intervinientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Intervinientes_Solicitantes] FOREIGN KEY([IdSolicitante])
REFERENCES [dbo].[Solicitantes] ([IdSolicitante])
GO
ALTER TABLE [dbo].[Intervinientes] NOCHECK CONSTRAINT [FK_Intervinientes_Solicitantes]
GO
ALTER TABLE [dbo].[Intervinientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Intervinientes_TipoInterviniente] FOREIGN KEY([IdTipoInterviniente])
REFERENCES [dbo].[TipoInterviniente] ([Codigo])
GO
ALTER TABLE [dbo].[Intervinientes] NOCHECK CONSTRAINT [FK_Intervinientes_TipoInterviniente]
GO
ALTER TABLE [dbo].[Intervinientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Intervinientes_TiposDocumentos] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
GO
ALTER TABLE [dbo].[Intervinientes] NOCHECK CONSTRAINT [FK_Intervinientes_TiposDocumentos]
GO
ALTER TABLE [dbo].[LaboratorioImportes]  WITH NOCHECK ADD  CONSTRAINT [FK_LaboratorioImportes_LaboratoriosColaboradores] FOREIGN KEY([IdLaboratorioColaborador])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[LaboratorioImportes] NOCHECK CONSTRAINT [FK_LaboratorioImportes_LaboratoriosColaboradores]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_Actividad] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[Actividades] ([IdActividad])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_Actividad]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_AvisoAdmon] FOREIGN KEY([IdAvisoAdmon])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_AvisoAdmon]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_AvisoFacturacion] FOREIGN KEY([IdAvisoFacturacion])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_AvisoFacturacion]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_AvisoInternas] FOREIGN KEY([IdAvisoInternas])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_AvisoInternas]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_AvisoTecnico] FOREIGN KEY([IdAvisoTecnico])
REFERENCES [dbo].[Avisos] ([IdAviso])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_AvisoTecnico]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_Banco] FOREIGN KEY([IdBanco])
REFERENCES [dbo].[Bancos] ([IdBanco])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_Banco]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[FormasPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_FormaPago]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_Idioma] FOREIGN KEY([IdIdioma])
REFERENCES [dbo].[Idiomas] ([IdIdioma])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_Idioma]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_IVA] FOREIGN KEY([IdIVA])
REFERENCES [dbo].[IVA] ([IdIVA])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_IVA]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_Personal] FOREIGN KEY([IdPersonal])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_Personal]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_Tarifa] FOREIGN KEY([IdTarifa])
REFERENCES [dbo].[Tarifas] ([IdTarifa])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_Tarifa]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_Laboratorio_TipoClienteConsumo] FOREIGN KEY([IdTipoClienteConsumo])
REFERENCES [dbo].[TiposClientesConsumo] ([IdTipoClienteConsumo])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_Laboratorio_TipoClienteConsumo]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH CHECK ADD  CONSTRAINT [FK_LaboratoriosColaboradores_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] CHECK CONSTRAINT [FK_LaboratoriosColaboradores_Direcciones]
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores]  WITH NOCHECK ADD  CONSTRAINT [FK_LaboratoriosColaboradores_Idiomas] FOREIGN KEY([IdIdiomaPreferido])
REFERENCES [dbo].[Idiomas] ([IdIdioma])
GO
ALTER TABLE [dbo].[LaboratoriosColaboradores] NOCHECK CONSTRAINT [FK_LaboratoriosColaboradores_Idiomas]
GO
ALTER TABLE [dbo].[LineasFactura]  WITH NOCHECK ADD FOREIGN KEY([IdLineaPeticion])
REFERENCES [dbo].[PeticionesLin] ([IdLineaPeticion])
GO
ALTER TABLE [dbo].[LineasFactura]  WITH NOCHECK ADD  CONSTRAINT [FK_LineasFactura_Factura] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[Facturas] ([IdFactura])
GO
ALTER TABLE [dbo].[LineasFactura] NOCHECK CONSTRAINT [FK_LineasFactura_Factura]
GO
ALTER TABLE [dbo].[LineasFactura]  WITH NOCHECK ADD  CONSTRAINT [FK_LineasFactura_Tarifa] FOREIGN KEY([IdTarifa])
REFERENCES [dbo].[Tarifas] ([IdTarifa])
GO
ALTER TABLE [dbo].[LineasFactura] NOCHECK CONSTRAINT [FK_LineasFactura_Tarifa]
GO
ALTER TABLE [dbo].[MarcadorComparisons]  WITH NOCHECK ADD  CONSTRAINT [FK_MarcadorComparisons_Resultado1] FOREIGN KEY([IdResultadoParentesco1])
REFERENCES [dbo].[ResultadosParentesco] ([IdResultadoParentesco])
GO
ALTER TABLE [dbo].[MarcadorComparisons] NOCHECK CONSTRAINT [FK_MarcadorComparisons_Resultado1]
GO
ALTER TABLE [dbo].[MarcadorComparisons]  WITH NOCHECK ADD  CONSTRAINT [FK_MarcadorComparisons_Resultado2] FOREIGN KEY([IdResultadoParentesco2])
REFERENCES [dbo].[ResultadosParentesco] ([IdResultadoParentesco])
GO
ALTER TABLE [dbo].[MarcadorComparisons] NOCHECK CONSTRAINT [FK_MarcadorComparisons_Resultado2]
GO
ALTER TABLE [dbo].[Medicos]  WITH NOCHECK ADD  CONSTRAINT [FK_Medicos_Actividad] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[Actividades] ([IdActividad])
GO
ALTER TABLE [dbo].[Medicos] NOCHECK CONSTRAINT [FK_Medicos_Actividad]
GO
ALTER TABLE [dbo].[MovimientosMuestras]  WITH NOCHECK ADD  CONSTRAINT [FK_MovimientosMuestras_Muestras] FOREIGN KEY([IdMuestra])
REFERENCES [dbo].[Muestras] ([IdMuestra])
GO
ALTER TABLE [dbo].[MovimientosMuestras] NOCHECK CONSTRAINT [FK_MovimientosMuestras_Muestras]
GO
ALTER TABLE [dbo].[MovimientosMuestras]  WITH NOCHECK ADD  CONSTRAINT [FK_MovimientosMuestras_TiposMovimiento] FOREIGN KEY([IdTipoMovimiento])
REFERENCES [dbo].[TiposMovimiento] ([IdTipoMovimiento])
GO
ALTER TABLE [dbo].[MovimientosMuestras] NOCHECK CONSTRAINT [FK_MovimientosMuestras_TiposMovimiento]
GO
ALTER TABLE [dbo].[MovimientosMuestras]  WITH NOCHECK ADD  CONSTRAINT [FK_MovimientosMuestras_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[MovimientosMuestras] NOCHECK CONSTRAINT [FK_MovimientosMuestras_Usuarios]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_CentroToma] FOREIGN KEY([IdCentroToma])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_CentroToma]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_Interviniente] FOREIGN KEY([IdInterviniente])
REFERENCES [dbo].[Intervinientes] ([IdInterviniente])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_Interviniente]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_MetodoAmplificacion] FOREIGN KEY([IdMetodoAmplificacion])
REFERENCES [dbo].[MetodosAmplificacion] ([IdMetodo])
GO
ALTER TABLE [dbo].[Muestras] CHECK CONSTRAINT [FK_Muestras_MetodoAmplificacion]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_MetodoExtraccion] FOREIGN KEY([IdMetodoExtraccion])
REFERENCES [dbo].[MetodosExtraccion] ([IdMetodo])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_MetodoExtraccion]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_PersonaTomaMuestras] FOREIGN KEY([IdPersonaTomaMuestras])
REFERENCES [dbo].[PersonasTomaMuestras] ([IdPersonaTomaMuestras])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_PersonaTomaMuestras]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_Peticiones] FOREIGN KEY([IdPeticion])
REFERENCES [dbo].[Peticiones] ([IdPeticion])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_Peticiones]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_Solicitantes] FOREIGN KEY([IdSolicitante])
REFERENCES [dbo].[Solicitantes] ([IdSolicitante])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_Solicitantes]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_Solicitudes] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_Solicitudes]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_TecnicoAmplificacion] FOREIGN KEY([IdTecnicoAmplificacion])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_TecnicoAmplificacion]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_TecnicoExtraccion] FOREIGN KEY([IdTecnicoExtraccion])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_TecnicoExtraccion]
GO
ALTER TABLE [dbo].[Muestras]  WITH NOCHECK ADD  CONSTRAINT [FK_Muestras_TipoMuestra] FOREIGN KEY([TipoMuestra])
REFERENCES [dbo].[TiposMuestra] ([IdTipoMuestra])
GO
ALTER TABLE [dbo].[Muestras] NOCHECK CONSTRAINT [FK_Muestras_TipoMuestra]
GO
ALTER TABLE [dbo].[NotificacionesSMS]  WITH NOCHECK ADD  CONSTRAINT [FK_NotificacionesSMS_Solicitudes] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[NotificacionesSMS] NOCHECK CONSTRAINT [FK_NotificacionesSMS_Solicitudes]
GO
ALTER TABLE [dbo].[NotificacionesSMS]  WITH NOCHECK ADD  CONSTRAINT [FK_NotificacionesSMS_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[NotificacionesSMS] NOCHECK CONSTRAINT [FK_NotificacionesSMS_Usuarios]
GO
ALTER TABLE [dbo].[PagosPaciente]  WITH NOCHECK ADD FOREIGN KEY([IdLineaPeticion])
REFERENCES [dbo].[PeticionesLin] ([IdLineaPeticion])
GO
ALTER TABLE [dbo].[PagosPaciente]  WITH NOCHECK ADD  CONSTRAINT [FK_PagosPaciente_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[FormasPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[PagosPaciente] NOCHECK CONSTRAINT [FK_PagosPaciente_FormaPago]
GO
ALTER TABLE [dbo].[PagosPaciente]  WITH NOCHECK ADD  CONSTRAINT [FK_PagosPaciente_Solicitantes] FOREIGN KEY([IdSolicitante])
REFERENCES [dbo].[Solicitantes] ([IdSolicitante])
GO
ALTER TABLE [dbo].[PagosPaciente] NOCHECK CONSTRAINT [FK_PagosPaciente_Solicitantes]
GO
ALTER TABLE [dbo].[PerfilesGeneticos]  WITH NOCHECK ADD  CONSTRAINT [FK_PerfilesGeneticos_Intervinientes] FOREIGN KEY([IdInterviniente])
REFERENCES [dbo].[Intervinientes] ([IdInterviniente])
GO
ALTER TABLE [dbo].[PerfilesGeneticos] NOCHECK CONSTRAINT [FK_PerfilesGeneticos_Intervinientes]
GO
ALTER TABLE [dbo].[PerfilesGeneticos]  WITH CHECK ADD  CONSTRAINT [FK_PerfilesGeneticos_Usuarios] FOREIGN KEY([IdUsuarioAnalista])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[PerfilesGeneticos] CHECK CONSTRAINT [FK_PerfilesGeneticos_Usuarios]
GO
ALTER TABLE [dbo].[PermisosDocumento]  WITH NOCHECK ADD  CONSTRAINT [FK_PermisosDocumento_Documentos] FOREIGN KEY([IdDocumento])
REFERENCES [dbo].[Documentos] ([IdDocumento])
GO
ALTER TABLE [dbo].[PermisosDocumento] NOCHECK CONSTRAINT [FK_PermisosDocumento_Documentos]
GO
ALTER TABLE [dbo].[PermisosDocumento]  WITH NOCHECK ADD  CONSTRAINT [FK_PermisosDocumento_Roles] FOREIGN KEY([IdRol])
REFERENCES [dbo].[Roles] ([IdRol])
GO
ALTER TABLE [dbo].[PermisosDocumento] NOCHECK CONSTRAINT [FK_PermisosDocumento_Roles]
GO
ALTER TABLE [dbo].[PermisosDocumento]  WITH NOCHECK ADD  CONSTRAINT [FK_PermisosDocumento_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[PermisosDocumento] NOCHECK CONSTRAINT [FK_PermisosDocumento_Usuarios]
GO
ALTER TABLE [dbo].[Personal]  WITH NOCHECK ADD  CONSTRAINT [FK_Personal_Cargo] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[Cargos] ([IdCargo])
GO
ALTER TABLE [dbo].[Personal] NOCHECK CONSTRAINT [FK_Personal_Cargo]
GO
ALTER TABLE [dbo].[Personal]  WITH CHECK ADD  CONSTRAINT [FK_Personal_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[Personal] CHECK CONSTRAINT [FK_Personal_Direcciones]
GO
ALTER TABLE [dbo].[Personal]  WITH NOCHECK ADD  CONSTRAINT [FK_Personal_Especialidad] FOREIGN KEY([IdEspecialidad])
REFERENCES [dbo].[Especialidades] ([IdEspecialidad])
GO
ALTER TABLE [dbo].[Personal] NOCHECK CONSTRAINT [FK_Personal_Especialidad]
GO
ALTER TABLE [dbo].[Personal]  WITH NOCHECK ADD  CONSTRAINT [FK_Personal_TiposDocumentos] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
GO
ALTER TABLE [dbo].[Personal] NOCHECK CONSTRAINT [FK_Personal_TiposDocumentos]
GO
ALTER TABLE [dbo].[PersonasTomaMuestras]  WITH NOCHECK ADD  CONSTRAINT [FK_PersonasToma_Laboratorio] FOREIGN KEY([IdLaboratorioColaborador])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[PersonasTomaMuestras] NOCHECK CONSTRAINT [FK_PersonasToma_Laboratorio]
GO
ALTER TABLE [dbo].[PersonasTomaMuestras]  WITH NOCHECK ADD  CONSTRAINT [FK_PersonasTomaMuestras_TiposDocumentos] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
GO
ALTER TABLE [dbo].[PersonasTomaMuestras] NOCHECK CONSTRAINT [FK_PersonasTomaMuestras_TiposDocumentos]
GO
ALTER TABLE [dbo].[Peticiones]  WITH NOCHECK ADD FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[Peticiones]  WITH NOCHECK ADD  CONSTRAINT [FK_Peticiones_Solicitudes] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[Peticiones] NOCHECK CONSTRAINT [FK_Peticiones_Solicitudes]
GO
ALTER TABLE [dbo].[Peticiones]  WITH NOCHECK ADD  CONSTRAINT [FK_Peticiones_TiposPrueba] FOREIGN KEY([IdTipoPrueba])
REFERENCES [dbo].[TiposPrueba] ([IdTipoPrueba])
GO
ALTER TABLE [dbo].[Peticiones] NOCHECK CONSTRAINT [FK_Peticiones_TiposPrueba]
GO
ALTER TABLE [dbo].[Peticiones]  WITH NOCHECK ADD  CONSTRAINT [FK_Peticiones_TiposPruebasConsumo] FOREIGN KEY([IdSubTipoPrueba])
REFERENCES [dbo].[TiposPruebasConsumo] ([IdTipoPruebaConsumo])
GO
ALTER TABLE [dbo].[Peticiones] NOCHECK CONSTRAINT [FK_Peticiones_TiposPruebasConsumo]
GO
ALTER TABLE [dbo].[PeticionesLin]  WITH NOCHECK ADD  CONSTRAINT [FK_PeticionesLin_Peticiones] FOREIGN KEY([IdPeticion])
REFERENCES [dbo].[Peticiones] ([IdPeticion])
GO
ALTER TABLE [dbo].[PeticionesLin] NOCHECK CONSTRAINT [FK_PeticionesLin_Peticiones]
GO
ALTER TABLE [dbo].[PeticionesLin]  WITH NOCHECK ADD  CONSTRAINT [FK_PeticionesLin_PlazoEntrega] FOREIGN KEY([IdPlazoEntrega])
REFERENCES [dbo].[PlazosEntrega] ([IdPlazoEntrega])
GO
ALTER TABLE [dbo].[PeticionesLin] NOCHECK CONSTRAINT [FK_PeticionesLin_PlazoEntrega]
GO
ALTER TABLE [dbo].[PeticionesLin]  WITH NOCHECK ADD  CONSTRAINT [FK_PeticionesLin_Solicitudes] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[PeticionesLin] NOCHECK CONSTRAINT [FK_PeticionesLin_Solicitudes]
GO
ALTER TABLE [dbo].[PeticionesLin]  WITH NOCHECK ADD  CONSTRAINT [FK_PeticionesLin_TipoMuestra] FOREIGN KEY([IdTipoMuestra])
REFERENCES [dbo].[TiposMuestra] ([IdTipoMuestra])
GO
ALTER TABLE [dbo].[PeticionesLin] NOCHECK CONSTRAINT [FK_PeticionesLin_TipoMuestra]
GO
ALTER TABLE [dbo].[PeticionesLin]  WITH NOCHECK ADD  CONSTRAINT [FK_PeticionesLin_TiposPrueba] FOREIGN KEY([IdTipoPrueba])
REFERENCES [dbo].[TiposPrueba] ([IdTipoPrueba])
GO
ALTER TABLE [dbo].[PeticionesLin] NOCHECK CONSTRAINT [FK_PeticionesLin_TiposPrueba]
GO
ALTER TABLE [dbo].[PeticionesLin]  WITH NOCHECK ADD  CONSTRAINT [FK_PeticionesLin_TiposPruebasConsumo] FOREIGN KEY([IdTiposPruebasConsumo])
REFERENCES [dbo].[TiposPruebasConsumo] ([IdTipoPruebaConsumo])
GO
ALTER TABLE [dbo].[PeticionesLin] NOCHECK CONSTRAINT [FK_PeticionesLin_TiposPruebasConsumo]
GO
ALTER TABLE [dbo].[Plantillas]  WITH NOCHECK ADD  CONSTRAINT [FK_Plantillas_Idiomas] FOREIGN KEY([IdIdioma])
REFERENCES [dbo].[Idiomas] ([IdIdioma])
GO
ALTER TABLE [dbo].[Plantillas] NOCHECK CONSTRAINT [FK_Plantillas_Idiomas]
GO
ALTER TABLE [dbo].[Plantillas]  WITH NOCHECK ADD  CONSTRAINT [FK_Plantillas_TiposPlantillas] FOREIGN KEY([IdTipoPlantilla])
REFERENCES [dbo].[TiposPlantillas] ([IdTipoPlantilla])
GO
ALTER TABLE [dbo].[Plantillas] NOCHECK CONSTRAINT [FK_Plantillas_TiposPlantillas]
GO
ALTER TABLE [dbo].[Plantillas]  WITH NOCHECK ADD  CONSTRAINT [FK_Plantillas_TiposPruebasConsumo] FOREIGN KEY([IdTipoPruebaConsumo])
REFERENCES [dbo].[TiposPruebasConsumo] ([IdTipoPruebaConsumo])
GO
ALTER TABLE [dbo].[Plantillas] NOCHECK CONSTRAINT [FK_Plantillas_TiposPruebasConsumo]
GO
ALTER TABLE [dbo].[PlantillasInforme]  WITH NOCHECK ADD  CONSTRAINT [FK_PlantillasInforme_Idiomas] FOREIGN KEY([IdIdioma])
REFERENCES [dbo].[Idiomas] ([IdIdioma])
GO
ALTER TABLE [dbo].[PlantillasInforme] NOCHECK CONSTRAINT [FK_PlantillasInforme_Idiomas]
GO
ALTER TABLE [dbo].[PlantillasNotificacion]  WITH NOCHECK ADD  CONSTRAINT [FK_PlantillasNotificacion_Idiomas] FOREIGN KEY([IdIdioma])
REFERENCES [dbo].[Idiomas] ([IdIdioma])
GO
ALTER TABLE [dbo].[PlantillasNotificacion] NOCHECK CONSTRAINT [FK_PlantillasNotificacion_Idiomas]
GO
ALTER TABLE [dbo].[Poblaciones]  WITH NOCHECK ADD FOREIGN KEY([CodigoProvincia])
REFERENCES [dbo].[Provincias] ([CodigoProvincia])
GO
ALTER TABLE [dbo].[PrecioCache]  WITH NOCHECK ADD  CONSTRAINT [FK_PrecioCache_ReglasIncrementoPrecio] FOREIGN KEY([IdRegla])
REFERENCES [dbo].[ReglasIncrementoPrecio] ([IdRegla])
GO
ALTER TABLE [dbo].[PrecioCache] NOCHECK CONSTRAINT [FK_PrecioCache_ReglasIncrementoPrecio]
GO
ALTER TABLE [dbo].[PrecioCache]  WITH NOCHECK ADD  CONSTRAINT [FK_PrecioCache_TiposPruebasConsumo] FOREIGN KEY([IdTiposPruebasConsumo])
REFERENCES [dbo].[TiposPruebasConsumo] ([IdTipoPruebaConsumo])
GO
ALTER TABLE [dbo].[PrecioCache] NOCHECK CONSTRAINT [FK_PrecioCache_TiposPruebasConsumo]
GO
ALTER TABLE [dbo].[Productos]  WITH NOCHECK ADD  CONSTRAINT [FK_Productos_Familia] FOREIGN KEY([IdFamiliaProducto])
REFERENCES [dbo].[Familias] ([IdFamilia])
GO
ALTER TABLE [dbo].[Productos] NOCHECK CONSTRAINT [FK_Productos_Familia]
GO
ALTER TABLE [dbo].[Productos]  WITH NOCHECK ADD  CONSTRAINT [FK_Productos_Muestra] FOREIGN KEY([IdMuestra])
REFERENCES [dbo].[Muestras] ([IdMuestra])
GO
ALTER TABLE [dbo].[Productos] NOCHECK CONSTRAINT [FK_Productos_Muestra]
GO
ALTER TABLE [dbo].[Proveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_Proveedor_Actividad] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[Actividades] ([IdActividad])
GO
ALTER TABLE [dbo].[Proveedores] NOCHECK CONSTRAINT [FK_Proveedor_Actividad]
GO
ALTER TABLE [dbo].[Proveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_Proveedor_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[FormasPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[Proveedores] NOCHECK CONSTRAINT [FK_Proveedor_FormaPago]
GO
ALTER TABLE [dbo].[Proveedores]  WITH CHECK ADD  CONSTRAINT [FK_Proveedores_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[Proveedores] CHECK CONSTRAINT [FK_Proveedores_Direcciones]
GO
ALTER TABLE [dbo].[Recibos]  WITH NOCHECK ADD  CONSTRAINT [FK_Recibos_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[Recibos] NOCHECK CONSTRAINT [FK_Recibos_Cliente]
GO
ALTER TABLE [dbo].[Recibos]  WITH NOCHECK ADD  CONSTRAINT [FK_Recibos_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresas] ([IdEmpresa])
GO
ALTER TABLE [dbo].[Recibos] NOCHECK CONSTRAINT [FK_Recibos_Empresa]
GO
ALTER TABLE [dbo].[Recibos]  WITH NOCHECK ADD  CONSTRAINT [FK_Recibos_Factura] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[Facturas] ([IdFactura])
GO
ALTER TABLE [dbo].[Recibos] NOCHECK CONSTRAINT [FK_Recibos_Factura]
GO
ALTER TABLE [dbo].[Recibos]  WITH NOCHECK ADD  CONSTRAINT [FK_Recibos_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[FormasPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[Recibos] NOCHECK CONSTRAINT [FK_Recibos_FormaPago]
GO
ALTER TABLE [dbo].[Recibos]  WITH NOCHECK ADD  CONSTRAINT [FK_Recibos_Remesa] FOREIGN KEY([IdRemesa])
REFERENCES [dbo].[Remesas] ([IdRemesa])
GO
ALTER TABLE [dbo].[Recibos] NOCHECK CONSTRAINT [FK_Recibos_Remesa]
GO
ALTER TABLE [dbo].[Recibos]  WITH NOCHECK ADD  CONSTRAINT [FK_Recibos_Solicitantes] FOREIGN KEY([IdSolicitante])
REFERENCES [dbo].[Solicitantes] ([IdSolicitante])
GO
ALTER TABLE [dbo].[Recibos] NOCHECK CONSTRAINT [FK_Recibos_Solicitantes]
GO
ALTER TABLE [dbo].[RecibosPagos]  WITH NOCHECK ADD  CONSTRAINT [FK_RecibosPagos_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[FormasPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[RecibosPagos] NOCHECK CONSTRAINT [FK_RecibosPagos_FormaPago]
GO
ALTER TABLE [dbo].[RecibosPagos]  WITH NOCHECK ADD  CONSTRAINT [FK_RecibosPagos_Personal] FOREIGN KEY([IdPersonalRegistro])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[RecibosPagos] NOCHECK CONSTRAINT [FK_RecibosPagos_Personal]
GO
ALTER TABLE [dbo].[RecibosPagos]  WITH NOCHECK ADD  CONSTRAINT [FK_RecibosPagos_Recibo] FOREIGN KEY([IdRecibo])
REFERENCES [dbo].[Recibos] ([IdRecibo])
GO
ALTER TABLE [dbo].[RecibosPagos] NOCHECK CONSTRAINT [FK_RecibosPagos_Recibo]
GO
ALTER TABLE [dbo].[ReferenciaDetalles]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferenciaDetalles_Abogado] FOREIGN KEY([IdAbogado])
REFERENCES [dbo].[Abogados] ([IdAbogado])
GO
ALTER TABLE [dbo].[ReferenciaDetalles] NOCHECK CONSTRAINT [FK_ReferenciaDetalles_Abogado]
GO
ALTER TABLE [dbo].[ReferenciaDetalles]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferenciaDetalles_Base] FOREIGN KEY([IdReferenciaPaciente])
REFERENCES [dbo].[ReferenciasPaciente] ([IdReferenciaPaciente])
GO
ALTER TABLE [dbo].[ReferenciaDetalles] NOCHECK CONSTRAINT [FK_ReferenciaDetalles_Base]
GO
ALTER TABLE [dbo].[ReferenciaDetalles]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferenciaDetalles_Campania] FOREIGN KEY([IdCampaniaMarketing])
REFERENCES [dbo].[Campanias] ([IdCampaniaMarketing])
GO
ALTER TABLE [dbo].[ReferenciaDetalles] NOCHECK CONSTRAINT [FK_ReferenciaDetalles_Campania]
GO
ALTER TABLE [dbo].[ReferenciaDetalles]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferenciaDetalles_Lab] FOREIGN KEY([IdLaboratorioColaborador])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[ReferenciaDetalles] NOCHECK CONSTRAINT [FK_ReferenciaDetalles_Lab]
GO
ALTER TABLE [dbo].[ReferenciaDetalles]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferenciaDetalles_Medico] FOREIGN KEY([IdMedico])
REFERENCES [dbo].[Medicos] ([IdMedico])
GO
ALTER TABLE [dbo].[ReferenciaDetalles] NOCHECK CONSTRAINT [FK_ReferenciaDetalles_Medico]
GO
ALTER TABLE [dbo].[ReferenciasPaciente]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferenciasPaciente_Personal] FOREIGN KEY([IdPersonalRegistro])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[ReferenciasPaciente] NOCHECK CONSTRAINT [FK_ReferenciasPaciente_Personal]
GO
ALTER TABLE [dbo].[ReferenciasPaciente]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferenciasPaciente_Solicitantes] FOREIGN KEY([IdSolicitante])
REFERENCES [dbo].[Solicitantes] ([IdSolicitante])
GO
ALTER TABLE [dbo].[ReferenciasPaciente] NOCHECK CONSTRAINT [FK_ReferenciasPaciente_Solicitantes]
GO
ALTER TABLE [dbo].[ReferenciasPaciente]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferenciasPaciente_TipoReferencia] FOREIGN KEY([IdTipoReferencia])
REFERENCES [dbo].[TiposReferencia] ([IdTipoReferencia])
GO
ALTER TABLE [dbo].[ReferenciasPaciente] NOCHECK CONSTRAINT [FK_ReferenciasPaciente_TipoReferencia]
GO
ALTER TABLE [dbo].[Remesas]  WITH NOCHECK ADD  CONSTRAINT [FK_Remesas_Banco] FOREIGN KEY([IdBanco])
REFERENCES [dbo].[Bancos] ([IdBanco])
GO
ALTER TABLE [dbo].[Remesas] NOCHECK CONSTRAINT [FK_Remesas_Banco]
GO
ALTER TABLE [dbo].[ResultadosAndrologia]  WITH NOCHECK ADD FOREIGN KEY([IdLineaPeticion])
REFERENCES [dbo].[PeticionesLin] ([IdLineaPeticion])
GO
ALTER TABLE [dbo].[ResultadosAndrologia]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosAndrologia_Determinacion] FOREIGN KEY([IdDeterminacion])
REFERENCES [dbo].[CatalogoDeterminacionesAndrologia] ([IdDeterminacionCatalogo])
GO
ALTER TABLE [dbo].[ResultadosAndrologia] NOCHECK CONSTRAINT [FK_ResultadosAndrologia_Determinacion]
GO
ALTER TABLE [dbo].[ResultadosAndrologia]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosAndrologia_Documentos] FOREIGN KEY([IdDocumento])
REFERENCES [dbo].[Documentos] ([IdDocumento])
GO
ALTER TABLE [dbo].[ResultadosAndrologia] NOCHECK CONSTRAINT [FK_ResultadosAndrologia_Documentos]
GO
ALTER TABLE [dbo].[ResultadosAndrologia]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosAndrologia_Personal] FOREIGN KEY([IdPersonalRegistro])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[ResultadosAndrologia] NOCHECK CONSTRAINT [FK_ResultadosAndrologia_Personal]
GO
ALTER TABLE [dbo].[ResultadosAndrologia]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosAndrologia_Usuarios_ValidadoPor] FOREIGN KEY([ValidadoPor])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[ResultadosAndrologia] NOCHECK CONSTRAINT [FK_ResultadosAndrologia_Usuarios_ValidadoPor]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica]  WITH NOCHECK ADD FOREIGN KEY([IdLineaPeticion])
REFERENCES [dbo].[PeticionesLin] ([IdLineaPeticion])
GO
ALTER TABLE [dbo].[ResultadosCitogenetica]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosCitogenetica_Documentos] FOREIGN KEY([IdDocumento])
REFERENCES [dbo].[Documentos] ([IdDocumento])
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] NOCHECK CONSTRAINT [FK_ResultadosCitogenetica_Documentos]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosCitogenetica_Personal] FOREIGN KEY([IdPersonalRegistro])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] NOCHECK CONSTRAINT [FK_ResultadosCitogenetica_Personal]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosCitogenetica_Usuarios_ValidadoPor] FOREIGN KEY([ValidadoPor])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] NOCHECK CONSTRAINT [FK_ResultadosCitogenetica_Usuarios_ValidadoPor]
GO
ALTER TABLE [dbo].[ResultadosGenetica]  WITH NOCHECK ADD FOREIGN KEY([IdLineaPeticion])
REFERENCES [dbo].[PeticionesLin] ([IdLineaPeticion])
GO
ALTER TABLE [dbo].[ResultadosGenetica]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosGenetica_Documentos] FOREIGN KEY([IdDocumento])
REFERENCES [dbo].[Documentos] ([IdDocumento])
GO
ALTER TABLE [dbo].[ResultadosGenetica] NOCHECK CONSTRAINT [FK_ResultadosGenetica_Documentos]
GO
ALTER TABLE [dbo].[ResultadosGenetica]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosGenetica_Personal] FOREIGN KEY([IdPersonalRegistro])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[ResultadosGenetica] NOCHECK CONSTRAINT [FK_ResultadosGenetica_Personal]
GO
ALTER TABLE [dbo].[ResultadosGenetica]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosGenetica_Usuarios_ValidadoPor] FOREIGN KEY([ValidadoPor])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[ResultadosGenetica] NOCHECK CONSTRAINT [FK_ResultadosGenetica_Usuarios_ValidadoPor]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD FOREIGN KEY([IdLineaPeticion])
REFERENCES [dbo].[PeticionesLin] ([IdLineaPeticion])
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosParentesco_Documentos] FOREIGN KEY([IdDocumento])
REFERENCES [dbo].[Documentos] ([IdDocumento])
GO
ALTER TABLE [dbo].[ResultadosParentesco] NOCHECK CONSTRAINT [FK_ResultadosParentesco_Documentos]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosParentesco_Interviniente] FOREIGN KEY([IdInterviniente])
REFERENCES [dbo].[Intervinientes] ([IdInterviniente])
GO
ALTER TABLE [dbo].[ResultadosParentesco] NOCHECK CONSTRAINT [FK_ResultadosParentesco_Interviniente]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosParentesco_MarcadoresGeneticos] FOREIGN KEY([IdMarcador])
REFERENCES [dbo].[MarcadoresGeneticos] ([IdMarcador])
GO
ALTER TABLE [dbo].[ResultadosParentesco] NOCHECK CONSTRAINT [FK_ResultadosParentesco_MarcadoresGeneticos]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosParentesco_Personal] FOREIGN KEY([IdPersonalRegistro])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[ResultadosParentesco] NOCHECK CONSTRAINT [FK_ResultadosParentesco_Personal]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH CHECK ADD  CONSTRAINT [FK_ResultadosParentesco_Solicitudes] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[ResultadosParentesco] CHECK CONSTRAINT [FK_ResultadosParentesco_Solicitudes]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD  CONSTRAINT [FK_ResultadosParentesco_Usuarios_ValidadoPor] FOREIGN KEY([ValidadoPor])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[ResultadosParentesco] NOCHECK CONSTRAINT [FK_ResultadosParentesco_Usuarios_ValidadoPor]
GO
ALTER TABLE [dbo].[ResultadosPrueba]  WITH NOCHECK ADD FOREIGN KEY([IdLineaPeticion])
REFERENCES [dbo].[PeticionesLin] ([IdLineaPeticion])
GO
ALTER TABLE [dbo].[Solicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_Pacientes_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[FormasPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[Solicitantes] NOCHECK CONSTRAINT [FK_Pacientes_FormaPago]
GO
ALTER TABLE [dbo].[Solicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_Pacientes_Laboratorio] FOREIGN KEY([IdLaboratorioColaborador])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[Solicitantes] NOCHECK CONSTRAINT [FK_Pacientes_Laboratorio]
GO
ALTER TABLE [dbo].[Solicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_Pacientes_Medico] FOREIGN KEY([IdMedico])
REFERENCES [dbo].[Medicos] ([IdMedico])
GO
ALTER TABLE [dbo].[Solicitantes] NOCHECK CONSTRAINT [FK_Pacientes_Medico]
GO
ALTER TABLE [dbo].[Solicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_Pacientes_Tarifa] FOREIGN KEY([IdTarifa])
REFERENCES [dbo].[Tarifas] ([IdTarifa])
GO
ALTER TABLE [dbo].[Solicitantes] NOCHECK CONSTRAINT [FK_Pacientes_Tarifa]
GO
ALTER TABLE [dbo].[Solicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_Pacientes_TipoReferencia] FOREIGN KEY([IdTipoReferencia])
REFERENCES [dbo].[TiposReferencia] ([IdTipoReferencia])
GO
ALTER TABLE [dbo].[Solicitantes] NOCHECK CONSTRAINT [FK_Pacientes_TipoReferencia]
GO
ALTER TABLE [dbo].[Solicitantes]  WITH CHECK ADD  CONSTRAINT [FK_Solicitantes_Direcciones] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[Direcciones] ([IdDireccion])
GO
ALTER TABLE [dbo].[Solicitantes] CHECK CONSTRAINT [FK_Solicitantes_Direcciones]
GO
ALTER TABLE [dbo].[Solicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitantes_Idiomas] FOREIGN KEY([IdIdiomaPreferido])
REFERENCES [dbo].[Idiomas] ([IdIdioma])
GO
ALTER TABLE [dbo].[Solicitantes] NOCHECK CONSTRAINT [FK_Solicitantes_Idiomas]
GO
ALTER TABLE [dbo].[Solicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitantes_TiposDocumentos] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
GO
ALTER TABLE [dbo].[Solicitantes] NOCHECK CONSTRAINT [FK_Solicitantes_TiposDocumentos]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitudes_Estados] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estados] ([IdEstado])
GO
ALTER TABLE [dbo].[Solicitudes] NOCHECK CONSTRAINT [FK_Solicitudes_Estados]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitudes_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[FormasPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[Solicitudes] NOCHECK CONSTRAINT [FK_Solicitudes_FormaPago]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitudes_FormasEntrega] FOREIGN KEY([IdFormaEntrega])
REFERENCES [dbo].[FormasEntrega] ([IdFormaEntrega])
GO
ALTER TABLE [dbo].[Solicitudes] NOCHECK CONSTRAINT [FK_Solicitudes_FormasEntrega]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitudes_PlazosEntrega] FOREIGN KEY([IdPlazoEntrega])
REFERENCES [dbo].[PlazosEntrega] ([IdPlazoEntrega])
GO
ALTER TABLE [dbo].[Solicitudes] NOCHECK CONSTRAINT [FK_Solicitudes_PlazosEntrega]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitudes_Solicitantes] FOREIGN KEY([IdSolicitante])
REFERENCES [dbo].[Solicitantes] ([IdSolicitante])
GO
ALTER TABLE [dbo].[Solicitudes] NOCHECK CONSTRAINT [FK_Solicitudes_Solicitantes]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitudes_TipoMuestra] FOREIGN KEY([IdTipoMuestra])
REFERENCES [dbo].[TiposMuestra] ([IdTipoMuestra])
GO
ALTER TABLE [dbo].[Solicitudes] NOCHECK CONSTRAINT [FK_Solicitudes_TipoMuestra]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH NOCHECK ADD  CONSTRAINT [FK_Solicitudes_TipoPruebaConsumo] FOREIGN KEY([IdTipoPruebaConsumo])
REFERENCES [dbo].[TiposPruebasConsumo] ([IdTipoPruebaConsumo])
GO
ALTER TABLE [dbo].[Solicitudes] NOCHECK CONSTRAINT [FK_Solicitudes_TipoPruebaConsumo]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH CHECK ADD  CONSTRAINT [FK_Solicitudes_Usuarios_Creador] FOREIGN KEY([IdUsuarioCreador])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[Solicitudes] CHECK CONSTRAINT [FK_Solicitudes_Usuarios_Creador]
GO
ALTER TABLE [dbo].[SolicitudesSolicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_SolicitudesSolicitantes_Solicitantes] FOREIGN KEY([IdSolicitante])
REFERENCES [dbo].[Solicitantes] ([IdSolicitante])
GO
ALTER TABLE [dbo].[SolicitudesSolicitantes] NOCHECK CONSTRAINT [FK_SolicitudesSolicitantes_Solicitantes]
GO
ALTER TABLE [dbo].[SolicitudesSolicitantes]  WITH NOCHECK ADD  CONSTRAINT [FK_SolicitudesSolicitantes_Solicitudes] FOREIGN KEY([IdSolicitud])
REFERENCES [dbo].[Solicitudes] ([IdSolicitud])
GO
ALTER TABLE [dbo].[SolicitudesSolicitantes] NOCHECK CONSTRAINT [FK_SolicitudesSolicitantes_Solicitudes]
GO
ALTER TABLE [dbo].[TiposPruebasConsumo]  WITH NOCHECK ADD  CONSTRAINT [FK_TipoConsumo_TipoPrueba] FOREIGN KEY([IDTipoPrueba])
REFERENCES [dbo].[TiposPrueba] ([IdTipoPrueba])
GO
ALTER TABLE [dbo].[TiposPruebasConsumo] NOCHECK CONSTRAINT [FK_TipoConsumo_TipoPrueba]
GO
ALTER TABLE [dbo].[TiposPruebasConsumo]  WITH NOCHECK ADD  CONSTRAINT [FK_TiposPruebasConsumo_DudaParienteCercano] FOREIGN KEY([IdDudaParienteCercano])
REFERENCES [dbo].[DudaParienteCercano] ([IdDudaParienteCercano])
GO
ALTER TABLE [dbo].[TiposPruebasConsumo] NOCHECK CONSTRAINT [FK_TiposPruebasConsumo_DudaParienteCercano]
GO
ALTER TABLE [dbo].[TomasMuestra]  WITH NOCHECK ADD  CONSTRAINT [FK_TomasMuestra_Interviniente] FOREIGN KEY([IdInterviniente])
REFERENCES [dbo].[Intervinientes] ([IdInterviniente])
GO
ALTER TABLE [dbo].[TomasMuestra] NOCHECK CONSTRAINT [FK_TomasMuestra_Interviniente]
GO
ALTER TABLE [dbo].[TomasMuestra]  WITH NOCHECK ADD  CONSTRAINT [FK_TomasMuestra_LaboratorioColaborador] FOREIGN KEY([IdLugarToma])
REFERENCES [dbo].[LaboratoriosColaboradores] ([IdLaboratorioColaborador])
GO
ALTER TABLE [dbo].[TomasMuestra] NOCHECK CONSTRAINT [FK_TomasMuestra_LaboratorioColaborador]
GO
ALTER TABLE [dbo].[TomasMuestra]  WITH NOCHECK ADD  CONSTRAINT [FK_TomasMuestra_Muestra] FOREIGN KEY([IdMuestra])
REFERENCES [dbo].[Muestras] ([IdMuestra])
GO
ALTER TABLE [dbo].[TomasMuestra] NOCHECK CONSTRAINT [FK_TomasMuestra_Muestra]
GO
ALTER TABLE [dbo].[TomasMuestra]  WITH NOCHECK ADD  CONSTRAINT [FK_TomasMuestra_Personal] FOREIGN KEY([IdPersonalToma])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[TomasMuestra] NOCHECK CONSTRAINT [FK_TomasMuestra_Personal]
GO
ALTER TABLE [dbo].[TomasMuestra]  WITH NOCHECK ADD  CONSTRAINT [FK_TomasMuestra_Plantillas] FOREIGN KEY([IdPlantilla])
REFERENCES [dbo].[Plantillas] ([IdPlantilla])
GO
ALTER TABLE [dbo].[TomasMuestra] NOCHECK CONSTRAINT [FK_TomasMuestra_Plantillas]
GO
ALTER TABLE [dbo].[Usuarios]  WITH NOCHECK ADD  CONSTRAINT [FK_Usuarios_Personal] FOREIGN KEY([IdPersonal])
REFERENCES [dbo].[Personal] ([IdPersonal])
GO
ALTER TABLE [dbo].[Usuarios] NOCHECK CONSTRAINT [FK_Usuarios_Personal]
GO
ALTER TABLE [dbo].[Usuarios]  WITH NOCHECK ADD  CONSTRAINT [FK_Usuarios_Rol] FOREIGN KEY([IdRol])
REFERENCES [dbo].[Roles] ([IdRol])
GO
ALTER TABLE [dbo].[Usuarios] NOCHECK CONSTRAINT [FK_Usuarios_Rol]
GO
ALTER TABLE [dbo].[UsuariosPortal]  WITH NOCHECK ADD  CONSTRAINT [FK_UsuariosPortal_Roles] FOREIGN KEY([IdRol])
REFERENCES [dbo].[Roles] ([IdRol])
GO
ALTER TABLE [dbo].[UsuariosPortal] NOCHECK CONSTRAINT [FK_UsuariosPortal_Roles]
GO
ALTER TABLE [dbo].[UsuariosPortal]  WITH CHECK ADD  CONSTRAINT [FK_UsuariosPortal_TiposEntidad] FOREIGN KEY([IdTipoEntidad])
REFERENCES [dbo].[TiposEntidad] ([IdEntidadTipo])
GO
ALTER TABLE [dbo].[UsuariosPortal] CHECK CONSTRAINT [FK_UsuariosPortal_TiposEntidad]
GO
ALTER TABLE [dbo].[ValidacionesResultado]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidacionesResultado_Usuarios] FOREIGN KEY([IdUsuarioValidador])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[ValidacionesResultado] NOCHECK CONSTRAINT [FK_ValidacionesResultado_Usuarios]
GO
ALTER TABLE [dbo].[Acreditaciones]  WITH NOCHECK ADD  CONSTRAINT [CHK_Acreditaciones_Estado] CHECK  (([Estado]='En Proceso' OR [Estado]='Expirada' OR [Estado]='Vigente'))
GO
ALTER TABLE [dbo].[Acreditaciones] NOCHECK CONSTRAINT [CHK_Acreditaciones_Estado]
GO
ALTER TABLE [dbo].[AuditoriasCalidad]  WITH NOCHECK ADD  CONSTRAINT [CHK_AuditoriasCalidad_Resultado] CHECK  (([Resultado]='Pendiente' OR [Resultado]='No Conforme' OR [Resultado]='Conforme'))
GO
ALTER TABLE [dbo].[AuditoriasCalidad] NOCHECK CONSTRAINT [CHK_AuditoriasCalidad_Resultado]
GO
ALTER TABLE [dbo].[AuditoriasCalidad]  WITH NOCHECK ADD  CONSTRAINT [CHK_AuditoriasCalidad_Tipo] CHECK  (([TipoAuditoria]='Externa' OR [TipoAuditoria]='Interna'))
GO
ALTER TABLE [dbo].[AuditoriasCalidad] NOCHECK CONSTRAINT [CHK_AuditoriasCalidad_Tipo]
GO
ALTER TABLE [dbo].[ConfigValidaciones]  WITH NOCHECK ADD  CONSTRAINT [CHK_ConfigValidaciones_TipoResultado] CHECK  (([TipoResultado]='Andrologia' OR [TipoResultado]='Citogenetica' OR [TipoResultado]='Genetica' OR [TipoResultado]='Parentesco'))
GO
ALTER TABLE [dbo].[ConfigValidaciones] NOCHECK CONSTRAINT [CHK_ConfigValidaciones_TipoResultado]
GO
ALTER TABLE [dbo].[Consentimientos]  WITH NOCHECK ADD  CONSTRAINT [CK_Consentimientos_Estado] CHECK  (([EstadoConsentimiento]='Cancelado' OR [EstadoConsentimiento]='Rechazado' OR [EstadoConsentimiento]='Firmado' OR [EstadoConsentimiento]='Pendiente'))
GO
ALTER TABLE [dbo].[Consentimientos] NOCHECK CONSTRAINT [CK_Consentimientos_Estado]
GO
ALTER TABLE [dbo].[Direcciones]  WITH NOCHECK ADD  CONSTRAINT [CHK_Direcciones_LocalizacionValida] CHECK  (([CodigoPais]='ES' AND [CodigoProvincia] IS NOT NULL AND [CodigoMunicipio] IS NOT NULL AND [CodigoPostal] IS NOT NULL OR [CodigoPais]<>'ES' AND [ProvinciaTexto] IS NOT NULL AND [MunicipioTexto] IS NOT NULL AND [CodigoPostalTexto] IS NOT NULL AND [CodigoProvincia] IS NULL AND [CodigoMunicipio] IS NULL AND [CodigoPostal] IS NULL))
GO
ALTER TABLE [dbo].[Direcciones] NOCHECK CONSTRAINT [CHK_Direcciones_LocalizacionValida]
GO
ALTER TABLE [dbo].[Direcciones]  WITH NOCHECK ADD  CONSTRAINT [CHK_Direcciones_Valida] CHECK  (([CodigoPais]='ES' AND [CodigoProvincia] IS NOT NULL AND [CodigoMunicipio] IS NOT NULL AND [CodigoPostal] IS NOT NULL AND [ProvinciaTexto] IS NULL AND [MunicipioTexto] IS NULL AND [CodigoPostalTexto] IS NULL OR [CodigoPais]<>'ES' AND [ProvinciaTexto] IS NOT NULL AND [MunicipioTexto] IS NOT NULL AND [CodigoPostalTexto] IS NOT NULL AND [CodigoProvincia] IS NULL AND [CodigoMunicipio] IS NULL AND [CodigoPostal] IS NULL))
GO
ALTER TABLE [dbo].[Direcciones] NOCHECK CONSTRAINT [CHK_Direcciones_Valida]
GO
ALTER TABLE [dbo].[EntidadMetadata]  WITH NOCHECK ADD  CONSTRAINT [CHK_TipoEntidad_Metadata] CHECK  (([TipoEntidad]='Medico' OR [TipoEntidad]='Empresa' OR [TipoEntidad]='Solicitante' OR [TipoEntidad]='Laboratorio'))
GO
ALTER TABLE [dbo].[EntidadMetadata] NOCHECK CONSTRAINT [CHK_TipoEntidad_Metadata]
GO
ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [CHK_Facturas_EstadoFactura] CHECK  (([EstadoFactura]='Anulada' OR [EstadoFactura]='Pagada' OR [EstadoFactura]='Pendiente' OR [EstadoFactura] IS NULL))
GO
ALTER TABLE [dbo].[Facturas] NOCHECK CONSTRAINT [CHK_Facturas_EstadoFactura]
GO
ALTER TABLE [dbo].[IndiceParentesco]  WITH NOCHECK ADD  CONSTRAINT [CHK_IndiceParentesco_Resultado] CHECK  (([Resultado]=NULL OR [Resultado]='Inconcluso' OR [Resultado]='No compatible' OR [Resultado]='Compatible'))
GO
ALTER TABLE [dbo].[IndiceParentesco] NOCHECK CONSTRAINT [CHK_IndiceParentesco_Resultado]
GO
ALTER TABLE [dbo].[IndiceParentesco]  WITH NOCHECK ADD  CONSTRAINT [CHK_IndiceParentesco_TipoRelacion] CHECK  (([TipoRelacion]='Otros' OR [TipoRelacion]='Abuelo-Nieto' OR [TipoRelacion]='Hermanos' OR [TipoRelacion]='Madre-Hijo' OR [TipoRelacion]='Padre-Hijo'))
GO
ALTER TABLE [dbo].[IndiceParentesco] NOCHECK CONSTRAINT [CHK_IndiceParentesco_TipoRelacion]
GO
ALTER TABLE [dbo].[Intervinientes]  WITH NOCHECK ADD CHECK  (([Sexo]='F' OR [Sexo]='M'))
GO
ALTER TABLE [dbo].[Notas]  WITH NOCHECK ADD  CONSTRAINT [CHK_TipoEntidad] CHECK  (([TipoEntidad]='Direccion' OR [TipoEntidad]='Medico' OR [TipoEntidad]='Empresa' OR [TipoEntidad]='Solicitante' OR [TipoEntidad]='Laboratorio'))
GO
ALTER TABLE [dbo].[Notas] NOCHECK CONSTRAINT [CHK_TipoEntidad]
GO
ALTER TABLE [dbo].[Notas]  WITH NOCHECK ADD  CONSTRAINT [CHK_TipoNota] CHECK  (([TipoNota]='Normalizacion' OR [TipoNota]='Internas' OR [TipoNota]='Facturacion' OR [TipoNota]='Admon' OR [TipoNota]='Tecnico'))
GO
ALTER TABLE [dbo].[Notas] NOCHECK CONSTRAINT [CHK_TipoNota]
GO
ALTER TABLE [dbo].[NotificacionesSMS]  WITH NOCHECK ADD  CONSTRAINT [CHK_NotificacionesSMS_Estado] CHECK  (([Estado]='Pendiente' OR [Estado]='Fallido' OR [Estado]='Enviado'))
GO
ALTER TABLE [dbo].[NotificacionesSMS] NOCHECK CONSTRAINT [CHK_NotificacionesSMS_Estado]
GO
ALTER TABLE [dbo].[PermisosDocumento]  WITH NOCHECK ADD  CONSTRAINT [CHK_PermisosDocumento_Permiso] CHECK  (([Permiso]='Eliminar' OR [Permiso]='Editar' OR [Permiso]='Leer'))
GO
ALTER TABLE [dbo].[PermisosDocumento] NOCHECK CONSTRAINT [CHK_PermisosDocumento_Permiso]
GO
ALTER TABLE [dbo].[PeticionesLin]  WITH NOCHECK ADD  CONSTRAINT [CHK_PeticionesLin_EstadoResultado] CHECK  (([EstadoResultado]='Rechazado' OR [EstadoResultado]='Completado' OR [EstadoResultado]='En Proceso'))
GO
ALTER TABLE [dbo].[PeticionesLin] NOCHECK CONSTRAINT [CHK_PeticionesLin_EstadoResultado]
GO
ALTER TABLE [dbo].[PlantillasNotificacion]  WITH NOCHECK ADD  CONSTRAINT [CHK_PlantillasNotificacion_Canal] CHECK  (([Canal]='SMS' OR [Canal]='Email'))
GO
ALTER TABLE [dbo].[PlantillasNotificacion] NOCHECK CONSTRAINT [CHK_PlantillasNotificacion_Canal]
GO
ALTER TABLE [dbo].[ResultadosAndrologia]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosAndrologia_EstadoValidacion] CHECK  (([EstadoValidacion]='RechazadoPorTecnico' OR [EstadoValidacion]='AprobadoPorTecnico' OR [EstadoValidacion]='Pendiente'))
GO
ALTER TABLE [dbo].[ResultadosAndrologia] NOCHECK CONSTRAINT [CHK_ResultadosAndrologia_EstadoValidacion]
GO
ALTER TABLE [dbo].[ResultadosAndrologia]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosAndrologia_EstadoValidacionFinal] CHECK  (([EstadoValidacionFinal]='Rechazado' OR [EstadoValidacionFinal]='Aprobado' OR [EstadoValidacionFinal]='Pendiente'))
GO
ALTER TABLE [dbo].[ResultadosAndrologia] NOCHECK CONSTRAINT [CHK_ResultadosAndrologia_EstadoValidacionFinal]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosCitogenetica_EstadoValidacion] CHECK  (([EstadoValidacion]='RechazadoPorTecnico' OR [EstadoValidacion]='AprobadoPorTecnico' OR [EstadoValidacion]='Pendiente'))
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] NOCHECK CONSTRAINT [CHK_ResultadosCitogenetica_EstadoValidacion]
GO
ALTER TABLE [dbo].[ResultadosCitogenetica]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosCitogenetica_EstadoValidacionFinal] CHECK  (([EstadoValidacionFinal]='Rechazado' OR [EstadoValidacionFinal]='Aprobado' OR [EstadoValidacionFinal]='Pendiente'))
GO
ALTER TABLE [dbo].[ResultadosCitogenetica] NOCHECK CONSTRAINT [CHK_ResultadosCitogenetica_EstadoValidacionFinal]
GO
ALTER TABLE [dbo].[ResultadosGenetica]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosGenetica_EstadoValidacion] CHECK  (([EstadoValidacion]='RechazadoPorTecnico' OR [EstadoValidacion]='AprobadoPorTecnico' OR [EstadoValidacion]='Pendiente'))
GO
ALTER TABLE [dbo].[ResultadosGenetica] NOCHECK CONSTRAINT [CHK_ResultadosGenetica_EstadoValidacion]
GO
ALTER TABLE [dbo].[ResultadosGenetica]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosGenetica_EstadoValidacionFinal] CHECK  (([EstadoValidacionFinal]='Rechazado' OR [EstadoValidacionFinal]='Aprobado' OR [EstadoValidacionFinal]='Pendiente'))
GO
ALTER TABLE [dbo].[ResultadosGenetica] NOCHECK CONSTRAINT [CHK_ResultadosGenetica_EstadoValidacionFinal]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosParentesco_Alelos] CHECK  (([Alelo1] IS NULL OR [Alelo1] like '[0-9]+' OR [Alelo1] like '[0-9]+.[0-9]' AND [Alelo2] IS NULL OR [Alelo2] like '[0-9]+' OR [Alelo2] like '[0-9]+.[0-9]'))
GO
ALTER TABLE [dbo].[ResultadosParentesco] NOCHECK CONSTRAINT [CHK_ResultadosParentesco_Alelos]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosParentesco_EstadoValidacion] CHECK  (([EstadoValidacion]='RechazadoPorTecnico' OR [EstadoValidacion]='AprobadoPorTecnico' OR [EstadoValidacion]='Pendiente'))
GO
ALTER TABLE [dbo].[ResultadosParentesco] NOCHECK CONSTRAINT [CHK_ResultadosParentesco_EstadoValidacion]
GO
ALTER TABLE [dbo].[ResultadosParentesco]  WITH NOCHECK ADD  CONSTRAINT [CHK_ResultadosParentesco_EstadoValidacionFinal] CHECK  (([EstadoValidacionFinal]='Rechazado' OR [EstadoValidacionFinal]='Aprobado' OR [EstadoValidacionFinal]='Pendiente'))
GO
ALTER TABLE [dbo].[ResultadosParentesco] NOCHECK CONSTRAINT [CHK_ResultadosParentesco_EstadoValidacionFinal]
GO
ALTER TABLE [dbo].[Solicitantes]  WITH NOCHECK ADD  CONSTRAINT [CK_Solicitantes_Sexo] CHECK  (([Sexo]='F' OR [Sexo]='M'))
GO
ALTER TABLE [dbo].[Solicitantes] NOCHECK CONSTRAINT [CK_Solicitantes_Sexo]
GO
ALTER TABLE [dbo].[Solicitudes]  WITH NOCHECK ADD  CONSTRAINT [CHK_Solicitudes_EstadoResultados] CHECK  (([EstadoResultados]='Completado' OR [EstadoResultados]='Parcial' OR [EstadoResultados]='Pendiente'))
GO
ALTER TABLE [dbo].[Solicitudes] NOCHECK CONSTRAINT [CHK_Solicitudes_EstadoResultados]
GO
ALTER TABLE [dbo].[ValidacionesResultado]  WITH NOCHECK ADD  CONSTRAINT [CHK_ValidacionesResultado_Estado] CHECK  (([EstadoValidacion]='Pendiente' OR [EstadoValidacion]='Rechazado' OR [EstadoValidacion]='Validado'))
GO
ALTER TABLE [dbo].[ValidacionesResultado] NOCHECK CONSTRAINT [CHK_ValidacionesResultado_Estado]
GO
ALTER TABLE [dbo].[ValidacionesResultado]  WITH NOCHECK ADD  CONSTRAINT [CHK_ValidacionesResultado_Tipo] CHECK  (([TipoResultado]='Andrologia' OR [TipoResultado]='Citogenetica' OR [TipoResultado]='Genetica' OR [TipoResultado]='Parentesco'))
GO
ALTER TABLE [dbo].[ValidacionesResultado] NOCHECK CONSTRAINT [CHK_ValidacionesResultado_Tipo]
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcularIndiceParentesco]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_CalcularIndiceParentesco]
    @IdSolicitud INT,
    @TipoRelacion VARCHAR(50),
    @IdPerfilGenetico1 INT,
    @IdPerfilGenetico2 INT,
    @IdUsuarioAnalista INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar parámetros
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud)
        THROW 50001, 'La solicitud especificada no existe.', 1;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[PerfilesGeneticos] WHERE IdPerfilGenetico = @IdPerfilGenetico1)
        THROW 50002, 'El primer perfil genético no existe.', 1;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[PerfilesGeneticos] WHERE IdPerfilGenetico = @IdPerfilGenetico2)
        THROW 50003, 'El segundo perfil genético no existe.', 1;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuarioAnalista)
        THROW 50004, 'El usuario analista no existe.', 1;

    -- Validar muestras
    EXEC [dbo].[sp_ValidarMuestrasSolicitud] @IdSolicitud;

    -- Validar consentimiento
    EXEC [dbo].[sp_ValidarConsentimientoSolicitud] @IdSolicitud;

    -- Validar caso forense si aplica
    IF EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud AND EsForense = 1)
        EXEC [dbo].[sp_ValidarCasoForense] @IdSolicitud;

    -- Validar número mínimo de marcadores (24 marcadores)
    EXEC [dbo].[sp_ValidarMinimoMarcadores] @IdSolicitud, 24;

    -- Declarar variables para cálculos
    DECLARE @CPI DECIMAL(18,6) = 1.0;
    DECLARE @LR DECIMAL(18,6) = 1.0;
    DECLARE @Probabilidad DECIMAL(5,2) = 95.00;
    DECLARE @Marcadores NVARCHAR(MAX) = '[';
    DECLARE @NumMarcadores INT = 0;
    DECLARE @Resultado VARCHAR(100) = 'Inconcluso';

    -- Obtener intervinientes asociados a los perfiles
    DECLARE @IdInterviniente1 INT, @IdInterviniente2 INT;
    SELECT @IdInterviniente1 = IdInterviniente FROM [dbo].[PerfilesGeneticos] WHERE IdPerfilGenetico = @IdPerfilGenetico1;
    SELECT @IdInterviniente2 = IdInterviniente FROM [dbo].[PerfilesGeneticos] WHERE IdPerfilGenetico = @IdPerfilGenetico2;

    -- Obtener marcadores genéticos para ambos intervinientes
    DECLARE @MarcadoresTabla TABLE (
        NombreMarcador NVARCHAR(100),
        Alelo1_1 NVARCHAR(50),
        Alelo2_1 NVARCHAR(50),
        Alelo1_2 NVARCHAR(50),
        Alelo2_2 NVARCHAR(50)
    );

    INSERT INTO @MarcadoresTabla
    SELECT 
        mg.NombreMarcador,
        rp1.Alelo1 AS Alelo1_1,
        rp1.Alelo2 AS Alelo2_1,
        rp2.Alelo1 AS Alelo1_2,
        rp2.Alelo2 AS Alelo2_2
    FROM [dbo].[ResultadosParentesco] rp1
    JOIN [dbo].[ResultadosParentesco] rp2 ON rp1.IdMarcador = rp2.IdMarcador
    JOIN [dbo].[MarcadoresGeneticos] mg ON rp1.IdMarcador = mg.IdMarcador
    JOIN [dbo].[PeticionesLin] pl ON rp1.IdLineaPeticion = pl.IdLineaPeticion
    JOIN [dbo].[Peticiones] p ON pl.IdPeticion = p.IdPeticion
    WHERE rp1.IdInterviniente = @IdInterviniente1
      AND rp2.IdInterviniente = @IdInterviniente2
      AND p.IdSolicitud = @IdSolicitud;

    -- Contar marcadores
    SELECT @NumMarcadores = COUNT(*) FROM @MarcadoresTabla;

    -- Calcular CPI y LR
    DECLARE @Coincidencias INT = 0;
    SELECT @Coincidencias = COUNT(*)
    FROM @MarcadoresTabla
    WHERE (Alelo1_1 = Alelo1_2 OR Alelo1_1 = Alelo2_2 OR Alelo2_1 = Alelo1_2 OR Alelo2_1 = Alelo2_2);

    SET @CPI = POWER(10.0, @Coincidencias);
    SET @LR = @CPI * 100;
    IF @Coincidencias >= @NumMarcadores * 0.9
        SET @Resultado = 'Compatible';
    ELSE IF @Coincidencias < @NumMarcadores * 0.5
        SET @Resultado = 'No compatible';

    -- Construir lista de marcadores en JSON
    SELECT @Marcadores = @Marcadores + '{"Marcador":"' + NombreMarcador + '","Alelos1":"' + Alelo1_1 + ',' + Alelo2_1 + '","Alelos2":"' + Alelo1_2 + ',' + Alelo2_2 + '"},'
    FROM @MarcadoresTabla;
    SET @Marcadores = LEFT(@Marcadores, LEN(@Marcadores) - 1) + ']';
    IF @NumMarcadores = 0 SET @Marcadores = '[]';

    -- Insertar en IndiceParentesco
    INSERT INTO [dbo].[IndiceParentesco] (
        IdSolicitud,
        IdPerfilGenetico1,
        IdPerfilGenetico2,
        TipoRelacion,
        IndiceCombinadoParentesco,
        LikelihoodRatio,
        ProbabilidadParentesco,
        MarcadoresGeneticos,
        NumeroMarcadores,
        Resultado,
        Observaciones,
        FechaAnalisis,
        IdUsuarioAnalista,
        Estado
    )
    VALUES (
        @IdSolicitud,
        @IdPerfilGenetico1,
        @IdPerfilGenetico2,
        @TipoRelacion,
        @CPI,
        @LR,
        @Probabilidad,
        @Marcadores,
        @NumMarcadores,
        @Resultado,
        'Cálculo basado en comparación de alelos de ResultadosParentesco',
        GETDATE(),
        @IdUsuarioAnalista,
        'Activo'
    );

    SELECT SCOPE_IDENTITY() AS IdIndiceParentesco;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcularPrecioPrueba]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CalcularPrecioPrueba]
    @IdTipoPruebaConsumo INT,
    @IdTipoMuestra INT,
    @NumMuestras INT,
    @NumIntervinientes INT,
    @EsLegal BIT,
    @EsColaborador BIT,
    @IdPlazoEntrega INT,
    @PrecioTotal DECIMAL(10,2) OUTPUT,
    @IdConfiguracion INT OUTPUT,
    @MensajeError NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Inicializar variables
    SET @PrecioTotal = 0;
    SET @IdConfiguracion = NULL;
    SET @MensajeError = NULL;

    BEGIN TRY
        -- Validar parámetros de entrada
        IF @IdTipoPruebaConsumo <= 0
            THROW 50001, 'El IdTipoPruebaConsumo debe ser mayor que cero.', 1;
        IF @IdTipoMuestra <= 0
            THROW 50002, 'El IdTipoMuestra debe ser mayor que cero.', 1;
        IF @NumMuestras < 0
            THROW 50003, 'El número de muestras no puede ser negativo.', 1;
        IF @NumIntervinientes < 0
            THROW 50004, 'El número de intervinientes no puede ser negativo.', 1;
        IF @IdPlazoEntrega <= 0
            THROW 50005, 'El IdPlazoEntrega debe ser mayor que cero.', 1;

        -- Verificar existencia de tipo de prueba
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TiposPruebasConsumo] WHERE IdTipoPruebaConsumo = @IdTipoPruebaConsumo AND Activo = 1)
            THROW 50006, 'El tipo de prueba especificado no existe o no está activo.', 1;

        -- Verificar existencia de tipo de muestra
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TiposMuestra] WHERE IdTipoMuestra = @IdTipoMuestra)
            THROW 50007, 'El tipo de muestra especificado no existe.', 1;

        -- Verificar existencia de plazo de entrega
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PlazosEntrega] WHERE IdPlazoEntrega = @IdPlazoEntrega)
            THROW 50008, 'El plazo de entrega especificado no existe.', 1;

        -- Declarar variables para cálculos
        DECLARE 
            @PrecioBase DECIMAL(10,2) = 0,
            @PrecioPorInterviniente DECIMAL(10,2) = 0,
            @PrecioPorMuestra DECIMAL(10,2) = 0,
            @CosteFijoMuestra DECIMAL(10,2) = 0,
            @IncrementoPlazo DECIMAL(10,2) = 0,
            @IncrementoIntervinientes DECIMAL(10,2) = 0,
            @PorcentajeLegal DECIMAL(5,2) = 0,
            @PorcentajeColaborador DECIMAL(5,2) = 0,
            @PorcentajeMuestraLegal DECIMAL(5,2) = 0,
            @IdRegla INT = NULL;

        -- Obtener configuración de precio
        SELECT TOP 1
            @PrecioBase = ISNULL(cp.PrecioBase, 0),
            @IdRegla = cp.IdRegla,
            @IdConfiguracion = cp.IdConfiguracion
        FROM [dbo].[ConfiguracionesPrecio] cp
        WHERE cp.IdTiposPruebasConsumo = @IdTipoPruebaConsumo
          AND cp.EsLegal = @EsLegal
          AND cp.EsColaborador = @EsColaborador;

        IF @IdConfiguracion IS NULL
        BEGIN
            SET @MensajeError = 'No se encontró configuración de precio para los parámetros especificados.';
            RETURN;
        END

        -- Obtener reglas de incremento
        SELECT 
            @PorcentajeLegal = ISNULL(PorcentajeIntervinienteLegal, 0),
            @PorcentajeMuestraLegal = ISNULL(PorcentajeMuestraLegal, 0),
            @PorcentajeColaborador = ISNULL(PorcentajeColaborador, 0)
        FROM [dbo].[ReglasIncrementoPrecio]
        WHERE IdRegla = @IdRegla;

        -- Obtener precios base por interviniente y muestra
        SELECT TOP 1
            @PrecioPorInterviniente = ISNULL(PrecioPorInterviniente, 0),
            @PrecioPorMuestra = ISNULL(PrecioPorMuestra, 0)
        FROM [dbo].[TarifasBase];

        -- Obtener coste fijo de la muestra
        SELECT @CosteFijoMuestra = ISNULL(CosteFijo, 0)
        FROM [dbo].[TiposMuestra]
        WHERE IdTipoMuestra = @IdTipoMuestra;

        -- Obtener incremento por plazo de entrega
        SELECT @IncrementoPlazo = ISNULL(IncrementoFijo, 0)
        FROM [dbo].[PlazosEntrega]
        WHERE IdPlazoEntrega = @IdPlazoEntrega;

        -- Obtener incremento por número de intervinientes
        SELECT @IncrementoIntervinientes = ISNULL(IncrementoFijo, 0)
        FROM [dbo].[IncrementosIntervinientes]
        WHERE NumIntervinientes = @NumIntervinientes;

        -- Calcular precio base
        SET @PrecioTotal = 
            @PrecioBase +
            (@NumIntervinientes * @PrecioPorInterviniente) +
            (@NumMuestras * (@PrecioPorMuestra + @CosteFijoMuestra)) +
            @IncrementoPlazo +
            @IncrementoIntervinientes;

        -- Aplicar incrementos por legalidad
        IF @EsLegal = 1
        BEGIN
            SET @PrecioTotal += (@PrecioTotal * @PorcentajeLegal / 100.0);
            SET @PrecioTotal += (@NumMuestras * @PrecioPorMuestra * @PorcentajeMuestraLegal / 100.0);
        END

        -- Aplicar incremento por colaborador
        IF @EsColaborador = 1
            SET @PrecioTotal += (@PrecioTotal * @PorcentajeColaborador / 100.0);

        -- Redondear el precio total
        SET @PrecioTotal = ROUND(@PrecioTotal, 2);

        -- Actualizar caché de precios
        IF EXISTS (SELECT 1 FROM [dbo].[PrecioCache] WHERE IdTiposPruebasConsumo = @IdTipoPruebaConsumo AND EsLegal = @EsLegal AND EsColaborador = @EsColaborador)
        BEGIN
            UPDATE [dbo].[PrecioCache]
            SET PrecioBase = @PrecioTotal,
                FechaActualizacion = GETDATE()
            WHERE IdTiposPruebasConsumo = @IdTipoPruebaConsumo
              AND EsLegal = @EsLegal
              AND EsColaborador = @EsColaborador;
        END
        ELSE
        BEGIN
            INSERT INTO [dbo].[PrecioCache] (
                IdTiposPruebasConsumo, EsLegal, EsColaborador, PrecioBase, IdRegla, FechaActualizacion
            )
            VALUES (
                @IdTipoPruebaConsumo, @EsLegal, @EsColaborador, @PrecioTotal, @IdRegla, GETDATE()
            );
        END
    END TRY
    BEGIN CATCH
        SET @MensajeError = ERROR_MESSAGE();
        SET @PrecioTotal = 0;
        SET @IdConfiguracion = NULL;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcularPrecioPruebaCorrecto]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CalcularPrecioPruebaCorrecto]
    @IdTipoPruebaConsumo INT,
    @IdTipoMuestra INT,
    @NumMuestras INT,
    @NumIntervinientes INT,
    @EsLegal BIT,
    @EsColaborador BIT,
    @IdPlazoEntrega INT,
    @PrecioTotal DECIMAL(10,2) OUTPUT,
    @IdConfiguracion INT OUTPUT,
    @MensajeError NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Inicializar variables
    SET @PrecioTotal = 0;
    SET @IdConfiguracion = NULL;
    SET @MensajeError = NULL;

    BEGIN TRY
        -- Validar parámetros de entrada
        IF @IdTipoPruebaConsumo <= 0
            THROW 50001, 'El IdTipoPruebaConsumo debe ser mayor que cero.', 1;
        IF @IdTipoMuestra <= 0
            THROW 50002, 'El IdTipoMuestra debe ser mayor que cero.', 1;
        IF @NumMuestras < 0
            THROW 50003, 'El número de muestras no puede ser negativo.', 1;
        IF @NumIntervinientes < 0
            THROW 50004, 'El número de intervinientes no puede ser negativo.', 1;
        IF @IdPlazoEntrega <= 0
            THROW 50005, 'El IdPlazoEntrega debe ser mayor que cero.', 1;
        IF @NumMuestras < @NumIntervinientes
            THROW 50006, 'El número de muestras debe ser al menos igual al número de intervinientes.', 1;

        -- Verificar existencia de tipo de prueba
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TiposPruebasConsumo] WHERE IdTipoPruebaConsumo = @IdTipoPruebaConsumo AND Activo = 1)
            THROW 50007, 'El tipo de prueba especificado no existe o no está activo.', 1;

        -- Verificar existencia de tipo de muestra
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TiposMuestra] WHERE IdTipoMuestra = @IdTipoMuestra)
            THROW 50008, 'El tipo de muestra especificado no existe.', 1;

        -- Verificar existencia de plazo de entrega
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PlazosEntrega] WHERE IdPlazoEntrega = @IdPlazoEntrega)
            THROW 50009, 'El plazo de entrega especificado no existe.', 1;

        -- Declarar variables para cálculos
        DECLARE 
            @PrecioBase DECIMAL(10,2) = 0,
            @PrecioPorInterviniente DECIMAL(10,2) = 0,
            @CosteFijoMuestra DECIMAL(10,2) = 0,
            @IncrementoPlazo DECIMAL(10,2) = 0,
            @IncrementoIntervinientes DECIMAL(10,2) = 0,
            @PorcentajeLegal DECIMAL(5,2) = 0,
            @PorcentajeMuestraLegal DECIMAL(5,2) = 0,
            @PorcentajeColaborador DECIMAL(5,2) = 0,
            @IdRegla INT = NULL,
            @NumMuestrasExtras INT = 0;

        -- Obtener configuración de precio
        SELECT TOP 1
            @PrecioBase = ISNULL(cp.PrecioBase, 0),
            @IdRegla = cp.IdRegla,
            @IdConfiguracion = cp.IdConfiguracion
        FROM [dbo].[ConfiguracionesPrecio] cp
        WHERE cp.IdTiposPruebasConsumo = @IdTipoPruebaConsumo
          AND cp.EsLegal = @EsLegal
          AND cp.EsColaborador = @EsColaborador;

        IF @IdConfiguracion IS NULL
        BEGIN
            SET @MensajeError = 'No se encontró configuración de precio para los parámetros especificados.';
            SET @PrecioTotal = 0;
            RETURN;
        END

        -- Obtener reglas de incremento
        SELECT 
            @PorcentajeLegal = ISNULL(PorcentajeIntervinienteLegal, 0),
            @PorcentajeMuestraLegal = ISNULL(PorcentajeMuestraLegal, 0),
            @PorcentajeColaborador = ISNULL(PorcentajeColaborador, 0)
        FROM [dbo].[ReglasIncrementoPrecio]
        WHERE IdRegla = @IdRegla;

        -- Obtener precio por interviniente según legalidad
        SELECT TOP 1
            @PrecioPorInterviniente = ISNULL(PrecioPorInterviniente, 0)
        FROM [dbo].[TarifasBase]
        WHERE IdTarifa = CASE WHEN @EsLegal = 1 THEN 2 ELSE 1 END;

        -- Obtener coste fijo de la muestra
        SELECT @CosteFijoMuestra = ISNULL(CosteFijo, 0)
        FROM [dbo].[TiposMuestra]
        WHERE IdTipoMuestra = @IdTipoMuestra;

        -- Obtener incremento por plazo de entrega
        SELECT @IncrementoPlazo = ISNULL(IncrementoFijo, 0)
        FROM [dbo].[PlazosEntrega]
        WHERE IdPlazoEntrega = @IdPlazoEntrega;

        -- Obtener incremento por número de intervinientes
        SELECT @IncrementoIntervinientes = ISNULL(IncrementoFijo, 0)
        FROM [dbo].[IncrementosIntervinientes]
        WHERE NumIntervinientes = @NumIntervinientes;

        -- Determinar muestras extras
        SET @NumMuestrasExtras = @NumMuestras - @NumIntervinientes;
        IF @NumMuestrasExtras < 0 SET @NumMuestrasExtras = 0;

        -- Calcular precio base
        SET @PrecioTotal = 
            @PrecioBase +
            (@NumIntervinientes * @PrecioPorInterviniente) +
            (@NumMuestrasExtras * @CosteFijoMuestra) +
            @IncrementoPlazo +
            @IncrementoIntervinientes;

        -- Aplicar incrementos por legalidad
        IF @EsLegal = 1
        BEGIN
            SET @PrecioTotal += (@PrecioTotal * @PorcentajeLegal / 100.0);
            IF @NumMuestrasExtras > 0
                SET @PrecioTotal += (@NumMuestrasExtras * @CosteFijoMuestra * @PorcentajeMuestraLegal / 100.0);
        END

        -- Aplicar incremento por colaborador
        IF @EsColaborador = 1
            SET @PrecioTotal += (@PrecioTotal * @PorcentajeColaborador / 100.0);

        -- Redondear el precio total
        SET @PrecioTotal = ROUND(@PrecioTotal, 2);

        -- Actualizar caché de precios
        IF EXISTS (SELECT 1 FROM [dbo].[PrecioCache] WHERE IdTiposPruebasConsumo = @IdTipoPruebaConsumo AND EsLegal = @EsLegal AND EsColaborador = @EsColaborador)
        BEGIN
            UPDATE [dbo].[PrecioCache]
            SET PrecioBase = @PrecioTotal,
                FechaActualizacion = GETDATE()
            WHERE IdTiposPruebasConsumo = @IdTipoPruebaConsumo
              AND EsLegal = @EsLegal
              AND EsColaborador = @EsColaborador;
        END
        ELSE
        BEGIN
            INSERT INTO [dbo].[PrecioCache] (
                IdTiposPruebasConsumo, EsLegal, EsColaborador, PrecioBase, IdRegla, FechaActualizacion
            )
            VALUES (
                @IdTipoPruebaConsumo, @EsLegal, @EsColaborador, @PrecioTotal, @IdRegla, GETDATE()
            );
        END
    END TRY
    BEGIN CATCH
        SET @MensajeError = ERROR_MESSAGE();
        SET @PrecioTotal = 0;
        SET @IdConfiguracion = NULL;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcularPrecioTotal]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CalcularPrecioTotal]
    @IdTiposPruebasConsumo INT,
    @EsLegal BIT,
    @EsColaborador BIT,
    @IdTipoMuestra INT,
    @IdPlazoEntrega INT,
    @NumIntervinientes INT,
    @NumMuestras INT,
    @IdPeticion INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @PrecioBase DECIMAL(10,2) = 0,
        @PrecioPorInterviniente DECIMAL(10,2) = 0,
        @PrecioPorMuestra DECIMAL(10,2) = 0,
        @IncrementoPlazo DECIMAL(10,2) = 0,
        @CosteMuestra DECIMAL(10,2) = 0,
        @PorcentajeLegal DECIMAL(5,2) = 0,
        @PorcentajeColaborador DECIMAL(5,2) = 0,
        @IdRegla INT = NULL,
        @Total DECIMAL(10,2) = 0,
        @MuestrasConCoste INT = 0;

    -- Obtener configuración de precio base y regla
    SELECT TOP 1
        @PrecioBase = ISNULL(cp.PrecioBase, 0),
        @IdRegla = cp.IdRegla
    FROM ConfiguracionesPrecio cp
    WHERE cp.IdTiposPruebasConsumo = @IdTiposPruebasConsumo
      AND cp.EsLegal = @EsLegal
      AND cp.EsColaborador = @EsColaborador;

    -- Obtener los porcentajes de incremento de la regla
    SELECT 
        @PorcentajeLegal = ISNULL(PorcentajeIntervinienteLegal, 0),
        @PorcentajeColaborador = ISNULL(PorcentajeColaborador, 0)
    FROM ReglasIncrementoPrecio
    WHERE IdRegla = @IdRegla;

    -- Obtener precios estándar por muestra e interviniente
    SELECT TOP 1
        @PrecioPorMuestra = ISNULL(PrecioPorMuestra, 0),
        @PrecioPorInterviniente = ISNULL(PrecioPorInterviniente, 0)
    FROM TarifasBase;

    -- Obtener el coste fijo del tipo de muestra
    SELECT @CosteMuestra = ISNULL(CosteFijo, 0)
    FROM TiposMuestra
    WHERE IdTipoMuestra = @IdTipoMuestra;

    -- Obtener el incremento por el plazo de entrega
    SELECT @IncrementoPlazo = ISNULL(IncrementoFijo, 0)
    FROM PlazosEntrega
    WHERE IdPlazoEntrega = @IdPlazoEntrega;

    -- Calcular muestras con coste
    IF @IdPeticion IS NOT NULL
    BEGIN
        -- Consultar intentos por interviniente
        DECLARE @Muestras TABLE (IdInterviniente INT, Intentos INT, Valida BIT);
        INSERT INTO @Muestras
        SELECT IdInterviniente, Intentos, Valida
        FROM Muestras
        WHERE IdPeticion = @IdPeticion;

        -- Usar CTE para calcular costos por muestra
        WITH MuestrasCosto AS (
            SELECT 
                m.IdInterviniente,
                m.Intentos,
                m.Valida,
                CASE 
                    WHEN m.Intentos = 1 AND m.Valida = 1 THEN 1
                    WHEN m.Intentos = 2 AND m.Valida = 1 AND 
                         EXISTS (SELECT 1 FROM @Muestras m2 
                                 WHERE m2.IdInterviniente = m.IdInterviniente 
                                 AND m2.Intentos = 1 AND m2.Valida = 0) THEN 0
                    WHEN m.Intentos >= 3 AND m.Valida = 1 THEN 1
                    ELSE 0
                END AS TieneCosto
            FROM @Muestras m
        )
        SELECT @MuestrasConCoste = SUM(TieneCosto)
        FROM MuestrasCosto;
    END
    ELSE
    BEGIN
        -- Estimación: asumir una muestra válida por interviniente
        SET @MuestrasConCoste = @NumIntervinientes;
    END

    -- Calcular subtotal
    SET @Total = 
        @PrecioBase +
        (@NumIntervinientes * @PrecioPorInterviniente) +
        (@MuestrasConCoste * (@PrecioPorMuestra + @CosteMuestra)) +
        @IncrementoPlazo;

    -- Aplicar incrementos por legalidad y colaboración
    IF @EsLegal = 1
        SET @Total += (@Total * @PorcentajeLegal / 100.0);

    IF @EsColaborador = 1
        SET @Total += (@Total * @PorcentajeColaborador / 100.0);

    SELECT @Total AS PrecioTotal;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcularPrecioTotal_Debug]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_CalcularPrecioTotal_Debug]
    @IdTiposPruebasConsumo INT,
    @EsLegal BIT,
    @EsColaborador BIT,
    @IdTipoMuestra INT,
    @IdPlazoEntrega INT,
    @NumIntervinientes INT,
    @NumMuestras INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @PrecioBase DECIMAL(10,2) = 0,
        @PrecioPorInterviniente DECIMAL(10,2) = 0,
        @PrecioPorMuestra DECIMAL(10,2) = 0,
        @IncrementoPlazo DECIMAL(10,2) = 0,
        @CosteMuestra DECIMAL(10,2) = 0,
        @PorcentajeLegal DECIMAL(5,2) = 0,
        @PorcentajeColaborador DECIMAL(5,2) = 0,
        @IdRegla INT = NULL,
        @Subtotal DECIMAL(10,2) = 0,
        @Total DECIMAL(10,2) = 0;

    -- Obtener configuración
    SELECT TOP 1
        @PrecioBase = ISNULL(cp.PrecioBase, 0),
        @IdRegla = cp.IdRegla
    FROM ConfiguracionesPrecio cp
    WHERE cp.IdTiposPruebasConsumo = @IdTiposPruebasConsumo
      AND cp.EsLegal = @EsLegal
      AND cp.EsColaborador = @EsColaborador;

    -- Regla de incremento
    SELECT 
        @PorcentajeLegal = ISNULL(PorcentajeIntervinienteLegal, 0),
        @PorcentajeColaborador = ISNULL(PorcentajeColaborador, 0)
    FROM ReglasIncrementoPrecio
    WHERE IdRegla = @IdRegla;

    -- Precios estándar
    SELECT TOP 1
        @PrecioPorMuestra = ISNULL(PrecioPorMuestra, 0),
        @PrecioPorInterviniente = ISNULL(PrecioPorInterviniente, 0)
    FROM TarifasBase;

    -- Coste muestra
    SELECT @CosteMuestra = ISNULL(CosteFijo, 0)
    FROM TiposMuestra
    WHERE IdTipoMuestra = @IdTipoMuestra;

    -- Incremento por plazo
    SELECT @IncrementoPlazo = ISNULL(IncrementoFijo, 0)
    FROM PlazosEntrega
    WHERE IdPlazoEntrega = @IdPlazoEntrega;

    -- Mostrar valores intermedios
    SELECT 
        @PrecioBase AS PrecioBase,
        @PrecioPorInterviniente AS PrecioPorInterviniente,
        @PrecioPorMuestra AS PrecioPorMuestra,
        @CosteMuestra AS CosteFijoMuestra,
        @IncrementoPlazo AS IncrementoPlazo,
        @PorcentajeLegal AS PorcentajeLegal,
        @PorcentajeColaborador AS PorcentajeColaborador;

    -- Calcular subtotal
    SET @Subtotal = 
        @PrecioBase +
        (@NumIntervinientes * @PrecioPorInterviniente) +
        (@NumMuestras * (@PrecioPorMuestra + @CosteMuestra)) +
        @IncrementoPlazo;

    -- Mostrar subtotal
    SELECT @Subtotal AS SubtotalAntesDeIncrementos;

    -- Aplicar incrementos
    SET @Total = @Subtotal;

    IF @EsLegal = 1
        SET @Total += (@Subtotal * @PorcentajeLegal / 100.0);

    IF @EsColaborador = 1
        SET @Total += (@Subtotal * @PorcentajeColaborador / 100.0);

    -- Resultado final
    SELECT @Total AS PrecioTotalFinal;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcularPrecioTotal_Debug_Variables]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_CalcularPrecioTotal_Debug_Variables]
    @IdTiposPruebasConsumo INT,
    @EsLegal BIT,
    @EsColaborador BIT,
    @IdTipoMuestra INT,
    @IdPlazoEntrega INT,
    @NumIntervinientes INT,
    @NumMuestras INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @PrecioBase DECIMAL(10,2) = 0,
        @PrecioPorInterviniente DECIMAL(10,2) = 0,
        @PrecioPorMuestra DECIMAL(10,2) = 0,
        @IncrementoPlazo DECIMAL(10,2) = 0,
        @CosteMuestra DECIMAL(10,2) = 0,
        @PorcentajeLegal DECIMAL(5,2) = 0,
        @PorcentajeColaborador DECIMAL(5,2) = 0,
        @IdRegla INT = NULL,
        @Subtotal DECIMAL(10,2) = 0,
        @Total DECIMAL(10,2) = 0;

    -- Obtener configuración de precio base y regla
    SELECT TOP 1
        @PrecioBase = ISNULL(cp.PrecioBase, 0),
        @IdRegla = cp.IdRegla
    FROM ConfiguracionesPrecio cp
    WHERE cp.IdTiposPruebasConsumo = @IdTiposPruebasConsumo
      AND cp.EsLegal = @EsLegal
      AND cp.EsColaborador = @EsColaborador;

    -- Obtener regla de incremento
    SELECT 
        @PorcentajeLegal = ISNULL(PorcentajeIntervinienteLegal, 0),
        @PorcentajeColaborador = ISNULL(PorcentajeColaborador, 0)
    FROM ReglasIncrementoPrecio
    WHERE IdRegla = @IdRegla;

    -- Obtener precios por muestra e interviniente
    SELECT TOP 1
        @PrecioPorMuestra = ISNULL(PrecioPorMuestra, 0),
        @PrecioPorInterviniente = ISNULL(PrecioPorInterviniente, 0)
    FROM TarifasBase;

    -- Obtener coste de tipo de muestra
    SELECT @CosteMuestra = ISNULL(CosteFijo, 0)
    FROM TiposMuestra
    WHERE IdTipoMuestra = @IdTipoMuestra;

    -- Obtener incremento por plazo
    SELECT @IncrementoPlazo = ISNULL(IncrementoFijo, 0)
    FROM PlazosEntrega
    WHERE IdPlazoEntrega = @IdPlazoEntrega;

    -- Mostrar todas las variables cargadas ANTES del cálculo
    SELECT 
        @IdTiposPruebasConsumo AS IdTiposPruebasConsumo,
        @EsLegal AS EsLegal,
        @EsColaborador AS EsColaborador,
        @NumIntervinientes AS NumIntervinientes,
        @NumMuestras AS NumMuestras,
        @PrecioBase AS PrecioBase,
        @PrecioPorInterviniente AS PrecioPorInterviniente,
        @PrecioPorMuestra AS PrecioPorMuestra,
        @CosteMuestra AS CosteMuestra,
        @IncrementoPlazo AS IncrementoPlazo,
        @PorcentajeLegal AS PorcentajeLegal,
        @PorcentajeColaborador AS PorcentajeColaborador;

    -- Calcular subtotal
    SET @Subtotal = 
        @PrecioBase +
        (@NumIntervinientes * @PrecioPorInterviniente) +
        (@NumMuestras * (@PrecioPorMuestra + @CosteMuestra)) +
        @IncrementoPlazo;

    -- Mostrar subtotal antes de incrementos
    SELECT @Subtotal AS SubtotalAntesIncrementos;

    -- Calcular total con incrementos
    SET @Total = @Subtotal;

    IF @EsLegal = 1
        SET @Total += (@Subtotal * @PorcentajeLegal / 100.0);

    IF @EsColaborador = 1
        SET @Total += (@Subtotal * @PorcentajeColaborador / 100.0);

    -- Mostrar total final
    SELECT @Total AS PrecioTotalFinal;
END;;
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearFactura]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CrearFactura]
    @IdEmpresa INT,
    @IdLaboratorioColaborador INT,
    @IdSolicitante INT,
    @FechaFactura DATE,
    @EstadoFactura NVARCHAR(50),
    @IdTarifa INT,
    @IdFormaPago INT,
    @LineasFactura dbo.LineaFacturaTipo READONLY
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @IdFactura INT;

    -- Validar parámetros
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Empresas] WHERE IdEmpresa = @IdEmpresa)
        THROW 50001, 'La empresa especificada no existe.', 1;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[LaboratoriosColaboradores] WHERE IdLaboratorioColaborador = @IdLaboratorioColaborador)
        THROW 50002, 'El laboratorio colaborador especificado no existe.', 1;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Solicitantes] WHERE IdSolicitante = @IdSolicitante)
        THROW 50003, 'El solicitante especificado no existe.', 1;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Tarifas] WHERE IdTarifa = @IdTarifa)
        THROW 50005, 'La tarifa especificada no existe.', 1;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[FormasPago] WHERE IdFormaPago = @IdFormaPago)
        THROW 50006, 'La forma de pago especificada no existe.', 1;
    IF @EstadoFactura NOT IN ('Pendiente', 'Pagada', 'Anulada')
        THROW 50007, 'El estado de la factura debe ser Pendiente, Pagada o Anulada.', 1;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar la factura
        INSERT INTO [dbo].[Facturas] (
            IdEmpresa, IdLaboratorioColaborador, IdSolicitante, FechaFactura, 
            EstadoFactura, ImporteTotal, IdTarifa, IdFormaPago
        )
        VALUES (
            @IdEmpresa, @IdLaboratorioColaborador, @IdSolicitante, @FechaFactura, 
            @EstadoFactura, 0.00, @IdTarifa, @IdFormaPago
        );

        -- Obtener el IdFactura generado
        SET @IdFactura = SCOPE_IDENTITY();

        -- Insertar las líneas de factura
        INSERT INTO [dbo].[LineasFactura] (
            IdFactura, IdPrueba, Descripcion, Importe, Cantidad
        )
        SELECT 
            @IdFactura, IdPrueba, Descripcion, Importe, Cantidad
        FROM @LineasFactura;

        -- Actualizar el ImporteTotal
        UPDATE [dbo].[Facturas]
        SET ImporteTotal = (
            SELECT SUM(Importe) 
            FROM [dbo].[LineasFactura] 
            WHERE IdFactura = @IdFactura
        )
        WHERE IdFactura = @IdFactura;

        COMMIT TRANSACTION;

        -- Devolver el IdFactura creado
        SELECT @IdFactura AS IdFacturaCreada;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_EnviarNotificacion]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_EnviarNotificacion]
    @IdSolicitud INT,
    @TipoNotificacion NVARCHAR(50),
    @IdUsuario INT,
    @IdNotificacion INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar parámetros
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud)
            THROW 50001, 'La solicitud especificada no existe.', 1;
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuario AND Activo = 1)
        BEGIN
            -- Return active users for debugging
            SELECT IdUsuario, NombreUsuario, NombreCompleto
            FROM [dbo].[Usuarios]
            WHERE Activo = 1;
            THROW 50002, 'El usuario especificado no existe o no está activo. Consulte la lista de usuarios activos devuelta.', 1;
        END;

        -- Obtener datos del solicitante
        DECLARE @IdSolicitante INT, @Email NVARCHAR(100), @NombreSolicitante NVARCHAR(255), @TelefonoSMS NVARCHAR(20), @PrefiereSMS BIT, @IdIdioma CHAR(2);
        SELECT TOP 1
            @IdSolicitante = s.IdSolicitante,
            @Email = s.Email,
            @NombreSolicitante = s.Nombre + ' ' + s.Apellidos,
            @TelefonoSMS = s.TelefonoSMS,
            @PrefiereSMS = s.PrefiereSMS,
            @IdIdioma = ISNULL(s.IdIdiomaPreferido, 'ES')
        FROM [dbo].[Solicitantes] s
        JOIN [dbo].[Solicitudes] sol ON s.IdSolicitante = sol.IdSolicitante
        WHERE sol.IdSolicitud = @IdSolicitud
          AND (s.EnviarEmail = 1 OR s.PrefiereSMS = 1);

        IF @Email IS NULL AND @TelefonoSMS IS NULL
        BEGIN
            -- Intentar con laboratorio colaborador
            SELECT TOP 1
                @Email = lc.Email,
                @NombreSolicitante = lc.NombreFiscal,
                @TelefonoSMS = lc.TelefonoSMS,
                @PrefiereSMS = lc.PrefiereSMS,
                @IdIdioma = ISNULL(lc.IdIdiomaPreferido, 'ES')
            FROM [dbo].[LaboratoriosColaboradores] lc
            JOIN [dbo].[Solicitantes] s ON lc.IdLaboratorioColaborador = s.IdLaboratorioColaborador
            JOIN [dbo].[Solicitudes] sol ON s.IdSolicitante = sol.IdSolicitante
            WHERE sol.IdSolicitud = @IdSolicitud;
        END

        IF @Email IS NULL AND @TelefonoSMS IS NULL
            THROW 50003, 'No se encontró un destinatario válido para la notificación.', 1;

        -- Obtener plantilla
        DECLARE @IdPlantilla INT, @Canal NVARCHAR(10), @Asunto NVARCHAR(255), @Contenido NVARCHAR(MAX);
        SELECT TOP 1 
            @IdPlantilla = IdPlantilla,
            @Canal = Canal,
            @Asunto = Asunto,
            @Contenido = Content -- Changed from Contenido to Content
        FROM [dbo].[PlantillasNotificacion]
        WHERE TipoNotificacion = @TipoNotificacion 
          AND IdIdioma = @IdIdioma 
          AND Activa = 1 
          AND Canal = CASE WHEN @PrefiereSMS = 1 AND @TelefonoSMS IS NOT NULL THEN 'SMS' ELSE 'Email' END;

        IF @IdPlantilla IS NULL
        BEGIN
            -- Return available templates for debugging
            SELECT IdPlantilla, TipoNotificacion, Canal, IdIdioma
            FROM [dbo].[PlantillasNotificacion]
            WHERE Activa = 1;
            THROW 50004, 'No se encontró una plantilla válida para la notificación. Consulte la lista de plantillas activas devuelta.', 1;
        END;

        -- Reemplazar marcadores
        DECLARE @ContenidoFinal NVARCHAR(MAX) = @Contenido;
        SET @ContenidoFinal = REPLACE(@ContenidoFinal, '{NombreSolicitante}', ISNULL(@NombreSolicitante, 'N/A'));
        SET @ContenidoFinal = REPLACE(@ContenidoFinal, '{IdSolicitud}', CAST(@IdSolicitud AS NVARCHAR(10)));
        SET @Asunto = REPLACE(@Asunto, '{IdSolicitud}', CAST(@IdSolicitud AS NVARCHAR(10)));

        IF @Canal = 'Email'
        BEGIN
            -- Crear envío de email
            DECLARE @IdEnvio INT;
            INSERT INTO [dbo].[Envios] (
                Fecha, Asunto, Cuerpo, CodPaciente, TipoEnvio, Estado, TipoNotificacion
            )
            VALUES (
                GETDATE(), @Asunto, @ContenidoFinal, @IdSolicitante, 1, 1, @TipoNotificacion
            );
            SET @IdEnvio = SCOPE_IDENTITY();

            -- Añadir destinatario
            INSERT INTO [dbo].[DestinatariosEnvio] (
                IdEnvio, Email, Tipo
            )
            VALUES (
                @IdEnvio, @Email, 'TO'
            );

            -- Añadir adjunto si aplica (por ejemplo, informe)
            DECLARE @IdDocumento INT, @NombreArchivo NVARCHAR(255), @RutaArchivo NVARCHAR(500);
            SELECT TOP 1 
                @IdDocumento = d.IdDocumento, -- Explicitly qualify IdDocumento
                @NombreArchivo = d.NombreArchivo,
                @RutaArchivo = d.RutaArchivo
            FROM [dbo].[InformesGenerados] ig
            JOIN [dbo].[Documentos] d ON ig.IdDocumento = d.IdDocumento
            WHERE ig.IdSolicitud = @IdSolicitud
            ORDER BY ig.FechaGeneracion DESC;

            IF @IdDocumento IS NOT NULL
            BEGIN
                INSERT INTO [dbo].[AdjuntosEnvio] (
                    IdEnvio, NombreArchivo
                )
                VALUES (
                    @IdEnvio, @NombreArchivo
                );
            END;

            SET @IdNotificacion = @IdEnvio;
        END
        ELSE IF @Canal = 'SMS'
        BEGIN
            -- Crear notificación SMS
            INSERT INTO [dbo].[NotificacionesSMS] (
                IdSolicitud, TelefonoDestinatario, Mensaje, Estado, IdUsuario
            )
            VALUES (
                @IdSolicitud, @TelefonoSMS, LEFT(@ContenidoFinal, 160), 'Pendiente', @IdUsuario
            );
            SET @IdNotificacion = SCOPE_IDENTITY();
        END

        -- Registrar en auditoría
        INSERT INTO [dbo].[AuditoriaAcciones] (
            IdUsuario, FechaAccion, Tabla, Accion, Detalles
        )
        VALUES (
            @IdUsuario, GETDATE(), 
            CASE WHEN @Canal = 'Email' THEN 'Envios' ELSE 'NotificacionesSMS' END,
            'INSERT',
            'Notificación ' + @Canal + ' enviada para IdSolicitud: ' + CAST(@IdSolicitud AS NVARCHAR(10))
        );

        COMMIT TRANSACTION;

        -- Devolver información de la notificación
        IF @Canal = 'Email'
        BEGIN
            SELECT 
                IdEnvio AS IdNotificacion,
                Asunto,
                Cuerpo AS Mensaje,
                Fecha,
                'Email' AS Canal
            FROM [dbo].[Envios]
            WHERE IdEnvio = @IdNotificacion;
        END
        ELSE
        BEGIN
            SELECT 
                IdNotificacionSMS AS IdNotificacion,
                NULL AS Asunto,
                Mensaje,
                FechaEnvio AS Fecha,
                'SMS' AS Canal
            FROM [dbo].[NotificacionesSMS]
            WHERE IdNotificacionSMS = @IdNotificacion;
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW 50005, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerarDocumentoDesdePlantilla]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

        CREATE PROCEDURE [dbo].[sp_GenerarDocumentoDesdePlantilla]
            @IdSolicitud INT,
            @IdTipoPruebaConsumo INT = NULL,
            @IdTipoPlantilla INT,
            @IdIdioma NVARCHAR(2),
            @ArchivoReferencia NVARCHAR(50) OUTPUT,
            @IdPlantilla INT OUTPUT,
            @MensajeError NVARCHAR(500) OUTPUT
        AS
        BEGIN
            SET NOCOUNT ON;

            SET @ArchivoReferencia = NULL;
            SET @IdPlantilla = NULL;
            SET @MensajeError = NULL;

            BEGIN TRY
                IF NOT EXISTS (SELECT 1 FROM TiposPlantillas WHERE IdTipoPlantilla = @IdTipoPlantilla AND Activo = 1)
                    THROW 50001, 'IdTipoPlantilla inválido o inactivo.', 1;

                SELECT TOP 1 
                    @IdPlantilla = p.IdPlantilla,
                    @ArchivoReferencia = p.ArchivoReferencia
                FROM [dbo].[Plantillas] p
                WHERE (p.IdTipoPruebaConsumo = @IdTipoPruebaConsumo OR p.IdTipoPruebaConsumo IS NULL)
                  AND p.IdTipoPlantilla = @IdTipoPlantilla
                  AND p.IdIdioma = @IdIdioma
                  AND p.Activa = 1;

                IF @IdPlantilla IS NULL
                BEGIN
                    SET @MensajeError = 'No se encontró una plantilla activa para los parámetros especificados.';
                    RETURN;
                END

                SET @ArchivoReferencia = CAST(NEWID() AS NVARCHAR(50));

                INSERT INTO [dbo].[AuditoriaAcciones] (IdUsuario, Accion, FechaAccion, Detalles)
                VALUES (1, 'GenerarDocumento', GETDATE(), 'IdSolicitud: ' + CAST(@IdSolicitud AS NVARCHAR(10)) + ', IdPlantilla: ' + CAST(@IdPlantilla AS NVARCHAR(10)));

            END TRY
            BEGIN CATCH
                SET @MensajeError = ERROR_MESSAGE();
                SET @ArchivoReferencia = NULL;
                SET @IdPlantilla = NULL;
            END CATCH
        END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerarIndicesParentesco]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GenerarIndicesParentesco]
    @IdSolicitud INT,
    @IdUsuarioAnalista INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar solicitud
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud)
        THROW 50001, 'La solicitud especificada no existe.', 1;

    -- Declarar variables para perfiles
    DECLARE @IdPerfil1 INT, @IdPerfil2 INT;
    DECLARE @TipoRelacion VARCHAR(50);

    -- Cursor para iterar sobre posibles relaciones
    DECLARE rel_cursor CURSOR FOR
    SELECT 'Padre-Hijo' AS TipoRelacion
    UNION SELECT 'Madre-Hijo'
    UNION SELECT 'Hermanos'
    UNION SELECT 'Abuelo-Nieto';

    OPEN rel_cursor;
    FETCH NEXT FROM rel_cursor INTO @TipoRelacion;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @IdPerfil1 = NULL;
        SET @IdPerfil2 = NULL;

        -- Identificar perfiles según la relación
        IF @TipoRelacion = 'Padre-Hijo'
        BEGIN
            SELECT @IdPerfil1 = pg.IdPerfilGenetico
            FROM [dbo].[PerfilesGeneticos] pg
            JOIN [dbo].[Intervinientes] i ON pg.IdInterviniente = i.IdInterviniente
            JOIN [dbo].[TipoInterviniente] ti ON i.IdTipoInterviniente = ti.Codigo
            WHERE i.IdSolicitud = @IdSolicitud AND ti.Descripcion = 'Hijo';

            SELECT @IdPerfil2 = pg.IdPerfilGenetico
            FROM [dbo].[PerfilesGeneticos] pg
            JOIN [dbo].[Intervinientes] i ON pg.IdInterviniente = i.IdInterviniente
            JOIN [dbo].[TipoInterviniente] ti ON i.IdTipoInterviniente = ti.Codigo
            WHERE i.IdSolicitud = @IdSolicitud AND ti.Descripcion = 'Presunto Padre';
        END
        ELSE IF @TipoRelacion = 'Madre-Hijo'
        BEGIN
            SELECT @IdPerfil1 = pg.IdPerfilGenetico
            FROM [dbo].[PerfilesGeneticos] pg
            JOIN [dbo].[Intervinientes] i ON pg.IdInterviniente = i.IdInterviniente
            JOIN [dbo].[TipoInterviniente] ti ON i.IdTipoInterviniente = ti.Codigo
            WHERE i.IdSolicitud = @IdSolicitud AND ti.Descripcion = 'Hijo';

            SELECT @IdPerfil2 = pg.IdPerfilGenetico
            FROM [dbo].[PerfilesGeneticos] pg
            JOIN [dbo].[Intervinientes] i ON pg.IdInterviniente = i.IdInterviniente
            JOIN [dbo].[TipoInterviniente] ti ON i.IdTipoInterviniente = ti.Codigo
            WHERE i.IdSolicitud = @IdSolicitud AND ti.Descripcion = 'Madre';
        END
        ELSE IF @TipoRelacion = 'Hermanos'
        BEGIN
            -- Asumimos dos intervinientes con tipo 'Hijo' o similar
            SELECT TOP 1 @IdPerfil1 = pg.IdPerfilGenetico
            FROM [dbo].[PerfilesGeneticos] pg
            JOIN [dbo].[Intervinientes] i ON pg.IdInterviniente = i.IdInterviniente
            JOIN [dbo].[TipoInterviniente] ti ON i.IdTipoInterviniente = ti.Codigo
            WHERE i.IdSolicitud = @IdSolicitud AND ti.Descripcion LIKE '%Hijo%';

            SELECT TOP 1 @IdPerfil2 = pg.IdPerfilGenetico
            FROM [dbo].[PerfilesGeneticos] pg
            JOIN [dbo].[Intervinientes] i ON pg.IdInterviniente = i.IdInterviniente
            JOIN [dbo].[TipoInterviniente] ti ON i.IdTipoInterviniente = ti.Codigo
            WHERE i.IdSolicitud = @IdSolicitud AND ti.Descripcion LIKE '%Hijo%'
              AND pg.IdPerfilGenetico <> @IdPerfil1;
        END
        ELSE IF @TipoRelacion = 'Abuelo-Nieto'
        BEGIN
            SELECT @IdPerfil1 = pg.IdPerfilGenetico
            FROM [dbo].[PerfilesGeneticos] pg
            JOIN [dbo].[Intervinientes] i ON pg.IdInterviniente = i.IdInterviniente
            JOIN [dbo].[TipoInterviniente] ti ON i.IdTipoInterviniente = ti.Codigo
            WHERE i.IdSolicitud = @IdSolicitud AND ti.Descripcion = 'Nieto';

            SELECT @IdPerfil2 = pg.IdPerfilGenetico
            FROM [dbo].[PerfilesGeneticos] pg
            JOIN [dbo].[Intervinientes] i ON pg.IdInterviniente = i.IdInterviniente
            JOIN [dbo].[TipoInterviniente] ti ON i.IdTipoInterviniente = ti.Codigo
            WHERE i.IdSolicitud = @IdSolicitud AND ti.Descripcion = 'Abuelo';
        END

        -- Generar índice si ambos perfiles existen
        IF @IdPerfil1 IS NOT NULL AND @IdPerfil2 IS NOT NULL
        BEGIN
            EXEC [dbo].[sp_CalcularIndiceParentesco]
                @IdSolicitud = @IdSolicitud,
                @TipoRelacion = @TipoRelacion,
                @IdPerfilGenetico1 = @IdPerfil1,
                @IdPerfilGenetico2 = @IdPerfil2,
                @IdUsuarioAnalista = @IdUsuarioAnalista;
        END

        FETCH NEXT FROM rel_cursor INTO @TipoRelacion;
    END;

    CLOSE rel_cursor;
    DEALLOCATE rel_cursor;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerarInformeCumplimiento]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GenerarInformeCumplimiento]
    @FechaInicio DATE,
    @FechaFin DATE,
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validar parámetros
        IF @FechaFin < @FechaInicio
            THROW 50001, 'La fecha de fin debe ser posterior a la fecha de inicio.', 1;
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuario AND Activo = 1)
            THROW 50002, 'El usuario especificado no existe o no está activo.', 1;

        -- Obtener datos de cumplimiento
        SELECT 
            TipoRegistro,
            IdRegistro,
            Descripcion,
            Fecha,
            Estado,
            Responsable,
            Observaciones
        FROM [dbo].[vw_InformeCumplimientoCalidad]
        WHERE Fecha BETWEEN @FechaInicio AND @FechaFin
        ORDER BY Fecha DESC;

        -- Registrar en auditoría
        INSERT INTO [dbo].[AuditoriaAcciones] (
            IdUsuario, FechaAccion, Tabla, Accion, Detalles
        )
        VALUES (
            @IdUsuario, GETDATE(), 'vw_InformeCumplimientoCalidad', 'SELECT',
            'Informe de cumplimiento generado para período: ' + CONVERT(NVARCHAR(10), @FechaInicio, 103) + ' a ' + CONVERT(NVARCHAR(10), @FechaFin, 103)
        );
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerarInformeMultilingue]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GenerarInformeMultilingue]
    @IdSolicitud INT,
    @TipoInforme NVARCHAR(50),
    @IdIdioma CHAR(2),
    @IdUsuario INT,
    @IdInformeGenerado INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar parámetros
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud)
            THROW 50001, 'La solicitud especificada no existe.', 1;
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Idiomas] WHERE IdIdioma = @IdIdioma AND Activo = 1)
            THROW 50002, 'El idioma especificado no es válido o no está activo.', 1;
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuario)
            THROW 50003, 'El usuario especificado no existe.', 1;
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PlantillasInforme] WHERE TipoInforme = @TipoInforme AND IdIdioma = @IdIdioma AND Activa = 1)
            THROW 50004, 'No existe una plantilla activa para el tipo de informe e idioma especificados.', 1;

        -- Obtener la plantilla
        DECLARE @ContenidoPlantilla NVARCHAR(MAX);
        DECLARE @IdPlantilla INT;
        SELECT TOP 1 
            @IdPlantilla = IdPlantilla,
            @ContenidoPlantilla = Contenido
        FROM [dbo].[PlantillasInforme]
        WHERE TipoInforme = @TipoInforme AND IdIdioma = @IdIdioma AND Activa = 1;

        -- Obtener datos del informe según el tipo
        DECLARE @ContenidoFinal NVARCHAR(MAX) = @ContenidoPlantilla;
        DECLARE @NombreArchivo NVARCHAR(255);
        DECLARE @RutaArchivo NVARCHAR(500);

        IF @TipoInforme = 'Paternidad'
        BEGIN
            -- Obtener datos de la vista de paternidad
            DECLARE @NombreHijo NVARCHAR(100), @NombrePadre NVARCHAR(100), @ProbabilidadParentesco DECIMAL(5,2), @Resultado NVARCHAR(100), @FechaAnalisis DATETIME;
            SELECT TOP 1
                @NombreHijo = NombreHijo,
                @NombrePadre = NombrePadre,
                @ProbabilidadParentesco = ProbabilidadParentesco,
                @Resultado = Resultado,
                @FechaAnalisis = FechaAnalisis
            FROM [dbo].[vw_ReportePaternidad]
            WHERE IdSolicitud = @IdSolicitud;

            IF @NombreHijo IS NULL
                THROW 50005, 'No se encontraron datos de paternidad para la solicitud.', 1;

            -- Reemplazar marcadores en la plantilla
            SET @ContenidoFinal = REPLACE(@ContenidoFinal, '{NombreHijo}', ISNULL(@NombreHijo, 'N/A'));
            SET @ContenidoFinal = REPLACE(@ContenidoFinal, '{NombrePadre}', ISNULL(@NombrePadre, 'N/A'));
            SET @ContenidoFinal = REPLACE(@ContenidoFinal, '{ProbabilidadParentesco}', CAST(ISNULL(@ProbabilidadParentesco, 0) AS NVARCHAR(10)) + '%');
            SET @ContenidoFinal = REPLACE(@ContenidoFinal, '{Resultado}', ISNULL(@Resultado, 'N/A'));
            SET @ContenidoFinal = REPLACE(@ContenidoFinal, '{FechaAnalisis}', ISNULL(CONVERT(NVARCHAR(10), @FechaAnalisis, 103), 'N/A'));

            SET @NombreArchivo = 'Informe_Paternidad_' + CAST(@IdSolicitud AS NVARCHAR(10)) + '_' + @IdIdioma + '.pdf';
            SET @RutaArchivo = '\Informes\' + @NombreArchivo;
        END
        -- Añadir más condiciones para otros tipos de informes (Citogenética, Andrología, etc.)

        -- Insertar el documento en [Documentos]
        DECLARE @IdDocumento INT;
        INSERT INTO [dbo].[Documentos] (
            IdEntidad, NombreArchivo, RutaArchivo, Extension, TamanoKB, FechaSubida, SubidoPor, IdTipoDocumento, IdEntidadTipo
        )
        VALUES (
            @IdSolicitud, @NombreArchivo, @RutaArchivo, 'pdf', 0, GETDATE(), @IdUsuario, 
            (SELECT TOP 1 IdTipoDocumento FROM [dbo].[TiposDocumentos] WHERE Nombre = 'Informe'), 
            (SELECT TOP 1 IdEntidadTipo FROM [dbo].[Entidades] WHERE Nombre = 'Solicitudes')
        );
        SET @IdDocumento = SCOPE_IDENTITY();

        -- Insertar en [InformesGenerados]
        INSERT INTO [dbo].[InformesGenerados] (
            IdSolicitud, IdPlantilla, IdDocumento, FechaGeneracion, IdUsuario, Estado
        )
        VALUES (
            @IdSolicitud, @IdPlantilla, @IdDocumento, GETDATE(), @IdUsuario, 'Generado'
        );
        SET @IdInformeGenerado = SCOPE_IDENTITY();

        -- Simular la generación del PDF (en un entorno real, se usaría una biblioteca externa)
        -- Aquí se asume que el contenido final se pasa a un servicio de generación de PDF
        -- Por ahora, actualizamos el documento con un marcador de contenido
        UPDATE [dbo].[Documentos]
        SET Comentarios = 'Contenido: ' + LEFT(@ContenidoFinal, 1000)
        WHERE IdDocumento = @IdDocumento;

        COMMIT TRANSACTION;

        -- Devolver información del informe generado
        SELECT 
            IdInforme,
            IdSolicitud,
            IdPlantilla,
            IdDocumento,
            FechaGeneracion,
            Estado
        FROM [dbo].[InformesGenerados]
        WHERE IdInforme = @IdInformeGenerado;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GestionarDocumento]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GestionarDocumento]
    @Accion NVARCHAR(50), -- 'Insertar', 'Actualizar', 'Eliminar', 'Consultar'
    @IdDocumento INT OUTPUT,
    @IdEntidad INT = NULL,
    @NombreArchivo NVARCHAR(255) = NULL,
    @RutaArchivo NVARCHAR(500) = NULL,
    @Extension NVARCHAR(10) = NULL,
    @TamanoKB INT = NULL,
    @IdTipoDocumento INT = NULL,
    @IdEntidadTipo INT = NULL,
    @Comentarios NVARCHAR(MAX) = NULL,
    @EsConfidencial BIT = 0,
    @FechaExpiracion DATETIME = NULL,
    @HashDocumento NVARCHAR(256) = NULL,
    @IdUsuario INT,
    @IdSolicitud INT = NULL -- Para filtrar por solicitud en Consultar
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar usuario
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuario AND Activo = 1)
        BEGIN
            SELECT IdUsuario, NombreUsuario, NombreCompleto
            FROM [dbo].[Usuarios]
            WHERE Activo = 1;
            THROW 50001, 'El usuario especificado no existe o no está activo. Consulte la lista de usuarios activos devuelta.', 1;
        END;

        IF @Accion = 'Insertar'
        BEGIN
            -- Validar parámetros requeridos
            IF @NombreArchivo IS NULL OR @RutaArchivo IS NULL OR @IdTipoDocumento IS NULL OR @IdEntidadTipo IS NULL
                THROW 50002, 'NombreArchivo, RutaArchivo, IdTipoDocumento y IdEntidadTipo son requeridos para insertar.', 1;

            -- Insertar documento
            INSERT INTO [dbo].[Documentos] (
                IdEntidad, NombreArchivo, RutaArchivo, Extension, TamanoKB, FechaSubida, SubidoPor,
                IdTipoDocumento, IdEntidadTipo, Comentarios, EsConfidencial, FechaExpiracion, HashDocumento
            )
            VALUES (
                @IdEntidad, @NombreArchivo, @RutaArchivo, @Extension, @TamanoKB, GETDATE(), @IdUsuario,
                @IdTipoDocumento, @IdEntidadTipo, @Comentarios, @EsConfidencial, @FechaExpiracion, @HashDocumento
            );

            SET @IdDocumento = SCOPE_IDENTITY();

            -- Asignar permisos si es confidencial
            IF @EsConfidencial = 1
            BEGIN
                INSERT INTO [dbo].[PermisosDocumento] (IdDocumento, IdUsuario, Permiso)
                VALUES (@IdDocumento, @IdUsuario, 'Leer');
            END;

            -- Registrar en auditoría
            INSERT INTO [dbo].[AuditoriaAcciones] (
                IdUsuario, FechaAccion, Tabla, Accion, Detalles, IdDocumento
            )
            VALUES (
                @IdUsuario, GETDATE(), 'Documentos', 'INSERT',
                'Documento insertado con IdDocumento: ' + CAST(@IdDocumento AS NVARCHAR(10)), @IdDocumento
            );

            -- Notificar si está asociado a una solicitud
            IF @IdEntidad IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdEntidad)
            BEGIN
                DECLARE @IdNotificacion INT;
                BEGIN TRY
                    EXEC [dbo].[sp_EnviarNotificacion]
                        @IdSolicitud = @IdEntidad,
                        @TipoNotificacion = 'DocumentoSubido',
                        @IdUsuario = @IdUsuario,
                        @IdNotificacion = @IdNotificacion OUTPUT;
                END TRY
                BEGIN CATCH
                    -- Log the notification error but don't fail the transaction
                    INSERT INTO [dbo].[AuditoriaAcciones] (
                        IdUsuario, FechaAccion, Tabla, Accion, Detalles, IdDocumento
                    )
                    VALUES (
                        @IdUsuario, GETDATE(), 'Documentos', 'ERROR',
                        'Error al enviar notificación para IdDocumento: ' + CAST(@IdDocumento AS NVARCHAR(10)) + ': ' + ERROR_MESSAGE(),
                        @IdDocumento
                    );
                END CATCH;
            END;
        END
        ELSE IF @Accion = 'Actualizar'
        BEGIN
            -- Validar documento
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Documentos] WHERE IdDocumento = @IdDocumento)
                THROW 50003, 'El documento especificado no existe.', 1;

            -- Verificar permisos
            IF @EsConfidencial = 1 AND NOT EXISTS (
                SELECT 1 FROM [dbo].[PermisosDocumento] 
                WHERE IdDocumento = @IdDocumento AND IdUsuario = @IdUsuario AND Permiso IN ('Editar', 'Eliminar')
            )
                THROW 50004, 'No tiene permisos para actualizar este documento confidencial.', 1;

            -- Actualizar documento
            UPDATE [dbo].[Documentos]
            SET 
                NombreArchivo = ISNULL(@NombreArchivo, NombreArchivo),
                RutaArchivo = ISNULL(@RutaArchivo, RutaArchivo),
                Extension = ISNULL(@Extension, Extension),
                TamanoKB = ISNULL(@TamanoKB, TamanoKB),
                IdTipoDocumento = ISNULL(@IdTipoDocumento, IdTipoDocumento),
                IdEntidadTipo = ISNULL(@IdEntidadTipo, IdEntidadTipo),
                Comentarios = ISNULL(@Comentarios, Comentarios),
                EsConfidencial = ISNULL(@EsConfidencial, EsConfidencial),
                FechaExpiracion = @FechaExpiracion,
                HashDocumento = ISNULL(@HashDocumento, HashDocumento)
            WHERE IdDocumento = @IdDocumento;

            -- Registrar en auditoría
            INSERT INTO [dbo].[AuditoriaAcciones] (
                IdUsuario, FechaAccion, Tabla, Accion, Detalles, IdDocumento
            )
            VALUES (
                @IdUsuario, GETDATE(), 'Documentos', 'UPDATE',
                'Documento actualizado con IdDocumento: ' + CAST(@IdDocumento AS NVARCHAR(10)), @IdDocumento
            );
        END
        ELSE IF @Accion = 'Eliminar'
        BEGIN
            -- Validar documento
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Documentos] WHERE IdDocumento = @IdDocumento)
                THROW 50005, 'El documento especificado no existe.', 1;

            -- Verificar permisos
            IF EXISTS (SELECT 1 FROM [dbo].[Documentos] WHERE IdDocumento = @IdDocumento AND EsConfidencial = 1)
                AND NOT EXISTS (
                    SELECT 1 FROM [dbo].[PermisosDocumento] 
                    WHERE IdDocumento = @IdDocumento AND IdUsuario = @IdUsuario AND Permiso = 'Eliminar'
                )
                THROW 50006, 'No tiene permisos para eliminar este documento confidencial.', 1;

            -- Eliminar permisos asociados
            DELETE FROM [dbo].[PermisosDocumento] WHERE IdDocumento = @IdDocumento;

            -- Eliminar documento
            DELETE FROM [dbo].[Documentos] WHERE IdDocumento = @IdDocumento;

            -- Registrar en auditoría
            INSERT INTO [dbo].[AuditoriaAcciones] (
                IdUsuario, FechaAccion, Tabla, Accion, Detalles, IdDocumento
            )
            VALUES (
                @IdUsuario, GETDATE(), 'Documentos', 'DELETE',
                'Documento eliminado con IdDocumento: ' + CAST(@IdDocumento AS NVARCHAR(10)), @IdDocumento
            );
        END
        ELSE IF @Accion = 'Consultar'
        BEGIN
            -- Consultar documentos, respetando permisos
            SELECT 
                d.IdDocumento,
                d.IdEntidad,
                d.NombreArchivo,
                d.RutaArchivo,
                d.Extension,
                d.TamanoKB,
                d.FechaSubida,
                u.NombreCompleto AS SubidoPor,
                td.Nombre AS TipoDocumento,
                e.Nombre AS EntidadTipo,
                d.Comentarios,
                d.EsConfidencial,
                d.FechaExpiracion
            FROM [dbo].[Documentos] d
            JOIN [dbo].[Usuarios] u ON d.SubidoPor = u.IdUsuario
            JOIN [dbo].[TiposDocumentos] td ON d.IdTipoDocumento = td.IdTipoDocumento
            JOIN [dbo].[Entidades] e ON d.IdEntidadTipo = e.IdEntidadTipo
            WHERE (@IdSolicitud IS NULL OR d.IdEntidad = @IdSolicitud)
              AND (@IdDocumento IS NULL OR d.IdDocumento = @IdDocumento)
              AND (d.EsConfidencial = 0 OR EXISTS (
                  SELECT 1 FROM [dbo].[PermisosDocumento] pd
                  WHERE pd.IdDocumento = d.IdDocumento 
                    AND (pd.IdUsuario = @IdUsuario OR pd.IdRol IN (
                        SELECT IdRol FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuario
                    ))
                    AND pd.Permiso = 'Leer'
              ))
              AND (d.FechaExpiracion IS NULL OR d.FechaExpiracion > GETDATE());
        END
        ELSE
        BEGIN
            THROW 50007, 'Acción no válida. Use Insertar, Actualizar, Eliminar o Consultar.', 1;
        END;

        COMMIT TRANSACTION;

        IF @Accion IN ('Insertar', 'Actualizar', 'Eliminar')
        BEGIN
            SELECT @IdDocumento AS IdDocumento;
        END;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW 50008, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GestionarResultado]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GestionarResultado]
    @Accion NVARCHAR(50), -- 'Registrar', 'AprobarTecnico', 'Validar', 'Consultar'
    @TipoResultado NVARCHAR(50), -- 'Parentesco', 'Genetica', 'Citogenetica', 'Andrologia'
    @IdResultado INT = NULL,
    @IdLineaPeticion INT = NULL,
    @Resultado NVARCHAR(MAX) = NULL,
    @IdUsuario INT,
    @EstadoValidacion NVARCHAR(50) = NULL,
    @Observaciones NVARCHAR(MAX) = NULL,
    @NivelValidacion INT = 1,
    @GenerarInforme BIT = 0,
    @IdSolicitud INT = NULL -- Para consultar por solicitud
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar usuario
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuario AND Activo = 1)
        BEGIN
            SELECT IdUsuario, NombreUsuario, NombreCompleto
            FROM [dbo].[Usuarios]
            WHERE Activo = 1;
            THROW 50001, 'El usuario especificado no existe o no está activo.', 1;
        END;

        -- Validar tipo de resultado
        IF @TipoResultado NOT IN ('Parentesco', 'Genetica', 'Citogenetica', 'Andrologia')
            THROW 50002, 'Tipo de resultado no válido.', 1;

        DECLARE @Tabla NVARCHAR(50), @Sql NVARCHAR(MAX), @IdValidacion INT;

        IF @Accion = 'Registrar'
        BEGIN
            -- Validar parámetros
            IF @IdLineaPeticion IS NULL OR @Resultado IS NULL
                THROW 50003, 'IdLineaPeticion y Resultado son requeridos para registrar.', 1;

            -- Validar línea de petición
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PeticionesLin] WHERE IdLineaPeticion = @IdLineaPeticion)
                THROW 50004, 'La línea de petición especificada no existe.', 1;

            -- Seleccionar tabla según tipo
            IF @TipoResultado = 'Parentesco'
                SET @Tabla = '[dbo].[ResultadosParentesco]';
            ELSE IF @TipoResultado = 'Genetica'
                SET @Tabla = '[dbo].[ResultadosGenetica]';
            ELSE IF @TipoResultado = 'Citogenetica'
                SET @Tabla = '[dbo].[ResultadosCitogenetica]';
            ELSE IF @TipoResultado = 'Andrologia'
                SET @Tabla = '[dbo].[ResultadosAndrologia]';

            -- Registrar resultado
            SET @Sql = N'
                INSERT INTO ' + QUOTENAME(@Tabla) + N' (
                    IdLineaPeticion, FechaResultado, Resultado, ValidadoPor, EstadoValidacion, EstadoValidacionFinal
                )
                VALUES (
                    @IdLineaPeticion, GETDATE(), @Resultado, @IdUsuario, ''Pendiente'', ''Pendiente''
                );
                SELECT @IdResultado = SCOPE_IDENTITY();
            ';
            EXEC sp_executesql @Sql, 
                N'@IdLineaPeticion INT, @Resultado NVARCHAR(MAX), @IdUsuario INT, @IdResultado INT OUTPUT',
                @IdLineaPeticion, @Resultado, @IdUsuario, @IdResultado OUTPUT;

            -- Actualizar estado en PeticionesLin
            UPDATE [dbo].[PeticionesLin]
            SET EstadoResultado = 'Completado',
                FechaCompletado = GETDATE(),
                NumValidacionesCompletadas = 0
            WHERE IdLineaPeticion = @IdLineaPeticion;

            -- Registrar en auditoría
            INSERT INTO [dbo].[AuditoriaAcciones] (
                IdUsuario, FechaAccion, Tabla, Accion, Detalles
            )
            VALUES (
                @IdUsuario, GETDATE(), @Tabla, 'INSERT',
                'Resultado registrado para IdLineaPeticion: ' + CAST(@IdLineaPeticion AS NVARCHAR(10))
            );
        END
        ELSE IF @Accion = 'AprobarTecnico'
        BEGIN
            -- Validar parámetros
            IF @IdResultado IS NULL OR @EstadoValidacion IS NULL
                THROW 50005, 'IdResultado y EstadoValidacion son requeridos para aprobar por técnico.', 1;

            IF @EstadoValidacion NOT IN ('AprobadoPorTecnico', 'RechazadoPorTecnico')
                THROW 50006, 'EstadoValidacion debe ser AprobadoPorTecnico o RechazadoPorTecnico.', 1;

            -- Seleccionar tabla según tipo
            IF @TipoResultado = 'Parentesco'
                SET @Tabla = '[dbo].[ResultadosParentesco]';
            ELSE IF @TipoResultado = 'Genetica'
                SET @Tabla = '[dbo].[ResultadosGenetica]';
            ELSE IF @TipoResultado = 'Citogenetica'
                SET @Tabla = '[dbo].[ResultadosCitogenetica]';
            ELSE IF @TipoResultado = 'Andrologia'
                SET @Tabla = '[dbo].[ResultadosAndrologia]';

            -- Verificar que el usuario es el técnico que registró el resultado
            SET @Sql = N'
                SELECT 1 
                FROM ' + QUOTENAME(@Tabla) + ' 
                WHERE ' + 
                CASE 
                    WHEN @TipoResultado = 'Parentesco' THEN 'IdResultadoParentesco'
                    WHEN @TipoResultado = 'Genetica' THEN 'IdResultadoGenetica'
                    WHEN @TipoResultado = 'Citogenetica' THEN 'IdResultadoCitogenetica'
                    WHEN @TipoResultado = 'Andrologia' THEN 'IdResultadoAndrologia'
                END + ' = @IdResultado AND ValidadoPor = @IdUsuario;
            ';
            EXEC sp_executesql @Sql, 
                N'@IdResultado INT, @IdUsuario INT',
                @IdResultado, @IdUsuario;
            IF @@ROWCOUNT = 0
                THROW 50007, 'El usuario no es el técnico que registró el resultado.', 1;

            -- Actualizar EstadoValidacion
            SET @Sql = N'
                UPDATE ' + QUOTENAME(@Tabla) + '
                SET EstadoValidacion = @EstadoValidacion
                WHERE ' + 
                CASE 
                    WHEN @TipoResultado = 'Parentesco' THEN 'IdResultadoParentesco'
                    WHEN @TipoResultado = 'Genetica' THEN 'IdResultadoGenetica'
                    WHEN @TipoResultado = 'Citogenetica' THEN 'IdResultadoCitogenetica'
                    WHEN @TipoResultado = 'Andrologia' THEN 'IdResultadoAndrologia'
                END + ' = @IdResultado;
            ';
            EXEC sp_executesql @Sql, 
                N'@EstadoValidacion NVARCHAR(50), @IdResultado INT',
                @EstadoValidacion, @IdResultado;

            -- Registrar en auditoría
            INSERT INTO [dbo].[AuditoriaAcciones] (
                IdUsuario, FechaAccion, Tabla, Accion, Detalles
            )
            VALUES (
                @IdUsuario, GETDATE(), @Tabla, 'UPDATE',
                'Resultado aprobado/rechazado por técnico para IdResultado: ' + CAST(@IdResultado AS NVARCHAR(10))
            );
        END
        ELSE IF @Accion = 'Validar'
        BEGIN
            -- Validar parámetros
            IF @IdResultado IS NULL OR @EstadoValidacion IS NULL OR @NivelValidacion < 1
                THROW 50008, 'IdResultado, EstadoValidacion y NivelValidacion son requeridos para validar.', 1;

            IF @EstadoValidacion NOT IN ('Aprobado', 'Rechazado', 'Revisar')
                THROW 50009, 'EstadoValidacion debe ser Aprobado, Rechazado o Revisar.', 1;

            -- Seleccionar tabla según tipo
            IF @TipoResultado = 'Parentesco'
                SET @Tabla = '[dbo].[ResultadosParentesco]';
            ELSE IF @TipoResultado = 'Genetica'
                SET @Tabla = '[dbo].[ResultadosGenetica]';
            ELSE IF @TipoResultado = 'Citogenetica'
                SET @Tabla = '[dbo].[ResultadosCitogenetica]';
            ELSE IF @TipoResultado = 'Andrologia'
                SET @Tabla = '[dbo].[ResultadosAndrologia]';

            -- Verificar que el resultado está aprobado por el técnico
            SET @Sql = N'
                SELECT 1 
                FROM ' + QUOTENAME(@Tabla) + ' 
                WHERE ' + 
                CASE 
                    WHEN @TipoResultado = 'Parentesco' THEN 'IdResultadoParentesco'
                    WHEN @TipoResultado = 'Genetica' THEN 'IdResultadoGenetica'
                    WHEN @TipoResultado = 'Citogenetica' THEN 'IdResultadoCitogenetica'
                    WHEN @TipoResultado = 'Andrologia' THEN 'IdResultadoAndrologia'
                END + ' = @IdResultado AND EstadoValidacion = ''AprobadoPorTecnico'';
            ';
            EXEC sp_executesql @Sql, 
                N'@IdResultado INT',
                @IdResultado;
            IF @@ROWCOUNT = 0
                THROW 50010, 'El resultado no ha sido aprobado por el técnico.', 1;

            -- Validar que el usuario tiene el rol requerido
            DECLARE @NumValidacionesRequeridas INT, @RolRequerido INT;
            SELECT @NumValidacionesRequeridas = NumValidacionesRequeridas, @RolRequerido = RolRequerido
            FROM [dbo].[ConfigValidaciones]
            WHERE TipoResultado = @TipoResultado;

            IF NOT EXISTS (
                SELECT 1 
                FROM [dbo].[Usuarios] u
                JOIN [dbo].[Roles] r ON u.IdRol = r.IdRol
                WHERE u.IdUsuario = @IdUsuario AND (r.IdRol = @RolRequerido OR @RolRequerido IS NULL)
            )
                THROW 50011, 'El usuario no tiene el rol requerido para validar este resultado.', 1;

            -- Registrar validación
            INSERT INTO [dbo].[ValidacionesResultado] (
                IdResultado, TipoResultado, IdUsuarioValidador, EstadoValidacion, Observaciones, FechaValidacion, NivelValidacion
            )
            VALUES (
                @IdResultado, @TipoResultado, @IdUsuario, @EstadoValidacion, @Observaciones, GETDATE(), @NivelValidacion
            );
            SET @IdValidacion = SCOPE_IDENTITY();

            -- Obtener IdLineaPeticion
            DECLARE @CurrentIdLineaPeticion INT;
            IF @TipoResultado = 'Parentesco'
                SELECT @CurrentIdLineaPeticion = IdLineaPeticion FROM [dbo].[ResultadosParentesco] WHERE IdResultadoParentesco = @IdResultado;
            ELSE IF @TipoResultado = 'Genetica'
                SELECT @CurrentIdLineaPeticion = IdLineaPeticion FROM [dbo].[ResultadosGenetica] WHERE IdResultadoGenetica = @IdResultado;
            ELSE IF @TipoResultado = 'Citogenetica'
                SELECT @CurrentIdLineaPeticion = IdLineaPeticion FROM [dbo].[ResultadosCitogenetica] WHERE IdResultadoCitogenetica = @IdResultado;
            ELSE IF @TipoResultado = 'Andrologia'
                SELECT @CurrentIdLineaPeticion = IdLineaPeticion FROM [dbo].[ResultadosAndrologia] WHERE IdResultadoAndrologia = @IdResultado;

            -- Actualizar número de validaciones completadas
            UPDATE [dbo].[PeticionesLin]
            SET NumValidacionesCompletadas = (
                SELECT COUNT(*) 
                FROM [dbo].[ValidacionesResultado] 
                WHERE IdResultado = @IdResultado AND TipoResultado = @TipoResultado AND EstadoValidacion = 'Aprobado'
            )
            WHERE IdLineaPeticion = @CurrentIdLineaPeticion;

            -- Determinar si es la validación final
            DECLARE @NumValidacionesCompletadas INT;
            SELECT @NumValidacionesCompletadas = NumValidacionesCompletadas
            FROM [dbo].[PeticionesLin]
            WHERE IdLineaPeticion = @CurrentIdLineaPeticion;

            IF @NumValidacionesCompletadas >= @NumValidacionesRequeridas OR @EstadoValidacion IN ('Rechazado', 'Revisar')
            BEGIN
                SET @Sql = N'
                    UPDATE ' + QUOTENAME(@Tabla) + '
                    SET EstadoValidacionFinal = CASE 
                        WHEN @EstadoValidacion = ''Revisar'' THEN ''Pendiente''
                        ELSE @EstadoValidacion
                    END
                    WHERE ' + 
                    CASE 
                        WHEN @TipoResultado = 'Parentesco' THEN 'IdResultadoParentesco'
                        WHEN @TipoResultado = 'Genetica' THEN 'IdResultadoGenetica'
                        WHEN @TipoResultado = 'Citogenetica' THEN 'IdResultadoCitogenetica'
                        WHEN @TipoResultado = 'Andrologia' THEN 'IdResultadoAndrologia'
                    END + ' = @IdResultado;
                ';
                EXEC sp_executesql @Sql, 
                    N'@EstadoValidacion NVARCHAR(50), @IdResultado INT',
                    @EstadoValidacion, @IdResultado;

                UPDATE [dbo].[ValidacionesResultado]
                SET EsFinal = 1
                WHERE IdValidacion = @IdValidacion;

                IF @EstadoValidacion = 'Aprobado' AND @GenerarInforme = 1
                BEGIN
                    -- Precompute subquery values for INSERT
                    DECLARE @IdEntidad INT, @IdTipoDocumento INT, @IdEntidadTipo INT;
                    SELECT @IdEntidad = IdSolicitud FROM [dbo].[PeticionesLin] WHERE IdLineaPeticion = @CurrentIdLineaPeticion;
                    IF @IdEntidad IS NULL
                        THROW 50015, 'No se encontró IdSolicitud para la línea de petición.', 1;

                    SELECT @IdTipoDocumento = IdTipoDocumento FROM [dbo].[TiposDocumentos] WHERE Nombre = 'Informe';
                    IF @IdTipoDocumento IS NULL
                        THROW 50016, 'No se encontró tipo de documento Informe.', 1;

                    SELECT @IdEntidadTipo = IdEntidadTipo FROM [dbo].[Entidades] WHERE Nombre = 'Solicitudes';
                    IF @IdEntidadTipo IS NULL
                        THROW 50017, 'No se encontró entidad Solicitudes.', 1;

                    -- Generar informe
                    DECLARE @IdDocumento INT, @RutaArchivo NVARCHAR(500) = '/documents/cefegen/Resultado_' + CAST(@IdResultado AS NVARCHAR(10)) + '.pdf';
                    DECLARE @NombreArchivo NVARCHAR(255) = 'Resultado_' + CAST(@IdResultado AS NVARCHAR(10)) + '.pdf';
                    INSERT INTO [dbo].[Documentos] (
                        IdEntidad, NombreArchivo, RutaArchivo, Extension, TamanoKB, FechaSubida, SubidoPor,
                        IdTipoDocumento, IdEntidadTipo
                    )
                    VALUES (
                        @IdEntidad, @NombreArchivo, @RutaArchivo, 'pdf', 100, GETDATE(), @IdUsuario,
                        @IdTipoDocumento, @IdEntidadTipo
                    );
                    SET @IdDocumento = SCOPE_IDENTITY();

                    -- Actualizar resultado con IdDocumento
                    SET @Sql = N'
                        UPDATE ' + QUOTENAME(@Tabla) + '
                        SET IdDocumento = @IdDocumento
                        WHERE ' + 
                        CASE 
                            WHEN @TipoResultado = 'Parentesco' THEN 'IdResultadoParentesco'
                            WHEN @TipoResultado = 'Genetica' THEN 'IdResultadoGenetica'
                            WHEN @TipoResultado = 'Citogenetica' THEN 'IdResultadoCitogenetica'
                            WHEN @TipoResultado = 'Andrologia' THEN 'IdResultadoAndrologia'
                        END + ' = @IdResultado;
                    ';
                    EXEC sp_executesql @Sql, 
                        N'@IdDocumento INT, @IdResultado INT',
                        @IdDocumento, @IdResultado;

                    -- Notificar al cliente
                    DECLARE @IdNotificacion INT;
                    BEGIN TRY
                        EXEC [dbo].[sp_EnviarNotificacion]
                            @IdSolicitud = @IdEntidad,
                            @TipoNotificacion = 'ResultadoDisponible',
                            @IdUsuario = @IdUsuario,
                            @IdNotificacion = @IdNotificacion OUTPUT;
                    END TRY
                    BEGIN CATCH
                        INSERT INTO [dbo].[AuditoriaAcciones] (
                            IdUsuario, FechaAccion, Tabla, Accion, Detalles
                        )
                        VALUES (
                            @IdUsuario, GETDATE(), 'Documentos', 'ERROR',
                            'Error al enviar notificación para IdResultado: ' + CAST(@IdResultado AS NVARCHAR(10)) + ': ' + ERROR_MESSAGE()
                        );
                    END CATCH;

                    -- Marcar como notificado
                    SET @Sql = N'
                        UPDATE ' + QUOTENAME(@Tabla) + '
                        SET Notificado = 1
                        WHERE ' + 
                        CASE 
                            WHEN @TipoResultado = 'Parentesco' THEN 'IdResultadoParentesco'
                            WHEN @TipoResultado = 'Genetica' THEN 'IdResultadoGenetica'
                            WHEN @TipoResultado = 'Citogenetica' THEN 'IdResultadoCitogenetica'
                            WHEN @TipoResultado = 'Andrologia' THEN 'IdResultadoAndrologia'
                        END + ' = @IdResultado;
                    ';
                    EXEC sp_executesql @Sql, 
                        N'@IdResultado INT',
                        @IdResultado;
                END;
            END;

            -- Registrar en auditoría
            INSERT INTO [dbo].[AuditoriaAcciones] (
                IdUsuario, FechaAccion, Tabla, Accion, Detalles
            )
            VALUES (
                @IdUsuario, GETDATE(), 'ValidacionesResultado', 'INSERT',
                'Validación registrada para IdResultado: ' + CAST(@IdResultado AS NVARCHAR(10)) + ', Nivel: ' + CAST(@NivelValidacion AS NVARCHAR(10))
            );
        END
        ELSE IF @Accion = 'Consultar'
        BEGIN
            -- Consultar resultados por solicitud
            IF @IdSolicitud IS NULL
                THROW 50012, 'IdSolicitud es requerido para consultar.', 1;

            SELECT 
                r.IdResultadoParentesco AS IdResultado,
                'Parentesco' AS TipoResultado,
                r.IdLineaPeticion,
                r.FechaResultado,
                r.Resultado,
                r.EstadoValidacion,
                r.EstadoValidacionFinal,
                r.FechaValidacion,
                u.NombreCompleto AS ValidadoPor,
                r.IdDocumento,
                (SELECT COUNT(*) FROM [dbo].[ValidacionesResultado] vr WHERE vr.IdResultado = r.IdResultadoParentesco AND vr.TipoResultado = 'Parentesco') AS NumValidaciones
            FROM [dbo].[ResultadosParentesco] r
            LEFT JOIN [dbo].[Usuarios] u ON r.ValidadoPor = u.IdUsuario
            JOIN [dbo].[PeticionesLin] pl ON r.IdLineaPeticion = pl.IdLineaPeticion
            JOIN [dbo].[Peticiones] p ON pl.IdPeticion = p.IdPeticion
            WHERE p.IdSolicitud = @IdSolicitud
            UNION ALL
            SELECT 
                r.IdResultadoGenetica AS IdResultado,
                'Genetica' AS TipoResultado,
                r.IdLineaPeticion,
                r.FechaResultado,
                r.Resultado,
                r.EstadoValidacion,
                r.EstadoValidacionFinal,
                r.FechaValidacion,
                u.NombreCompleto AS ValidadoPor,
                r.IdDocumento,
                (SELECT COUNT(*) FROM [dbo].[ValidacionesResultado] vr WHERE vr.IdResultado = r.IdResultadoGenetica AND vr.TipoResultado = 'Genetica') AS NumValidaciones
            FROM [dbo].[ResultadosGenetica] r
            LEFT JOIN [dbo].[Usuarios] u ON r.ValidadoPor = u.IdUsuario
            JOIN [dbo].[PeticionesLin] pl ON r.IdLineaPeticion = pl.IdLineaPeticion
            JOIN [dbo].[Peticiones] p ON pl.IdPeticion = p.IdPeticion
            WHERE p.IdSolicitud = @IdSolicitud
            UNION ALL
            SELECT 
                r.IdResultadoCitogenetica AS IdResultado,
                'Citogenetica' AS TipoResultado,
                r.IdLineaPeticion,
                r.FechaResultado,
                r.Resultado,
                r.EstadoValidacion,
                r.EstadoValidacionFinal,
                r.FechaValidacion,
                u.NombreCompleto AS ValidadoPor,
                r.IdDocumento,
                (SELECT COUNT(*) FROM [dbo].[ValidacionesResultado] vr WHERE vr.IdResultado = r.IdResultadoCitogenetica AND vr.TipoResultado = 'Citogenetica') AS NumValidaciones
            FROM [dbo].[ResultadosCitogenetica] r
            LEFT JOIN [dbo].[Usuarios] u ON r.ValidadoPor = u.IdUsuario
            JOIN [dbo].[PeticionesLin] pl ON r.IdLineaPeticion = pl.IdLineaPeticion
            JOIN [dbo].[Peticiones] p ON pl.IdPeticion = p.IdPeticion
            WHERE p.IdSolicitud = @IdSolicitud
            UNION ALL
            SELECT 
                r.IdResultadoAndrologia AS IdResultado,
                'Andrologia' AS TipoResultado,
                r.IdLineaPeticion,
                r.FechaResultado,
                r.Resultado,
                r.EstadoValidacion,
                r.EstadoValidacionFinal,
                r.FechaValidacion,
                u.NombreCompleto AS ValidadoPor,
                r.IdDocumento,
                (SELECT COUNT(*) FROM [dbo].[ValidacionesResultado] vr WHERE vr.IdResultado = r.IdResultadoAndrologia AND vr.TipoResultado = 'Andrologia') AS NumValidaciones
            FROM [dbo].[ResultadosAndrologia] r
            LEFT JOIN [dbo].[Usuarios] u ON r.ValidadoPor = u.IdUsuario
            JOIN [dbo].[PeticionesLin] pl ON r.IdLineaPeticion = pl.IdLineaPeticion
            JOIN [dbo].[Peticiones] p ON pl.IdPeticion = p.IdPeticion
            WHERE p.IdSolicitud = @IdSolicitud;
        END
        ELSE
        BEGIN
            THROW 50013, 'Acción no válida. Use Registrar, AprobarTecnico, Validar o Consultar.', 1;
        END;

        -- Actualizar estado de la solicitud
        IF @IdLineaPeticion IS NOT NULL
        BEGIN
            UPDATE [dbo].[Solicitudes]
            SET EstadoResultados = CASE
                WHEN EXISTS (
                    SELECT 1 
                    FROM [dbo].[PeticionesLin] pl
                    LEFT JOIN [dbo].[ResultadosParentesco] rp ON pl.IdLineaPeticion = rp.IdLineaPeticion
                    LEFT JOIN [dbo].[ResultadosGenetica] rg ON pl.IdLineaPeticion = rg.IdLineaPeticion
                    LEFT JOIN [dbo].[ResultadosCitogenetica] rc ON pl.IdLineaPeticion = rc.IdLineaPeticion
                    LEFT JOIN [dbo].[ResultadosAndrologia] ra ON pl.IdLineaPeticion = ra.IdLineaPeticion
                    WHERE pl.IdPeticion IN (SELECT IdPeticion FROM [dbo].[Peticiones] WHERE IdSolicitud = (SELECT IdSolicitud FROM [dbo].[Peticiones] WHERE IdPeticion = (SELECT IdPeticion FROM [dbo].[PeticionesLin] WHERE IdLineaPeticion = @IdLineaPeticion)))
                      AND (rp.IdResultadoParentesco IS NULL AND rg.IdResultadoGenetica IS NULL 
                           AND rc.IdResultadoCitogenetica IS NULL AND ra.IdResultadoAndrologia IS NULL)
                ) THEN 'Pendiente'
                WHEN EXISTS (
                    SELECT 1 
                    FROM [dbo].[PeticionesLin] pl
                    WHERE pl.IdPeticion IN (SELECT IdPeticion FROM [dbo].[Peticiones] WHERE IdSolicitud = (SELECT IdSolicitud FROM [dbo].[Peticiones] WHERE IdPeticion = (SELECT IdPeticion FROM [dbo].[PeticionesLin] WHERE IdLineaPeticion = @IdLineaPeticion)))
                      AND pl.EstadoResultado <> 'Completado'
                ) THEN 'Parcial'
                ELSE 'Completado'
            END
            WHERE IdSolicitud = (SELECT IdSolicitud FROM [dbo].[Peticiones] WHERE IdPeticion = (SELECT IdPeticion FROM [dbo].[PeticionesLin] WHERE IdLineaPeticion = @IdLineaPeticion));
        END;

        COMMIT TRANSACTION;

        IF @Accion IN ('Registrar', 'AprobarTecnico', 'Validar')
        BEGIN
            SELECT @IdResultado AS IdResultado;
        END;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW 50014, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ListarPreciosPorPlazoEntrega]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ListarPreciosPorPlazoEntrega]
    @IdTiposPruebasConsumo INT,
    @IdTipoMuestra INT,
    @NumIntervinientes INT,
    @NumMuestras INT,
    @EsLegal BIT,
    @EsColaborador BIT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validar parámetros
        IF @IdTiposPruebasConsumo <= 0 OR @IdTipoMuestra <= 0 OR @NumIntervinientes < 0 OR @NumMuestras < 0
        BEGIN
            THROW 50001, 'Parámetros de entrada inválidos. Verifique IdTiposPruebasConsumo, IdTipoMuestra, NumIntervinientes y NumMuestras.', 1;
        END

        -- Crear tabla temporal para resultados
        DECLARE @Resultados TABLE (
            IdPlazoEntrega INT,
            PlazoEntrega NVARCHAR(100),
            Dias INT,
            Precio DECIMAL(10,2)
        );

        -- Verificar si existe la configuración
        IF NOT EXISTS (
            SELECT 1 FROM dbo.ConfiguracionesPrecio 
            WHERE IdTiposPruebasConsumo = @IdTiposPruebasConsumo 
              AND EsLegal = @EsLegal 
              AND EsColaborador = @EsColaborador
        )
        BEGIN
            THROW 50002, 'No se encontró una configuración de precio para los parámetros especificados.', 1;
        END

        -- Obtener plazos de entrega
        DECLARE @IdPlazoEntrega INT, @Descripcion NVARCHAR(100), @Dias INT, @Precio DECIMAL(10,2);
        DECLARE plazo_cursor CURSOR FOR
        SELECT IdPlazoEntrega, Descripcion, Dias
        FROM dbo.PlazosEntrega;

        OPEN plazo_cursor;
        FETCH NEXT FROM plazo_cursor INTO @IdPlazoEntrega, @Descripcion, @Dias;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Calcular precio
            SET @Precio = NULL;
            EXEC dbo.sp_CalcularPrecioTotal
                @IdTiposPruebasConsumo = @IdTiposPruebasConsumo,
                @EsLegal = @EsLegal,
                @EsColaborador = @EsColaborador,
                @IdTipoMuestra = @IdTipoMuestra,
                @IdPlazoEntrega = @IdPlazoEntrega,
                @NumIntervinientes = @NumIntervinientes,
                @NumMuestras = @NumMuestras,
                @IdPeticion = NULL;

            IF @Precio IS NOT NULL
            BEGIN
                INSERT INTO @Resultados (IdPlazoEntrega, PlazoEntrega, Dias, Precio)
                VALUES (@IdPlazoEntrega, @Descripcion, @Dias, @Precio);
            END

            FETCH NEXT FROM plazo_cursor INTO @IdPlazoEntrega, @Descripcion, @Dias;
        END;

        CLOSE plazo_cursor;
        DEALLOCATE plazo_cursor;

        -- Devolver resultados
        SELECT 
            IdPlazoEntrega,
            PlazoEntrega,
            Dias,
            Precio
        FROM @Resultados
        ORDER BY Dias;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ListarPreciosPorPlazoEntregaFlexible]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ListarPreciosPorPlazoEntregaFlexible]
    @IdTiposPruebasConsumo INT,
    @IdTipoMuestra INT,
    @NumIntervinientes INT,
    @NumMuestras INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validar parámetros
        IF @IdTiposPruebasConsumo <= 0 OR @IdTipoMuestra <= 0 OR @NumIntervinientes < 0 OR @NumMuestras < 0
        BEGIN
            THROW 50001, 'Parámetros de entrada inválidos. Verifique IdTiposPruebasConsumo, IdTipoMuestra, NumIntervinientes y NumMuestras.', 1;
        END

        -- Crear tabla temporal para resultados
        DECLARE @Resultados TABLE (
            IdPlazoEntrega INT,
            PlazoEntrega NVARCHAR(100),
            Dias INT,
            Precio DECIMAL(10,2),
            EsLegal BIT,
            EsColaborador BIT,
            NumIntervinientes INT,
            NumMuestras INT
        );

        -- Obtener plazos de entrega
        DECLARE @Plazos TABLE (IdPlazoEntrega INT, Descripcion NVARCHAR(100), Dias INT);
        INSERT INTO @Plazos
        SELECT IdPlazoEntrega, Descripcion, Dias
        FROM dbo.PlazosEntrega;

        -- Iterar sobre todas las configuraciones de precios
        DECLARE @EsLegal BIT, @EsColaborador BIT, @Precio DECIMAL(10,2);
        DECLARE config_cursor CURSOR FOR
        SELECT EsLegal, EsColaborador
        FROM dbo.ConfiguracionesPrecio
        WHERE IdTiposPruebasConsumo = @IdTiposPruebasConsumo;

        OPEN config_cursor;
        FETCH NEXT FROM config_cursor INTO @EsLegal, @EsColaborador;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Iterar sobre plazos de entrega
            DECLARE @IdPlazoEntrega INT, @Descripcion NVARCHAR(100), @Dias INT;
            DECLARE plazo_cursor CURSOR FOR
            SELECT IdPlazoEntrega, Descripcion, Dias
            FROM @Plazos;

            OPEN plazo_cursor;
            FETCH NEXT FROM plazo_cursor INTO @IdPlazoEntrega, @Descripcion, @Dias;

            WHILE @@FETCH_STATUS = 0
            BEGIN
                -- Calcular precio
                SET @Precio = NULL;
                EXEC dbo.sp_CalcularPrecioTotal
                    @IdTiposPruebasConsumo = @IdTiposPruebasConsumo,
                    @EsLegal = @EsLegal,
                    @EsColaborador = @EsColaborador,
                    @IdTipoMuestra = @IdTipoMuestra,
                    @IdPlazoEntrega = @IdPlazoEntrega,
                    @NumIntervinientes = @NumIntervinientes,
                    @NumMuestras = @NumMuestras,
                    @IdPeticion = NULL;

                IF @Precio IS NOT NULL
                BEGIN
                    INSERT INTO @Resultados (IdPlazoEntrega, PlazoEntrega, Dias, Precio, EsLegal, EsColaborador, NumIntervinientes, NumMuestras)
                    VALUES (@IdPlazoEntrega, @Descripcion, @Dias, @Precio, @EsLegal, @EsColaborador, @NumIntervinientes, @NumMuestras);
                END

                FETCH NEXT FROM plazo_cursor INTO @IdPlazoEntrega, @Descripcion, @Dias;
            END;

            CLOSE plazo_cursor;
            DEALLOCATE plazo_cursor;

            FETCH NEXT FROM config_cursor INTO @EsLegal, @EsColaborador;
        END;

        CLOSE config_cursor;
        DEALLOCATE config_cursor;

        -- Devolver resultados (coincidencias exactas o todas las configuraciones)
        IF EXISTS (
            SELECT 1 FROM @Resultados 
            WHERE NumIntervinientes = @NumIntervinientes 
              AND NumMuestras = @NumMuestras
              AND Precio IS NOT NULL
        )
        BEGIN
            SELECT 
                IdPlazoEntrega,
                PlazoEntrega,
                Dias,
                Precio,
                EsLegal,
                EsColaborador
            FROM @Resultados
            WHERE NumIntervinientes = @NumIntervinientes 
              AND NumMuestras = @NumMuestras
              AND Precio IS NOT NULL
            ORDER BY Dias;
        END
        ELSE
        BEGIN
            SELECT 
                IdPlazoEntrega,
                PlazoEntrega,
                Dias,
                Precio,
                EsLegal,
                EsColaborador,
                NumIntervinientes,
                NumMuestras
            FROM @Resultados
            WHERE Precio IS NOT NULL
            ORDER BY Dias;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerPrecioEspecifico]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerPrecioEspecifico]
    @IdTiposPruebasConsumo INT,
    @IdTipoMuestra INT,
    @NumIntervinientes INT,
    @NumMuestras INT,
    @IdPlazoEntrega INT,
    @EsLegal BIT,
    @EsColaborador BIT,
    @Precio DECIMAL(10,2) OUTPUT,
    @IdConfiguracion INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validar parámetros
        IF @IdTiposPruebasConsumo <= 0 OR @IdTipoMuestra <= 0 OR @NumIntervinientes < 0 OR @NumMuestras < 0 OR @IdPlazoEntrega <= 0
        BEGIN
            THROW 50001, 'Parámetros de entrada inválidos. Verifique IdTiposPruebasConsumo, IdTipoMuestra, NumIntervinientes, NumMuestras y IdPlazoEntrega.', 1;
        END

        -- Verificar si existe la configuración
        SELECT TOP 1 
            @IdConfiguracion = IdConfiguracion
        FROM dbo.ConfiguracionesPrecio
        WHERE IdTiposPruebasConsumo = @IdTiposPruebasConsumo
          AND EsLegal = @EsLegal
          AND EsColaborador = @EsColaborador;

        IF @IdConfiguracion IS NULL
        BEGIN
            SET @Precio = 0;
            SET @IdConfiguracion = NULL;
            RETURN;
        END

        -- Calcular precio
        EXEC dbo.sp_CalcularPrecioTotal
            @IdTiposPruebasConsumo = @IdTiposPruebasConsumo,
            @EsLegal = @EsLegal,
            @EsColaborador = @EsColaborador,
            @IdTipoMuestra = @IdTipoMuestra,
            @IdPlazoEntrega = @IdPlazoEntrega,
            @NumIntervinientes = @NumIntervinientes,
            @NumMuestras = @NumMuestras,
            @IdPeticion = NULL;

        IF @Precio IS NULL
        BEGIN
            SET @Precio = 0;
            SET @IdConfiguracion = NULL;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ProcesarNotificacionesPendientes]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ProcesarNotificacionesPendientes]
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validar usuario
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuario AND Activo = 1)
            THROW 50001, 'El usuario especificado no existe o no está activo.', 1;

        -- Procesar cambios de estado de solicitudes
        DECLARE @IdSolicitud INT, @IdEstado INT;
        DECLARE solicitud_cursor CURSOR FOR
        SELECT s.IdSolicitud, s.IdEstado
        FROM [dbo].[Solicitudes] s
        JOIN [dbo].[Estados] e ON s.IdEstado = e.IdEstado
        WHERE e.DisparaNotificacion = 1
          AND NOT EXISTS (
              SELECT 1 
              FROM [dbo].[Envios] 
              WHERE CodPaciente = s.IdSolicitante 
                AND TipoNotificacion = 'EstadoSolicitud' 
                AND Fecha > DATEADD(MINUTE, -5, GETDATE())
          )
          AND NOT EXISTS (
              SELECT 1 
              FROM [dbo].[NotificacionesSMS] 
              WHERE IdSolicitud = s.IdSolicitud 
                AND FechaEnvio > DATEADD(MINUTE, -5, GETDATE())
          );

        OPEN solicitud_cursor;
        FETCH NEXT FROM solicitud_cursor INTO @IdSolicitud, @IdEstado;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @IdNotificacion INT;
            EXEC [dbo].[sp_EnviarNotificacion]
                @IdSolicitud = @IdSolicitud,
                @TipoNotificacion = 'EstadoSolicitud',
                @IdUsuario = @IdUsuario,
                @IdNotificacion = @IdNotificacion OUTPUT;

            FETCH NEXT FROM solicitud_cursor INTO @IdSolicitud, @IdEstado;
        END;

        CLOSE solicitud_cursor;
        DEALLOCATE solicitud_cursor;

        -- Procesar informes disponibles
        DECLARE informe_cursor CURSOR FOR
        SELECT ig.IdSolicitud
        FROM [dbo].[InformesGenerados] ig
        WHERE NOT EXISTS (
            SELECT 1 
            FROM [dbo].[Envios] 
            WHERE CodPaciente = (SELECT IdSolicitante FROM [dbo].[Solicitudes] WHERE IdSolicitud = ig.IdSolicitud)
              AND TipoNotificacion = 'ResultadoDisponible'
              AND Fecha > ig.FechaGeneracion
        )
        AND NOT EXISTS (
            SELECT 1 
            FROM [dbo].[NotificacionesSMS] 
            WHERE IdSolicitud = ig.IdSolicitud 
              AND FechaEnvio > ig.FechaGeneracion
        );

        OPEN informe_cursor;
        FETCH NEXT FROM informe_cursor INTO @IdSolicitud;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC [dbo].[sp_EnviarNotificacion]
                @IdSolicitud = @IdSolicitud,
                @TipoNotificacion = 'ResultadoDisponible',
                @IdUsuario = @IdUsuario,
                @IdNotificacion = @IdNotificacion OUTPUT;

            FETCH NEXT FROM informe_cursor INTO @IdSolicitud;
        END;

        CLOSE informe_cursor;
        DEALLOCATE informe_cursor;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW 50006, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarAcreditacion]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RegistrarAcreditacion]
    @Nombre NVARCHAR(100),
    @EntidadAcreditadora NVARCHAR(100),
    @FechaEmision DATE,
    @FechaExpiracion DATE,
    @Estado NVARCHAR(50),
    @Documento VARBINARY(MAX) = NULL,
    @NombreArchivo NVARCHAR(255) = NULL,
    @IdUsuarioRegistro INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar parámetros
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuarioRegistro AND Activo = 1)
            THROW 50001, 'El usuario especificado no existe o no está activo.', 1;
        IF @Estado NOT IN ('Vigente', 'Expirada', 'En Proceso')
            THROW 50002, 'El estado debe ser Vigente, Expirada o En Proceso.', 1;
        IF @FechaExpiracion <= @FechaEmision
            THROW 50003, 'La fecha de expiración debe ser posterior a la fecha de emisión.', 1;

        -- Insertar acreditación
        INSERT INTO [dbo].[Acreditaciones] (
            Nombre, EntidadAcreditadora, FechaEmision, FechaExpiracion, Estado, Documento, NombreArchivo, IdUsuarioRegistro
        )
        VALUES (
            @Nombre, @EntidadAcreditadora, @FechaEmision, @FechaExpiracion, @Estado, @Documento, @NombreArchivo, @IdUsuarioRegistro
        );

        DECLARE @IdAcreditacion INT = SCOPE_IDENTITY();

        -- Registrar en auditoría
        INSERT INTO [dbo].[AuditoriaAcciones] (
            IdUsuario, FechaAccion, Tabla, Accion, Detalles
        )
        VALUES (
            @IdUsuarioRegistro, GETDATE(), 'Acreditaciones', 'INSERT',
            'Acreditación registrada con IdAcreditacion: ' + CAST(@IdAcreditacion AS NVARCHAR(10))
        );

        COMMIT TRANSACTION;

        SELECT 
            IdAcreditacion,
            Nombre,
            EntidadAcreditadora,
            FechaEmision,
            FechaExpiracion,
            Estado,
            NombreArchivo
        FROM [dbo].[Acreditaciones]
        WHERE IdAcreditacion = @IdAcreditacion;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarAuditoriaCalidad]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RegistrarAuditoriaCalidad]
    @TipoAuditoria NVARCHAR(50),
    @FechaAuditoria DATETIME,
    @Resultado NVARCHAR(100),
    @Observaciones NVARCHAR(MAX) = NULL,
    @Documento VARBINARY(MAX) = NULL,
    @NombreArchivo NVARCHAR(255) = NULL,
    @IdUsuarioResponsable INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar parámetros
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuarioResponsable AND Activo = 1)
        BEGIN
            -- Return list of active users for debugging
            SELECT IdUsuario, NombreUsuario, NombreCompleto
            FROM [dbo].[Usuarios]
            WHERE Activo = 1;
            THROW 50001, 'El usuario responsable especificado no existe o no está activo. Consulte la lista de usuarios activos devuelta.', 1;
        END
        IF @TipoAuditoria NOT IN ('Interna', 'Externa')
            THROW 50002, 'El tipo de auditoría debe ser Interna o Externa.', 1;
        IF @Resultado NOT IN ('Conforme', 'No Conforme', 'Pendiente')
            THROW 50003, 'El resultado debe ser Conforme, No Conforme o Pendiente.', 1;

        -- Insertar auditoría
        INSERT INTO [dbo].[AuditoriasCalidad] (
            TipoAuditoria, FechaAuditoria, Resultado, Observaciones, Documento, NombreArchivo, IdUsuarioResponsable
        )
        VALUES (
            @TipoAuditoria, @FechaAuditoria, @Resultado, @Observaciones, @Documento, @NombreArchivo, @IdUsuarioResponsable
        );

        DECLARE @IdAuditoria INT = SCOPE_IDENTITY();

        -- Registrar en auditoría
        INSERT INTO [dbo].[AuditoriaAcciones] (
            IdUsuario, FechaAccion, Tabla, Accion, Detalles
        )
        VALUES (
            @IdUsuarioResponsable, GETDATE(), 'AuditoriasCalidad', 'INSERT',
            'Auditoría registrada con IdAuditoria: ' + CAST(@IdAuditoria AS NVARCHAR(10))
        );

        COMMIT TRANSACTION;

        SELECT 
            IdAuditoria,
            TipoAuditoria,
            FechaAuditoria,
            Resultado,
            Observaciones,
            NombreArchivo
        FROM [dbo].[AuditoriasCalidad]
        WHERE IdAuditoria = @IdAuditoria;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW 50004, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarUsuario]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RegistrarUsuario]
    @NombreUsuario nvarchar(50),
    @Email nvarchar(100),
    @HashPassword nvarchar(255),
    @IdRol int,
    @IdUsuarioCreador int
AS
BEGIN
    INSERT INTO Usuarios (NombreUsuario, Email, HashPassword, IdRol, Activo, FechaCreacion)
    VALUES (@NombreUsuario, @Email, @HashPassword, @IdRol, 1, GETDATE());

    DECLARE @IdUsuario int = SCOPE_IDENTITY();
    INSERT INTO AuditoriaAcciones (IdUsuario, Accion, FechaAccion, Detalles)
    VALUES (@IdUsuarioCreador, 'RegistrarUsuario', GETDATE(), 
            CONCAT('Nuevo usuario: ', @NombreUsuario, ', Id: ', @IdUsuario));
END;


GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarCasoForense]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ValidarCasoForense]
    @IdSolicitud INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud)
        THROW 50001, 'La solicitud especificada no existe.', 1;

    -- Verificar si es un caso forense
    IF EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud AND EsForense = 1)
    BEGIN
        -- Validar muestras
        EXEC [dbo].[sp_ValidarMuestrasSolicitud] @IdSolicitud;

        -- Validar consentimiento
        EXEC [dbo].[sp_ValidarConsentimientoSolicitud] @IdSolicitud;

        -- Validar número mínimo de marcadores
        EXEC [dbo].[sp_ValidarMinimoMarcadores] @IdSolicitud, 15;

        -- Validar que haya al menos dos muestras válidas (para casos forenses)
        DECLARE @NumMuestras INT;
        SELECT @NumMuestras = COUNT(*)
        FROM [dbo].[Muestras]
        WHERE IdSolicitud = @IdSolicitud AND Valida = 1;

        IF @NumMuestras < 2
            THROW 50009, 'Un caso forense requiere al menos dos muestras válidas.', 1;
    END;

    SELECT 'Validación completada para caso forense' AS Mensaje;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarConsentimientoSolicitud]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ValidarConsentimientoSolicitud]
    @IdSolicitud INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud)
        THROW 50001, 'La solicitud especificada no existe.', 1;

    IF NOT EXISTS (SELECT 1 FROM [dbo].[Consentimientos] WHERE IdSolicitud = @IdSolicitud)
        THROW 50008, 'No se ha registrado un consentimiento para la solicitud.', 1;

    SELECT COUNT(*) AS NumeroConsentimientos
    FROM [dbo].[Consentimientos]
    WHERE IdSolicitud = @IdSolicitud;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarMinimoMarcadores]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_ValidarMinimoMarcadores]
    @IdSolicitud INT,
    @MinimoMarcadores INT = 24  -- Actualizado a 24 marcadores
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NumMarcadores INT;

    SELECT @NumMarcadores = COUNT(DISTINCT rp.IdMarcador)
    FROM [dbo].[ResultadosParentesco] rp
    JOIN [dbo].[PeticionesLin] pl ON rp.IdLineaPeticion = pl.IdLineaPeticion
    JOIN [dbo].[Peticiones] p ON pl.IdPeticion = p.IdPeticion
    WHERE p.IdSolicitud = @IdSolicitud;

    IF @NumMarcadores < @MinimoMarcadores
        THROW 50006, 'Número insuficiente de marcadores genéticos para la solicitud. Se requieren al menos 24 marcadores.', 1;

    SELECT @NumMarcadores AS NumeroMarcadores;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarMuestrasSolicitud]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ValidarMuestrasSolicitud]
    @IdSolicitud INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM [dbo].[Solicitudes] WHERE IdSolicitud = @IdSolicitud)
        THROW 50001, 'La solicitud especificada no existe.', 1;

    IF EXISTS (SELECT 1 FROM [dbo].[Muestras] WHERE IdSolicitud = @IdSolicitud AND Valida = 0)
        THROW 50007, 'Existen muestras no válidas para la solicitud.', 1;

    SELECT COUNT(*) AS NumeroMuestrasValidas
    FROM [dbo].[Muestras]
    WHERE IdSolicitud = @IdSolicitud AND Valida = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarResultado]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ValidarResultado]
    @IdResultado INT,
    @TipoResultado NVARCHAR(50),
    @IdUsuarioValidador INT,
    @EstadoValidacion NVARCHAR(50),
    @Observaciones NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar parámetros
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE IdUsuario = @IdUsuarioValidador AND Activo = 1)
            THROW 50001, 'El usuario validador especificado no existe o no está activo.', 1;
        IF @EstadoValidacion NOT IN ('Validado', 'Rechazado')
            THROW 50002, 'El estado de validación debe ser Validado o Rechazado.', 1;
        IF @TipoResultado NOT IN ('Parentesco', 'Genetica', 'Citogenetica', 'Andrologia')
            THROW 50003, 'El tipo de resultado no es válido.', 1;

        -- Validar que el resultado existe y requiere validación
        DECLARE @RequiereValidacion BIT;
        DECLARE @Tabla NVARCHAR(50);
        DECLARE @Sql NVARCHAR(MAX);

        IF @TipoResultado = 'Parentesco'
        BEGIN
            SET @Tabla = '[dbo].[ResultadosParentesco]';
            IF NOT EXISTS (SELECT 1 FROM [dbo].[ResultadosParentesco] WHERE IdResultadoParentesco = @IdResultado)
                THROW 50004, 'El resultado de parentesco especificado no existe.', 1;
            SELECT @RequiereValidacion = t.RequiereValidacion
            FROM [dbo].[ResultadosParentesco] rp
            JOIN [dbo].[PeticionesLin] pl ON rp.IdLineaPeticion = pl.IdLineaPeticion
            JOIN [dbo].[TiposPruebasConsumo] t ON pl.IdTiposPruebasConsumo = t.IdTipoPruebaConsumo
            WHERE rp.IdResultadoParentesco = @IdResultado;
        END
        ELSE IF @TipoResultado = 'Genetica'
        BEGIN
            SET @Tabla = '[dbo].[ResultadosGenetica]';
            IF NOT EXISTS (SELECT 1 FROM [dbo].[ResultadosGenetica] WHERE IdResultadoGenetica = @IdResultado)
                THROW 50004, 'El resultado genético especificado no existe.', 1;
            SELECT @RequiereValidacion = t.RequiereValidacion
            FROM [dbo].[ResultadosGenetica] rg
            JOIN [dbo].[PeticionesLin] pl ON rg.IdLineaPeticion = pl.IdLineaPeticion
            JOIN [dbo].[TiposPruebasConsumo] t ON pl.IdTiposPruebasConsumo = t.IdTipoPruebaConsumo
            WHERE rg.IdResultadoGenetica = @IdResultado;
        END
        -- Añadir casos para Citogenetica y Andrologia

        IF @RequiereValidacion = 0
            THROW 50005, 'Este resultado no requiere validación.', 1;

        -- Actualizar el resultado
        SET @Sql = N'
            UPDATE ' + QUOTENAME(@Tabla) + '
            SET ValidadoPor = @IdUsuarioValidador,
                EstadoValidacion = @EstadoValidacion,
                FechaValidacion = GETDATE()
            WHERE ' + 
            CASE 
                WHEN @TipoResultado = 'Parentesco' THEN 'IdResultadoParentesco'
                WHEN @TipoResultado = 'Genetica' THEN 'IdResultadoGenetica'
                -- Añadir casos para Citogenetica y Andrologia
            END + ' = @IdResultado;
        ';
        EXEC sp_executesql @Sql, 
            N'@IdUsuarioValidador INT, @EstadoValidacion NVARCHAR(50), @IdResultado INT',
            @IdUsuarioValidador, @EstadoValidacion, @IdResultado;

        -- Insertar en ValidacionesResultado
        INSERT INTO [dbo].[ValidacionesResultado] (
            IdResultado, TipoResultado, IdUsuarioValidador, EstadoValidacion, Observaciones
        )
        VALUES (
            @IdResultado, @TipoResultado, @IdUsuarioValidador, @EstadoValidacion, @Observaciones
        );

        DECLARE @IdValidacion INT = SCOPE_IDENTITY();

        -- Registrar en auditoría
        INSERT INTO [dbo].[AuditoriaAcciones] (
            IdUsuario, FechaAccion, Tabla, Accion, Detalles
        )
        VALUES (
            @IdUsuarioValidador, GETDATE(), 'ValidacionesResultado', 'INSERT',
            'Validación registrada con IdValidacion: ' + CAST(@IdValidacion AS NVARCHAR(10)) + ' para ' + @TipoResultado
        );

        COMMIT TRANSACTION;

        SELECT 
            IdValidacion,
            IdResultado,
            TipoResultado,
            EstadoValidacion,
            Observaciones,
            FechaValidacion
        FROM [dbo].[ValidacionesResultado]
        WHERE IdValidacion = @IdValidacion;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH;
END;
GO
/****** Object:  Trigger [dbo].[TRG_AuditarAcreditaciones]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_AuditarAcreditaciones]
ON [dbo].[Acreditaciones]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[AuditoriaAcciones] (
        IdUsuario, FechaAccion, Tabla, Accion, Detalles
    )
    SELECT 
        IdUsuarioRegistro, 
        GETDATE(), 
        'Acreditaciones', 
        CASE WHEN EXISTS (SELECT 1 FROM deleted) THEN 'UPDATE' ELSE 'INSERT' END,
        'Acreditación ' + CASE WHEN EXISTS (SELECT 1 FROM deleted) THEN 'actualizada' ELSE 'creada' END + ' con IdAcreditacion: ' + CAST(i.IdAcreditacion AS NVARCHAR(10))
    FROM inserted i;
END;
GO
ALTER TABLE [dbo].[Acreditaciones] ENABLE TRIGGER [TRG_AuditarAcreditaciones]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarCalidad]    Script Date: 04/07/2025 19:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_AuditarCalidad]
ON [dbo].[AuditoriasCalidad]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[AuditoriaAcciones] (
        IdUsuario, FechaAccion, Tabla, Accion, Detalles
    )
    SELECT 
        IdUsuarioResponsable, 
        GETDATE(), 
        'AuditoriasCalidad', 
        CASE WHEN EXISTS (SELECT 1 FROM deleted) THEN 'UPDATE' ELSE 'INSERT' END,
        'Auditoría ' + CASE WHEN EXISTS (SELECT 1 FROM deleted) THEN 'actualizada' ELSE 'creada' END + ' con IdAuditoria: ' + CAST(i.IdAuditoria AS NVARCHAR(10))
    FROM inserted i;
END;
GO
ALTER TABLE [dbo].[AuditoriasCalidad] ENABLE TRIGGER [TRG_AuditarCalidad]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarDocumentos]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[TRG_AuditarDocumentos]
ON [dbo].[Documentos]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[AuditoriaAcciones] (
        IdUsuario, FechaAccion, Tabla, Accion, Detalles, IdDocumento
    )
    SELECT 
        i.SubidoPor, 
        GETDATE(), 
        'Documentos', 
        CASE 
            WHEN EXISTS (SELECT 1 FROM deleted) AND EXISTS (SELECT 1 FROM inserted) THEN 'UPDATE'
            WHEN EXISTS (SELECT 1 FROM deleted) THEN 'DELETE'
            ELSE 'INSERT'
        END,
        'Documento ' + 
        CASE 
            WHEN EXISTS (SELECT 1 FROM deleted) AND EXISTS (SELECT 1 FROM inserted) THEN 'actualizado'
            WHEN EXISTS (SELECT 1 FROM deleted) THEN 'eliminado'
            ELSE 'insertado'
        END + ' con IdDocumento: ' + CAST(COALESCE(i.IdDocumento, d.IdDocumento) AS NVARCHAR(10)),
        COALESCE(i.IdDocumento, d.IdDocumento)
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.IdDocumento = d.IdDocumento;
END;
GO
ALTER TABLE [dbo].[Documentos] ENABLE TRIGGER [TRG_AuditarDocumentos]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarIndiceParentesco]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_AuditarIndiceParentesco]
ON [dbo].[IndiceParentesco]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[AuditoriaAcciones] (IdUsuario, FechaAccion, Modulo, TipoAccion, Detalle)
    SELECT
        IdUsuarioAnalista,
        GETDATE(),
        'IndiceParentesco',
        CASE WHEN EXISTS (SELECT * FROM deleted) THEN 'UPDATE' ELSE 'INSERT' END,
        'Registro modificado/creado con IdIndiceParentesco: ' + CAST(i.IdIndiceParentesco AS NVARCHAR(10))
    FROM inserted i;
END;
GO
ALTER TABLE [dbo].[IndiceParentesco] ENABLE TRIGGER [TRG_AuditarIndiceParentesco]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarInformesGenerados]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_AuditarInformesGenerados]
ON [dbo].[InformesGenerados]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[AuditoriaAcciones] (IdUsuario, FechaAccion, Tabla, Accion, Detalles)
    SELECT
        IdUsuario,
        GETDATE(),
        'InformesGenerados',
        'INSERT',
        'Informe generado con IdInforme: ' + CAST(i.IdInforme AS NVARCHAR(10)) + ' para IdSolicitud: ' + CAST(i.IdSolicitud AS NVARCHAR(10))
    FROM inserted i;
END;
GO
ALTER TABLE [dbo].[InformesGenerados] ENABLE TRIGGER [TRG_AuditarInformesGenerados]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarMovimientosMuestras]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_AuditarMovimientosMuestras]
ON [dbo].[MovimientosMuestras]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[AuditoriaAcciones] (IdUsuario, FechaAccion, Modulo, TipoAccion, Detalle)
    SELECT
        IdUsuario,
        GETDATE(),
        'MovimientosMuestras',
        'INSERT',
        'Movimiento registrado para IdMuestra: ' + CAST(i.IdMuestra AS NVARCHAR(10))
    FROM inserted i;
END;
GO
ALTER TABLE [dbo].[MovimientosMuestras] ENABLE TRIGGER [TRG_AuditarMovimientosMuestras]
GO
/****** Object:  Trigger [dbo].[TRG_SetCodigoMuestra]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TRG_SetCodigoMuestra]
ON [dbo].[Muestras]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE m
        SET 
            CodigoMuestra = COALESCE(
                TRIM(CONCAT(
                    CAST(s.CodigoSolicitud AS VARCHAR(10)),
                    '-',
                    COALESCE(i.IdTipoInterviniente, 'UNK'),
                    CASE 
                        WHEN ins.Intentos = 1 THEN '' 
                        ELSE '-' + CAST(ins.Intentos AS VARCHAR(10))
                    END
                )),
                'MUE-' + CAST(ins.IdMuestra AS VARCHAR(10))
            ),
            QrCodeContent = COALESCE(
                (
                    '{' +
                    '"IdMuestra":"' + CAST(ins.IdMuestra AS NVARCHAR(10)) + '",' +
                    '"CodigoMuestra":"' + 
                        COALESCE(
                            TRIM(CONCAT(
                                CAST(s.CodigoSolicitud AS VARCHAR(10)),
                                '-',
                                COALESCE(i.IdTipoInterviniente, 'UNK'),
                                CASE 
                                    WHEN ins.Intentos = 1 THEN '' 
                                    ELSE '-' + CAST(ins.Intentos AS VARCHAR(10))
                                END
                            )),
                            'MUE-' + CAST(ins.IdMuestra AS VARCHAR(10))
                        ) + '",' +
                    '"IdSolicitud":"' + CAST(ISNULL(ins.IdSolicitud, 0) AS NVARCHAR(10)) + '",' +
                    '"IdInterviniente":"' + CAST(ISNULL(ins.IdInterviniente, 0) AS NVARCHAR(10)) + '",' +
                    '"TipoMuestra":"' + CAST(ISNULL(ins.TipoMuestra, 0) AS NVARCHAR(10)) + '",' +
                    '"FechaRecepcion":"' + ISNULL(CONVERT(NVARCHAR(10), ins.FechaRecepcion, 120), '') + '",' +
                    '"Valida":' + CASE WHEN ISNULL(ins.Valida, 0) = 1 THEN 'true' ELSE 'false' END + ',' +
                    '"Intentos":"' + CAST(ISNULL(ins.Intentos, 1) AS NVARCHAR(10)) + '",' +
                    '"IdEstado":"' + CAST(ISNULL(s.IdEstado, 1) AS NVARCHAR(10)) + '"' +
                    '}'
                ),
                '{}'
            ),
            BarcodeQrCode = COALESCE(
                'MUE-' + CAST(ins.IdMuestra AS NVARCHAR(10)) + '-' + LEFT(CAST(NEWID() AS NVARCHAR(36)), 8),
                'MUE-' + CAST(ins.IdMuestra AS NVARCHAR(10))
            )
        FROM [dbo].[Muestras] m
        INNER JOIN inserted ins ON m.IdMuestra = ins.IdMuestra
        LEFT JOIN [dbo].[Solicitudes] s ON ins.IdSolicitud = s.IdSolicitud
        LEFT JOIN [dbo].[Intervinientes] i ON ins.IdInterviniente = i.IdInterviniente;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
ALTER TABLE [dbo].[Muestras] ENABLE TRIGGER [TRG_SetCodigoMuestra]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarResultados]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[TRG_AuditarResultados]
ON [dbo].[ResultadosParentesco]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[AuditoriaAcciones] (
        IdUsuario, FechaAccion, Tabla, Accion, Detalles
    )
    SELECT 
        i.ValidadoPor, 
        GETDATE(), 
        'ResultadosParentesco', 
        CASE WHEN EXISTS (SELECT 1 FROM deleted) THEN 'UPDATE' ELSE 'INSERT' END,
        'Resultado ' + CASE WHEN EXISTS (SELECT 1 FROM deleted) THEN 'actualizado' ELSE 'insertado' END + 
        ' con IdResultadoParentesco: ' + CAST(i.IdResultadoParentesco AS NVARCHAR(10))
    FROM inserted i;
END;
GO
ALTER TABLE [dbo].[ResultadosParentesco] ENABLE TRIGGER [TRG_AuditarResultados]
GO
/****** Object:  Trigger [dbo].[TRG_NotificarCambioEstado]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_NotificarCambioEstado]
ON [dbo].[Solicitudes]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(IdEstado)
    BEGIN
        DECLARE @IdSolicitud INT, @IdEstado INT, @IdUsuario INT;
        DECLARE solicitud_cursor CURSOR FOR
        SELECT i.IdSolicitud, i.IdEstado, ISNULL(i.IdSolicitante, 1)
        FROM inserted i
        JOIN [dbo].[Estados] e ON i.IdEstado = e.IdEstado
        WHERE e.DisparaNotificacion = 1;

        OPEN solicitud_cursor;
        FETCH NEXT FROM solicitud_cursor INTO @IdSolicitud, @IdEstado, @IdUsuario;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @IdNotificacion INT;
            EXEC [dbo].[sp_EnviarNotificacion]
                @IdSolicitud = @IdSolicitud,
                @TipoNotificacion = 'EstadoSolicitud',
                @IdUsuario = @IdUsuario,
                @IdNotificacion = @IdNotificacion OUTPUT;

            FETCH NEXT FROM solicitud_cursor INTO @IdSolicitud, @IdEstado, @IdUsuario;
        END;

        CLOSE solicitud_cursor;
        DEALLOCATE solicitud_cursor;
    END;
END;
GO
ALTER TABLE [dbo].[Solicitudes] ENABLE TRIGGER [TRG_NotificarCambioEstado]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarCambiosUsuarios]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TRG_AuditarCambiosUsuarios]
ON [dbo].[Usuarios]
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaAcciones (IdUsuario, Accion, FechaAccion, Detalles)
    SELECT 
        i.IdUsuario, 
        'ActualizarUsuario', 
        GETDATE(), 
        CONCAT('Usuario: ', i.NombreUsuario, ', Cambios: ', 
               CASE WHEN i.Activo != d.Activo THEN 'Activo cambiado' ELSE '' END,
               CASE WHEN i.HashPassword != d.HashPassword THEN ', Contraseña cambiada' ELSE '' END)
    FROM inserted i
    JOIN deleted d ON i.IdUsuario = d.IdUsuario
    WHERE i.Activo != d.Activo OR i.HashPassword != d.HashPassword;
END;
GO
ALTER TABLE [dbo].[Usuarios] ENABLE TRIGGER [TRG_AuditarCambiosUsuarios]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarUsuarios]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_AuditarUsuarios]
ON [dbo].[Usuarios]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[AuditoriaAcciones] (
        IdUsuario,
        FechaAccion,
        Tabla,
        Accion,
        Detalles,
        IdDocumento
    )
    SELECT
        COALESCE(i.IdUsuario, d.IdUsuario),
        GETDATE(),
        'Usuarios',
        CASE
            WHEN i.IdUsuario IS NOT NULL AND d.IdUsuario IS NULL THEN 'Insert'
            WHEN i.IdUsuario IS NOT NULL AND d.IdUsuario IS NOT NULL THEN 'Update'
            ELSE 'Delete'
        END,
        CASE
            WHEN i.IdUsuario IS NOT NULL AND d.IdUsuario IS NULL THEN 
                'Usuario creado: ' + i.NombreUsuario + ', Email: ' + i.Email
            WHEN i.IdUsuario IS NOT NULL AND d.IdUsuario IS NOT NULL THEN 
                'Usuario actualizado: ' + i.NombreUsuario + ', Email: ' + i.Email
            ELSE 
                'Usuario eliminado: ' + d.NombreUsuario + ', Email: ' + d.Email
        END,
        NULL -- IdDocumento is NULL as no document is associated with user actions
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.IdUsuario = d.IdUsuario;
END;
GO
ALTER TABLE [dbo].[Usuarios] ENABLE TRIGGER [TRG_AuditarUsuarios]
GO
/****** Object:  Trigger [dbo].[TRG_AuditarValidaciones]    Script Date: 04/07/2025 19:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TRG_AuditarValidaciones]
ON [dbo].[ValidacionesResultado]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[AuditoriaAcciones] (
        IdUsuario, FechaAccion, Tabla, Accion, Detalles
    )
    SELECT 
        IdUsuarioValidador, 
        GETDATE(), 
        'ValidacionesResultado', 
        'INSERT',
        'Validación registrada con IdValidacion: ' + CAST(i.IdValidacion AS NVARCHAR(10)) + ' para ' + i.TipoResultado
    FROM inserted i;
END;
GO
ALTER TABLE [dbo].[ValidacionesResultado] ENABLE TRIGGER [TRG_AuditarValidaciones]
GO
USE [master]
GO
ALTER DATABASE [CEFEGEN] SET  READ_WRITE 
GO
