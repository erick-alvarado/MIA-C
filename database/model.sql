--using database
use corona;

create table hospital(
    id_hospital INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_hospital)
);

create table asociado(
    id_asociado INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_asociado)
);

create table tratamiento(
    id_tratamiento INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    efectividad TINYINT NOT NULL,
    PRIMARY KEY(id_tratamiento)
);

create table victima(
    id_victima INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    fecha_registro DATETIME NOT NULL,
    fecha_muerte DATETIME,
    estatus VARCHAR(30) NOT NULL,
    efectividad TINYINT NOT NULL,
    PRIMARY KEY(id_victima),

    CONSTRAINT id_hospital FOREIGN KEY (id_hospital) REFERENCES hospital(id_hospital)
);

create table detalle_asociado(
    id_detalle_asociado INTEGER NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    PRIMARY KEY(id_detalle_asociado),

    CONSTRAINT id_victima FOREIGN KEY (id_victima) REFERENCES victima(id_victima),
    CONSTRAINT id_asociado FOREIGN KEY (id_asociado) REFERENCES asociado(id_asociado)
);
create table detalle_tratamiento(
    id_detalle_tratamiento INTEGER NOT NULL AUTO_INCREMENT,
    efectividad_victima TINYINT NOT NULL,
    PRIMARY KEY(id_detalle_tratamiento),

    CONSTRAINT id_victima FOREIGN KEY (id_victima) REFERENCES victima(id_victima),
    CONSTRAINT id_tratamiento FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento)
);
create table ubicacion(
    id_ubicacion INTEGER NOT NULL AUTO_INCREMENT,
    direccion VARCHAR(30) NOT NULL,
    fecha DATETIME NOT NULL,
    hora_llegada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    PRIMARY KEY(id_ubicacion),

    CONSTRAINT id_victima FOREIGN KEY (id_victima) REFERENCES victima(id_victima)
);
create table contacto(
    id_contacto INTEGER NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(30) NOT NULL,
    fecha DATETIME NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    PRIMARY KEY(id_contacto),

    CONSTRAINT id_detalle_asociado FOREIGN KEY (id_detalle_asociado) REFERENCES detalle_asociado(id_detalle_asociado)
);