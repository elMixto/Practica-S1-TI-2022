CREATE TABLE `autor` ( 
  					 `rut` INT(8) UNSIGNED ZEROFILL NOT NULL , 
  					 `nombre` CHAR(50) NOT NULL , 
  					 `fono` INT(9) UNSIGNED NOT NULL );
             
ALTER TABLE `autor` ADD PRIMARY KEY (`rut`);             


CREATE TABLE `libro` ( 
  					 `codigo` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, 
  					 `titulo` VARCHAR(50) NOT NULL , 
  					 `fono` INT(9) UNSIGNED NOT NULL,
					 PRIMARY KEY (`codigo`)); 
           
           
CREATE TABLE `autorias` ( 
  					 `rut_autor` INT(10) UNSIGNED ZEROFILL NOT NULL, 
  					 `codigo_libro` INT(10) UNSIGNED ZEROFILL NOT NULL , 
  					 `fecha` DATE NOT NULL,
					 PRIMARY KEY (`rut_autor`,`codigo_libro`),
  				 CONSTRAINT `autorias_libro` FOREIGN KEY (`codigo_libro`) REFERENCES `libro`(`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  				 CONSTRAINT `autor_autorias` FOREIGN KEY (`rut_autor`) REFERENCES `autor`(`rut`) ON DELETE RESTRICT ON UPDATE RESTRICT
);
           
CREATE TABLE `ejemplares` ( 
  					 `codigo_ejemplar` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, 
  					 `codigo_libro` INT(10) UNSIGNED ZEROFILL NOT NULL, 
  					 `localizacion` VARCHAR(30) NOT NULL,
					 PRIMARY KEY (`codigo_ejemplar`,`codigo_libro`),
  				 CONSTRAINT `ejemplar_libro` FOREIGN KEY (`codigo_libro`) REFERENCES `libro`(`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT   
  );

CREATE TABLE `usuario` ( 
  					 `rut` INT(8) UNSIGNED ZEROFILL NOT NULL , 
  					 `nombre` CHAR(50) NOT NULL , 
  					 `fono` INT(9) UNSIGNED NOT NULL );
             
ALTER TABLE `usuario` ADD PRIMARY KEY (`rut`); 

CREATE TABLE `prestamos` ( 
  					 `rut_usuario` INT(8) UNSIGNED ZEROFILL NOT NULL, 
  					 `codigo_libro` INT(10) UNSIGNED ZEROFILL NOT NULL, 
  					 `codigo_ejemplar` INT(10) UNSIGNED ZEROFILL NOT NULL,
  						`fecha_prestamo` DATE NOT NULL,
  					`fecha_devolucion` DATE NOT NULL,
					 PRIMARY KEY (`rut_usuario`,`codigo_libro`,`codigo_ejemplar`),
  				 CONSTRAINT `usuario_prestamos` FOREIGN KEY (`rut_usuario`) REFERENCES `usuario`(`rut`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  				CONSTRAINT `prestamos_ejemplares` FOREIGN KEY (`codigo_ejemplar`,`codigo_libro`) REFERENCES `ejemplares` (`codigo_ejemplar`,`codigo_libro`) ON DELETE RESTRICT ON UPDATE RESTRICT
  );