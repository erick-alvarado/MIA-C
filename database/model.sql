create table IF NOT EXISTS hospital (
    id_hospital INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_hospital)
);

create table IF NOT EXISTS asociado(
    id_asociado INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_asociado)
);

create table IF NOT EXISTS tratamiento(
    id_tratamiento INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    efectividad TINYINT NOT NULL,
    PRIMARY KEY(id_tratamiento)
);

create table IF NOT EXISTS victima(
    id_victima INTEGER NOT NULL AUTO_INCREMENT,
    id_hospital INTEGER NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    fecha_registro DATETIME NOT NULL,
    fecha_muerte DATETIME,
    estatus VARCHAR(30) NOT NULL,
    efectividad TINYINT NOT NULL,
    PRIMARY KEY(id_victima),
    
    FOREIGN KEY (id_hospital) REFERENCES hospital(id_hospital) ON DELETE CASCADE
);

create table IF NOT EXISTS detalle_asociado(
    id_detalle_asociado INTEGER NOT NULL AUTO_INCREMENT,
    id_victima INTEGER NOT NULL,
    id_asociado INTEGER NOT NULL,
    fecha DATETIME NOT NULL,

    PRIMARY KEY(id_detalle_asociado),
    FOREIGN KEY (id_victima) REFERENCES victima(id_victima) ON DELETE CASCADE,
    FOREIGN KEY (id_asociado) REFERENCES asociado(id_asociado) ON DELETE CASCADE
);
create table IF NOT EXISTS detalle_tratamiento(
    id_detalle_tratamiento INTEGER NOT NULL AUTO_INCREMENT,
    id_victima INTEGER NOT NULL,
    id_tratamiento INTEGER NOT NULL,
    efectividad_victima TINYINT NOT NULL,
    PRIMARY KEY(id_detalle_tratamiento),

    FOREIGN KEY (id_victima) REFERENCES victima(id_victima) ON DELETE CASCADE,
    FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento) ON DELETE CASCADE
);
create table IF NOT EXISTS ubicacion(
    id_ubicacion INTEGER NOT NULL AUTO_INCREMENT,
    id_victima INTEGER NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    fecha DATETIME NOT NULL,
    hora_llegada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    PRIMARY KEY(id_ubicacion),

    FOREIGN KEY (id_victima) REFERENCES victima(id_victima) ON DELETE CASCADE

);
create table IF NOT EXISTS contacto(
    id_contacto INTEGER NOT NULL AUTO_INCREMENT,
    id_detalle_asociado INTEGER NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    fecha DATETIME NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    PRIMARY KEY(id_contacto),

    FOREIGN KEY (id_detalle_asociado) REFERENCES detalle_asociado(id_detalle_asociado) ON DELETE CASCADE
);

