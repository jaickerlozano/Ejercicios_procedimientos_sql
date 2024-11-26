/* FUNCIONES */
-- Siempre SIEMPRE devuelven un valor 
-- Podemos utilizarlas en consultas

/*
	CREATE FUNCTION nombre_funcion()
		RETURNS tipo_de_dato
			CARACTERISTICAS
            BEGIN
				instrucciones
                RETURN valor
			END
            
	CREATE FUNCTION suma(num1 int, num2 int)
    RETURN int
    BEGIN
		DECLARE RESULTADO INT;
        SET RESULTADO = num1+ num2;
		RETURN RESULTADO;
    END 
*/

/* CARACTERISTICAS
	- DETERMINISTIC : mismo resultado con mismos parámetros de entrada
    - NOT DETERMINISTIC: no devuelve el mismo resultado aunque se utilicen los mismos parametros de entrada
	- CONTAINS SQL: que la funcion tiene sentencias SQL, pero no sentencias de manipulacion de datos.
    - NO SQL: no tiene sentencias SQL
    - READS SQL DATA: sentencias SQL de lectura
    - MODIFIES SQL DATA: insert, update o delete
*/
USE ACADEMIA;
DROP FUNCTION IF EXISTS calcula_iva;
DELIMITER //
 CREATE FUNCTION calcula_iva(p_codigo int)
 RETURNS DECIMAL READS SQL DATA
 BEGIN
	DECLARE precio_total decimal;
	
    SELECT PRECIO+(PRECIO*0.21) INTO precio_total FROM CURSOS WHERE COD_CURSO = p_codigo;
    RETURN precio_total;
 END//

delimiter ;

SELECT calcula_iva(1);


select *, CALCULA_IVA (cod_curso) AS PRECIO_FINAL from cursos;













