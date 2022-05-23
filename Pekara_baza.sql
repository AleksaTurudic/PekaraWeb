create database Pekara
use  Pekara

create table korisnik
(
id_korisnik int identity(1,1) primary key,
email nvarchar(100) not null,
lozinka nvarchar(100) not null
)
insert into korisnik
values ('test@test','1234'), ('MikeOx@gmail.com','pass')

create table lokacija
(id_lokacija int identity(1,1) primary key,
adresa nvarchar(100),
radno_vreme_pocetak time,
radno_vreme_kraj time
)
insert into lokacija
values ('Cara Dusana 51','08:00','19:00'),
('Bulevar JNA','08:00','19:00')

create table radnik
(id_radnik int identity(1,1) primary key,
ime nvarchar(100),
prezime nvarchar(100),
JMBG int,
id_lokacije int,
tekuci_racun nvarchar(100)
)
insert into radnik
values ('Mika','Peric',14020013,1,''),
('Milena','Nikolic',13080046,2,'')

create table proizvod
(id_proizvoda int identity(1,1) primary key,
ime nvarchar(100),
tip nvarchar(100),
cena int,
kalorije int
)
insert into proizvod
values ('Kroasan', 'Pecivo', 100, 80),
('Krofna', 'Pecivo', 60, 100),
('Hleb', 'Pecivo', 39, 70),
('Jogurt', 'Pice', 60, 100),
('Cokoladno Mleko', 'Pice', 65, 85),
('Puding', 'Dezert', 40, 115)

create table proizvodjac
(id_proizvodjac int identity(1,1) primary key,
ime nvarchar(100),
PIB int
)
insert into proizvodjac
values ('Klas', 39537502),
('Imlek', 6351202);

create table lager
(id_lager int identity(1,1) primary key,
id_proizvoda int ,
id_lokacija int ,
kolicina int
)
insert into lager
values (1,1,30),(2,1,80),(3,1,100),(4,1,15),(5,1,200),(6,1,109),
(1,2,80),(2,2,14),(3,2,200),(4,2,70),(5,2,157),(6,2,314)

create table kupac   --posle ovog nisam ubacivao podatke jer ne koristim ove tabele, plan je bio da ih iskoristim ali nazalost nemam vremena
( id_kupac int identity(1,1) primary key,
  tip_kupovine nvarchar(100),
  datum_dostave datetime
)
create table racun
(
	id_racun int identity(1,1) primary key,
	id_kupac int,
	cena int,
)

create table racun_proizvod
(id_racun_proizvod int identity(1,1) primary key,
id_proizvod int,
id_racun int,
kolicina int
)

create table uvoz
( id_uvoz int identity(1,1) primary key,
	id_proizvodjac int,
	id_proizvod int,
	id_lager int,
	kolicina int,	
	cena_uvoza int
)


ALTER TABLE uvoz
ADD CONSTRAINT
FK_id_proizvod FOREIGN KEY
(id_proizvod) REFERENCES Proizvod(id_proizvoda)

ALTER TABLE uvoz
ADD CONSTRAINT
FK_id_proizvodjac FOREIGN KEY
(id_proizvodjac) REFERENCES Proizvodjac(id_proizvodjac)


ALTER TABLE uvoz
ADD CONSTRAINT
FK_id_lager_uvoz FOREIGN KEY
(id_lager) REFERENCES Lager(id_lager)

ALTER TABLE radnik
ADD CONSTRAINT
FK_id_lokacija FOREIGN KEY
(id_lokacije) REFERENCES Lokacija(id_lokacija)

ALTER TABLE lager
ADD CONSTRAINT
FK_id_proizvod_lager FOREIGN KEY
(id_proizvoda) REFERENCES Proizvod(id_proizvoda)

ALTER TABLE lager
ADD CONSTRAINT
FK_id_lokacija_lager FOREIGN KEY
(id_lokacija) REFERENCES Lokacija(id_lokacija)

ALTER TABLE racun
ADD CONSTRAINT
FK_id_kupac FOREIGN KEY
(id_kupac) REFERENCES Kupac(id_kupac)

ALTER TABLE racun_proizvod
ADD CONSTRAINT
FK_id_racun_1 FOREIGN KEY
(id_racun) REFERENCES Racun(id_racun)

ALTER TABLE racun_proizvod
ADD CONSTRAINT
FK_id_racun_2 FOREIGN KEY
(id_proizvod) REFERENCES Proizvod(id_proizvoda)









Create PROC dbo.Korisnik_Email
@email nvarchar(50),
@loz nvarchar(100)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 email FROM Korisnik
	WHERE email = @email and lozinka=@loz)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO

CREATE PROC Korisnik_Insert
@email nvarchar(50),
@loz nvarchar(100)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
IF EXISTS (SELECT TOP 1 email  FROM Korisnik
	WHERE email = @email  )
	Return 1
	else
	Insert Into Korisnik(email,lozinka)
	Values(@email,@loz)
		RETURN 0;
END TRY
	
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Create PROC dbo.Korisnik_Update
@email nvarchar(50),
@loz nvarchar(100)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS (SELECT TOP 1 email FROM dbo.Korisnik
	WHERE email = @email  )

	BEGIN
	
	Update Korisnik  Set lozinka=@loz  where email=@email 
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Create PROC Proizvod_insert
@ime nvarchar(50),
@cena int
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS (SELECT TOP 1 ime  FROM proizvod
	WHERE ime = @ime  )
	Return 1
	else
	Insert Into proizvod(ime,cena)
	Values(@ime,@cena)
		RETURN 0;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH

Create PROC Proizvod_Update
@ime nvarchar(100),
@tip nvarchar(100),
@cena int,
@kalorije int
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS (SELECT *  FROM dbo.proizvod
	WHERE ime = @ime  )

	BEGIN
	
	Update Proizvod  Set  tip=@tip, cena=@cena, kalorije=@kalorije  where ime=@ime
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Create PROC Proizvodjac_insert
@ime nvarchar(50),
@PIB int
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS (SELECT TOP 1 ime  FROM proizvodjac
	WHERE ime = @ime  )
	Return 1
	else
	Insert Into proizvodjac(ime,PIB)
	Values(@ime,@PIB)
		RETURN 0;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH

Create PROC Proizvodjac_Update
@id int,
@ime nvarchar(100),
@PIB int
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS (SELECT *  FROM dbo.proizvodjac
	WHERE id_proizvodjac = @id  )

	BEGIN
	
	Update Proizvodjac  Set  ime=@ime, PIB=@PIB  where id_proizvodjac=@id
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO
Create PROC Kupovina
@id_proizvoda int, 
@kolicina int,
@id_lokacija int
as
set lock_timeout 3000;
begin try
IF EXISTS (SELECT *  FROM dbo.lager
	WHERE id_proizvoda = @id_proizvoda and id_lokacija=@id_lokacija  )
	begin
	update lager set kolicina=kolicina-@kolicina where id_lokacija=@id_lokacija and id_proizvoda=@id_proizvoda 
	return 0
	end
	return -1
end try
BEGIN CATCH
	RETURN @@ERROR;
END CATCH

Create PROC Uvoz_kolicina
@id_proizvoda int, 
@kolicina int,
@id_lokacija int
as
set lock_timeout 3000;
begin try
IF EXISTS (SELECT *  FROM dbo.lager
	WHERE id_proizvoda = @id_proizvoda and id_lokacija=@id_lokacija  )
	begin
	update lager set kolicina=kolicina+@kolicina where id_lokacija=@id_lokacija and id_proizvoda=@id_proizvoda 
	return 0
	end
	return -1
end try
BEGIN CATCH
	RETURN @@ERROR;
END CATCH

Create PROC Promena_radnog_mesta
@id_radnik int, 
@id_lokacija int
as
set lock_timeout 3000;
begin try
IF EXISTS (SELECT *  FROM dbo.radnik
	WHERE id_radnik = @id_radnik  )
	begin
	update radnik set id_lokacije=@id_lokacija where id_radnik=@id_radnik
	return 0
	end
	return -1
end try
BEGIN CATCH
	RETURN @@ERROR;
END CATCH