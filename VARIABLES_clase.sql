/*
	VARIABLES
    
    set @nombreVariable = valor;

*/

USE ACADEMIA;

SET @V1 = 10;

SELECT @V1;

SELECT * FROM ACADEMIA.CURSOS WHERE COD_CURSO = @V1;

SET @COLUMNA = "NOMBRE";

SELECT @COLUMNA FROM ACADEMIA.CURSOS; -- Las variable solo sirven para DATOS



delimiter //

create procedure proced1()
begin
 SELECT * FROM CURSOS WHERE COD_CURSO = @V1;
 END// 
 
delimiter ;
 
 
 call proced1();
 
 
 
 
 


