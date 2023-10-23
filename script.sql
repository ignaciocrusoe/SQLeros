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