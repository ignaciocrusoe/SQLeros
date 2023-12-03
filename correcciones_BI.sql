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

-- Borro funciones
IF OBJECT_ID('SQLeros.BI_ObtenerCuatrimestre', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_ObtenerCuatrimestre
GO
IF OBJECT_ID('SQLeros.BI_MontoPagoAnterior', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_MontoPagoAnterior
GO

-- Borro vistas
IF OBJECT_ID('SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler
GO
IF OBJECT_ID('SQLeros.BI_PorcentajeIncrementoValorAlquiler', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PorcentajeIncrementoValorAlquiler
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
	bi_anu_codigo INT IDENTITY PRIMARY KEY,
	bi_anu_tiempo_pub INT,
	bi_anu_precio_total DECIMAL(12,2),
	bi_anu_cantidad INT,
	bi_anu_tipo_op INT,
	bi_anu_tipo_moneda INT,
	bi_anu_ambientes INT,
	bi_anu_ubicacion INT,
	bi_anu_duracion_promedio INT, --En días
	bi_anu_tipo_inmueble INT,
	bi_anu_rangom2 INT
)
GO

CREATE TABLE SQLeros.BI_Alquiler(
	bi_alq_codigo INT IDENTITY PRIMARY KEY,
	bi_alq_tiempo_inicio INT,
	bi_alq_tiempo_fin INT,
	bi_alq_cant_periodos INT,
	bi_alq_depositio DECIMAL(12,2),
	bi_alq_comision_promedio DECIMAL(12,2),
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
	bi_pagoalq_codigo INT IDENTITY PRIMARY KEY,
	bi_pagoalq_tiempo INT, -- FOREIGN KEY REFERENCES SQLeros.Bi_Tiempo (bi_tiempo_codigo),
	bi_pagoalq_valor_promedio DECIMAL(12, 2),
	bi_pagoalq_alquiler_esta_activo BIT,	-- Esto sería dimensión? O estado entero es dim?
	bi_pagoalq_paga_a_tiempo BIT,	-- dimensión?
	bi_pagoalq_cantidad_pagos INT,
	bi_pagoalq_total_pagado DECIMAL(12, 2),
	bi_pagoalq_porcentaje_aumento_pago DECIMAL(5, 2) -- Solo para los alquileres activos que hayan aumentado desde el último pago
)
GO

-- Funciones
IF OBJECT_ID('SQLeros.BI_f_rango_superficie', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_rango_superficie
GO
CREATE FUNCTION SQLeros.BI_f_rango_superficie (@superficie VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @rango INT
	IF CAST(@superficie AS DECIMAL(12,2)) < 35
	BEGIN
		SELECT @rango = bi_rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE bi_rangom2_descripcion = '<35'
	END
	ELSE IF CAST(@superficie AS DECIMAL(12,2)) >= 35 AND CAST(@superficie AS DECIMAL(12,2)) <55
	BEGIN
		SELECT @rango = bi_rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE bi_rangom2_descripcion = '35-55'
	END
	ELSE IF CAST(@superficie AS DECIMAL(12,2)) >= 55 AND CAST(@superficie AS DECIMAL(12,2)) <75
	BEGIN
		SELECT @rango = bi_rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE bi_rangom2_descripcion = '55-75'
	END
	ELSE IF CAST(@superficie AS DECIMAL(12,2)) >= 75 AND CAST(@superficie AS DECIMAL(12,2)) <100
	BEGIN
		SELECT @rango = bi_rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE bi_rangom2_descripcion = '75-100'
	END
	ELSE IF CAST(@superficie AS DECIMAL(12,2)) >= 100
	BEGIN
		SELECT @rango = bi_rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE bi_rangom2_descripcion = '>100'
	END
	RETURN @rango
END
GO

IF OBJECT_ID('SQLeros.BI_f_rango_etario', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_rango_etario
GO
CREATE FUNCTION SQLeros.BI_f_rango_etario (@fecha_nacimiento SMALLDATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @rango INT
	DECLARE @edad INT
	SET @edad = DATEDIFF(DAY, @fecha_nacimiento, CAST (GETDATE() AS SMALLDATETIME))
	IF CAST(@edad AS DECIMAL(12,2)) < 25
	BEGIN
		SELECT @rango = bi_rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE bi_rangoetario_descripcion = '<25'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 25 AND CAST(@edad AS DECIMAL(12,2)) <25
	BEGIN
		SELECT @rango = bi_rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE bi_rangoetario_descripcion = '25-35'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 35 AND CAST(@edad AS DECIMAL(12,2)) < 50
	BEGIN
		SELECT @rango = bi_rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE bi_rangoetario_descripcion = '35-50'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 50
	BEGIN
		SELECT @edad = bi_rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE bi_rangoetario_descripcion = '>50'
	END
	RETURN @edad
END
GO

CREATE FUNCTION SQLeros.BI_ObtenerCuatrimestre(@mes INT)
RETURNS INT
AS
BEGIN
	DECLARE @cuatrimestre INT
	IF (@mes > 0 AND @mes <= 4)
	BEGIN
		SET @cuatrimestre = 1
	END
	ELSE IF (@mes > 4 AND @mes <= 8)
	BEGIN
		SET @cuatrimestre = 2
	END
	ELSE IF (@mes > 8 AND @mes <= 12)
	BEGIN
		SET @cuatrimestre = 3
	END
	RETURN @cuatrimestre
END
GO

IF OBJECT_ID('SQLeros.BI_f_MontoPagoAnterior', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_MontoPagoAnterior
GO
CREATE FUNCTION SQLeros.BI_f_MontoPagoAnterior(@pagoAlquiler INT)
RETURNS DECIMAL (12, 2)
AS
BEGIN
	DECLARE @monto DECIMAL(12, 2)
	SELECT TOP 1 @monto = P2.pagoalq_importe
		FROM SQLeros.PagoAlquiler AS P1
			JOIN SQLeros.PagoAlquiler AS P2 ON P1.pagoalq_alquiler = P2.pagoalq_alquiler
		WHERE P1.pagoalq_codigo = @pagoAlquiler AND P2.pagoalq_nro_periodo = P1.pagoalq_nro_periodo - 1
		ORDER BY P2.pagoalq_fecha DESC
	RETURN ISNULL(@monto, -1)
END
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

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarTipoOperacion')
	DROP PROCEDURE SQLeros.BI_MigrarTipoOperacion
GO
CREATE PROCEDURE SQLeros.BI_MigrarTipoOperacion
AS
BEGIN
	INSERT INTO SQLeros.BI_TipoOperacion (bi_tipooperacion_codigo, bi_tipooperacion_descripcion)
	SELECT tipooperacion_codigo, tipooperacion_descripcion FROM SQLeros.TipoOperacion
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarTipoInmueble')
	DROP PROCEDURE SQLeros.BI_MigrarTipoInmueble
GO
CREATE PROCEDURE SQLeros.BI_MigrarTipoInmueble
AS
BEGIN
	INSERT INTO SQLeros.BI_TipoInmueble(bi_tipoinmueble_codigo, bi_tipoinmueble_descripcion)
	SELECT tipoinmueble_codigo, tipoinmueble_descripcion FROM SQLeros.TipoInmueble
END
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarAmbientes')
	DROP PROCEDURE SQLeros.BI_MigrarAmbientes
GO
CREATE PROCEDURE SQLeros.BI_MigrarAmbientes
AS
BEGIN
	INSERT INTO SQLeros.BI_Ambientes(bi_ambientes_codigo, bi_ambientes_cantidad)
	SELECT ambientes_codigo, ambientes_cantidad FROM SQLeros.Ambientes
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

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_InsertarRangoM2')
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

-- Carga de dimensión tiempo
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarTiempo')
	DROP PROCEDURE SQLeros.BI_MigrarTiempo
GO
CREATE PROCEDURE SQLeros.BI_MigrarTiempo
AS
BEGIN
	INSERT INTO SQLeros.BI_Tiempo(bi_tiempo_cuatrimestre, bi_tiempo_month, bi_tiempo_year)
	SELECT distinct SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_fecha)), MONTH(pagoalq_fecha), YEAR(pagoalq_fecha) FROM SQLeros.PagoAlquiler
	WHERE NOT EXISTS (SELECT bi_tiempo_cuatrimestre, bi_tiempo_month, bi_tiempo_year FROM SQLeros.BI_Tiempo
					  WHERE bi_tiempo_cuatrimestre = SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_fecha))
					  AND bi_tiempo_month = MONTH(pagoalq_fecha)
					  AND bi_tiempo_year = YEAR(pagoalq_fecha))
	UNION
	SELECT distinct SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_fecha_inicio)), MONTH(pagoalq_fecha_inicio), YEAR(pagoalq_fecha_inicio) FROM SQLeros.PagoAlquiler
	WHERE NOT EXISTS (SELECT bi_tiempo_cuatrimestre, bi_tiempo_month, bi_tiempo_year FROM SQLeros.BI_Tiempo
					  WHERE bi_tiempo_cuatrimestre = SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_fecha))
					  AND bi_tiempo_month = MONTH(pagoalq_fecha)
					  AND bi_tiempo_year = YEAR(pagoalq_fecha))
	UNION
	SELECT distinct SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_vencimiento)), MONTH(pagoalq_vencimiento), YEAR(pagoalq_vencimiento) FROM SQLeros.PagoAlquiler
	WHERE NOT EXISTS (SELECT bi_tiempo_cuatrimestre, bi_tiempo_month, bi_tiempo_year FROM SQLeros.BI_Tiempo
					  WHERE bi_tiempo_cuatrimestre = SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_fecha))
					  AND bi_tiempo_month = MONTH(pagoalq_fecha)
					  AND bi_tiempo_year = YEAR(pagoalq_fecha))
	UNION
	SELECT distinct SQLeros.BI_ObtenerCuatrimestre(MONTH(anu_fecha_pub)), MONTH(anu_fecha_pub), YEAR(anu_fecha_pub) FROM SQLeros.Anuncio
	WHERE NOT EXISTS (SELECT bi_tiempo_cuatrimestre, bi_tiempo_month, bi_tiempo_year FROM SQLeros.BI_Tiempo
					  WHERE bi_tiempo_cuatrimestre = SQLeros.BI_ObtenerCuatrimestre(MONTH(anu_fecha_pub))
					  AND bi_tiempo_month = MONTH(anu_fecha_pub)
					  AND bi_tiempo_year = YEAR(anu_fecha_pub))
	-- Union demás fechas
END
GO

--Procedures para migrar los hechos
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarAnuncio')
	DROP PROCEDURE SQLeros.BI_MigrarAnuncio
GO
CREATE PROCEDURE SQLeros.BI_MigrarAnuncio
AS
BEGIN
	INSERT INTO SQLeros.BI_Anuncio(bi_anu_ambientes, bi_anu_duracion_promedio, bi_anu_precio_total, bi_anu_cantidad, bi_anu_rangom2, bi_anu_tiempo_pub, bi_anu_tipo_inmueble, bi_anu_tipo_moneda, bi_anu_tipo_op, bi_anu_ubicacion)
	SELECT inm_ambientes,
	AVG(DATEDIFF(DAY, anu_fecha_pub, anu_fecha_fin)),
	SUM(anu_precio),COUNT(*) , SQLeros.BI_f_rango_superficie(inm_superficie),
	(SELECT TOP 1 bi_tiempo_codigo FROM SQLeros.BI_Tiempo WHERE
	bi_tiempo_year = YEAR(anu_fecha_pub) AND bi_tiempo_month = MONTH(anu_fecha_pub)),
	inm_tipo, anu_moneda, anu_tipo_op, inm_ubicacion
	FROM SQLeros.Anuncio
	JOIN SQLeros.Inmueble ON inm_codigo = anu_inmueble
	GROUP BY inm_ambientes, inm_tipo, anu_moneda, anu_tipo_op, inm_ubicacion, SQLeros.BI_f_rango_superficie(inm_superficie), YEAR(anu_fecha_pub), MONTH(anu_fecha_pub)
END

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarPagoAlquiler')
	DROP PROCEDURE SQLeros.BI_MigrarPagoAlquiler
GO

CREATE PROCEDURE SQLeros.BI_MigrarPagoAlquiler
AS
BEGIN
	INSERT INTO SQLeros.BI_PagoAlquiler (bi_pagoalq_tiempo, bi_pagoalq_valor_promedio, bi_pagoalq_alquiler_esta_activo, bi_pagoalq_total_pagado, bi_pagoalq_cantidad_pagos, bi_pagoalq_paga_a_tiempo)
	SELECT bi_tiempo_codigo, AVG(pagoalq_importe), 
		(CASE WHEN estadoalquiler_descripcion = 'Activo' THEN 1 ELSE 0 END), SUM(pagoalq_importe), COUNT(*),
		(CASE WHEN pagoalq_fecha > pagoalq_vencimiento THEN 0 ELSE 1 END)
	FROM SQLeros.PagoAlquiler
		JOIN SQLeros.BI_Tiempo ON YEAR(pagoalq_fecha) = bi_tiempo_year AND MONTH(pagoalq_fecha) = bi_tiempo_month	-- Se puede evitar si la key fuera year+month
		JOIN SQLeros.Alquiler ON pagoalq_alquiler = alq_codigo
		JOIN SQLeros.EstadoAlquiler ON alq_estado = estadoalquiler_codigo
	GROUP BY YEAR(pagoalq_fecha), bi_tiempo_codigo, estadoalquiler_codigo, estadoalquiler_descripcion, CASE WHEN pagoalq_fecha > pagoalq_vencimiento THEN 0 ELSE 1 END
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_AumentoPagoAlq')
	DROP PROCEDURE SQLeros.BI_AumentoPagoAlq
GO
CREATE PROCEDURE SQLeros.BI_AumentoPagoAlq -- Solo para los activos que hayan aumentado
AS
BEGIN
	UPDATE SQLeros.BI_PagoAlquiler
	SET bi_pagoalq_porcentaje_aumento_pago =
		 100 *
		 ISNULL(
			(SELECT AVG(SQLeros.BI_f_MontoPagoAnterior(pagoalq_codigo) / pagoalq_importe)
			FROM SQLeros.PagoAlquiler AS P1
				JOIN SQLeros.Alquiler ON pagoalq_alquiler = alq_codigo
				JOIN SQLeros.EstadoAlquiler ON alq_estado = estadoalquiler_codigo
			WHERE bi_tiempo_year = YEAR(pagoalq_fecha) AND bi_tiempo_month = MONTH(pagoalq_fecha) AND
				estadoalquiler_descripcion = 'Activo' AND pagoalq_importe >
				(SELECT TOP 1 P2.pagoalq_importe
				FROM SQLeros.PagoAlquiler AS P2
				WHERE P2.pagoalq_alquiler = P1.pagoalq_alquiler AND P2.pagoalq_fecha < P1.pagoalq_fecha
				ORDER BY P2.pagoalq_fecha DESC))
		, 0)
	FROM SQLeros.BI_PagoAlquiler
		JOIN SQLeros.BI_Tiempo ON bi_pagoAlq_tiempo = bi_tiempo_codigo
	WHERE bi_pagoalq_alquiler_esta_activo = 1
END
GO

--Creación de vistas
/*VISTA 1*/
IF OBJECT_ID('SQLeros.BI_DuracionPromedioDeAnuncios', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_DuracionPromedioDeAnuncios
GO
CREATE VIEW SQLeros.BI_DuracionPromedioDeAnuncios AS
SELECT bi_anu_duracion_promedio AS [Duración promedio en días],
bi_tipooperacion_descripcion AS [Tipo de operación],
bi_barrio_descripcion AS [Barrio],
bi_ambientes_cantidad AS [Ambientes]
FROM SQLeros.BI_Anuncio
JOIN SQLeros.BI_TipoOperacion ON bi_tipooperacion_codigo = bi_anu_tipo_op
JOIN SQLeros.BI_Ubicacion ON bi_ubicacion_codigo = bi_anu_ubicacion
JOIN SQLeros.BI_Barrio ON bi_barrio_codigo = bi_ubicacion_barrio
JOIN SQLeros.BI_Ambientes ON bi_ambientes_codigo = bi_anu_ambientes
GROUP BY bi_anu_duracion_promedio, bi_tipooperacion_codigo, bi_tipooperacion_descripcion, bi_barrio_codigo, bi_barrio_descripcion, bi_ambientes_codigo, bi_ambientes_cantidad
GO

/*VISTA 2*/
IF OBJECT_ID('SQLeros.BI_PrecioPromedioDeAnunciosDeInmuebles', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PrecioPromedioDeAnunciosDeInmuebles
GO
CREATE VIEW SQLeros.BI_PrecioPromedioDeAnunciosDeInmuebles AS
SELECT SUM(bi_anu_precio_total) / SUM(bi_anu_cantidad) AS [Precio promedio],
bi_tipooperacion_descripcion AS [Tipo de operación],
bi_tipoinmueble_descripcion AS [Tipo de inmueble],
bi_rangom2_descripcion AS [Rango M2]
FROM SQLeros.BI_Anuncio
JOIN SQLeros.BI_TipoOperacion ON bi_tipooperacion_codigo = bi_anu_tipo_op
JOIN SQLeros.BI_TipoInmueble ON bi_tipoinmueble_codigo = bi_anu_tipo_inmueble
JOIN SQLeros.BI_RangoM2 ON bi_rangom2_codigo = bi_anu_rangom2
GROUP BY bi_tipooperacion_codigo, bi_tipooperacion_descripcion, bi_tipoinmueble_codigo, bi_tipoinmueble_descripcion, bi_rangom2_codigo, bi_rangom2_descripcion
GO

/*VISTA 4*/
-- Nota: Esta vista esta vacía dado que no hay datos que cumplan la condicion.
-- SELECT * FROM SQLeros.PagoAlquiler WHERE pagoalq_fecha > pagoalq_vencimiento
-- SELECT * FROM gd_esquema.Maestra WHERE PAGO_ALQUILER_FECHA > PAGO_ALQUILER_FECHA_VENCIMIENTO
-- Ninguna de esas querys devuelve nada.
IF OBJECT_ID('SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler
GO
CREATE VIEW SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler AS
SELECT bi_tiempo_year Año, bi_tiempo_month Mes,
	100 *
	ISNULL(
		(SELECT SUM(P1.bi_pagoalq_cantidad_pagos)
		FROM SQLeros.BI_PagoAlquiler AS P1
		WHERE P1.bi_pagoalq_paga_a_tiempo = 0 AND P1.bi_pagoAlq_tiempo = P2.bi_pagoAlq_tiempo)
	, 0)
	/ SUM(bi_pagoalq_cantidad_pagos) Porcentaje
	FROM SQLeros.BI_PagoAlquiler AS P2
	JOIN SQLeros.BI_Tiempo ON bi_pagoAlq_tiempo = bi_tiempo_codigo
GROUP BY bi_pagoAlq_tiempo, bi_tiempo_year, bi_tiempo_month
GO

/*VISTA 5*/
-- Parece que no hay activos con aumento. Mostramos todos los activos (van a tener aumento = 0).
-- SELECT * FROM SQLeros.BI_PagoAlquiler WHERE bi_pagoalq_estado = 'Activo'
-- SELECT PAGO_ALQUILER_IMPORTE FROM gd_esquema.Maestra WHERE ALQUILER_ESTADO = 'Activo'
-- Nota: parece que todos los alquileres activos tienen un solo pago => nunca hay aumento
/*
CREATE VIEW SQLeros.BI_PorcentajeIncrementoValorAlquiler
AS
SELECT bi_tiempo_year, bi_tiempo_month, bi_pagoalq_porcentaje_aumento_pago
FROM SQLeros.BI_PagoAlquiler
	JOIN SQLeros.BI_Tiempo ON bi_pagoAlq_tiempo = bi_tiempo_codigo
WHERE bi_pagoalq_alquiler_esta_activo = 1 AND bi_pagoalq_porcentaje_aumento_pago IS NOT NULL
GO
*/
--Migración de Tablas
BEGIN TRANSACTION
	BEGIN TRY
		--Migración de las dimensiones
		EXEC SQLeros.BI_MigrarTiempo
		EXEC SQLeros.BI_MigrarBarrio
		EXEC SQLeros.BI_MigrarLocalidad
		EXEC SQLeros.BI_MigrarProvincia
		EXEC SQLeros.BI_MigrarUbicacion
		EXEC SQLeros.BI_InsertarRangoEtario
		EXEC SQLeros.BI_InsertarRangoM2
		EXEC SQLeros.BI_MigrarTipoOperacion
		EXEC SQLeros.BI_MigrarTipoInmueble
		EXEC SQLeros.BI_MigrarAmbientes

		--Migración de los hechos
		EXEC SQLeros.BI_MigrarPagoAlquiler
		EXEC SQLeros.BI_AumentoPagoAlq
		EXEC SQLeros.BI_MigrarAnuncio
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH

-- Selects de las vistas
/*
SELECT * FROM SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler		-- Vista 4
SELECT * FROM SQLeros.BI_PorcentajeIncrementoValorAlquiler			-- Vista 5
*/

-- Para probar vista 5 - borrar

/*
	-- Insert para ver si funciona la vista
	INSERT INTO SQLeros.PagoAlquiler (pagoalq_alquiler, pagoalq_fecha, pagoalq_vencimiento, pagoalq_importe, pagoalq_descripcion_periodo)
	VALUES (3, '2023-12-02 00:00:00', '2024-01-02 00:00:00', 100, 'holachau1')

	DELETE FROM SQLeros.PagoAlquiler WHERE pagoalq_descripcion_periodo = 'holachau1'
*/