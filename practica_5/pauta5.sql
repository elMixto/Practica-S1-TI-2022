
CREATE TABLE empleado (
    id INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    nombre CHAR(50) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE vehiculo (
    id INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    marca CHAR(50) NOT NULL,
    modelo CHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE servicio (
    id INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    nombre CHAR(50) NOT NULL,
    valor INT UNSIGNED NOT NULL,
    PRIMARY KEY (id)

);

CREATE TABLE prestacion_servicio (
    id INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    id_empleado INT(3) UNSIGNED ZEROFILL NOT NULL,
    id_vehiculo INT(3) UNSIGNED ZEROFILL NOT NULL,
    id_servicio INT(3) UNSIGNED ZEROFILL NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT empleado_ps FOREIGN KEY (id_empleado) REFERENCES empleado(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT vehiculo_ps FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT servicio_ps FOREIGN KEY (id_servicio) REFERENCES servicio(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

/*Para despues*/
INSERT INTO empleado(nombre,fecha_ingreso) VALUES("Mario Molina","2010/02/10");
INSERT INTO vehiculo(marca,modelo) VALUES("Toyota","Yaris");
INSERT INTO servicio(nombre,valor) VALUES("Limpieza",15000);

INSERT INTO prestacion_servicio (id_empleado,id_vehiculo,id_servicio,fecha) VALUES(7,1,1,"2018/11/15");

/*c*/
SELECT COUNT(*) FROM PRESTACION_SERVICIO WHERE BETWEEN "2018/10</01" AND "2018/11/23";
/*d*/
SELECT id_vehiculo, COUNT(id_servicio) FROM prestacion_servicio GROUP BY id_vehiculo;
/*e*/
SELECT id_vehiculo, COUNT(id_servicio)
    FROM prestacion_servicio GROUP BY id_vehiculo ORDER BY COUNT(id_servicio) ASC;

/*f*/
SELECT empleado.nombre, servicio.nombre, vehiculo.modelo
    FROM empleado, servicio,vehiculo,prestacion_servicio
        WHERE empleado.id = prestacion_servicio.id_empleado
            AND servicio.id = prestacion_servicio.id_servicio
            AND vehiculo.id = prestacion_servicio.id_vehiculo
            AND prestacion_servicio.id = 1;


