/*
PROCEDIMIENTOS
 Dentro de la base de datos academia:
 */
-- 1. Crea un procedimiento llamado “cursos_asignaturas”para visualizar los cursos y sus
-- asignaturas respectivamente. Ordénalo por cursos.
use academia;
drop procedure if exists cursos_asignaturas;
delimiter //
	create procedure cursos_asignaturas()
	begin
		select c.nombre as cursos, a.nombre as asignaturas 
		from cursos as c inner join asignaturas as a
		on c.cod_curso=a.cod_curso
        order by c.nombre;
	end//
delimiter ;

call cursos_asignaturas;

/*
2. Crea un procedimiento llamado “actualizar_precio”, que reciba como parámetro el
código del curso y el precio que se le va a asignar a ese curso. Se debe controlar
que el precio sea mayor que 100. Si no se cumple, se fija el precio a 100.
*/

delimiter //
drop procedure if exists actualizar_precio;
create procedure actualizar_precio(in c_cod_curso int, in precio_curso decimal)
begin
    
	if precio_curso < 100 then
		set precio_curso = 100;
	end if;
        
	update cursos set precio = precio_curso where cod_curso = c_cod_curso;
    
end//
delimiter ;

call actualizar_precio(15,50);
call actualizar_precio(11,190);
select * from cursos;

/*
3. Crea un procedimiento llamado “profesores_cursos” para visualizar los cursos de
cada profesor. Debe recibir un parámetro que sea el nombre del profesor para ver
las asignaturas.
*/

delimiter //
drop procedure if exists profesores_cursos;
create procedure profesores_cursos(nombre_profesor varchar(50))
begin
	select a.cod_profesor, p.nombre, c.nombre, a.nombre
	from cursos as c inner join asignaturas as a inner join profesores as p
	on c.cod_curso=a.cod_curso and a.cod_profesor=p.cod_profesor
	where p.nombre = nombre_profesor;
end //

delimiter ;

call profesores_cursos('Cindelyn');
call profesores_cursos('Dreddy');
call profesores_cursos('Andi');

/*
4. Crea un procedimiento llamado “nombre_completo” que devuelva una SELECT con
el nombre y el apellido de un alumno. Debe recibir el parámetro de entrada del
código del alumno.
*/
delimiter //
drop procedure if exists nombre_completo;
create procedure nombre_completo(codigo_alumno int)
begin
    select concat(nombre, apellidos) from alumnos where cod_alumno = codigo_alumno;
end //

delimiter ;

call nombre_completo(10);
call nombre_completo(2);

/*
5. Modificar el procedimiento anterior (crea uno nuevo con otro nombre) para que el
resultado se almacene en una variable de tipo OUT. Para ver que ha funcionado,
visualiza la variable.
*/

delimiter //
set @resultado = '';
drop procedure if exists nombre_completo_alumno;
create procedure nombre_completo_alumno(codigo_alumno int, out salida varchar(100))
begin
    select concat(nombre, apellidos) into salida from alumnos where cod_alumno = codigo_alumno;
end //

delimiter ;
call nombre_completo_alumno(10, @resultado);
select @resultado;
call nombre_completo_alumno(2, @resultado);
select @resultado;

-- 6. Crea un procedimiento llamado “devolver_mayus” con un argumento de tipo INOUT.
-- El parámetro debe ser una cadena de texto que se devuelva en mayúsculas.

delimiter //
set @mayus = 'Estoy aprendiendo el manejo de datos en mysql';
drop procedure if exists devolver_mayus;
create procedure devolver_mayus(inout texto varchar(150))
begin
    select concat('El texto "', texto, '" en mayúscula es: ',upper(texto)) into texto;
end //

delimiter ;

call devolver_mayus(@mayus);
select @mayus;

/*
7. Crea un procedimiento llamado “devolver_datos” que reciba como parámetro de
entrada el código del curso, y que devuelva en dos variables de tipo OUT el nombre
y el precio. Visualiza el resultado para ver que ha salido correctamente.
*/
delimiter //

set @nombre_curso = '';
set @precio_curso = 0;

drop procedure if exists devolver_datos;
create procedure devolver_datos(in c_cod_curso int, out salida_curso varchar(50), out salida_precio decimal)
begin
	select nombre, precio into salida_curso, salida_precio from cursos where cod_curso = c_cod_curso;
end //
delimiter ; 

call devolver_datos(1,@nombre_curso, @precio_curso);
select @nombre_curso, @precio_curso;
