/*
	VARIABLES DENTRO DE UN PROCEDIMIENTO, FUNCION O TRIGGER
    
    DECLARE nombre TIPO;
    
    SET VARIABLE = VALOR;

*/

DELIMITER //

create procedure calcula_beneficio(p_codigo int)
begin
	declare num_alumnos int;
    declare precio_curso decimal;
    declare beneficio decimal;
	
    SELECT COUNT(*) INTO num_alumnos FROM ALUMNOS WHERE COD_CURSO = p_codigo;
    SELECT precio INTO precio_curso FROM CURSOS WHERE COD_CURSO = p_codigo;
    
    SET beneficio = num_alumnos * precio_curso;
    
    SELECT CONCAT("La ganancia del curso ", p_codigo, " es ", beneficio);
    

end//

DELIMITER ;


CALL calcula_beneficio(10);




