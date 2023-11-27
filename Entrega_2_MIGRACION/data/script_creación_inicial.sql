IF SCHEMA_ID('SQLeros') IS NULL
	BEGIN
		EXECUTE('CREATE SCHEMA SQLeros'	)
	END
GO

USE GD2C2023

IF OBJECT_ID('SQLeros.Persona', 'U') IS NOT NULL
DROP TABLE SQLeros.Persona;

IF OBJECT_ID('SQLeros.Propietario', 'U') IS NOT NULL
DROP TABLE SQLeros.Propietario;

IF OBJECT_ID('SQLeros.Agente', 'U') IS NOT NULL
DROP TABLE SQLeros.Agente;

IF OBJECT_ID('SQLeros.Inmueble', 'U') IS NOT NULL
DROP TABLE SQLeros.Inmueble;

IF OBJECT_ID('SQLeros.CaracteristicaInmueble', 'U') IS NOT NULL
DROP TABLE SQLeros.CaracteristicaInmueble;

IF OBJECT_ID('SQLeros.CaracteristicaInmueblePorInmueble', 'U') IS NOT NULL
DROP TABLE SQLeros.CaracteristicaInmueblePorInmueble;

IF OBJECT_ID('SQLeros.Anuncio', 'U') IS NOT NULL
DROP TABLE SQLeros.Anuncio;

IF OBJECT_ID('SQLeros.Sucursal', 'U') IS NOT NULL
DROP TABLE SQLeros.Sucursal;

IF OBJECT_ID('SQLeros.Inquilino', 'U') IS NOT NULL
DROP TABLE SQLeros.Inquilino;

IF OBJECT_ID('SQLeros.Comprador', 'U') IS NOT NULL
DROP TABLE SQLeros.Comprador;

IF OBJECT_ID('SQLeros.Alquiler', 'U') IS NOT NULL
DROP TABLE SQLeros.Alquiler;

IF OBJECT_ID('SQLeros.DetalleAlquiler', 'U') IS NOT NULL
DROP TABLE SQLeros.DetalleAlquiler;

IF OBJECT_ID('SQLeros.PagoAlquiler', 'U') IS NOT NULL
DROP TABLE SQLeros.PagoAlquiler;

IF OBJECT_ID('SQLeros.MedioDePago', 'U') IS NOT NULL
DROP TABLE SQLeros.MedioDePago;

IF OBJECT_ID('SQLeros.Venta', 'U') IS NOT NULL
DROP TABLE SQLeros.Venta;

IF OBJECT_ID('SQLeros.PagoVenta', 'U') IS NOT NULL
DROP TABLE SQLeros.PagoVenta;

IF OBJECT_ID('SQLeros.EstadoAnuncio', 'U') IS NOT NULL
DROP TABLE SQLeros.EstadoAnuncio;

IF OBJECT_ID('SQLeros.TipoOperacion', 'U') IS NOT NULL
DROP TABLE SQLeros.TipoOperacion;

IF OBJECT_ID('SQLeros.Barrio', 'U') IS NOT NULL
DROP TABLE SQLeros.Barrio;

IF OBJECT_ID('SQLeros.Localidad', 'U') IS NOT NULL
DROP TABLE SQLeros.Localidad;

IF OBJECT_ID('SQLeros.Provincia', 'U') IS NOT NULL
DROP TABLE SQLeros.Provincia;

IF OBJECT_ID('SQLeros.Ubicacion', 'U') IS NOT NULL
DROP TABLE SQLeros.Ubicacion;

IF OBJECT_ID('SQLeros.EstadoInmueble', 'U') IS NOT NULL
DROP TABLE SQLeros.EstadoInmueble;

IF OBJECT_ID('SQLeros.Disposicion', 'U') IS NOT NULL
DROP TABLE SQLeros.Disposicion;

IF OBJECT_ID('SQLeros.Orientacion', 'U') IS NOT NULL
DROP TABLE SQLeros.Orientacion;

IF OBJECT_ID('SQLeros.Ambientes', 'U') IS NOT NULL
DROP TABLE SQLeros.Ambientes;

IF OBJECT_ID('SQLeros.TipoInmueble', 'U') IS NOT NULL
DROP TABLE SQLeros.TipoInmueble;

IF OBJECT_ID('SQLeros.Moneda', 'U') IS NOT NULL
DROP TABLE SQLeros.Moneda;

IF OBJECT_ID('SQLeros.TipoPeriodo', 'U') IS NOT NULL
DROP TABLE SQLeros.TipoPeriodo;

IF OBJECT_ID('SQLeros.EstadoAlquiler', 'U') IS NOT NULL
DROP TABLE SQLeros.EstadoAlquiler;

IF OBJECT_ID('SQLeros.InquilinoPorAlquiler', 'U') IS NOT NULL
DROP TABLE SQLeros.InquilinoPorAlquiler;

/*CREACIÓN DE LAS TABLAS*/

-- Creo la tabla Persona porque hay que almacenar los mismos datos para un propietario o inquilino
BEGIN
CREATE TABLE SQLeros.Persona(
	pers_codigo INT IDENTITY PRIMARY KEY,
	pers_nombre VARCHAR(50),
	pers_apellido VARCHAR(50),
	pers_dni CHAR(8),
	pers_fecha_reg SMALLDATETIME,
	pers_telefono VARCHAR(50),
	pers_mail VARCHAR(50),
	pers_fecha_nac VARCHAR(50)
);
END

CREATE TABLE SQLeros.Inmueble(
	inm_codigo INT IDENTITY PRIMARY KEY,
	inm_codigo_maestra INT,
	inm_nombre VARCHAR(50),
	inm_descripcion VARCHAR(50),
	inm_direccion VARCHAR(100),
	inm_superficie VARCHAR(50),
	inm_antiguedad VARCHAR(50),
	inm_expensas DECIMAL(20,8),
	inm_ubicacion INT,
	inm_tipo INT,
	inm_ambientes INT,
	inm_orientacion INT,
	inm_disposicion INT,
	inm_estado INT,
)
GO

CREATE TABLE SQLeros.CaracteristicaInmueble(
	caracteristicainmueble_codigo INT IDENTITY PRIMARY KEY,
	caracteristicainmueble_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros. CaracteristicaInmueblePorInmueble(
	caracteristicainmuebleporinmueble_inmueble INT,
	caracteristicainmuebleporinmueble_caracteristica INT,
	CONSTRAINT CaracteristicaInmueblePorInmueblePK PRIMARY KEY (caracteristicainmuebleporinmueble_inmueble, caracteristicainmuebleporinmueble_caracteristica)
)
GO

CREATE TABLE SQLeros.Anuncio(
	anu_codigo INT IDENTITY PRIMARY KEY,
	anu_codigo_maestra INT,
	anu_agente INT,
	anu_inmueble INT,
	anu_sucursal INT,
	anu_fecha_pub SMALLDATETIME,
	anu_precio DECIMAL(12,2),
	anu_costo DECIMAL(12,2),
	anu_fecha_fin SMALLDATETIME,
	anu_tipo_op INT,
	anu_moneda INT,
	anu_estado INT,
	anu_tipo_periodo INT
)
GO

CREATE TABLE SQLeros.Sucursal(
	sucur_codigo INT IDENTITY PRIMARY KEY,
	sucur_codigo_maestra INT,
	sucur_nombre VARCHAR(50),
	sucur_ubicacion INT,
	sucur_sucur_telefono VARCHAR(20),
	sucur_direccion VARCHAR(100),
)
GO

CREATE TABLE SQLeros.Agente(
	agen_codigo INT IDENTITY PRIMARY KEY,
	agen_persona INT,
	agen_sucursal INT
)
GO

CREATE TABLE SQLeros.Propietario(
	propietario_codigo INT IDENTITY PRIMARY KEY,
	propietario_persona INT,
)
GO

CREATE TABLE SQLeros.Inquilino(
	inquilino_codigo INT IDENTITY PRIMARY KEY,
	inquilino_persona INT,
)
GO

CREATE TABLE SQLeros.InquilinoPorAlquiler(
	inquilinoporalquiler_inquilino INT,
	inquilinoporalquiler_alquiler INT,
	CONSTRAINT InquilinoPorAlquilerPK PRIMARY KEY (inquilinoporalquiler_inquilino, inquilinoporalquiler_alquiler)
)
GO

CREATE TABLE SQLeros.Comprador(
	comprador_codigo INT IDENTITY PRIMARY KEY,
	comprador_persona INT,
)
GO

CREATE TABLE SQLeros.Alquiler(
	alq_codigo INT IDENTITY PRIMARY KEY,
	alq_codigo_maestra INT,
	alq_inquilino INT,
	alq_anuncio INT,
	alq_fecha_inicio SMALLDATETIME,
	alq_fecha_fin SMALLDATETIME,
	alq_cant_periodos INT,
	alq_depositio DECIMAL(12,2),
	alq_comision DECIMAL(12,2),
	alq_gastos DECIMAL(12,2),
	alq_estado INT,
	alq_precio DECIMAL(12,2)
)
GO

CREATE TABLE SQLeros.DetalleAlquiler(
	detallealq_codigo INT IDENTITY PRIMARY KEY,
	detallealq_alquiler INT,
	detallealq_nro_periodo_inicial INT,
	detallealq_nro_periodo_final INT,
	detallealq_precio DECIMAL(12,2)
)
GO

CREATE TABLE SQLeros.PagoAlquiler(
	pagoalq_codigo INT IDENTITY PRIMARY KEY,
	pagoalq_codigo_maestra INT,
	pagoalq_fecha SMALLDATETIME,
	pagoalq_nro_periodo INT,
	pagoalq_alquiler INT,
	pagoalq_descripcion_periodo VARCHAR(100),
	pagoalq_fecha_inicio SMALLDATETIME,
	pagoalq_fecha_fin SMALLDATETIME,
	pagoalq_importe DECIMAL(12,2),
	pagoalq_medio INT,
	pagoalq_vencimiento SMALLDATETIME
)
GO

CREATE TABLE SQLeros.MedioDePago(
	medio_codigo INT IDENTITY PRIMARY KEY,
	medio_nombre VARCHAR(25),
)
GO

CREATE TABLE SQLeros.Venta(
	 venta_codigo INT IDENTITY PRIMARY KEY,
	 venta_codigo_maestra INT,
	 venta_comprador INT,
	 venta_anuncio INT,
	 venta_fecha SMALLDATETIME,
	 venta_precio DECIMAL(12,2),
	 venta_comision DECIMAL(12,2),
	 venta_moneda INT
)
GO

CREATE TABLE SQLeros.PagoVenta(
	pagoventa_codigo INT IDENTITY PRIMARY KEY,
	pagoventa_venta INT,
	pagoventa_importe DECIMAL(12,2),
	pagoventa_moneda INT,
	pagoventa_cotizacion DECIMAL(12,2),
	pagoventa_medio INT
)
GO

CREATE TABLE SQLeros.EstadoAnuncio(
	estadoanuncio_codigo INT IDENTITY PRIMARY KEY,
	estadoanuncio_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.TipoOperacion(
	tipooperacion_codigo INT IDENTITY PRIMARY KEY,
	tipooperacion_descripcion VARCHAR(40)
)
GO

CREATE TABLE SQLeros.Barrio(
	barrio_codigo INT IDENTITY PRIMARY KEY,
	barrio_descripcion VARCHAR(20)
)
GO

CREATE TABLE SQLeros.Localidad(
	localidad_codigo INT IDENTITY PRIMARY KEY,
	localidad_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.Provincia(
	provincia_codigo INT IDENTITY PRIMARY KEY,
	provincia_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.Ubicacion(
	ubicacion_codigo INT IDENTITY PRIMARY KEY,
	ubicacion_barrio INT,
	ubicacion_localidad INT,
	ubicacion_provincia INT
)
GO

CREATE TABLE SQLeros.EstadoInmueble(
	estadoinmueble_codigo INT IDENTITY PRIMARY KEY,
	estadoinmueble_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.Disposicion(
	disposicion_codigo INT IDENTITY PRIMARY KEY,
	disposicion_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.Orientacion(
	orientacion_codigo INT IDENTITY PRIMARY KEY,
	orientacion_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.Ambientes(
	ambientes_codigo INT IDENTITY PRIMARY KEY,
	ambientes_cantidad VARCHAR(50)
)
GO

CREATE TABLE SQLeros.TipoInmueble(
	tipoinmueble_codigo INT IDENTITY PRIMARY KEY,
	tipoinmueble_descripcion VARCHAR(50)
)
GO

CREATE TABLE SQLeros.Moneda(
	moneda_codigo INT IDENTITY PRIMARY KEY,
	moneda_nombre VARCHAR(20),
	moneda_eq_pesos decimal(8,2)
)
GO

CREATE TABLE SQLeros.TipoPeriodo(
	tipoperiodo_codigo INT IDENTITY PRIMARY KEY,
	tipoperiodo_descripcion VARCHAR(20)
)
GO

CREATE TABLE SQLeros.EstadoAlquiler(
	estadoalquiler_codigo INT IDENTITY PRIMARY KEY,
	estadoalquiler_descripcion VARCHAR(25),
)
GO

/*MIGRACIÓN*/

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarEstadoAlquiler')
	DROP PROCEDURE SQLeros.MigrarEstadoAlquiler
GO
CREATE PROCEDURE SQLeros.MigrarEstadoAlquiler
	AS
		BEGIN
			INSERT INTO SQLeros.EstadoAlquiler(estadoalquiler_descripcion)
			SELECT DISTINCT ALQUILER_ESTADO FROM gd_esquema.Maestra
			WHERE ALQUILER_ESTADO IS NOT NULL
			GROUP BY ALQUILER_ESTADO
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarEstadoInmueble')
	DROP PROCEDURE SQLeros.MigrarEstadoInmueble
GO
CREATE PROCEDURE SQLeros.MigrarEstadoInmueble
	AS
		BEGIN
			INSERT INTO SQLeros.EstadoInmueble(estadoinmueble_descripcion)
			SELECT DISTINCT INMUEBLE_ESTADO FROM gd_esquema.Maestra
			WHERE INMUEBLE_ESTADO IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarTipoInmueble')
	DROP PROCEDURE SQLeros.MigrarTipoInmueble
GO
CREATE PROCEDURE SQLeros.MigrarTipoInmueble
	AS
		BEGIN
			INSERT INTO SQLeros.TipoInmueble(tipoinmueble_descripcion)
			SELECT DISTINCT INMUEBLE_TIPO_INMUEBLE FROM gd_esquema.Maestra
			WHERE INMUEBLE_TIPO_INMUEBLE IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarAmbientes')
	DROP PROCEDURE SQLeros.MigrarAmbientes
GO
CREATE PROCEDURE SQLeros.MigrarAmbientes
	AS
		BEGIN
			INSERT INTO SQLeros.Ambientes(ambientes_cantidad)
			SELECT DISTINCT INMUEBLE_CANT_AMBIENTES FROM gd_esquema.Maestra
			WHERE INMUEBLE_CANT_AMBIENTES IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarProvincia')
	DROP PROCEDURE SQLeros.MigrarProvincia
GO
CREATE PROCEDURE SQLeros.MigrarProvincia
	AS
		BEGIN
			INSERT INTO SQLeros.Provincia(provincia_descripcion)
			SELECT DISTINCT INMUEBLE_PROVINCIA FROM gd_esquema.Maestra
			WHERE INMUEBLE_PROVINCIA IS NOT NULL
		
			INSERT INTO SQLeros.Provincia(provincia_descripcion)
			SELECT DISTINCT SUCURSAL_PROVINCIA FROM gd_esquema.Maestra
			WHERE SUCURSAL_PROVINCIA IS NOT NULL
			AND SUCURSAL_PROVINCIA NOT IN (SELECT provincia_descripcion FROM SQLeros.Provincia)
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarBarrio')
	DROP PROCEDURE SQLeros.MigrarBarrio
GO
CREATE PROCEDURE SQLeros.MigrarBarrio
	AS
		BEGIN
			INSERT INTO SQLeros.Barrio(barrio_descripcion)
			SELECT DISTINCT INMUEBLE_BARRIO FROM gd_esquema.Maestra
			GROUP BY INMUEBLE_BARRIO
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarLocalidad')
	DROP PROCEDURE SQLeros.MigrarLocalidad
GO
CREATE PROCEDURE SQLeros.MigrarLocalidad
	AS
		BEGIN
			INSERT INTO SQLeros.Localidad(localidad_descripcion)
			SELECT DISTINCT INMUEBLE_LOCALIDAD FROM gd_esquema.Maestra
			WHERE INMUEBLE_LOCALIDAD IS NOT NULL
			
			INSERT INTO SQLeros.Localidad(localidad_descripcion)
			SELECT DISTINCT SUCURSAL_LOCALIDAD FROM gd_esquema.Maestra
			WHERE SUCURSAL_LOCALIDAD IS NOT NULL
			AND SUCURSAL_LOCALIDAD NOT IN (SELECT localidad_descripcion FROM SQLeros.Localidad)
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarOrientacion')
	DROP PROCEDURE SQLeros.MigrarOrientacion
GO
CREATE PROCEDURE SQLeros.MigrarOrientacion
	AS
		BEGIN
			INSERT INTO SQLeros.Orientacion(orientacion_descripcion)
			SELECT DISTINCT INMUEBLE_ORIENTACION FROM gd_esquema.Maestra
			WHERE INMUEBLE_ORIENTACION IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarDisposicion')
	DROP PROCEDURE SQLeros.MigrarDisposicion
GO
CREATE PROCEDURE SQLeros.MigrarDisposicion
	AS
		BEGIN
			INSERT INTO SQLeros.Disposicion(disposicion_descripcion)
			SELECT DISTINCT INMUEBLE_DISPOSICION FROM gd_esquema.Maestra
			WHERE INMUEBLE_DISPOSICION IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarMoneda')
	DROP PROCEDURE SQLeros.MigrarMoneda
GO
CREATE PROCEDURE SQLeros.MigrarMoneda
	AS
		BEGIN
			INSERT INTO SQLeros.Moneda (moneda_nombre)
			SELECT DISTINCT ANUNCIO_MONEDA FROM gd_esquema.Maestra
			
			INSERT INTO SQLeros.Moneda (moneda_nombre)
			SELECT DISTINCT PAGO_VENTA_MONEDA FROM gd_esquema.Maestra
			WHERE PAGO_VENTA_MONEDA NOT IN (SELECT moneda_nombre FROM SQLeros.Moneda)
			
			INSERT INTO SQLeros.Moneda (moneda_nombre)
			SELECT DISTINCT VENTA_MONEDA FROM gd_esquema.Maestra
			WHERE VENTA_MONEDA NOT IN (SELECT moneda_nombre FROM SQLeros.Moneda)
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarUbicacion')
	DROP PROCEDURE SQLeros.MigrarUbicacion
GO
CREATE PROCEDURE SQLeros.MigrarUbicacion
	AS
		BEGIN
			INSERT INTO SQLeros.Ubicacion(ubicacion_barrio, ubicacion_localidad, ubicacion_provincia)
			SELECT barrio_codigo, localidad_codigo, provincia_codigo FROM gd_esquema.Maestra
			JOIN SQLeros.Barrio ON barrio_descripcion = INMUEBLE_BARRIO
			JOIN SQLeros.Localidad ON localidad_descripcion = INMUEBLE_LOCALIDAD
			JOIN SQLeros.Provincia ON provincia_descripcion = INMUEBLE_PROVINCIA
			GROUP BY barrio_codigo, localidad_codigo, provincia_codigo
			
			INSERT INTO SQLeros.Ubicacion(ubicacion_localidad, ubicacion_provincia)
			SELECT localidad_codigo, provincia_codigo FROM gd_esquema.Maestra
			LEFT JOIN SQLeros.Localidad ON localidad_descripcion = SUCURSAL_LOCALIDAD
			LEFT JOIN SQLeros.Provincia ON provincia_descripcion = SUCURSAL_PROVINCIA
			WHERE SUCURSAL_LOCALIDAD IS NOT NULL
			GROUP BY localidad_codigo, provincia_codigo
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarCaracteristicaInmueble')
	DROP PROCEDURE SQLeros.MigrarCaracteristicaInmueble
GO
CREATE PROCEDURE SQLeros.MigrarCaracteristicaInmueble
	AS
		BEGIN
			INSERT INTO SQLeros.CaracteristicaInmueble(caracteristicainmueble_descripcion) VALUES ('WiFi')
			
			INSERT INTO SQLeros.CaracteristicaInmueble(caracteristicainmueble_descripcion) VALUES ('Cable')
			
			INSERT INTO SQLeros.CaracteristicaInmueble(caracteristicainmueble_descripcion) VALUES ('Calefacción')
			
			INSERT INTO SQLeros.CaracteristicaInmueble(caracteristicainmueble_descripcion) VALUES ('Gas')
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarPersona')
	DROP PROCEDURE SQLeros.MigrarPersona
GO
CREATE PROCEDURE SQLeros.MigrarPersona
	AS
		BEGIN
			INSERT INTO SQLeros.Persona(pers_dni, pers_nombre, pers_apellido, pers_mail, pers_telefono, pers_fecha_nac, pers_fecha_reg)
			SELECT DISTINCT PROPIETARIO_DNI, PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_MAIL, PROPIETARIO_TELEFONO, PROPIETARIO_FECHA_NAC, PROPIETARIO_FECHA_REGISTRO FROM gd_esquema.Maestra
			WHERE PROPIETARIO_DNI IS NOT NULL
			
			INSERT INTO SQLeros.Persona(pers_dni, pers_nombre, pers_apellido, pers_mail, pers_telefono, pers_fecha_nac, pers_fecha_reg)
			SELECT DISTINCT AGENTE_DNI, AGENTE_NOMBRE, AGENTE_APELLIDO, AGENTE_MAIL, AGENTE_TELEFONO, AGENTE_FECHA_NAC, AGENTE_FECHA_REGISTRO
			FROM gd_esquema.Maestra
			WHERE AGENTE_DNI IS NOT NULL AND AGENTE_DNI NOT IN (
			SELECT pers_dni FROM SQLeros.Persona
			)
			
			INSERT INTO SQLeros.Persona(pers_dni, pers_nombre, pers_apellido, pers_mail, pers_telefono, pers_fecha_nac, pers_fecha_reg)
			SELECT DISTINCT INQUILINO_DNI, INQUILINO_NOMBRE, INQUILINO_APELLIDO, INQUILINO_MAIL, INQUILINO_TELEFONO, INQUILINO_FECHA_NAC, INQUILINO_FECHA_REGISTRO
			FROM gd_esquema.Maestra
			WHERE INQUILINO_DNI IS NOT NULL AND INQUILINO_DNI NOT IN (
			SELECT pers_dni FROM SQLeros.Persona
			)
			
			INSERT INTO SQLeros.Persona(pers_dni, pers_nombre, pers_apellido, pers_mail, pers_telefono, pers_fecha_nac, pers_fecha_reg)
			SELECT DISTINCT COMPRADOR_DNI, COMPRADOR_NOMBRE, COMPRADOR_APELLIDO, COMPRADOR_MAIL, COMPRADOR_TELEFONO, COMPRADOR_FECHA_NAC, COMPRADOR_FECHA_REGISTRO
			FROM gd_esquema.Maestra
			WHERE COMPRADOR_DNI IS NOT NULL AND COMPRADOR_DNI NOT IN (
			SELECT pers_dni FROM SQLeros.Persona
			)
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarPropietario')
	DROP PROCEDURE SQLeros.MigrarPropietario
GO
CREATE PROCEDURE SQLeros.MigrarPropietario
	AS
		BEGIN
			INSERT INTO SQLeros.Propietario (propietario_persona)
			SELECT pers_codigo FROM SQLeros.Persona
			WHERE pers_dni IN (
			SELECT PROPIETARIO_DNI FROM gd_esquema.Maestra
			)
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarInquilino')
	DROP PROCEDURE SQLeros.MigrarInquilino
GO
CREATE PROCEDURE SQLeros.MigrarInquilino
	AS
		BEGIN
			INSERT INTO SQLeros.Inquilino (inquilino_persona)
			SELECT pers_codigo FROM SQLeros.Persona
			WHERE pers_dni IN (
			SELECT INQUILINO_DNI FROM gd_esquema.Maestra
			)
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarComprador')
	DROP PROCEDURE SQLeros.MigrarComprador
GO
CREATE PROCEDURE SQLeros.MigrarComprador
	AS
		BEGIN
			INSERT INTO SQLeros.comprador (comprador_persona)
			SELECT pers_codigo FROM SQLeros.Persona
			WHERE pers_dni IN (
			SELECT COMPRADOR_DNI FROM gd_esquema.Maestra
			)
	END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarInmueble')
	DROP PROCEDURE SQLeros.MigrarInmueble
GO
CREATE PROCEDURE SQLeros.MigrarInmueble
	AS
		BEGIN
			INSERT INTO SQLeros.Inmueble (inm_codigo_maestra, inm_descripcion, inm_ambientes, inm_direccion, inm_disposicion, inm_estado, inm_expensas, inm_ubicacion, inm_superficie, inm_antiguedad, inm_tipo, inm_nombre, inm_orientacion)
			SELECT DISTINCT INMUEBLE_CODIGO, INMUEBLE_DESCRIPCION, ambientes_codigo, INMUEBLE_DIRECCION, disposicion_codigo, estadoinmueble_codigo, INMUEBLE_EXPESAS, ubicacion_codigo, INMUEBLE_SUPERFICIETOTAL, INMUEBLE_ANTIGUEDAD, tipoinmueble_codigo, INMUEBLE_NOMBRE, orientacion_codigo
			FROM gd_esquema.Maestra
			LEFT JOIN SQLeros.Ambientes ON  INMUEBLE_CANT_AMBIENTES = ambientes_cantidad
			LEFT JOIN SQLeros.Disposicion ON  INMUEBLE_DISPOSICION = disposicion_descripcion
			LEFT JOIN SQLeros.EstadoInmueble ON  INMUEBLE_ESTADO = estadoinmueble_descripcion
			JOIN SQLeros.TipoInmueble ON tipoinmueble_descripcion = INMUEBLE_TIPO_INMUEBLE
			JOIN SQLeros.Orientacion ON orientacion_descripcion = INMUEBLE_ORIENTACION
			JOIN SQLeros.Ubicacion ON ubicacion_codigo = (
				SELECT TOP 1 ubicacion_codigo	--Revisar el TOP 1
				FROM SQLeros.Ubicacion A
				JOIN SQLeros.Barrio ON barrio_codigo = A.ubicacion_barrio
				JOIN SQLeros.Localidad ON localidad_codigo = A.ubicacion_localidad
				JOIN SQLeros.Provincia ON provincia_codigo = A.ubicacion_provincia
				WHERE INMUEBLE_BARRIO = barrio_descripcion
				AND INMUEBLE_LOCALIDAD = localidad_descripcion
				AND INMUEBLE_PROVINCIA = provincia_descripcion
				)
			WHERE INMUEBLE_CODIGO IS NOT NULL
			GROUP BY INMUEBLE_CODIGO, INMUEBLE_DESCRIPCION, ambientes_codigo, INMUEBLE_DIRECCION, disposicion_codigo, estadoinmueble_codigo, INMUEBLE_EXPESAS, ubicacion_codigo, INMUEBLE_SUPERFICIETOTAL, INMUEBLE_ANTIGUEDAD, tipoinmueble_codigo, INMUEBLE_NOMBRE, orientacion_codigo
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarCaracteristicaInmueblePorInmueble')
	DROP PROCEDURE SQLeros.MigrarCaracteristicaInmueblePorInmueble
GO
CREATE PROCEDURE SQLeros.MigrarCaracteristicaInmueblePorInmueble
	AS
		BEGIN
			INSERT INTO SQLeros.CaracteristicaInmueblePorInmueble (caracteristicainmuebleporinmueble_inmueble, caracteristicainmuebleporinmueble_caracteristica)
			SELECT inm_codigo, (SELECT caracteristicainmueble_codigo FROM SQLeros.CaracteristicaInmueble WHERE caracteristicainmueble_descripcion = 'Wifi')
			FROM SQLeros.Inmueble
			JOIN gd_esquema.Maestra ON inm_descripcion =  INMUEBLE_DESCRIPCION
			AND inm_ambientes = (SELECT ambientes_codigo FROM SQLeros.Ambientes WHERE ambientes_cantidad = INMUEBLE_CANT_AMBIENTES)
			AND inm_antiguedad = INMUEBLE_ANTIGUEDAD
			AND inm_direccion = INMUEBLE_DIRECCION
			AND inm_disposicion = (SELECT disposicion_codigo FROM SQLeros.Disposicion WHERE disposicion_descripcion = INMUEBLE_DISPOSICION) 
			AND inm_estado = (SELECT estadoinmueble_codigo FROM SQLeros.EstadoInmueble WHERE estadoinmueble_descripcion = INMUEBLE_ESTADO)
			AND inm_expensas = INMUEBLE_EXPESAS
			WHERE INMUEBLE_CARACTERISTICA_WIFI = 1
			GROUP BY inm_codigo
			
			INSERT INTO SQLeros.CaracteristicaInmueblePorInmueble (caracteristicainmuebleporinmueble_inmueble, caracteristicainmuebleporinmueble_caracteristica)
			SELECT inm_codigo, (SELECT caracteristicainmueble_codigo FROM SQLeros.CaracteristicaInmueble WHERE caracteristicainmueble_descripcion = 'Cable')
			FROM SQLeros.Inmueble
			JOIN gd_esquema.Maestra ON inm_descripcion =  INMUEBLE_DESCRIPCION
			AND inm_ambientes = (SELECT ambientes_codigo FROM SQLeros.Ambientes WHERE ambientes_cantidad = INMUEBLE_CANT_AMBIENTES)
			AND inm_antiguedad = INMUEBLE_ANTIGUEDAD
			AND inm_direccion = INMUEBLE_DIRECCION
			AND inm_disposicion = (SELECT disposicion_codigo FROM SQLeros.Disposicion WHERE disposicion_descripcion = INMUEBLE_DISPOSICION) 
			AND inm_estado = (SELECT estadoinmueble_codigo FROM SQLeros.EstadoInmueble WHERE estadoinmueble_descripcion = INMUEBLE_ESTADO)
			AND inm_expensas = INMUEBLE_EXPESAS
			WHERE INMUEBLE_CARACTERISTICA_CABLE = 1
			GROUP BY inm_codigo
			
			INSERT INTO SQLeros.CaracteristicaInmueblePorInmueble (caracteristicainmuebleporinmueble_inmueble, caracteristicainmuebleporinmueble_caracteristica)
			SELECT inm_codigo, (SELECT caracteristicainmueble_codigo FROM SQLeros.CaracteristicaInmueble WHERE caracteristicainmueble_descripcion = 'Calefacción')
			FROM SQLeros.Inmueble
			JOIN gd_esquema.Maestra ON inm_descripcion =  INMUEBLE_DESCRIPCION
			AND inm_ambientes = (SELECT ambientes_codigo FROM SQLeros.Ambientes WHERE ambientes_cantidad = INMUEBLE_CANT_AMBIENTES)
			AND inm_antiguedad = INMUEBLE_ANTIGUEDAD
			AND inm_direccion = INMUEBLE_DIRECCION
			AND inm_disposicion = (SELECT disposicion_codigo FROM SQLeros.Disposicion WHERE disposicion_descripcion = INMUEBLE_DISPOSICION) 
			AND inm_estado = (SELECT estadoinmueble_codigo FROM SQLeros.EstadoInmueble WHERE estadoinmueble_descripcion = INMUEBLE_ESTADO)
			AND inm_expensas = INMUEBLE_EXPESAS
			WHERE INMUEBLE_CARACTERISTICA_CALEFACCION = 1
			GROUP BY inm_codigo
			
			INSERT INTO SQLeros.CaracteristicaInmueblePorInmueble (caracteristicainmuebleporinmueble_inmueble, caracteristicainmuebleporinmueble_caracteristica)
			SELECT inm_codigo, (SELECT caracteristicainmueble_codigo FROM SQLeros.CaracteristicaInmueble WHERE caracteristicainmueble_descripcion = 'Gas')
			FROM SQLeros.Inmueble
			JOIN gd_esquema.Maestra ON inm_descripcion =  INMUEBLE_DESCRIPCION
			AND inm_ambientes = (SELECT ambientes_codigo FROM SQLeros.Ambientes WHERE ambientes_cantidad = INMUEBLE_CANT_AMBIENTES)
			AND inm_antiguedad = INMUEBLE_ANTIGUEDAD
			AND inm_direccion = INMUEBLE_DIRECCION
			AND inm_disposicion = (SELECT disposicion_codigo FROM SQLeros.Disposicion WHERE disposicion_descripcion = INMUEBLE_DISPOSICION) 
			AND inm_estado = (SELECT estadoinmueble_codigo FROM SQLeros.EstadoInmueble WHERE estadoinmueble_descripcion = INMUEBLE_ESTADO)
			AND inm_expensas = INMUEBLE_EXPESAS
			WHERE INMUEBLE_CARACTERISTICA_GAS = 1
			GROUP BY inm_codigo
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarSucursal')
	DROP PROCEDURE SQLeros.MigrarSucursal
GO
CREATE PROCEDURE SQLeros.MigrarSucursal
	AS
		BEGIN
			INSERT INTO SQLeros.Sucursal (sucur_codigo_maestra, sucur_nombre, sucur_direccion, sucur_sucur_telefono, sucur_ubicacion)
			SELECT DISTINCT SUCURSAL_CODIGO, SUCURSAL_NOMBRE, SUCURSAL_DIRECCION, SUCURSAL_TELEFONO, ubicacion_codigo FROM gd_esquema.Maestra
			LEFT JOIN SQLeros.Ubicacion ON ubicacion_codigo = (
				SELECT ubicacion_codigo
				FROM SQLeros.Ubicacion A
				JOIN SQLeros.Localidad ON localidad_codigo = A.ubicacion_localidad
				JOIN SQLeros.Provincia ON provincia_codigo = A.ubicacion_provincia
				WHERE SUCURSAL_LOCALIDAD = localidad_descripcion
				AND SUCURSAL_PROVINCIA = provincia_descripcion
				)
			GROUP BY SUCURSAL_NOMBRE, SUCURSAL_DIRECCION, SUCURSAL_TELEFONO, ubicacion_codigo, SUCURSAL_CODIGO
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarAgente')
	DROP PROCEDURE SQLeros.MigrarAgente
GO
CREATE PROCEDURE SQLeros.MigrarAgente
	AS
		BEGIN
			INSERT INTO SQLeros.Agente (agen_persona, agen_sucursal)
			SELECT distinct pers_codigo, sucur_codigo FROM SQLeros.Persona
			left join gd_esquema.Maestra on AGENTE_DNI = pers_dni
			join SQLeros.sucursal on SUCURSAL_CODIGO = sucur_codigo_maestra
			WHERE pers_dni IN (SELECT AGENTE_DNI FROM gd_esquema.Maestra)
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarEstadoAnuncio')
	DROP PROCEDURE SQLeros.MigrarEstadoAnuncio
GO
CREATE PROCEDURE SQLeros.MigrarEstadoAnuncio
	AS
		BEGIN
			INSERT INTO SQLeros.EstadoAnuncio (estadoanuncio_descripcion)
			SELECT DISTINCT ANUNCIO_ESTADO FROM gd_esquema.Maestra
			WHERE ANUNCIO_ESTADO IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarTipoOperacion')
	DROP PROCEDURE SQLeros.MigrarTipoOperacion
GO
CREATE PROCEDURE SQLeros.MigrarTipoOperacion
	AS
		BEGIN
			INSERT INTO SQLeros.TipoOperacion (tipooperacion_descripcion)
			SELECT DISTINCT ANUNCIO_TIPO_OPERACION FROM gd_esquema.Maestra
			WHERE ANUNCIO_TIPO_OPERACION IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarTipoPeriodo')
	DROP PROCEDURE SQLeros.MigrarTipoPeriodo
GO
CREATE PROCEDURE SQLeros.MigrarTipoPeriodo
	AS
		BEGIN
			INSERT INTO SQLeros.TipoPeriodo (tipoperiodo_descripcion)
			SELECT DISTINCT ANUNCIO_TIPO_PERIODO FROM gd_esquema.Maestra
			WHERE ANUNCIO_TIPO_PERIODO IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarAnuncio')
	DROP PROCEDURE SQLeros.MigrarAnuncio
GO
CREATE PROCEDURE SQLeros.MigrarAnuncio
	AS
		BEGIN
			INSERT INTO SQLeros.Anuncio (anu_codigo_maestra, anu_agente, anu_inmueble, anu_sucursal, anu_fecha_pub, anu_precio, anu_costo, anu_fecha_fin, anu_tipo_op, anu_moneda, anu_estado, anu_tipo_periodo)
			SELECT ANUNCIO_CODIGO, agen_codigo, inm_codigo, sucur_codigo, ANUNCIO_FECHA_PUBLICACION, ANUNCIO_PRECIO_PUBLICADO, ANUNCIO_COSTO_ANUNCIO, ANUNCIO_FECHA_FINALIZACION, tipooperacion_codigo, moneda_codigo, estadoanuncio_codigo, tipoperiodo_codigo
			FROM gd_esquema.Maestra
			JOIN SQLeros.Persona ON pers_dni = AGENTE_DNI
			JOIN SQLeros.Agente ON agen_persona = pers_codigo
			JOIN SQLeros.Inmueble ON inm_codigo_maestra = INMUEBLE_CODIGO
			JOIN SQLeros.Sucursal ON sucur_codigo_maestra = SUCURSAL_CODIGO
			JOIN SQLeros.TipoOperacion ON tipooperacion_descripcion = ANUNCIO_TIPO_OPERACION
			JOIN SQLeros.EstadoAnuncio ON estadoanuncio_descripcion = ANUNCIO_ESTADO
			JOIN SQLeros.TipoPeriodo ON tipoperiodo_descripcion = ANUNCIO_TIPO_PERIODO
			JOIN SQLeros.Moneda ON moneda_nombre = ANUNCIO_MONEDA
			GROUP BY ANUNCIO_CODIGO, agen_codigo, inm_codigo, sucur_codigo, ANUNCIO_FECHA_PUBLICACION, ANUNCIO_PRECIO_PUBLICADO, ANUNCIO_COSTO_ANUNCIO, ANUNCIO_FECHA_FINALIZACION, tipooperacion_codigo, moneda_codigo, estadoanuncio_codigo, tipoperiodo_codigo
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarAlquiler')
	DROP PROCEDURE SQLeros.MigrarAlquiler
GO
CREATE PROCEDURE SQLeros.MigrarAlquiler
	AS
		BEGIN
			INSERT INTO SQLeros.Alquiler (alq_codigo_maestra, alq_anuncio, alq_cant_periodos, alq_comision, alq_depositio, alq_fecha_fin, alq_fecha_inicio, alq_gastos, alq_precio, alq_estado)
			SELECT DISTINCT ALQUILER_CODIGO, anu_codigo, ALQUILER_CANT_PERIODOS, ALQUILER_COMISION, ALQUILER_DEPOSITO, ALQUILER_FECHA_FIN, ALQUILER_FECHA_INICIO, ALQUILER_GASTOS_AVERIGUA, ANUNCIO_PRECIO_PUBLICADO, estadoalquiler_codigo
			FROM gd_esquema.Maestra
			JOIN SQLeros.EstadoAnuncio ON estadoanuncio_descripcion = ANUNCIO_ESTADO
			JOIN SQLeros.EstadoAlquiler ON estadoalquiler_descripcion = ALQUILER_ESTADO
			JOIN SQLeros.Anuncio ON anu_codigo_maestra = ANUNCIO_CODIGO
			GROUP BY ALQUILER_CODIGO, anu_codigo, ALQUILER_CANT_PERIODOS, ALQUILER_COMISION, ALQUILER_DEPOSITO, ALQUILER_FECHA_FIN, ALQUILER_FECHA_INICIO, ALQUILER_GASTOS_AVERIGUA, ANUNCIO_PRECIO_PUBLICADO, estadoalquiler_codigo
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarDetalleAlquiler')
	DROP PROCEDURE SQLeros.MigrarDetalleAlquiler
GO
CREATE PROCEDURE SQLeros.MigrarDetalleAlquiler
	AS
		BEGIN
			INSERT INTO SQLeros.DetalleAlquiler (detallealq_alquiler, detallealq_nro_periodo_final, detallealq_nro_periodo_inicial, detallealq_precio)
			SELECT DISTINCT alquiler_codigo, DETALLE_ALQ_NRO_PERIODO_FIN, DETALLE_ALQ_NRO_PERIODO_INI, DETALLE_ALQ_PRECIO FROM gd_esquema.Maestra
			JOIN SQLeros.Alquiler ON alq_codigo_maestra = ALQUILER_CODIGO
			WHERE DETALLE_ALQ_PRECIO IS NOT NULL
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarVenta')
	DROP PROCEDURE SQLeros.MigrarVenta
GO
CREATE PROCEDURE SQLeros.MigrarVenta
	AS
		BEGIN
			INSERT INTO SQLeros.Venta (venta_codigo_maestra, venta_anuncio, venta_comision, venta_comprador, venta_fecha, venta_moneda, venta_precio)
			SELECT DISTINCT VENTA_CODIGO, anu_codigo, VENTA_COMISION, comprador_codigo, VENTA_FECHA, moneda_codigo, VENTA_PRECIO_VENTA
			FROM gd_esquema.Maestra
			JOIN SQLeros.Anuncio ON anu_codigo_maestra = ANUNCIO_CODIGO
			JOIN SQLeros.Persona ON pers_dni = COMPRADOR_DNI
			JOIN SQLeros.Comprador ON comprador_persona = pers_codigo
			JOIN SQLeros.Moneda ON moneda_nombre = VENTA_MONEDA
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarMedioDePago')
	DROP PROCEDURE SQLeros.MigrarMedioDePago
GO
CREATE PROCEDURE SQLeros.MigrarMedioDePago
	AS
		BEGIN
			INSERT INTO SQLeros.MedioDePago (medio_nombre)
			SELECT DISTINCT PAGO_ALQUILER_MEDIO_PAGO FROM gd_esquema.Maestra
			WHERE PAGO_ALQUILER_MEDIO_PAGO IS NOT NULL

			INSERT INTO SQLeros.MedioDePago (medio_nombre)
			SELECT DISTINCT PAGO_VENTA_MEDIO_PAGO FROM gd_esquema.Maestra
			WHERE PAGO_VENTA_MEDIO_PAGO IS NOT NULL
			AND PAGO_VENTA_MEDIO_PAGO NOT IN (SELECT medio_nombre FROM SQLeros.MedioDePago)
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarPagoAlquiler')
	DROP PROCEDURE SQLeros.MigrarPagoAlquiler
GO
CREATE PROCEDURE SQLeros.MigrarPagoAlquiler
	AS
		BEGIN
			INSERT INTO SQLeros.PagoAlquiler (pagoalq_codigo_maestra, pagoalq_alquiler, pagoalq_descripcion_periodo, pagoalq_fecha, pagoalq_fecha_fin, pagoalq_fecha_inicio, pagoalq_importe, pagoalq_medio, pagoalq_nro_periodo, pagoalq_vencimiento)
			SELECT DISTINCT PAGO_ALQUILER_CODIGO, alq_codigo, PAGO_ALQUILER_DESC, PAGO_ALQUILER_FECHA, PAGO_ALQUILER_FEC_FIN, PAGO_ALQUILER_FEC_INI, PAGO_ALQUILER_IMPORTE, medio_codigo, PAGO_ALQUILER_NRO_PERIODO, PAGO_ALQUILER_FECHA_VENCIMIENTO
			FROM gd_esquema.Maestra
			JOIN SQLeros.MedioDePago ON medio_nombre = PAGO_ALQUILER_MEDIO_PAGO
			JOIN SQLeros.Alquiler ON alq_codigo_maestra = ALQUILER_CODIGO
		END
GO
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarPagoVenta')
	DROP PROCEDURE SQLeros.MigrarPagoVenta
GO
CREATE PROCEDURE SQLeros.MigrarPagoVenta
	AS
		BEGIN
			INSERT INTO SQLeros.PagoVenta(pagoventa_venta, pagoventa_importe, pagoventa_moneda, pagoventa_cotizacion, pagoventa_medio)
			SELECT DISTINCT V.venta_codigo, M.PAGO_VENTA_IMPORTE, moneda_codigo, M.PAGO_VENTA_COTIZACION, medio_codigo
			FROM gd_esquema.Maestra M
			JOIN SQLeros.MedioDePago ON medio_nombre = M.PAGO_VENTA_MEDIO_PAGO
			JOIN SQLeros.Moneda ON moneda_nombre = M.PAGO_VENTA_MONEDA
			JOIN SQLeros.Venta V ON venta_codigo_maestra = M.VENTA_CODIGO
			GROUP BY V.venta_codigo, M.PAGO_VENTA_IMPORTE, moneda_codigo, M.PAGO_VENTA_COTIZACION, medio_codigo
		END
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarInquilinoPorAlquiler')
	DROP PROCEDURE SQLeros.MigrarInquilinoPorAlquiler
GO
CREATE PROCEDURE SQLeros.MigrarInquilinoPorAlquiler
	AS
		BEGIN
			INSERT INTO SQLeros.InquilinoPorAlquiler(inquilinoporalquiler_inquilino, inquilinoporalquiler_alquiler)
			SELECT DISTINCT inquilino_codigo, alquiler_codigo
			FROM gd_esquema.Maestra
			JOIN Persona ON INQUILINO_DNI = pers_dni
			JOIN SQLeros.Inquilino ON inquilino_persona = pers_codigo
			JOIN SQLeros.Alquiler ON alq_codigo_maestra = ALQUILER_CODIGO
		END
GO

BEGIN TRANSACTION
	BEGIN TRY
		EXEC SQLeros.MigrarEstadoInmueble
		EXEC SQLeros.MigrarTipoInmueble
		EXEC SQLeros.MigrarAmbientes
		EXEC SQLeros.MigrarProvincia
		EXEC SQLeros.MigrarBarrio
		EXEC SQLeros.MigrarLocalidad
		EXEC SQLeros.MigrarOrientacion
		EXEC SQLeros.MigrarDisposicion
		EXEC SQLeros.MigrarUbicacion
		EXEC SQLeros.MigrarMoneda
		EXEC SQLeros.MigrarCaracteristicaInmueble
		EXEC SQLeros.MigrarPersona
		EXEC SQLeros.MigrarPropietario
		EXEC SQLeros.MigrarInquilino
		EXEC SQLeros.MigrarComprador
		EXEC SQLeros.MigrarInmueble
		EXEC SQLeros.MigrarCaracteristicaInmueblePorInmueble
		EXEC SQLeros.MigrarSucursal
		EXEC SQLeros.MigrarAgente
		EXEC SQLeros.MigrarEstadoAnuncio
		EXEC SQLeros.MigrarTipoOperacion
		EXEC SQLeros.MigrarTipoPeriodo
		EXEC SQLeros.MigrarAnuncio
		EXEC SQLeros.MigrarEstadoAlquiler
		EXEC SQLeros.MigrarAlquiler
		EXEC SQLeros.MigrarDetalleAlquiler
		EXEC SQLeros.MigrarVenta
		EXEC SQLeros.MigrarMedioDePago
		EXEC SQLeros.MigrarPagoAlquiler
		EXEC SQLeros.MigrarPagoVenta
		EXEC SQLeros.MigrarInquilinoPorAlquiler
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
	END CATCH