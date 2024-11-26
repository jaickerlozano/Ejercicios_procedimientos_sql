-- **** CONTROL DE FLUJO ****
-- CONDICIONES CON IF 
/*
	IF condicion 
		THEN instrucciones 
    END IF;
    
    IF condicion
		THEN instrucciones
	ELSEIF condiciones
		THEN intrucciones
	ELSE intrucciones
    END IF;
*/

DROP PROCEDURE INSERT_CURSO;

DELIMITER //
	CREATE PROCEDURE insert_curso(p_codigo int, p_nombre varchar(50), p_precio decimal)
    BEGIN
		IF p_precio < 100 THEN
			SELECT "El precio no puede ser menor que 100";
		ELSEIF p_precio > 300 THEN
			SELECT "El precio no puede ser mayor que 300";
		ELSE 
			INSERT INTO CURSOS VALUES(p_codigo, p_nombre, p_precio);
		END IF;
        
    END//
    
DELIMITER ; 

CALL insert_curso(30000, "CURSO30000", 9);
CALL insert_curso(40000, "CURSO40000", 900);
CALL insert_curso(40000, "CURSO40000", 200);
SELECT * FROM CURSOS;

-- CONDICIONES CON CASE 
/*
	CASE expresion
		WHEN valor1 THEN instrucciones;
        WHEN valor2 THEN instrucciones;
        WHEN valor3 THEN instrucciones;
        
        ELSE instrucciones;
	END;
    
    CASE
		WHEN expresion1 THEN instrucciones;
        WHEN expresion2 THEN instrucciones;alter
         ELSE instrucciones;
	END;
*/

DROP PROCEDURE INSERT_CURSO;

DELIMITER //
	CREATE PROCEDURE insert_curso(p_codigo int, p_nombre varchar(50), p_precio decimal)
    BEGIN
		CASE 
        WHEN p_precio < 100 THEN
			SELECT "El precio no puede ser menor que 100";
		WHEN p_precio > 300 THEN
			SELECT "El precio no puede ser mayor que 300";
		ELSE 
			INSERT INTO CURSOS VALUES(p_codigo, p_nombre, p_precio);
		END CASE;
    END//
    
DELIMITER ; 

CALL INSERT_CURSO(555555, "CURSO555555", 150);
SELECT * FROM CURSOS;

-- BUCLES - LOOP
/*
	etiqueta:LOOP
		instrucciones;
        LEAVE etiqueta; -- para salir del bucle
        ITERATE etiqueta; -- para volver al principio del bucle
	END LOOP;
*/

DROP PROCEDURE BUCLE;
DELIMITER //
CREATE PROCEDURE BUCLE()
	BEGIN
		DECLARE counter INT;
        DECLARE resultado VARCHAR(50);
        SET COUNTER = 1;
        SET resultado = '';
        
        bucle1:LOOP
            SET COUNTER = COUNTER +1;
			SET RESULTADO = CONCAT(RESULTADO, '-', COUNTER);
            IF COUNTER > 10 THEN
				leave bucle1;
            end if;
		END LOOP;
        SELECT RESULTADO;
    END //
    
DELIMITER ;

call bucle();

-- BUCLES - WHILE
/*
	WHILE condicion DO
		INSTRUCCIONES;
    END WHILE;
*/

DROP PROCEDURE BUCLE_WHILE;
DELIMITER // 
 CREATE PROCEDURE BUCLE_WHILE() 
 BEGIN
	DECLARE COUNTER INT;
    DECLARE RESULTADO VARCHAR(50);
    
    SET COUNTER = 0;
    SET RESULTADO = '';
    
    WHILE counter <= 10 DO
    SET RESULTADO = CONCAT(RESULTADO, '-', COUNTER);
    SET COUNTER = COUNTER +1;
    END WHILE;
    SELECT RESULTADO;
 END//
 
 DELIMITER ; 
 
 CALL BUCLE_WHILE();

-- BUCLES - REPEAT

/*
	REPEAT
		instrucciones;
	UNTIL condicion;
    END REPEAT;
*/

DROP PROCEDURE BUCLE_REPEAT;

DELIMITER //
CREATE PROCEDURE BUCLE_REPEAT()
BEGIN
	DECLARE COUNTER INT;
    DECLARE RESULTADO VARCHAR(50);
    
    SET COUNTER = 0;
    SET RESULTADO = '';
    
    REPEAT
		SET RESULTADO = CONCAT(RESULTADO, '-', COUNTER);
		SET COUNTER = COUNTER +1;
    UNTIL COUNTER = 11
    END REPEAT;
    
    SELECT RESULTADO;
END//

DELIMITER ;

call bucle_repeat();














