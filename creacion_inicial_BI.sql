USE GD2C2023

IF OBJECT_ID('SQLeros.DuracionPromedioDeAnuncios', 'V') IS NOT NULL
	DROP VIEW SQLeros.DuracionPromedioDeAnuncios
GO

IF OBJECT_ID('SQLeros.PrecioPromedioDeInmuebles', 'V') IS NOT NULL
	DROP VIEW SQLeros.PrecioPromedioDeInmuebles
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
disposicion_descripcion AS [Rango m2],
AVG(anu_precio) AS [Precio promedio],
moneda_nombre
FROM SQLeros.Anuncio
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = anu_tipo_op
JOIN SQLeros.Inmueble ON inm_codigo = anu_inmueble
JOIN SQLeros.TipoInmueble ON tipoinmueble_codigo = inm_tipo
JOIN SQLeros.Disposicion ON disposicion_codigo = inm_disposicion
JOIN SQLeros.Moneda ON moneda_codigo = anu_moneda
GROUP BY tipooperacion_descripcion, tipoinmueble_descripcion, disposicion_descripcion, moneda_nombre
GO

SELECT * FROM SQLeros.PrecioPromedioDeInmuebles