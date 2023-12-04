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

IF OBJECT_ID('SQLeros.BI_EstadoAlquiler', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_EstadoAlquiler
GO

--Borro las tablas de hechos
IF OBJECT_ID('SQLeros.BI_Anuncio', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Anuncio
GO

IF OBJECT_ID('SQLeros.Bi_Operacion', 'U') IS NOT NULL
	DROP TABLE SQLeros.Bi_Operacion
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
	bi_sucur_nombre VARCHAR(50)
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
)
GO

CREATE TABLE SQLeros.BI_EstadoAlquiler(
	bi_estadoalquiler_codigo INT PRIMARY KEY,
	bi_estadoalquiler_descripcion VARCHAR(25),
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
	bi_anu_rangom2 INT,
	bi_anu_rangoetario_agente INT,
	bi_anu_sucursal INT
)
GO

CREATE TABLE SQLeros.BI_Operacion(
	bi_operacion_codigo INT IDENTITY PRIMARY KEY,
	bi_operacion_tiempo_inicio INT,
	bi_operacion_comision_total DECIMAL(12,2),
	bi_operacion_precio_total DECIMAL(12,2),
	bi_operacion_cantidad INT,
	bi_operacion_ubicacion_inmueble INT,
	bi_operacion_rangoetario_agente INT,
	bi_operacion_rangoetario_cliente INT,
	bi_operacion_sucursal INT,
	bi_operacion_tipo_operacion INT,
	bi_operacion_moneda INT,
	bi_operacion_tipo_inmueble INT
)
GO

CREATE TABLE SQLeros.BI_PagoAlquiler(
	bi_pagoalq_codigo INT IDENTITY PRIMARY KEY,
	bi_pagoalq_tiempo INT,
	bi_pagoalq_total_pagado DECIMAL(12, 2),
	bi_pagoalq_incremento_total DECIMAL(12,2),
	bi_pagoalq_pagos_incumplidos INT,
	bi_pagoalq_cantidad_pagos INT,
	bi_pagoalq_cantidad_pagos_con_aumento INT,
	bi_pagoalq_estado_alquiler INT
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
	SET @edad = DATEDIFF(YEAR, @fecha_nacimiento, CAST (GETDATE() AS SMALLDATETIME))
	IF CAST(@edad AS DECIMAL(12,2)) < 25
	BEGIN
		SELECT @rango = bi_rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE bi_rangoetario_descripcion = '<25'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 25 AND CAST(@edad AS DECIMAL(12,2)) <35
	BEGIN
		SELECT @rango = bi_rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE bi_rangoetario_descripcion = '25-35'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 35 AND CAST(@edad AS DECIMAL(12,2)) < 50
	BEGIN
		SELECT @rango = bi_rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE bi_rangoetario_descripcion = '35-50'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 50
	BEGIN
		SELECT @rango = bi_rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE bi_rangoetario_descripcion = '>50'
	END
	RETURN @rango
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

IF OBJECT_ID('SQLeros.BI_f_HuboAumento', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_HuboAumento
GO
CREATE FUNCTION SQLeros.BI_f_HuboAumento (@arg1 DECIMAL(12,2), @arg2 DECIMAL(12,2))
RETURNS BIT
BEGIN
	DECLARE @return BIT
	IF(@arg1 > @arg2)
	BEGIN
		SET @return = 1
	END
	ELSE
	BEGIN
		SET @return = NULL
	END
	RETURN @return
END
GO

IF OBJECT_ID('SQLeros.BI_f_RangoEtarioInquilino', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_RangoEtarioInquilino
GO
CREATE FUNCTION SQLeros.BI_f_RangoEtarioInquilino (@alquiler INT)
RETURNS INT
AS
BEGIN
	DECLARE @rango_etario INT, @inquilino INT, @fecha_nacimiento SMALLDATETIME
	SELECT TOP 1 @fecha_nacimiento = pers_fecha_nac FROM SQLeros.InquilinoPorAlquiler JOIN SQLeros.Inquilino ON inquilino_codigo = inquilinoporalquiler_inquilino JOIN SQLeros.Persona ON pers_codigo = inquilino_persona WHERE inquilinoporalquiler_alquiler = @alquiler ORDER BY pers_fecha_nac DESC
	SET @rango_etario = SQLeros.BI_f_rango_etario(@fecha_nacimiento)
	RETURN @rango_etario
END
GO

IF OBJECT_ID('SQLeros.BI_f_MontoPagoAnterior', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_MontoPagoAnterior
GO
CREATE FUNCTION SQLeros.BI_f_MontoPagoAnterior(@pagoAlquiler INT)
RETURNS DECIMAL (12, 2)
AS
BEGIN
	DECLARE @monto DECIMAL(12, 2), @fecha SMALLDATETIME, @alquiler INT
	SELECT @fecha = pagoalq_fecha, @alquiler = pagoalq_alquiler FROM SQLeros.PagoAlquiler WHERE pagoalq_codigo = @pagoAlquiler
	SET @monto = (SELECT TOP 1 pagoalq_importe FROM SQLeros.PagoAlquiler
				  WHERE pagoalq_fecha < @fecha AND pagoalq_codigo != @pagoAlquiler AND pagoalq_alquiler = @alquiler
				  ORDER BY pagoalq_fecha DESC)
	RETURN @monto
END
GO

IF OBJECT_ID('SQLeros.BI_f_NoPagoATiempo', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_NoPagoATiempo
GO
CREATE FUNCTION SQLeros.BI_f_NoPagoATiempo (@pago INT)
RETURNS BIT
AS
BEGIN
	DECLARE @r_value BIT
	DECLARE @vencimiento SMALLDATETIME, @fecha_de_pago SMALLDATETIME
	SELECT @fecha_de_pago = pagoalq_fecha, @vencimiento = pagoalq_vencimiento FROM SQLeros.PagoAlquiler
	WHERE pagoalq_codigo = @pago
	IF (@fecha_de_pago > @vencimiento)
	BEGIN
		SET @r_value = 1
	END
	ELSE
	BEGIN
		SET @r_value = NULL
	END
	RETURN @r_value
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

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarTipoMoneda')
	DROP PROCEDURE SQLeros.BI_MigrarTipoMoneda
GO
CREATE PROCEDURE SQLeros.BI_MigrarTipoMoneda
AS
BEGIN
	INSERT INTO SQLeros.BI_TipoMoneda(bi_moneda_codigo, bi_moneda_nombre)
	SELECT moneda_codigo, moneda_nombre FROM SQLeros.Moneda
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

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarEstadoAlquiler')
	DROP PROCEDURE SQLeros.BI_MigrarEstadoAlquiler
GO
CREATE PROCEDURE SQLeros.BI_MigrarEstadoAlquiler
AS
BEGIN
	INSERT INTO SQLeros.BI_EstadoAlquiler(bi_estadoalquiler_codigo, bi_estadoalquiler_descripcion)
	SELECT DISTINCT estadoalquiler_codigo, estadoalquiler_descripcion FROM SQLeros.EstadoAlquiler
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

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarSucursal')
	DROP PROCEDURE SQLeros.BI_MigrarSucursal
GO
CREATE PROCEDURE SQLeros.BI_MigrarSucursal
AS
BEGIN
	INSERT INTO SQLeros.BI_Sucursal (bi_sucur_codigo, bi_sucur_nombre)
	SELECT sucur_codigo, sucur_nombre FROM SQLeros.Sucursal
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
					  WHERE bi_tiempo_cuatrimestre = SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_fecha_inicio))
					  AND bi_tiempo_month = MONTH(pagoalq_fecha_inicio)
					  AND bi_tiempo_year = YEAR(pagoalq_fecha_inicio))
	UNION
	SELECT distinct SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_vencimiento)), MONTH(pagoalq_vencimiento), YEAR(pagoalq_vencimiento) FROM SQLeros.PagoAlquiler
	WHERE NOT EXISTS (SELECT bi_tiempo_cuatrimestre, bi_tiempo_month, bi_tiempo_year FROM SQLeros.BI_Tiempo
					  WHERE bi_tiempo_cuatrimestre = SQLeros.BI_ObtenerCuatrimestre(MONTH(pagoalq_vencimiento))
					  AND bi_tiempo_month = MONTH(pagoalq_vencimiento)
					  AND bi_tiempo_year = YEAR(pagoalq_vencimiento))
	UNION
	SELECT distinct SQLeros.BI_ObtenerCuatrimestre(MONTH(anu_fecha_pub)), MONTH(anu_fecha_pub), YEAR(anu_fecha_pub) FROM SQLeros.Anuncio
	WHERE NOT EXISTS (SELECT bi_tiempo_cuatrimestre, bi_tiempo_month, bi_tiempo_year FROM SQLeros.BI_Tiempo
					  WHERE bi_tiempo_cuatrimestre = SQLeros.BI_ObtenerCuatrimestre(MONTH(anu_fecha_pub))
					  AND bi_tiempo_month = MONTH(anu_fecha_pub)
					  AND bi_tiempo_year = YEAR(anu_fecha_pub))
	UNION
	SELECT distinct SQLeros.BI_ObtenerCuatrimestre(MONTH(venta_fecha)), MONTH(venta_fecha), YEAR(venta_fecha) FROM SQLeros.Venta
	WHERE NOT EXISTS (SELECT bi_tiempo_cuatrimestre, bi_tiempo_month, bi_tiempo_year FROM SQLeros.BI_Tiempo
					  WHERE bi_tiempo_cuatrimestre = SQLeros.BI_ObtenerCuatrimestre(MONTH(venta_fecha))
					  AND bi_tiempo_month = MONTH(venta_fecha)
					  AND bi_tiempo_year = YEAR(venta_fecha))
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
	INSERT INTO SQLeros.BI_Anuncio(bi_anu_ambientes, bi_anu_duracion_promedio, bi_anu_precio_total, bi_anu_cantidad, bi_anu_rangom2, bi_anu_tiempo_pub, bi_anu_tipo_inmueble, bi_anu_tipo_moneda, bi_anu_tipo_op, bi_anu_ubicacion, bi_anu_rangoetario_agente, bi_anu_sucursal)
	SELECT inm_ambientes,
	AVG(DATEDIFF(DAY, anu_fecha_pub, anu_fecha_fin)),
	SUM(anu_precio),COUNT(*) , SQLeros.BI_f_rango_superficie(inm_superficie),
	(SELECT TOP 1 bi_tiempo_codigo FROM SQLeros.BI_Tiempo WHERE
	bi_tiempo_year = YEAR(anu_fecha_pub) AND bi_tiempo_month = MONTH(anu_fecha_pub)),
	inm_tipo, anu_moneda, anu_tipo_op, inm_ubicacion, SQLeros.BI_f_rango_etario(pers_fecha_nac), anu_sucursal
	FROM SQLeros.Anuncio
	JOIN SQLeros.Inmueble ON inm_codigo = anu_inmueble
	JOIN SQLeros.Agente ON anu_agente = agen_codigo
	JOIN SQLeros.Persona ON agen_persona = pers_codigo
	GROUP BY inm_ambientes, inm_tipo, anu_moneda, anu_tipo_op, inm_ubicacion, SQLeros.BI_f_rango_superficie(inm_superficie), YEAR(anu_fecha_pub), MONTH(anu_fecha_pub), SQLeros.BI_f_rango_etario(pers_fecha_nac), anu_sucursal
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarAlquiler')
	DROP PROCEDURE SQLeros.BI_MigrarAlquiler
GO
CREATE PROCEDURE SQLeros.BI_MigrarAlquiler
AS
BEGIN
	INSERT INTO SQLeros.BI_Operacion (bi_operacion_cantidad, bi_operacion_comision_total, bi_operacion_precio_total, bi_operacion_tiempo_inicio, bi_operacion_ubicacion_inmueble, bi_operacion_rangoetario_agente, bi_operacion_rangoetario_cliente, bi_operacion_sucursal, bi_operacion_tipo_operacion, bi_operacion_moneda, bi_operacion_tipo_inmueble)
	SELECT COUNT(*), SUM(alq_comision), SUM(alq_precio), bi_tiempo_codigo, inm_ubicacion, SQLeros.BI_f_rango_etario(PA.pers_fecha_nac), SQLeros.BI_f_RangoEtarioInquilino(alq_codigo), anu_sucursal, anu_tipo_op, anu_moneda, inm_tipo
	FROM SQLeros.Alquiler
	JOIN SQLeros.BI_Tiempo ON bi_tiempo_year = YEAR(alq_fecha_inicio) AND bi_tiempo_month = MONTH(alq_fecha_inicio)
	JOIN SQLeros.Anuncio ON anu_codigo = alq_anuncio
	JOIN SQLeros.Inmueble ON inm_codigo = anu_inmueble
	JOIN SQLeros.Agente ON agen_codigo = anu_agente
	JOIN SQLeros.Persona PA ON PA.pers_codigo = agen_persona
	JOIN SQLeros.PagoAlquiler ON pagoalq_alquiler = pagoalq_codigo
	GROUP BY bi_tiempo_codigo, YEAR(alq_fecha_inicio), MONTH(alq_fecha_inicio), inm_ubicacion, SQLeros.BI_f_rango_etario(PA.pers_fecha_nac), SQLeros.BI_f_RangoEtarioInquilino(alq_codigo), anu_sucursal, anu_tipo_op, anu_moneda, inm_tipo
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarPagoAlquiler')
	DROP PROCEDURE SQLeros.BI_MigrarPagoAlquiler
GO
CREATE PROCEDURE SQLeros.BI_MigrarPagoAlquiler
AS
BEGIN
	INSERT INTO SQLeros.BI_PagoAlquiler (bi_pagoalq_cantidad_pagos_con_aumento, bi_pagoalq_cantidad_pagos, bi_pagoalq_pagos_incumplidos, bi_pagoalq_tiempo, bi_pagoalq_total_pagado, bi_pagoalq_estado_alquiler, bi_pagoalq_incremento_total) 
	SELECT COUNT(SQLeros.BI_f_HuboAumento(pagoalq_importe, ISNULL(SQLeros.BI_f_MontoPagoAnterior(pagoalq_codigo), pagoalq_importe))), COUNT(*), COUNT(SQLeros.BI_f_NoPagoATiempo(pagoalq_codigo)), bi_tiempo_codigo, SUM(pagoalq_importe) , alq_estado, SUM(pagoalq_importe - ISNULL(SQLeros.BI_f_MontoPagoAnterior(pagoalq_codigo), pagoalq_importe))
	FROM SQLeros.PagoAlquiler
	JOIN SQLeros.BI_Tiempo ON bi_tiempo_year = YEAR(pagoalq_fecha) AND bi_tiempo_month = MONTH(pagoalq_fecha)
	JOIN SQLeros.Alquiler ON alq_codigo = pagoalq_alquiler
	GROUP BY bi_tiempo_codigo, alq_estado
END
GO

/*
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
*/
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarVenta')
	DROP PROCEDURE SQLeros.BI_MigrarVenta
GO
CREATE PROCEDURE SQLeros.BI_MigrarVenta
AS
BEGIN
	INSERT INTO SQLeros.BI_Operacion (bi_operacion_cantidad, bi_operacion_comision_total, bi_operacion_precio_total, bi_operacion_tiempo_inicio, bi_operacion_ubicacion_inmueble, bi_operacion_rangoetario_agente, bi_operacion_rangoetario_cliente, bi_operacion_sucursal, bi_operacion_tipo_operacion, bi_operacion_moneda, bi_operacion_tipo_inmueble)
	SELECT COUNT(*), SUM(venta_comision), SUM(venta_precio), bi_tiempo_codigo, inm_ubicacion, SQLeros.BI_f_rango_etario(PA.pers_fecha_nac), SQLeros.BI_f_rango_etario(COMP.pers_fecha_nac), agen_sucursal, bi_tipooperacion_codigo, venta_moneda, inm_tipo
	FROM SQLeros.Venta
		JOIN SQLeros.BI_Tiempo ON YEAR(venta_fecha) = bi_tiempo_year AND MONTH(venta_fecha) = bi_tiempo_month
		JOIN SQLeros.Anuncio ON venta_anuncio = anu_codigo
		JOIN SQLeros.Agente ON anu_agente = agen_codigo
		JOIN SQLeros.Persona PA ON agen_persona = PA.pers_codigo
		JOIN SQLeros.Persona COMP ON COMP.pers_codigo = venta_comprador
		JOIN SQLeros.Inmueble ON anu_inmueble = inm_codigo
		JOIN SQLeros.BI_TipoOperacion ON bi_tipooperacion_descripcion = 'Tipo Operación Venta'
	GROUP BY bi_tiempo_codigo, inm_ubicacion, SQLeros.BI_f_rango_etario(PA.pers_fecha_nac), SQLeros.BI_f_rango_etario(COMP.pers_fecha_nac), agen_sucursal, bi_tipooperacion_codigo, venta_moneda, inm_tipo
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
bi_rangom2_descripcion AS [Rango M2],
bi_moneda_nombre AS [Moneda]
FROM SQLeros.BI_Anuncio
JOIN SQLeros.BI_TipoOperacion ON bi_tipooperacion_codigo = bi_anu_tipo_op
JOIN SQLeros.BI_TipoInmueble ON bi_tipoinmueble_codigo = bi_anu_tipo_inmueble
JOIN SQLeros.BI_RangoM2 ON bi_rangom2_codigo = bi_anu_rangom2
JOIN SQLeros.BI_TipoMoneda ON bi_moneda_codigo = bi_anu_tipo_moneda
GROUP BY bi_tipooperacion_codigo, bi_tipooperacion_descripcion, bi_tipoinmueble_codigo, bi_tipoinmueble_descripcion, bi_rangom2_codigo, bi_rangom2_descripcion, bi_moneda_codigo, bi_moneda_nombre
GO

/*VISTA 3*/
IF OBJECT_ID('SQLeros.BI_BarriosMasElegidos', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_BarriosMasElegidos
GO
CREATE VIEW SQLeros.BI_BarriosMasElegidos AS
SELECT TOP 5 bi_barrio_descripcion AS [Barrio],
bi_rangoetario_descripcion AS [Rango etario],
bi_tiempo_year AS [Año],
bi_tiempo_cuatrimestre AS [Cuatrimestre],
COUNT(*) AS [Cantidad] --Después borrar la cantidad
FROM SQLeros.BI_Operacion
JOIN SQLeros.BI_Ubicacion ON bi_ubicacion_codigo = bi_operacion_ubicacion_inmueble
JOIN SQLeros.BI_Barrio ON bi_barrio_codigo = bi_ubicacion_barrio
JOIN SQLeros.BI_Tiempo ON bi_tiempo_codigo = bi_operacion_tiempo_inicio
JOIN SQLeros.BI_RangoEtario ON bi_rangoetario_codigo = bi_operacion_rangoetario_cliente
JOIN SQLeros.BI_TipoOperacion ON bi_tipooperacion_codigo = bi_operacion_tipo_operacion
WHERE bi_tipooperacion_descripcion = 'Tipo Operación Alquiler Contrato' OR bi_tipooperacion_descripcion = 'Tipo Operación Alquiler Temporario'
GROUP BY bi_barrio_codigo, bi_barrio_descripcion, bi_rangoetario_codigo, bi_rangoetario_descripcion, bi_tiempo_year, bi_tiempo_cuatrimestre
ORDER BY COUNT(*) DESC
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
SELECT SUM(bi_pagoalq_pagos_incumplidos) / SUM(bi_pagoalq_cantidad_pagos) AS [Porcentaje de incumplimiento de pagos],
bi_tiempo_year AS [Año],
bi_tiempo_month AS [Month]
FROM SQLeros.BI_PagoAlquiler
JOIN SQLeros.BI_Tiempo ON YEAR(bi_pagoalq_tiempo) = bi_tiempo_year AND MONTH(bi_pagoalq_tiempo) = bi_tiempo_month
GROUP BY bi_tiempo_year, bi_tiempo_month
GO

/*VISTA 5*/
-- Parece que no hay activos con aumento. Mostramos todos los activos (van a tener aumento = 0).
-- SELECT * FROM SQLeros.BI_PagoAlquiler WHERE bi_pagoalq_estado = 'Activo'
-- SELECT PAGO_ALQUILER_IMPORTE FROM gd_esquema.Maestra WHERE ALQUILER_ESTADO = 'Activo'
-- Nota: parece que todos los alquileres activos tienen un solo pago => nunca hay aumento
IF OBJECT_ID('SQLeros.BI_PorcentajeIncrementoValorAlquiler', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PorcentajeIncrementoValorAlquiler
GO
CREATE VIEW SQLeros.BI_PorcentajeIncrementoValorAlquiler AS
SELECT 100.0 * SUM(bi_pagoalq_incremento_total) / SUM(bi_pagoalq_cantidad_pagos_con_aumento) AS [Porcentaje de incremento del valor de los alquileres],
bi_tiempo_year AS [Año],
bi_tiempo_month AS [Mes]
FROM SQLeros.BI_PagoAlquiler
JOIN SQLeros.BI_EstadoAlquiler ON bi_estadoalquiler_codigo = bi_pagoalq_estado_alquiler
JOIN SQLeros.BI_Tiempo ON bi_tiempo_codigo = bi_pagoalq_tiempo
WHERE bi_estadoalquiler_descripcion = 'Activo' AND bi_pagoalq_incremento_total > 0
GROUP BY bi_tiempo_year, bi_tiempo_month
GO

/*VISTA 6*/
IF OBJECT_ID('SQLeros.BI_PrecioPromedioDeM2', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PrecioPromedioDeM2
GO
CREATE VIEW SQLeros.BI_PrecioPromedioDeM2 AS
SELECT SUM(bi_operacion_precio_total) / SUM(bi_operacion_cantidad) AS [Precio Promedio],
bi_tipoinmueble_descripcion AS [Tipo de inmueble],
bi_localidad_descripcion AS [Localidad],
bi_tiempo_year AS [Año],
bi_tiempo_cuatrimestre AS [Cuatrimestre]
FROM SQLeros.BI_Operacion
JOIN SQLeros.BI_TipoInmueble ON bi_tipoinmueble_codigo = bi_operacion_tipo_inmueble
JOIN SQLeros.BI_Tiempo ON bi_operacion_tiempo_inicio = bi_tiempo_codigo
JOIN SQLeros.BI_Ubicacion ON bi_ubicacion_codigo = bi_operacion_ubicacion_inmueble
JOIN SQLeros.BI_Localidad ON bi_localidad_codigo = bi_ubicacion_localidad
JOIN SQLeros.BI_TipoOperacion ON bi_tipooperacion_codigo = bi_operacion_tipo_operacion
WHERE bi_tipooperacion_descripcion = 'Tipo Operación Venta'
GROUP BY bi_tipoinmueble_codigo, bi_tipoinmueble_descripcion, bi_localidad_codigo, bi_localidad_descripcion, bi_tiempo_year, bi_tiempo_cuatrimestre
GO

/*VISTA 7*/
IF OBJECT_ID('SQLeros.BI_ValorPromedioDeLaComision', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_ValorPromedioDeLaComision
GO
CREATE VIEW SQLeros.BI_ValorPromedioDeLaComision AS
SELECT SUM(bi_operacion_comision_total) / SUM(bi_operacion_cantidad) AS [Comisión promedio],
bi_tipooperacion_descripcion AS [Tipo de operación],
bi_sucur_nombre AS [Sucursal],
bi_tiempo_year AS [Año],
bi_tiempo_cuatrimestre AS [Cuatrimestre]
FROM SQLeros.BI_Operacion
JOIN SQLeros.BI_TipoOperacion ON bi_tipooperacion_codigo = bi_operacion_tipo_operacion
JOIN SQLeros.BI_Sucursal ON bi_sucur_codigo = bi_operacion_sucursal
JOIN SQLeros.BI_Tiempo ON bi_tiempo_codigo = bi_operacion_tiempo_inicio
GROUP BY bi_tipooperacion_codigo, bi_tipooperacion_descripcion, bi_sucur_codigo, bi_sucur_nombre, bi_tiempo_year, bi_tiempo_cuatrimestre
GO

/*VISTA 8*/
IF OBJECT_ID('SQLeros.BI_PorcentajeOperacionesConcretadas', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PorcentajeOperacionesConcretadas
GO
CREATE VIEW SQLeros.BI_PorcentajeOperacionesConcretadas
AS
SELECT 100.0 * SUM(OP.bi_operacion_cantidad) / (SELECT SUM(bi_anu_cantidad) FROM SQLeros.BI_Anuncio
					JOIN SQLeros.BI_Tiempo TI2 ON TI2.bi_tiempo_codigo = bi_anu_tiempo_pub
					WHERE bi_anu_sucursal = SU.bi_sucur_codigo
					AND bi_anu_rangoetario_agente = RE.bi_rangoetario_codigo
					AND TI2.bi_tiempo_year = TI.bi_tiempo_year
					GROUP BY bi_anu_sucursal, YEAR(TI2.bi_tiempo_year), bi_anu_rangoetario_agente) AS [Porcentaje de operaciones concretadas],
SU.bi_sucur_nombre AS [Sucursal],
RE.bi_rangoetario_descripcion AS [Rango etario del empleado],
TI.bi_tiempo_year AS [Año]
FROM SQLeros.BI_Operacion OP
JOIN SQLeros.BI_Sucursal SU ON SU.bi_sucur_codigo = OP.bi_operacion_sucursal
JOIN SQLeros.BI_RangoEtario RE ON RE.bi_rangoetario_codigo = OP.bi_operacion_rangoetario_agente
JOIN SQLeros.BI_Tiempo TI ON TI.bi_tiempo_codigo = OP.bi_operacion_tiempo_inicio
GROUP BY SU.bi_sucur_codigo, SU.bi_sucur_nombre, RE.bi_rangoetario_codigo, RE.bi_rangoetario_descripcion, TI.bi_tiempo_yeaR
GO

/*Vista 9*/
IF OBJECT_ID('SQLeros.BI_MontoTotalDeCierreDeContratos', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_MontoTotalDeCierreDeContratos
GO
CREATE VIEW SQLeros.BI_MontoTotalDeCierreDeContratos AS
SELECT SUM(bi_operacion_precio_total) AS [Monto total de cierre de contratos],
bi_tiempo_year AS [Año],
bi_tiempo_cuatrimestre AS [Cuatrimestre],
bi_sucur_nombre AS [Sucursal],
bi_tipooperacion_descripcion AS [Tipo de operación]
FROM SQLeros.BI_Operacion
JOIN SQLeros.BI_TipoOperacion ON bi_tipooperacion_codigo = bi_operacion_tipo_operacion
JOIN SQLeros.BI_Tiempo ON bi_tiempo_codigo = bi_operacion_tiempo_inicio
JOIN SQLeros.BI_Sucursal ON bi_sucur_codigo = bi_operacion_sucursal
GROUP BY bi_tiempo_year, bi_tiempo_cuatrimestre, bi_sucur_codigo, bi_sucur_nombre, bi_tipooperacion_codigo, bi_tipooperacion_descripcion
GO

--Migración de Tablas
--BEGIN TRANSACTION
	--BEGIN TRY
		--Migración de las dimensiones
		EXEC SQLeros.BI_MigrarTiempo
		EXEC SQLeros.BI_MigrarAmbientes
		EXEC SQLeros.BI_MigrarBarrio
		EXEC SQLeros.BI_MigrarLocalidad
		EXEC SQLeros.BI_MigrarProvincia
		EXEC SQLeros.BI_MigrarUbicacion
		EXEC SQLeros.BI_InsertarRangoEtario
		EXEC SQLeros.BI_InsertarRangoM2
		EXEC SQLeros.BI_MigrarTipoOperacion
		EXEC SQLeros.BI_MigrarTipoInmueble
		EXEC SQLeros.BI_MigrarTipoMoneda
		EXEC SQLeros.BI_MigrarSucursal
		EXEC SQLeros.BI_MigrarEstadoAlquiler

		--Migración de los hechos
		EXEC SQLeros.BI_MigrarAnuncio
		EXEC SQLeros.BI_MigrarAlquiler
		EXEC SQLeros.BI_MigrarVenta
		EXEC SQLeros.BI_MigrarPagoAlquiler
		--EXEC SQLeros.BI_AumentoPagoAlq
		--COMMIT TRANSACTION;
	--END TRY
	--BEGIN CATCH
		--ROLLBACK TRANSACTION;
	--END CATCH

-- Selects de las vistas
/*
SELECT * FROM SQLeros.BI_DuracionPromedioDeAnuncios					-- Vista 1
SELECT * FROM SQLeros.BI_PrecioPromedioDeAnunciosDeInmuebles		-- Vista 2
SELECT * FROM SQLeros.BI_BarriosMasElegidos							-- Vista 3
SELECT * FROM SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler		-- Vista 4
SELECT * FROM SQLeros.BI_PorcentajeIncrementoValorAlquiler			-- Vista 5
SELECT * FROM SQLeros.BI_ValorPromedioDeLaComision					-- Vista 7
SELECT * FROM SQLeros.BI_PorcentajeOperacionesConcretadas			-- Vista 8
SELECT * FROM SQLeros.BI_MontoTotalDeCierreDeContratos				-- Vista 9
*/

-- Para probar vista 5 - borrar

/*
	-- Insert para ver si funciona la vista
	INSERT INTO SQLeros.PagoAlquiler (pagoalq_alquiler, pagoalq_fecha, pagoalq_vencimiento, pagoalq_importe, pagoalq_descripcion_periodo)
	VALUES (3, '2023-12-02 00:00:00', '2024-01-02 00:00:00', 100, 'holachau1')

	DELETE FROM SQLeros.PagoAlquiler WHERE pagoalq_descripcion_periodo = 'holachau1'
*/