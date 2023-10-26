/*
CREATE SCHEMA SQLeros
GO
*/

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
BEGIN
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
END

CREATE TABLE SQLeros.Inmueble(
	inm_codigo INT IDENTITY PRIMARY KEY,
	inm_nombre VARCHAR(50),
	inm_descripcion VARCHAR(50),
	inm_direccion VARCHAR(100),
	inm_superficie VARCHAR(50),
	inm_antiguedad VARCHAR(50),
	inm_expensas VARCHAR(50),
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
	ambientes_cantidad VARCHAR(50)
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

INSERT INTO SQLeros.Ambientes(ambientes_cantidad)
SELECT DISTINCT INMUEBLE_CANT_AMBIENTES FROM gd_esquema.Maestra
WHERE INMUEBLE_CANT_AMBIENTES IS NOT NULL

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

INSERT INTO SQLeros.Disposicion(disposicion_descripcion)
SELECT DISTINCT INMUEBLE_DISPOSICION FROM gd_esquema.Maestra
WHERE INMUEBLE_DISPOSICION IS NOT NULL

INSERT INTO SQLeros.Ubicacion(ubicacion_barrio, ubicacion_localidad, ubicacion_provincia)
SELECT barrio_codigo, localidad_codigo, provincia_codigo FROM gd_esquema.Maestra
JOIN SQLeros.Barrio ON barrio_descripcion = INMUEBLE_BARRIO
JOIN SQLeros.Localidad ON localidad_descripcion = INMUEBLE_LOCALIDAD
JOIN SQLeros.Provincia ON provincia_descripcion = INMUEBLE_PROVINCIA
GROUP BY barrio_codigo, localidad_codigo, provincia_codigo

INSERT INTO SQLeros.Ubicacion(ubicacion_localidad, ubicacion_provincia)
SELECT localidad_codigo, provincia_codigo FROM gd_esquema.Maestra
JOIN SQLeros.Localidad ON localidad_descripcion = SUCURSAL_LOCALIDAD
JOIN SQLeros.Provincia ON provincia_descripcion = SUCURSAL_PROVINCIA
WHERE localidad_codigo NOT IN (SELECT localidad_codigo FROM SQLeros.Localidad)
GROUP BY localidad_codigo, provincia_codigo

INSERT INTO SQLeros.CaracteristicaInmueble(caracteristicainmueble_descripcion) VALUES ('WiFi')

INSERT INTO SQLeros.CaracteristicaInmueble(caracteristicainmueble_descripcion) VALUES ('Cable')

INSERT INTO SQLeros.CaracteristicaInmueble(caracteristicainmueble_descripcion) VALUES ('Calefacción')

INSERT INTO SQLeros.CaracteristicaInmueble(caracteristicainmueble_descripcion) VALUES ('Gas')

BEGIN
INSERT INTO SQLeros.Persona(pers_dni, pers_nombre, pers_apellido, pers_mail, pers_telefono, pers_fecha_nac, pers_fecha_reg)
SELECT DISTINCT PROPIETARIO_DNI, PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_MAIL, PROPIETARIO_TELEFONO, PROPIETARIO_FECHA_NAC, PROPIETARIO_FECHA_REGISTRO FROM gd_esquema.Maestra
WHERE PROPIETARIO_DNI IS NOT NULL

INSERT INTO SQLeros.Persona(pers_dni, pers_nombre, pers_apellido, pers_mail, pers_telefono, pers_fecha_nac, pers_fecha_reg)
SELECT DISTINCT AGENTE_DNI, AGENTE_NOMBRE, AGENTE_APELLIDO, AGENTE_MAIL, AGENTE_TELEFONO, AGENTE_FECHA_NAC, AGENTE_FECHA_REGISTRO
FROM gd_esquema.Maestra
WHERE PROPIETARIO_DNI IS NOT NULL AND PROPIETARIO_DNI NOT IN (
SELECT pers_dni FROM SQLeros.Persona
)
END

INSERT INTO SQLeros.Propietario (propietario_persona)
SELECT pers_codigo FROM SQLeros.Persona
WHERE pers_dni IN (
SELECT PROPIETARIO_DNI FROM gd_esquema.Maestra
)

INSERT INTO SQLeros.Inmueble (inm_descripcion, inm_ambientes, inm_direccion, inm_disposicion, inm_estado, inm_expensas, inm_ubicacion, inm_superficie, inm_antiguedad, inm_tipo, inm_nombre)
SELECT DISTINCT INMUEBLE_DESCRIPCION, ambientes_codigo, INMUEBLE_DIRECCION, disposicion_codigo, estadoinmueble_codigo, INMUEBLE_EXPESAS, ubicacion_codigo, INMUEBLE_SUPERFICIETOTAL, INMUEBLE_ANTIGUEDAD, tipoinmueble_codigo, INMUEBLE_NOMBRE
FROM gd_esquema.Maestra
LEFT JOIN SQLeros.Ambientes ON  INMUEBLE_CANT_AMBIENTES = ambientes_cantidad
LEFT JOIN SQLeros.Disposicion ON  INMUEBLE_DISPOSICION = disposicion_descripcion
LEFT JOIN SQLeros.EstadoInmueble ON  INMUEBLE_ESTADO = estadoinmueble_descripcion
JOIN SQLeros.TipoInmueble ON tipoinmueble_descripcion = INMUEBLE_TIPO_INMUEBLE
LEFT JOIN SQLeros.Ubicacion ON ubicacion_codigo = (
	SELECT ubicacion_codigo
	FROM SQLeros.Ubicacion A
	JOIN SQLeros.Barrio ON barrio_codigo = A.ubicacion_barrio
	JOIN SQLeros.Localidad ON localidad_codigo = A.ubicacion_localidad
	JOIN SQLeros.Provincia ON provincia_codigo = A.ubicacion_provincia
	WHERE INMUEBLE_BARRIO = barrio_descripcion
	AND INMUEBLE_LOCALIDAD = localidad_descripcion
	AND INMUEBLE_PROVINCIA = provincia_descripcion
	)
WHERE INMUEBLE_CODIGO IS NOT NULL

GROUP BY INMUEBLE_DESCRIPCION, ambientes_codigo, INMUEBLE_DIRECCION, disposicion_codigo, estadoinmueble_codigo, INMUEBLE_EXPESAS, ubicacion_codigo, INMUEBLE_SUPERFICIETOTAL, INMUEBLE_ANTIGUEDAD, tipoinmueble_codigo, INMUEBLE_NOMBRE

SELECT * FROM SQLeros.Inmueble

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


/*
INSERT INTO SQLeros.Sucursal (sucur_nombre, sucur_direccion, sucur_sucur_telefono, sucur_ubicacion)
SELECT SUCURSAL_NOMBRE, SUCURSAL_DIRECCION, SUCURSAL_TELEFONO, SQLeros.Ubicacion FROM gd_esquema.Maestra
JOIN SQLeros.Ubicacion ON (SLECT barrio_descripcion FROM SQLeros.Barrio)

*/



/*
INSERT INTO SQLeros.Agente (agen_persona, agen_sucursal)
SELECT pers_codigo, AGENTE_NOMBRE FROM SQLeros.Persona
LEFT JOIN gd_esquema.Maestra ON pers_dni = AGENTE_DNI
WHERE pers_dni IN (
SELECT PROPIETARIO_DNI FROM gd_esquema.Maestra
)
*/

SELECT inm_descripcion, caracteristicainmueble_descripcion FROM SQLeros.CaracteristicaInmueblePorInmueble
JOIN SQLeros.Inmueble ON inm_codigo = caracteristicainmuebleporinmueble_inmueble
JOIN SQLeros.CaracteristicaInmueble ON caracteristicainmueble_codigo = caracteristicainmuebleporinmueble_caracteristica
/*
SELECT * FROM gd_esquema.Maestra WHERE INMUEBLE_ANTIGUEDAD IS NOT NULL
*/