IF SCHEMA_ID('SQLeros') IS NULL
	BEGIN
		EXECUTE('CREATE SCHEMA SQLeros'	)
	END
GO

USE GD2C2023

IF OBJECT_ID('SQLeros.DuracionPromedioDeAnuncios', 'V') IS NOT NULL
	DROP VIEW SQLeros.DuracionPromedioDeAnuncios
GO

IF OBJECT_ID('SQLeros.PrecioPromedioDeInmuebles', 'V') IS NOT NULL
	DROP VIEW SQLeros.PrecioPromedioDeInmuebles
GO

IF OBJECT_ID('SQLeros.PorcentajeDeOperacionesConcretadas', 'V') IS NOT NULL
	DROP VIEW SQLeros.PorcentajeDeOperacionesConcretadas
GO

IF OBJECT_ID('SQLeros.BI_RangoEtario', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoEtario
GO

IF OBJECT_ID('SQLeros.BI_RangoM2', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoM2
GO

IF OBJECT_ID('SQLeros.BI_Inmueble', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoM2
GO

IF OBJECT_ID('SQLeros.BI_Anuncio', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoM2
GO

CREATE TABLE SQLeros.BI_RangoEtario(
	rangoetario_codigo INT IDENTITY PRIMARY KEY,
	rangoetario_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.BI_RangoM2(
	rangom2_codigo INT IDENTITY PRIMARY KEY,
	rangom2_descripcion VARCHAR(10)
)
GO

--Fact table
CREATE TABLE SQLeros.BI_Anuncio(
	bi_anu_codigo INT IDENTITY PRIMARY KEY,
	bi_anu_codigo_maestra INT,
	bi_anu_agente INT,
	bi_anu_inmueble INT,
	bi_anu_sucursal INT,
	bi_anu_fecha_pub SMALLDATETIME,
	bi_anu_precio DECIMAL(12,2),
	bi_anu_costo DECIMAL(12,2),
	bi_anu_fecha_fin SMALLDATETIME,
	bi_anu_tipo_op INT,
	bi_anu_moneda INT,
	bi_anu_estado INT,
	bi_anu_tipo_periodo INT
)
GO

CREATE TABLE SQLeros.BI_Inmueble(
	bi_inm_codigo INT IDENTITY PRIMARY KEY,
	bi_inm_codigo_maestra INT,
	bi_inm_nombre VARCHAR(50),
	bi_inm_descripcion VARCHAR(50),
	bi_inm_direccion VARCHAR(100),
	bi_inm_superficie INT,
	bi_inm_antiguedad VARCHAR(50),
	bi_inm_expensas DECIMAL(20,8),
	bi_inm_ubicacion INT,
	bi_inm_tipo INT,
	bi_inm_ambientes INT,
	bi_inm_orientacion INT,
	bi_inm_disposicion INT,
	bi_inm_estado INT,
)
GO

INSERT INTO SQLeros.RangoEtario (rangoetario_descripcion) VALUES ('<25')
INSERT INTO SQLeros.RangoEtario (rangoetario_descripcion) VALUES ('25-35')
INSERT INTO SQLeros.RangoEtario (rangoetario_descripcion) VALUES ('35-50')
INSERT INTO SQLeros.RangoEtario (rangoetario_descripcion) VALUES ('>50')
GO

INSERT INTO SQLeros.RangoM2 (rangom2_descripcion) VALUES ('<35')
INSERT INTO SQLeros.RangoM2 (rangom2_descripcion) VALUES ('35-55')
INSERT INTO SQLeros.RangoM2 (rangom2_descripcion) VALUES ('55-75')
INSERT INTO SQLeros.RangoM2 (rangom2_descripcion) VALUES ('75-100')
INSERT INTO SQLeros.RangoM2 (rangom2_descripcion) VALUES ('>100')
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarAnuncio')
	DROP PROCEDURE SQLeros.MigrarOrientacion
GO
CREATE PROCEDURE SQLeros.BI_MigrarInmueble
AS
BEGIN
	INSERT INTO SQLeros.BI_Anuncio (bi_anu_agente, bi_anu_codigo, bi_anu_codigo_maestra, bi_anu_costo, bi_anu_estado, bi_anu_fecha_fin, bi_anu_fecha_pub, bi_anu_inmueble, bi_anu_moneda, bi_anu_precio, bi_anu_precio, bi_anu_sucursal, bi_anu_tipo_op, bi_anu_tipo_periodo)
	SELECT DISTINCT anu_agente, anu_codigo, anu_codigo_maestra, anu_costo, anu_estado, anu_fecha_fin, anu_fecha_pub, anu_inmueble, anu_moneda, anu_precio, anu_precio, anu_sucursal, anu_tipo_op, anu_tipo_periodo FROM SQLeros.Anuncio
END
GO

CREATE VIEW SQLeros.DuracionPromedioDeAnuncios AS
SELECT tipooperacion_descripcion AS [Tipo de operación],
AVG(DATEDIFF(DAY, anu_fecha_pub, anu_fecha_fin)) AS [Promedio]
FROM SQLeros.Anuncio
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = anu_tipo_op
GROUP BY tipooperacion_descripcion
GO

CREATE VIEW SQLeros.PrecioPromedioDeInmuebles AS
SELECT tipooperacion_descripcion AS [Tipo de operación],
tipoinmueble_descripcion AS [Tipo de inmueble],
inm_superficie AS [Rango m2],
AVG(anu_precio) AS [Precio promedio],
moneda_nombre
FROM SQLeros.Anuncio
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = anu_tipo_op
JOIN SQLeros.Inmueble ON inm_codigo = anu_inmueble
JOIN SQLeros.TipoInmueble ON tipoinmueble_codigo = inm_tipo
JOIN SQLeros.Moneda ON moneda_codigo = anu_moneda
GROUP BY tipooperacion_descripcion, tipoinmueble_descripcion, inm_superficie, moneda_nombre
GO

CREATE VIEW SQLeros.PorcentajeDeOperacionesConcretadas AS
SELECT tipooperacion_descripcion,
rangoetario_decripcion,
FROM SQLeros.Anuncio
JOIN SQLeros.Sucursal ON sucur_codigo = anu_sucursal
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = anu_tipo_op
JOIN SQLeros.Agente ON agen_codigo = anu_agente
JOIN SQLeros.Persona ON pers_codigo = agen_persona
JOIN SQLeros.BI_RangoEtario ON rangoetario_codigo

SELECT * FROM SQLeros.PrecioPromedioDeInmuebles