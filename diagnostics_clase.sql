use academia;
/*
	GET DIAGNOSTICS CONDITION 1
		- RETURNED_SQLSTATE:  indica el estado de la condicion
        - MESSAGE_TEXT
        - MYSQL_ERRNO: error code
*/
Delimiter //

Drop procedure if exists errores4//
create procedure errores4(p_codigo int, p_nombre varchar(50), p_precio decimal)
begin
	declare mensaje text;
    declare codigo int;
	declare continue handler for sqlexception
    BEGIN 
		GET diagnostics CONDITION 1
        codigo = mysql_errno, mensaje = message_text;
        
        SELECT 'SE HA PRODUCIDO EL ERROR ', codigo, ' con el mensaje ', mensaje;
    END;
    
    DECLARE continue handler for sqlwarning
        SELECT 'CUIDADO! SE HA PRODUCIDO UN WARNING';

	insert into cursos values (p_codigo, p_nombre, p_precio);
    
    Select 'He pasado por aqui';
end //

call errores4(2000, NULL, 999)//