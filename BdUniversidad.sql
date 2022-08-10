--base de datos
use master
go
if DB_ID('BDUniversidad') is not null
    drop database BDUniversidad
	go
	create database BDUniversidad
	go
	use BDUniversidad
	go
	-- crear tablas
	if DB_ID('Tescuela') is not null
    drop database Tescuela
	go
	create table Tescuela
	(
	codEscuela char(3) primary key,
	escuela varchar(50),
	facultad varchar (50)
	)
	go
	if DB_ID('Talumno') is not null
    drop database Talumno
	go
	create table  Talumno
	(
	codAlumno char(5) primary key,
	apellidos varchar(50),
	Nombres varchar (50),
	LugarNac varchar (50),
	FechaNac varchar (50),
	codEscuela char (3), 
	foreign key (codEscuela) references Tescuela
	)
	go
	--insertar datos
	insert into Tescuela values('E01','Sistemas','Ingenieria')
	insert into Tescuela values('E02','civil','Ingenieria')
	insert into Tescuela values('E03','industrial','Ingenieria')
	insert into Tescuela values('E04','arquitectura','Ingenieria')
