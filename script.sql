CREATE SCHEMA SQLeros
GO

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

/*CREACIÓN DE LAS TABLAS*/

-- Creo la tabla Persona porque hay que almacenar los mismos datos para un propietario o inquilino
CREATE TABLE SQLeros.Persona(
	pers_codigo INT IDENTITY PRIMARY KEY,
	pers_nombre VARCHAR(50),
	pers_apellido VARCHAR(50),
	pers_dni CHAR(8),
	pers_fecha_reg SMALLDATETIME,
	pers_telefono VARCHAR(50),
	pers_mail VARCHAR(50),
	pers_fecha_nac VARCHAR(50),
);
GO

CREATE TABLE SQLeros.Inmueble(
	inm_codigo INT IDENTITY PRIMARY KEY,
	inm_nombre VARCHAR(50),
	inm_descripcion VARCHAR(50),
	inm_direccion VARCHAR(50),
	inm_suerficie VARCHAR(50),
	inm_anio VARCHAR(50),
	inm_expensas VARCHAR(50),
	inm_ubicacion INT,
	inm_tipo INT,
	inm_ambientes INT,
	inm_orientacion INT,
	inm_disposicion INT,
	inm_estado INT,
	inm_caracteristicas INT
)
GO

CREATE TABLE SQLeros.CaracteristicaInmueble(
	caracteristicainmueble_codigo INT IDENTITY PRIMARY KEY,
	caracteristicainmueble_descripcion VARCHAR(10)
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

CREATE TABLE SQLeros.Comprador(
	comprador_codigo INT IDENTITY PRIMARY KEY,
	comprador_persona INT,
)
GO

CREATE TABLE SQLeros.Alquiler(
	alq_codigo INT IDENTITY PRIMARY KEY,
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
	pagoalq_detalle VARCHAR(100),
	pagoalq_fecha SMALLDATETIME,
	pagoalq_nro_periodo INT,
	pagoalq_descripcion_periodo INT,
	pagoalq_fecha_inicio SMALLDATETIME,
	pagoalq_fecha_fin SMALLDATETIME,
	pagoalq_importe DECIMAL(12,2),
	pagoalq_medio INT
)
GO

CREATE TABLE SQLeros.MedioDePago(
	medio_codigo INT IDENTITY PRIMARY KEY,
	medio_nombre VARCHAR(10),
	medio_descripcion VARCHAR(100)
)
GO

CREATE TABLE SQLeros.Venta(
	 venta_codigo INT IDENTITY PRIMARY KEY,
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
	tipooperacion_descripcion VARCHAR(10)
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
	ambientes_cantidad INT
)
GO

CREATE TABLE SQLeros.TipoInmueble(
	tipoinmueble_codigo INT IDENTITY PRIMARY KEY,
	tipoinmueble_descripcion VARCHAR(50)
)
GO

/*MIGRACIÓN*/

INSERT INTO SQLeros.EstadoInmueble(estadoinmueble_descripcion)
SELECT DISTINCT INMUEBLE_ESTADO FROM gd_esquema.Maestra
WHERE INMUEBLE_ESTADO IS NOT NULL

INSERT INTO SQLeros.TipoInmueble(tipoinmueble_descripcion)
SELECT DISTINCT INMUEBLE_TIPO_INMUEBLE FROM gd_esquema.Maestra
WHERE INMUEBLE_TIPO_INMUEBLE IS NOT NULL


INSERT INTO SQLeros.Provincia(provincia_descripcion)
SELECT DISTINCT INMUEBLE_PROVINCIA FROM gd_esquema.Maestra
WHERE INMUEBLE_PROVINCIA IS NOT NULL

INSERT INTO SQLeros.Barrio(barrio_descripcion)
SELECT DISTINCT INMUEBLE_BARRIO FROM gd_esquema.Maestra
WHERE INMUEBLE_BARRIO IS NOT NULL

INSERT INTO SQLeros.Localidad(localidad_descripcion)
SELECT DISTINCT INMUEBLE_LOCALIDAD FROM gd_esquema.Maestra
WHERE INMUEBLE_LOCALIDAD IS NOT NULL

INSERT INTO SQLeros.Orientacion(orientacion_descripcion)
SELECT DISTINCT INMUEBLE_ORIENTACION FROM gd_esquema.Maestra
WHERE INMUEBLE_ORIENTACION IS NOT NULL

INSERT INTO SQLeros.Ubicacion(ubicacion_barrio, ubicacion_localidad, ubicacion_provincia)
SELECT barrio_codigo, localidad_codigo, provincia_codigo FROM gd_esquema.Maestra
JOIN SQLeros.Barrio ON barrio_descripcion = INMUEBLE_BARRIO
JOIN SQLeros.Localidad ON localidad_descripcion = INMUEBLE_LOCALIDAD
JOIN SQLeros.Provincia ON provincia_descripcion = INMUEBLE_PROVINCIA
GROUP BY barrio_codigo, localidad_codigo, provincia_codigo