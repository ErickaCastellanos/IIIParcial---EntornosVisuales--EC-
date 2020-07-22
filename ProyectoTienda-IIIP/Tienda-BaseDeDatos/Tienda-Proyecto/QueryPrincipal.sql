-- Creacion de la base de datos
create database proyectoTienda
go

-- Base a utilizar
use proyectoTienda
go

-- Creacion de las tablas
-- Tabla Usuario
create table usuarios
(
	-- Definicion de las Variables
	idUsuario int primary key identity,
	nombre varchar(25) not null,
	apellido varchar(25) not null,
	nombreUsuario varchar(25) not null,
	pasword varchar(40) not null,
	rol char(15) not null,
	estado char(20) not null,
	correo varchar(45)
);
go

select * from usuarios;
go

------ Procedimientos Almacenados ------
         --- Insertar ---
create procedure insertarUsuario
-- Definicion de Alias
@idUsuario int,
@nombre varchar(25),
@apellido varchar(25),
@userName varchar(25),
@psw varchar(25),
@rol char(15),
@estado char(20),
@correo varchar(45)
as begin 
if exists (select nombreUsuario from usuarios where nombreUsuario = @userName and estado = 'activo')
raiserror ('Ya existe un Registro con en ese Usuario, Ingrese un Nuevo', 16, 1)
else 
	insert into usuarios values( @nombre, @apellido, @userName, @psw, @rol, @estado, @correo)
end
go

execute insertarUsuario 1, 'Ericka', 'Castellanos', 'EriCast18', '980511', 'Admin', 'Activo', 'ericast@gmail.com'
execute insertarUsuario 2, 'Enoc', 'Dubon', 'dubon678', '874567', 'Cliente', 'Activo', 'dubonenoc@gmail.com'
execute insertarUsuario 3, 'Kenny', 'Suazo', 'kensuazo12', '987654', 'Cajero', 'Activo', 'suazo2010@gmail.com'
execute insertarUsuario 4, 'Axel', 'Mendoza', 'mendoza34', '115599', 'Cocinero', 'Activo', 'mendoza1234@gmail.com'
go

 --- Actualizar ---
 create procedure actualizarUsuario
 -- Definicion de Alias
 @idUsuario int,
@nombre varchar(25),
@apellido varchar(25),
@userName varchar(25),
@psw varchar(25),
@rol char(15) 
as begin 
if exists (select nombreUsuario, idUsuario from usuarios where (nombreUsuario = @userName and 
idUsuario = @idUsuario and estado = 'activo'))
raiserror('Usuario esta en uso, utiliza otro por fsvor', 16, 1)
else
update usuarios set nombre = @nombre, apellido = @apellido, pasword = @psw, rol = @rol
where idUsuario = @idUsuario
end
go


--- Buscar ---
 create procedure buscarUsuario
 -- Definicion de Alias
 @userName varchar(50)
 as begin
 select concat(nombre, '', apellido) as 'Nombre Completo', nombreUsuario as 'Usuario',
 estado as 'Estado', rol as 'Puesto', correo as 'Correo'
 from usuarios
 where nombreUsuario like '%' + @userName + '%'
 end
 go

 --- Eliminar ---
 create procedure eliminarUsuario
 -- Definicion de Alias
 @idUsuario int, @rol varchar(50)
	as begin 
		if exists (select nombreUsuario from usuarios where @rol = 'admin')
			raiserror ('El usuario *Admin* no se puede eliminar, Accion denegada',16,1)
		else
			update usuarios set estado = 'eliminado'
			where idUsuario = @idUsuario and rol <> 'admin'
	end
go


-- Utilizar los procedimientos
execute buscarUsuario 'E'