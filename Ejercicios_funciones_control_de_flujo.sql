/*
 Funciones y Control de Errores
 Entra en la base de datos academia y carga el fichero TARJETAS.sql.
*/
use academia;
/*
1. Crea una función que divida los números de las tarjetas en grupos de 4 
dígitos. Para las que son tipo VISA, separaremos estos grupos con ‘-’. Y para 
las que son tipo MASTERCARD, separaremos con ‘/’. Si el número no tiene 16 
dígitos escribe: ‘Número incorrecto’
*/
DROP FUNCTION IF EXISTS dividir_digitos_tarjeta;
DELIMITER //
CREATE FUNCTION dividir_digitos_tarjeta(id_tarjeta INT)
RETURNS VARCHAR(50) READS SQL DATA
BEGIN 
	DECLARE resultado VARCHAR(50);
    DECLARE tipo_tarjeta VARCHAR(50);
    SELECT num_tarjeta, tipo INTO resultado, tipo_tarjeta FROM tarjetas WHERE id = id_tarjeta;
    IF length(resultado) = 16 AND tipo_tarjeta = 'visa' THEN
		SET resultado = concat(
        substring(resultado,1,4),' - ',
        substring(resultado,5,4),' - ',
        substring(resultado,9,4),' - ',
        substring(resultado,13,4)
        );
	ELSEIF length(resultado) = 16 AND tipo_tarjeta = 'mastercard' THEN
		SET resultado = concat(
        substring(resultado,1,4),' / ',
        substring(resultado,5,4),' / ',
        substring(resultado,9,4),' / ',
        substring(resultado,13,4)
        );
	ELSE
		SET resultado = 'Número incorrecto';
	END IF;
    RETURN resultado;
END //

DELIMITER ;
SELECT dividir_digitos_tarjeta(9);
SELECT num_tarjeta, dividir_digitos_tarjeta(id) AS num_tarjeta, tipo FROM tarjetas;


-- Una forma más óptima de hacerlo es guardar los digitos en bloques de 4 y de esta forma 
-- Se calcula más rápido los número de tarjetas
DROP FUNCTION IF EXISTS dividir_tarjetas;
DELIMITER //
CREATE FUNCTION dividir_tarjetas(num_tarjeta VARCHAR(16), tipo VARCHAR(50))
RETURNS VARCHAR(50) NO SQL
BEGIN
	DECLARE bloque1 VARCHAR(4);
    DECLARE bloque2 VARCHAR(4);
    DECLARE bloque3 VARCHAR(4);
    DECLARE bloque4 VARCHAR(4);
    
    SET bloque1 = ' ';
    SET bloque2 = ' ';
    SET bloque3 = ' ';
    SET bloque4 = ' ';
    
    IF length(num_tarjeta) <> 16 THEN 
		RETURN 'Número incorrecto';
	END IF;
    
    IF (tipo = 'visa') THEN
        SET bloque1 = substring(num_tarjeta,1,4);
        SET bloque2 = substring(num_tarjeta,5,4);
        SET bloque3 = substring(num_tarjeta,9,4);
        SET bloque4 = substring(num_tarjeta,13,4);
        
        RETURN concat(bloque1, '-', bloque2, '-', bloque3, '-', bloque4);
	END IF;
    
    IF (tipo = 'mastercard') THEN
        SET bloque1 = substring(num_tarjeta,1,4);
        SET bloque2 = substring(num_tarjeta,5,4);
        SET bloque3 = substring(num_tarjeta,9,4);
        SET bloque4 = substring(num_tarjeta,13,4);
        
        RETURN concat(bloque1, '/', bloque2, '/', bloque3, '/', bloque4);
	END IF;
END//

DELIMITER ;
SELECT num_tarjeta, tipo, dividir_tarjetas(num_tarjeta, tipo) AS num_tarjeta FROM tarjetas;


/*
2. Crea una función llamada “datos alumno” que devuelva en un solo valor el 
nombre, apellidos y correo del alumno. Debe recibir como argumentos los 3 
datos del alumno. Lo probamos en una SELECT. 
*/
DROP FUNCTION IF EXISTS datos_alumno;

DELIMITER //
CREATE FUNCTION datos_alumno(p_nombre VARCHAR(50), p_apellidos VARCHAR(50), p_correo VARCHAR(50))
RETURNS VARCHAR(200) NO SQL
BEGIN

    RETURN CONCAT(p_nombre, ' | ', p_apellidos, ' | ', p_correo);
    
END //
DELIMITER ;

SELECT nombre, apellidos, correo, datos_alumno(nombre, apellidos, correo) from alumnos;


/*
3. Crear una función llamada “cursos_num_alumnos” que devuelva el número de 
alumnos de un curso que se pasa como argumento Lo probamos con una 
SELECT.
*/
DROP FUNCTION IF EXISTS cursos_num_alumnos;

DELIMITER //
CREATE FUNCTION cursos_num_alumnos(p_curso INT)
RETURNS INT READS SQL DATA
BEGIN
	DECLARE num_alumnos INT;
    SET num_alumnos = 0;
    
    SELECT COUNT(nombre) INTO num_alumnos FROM alumnos WHERE cod_curso = p_curso;
    RETURN num_alumnos;
END //
DELIMITER ;

SELECT nombre, cursos_num_alumnos(cod_curso) as num_alumnos FROM cursos;


/*
4. Crear una función llamada “nota_media” que pasándole el código del alumno 
nos indique la nota media de dicho alumno
*/
DROP FUNCTION IF EXISTS nota_media;

DELIMITER //
CREATE FUNCTION nota_media(p_cod_alumno INT)
RETURNS DECIMAL(10,2) READS SQL DATA
BEGIN
	DECLARE promedio DECIMAL(10,2);
    SET promedio = 0;
    
    SELECT AVG(nota) INTO promedio 
    FROM notas_alumnos WHERE cod_alumno = p_cod_alumno;
	RETURN promedio;
END//
DELIMITER ;

SELECT cod_alumno, nombre, nota_media(cod_alumno) AS nota_media FROM alumnos;