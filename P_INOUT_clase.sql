/*
 PARÁMETROS DE ENTRADA/SALIDA -> INOUT
*/

SET @VAR3 = 3;

DELIMITER //
CREATE PROCEDURE calcula_asignaturas(INOUT par DECIMAL)
begin
	select count(*) INTO par FROM ASIGNATURAS WHERE COD_CURSO = par;
end //

DELIMITER ;

CALL calcula_asignaturas(@var3);

SELECT @VAR3;

CALL calcula_asignaturas(@var3);