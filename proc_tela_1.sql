alter PROCEDURE dbo.p_pessoa_luis_alterar
(
	@id_pessoa int output,
	@mn_pessoa varchar (200),
	@dt_nascimento smalldatetime,
	@id_tp_sexo tinyint,
	@nr_cpf varchar(11),
	@cd_retorno int = null output,
	@nm_retorno varchar (250) = null output
)
as
begin
	update tb 
		set tb.mn_pessoa = @mn_pessoa,
			tb.dt_nascimento = @dt_nascimento,
			tb.id_tp_sexo = @id_tp_sexo,
			tb.nr_cpf = @nr_cpf
					   		
	from
		dbo.a_pessoa_luis tb
	where
		tb.id_pessoa = @id_pessoa

	select
	@cd_retorno = 0,
	@nm_retorno = 'Pessoa alterada com sucesso!!!!'
end
