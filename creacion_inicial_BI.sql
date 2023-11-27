USE GD2C2023

IF OBJECT_ID('SQLeros.BI_DuracionPromedioDeAnuncios', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_DuracionPromedioDeAnuncios
GO

IF OBJECT_ID('SQLeros.BI_PrecioPromedioDeInmuebles', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PrecioPromedioDeInmuebles
GO

IF OBJECT_ID('SQLeros.BI_PorcentajeDeOperacionesConcretadas', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PorcentajeDeOperacionesConcretadas
GO

IF OBJECT_ID('SQLeros.BI_BarriosMasElegidos', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_BarriosMasElegidos
GO

IF OBJECT_ID('SQLeros.BI_PrecioPromedioDeM2', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PrecioPromedioDeM2
GO

IF OBJECT_ID('SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler', 'V') IS NOT NULL
	DROP VIEW SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler
GO

IF OBJECT_ID('SQLeros.BI_Tiempo', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Tiempo
GO

IF OBJECT_ID('SQLeros.BI_RangoEtario', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoEtario
GO

IF OBJECT_ID('SQLeros.BI_RangoM2', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_RangoM2
GO

IF OBJECT_ID('SQLeros.BI_Inmueble', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Inmueble
GO

IF OBJECT_ID('SQLeros.BI_Venta', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Venta
GO

IF OBJECT_ID('SQLeros.BI_Anuncio', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Anuncio
GO

IF OBJECT_ID('SQLeros.BI_Persona', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_Persona
GO

IF OBJECT_ID('SQLeros.BI_PagoAlq', 'U') IS NOT NULL
	DROP TABLE SQLeros.BI_PagoAlq
GO

IF OBJECT_ID('SQLeros.BI_f_rango_superficie', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_rango_superficie
GO

IF OBJECT_ID('SQLeros.BI_ObtenerCuatrimestre', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_ObtenerCuatrimestre
GO

IF OBJECT_ID('SQLeros.BI_f_rango_etario', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_f_rango_etario
GO

IF OBJECT_ID('SQLeros.BI_MontoPagoAnterior', 'FN') IS NOT NULL
	DROP FUNCTION SQLeros.BI_MontoPagoAnterior
GO

-- Tablas dimensionales
CREATE TABLE SQLeros.BI_Tiempo(
	bi_tiempo_codigo INT IDENTITY PRIMARY KEY,
	bi_tiempo_year INT,
	bi_tiempo_month INT,
	bi_tiempo_day INT,
	bi_tiempo_cuatrimestre INT
)

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

-- Fact table
CREATE TABLE SQLeros.BI_Venta(
	 bi_venta_codigo INT PRIMARY KEY,
	 bi_venta_comprador INT,
	 bi_venta_anuncio INT,
	 bi_venta_tiempo INT,
	 bi_venta_precio DECIMAL(12,2),
	 bi_venta_comision DECIMAL(12,2),
	 bi_venta_moneda INT,
	 bi_venta_precio_m2 DECIMAL(12,2)
)
GO

CREATE TABLE SQLeros.BI_Anuncio(
	bi_anu_codigo INT PRIMARY KEY,
	bi_anu_agente INT,
	bi_anu_inmueble INT,
	bi_anu_sucursal INT,
	bi_anu_tiempo_pub INT,
	bi_anu_precio DECIMAL(12,2),
	bi_anu_costo DECIMAL(12,2),
	bi_anu_tiempo_fin INT,
	bi_anu_tipo_op INT,
	bi_anu_moneda INT,
	bi_anu_estado INT,
	bi_anu_tipo_periodo INT,
	bi_anu_comision DECIMAL(12,2)
)
GO

CREATE TABLE SQLeros.BI_Inmueble(
	bi_inm_codigo INT PRIMARY KEY,
	bi_inm_codigo_maestra INT,
	bi_inm_nombre VARCHAR(50),
	bi_inm_descripcion VARCHAR(50),
	bi_inm_direccion VARCHAR(100),
	bi_inm_superficie DECIMAL(12,2),
	bi_inm_rango_superficie DECIMAL(12,2),
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

CREATE TABLE SQLeros.BI_Persona(
	pers_codigo INT PRIMARY KEY,
	pers_nombre VARCHAR(50),
	pers_apellido VARCHAR(50),
	pers_dni CHAR(8),
	pers_fecha_reg SMALLDATETIME,
	pers_telefono VARCHAR(50),
	pers_mail VARCHAR(50),
	pers_fecha_nac VARCHAR(50),
	pers_rango_etario INT
)
GO

CREATE TABLE SQLeros.BI_PagoAlq(
	bi_pagoAlq_codigo INT PRIMARY KEY,
	bi_pagoAlq_tiempoVencimiento INT,
	bi_pagoAlq_tiempo INT,
	--pagoAlq_esMoroso BIT	-- Es un campo calculado, no se si es correcto utilizarlo
	bi_pagoAlq_fechaVencimiento SMALLDATETIME,	-- Utilizar estas fechas o hay que usar solo el tiempo? (redundante?)
	bi_pagoAlq_fecha SMALLDATETIME,

	bi_pagoAlq_estado VARCHAR(25),
	bi_pagoAlq_monto DECIMAL(12, 2),
	bi_pagoAlq_montoAnterior DECIMAL(12, 2),
	bi_pagoAlq_tiempoInicial INT
)
GO

INSERT INTO SQLeros.BI_RangoEtario (rangoetario_descripcion) VALUES ('<25')
INSERT INTO SQLeros.BI_RangoEtario (rangoetario_descripcion) VALUES ('25-35')
INSERT INTO SQLeros.BI_RangoEtario (rangoetario_descripcion) VALUES ('35-50')
INSERT INTO SQLeros.BI_RangoEtario (rangoetario_descripcion) VALUES ('>50')
GO

INSERT INTO SQLeros.BI_RangoM2 (rangom2_descripcion) VALUES ('<35')
INSERT INTO SQLeros.BI_RangoM2 (rangom2_descripcion) VALUES ('35-55')
INSERT INTO SQLeros.BI_RangoM2 (rangom2_descripcion) VALUES ('55-75')
INSERT INTO SQLeros.BI_RangoM2 (rangom2_descripcion) VALUES ('75-100')
INSERT INTO SQLeros.BI_RangoM2 (rangom2_descripcion) VALUES ('>100')
GO

CREATE FUNCTION SQLeros.BI_f_rango_superficie (@superficie VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @rango INT
	IF CAST(@superficie AS DECIMAL(12,2)) < 35
	BEGIN
		SELECT @rango = rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE rangom2_descripcion = '<35'
	END
	ELSE IF CAST(@superficie AS DECIMAL(12,2)) >= 35 AND CAST(@superficie AS DECIMAL(12,2)) <55
	BEGIN
		SELECT @rango = rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE rangom2_descripcion = '35-55'
	END
	ELSE IF CAST(@superficie AS DECIMAL(12,2)) >= 55 AND CAST(@superficie AS DECIMAL(12,2)) <75
	BEGIN
		SELECT @rango = rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE rangom2_descripcion = '55-75'
	END
	ELSE IF CAST(@superficie AS DECIMAL(12,2)) >= 75 AND CAST(@superficie AS DECIMAL(12,2)) <100
	BEGIN
		SELECT @rango = rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE rangom2_descripcion = '75-100'
	END
	ELSE IF CAST(@superficie AS DECIMAL(12,2)) >= 100
	BEGIN
		SELECT @rango = rangom2_codigo FROM SQLeros.BI_RangoM2 WHERE rangom2_descripcion = '>100'
	END
	RETURN @rango
END
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
		SELECT @rango = rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE rangoetario_descripcion = '<25'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 25 AND CAST(@edad AS DECIMAL(12,2)) <25
	BEGIN
		SELECT @rango = rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE rangoetario_descripcion = '25-35'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 35 AND CAST(@edad AS DECIMAL(12,2)) < 50
	BEGIN
		SELECT @rango = rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE rangoetario_descripcion = '35-50'
	END
	ELSE IF CAST(@edad AS DECIMAL(12,2)) >= 50
	BEGIN
		SELECT @edad = rangoetario_codigo FROM SQLeros.BI_RangoEtario WHERE rangoetario_descripcion = '>50'
	END
	RETURN @edad
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarTiempo')
	DROP PROCEDURE SQLeros.BI_MigrarTiempo
GO

CREATE FUNCTION SQLeros.BI_ObtenerCuatrimestre(@mes INT)
RETURNS INT
AS
BEGIN
	DECLARE @cuatrimestre INT
	IF (@mes >= 0 AND @mes < 3)
	BEGIN
		SET @cuatrimestre = 1
	END
	ELSE IF (@mes >= 3 AND @mes < 6)
	BEGIN
		SET @cuatrimestre = 2
	END
	ELSE IF (@mes >= 6 AND @mes < 9)
	BEGIN
		SET @cuatrimestre = 3
	END
	ELSE IF (@mes >= 9 AND @mes <= 12)
	BEGIN
		SET @cuatrimestre = 4
	END
	RETURN @cuatrimestre
END
GO

CREATE PROCEDURE SQLeros.BI_MigrarTiempo (@tiempo SMALLDATETIME, @key INT OUTPUT)
AS
BEGIN
	INSERT INTO SQLeros.BI_Tiempo (bi_tiempo_cuatrimestre, bi_tiempo_day, bi_tiempo_month, bi_tiempo_year)
	VALUES (SQLeros.BI_ObtenerCuatrimestre(MONTH(@tiempo)), DAY(@tiempo), MONTH(@tiempo), YEAR(@tiempo))
	SET @key = SCOPE_IDENTITY()
END
GO


IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarAnuncio')
	DROP PROCEDURE SQLeros.BI_MigrarAnuncio
GO
CREATE PROCEDURE SQLeros.BI_MigrarAnuncio
AS
BEGIN
	
	DECLARE @anu_fecha_fin SMALLDATETIME
	DECLARE @anu_fecha_pub SMALLDATETIME
	DECLARE @tiempo_final INT
	DECLARE @tiempo_publicacion INT

	DECLARE @anu_agente INT
	DECLARE @anu_codigo INT
	DECLARE @anu_costo DECIMAL(12,2)
	DECLARE @anu_estado INT
	DECLARE @anu_inmueble INT
	DECLARE @anu_moneda INT
	DECLARE @anu_precio DECIMAL(12,2)
	DECLARE @comision DECIMAL(12,2)
	DECLARE @anu_sucursal INT, @anu_tipo_op INT, @anu_tipo_periodo  INT

	DECLARE c_anuncios CURSOR FOR
		SELECT anu_agente, anu_codigo, anu_costo, anu_estado, anu_fecha_fin, anu_fecha_pub, anu_inmueble, anu_moneda, anu_precio, anu_sucursal, anu_tipo_op, anu_tipo_periodo FROM SQLeros.Anuncio
	OPEN c_anuncios
	FETCH NEXT FROM c_anuncios INTO @anu_agente, @anu_codigo, @anu_costo, @anu_estado, @anu_fecha_fin, @anu_fecha_pub, @anu_inmueble, @anu_moneda, @anu_precio, @anu_sucursal, @anu_tipo_op, @anu_tipo_periodo
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		IF (SELECT tipooperacion_descripcion FROM SQLeros.TipoOperacion WHERE tipooperacion_codigo = @anu_tipo_op) = 'Tipo Operación Venta'
		BEGIN
			SELECT @comision = bi_venta_comision FROM SQLeros.BI_Venta WHERE bi_venta_anuncio = @anu_codigo
		END
		ELSE
		BEGIN
			SELECT @comision = alq_comision FROM SQLeros.Alquiler WHERE alq_anuncio = @anu_codigo
		END

		EXEC SQLeros.BI_MigrarTiempo @anu_fecha_fin, @tiempo_final OUTPUT
		EXEC SQLeros.BI_MigrarTiempo @anu_fecha_pub, @tiempo_publicacion OUTPUT
		INSERT INTO SQLeros.BI_Anuncio (bi_anu_comision, bi_anu_agente, bi_anu_codigo, bi_anu_costo, bi_anu_estado, bi_anu_tiempo_fin, bi_anu_tiempo_pub, bi_anu_inmueble, bi_anu_moneda, bi_anu_precio, bi_anu_sucursal, bi_anu_tipo_op, bi_anu_tipo_periodo)
		VALUES (@comision, @anu_agente, @anu_codigo, @anu_costo, @anu_estado, @tiempo_final, @tiempo_publicacion, @anu_inmueble, @anu_moneda, @anu_precio, @anu_sucursal, @anu_tipo_op, @anu_tipo_periodo)
		FETCH NEXT FROM c_anuncios INTO @anu_agente, @anu_codigo, @anu_costo, @anu_estado, @anu_fecha_fin, @anu_fecha_pub, @anu_inmueble, @anu_moneda, @anu_precio, @anu_sucursal, @anu_tipo_op, @anu_tipo_periodo
	END
	CLOSE c_anuncios
	DEALLOCATE c_anuncios

END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarInmueble')
	DROP PROCEDURE SQLeros.BI_MigrarInmueble
GO
CREATE PROCEDURE SQLeros.BI_MigrarInmueble
AS
BEGIN
	INSERT INTO SQLeros.BI_Inmueble (bi_inm_codigo, bi_inm_ambientes, bi_inm_antiguedad, bi_inm_descripcion, bi_inm_direccion, bi_inm_disposicion, bi_inm_estado, bi_inm_expensas, bi_inm_nombre, bi_inm_orientacion, bi_inm_rango_superficie, bi_inm_superficie, bi_inm_tipo, bi_inm_ubicacion) 
	SELECT DISTINCT inm_codigo, inm_ambientes, inm_antiguedad, inm_descripcion, inm_direccion, inm_disposicion, inm_estado, inm_expensas, inm_nombre, inm_orientacion, SQLeros.BI_f_rango_superficie(inm_superficie), CAST(inm_superficie AS DECIMAL(12,2)), inm_tipo, inm_ubicacion FROM SQLeros.Inmueble

END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarPersonas')
	DROP PROCEDURE SQLeros.BI_MigrarPersonas
GO
CREATE PROCEDURE SQLeros.BI_MigrarPersonas
AS
BEGIN
	INSERT INTO SQLeros.BI_Persona (pers_apellido, pers_codigo, pers_dni, pers_fecha_nac, pers_fecha_reg, pers_mail, pers_nombre, pers_rango_etario, pers_telefono)
	SELECT pers_apellido, pers_codigo, pers_dni, pers_fecha_nac, pers_fecha_reg, pers_mail, pers_nombre, SQLeros.BI_f_rango_etario(pers_fecha_nac), pers_telefono FROM SQLeros.Persona
	GROUP BY pers_apellido, pers_codigo, pers_dni, pers_fecha_nac, pers_fecha_reg, pers_mail, pers_nombre, pers_telefono
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarVentas')
	DROP PROCEDURE SQLeros.BI_MigrarVentas
GO

CREATE PROCEDURE SQLeros.BI_MigrarVentas
AS
BEGIN
	DECLARE @fecha SMALLDATETIME
	DECLARE @tiempo INT
	DECLARE @venta_anuncio INT
	DECLARE @precio DECIMAL(12,2)
	DECLARE @preciom2 DECIMAL(12,2)
	DECLARE @superficie DECIMAL(12,2)
	DECLARE @venta_codigo INT
	DECLARE @venta_comision INT
	DECLARE @moneda INT
	DECLARE @venta_comprador INT
	DECLARE @venta_moneda INT
	DECLARE c_ventas CURSOR FOR SELECT venta_anuncio, venta_codigo, venta_comision, venta_comprador, venta_fecha, venta_moneda, venta_precio, inm_superficie FROM SQLeros.Venta JOIN SQLeros.Anuncio ON anu_codigo = venta_anuncio JOIN SQLeros.Inmueble ON inm_codigo = anu_inmueble
	OPEN c_ventas
	FETCH NEXT FROM c_ventas INTO @venta_anuncio, @venta_codigo, @venta_comision, @venta_comprador, @fecha, @moneda, @precio, @superficie
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC SQLeros.BI_MigrarTiempo @fecha, @tiempo OUTPUT
		SET @preciom2 = @precio / @superficie
		INSERT INTO BI_Venta (bi_venta_anuncio, bi_venta_codigo, bi_venta_comision, bi_venta_comprador, bi_venta_tiempo, bi_venta_moneda, bi_venta_precio, bi_venta_precio_m2)
		VALUES (@venta_anuncio, @venta_codigo, @venta_comision, @venta_comprador, @tiempo, @moneda, @precio, @preciom2)
		FETCH NEXT FROM c_ventas INTO @venta_anuncio, @venta_codigo, @venta_comision, @venta_comprador, @fecha, @moneda, @precio, @superficie
	END
	CLOSE c_ventas
	DEALLOCATE c_ventas
END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'BI_MigrarPagoAlq')
	DROP PROCEDURE SQLeros.BI_MigrarPagoAlq
GO

CREATE FUNCTION SQLeros.BI_MontoPagoAnterior(@pagoAlquiler INT)
RETURNS DECIMAL (12, 2)
AS
BEGIN
	DECLARE @monto DECIMAL(12, 2)
	SELECT @monto = P2.pagoalq_importe
	FROM SQLeros.PagoAlquiler AS P1
		JOIN SQLeros.DetalleAlquiler AS D1 ON pagoalq_alquiler = detallealq_codigo
		JOIN SQLeros.DetalleAlquiler AS D2 ON D1.detallealq_alquiler = D2.detallealq_alquiler
		JOIN SQLeros.PagoAlquiler AS P2 ON P2.pagoalq_alquiler = D2.detallealq_codigo 
	WHERE P1.pagoalq_codigo = @pagoAlquiler AND MONTH(P1.pagoalq_fecha) - 1 = MONTH(P2.pagoalq_fecha)
	RETURN ISNULL(@monto, 0)
END
GO


CREATE PROCEDURE SQLeros.BI_MigrarPagoAlq
AS
BEGIN
	DECLARE @fechaVencimiento SMALLDATETIME, @fechaPago SMALLDATETIME, @tiempoVencimiento INT, @tiempoPago INT, @monto DECIMAL(12, 2), @codPago INT, @estado CHAR(25), @fechaInicial SMALLDATETIME, @tiempoInicial INT
	DECLARE c_pagoAlq CURSOR FOR
		SELECT pagoalq_vencimiento, pagoalq_fecha, pagoalq_importe, pagoalq_codigo, estadoalquiler_descripcion, pagoalq_fecha_inicio
		FROM PagoAlquiler
			JOIN DetalleAlquiler ON pagoalq_alquiler = detallealq_alquiler
			JOIN Alquiler ON detallealq_alquiler = Alquiler.alq_codigo
			JOIN EstadoAlquiler ON alq_estado = estadoalquiler_codigo
	OPEN c_pagoAlq
		FETCH NEXT FROM c_pagoAlq INTO @fechaVencimiento, @fechaPago, @monto, @codPago, @estado, @fechaInicial
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC SQLeros.BI_MigrarTiempo @fechaVencimiento, @tiempoVencimiento OUTPUT
			EXEC SQLeros.BI_MigrarTiempo @fechaPago, @tiempoPago OUTPUT
			EXEC SQLeros.BI_MigrarTiempo @fechaInicial, @tiempoInicial OUTPUT
			INSERT INTO BI_PagoAlq (bi_pagoAlq_tiempoVencimiento, bi_pagoAlq_tiempo, bi_pagoAlq_fechaVencimiento, bi_pagoAlq_fecha, bi_pagoAlq_monto, bi_pagoAlq_montoAnterior, bi_pagoAlq_estado)
			VALUES (@tiempoVencimiento, @tiempoPago, @fechaVencimiento, @fechaPago, @monto, SQLeros.BI_MontoPagoAnterior(@codPago), @estado, @tiempoInicial)
			FETCH NEXT FROM c_pagoAlq INTO @fechaVencimiento, @fechaPago, @monto, @codPago, @estado, @fechaInicial
		END
	CLOSE c_pagoAlq DEALLOCATE c_pagoAlq
END
GO

/*VISTA 1*/
CREATE VIEW SQLeros.BI_DuracionPromedioDeAnuncios AS
SELECT tipooperacion_descripcion AS [Tipo de operación],
AVG(DATEDIFF(DAY, anu_fecha_pub, anu_fecha_fin)) AS [Promedio]
FROM SQLeros.Anuncio
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = anu_tipo_op
GROUP BY tipooperacion_descripcion
GO

/*VISTA 2*/
CREATE VIEW SQLeros.BI_PrecioPromedioDeInmuebles AS
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

/*VISTA 3*/
CREATE VIEW SQLeros.BI_BarriosMasElegidos AS
SELECT rangoetario_descripcion,bi_tiempo_year, bi_tiempo_cuatrimestre, barrio_descripcion, COUNT(alq_codigo) AS [count] FROM SQLeros.Alquiler
JOIN SQLeros.BI_Anuncio ON bi_anu_codigo = alq_anuncio
JOIN SQLeros.BI_Inmueble ON bi_inm_codigo = bi_anu_inmueble
JOIN SQLeros.Ubicacion ON ubicacion_codigo = bi_inm_ubicacion
JOIN SQLeros.Barrio ON barrio_codigo = ubicacion_barrio
JOIN SQLeros.InquilinoPorAlquiler ON inquilinoporalquiler_alquiler = alq_codigo
JOIN SQLeros.Inquilino ON inquilino_codigo = inquilinoporalquiler_inquilino
JOIN SQLeros.BI_Persona ON pers_codigo = inquilino_persona
JOIN SQLeros.BI_RangoEtario ON rangoetario_codigo = pers_rango_etario
JOIN SQLeros.BI_Tiempo ON bi_tiempo_codigo = bi_anu_tiempo_pub
GROUP BY rangoetario_codigo, rangoetario_descripcion, barrio_codigo, barrio_descripcion, bi_tiempo_cuatrimestre, bi_tiempo_year
-ORDER BY COUNT(alq_codigo) DESC
GO
/*
SELECT rangoetario_descripcion,
	   bi_tiempo_cuatrimestre,
	  (SELECT TOP 5 barrio_descripcion FROM SQLeros.Barrio
	  JOIN
	  ORDER BY COUNT(alq_codigo))
	  FROM SQLeros.Alquiler
JOIN SQLeros.BI_Anuncio ON bi_anu_codigo = alq_anuncio
JOIN SQLeros.InquilinoPorAlquiler ON inquilinoporalquiler_alquiler = alq_codigo
JOIN SQLeros.Inquilino ON inquilino_codigo = inquilinoporalquiler_inquilino
JOIN SQLeros.BI_Persona ON pers_codigo = inquilino_persona
JOIN SQLeros.BI_RangoEtario ON rangoetario_codigo = pers_rango_etario
JOIN SQLeros.BI_Tiempo ON bi_tiempo_codigo = bi_anu_tiempo_pub
GO
*/

/*VISTA 4*/
CREATE VIEW SQLeros.BI_PorcentajeIncumpliemientoPagoAlquiler AS
SELECT bi_tiempo_month, bi_tiempo_year,
	(SELECT COUNT(*)
	FROM SQLeros.BI_PagoAlq
		JOIN SQLeros.BI_Tiempo ON bi_pagoAlq_tiempoVencimiento = bi_tiempo_codigo
	WHERE bi_pagoAlq_tiempoVencimiento < bi_pagoAlq_tiempo AND T.bi_tiempo_month = bi_tiempo_month AND T.bi_tiempo_year = bi_tiempo_year) / COUNT(*) AS [Porcentaje]
FROM SQLeros.BI_PagoAlq
	JOIN SQLeros.BI_Tiempo AS T ON bi_pagoAlq_tiempoVencimiento = bi_tiempo_codigo
GROUP BY bi_tiempo_month, bi_tiempo_year
GO

/*VISTA 5*/
-- Alquiler activo --> Estado = Activo
CREATE VIEW SQLeros.BI_PorcentajeIncrementoValorAlquiler
AS
SELECT bi_tiempo_year, bi_tiempo_month, AVG((bi_pagoAlq_monto/bi_pagoAlq_montoAnterior)*100) AS [Porcentaje Aumento]
FROM SQLeros.BI_PagoAlq
	JOIN SQLeros.BI_Tiempo ON bi_pagoAlq_tiempoInicial = bi_tiempo_codigo
WHERE bi_pagoAlq_estado = 'Activo'
GROUP BY bi_tiempo_year, bi_tiempo_month
GO

/*VISTA 6*/
CREATE VIEW SQLeros.BI_PrecioPromedioDeM2 AS
SELECT tipoinmueble_descripcion, localidad_descripcion, AVG(bi_venta_precio / bi_inm_superficie) AS [Promedio] FROM SQLeros.BI_Anuncio
JOIN SQLeros.BI_Inmueble ON bi_inm_codigo = bi_anu_inmueble
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = bi_anu_tipo_op
JOIN SQLeros.BI_Venta ON bi_venta_anuncio = bi_anu_codigo
JOIN SQLeros.TipoInmueble ON tipoinmueble_codigo = bi_inm_tipo
JOIN SQLeros.Ubicacion ON ubicacion_codigo = bi_inm_ubicacion
JOIN SQLeros.Localidad ON localidad_codigo = ubicacion_localidad
JOIN SQLeros.BI_Tiempo ON bi_tiempo_codigo = bi_venta_tiempo
GROUP BY bi_inm_tipo, localidad_codigo, localidad_descripcion, tipoinmueble_descripcion
GO

/*VISTA 7*/
CREATE VIEW SQLeros.BI_ValorPromedioDeLaComision AS
SELECT tipooperacion_descripcion, sucur_nombre, AVG(ISNULL(bi_anu_comision,0)) AS [Promedio de la comisión] FROM SQLeros.BI_Anuncio
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = bi_anu_tipo_op
JOIN SQLeros.Sucursal ON sucur_codigo = bi_anu_sucursal
GROUP BY tipooperacion_codigo, tipooperacion_descripcion, sucur_codigo, sucur_nombre
GO

/*VISTA 8*/
CREATE VIEW SQLeros.PorcentajeDeOperacionesConcretadas AS
SELECT tipooperacion_descripcion,
rangoetario_descripcion,
((SELECT SUM(bi_venta_codigo) FROM SQLeros.BI_Venta WHERE bi_venta_anuncio = A.bi_anu_codigo) / (SELECT SUM(bi_anu_codigo) FROM SQLeros.BI_Anuncio)) AS [-]
FROM SQLeros.BI_Anuncio A
JOIN SQLeros.Sucursal ON sucur_codigo = bi_anu_sucursal
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = bi_anu_tipo_op
JOIN SQLeros.Agente ON agen_codigo = bi_anu_agente
JOIN SQLeros.BI_Persona ON pers_codigo = agen_persona
JOIN SQLeros.BI_RangoEtario ON rangoetario_codigo = pers_rango_etario
JOIN SQLeros.BI_Venta ON bi_venta_anuncio = bi_anu_codigo
GROUP BY tipooperacion_descripcion, rangoetario_descripcion
GO

/*VISTA 9*/
CREATE VIEW SQLeros.MontoTotalDeCierreDeContratos AS
SELECT bi_tiempo_cuatrimestre, sucur_nombre, tipooperacion_descripcion, moneda_nombre, SUM(pagoventa_importe) AS 'Monto total de cierre' FROM SQLeros.BI_Anuncio
JOIN SQLeros.BI_Tiempo ON bi_tiempo_codigo = bi_anu_tiempo_pub
JOIN SQLeros.Sucursal ON sucur_codigo = bi_anu_sucursal
JOIN SQLeros.Moneda ON moneda_codigo = bi_anu_moneda
JOIN SQLeros.TipoOperacion ON tipooperacion_codigo = bi_anu_tipo_op
JOIN SQLeros.BI_Venta ON bi_venta_anuncio = bi_anu_codigo
JOIN SQLeros.PagoVenta ON pagoventa_venta = bi_venta_codigo
GROUP BY bi_tiempo_cuatrimestre, sucur_nombre, tipooperacion_descripcion, moneda_nombre
GO


BEGIN TRANSACTION
	BEGIN TRY
		EXEC SQLeros.BI_MigrarAnuncio
		EXEC SQLeros.BI_MigrarInmueble
		EXEC SQLeros.BI_MigrarVentas
		EXEC SQLeros.BI_MigrarPersonas
		EXEC SQLeros.BI_MigrarPagoAlq	
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH
