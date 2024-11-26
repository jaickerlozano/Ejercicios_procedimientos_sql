/*
5. Crea una tabla con únicamente dos columnas: Código y Texto. Después, crea 
un procedimiento llamado “handler1” que lea la tabla. Debe tener un handler 
que controle si la tabla existe. Código 1146. ¿Qué pasa si eliminamos la tabla?
*/
CREATE TABLE tabla_handler1 (
Código INT,
Texto VARCHAR(150));

INSERT INTO tabla_handler1 VALUES(1, 'Texto1');
INSERT INTO tabla_handler1 VALUES(2, 'Texto2');
INSERT INTO tabla_handler1 VALUES(3, 'Texto3');
INSERT INTO tabla_handler1 VALUES(4, 'Texto4');

DROP PROCEDURE IF EXISTS handler1;
DELIMITER //
CREATE PROCEDURE handler1()
BEGIN
	DECLARE CONTINUE HANDLER FOR 1146
    SELECT 'La tabla no existe';
	SELECT * FROM academia.tabla_handler1;
END//
DELIMITER ;

-- Si la tabla existe, se realizará el llamado del procedimiento mostrando la tabla.
CALL handler1();
-- Al eliminar la tabla y hacer el llamado del procedimiento nuevamente, nos aprecerá un 
-- mensaje de error indicando que la tabla no existe.
DROP TABLE tabla_handler1;
CALL handler1();

/*
6. Hacer un procedimiento denominado “insert_curso_error” que intente insertar 
una fila en la tabla cursos. Si la clave primaria está duplicada (código 1062), en 
vez de generar un error, recalculamos la clave indicando el valor más alto más 
uno.
*/
DROP PROCEDURE IF EXISTS insert_curso_error;
DELIMITER //
CREATE PROCEDURE insert_curso_error(p_cod_curso INT, p_nombre VARCHAR(50), p_precio INT)
BEGIN
	DECLARE codigo_disponible INT;
	DECLARE CONTINUE HANDLER FOR 1062
    IF p_cod_curso = (SELECT cod_curso from cursos where cod_curso = p_cod_curso) THEN
		SELECT MAX(cod_curso) + 1 INTO codigo_disponible FROM cursos;
		SELECT CONCAT('El codigo ', p_cod_curso, ' ya existe. El código disponible es: ') AS mensaje_de_error, 
        codigo_disponible;
        INSERT INTO academia.cursos VALUES (codigo_disponible, p_nombre, p_precio);
    END IF;
	INSERT INTO academia.cursos VALUES (p_cod_curso, p_nombre, p_precio);
END//
DELIMITER ;

call insert_curso_error(16,'CURSO19',150);
SELECT * FROM CURSOS;
-- Si intentamos ingresar nuevamente el mismo código insertado nos saldrá el mensaje de error indicando el 
-- próximo código disponible.

/*
7. Hacer un procedimiento llamado “error_generico” que intente modificar la 
columna nombre de un curso, pasando el código y el nuevo nombre. Con una 
SQLEXCEPTION debemos controlar si hay algún error y luego pintar el número 
de error usando DIAGNOSTIC. Luego probamos con algún error, como por 
ejemplo pasándole un nulo al campo o un nombre duplicado, lo que sea.
*/

DROP PROCEDURE IF EXISTS error_generico;
DELIMITER //
CREATE PROCEDURE error_generico(p_cod_curso INT, p_nombre VARCHAR(50))
BEGIN
    DECLARE mensaje TEXT;
    DECLARE cod_error INT;
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1
        cod_error = MYSQL_ERRNO, mensaje = MESSAGE_TEXT;
        SELECT CONCAT('ERROR ', cod_error, 'MENSAJE: ', mensaje) AS ERROR;
    END;
    
	UPDATE cursos SET nombre = p_nombre WHERE cod_curso = p_cod_curso;
END//
DELIMITER ;

call error_generico(2,'CURSO3');
call error_generico(2,NULL);
SELECT * FROM CURSOS;

/*
8. Crear un procedimiento llamado “error_condition”. Usando el ejercicio 
anterior, hacemos un update, aunque en este caso creamos 2 Condition, una 
para el nombre duplicado y el otro para el NULL. 
*/
DROP PROCEDURE IF EXISTS error_condition;
DELIMITER //
CREATE PROCEDURE error_condition(p_cod_curso INT, p_nombre VARCHAR(50))
BEGIN
    DECLARE mensaje TEXT;
    DECLARE cod_error INT;
    
	DECLARE NOMBRE_DUPLICADO CONDITION FOR 1062;
    DECLARE NOMBRE_NULO CONDITION FOR 1048;
    
    DECLARE EXIT HANDLER FOR NOMBRE_DUPLICADO
		SELECT CONCAT('EL NOMBRE ', p_nombre, ' YA EXISTE') AS TIPO_ERROR;
        
	DECLARE EXIT HANDLER FOR NOMBRE_NULO
		SELECT CONCAT('EL NOMBRE NO PUEDE SER NULO') AS TIPO_ERROR;
    
	UPDATE cursos SET nombre = p_nombre WHERE cod_curso = p_cod_curso;
END//
DELIMITER ;

call error_condition(1,NULL);