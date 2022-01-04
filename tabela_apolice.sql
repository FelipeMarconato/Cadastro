CREATE TABLE DBO.A_RAMO_LUIS
(
	id_ramo tinyint not null identity (1,1),
	tp_ramo varchar (20) not null,
	constraint pk_a_ramo_luis primary key (id_ramo)
)
go
if not exists (select top 1 1 from dbo.A_RAMO_LUIS)
begin
	insert into dbo.A_RAMO_LUIS (tp_ramo) values ('AUTOMOVEL'),('VIDA'),('RESIDENCIAL')
end
go
CREATE TABLE DBO.A_APOLICE_CAD_LUIS
(
	id_apolice int not null identity (1,1),
	num_apolice varchar (30),
	dt_inicio_vigencia smalldatetime not null,
	dt_fim_vigencia smalldatetime not null,
	id_pessoa int not null,
	id_ramo tinyint not null,
	constraint pk_a_apolice_cad_luis primary key (id_apolice),
	constraint [fk_a_apolice_cad_luis_X_a_pessoa_luis(id_pessoa)] foreign key (id_Pessoa) references dbo.a_pessoa_luis(id_pessoa),
	constraint [fk_a_apolice_cad_luis_X_a_ramo_luis(id_ramo)] foreign key (id_ramo) references dbo.a_ramo_luis(id_ramo)
)

