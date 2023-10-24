CREATE SCHEMA SQLeros
GO

IF OBJECT_ID('Persona', 'U') IS NOT NULL
DROP TABLE Persona;

IF OBJECT_ID('Propietario', 'U') IS NOT NULL
DROP TABLE Propietario;

IF OBJECT_ID('Agente', 'U') IS NOT NULL
DROP TABLE Agente;

IF OBJECT_ID('Inmueble', 'U') IS NOT NULL
DROP TABLE Inmueble;

IF OBJECT_ID('CaracteristicaInmueble', 'U') IS NOT NULL
DROP TABLE CaracteristicaInmueble;

IF OBJECT_ID('CaracteristicaInmueblePorInmueble', 'U') IS NOT NULL
DROP TABLE CaracteristicaInmueblePorInmueble;

IF OBJECT_ID('Anuncio', 'U') IS NOT NULL
DROP TABLE Anuncio;

IF OBJECT_ID('Sucursal', 'U') IS NOT NULL
DROP TABLE Sucursal;

IF OBJECT_ID('Inquilino', 'U') IS NOT NULL
DROP TABLE Inquilino;

IF OBJECT_ID('Comprador', 'U') IS NOT NULL
DROP TABLE Comprador;

IF OBJECT_ID('Alquiler', 'U') IS NOT NULL
DROP TABLE Alquiler;

IF OBJECT_ID('DetalleAlquiler', 'U') IS NOT NULL
DROP TABLE DetalleAlquiler;

IF OBJECT_ID('PagoAlquiler', 'U') IS NOT NULL
DROP TABLE PagoAlquiler;

IF OBJECT_ID('MedioDePago', 'U') IS NOT NULL
DROP TABLE MedioDePago;

IF OBJECT_ID('Venta', 'U') IS NOT NULL
DROP TABLE Venta;

IF OBJECT_ID('PagoVenta', 'U') IS NOT NULL
DROP TABLE PagoVenta;

/*CREACIÓN DE LAS TABLAS*/

-- Creo la tabla Persona porque hay que almacenar los mismos datos para un propietario o inquilino
CREATE TABLE SQLeros.Persona(
	pers_codigo INT PRIMARY KEY,
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
	inm_codigo INT PRIMARY KEY,
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
	caracteristicainmueble_codigo INT PRIMARY KEY,
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
	anu_codigo INT PRIMARY KEY,
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
	sucur_codigo INT PRIMARY KEY,
	sucur_nombre VARCHAR(50),
	sucur_ubicacion INT,
	sucur_sucur_telefono VARCHAR(20),
	sucur_direccion VARCHAR(100),
)
GO

CREATE TABLE SQLeros.Agente(
	agen_codigo INT PRIMARY KEY,
	agen_persona INT,
	agen_sucursal INT
)
GO

CREATE TABLE SQLeros.Propietario(
	propietario_codigo INT PRIMARY KEY,
	propietario_persona INT,
)
GO

CREATE TABLE SQLeros.Inquilino(
	inquilino_codigo INT PRIMARY KEY,
	inquilino_persona INT,
)
GO

CREATE TABLE SQLeros.Comprador(
	comprador_codigo INT PRIMARY KEY,
	comprador_persona INT,
)
GO

CREATE TABLE SQLeros.Alquiler(
	alq_codigo INT PRIMARY KEY,
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
	detallealq_codigo INT PRIMARY KEY,
	detallealq_alquiler INT,
	detallealq_nro_periodo_inicial INT,
	detallealq_nro_periodo_final INT,
	detallealq_precio DECIMAL(12,2)
)
GO

CREATE TABLE SQLeros.PagoAlquiler(
	pagoalq_codigo INT PRIMARY KEY,
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
	medio_codigo INT PRIMARY KEY,
	medio_nombre VARCHAR(10),
	medio_descripcion VARCHAR(100)
)
GO

CREATE TABLE SQLeros.Venta(
	 venta_codigo INT PRIMARY KEY,
	 venta_comprador INT,
	 venta_anuncio INT,
	 venta_fecha SMALLDATETIME,
	 venta_precio DECIMAL(12,2),
	 venta_comision DECIMAL(12,2),
	 venta_moneda INT
)
GO

CREATE TABLE SQLeros.PagoVenta(
	pagoventa_codigo INT PRIMARY KEY,
	pagoventa_venta INT,
	pagoventa_importe DECIMAL(12,2),
	pagoventa_moneda INT,
	pagoventa_cotizacion DECIMAL(12,2),
	pagoventa_medio INT
)
GO

CREATE TABLE SQLeros.EstadoAnuncio(
	estadoanuncio_codigo INT PRIMARY KEY,
	estadoanuncio_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.TipoOperacion(
	tipooperacion_codigo INT PRIMARY KEY,
	tipooperacion_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.Barrio(
	barrio_codigo INT PRIMARY KEY,
	barrio_descripcion VARCHAR(20)
)
GO

CREATE TABLE SQLeros.Localidad(
	localidad_codigo INT PRIMARY KEY,
	localidad_descripcion VARCHAR(20)
)
GO

CREATE TABLE SQLeros.Provincia(
	provincia_codigo INT PRIMARY KEY,
	provincia_descripcion VARCHAR(20)
)
GO

CREATE TABLE SQLeros.Ubicacion(
	ubicacion_codigo INT PRIMARY KEY,
	ubicacion_barrio INT,
	ubicacion_localidad INT,
	ubicacion_provincia INT
)
GO

CREATE TABLE SQLeros.EstadoInmueble(
	estadoinmueble_codigo INT PRIMARY KEY,
	estadoinmueble_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.Disposicion(
	disposicion_codigo INT PRIMARY KEY,
	disposicion_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.Orientacion(
	orientacion_codigo INT PRIMARY KEY,
	orientacion_descripcion VARCHAR(10)
)
GO

CREATE TABLE SQLeros.Ambientes(
	ambientes_codigo INT PRIMARY KEY,
	ambientes_cantidad INT
)
GO

CREATE TABLE SQLeros.TipoInmueble(
	tipoinmueble_codigo INT PRIMARY KEY,
	tipoinmueble_descripcion VARCHAR(10)
)
GO