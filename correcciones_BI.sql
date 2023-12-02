USE GD2C2023

--Borro las tablas de dimensiones
IF OBJECT_ID('SQLeros.BI_Tiempo', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Tiempo
GO

IF OBJECT_ID('SQLeros.BI_Barrio', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Barrio
GO

IF OBJECT_ID('SQLeros.BI_Localidad', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Localidad
GO

IF OBJECT_ID('SQLeros.BI_Provincia', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Provincia
GO

IF OBJECT_ID('SQLeros.BI_Ubicacion', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Ubicacion
GO

IF OBJECT_ID('SQLeros.BI_Sucursal', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Sucursal
GO

IF OBJECT_ID('SQLeros.BI_RangoEtario', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoEtario
GO

IF OBJECT_ID('SQLeros.BI_TipoInmueble', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_TipoInmueble
GO

IF OBJECT_ID('SQLeros.BI_Ambientes', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Ambientes
GO

IF OBJECT_ID('SQLeros.BI_RangoM2', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoM2
GO

IF OBJECT_ID('SQLeros.BI_TipoOperacion', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_TipoOperacion
GO

IF OBJECT_ID('SQLeros.BI_TipoMoneda', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_TipoMoneda
GO

--Borro las tablas de hechos
IF OBJECT_ID('SQLeros.BI_Anuncio', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Anuncio
GO

IF OBJECT_ID('SQLeros.Bi_alquiler', 'U') IS NOT NULL
	DROP TABLE SQLeros.Bi_alquiler
GO

IF OBJECT_ID('SQLeros.BI_Venta', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Venta
GO

IF OBJECT_ID('SQLeros.BI_PagoAlquiler', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_PagoAlquiler
GO

--Dimensiones
CREATE TABLE SQLeros.BI_Tiempo(
	bi_tiempo_codigo INT IDENTITY PRIMARY KEY,
	bi_tiempo_year INT,
	bi_tiempo_month INT,
	bi_tiempo_cuatrimestre INT
)

CREATE TABLE SQLeros.BI_Barrio(
	bi_barrio_codigo INT PRIMARY KEY,
	bi_barrio_descripcion VARCHAR(20)
)
GO

CREATE TABLE SQLeros.BI_Localidad(
	bi_localidad_codigo INT PRIMARY KEY,
	bi_localidad_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.BI_Provincia(
	bi_provincia_codigo INT PRIMARY KEY,
	bi_provincia_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.BI_Ubicacion(
	bi_ubicacion_codigo INT PRIMARY KEY,
	bi_ubicacion_barrio INT,
	bi_ubicacion_localidad INT,
	bi_ubicacion_provincia INT
)
GO

CREATE TABLE SQLeros.BI_Sucursal(
	bi_sucur_codigo INT PRIMARY KEY,
	bi_sucur_nombre VARCHAR(50),
	bi_sucur_ubicacion INT, --No sé si tenemos que guardar la ubicación
	bi_sucur_sucur_telefono VARCHAR(20),
	bi_sucur_direccion VARCHAR(100),
)
GO

CREATE TABLE SQLeros.BI_RangoEtario(
	bi_rangoetario_codigo INT IDENTITY PRIMARY KEY,
	bi_rangoetario_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.BI_TipoInmueble(
	bi_tipoinmueble_codigo INT PRIMARY KEY,
	bi_tipoinmueble_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.BI_Ambientes(
	bi_ambientes_codigo INT PRIMARY KEY,
	bi_ambientes_cantidad VARCHAR(50)
)
GO

CREATE TABLE SQLeros.BI_RangoM2(
	bi_rangom2_codigo INT IDENTITY PRIMARY KEY,
	bi_rangom2_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.BI_TipoOperacion(
	bi_tipooperacion_codigo INT PRIMARY KEY,
	bi_tipooperacion_descripcion VARCHAR(40)
)
GO

CREATE TABLE SQLeros.BI_TipoMoneda(
	bi_moneda_codigo INT PRIMARY KEY,
	bi_moneda_nombre VARCHAR(20),
	bi_moneda_eq_pesos decimal(8,2) --Puede ser que no necesitemos el equivalente en pesos
)
GO

--Hechos
CREATE TABLE SQLeros.BI_Anuncio(
	bi_anu_codigo INT PRIMARY KEY,
	bi_anu_sucursal INT,
	bi_anu_tiempo_pub INT,
	bi_anu_precio DECIMAL(12,2),
	bi_anu_costo DECIMAL(12,2),
	bi_anu_tiempo_fin INT,
	bi_anu_tipo_op INT,
	bi_anu_moneda INT,
	bi_anu_estado INT, --Habría que agregar la dimensión estado
	bi_anu_tipo_periodo INT,  --Habría que agregar la dimensión tipo_periodo
	bi_anu_duracion INT --En días
)
GO

CREATE TABLE SQLeros.BI_Alquiler(
	bi_alq_codigo INT PRIMARY KEY,
	bi_alq_tiempo_inicio INT,
	bi_alq_tiempo_fin INT,
	bi_alq_cant_periodos INT,
	bi_alq_depositio DECIMAL(12,2),
	bi_alq_comision DECIMAL(12,2),
	bi_alq_gastos DECIMAL(12,2),
	bi_alq_estado INT,
	bi_alq_precio DECIMAL(12,2),
	bi_aql_rengoetario_agente INT,
	bi_aql_rengoetario_inquilino INT,
)
GO

CREATE TABLE SQLeros.BI_Venta(
	bi_venta_codigo INT PRIMARY KEY,
	bi_venta_anuncio INT,
	bi_venta_tiempo INT,
	bi_venta_precio DECIMAL(12,2),
	bi_venta_comision DECIMAL(12,2),
	bi_venta_moneda INT,
	bi_venta_rengoetario_agente INT,
	bi_venta_rengoetario_comprador INT
)
GO

CREATE TABLE SQLeros.BI_PagoAlquiler(
	bi_pagoalq_codigo INT PRIMARY KEY,
	bi_pagoalq_tiempo INT,
	bi_pagoalq_nro_periodo INT,
	bi_pagoalq_descripcion_periodo VARCHAR(100),
	bi_pagoalq_tiempo_inicio INT,
	bi_pagoalq_tiempo_fin INT,
	bi_pagoalq_importe DECIMAL(12,2),
	bi_pagoalq_medio INT,
	bi_pagoalq_vencimiento INT
)
GO

--Procedures para migrar las dimensiones
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarBarrio')
	DROP PROCEDURE SQLeros.BI_MigrarBarrio
GO
CREATE PROCEDURE SQLeros.BI_MigrarBarrio
AS
BEGIN
	INSERT INTO SQLeros.BI_Barrio (bi_barrio_codigo, bi_barrio_descripcion)
	SELECT DISTINCT barrio_codigo, barrio_descripcion FROM SQLeros.Barrio
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarLocalidad')
	DROP PROCEDURE SQLeros.BI_MigrarLocalidad
GO
CREATE PROCEDURE SQLeros.BI_MigrarLocalidad
AS
BEGIN
	INSERT INTO SQLeros.BI_Localidad(bi_localidad_codigo, bi_localidad_descripcion)
	SELECT DISTINCT localidad_codigo, localidad_descripcion FROM SQLeros.Localidad
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarProvincia')
	DROP PROCEDURE SQLeros.BI_MigrarProvincia
GO
CREATE PROCEDURE SQLeros.BI_MigrarProvincia
AS
BEGIN
	INSERT INTO SQLeros.BI_Provincia(bi_provincia_codigo, bi_provincia_descripcion)
	SELECT DISTINCT provincia_codigo, provincia_descripcion FROM SQLeros.Provincia
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarUbicacion')
	DROP PROCEDURE SQLeros.BI_MigrarUbicacion
GO
CREATE PROCEDURE SQLeros.BI_MigrarUbicacion
AS
BEGIN
	INSERT INTO SQLeros.BI_Ubicacion(bi_ubicacion_codigo, bi_ubicacion_barrio, bi_ubicacion_localidad, bi_ubicacion_provincia)
	SELECT DISTINCT ubicacion_codigo, ubicacion_barrio, ubicacion_localidad, ubicacion_provincia FROM SQLeros.Ubicacion
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_InsertarRangoEtario')
	DROP PROCEDURE SQLeros.BI_InsertarRangoEtario
GO
CREATE PROCEDURE SQLeros.BI_InsertarRangoEtario
AS
BEGIN
	INSERT INTO SQLeros.BI_RangoEtario (bi_rangoetario_descripcion) VALUES ('<25')
	INSERT INTO SQLeros.BI_RangoEtario (bi_rangoetario_descripcion) VALUES ('25-35')
	INSERT INTO SQLeros.BI_RangoEtario (bi_rangoetario_descripcion) VALUES ('35-50')
	INSERT INTO SQLeros.BI_RangoEtario (bi_rangoetario_descripcion) VALUES ('>50')
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_InsertarRangoM2"')
	DROP PROCEDURE SQLeros.BI_InsertarRangoM2
GO
CREATE PROCEDURE SQLeros.BI_InsertarRangoM2
AS
BEGIN
	INSERT INTO SQLeros.BI_RangoM2 (bi_rangom2_descripcion) VALUES ('<35')
	INSERT INTO SQLeros.BI_RangoM2 (bi_rangom2_descripcion) VALUES ('35-55')
	INSERT INTO SQLeros.BI_RangoM2 (bi_rangom2_descripcion) VALUES ('55-75')
	INSERT INTO SQLeros.BI_RangoM2 (bi_rangom2_descripcion) VALUES ('75-100')
	INSERT INTO SQLeros.BI_RangoM2 (bi_rangom2_descripcion) VALUES ('>100')
END
GO
--Procedures para migrar los hechos

--Creación de vistas

--Migración de Tablas
BEGIN TRANSACTION
	BEGIN TRY
		EXEC SQLeros.BI_MigrarBarrio
		EXEC SQLeros.BI_MigrarLocalidad
		EXEC SQLeros.BI_MigrarProvincia
		EXEC SQLeros.BI_InsertarRangoEtario
		EXEC SQLeros.BI_InsertarRangoM2
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH