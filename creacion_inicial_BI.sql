USE GD2C2023

IF OBJECT_ID('SQLeros.DuracionPromedioDeAnuncios', 'V') IS NOT NULL
	DROP VIEW SQLeros.DuracionPromedioDeAnuncios
GO

IF OBJECT_ID('SQLeros.PrecioPromedioDeInmuebles', 'V') IS NOT NULL
	DROP VIEW SQLeros.PrecioPromedioDeInmuebles
GO

IF OBJECT_ID('SQLeros.PorcentajeDeIncumplimientoDePagoDeAlquileres', 'V') IS NOT NULL
	DROP VIEW SQLeros.PorcentajeDeIncumplimientoDePagoDeAlquileres
GO

IF OBJECT_ID('SQLeros.BI_RangoEtario', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoEtario
GO

IF OBJECT_ID('SQLeros.BI_RangoM2', 'U') IS NOT NULL
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

CREATE VIEW SQLeros.PorcentajeDeIncumplimientoDePagoDeAlquileres AS
SELECT tipooperacion_descripcion,
sucur_nombre,
FROM SQLeros.Anuncio
JOIN SQLeros.Sucursal ON sucur_codigo = anu_sucursal
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = anu_tipo_op
JOIN SQLeros.Agente ON 
JOIN SQLeros.Persona O

SELECT * FROM SQLeros.PrecioPromedioDeInmuebles