/* PROCEDIMIENTOS *

DELIMITER //

	CREATE PROCEDURE NOMBRE(PARAMETROS DE ENTRADA)
		BEGIN
			LINEAS DE CODIGO;
            
        END//


DELIMITER -> indicar el símbolo para que mysql sepa que el procedimiento ha terminado
*/

DELIMITER //
	CREATE PROCEDURE VER_CURSOS()
    BEGIN
		SELECT * FROM ACADEMIA.CURSOS;
    END //
    
CALL VER_CURSOS();


DELIMITER //
	CREATE PROCEDURE INSERTA_CURSO()
    BEGIN 
		INSERT INTO ACADEMIA.CURSOS VALUES(9999, "CURSO9999", 200);
    END//
    
/*
	parametros: 
    IN
    OUT
    INOUT
*/

DELIMITER //
	CREATE PROCEDURE CONSULTA_CURSO_PRECIO(IN p_precio DECIMAL)
    begin 
		select * from cursos where precio<=p_precio;
    end //
    

delimiter ;
 
 CALL CONSULTA_CURSO_PRECIO(220);

-- -- 
DROP PROCEDURE IF EXISTS INSERTA_CURSO;
DELIMITER //
	CREATE PROCEDURE INSERTA_CURSOS(IN p_codigo INT, p_nombre VARCHAR(50), p_precio INT)
		BEGIN 
        INSERT INTO CURSOS VALUES(p_codigo, p_nombre, p_precio);
        END //
        
DELIMITER ;

CALL INSERTA_CURSOS(8888, 'CURSO8888', 800);


SELECT * FROM CURSOS;














    
    
   
