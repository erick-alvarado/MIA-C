create TEMPORARY table IF NOT EXISTS temporal(
    id_temporal INTEGER NOT NULL AUTO_INCREMENT,
    nombre_victima VARCHAR(30),
    apellido_victima VARCHAR(30),
    direccion_victima VARCHAR(30),
    fecha_primera_sospecha DATETIME,
    fecha_confirmacion DATETIME,
    fecha_muerte DATETIME,
    estado_victima VARCHAR(30),
    nombre_asociado VARCHAR(30),
    apellido_asociado VARCHAR(30),
    fecha_conocio DATETIME,
    contacto_fisico VARCHAR(30),
    fecha_inicio_contacto DATETIME,
    fecha_fin_contacto DATETIME,
    nombre_hospital VARCHAR(30),
    direccion_hospital VARCHAR(30),
    ubicacion_victima VARCHAR(30),
    fecha_llegada DATETIME,
    fecha_retiro DATETIME,
    tratamiento VARCHAR(30),
    efectividad TINYINT,
    fecha_inicio_tratamiento DATETIME,
    fecha_fin_tratamiento DATETIME,
    efectividad_victima TINYINT,
    PRIMARY KEY(id_temporal)
);