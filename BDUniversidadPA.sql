---BRIAN ESPINOZA ALARCON---
--- PROCEDIMIENTO ALMACENADO TALUMNO------------------
--PARA LA TABLA DE ESCUELA---
------------------------------------------------------------
 -- Procedimiento almacenado para listar Escuela
 use BDUniversidad
 go
if OBJECT_ID ('spListarEscuela') is not null
	drop proc spListarEscuela
go

create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go
exec spListarEscuela
--------------------------------------------------------------
-- Procedimiento almacenado para Agregar Escuela
if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go

create proc spAgregarEscuela
	@CodEscuela char(3), 
	@Escuela varchar(50),
	@Facultad varchar(50)
as 
begin
--CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		-- Validar que el nombre de Escuela no se repita
		if not exists (select Escuela from TEscuela where Escuela = @Escuela)
			begin 
				insert into TEscuela values (@CodEscuela, @Escuela , @Facultad)
				select CodError = 0, Mensaje = 'Escuela insertada correctamente'
			end
		else select CodError = 1, Mensaje = 'Error: Escuela duplicada'
	else select CodError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go
exec spAgregarEscuela 'E05', 'agronomia', 'Ingenieria'
--------------------------------------------------------------
-- Procedimiento Almacenado para Eliminar Escuela
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go

create proc spEliminarEscuela
	@CodEscuela char(4)
as
begin
	--Validar que el codigo exista
	if exists (select CodEscuela from TEscuela where CodEscuela = @CodEscuela)

		-- Validar que la escuela no este en la tabla Alumno
		if not exists (select CodEscuela  from TAlumno where CodEscuela= @CodEscuela)
			begin
				delete from TEscuela where CodEscuela = @CodEscuela
				select CodError = 1, Mensaje = 'Escuela eliminada correctamente'
			end
		else select CodError = 0, Mensaje = 'Error: La Escueala tiene un Alumno'
	else select CodError = 0, Mensaje = 'Error: Id de la Escuela no existe'
end
go
--------------------------------------------------------------
-- Procedimiento almacenado para Actualizar Escuela
if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go

create proc spActualizarEscuela
	@CodEscuela char(4),
	@Escuela varchar(50),
	@Facultad varchar(50)
as 
begin
	-- Validar clave primaria ----
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		-- Validar que el nombre de escuela no se repita
		if not exists (select Escuela from TEscuela where Escuela = @Escuela)
			begin 
				update TEscuela set Escuela = @Escuela, Facultad  =  @Facultad where CodEscuela = @CodEscuela 
				
				select CodError = 1, Mensaje = 'Se actualizado Escuela correctamente'
			end
		else select CodError = 0, Mensaje = 'Error: Nombre de Escuela Existe'
	else select CodError = 0, Mensaje = 'Error: id de Escuela no existe'
end
go
--------------------------------------------------------------
-- Procedimiento almacenado para Buscar Escuela
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create proc spBuscarEscuela
	@Texto varchar(50),
	@Criterio varchar(50)
as
begin
	-- Busqueda exacta para el id de escuela
	if(@Criterio = 'CodEscuela')
		select CodEscuela, Escuela from TEscuela where CodEscuela = @Texto
	--Busqueda con el nombre de la escueka
	else if (@Criterio = 'Escuela')
		select Escuela, CodEscuela from TEscuela where Escuela  like @Texto + '%'
end
go

--- PROCEDIMIENTO ALMACENADO TALUMNO------------------
--PARA LA TABLA DE ALUMNOS---
------------------------------------------------------------
 -- Procedimiento almacenado para listar Alumno
 
 go
if OBJECT_ID ('spListarAlumno') is not null
	drop proc spListarAlumno
go

create proc spListarAlumno
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac,FechaNac from TAlumno
end
go
exec spListarAlumno
--------------------------------------------------------------
-- Procedimiento almacenado para Agregar Alumno
if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go

create proc spAgregarAlumno
	@CodAlumno char(3), 
	@Apellidos varchar(50),
	@Nombres varchar(50),
	@LugarNac Varchar(50),
	@FechaNac varchar(50)

as 
begin
--CodEscuela no puede ser duplicado
	if not exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		-- Validar que el nombre de Alumno no se repita
			begin 
				insert into TAlumno values (@CodAlumno, @Apellidos, @Nombres,@LugarNac,@FechaNac )
				select CodError = 0, Mensaje = 'Alumno insertado correctamente'
			end
	else select CodError = 1, Mensaje = 'Error: CodAlumno duplicado'
end
go
--------------------------------------------------------------
-- Procedimiento Almacenado para Eliminar Alumno
if OBJECT_ID('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go

create proc spEliminarAlumno
	@CodAlumno char(4)
as
begin
	--Validar que el codigo exista
	if exists (select CodAlumno from TAlumno where CodAlumno = @CodAlumno)

		-- Validar que la escuela no este en la tabla Alumno
		if not exists (select CodAlumno  from TAlumno where CodAlumno= @CodAlumno)
			begin
				delete from TAlumno  where CodAlumno = @CodAlumno
				select CodError = 1, Mensaje = 'Alumno eliminado correctamente'
			end
		else select CodError = 0, Mensaje = 'Error: Alumno tiene una escuela'
	else select CodError = 0, Mensaje = 'Error: Id de la Alumno no existe'
end
go
--------------------------------------------------------------
-- Procedimiento almacenado para Actualizar Alumno
if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go

create proc spActualizarAlumno
	@CodAlumno char(3), 
	@Apellidos varchar(50),
	@Nombres varchar(50),
	@LugarNac Varchar(50),
	@FechaNac varchar(50)
as 
begin
	-- Validar clave primaria ----
	if exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		-- Validar que el nombre de Alumno no se repita
			begin 
				update TAlumno set Apellidos= @Apellidos, Nombres = @Nombres, LugarNac = @LugarNac,FechaNac = @FechaNac  where CodAlumno  = @CodAlumno 
				
				select CodError = 1, Mensaje = 'Se actualizado Alumno correctamente'
			end
	else select CodError = 0, Mensaje = 'Error: id de Alumno no existe'
end
go
--------------------------------------------------------------
-- Procedimiento almacenado para Buscar Alumno
if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go
create proc spBuscarAlumno
	@Texto varchar(50),
	@Criterio varchar(50)
as
begin
	-- Busqueda exacta para el id de Alumno
	if(@Criterio = 'CodAlumno')
		select CodAlumno , Apellidos from TAlumno where CodAlumno  = @Texto
	--Busqueda con el nombre del Alumno
	else if (@Criterio = 'Apellidos')
		select Apellidos, CodAlumno from  TAlumno where Apellidos  like @Texto + '%'
end
go