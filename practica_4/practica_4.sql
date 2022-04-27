-- Eliminamos la tabla autor si existe anteriormente
DROP TABLE IF EXISTS `Autor`;

-- Creamos la tabla autor
CREATE TABLE `Autor` (
  `rut` int(8) unsigned zerofill NOT NULL,
  `nombre` char(50) NOT NULL,
  `fono` int(9) unsigned NOT NULL,
  PRIMARY KEY (`rut`)
);

-- Creamos la tabla Libro
DROP TABLE IF EXISTS `Libro`;

CREATE TABLE `Libro` (
  `codigo` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) NOT NULL,
  `ISBN` int(12) NOT NULL,
  `editorial` char(30) NOT NULL,
  PRIMARY KEY (`codigo`)
) ;

-- Creamos la tabla escribe
DROP TABLE IF EXISTS `escribe`;
CREATE TABLE `escribe` (
  `rut` int(8) unsigned zerofill NOT NULL,
  `codigo_libro` bigint(20) unsigned NOT NULL,
  `fecha_autoria` date DEFAULT NULL,
  PRIMARY KEY (`rut`,`codigo_libro`),
  KEY `escribe_libro` (`codigo_libro`),
  CONSTRAINT `autor_escribe` FOREIGN KEY (`rut`) REFERENCES `Autor` (`rut`),
  CONSTRAINT `escribe_libro` FOREIGN KEY (`codigo_libro`) REFERENCES `Libro` (`codigo`)
);


-- Creamos la tabla ejemplares

DROP TABLE IF EXISTS `Ejemplares`;

CREATE TABLE `Ejemplares` (
  `codigoLibro` bigint(20) unsigned NOT NULL,
  `codigoEjemplar` int(100) NOT NULL,
  `localizacion` varchar(50) NOT NULL,
  PRIMARY KEY (`codigoLibro`,`codigoEjemplar`),
  CONSTRAINT `ejemplar_libro` FOREIGN KEY (`codigoLibro`) REFERENCES `Libro` (`codigo`)
);


DROP TABLE IF EXISTS `Usuario`;

CREATE TABLE `Usuario` (
  `rut` int(8) unsigned zerofill NOT NULL,
  PRIMARY KEY (`rut`)
);

DROP TABLE IF EXISTS `Prestamos`;


CREATE TABLE `Prestamos` (
  `Rut` int(8) unsigned zerofill NOT NULL,
  `codigoLibro` bigint(20) unsigned NOT NULL,
  `codigoEjemplar` int(100) NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion` date NOT NULL,
  PRIMARY KEY (`Rut`,`codigoLibro`,`codigoEjemplar`),
  KEY `Prestamos_Ejemplares_FK` (`codigoLibro`,`codigoEjemplar`),
  CONSTRAINT `Prestamos_Ejemplares_FK` FOREIGN KEY (`codigoLibro`, `codigoEjemplar`) REFERENCES `Ejemplares` (`codigoLibro`, `codigoEjemplar`),
  CONSTRAINT `usuario_prestamo` FOREIGN KEY (`Rut`) REFERENCES `Usuario` (`rut`)
);






