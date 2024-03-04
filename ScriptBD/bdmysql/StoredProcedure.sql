--Insert or Update etudiant
create procedure sp_insert_etudiant
	@id int,@nom varchar(50),@postnom varchar(50),
	@prenom varchar(50),@sexe varchar(1),@matricule varchar(20)
as
begin
	if not exists(select * from etudiant where id=@id)
		insert into etudiant(id,nom,postnom,prenom,sexe,matricule) values 
		(@id,@nom,@postnom,@prenom,@sexe,@matricule)
	else
		update etudiant set nom=@nom,postnom=@postnom,prenom=@prenom,
		sexe=@sexe,matricule=@matricule where id=@id
end
go

--Delete etudiant
create procedure sp_delete_etudiant
	@id int
as
begin
	if exists(select * from etudiant where id=@id)
		delete from etudiant where id=@id
end
go

--Select all etudiant
create procedure sp_select_etudiant
as
begin 
	select id,nom,postnom,prenom,sexe,matricule from etudiant order by nom asc
end
go

--Select one etudiant
create procedure sp_select_etudiants
	@id int
as
begin
	select id,nom,postnom,prenom,sexe,matricule from etudiant 
	where id=@id
end
go

--Insert or Update telephone
create procedure sp_insert_telephone
	@id int,@id_proprietaire int,@initial varchar(4),
	@numero varchar(9)
as
begin
	if not exists(select * from telephone where id=@id)
		insert into telephone(id,id_proprietaire,initial,numero) values 
		(@id,@id_proprietaire,@initial,@numero)
	else
		update telephone set id_proprietaire=@id_proprietaire,
		initial=@initial,numero=@numero where id=@id
end
go

--Delete telephone
create procedure sp_delete_telephone
	@id int
as
begin
	if exists(select * from telephone where id=@id)
		delete from telephone where id=@id
end
go

--Select all telephone
create procedure sp_select_telephones
as
begin
	select id,id_proprietaire,initial,numero from telephone order by numero asc
end
go

--Select all telephone of etudiant
create procedure sp_select_telephones_personne
	@id_personne int	
as
begin
	select id,id_proprietaire,initial,numero
	from telephone where id_proprietaire=@id_personne
	order by numero asc
end
go

--Select one etudiant
create procedure sp_select_telephone
	@id int
as
begin
	select id,id_proprietaire,initial,numero from telephone
	where id=@id
end
go

--Stored Procedure for report of etudiants
create procedure sp_liste_etudiants
as
begin
	select etudiant.id,etudiant.nom + ' ' + ISNULL(etudiant.postnom,'') + ' ' + ISNULL(etudiant.prenom,'') as nom,
	etudiant.sexe,telephone.id as idtel,telephone.initial + telephone.numero as numero
	from etudiant
	left outer join telephone 
	on etudiant.id=telephone.id_proprietaire
end
go

--Test Insert and Update
exec sp_insert_etudiant 1,'Isamuna','Nkembo','Josue','M','22LIAGELJ253'
exec sp_insert_etudiant 2,'Daniel','daba','Dieumerci','M','22LIAGELJ620114'
exec sp_insert_etudiant 3,'Chirimwami','Batumike','Jonathan','M','22LIAGELJ610354'
exec sp_insert_etudiant 4,'Maki','Ndrundro','Jeremie','M','22LIAGELJ640354'
exec sp_insert_etudiant 5,'Richard','Bwale','Rich','M','22LIAGELJ62354'
select * from etudiant

exec sp_insert_telephone 1,1,'+250','785623146'
exec sp_insert_telephone 2,1,'+243','0812700368'
exec sp_insert_telephone 3,2,'+243','985645235'
exec sp_insert_telephone 4,3,'+243','815790584'
exec sp_insert_telephone 5,3,'+242','808256231'
select * from telephone

--Test delete
--exec sp_delete_telephone 1
--select * from telephone

--exec sp_delete_etudiant 3
--select * from etudiant

--Test Select all
--exec sp_select_etudiants 

exec sp_select_telephones

--Test Select One
exec sp_select_etudiants 2

exec sp_select_telephone 4

exec sp_select_telephones_personne 2

--Test Select report
exec sp_liste_etudiants

