/*	CONTROL DE ERRORES

DECLARE 
	OPCION (CONTINUE-EXIT-UNDO)
	
    HANDLER FOR
		CONDICION ( Codigo SQLSTATE - Codigo Error MySQL - SQL WARNING - NOT FOUND -EXCEPTION)
        Instrucciones 
	
CONDICIONES
	Error MySQL: codigo numerico (int) que es un error de MySQL (1051 -> tabla no existente)
	SQLSTATE: código de 5 caracteres que indica un error generado por el servidor
    Condicion: Una expresion asociada a un error de MySQL
    SQL WARNING: SQL STATE que empiezan por '01'
    NOT FOUND: SQL STATE que empiezan por '02'
    SQL EXCEPTION: SQLSTATEs que no empiezan por '00', '01' o '02'
    
https://dev.mysql.com/doc/mysql-errors/8.0/en/error-reference-introduction.html
*/
use academia;
Delimiter // 

Drop procedure if exists errores1//
create procedure errores1(p_codigo int, p_nombre varchar(50), p_precio decimal)
begin
	declare continue handler for 1062
    SELECT CONCAT('El codigo ', p_codigo, ' ya existe');
    
    declare continue handler for 1048 
    SELECT "ERROR, CAMPO NULO";
    
	insert into cursos values (p_codigo, p_nombre, p_precio);
    Select 'He pasado por aqui';
end //

call errores1(1, 'curso', 9999)//
call errores1(2000, NULL, 999)//



Drop procedure if exists errores2//
create procedure errores2(p_codigo int, p_nombre varchar(50), p_precio decimal)
begin
	DECLARE NOMBRE_NULO BOOL;
	declare continue handler for 1062
    SELECT CONCAT('El codigo ', p_codigo, ' ya existe');
    
    declare continue handler for 1048
    SET NOMBRE_NULO = TRUE;
    
	insert into cursos values (p_codigo, p_nombre, p_precio);
    IF NOMBRE_NULO THEN
		insert into cursos values (p_codigo, "desconocido", p_precio);
    end if;
    
    Select 'He pasado por aqui';
end //


call errores2(2000, NULL, 999)//

SELECT * FROM CURSOS//

Drop procedure if exists errores3//
create procedure errores3(p_codigo int, p_nombre varchar(50), p_precio decimal)
begin
	declare continue handler for sqlexception
    SELECT 'CUIDADO! SE HA PRODUCIDO UN ERROR';
    
    DECLARE continue handler for sqlwarning
        SELECT 'CUIDADO! SE HA PRODUCIDO UN WARNING';

	insert into cursos values (p_codigo, p_nombre, p_precio);
    
    Select 'He pasado por aqui';
end //

call errores3(2000, NULL, 999)//








