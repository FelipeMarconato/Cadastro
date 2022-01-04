create table dbo.a_dom_sexo_luis
(
id_tp_sexo tinyint not null identity (1,1),
ds_tp_sexo varchar (20) not null,
constraint pk_a_dom_sexo_luis primary key (id_tp_sexo)
)
go
if not exists (select top 1 1 from dbo.a_dom_sexo_luis)
begin
     insert into dbo.a_dom_sexo_luis (ds_tp_sexo) values ('Feminino'), ('Masculino'), ('outros')
end
go
create table dbo.a_dom_meio_comunic_luis
(
	id_tp_meio_comunic tinyint not null identity (1,1),
	ds_tp_meio_comunic varchar (25) not null,
	constraint pk_a_dom_meio_comunic_luis primary key (id_tp_meio_comunic)
)
go
if not exists (select top 1 1 from dbo.a_dom_meio_comunic_luis)
begin
	insert into dbo.a_dom_meio_comunic_luis (ds_tp_meio_comunic) values ('E-mail'), ('Endereço'), ('Telefone')
end
go
create table dbo.a_pessoa_luis
(
	id_pessoa int not null identity(1,1),
	mn_pessoa varchar (200) not null,
	dt_nascimento smalldatetime not null,
	id_tp_sexo tinyint not null,
	nr_cpf varchar (11),
	constraint pk_a_pessoa_gui primary key (id_pessoa),
	constraint [fk_a_pessoa_luis_X_a_dom_sexo_luis(id_tp_sexo)] foreign key (id_tp_sexo) references dbo.a_dom_sexo_luis (id_tp_sexo)
)
go
create table dbo.a_pessoa_meio_comunic_luis
(
	id_pessoa_meio_comunic int not null identity (1,1),
	id_pessoa int not null,
	id_tp_meio_comunic tinyint not null,
	ds_valor varchar (100) not null,
	constraint pk_a_pessoa_meio_comunic_luis primary key (id_pessoa_meio_comunic),
	constraint [fk_a_pessoa_meio_comunic_luis_X_a_pessoa_luis(id_pessoa)] foreign key (id_pessoa) references dbo.a_pessoa_luis(id_pessoa),
	constraint [fk_a_pessoa_meio_comunic_luis_X_a_dom_meio_comunic_luis(id_tp_meio_comunic)] foreign key (id_tp_meio_comunic) references dbo.a_dom_meio_comunic_luis(id_tp_meio_comunic)
)




