CREATE SCHEMA SQLeros
GO

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

CREATE TABLE SQLeros.Inmueble(
	inm_codigo INT PRIMARY KEY,
	inm_nombre VARCHAR(50),
	inm_descripcion VARCHAR(50),
	inm_direccion VARCHAR(50),
	inm_suerficie VARCHAR(50),
	inm_anio VARCHAR(50),
	inm_expensas VARCHAR(50),
	inm_wifi BIT,
	inm_cable BIT,
	inm_calefaccion BIT,
	inm_gas BIT,
	inm_ubicacion INT,
	inm_tipo INT,
	inm_ambientes INT,
	inm_orientacion INT,
	inm_disposicion INT,
	inm_estado INT,
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