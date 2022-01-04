alter PROC DBO.P_NOVA_APOLICE_LUIS	
(
	@where                  varchar(max)            = null,
    @orderby                varchar(max)            = null, 
    @cd_retorno             int                     = null output,
    @nm_retorno             varchar(200)            = null output,
    @id_pessoa              int                     = null output,
    @id_apolice             int                     = null output,
	@num_apolice			varchar (20)			= null,
	@dt_inicio_vigencia		smalldatetime			= null,
	@dt_fim_vigencia		smalldatetime			= null,
	@id_ramo				tinyint					= null,
	@cd_usuario				varchar (100)			= null,-
	@cd_empresa				varchar (200)			= null,
	@dv_documento_oficial	bit						= null,
	@id_sub					int						= null,
	@id_sub_novo			int						= null,
	@nr_versao_proc			int						= null
)
as


IF exists (select top 1 1 from dbo.A_APOLICE_CAD_LUIS
			where num_apolice = @num_apolice
					and id_ramo = @id_ramo) 

begin try

if object_id('tempdb..#id_sub','u') is not null
	begin
		drop table #id_sub
	end

	create table #id_sub  
	(
		id_sub int
	)

	Insert Into dbo.A_APOLICE_CAD_LUIS(
		id_pessoa, num_apolice, dt_inicio_vigencia, dt_fim_vigencia, id_ramo, dv_documento_oficial)

	output inserted.id_apolice into #id_sub
	
	values (@id_pessoa, @num_apolice, @dt_inicio_vigencia, @dt_fim_vigencia, @id_ramo, @dv_documento_oficial)

	select
		@id_sub_novo = id_sub
	from #id_sub

	drop table #id_sub

select	
		@cd_retorno = 0,
		@nm_retorno = edn.f_mensagem_erro(@cd_retorno, @cd_usuario, null, null, null, null, null)
		/*Processamento efetuado com sucesso.*/

end try
begin catch


	if isnull(error_message(),'') <> ''
	begin
		select
			@cd_retorno	= case when isnull(@cd_retorno,0) < 1 then 1 else @cd_retorno end,
			@nm_retorno =
				'Procedure: ' + isnull(object_name(@@procid),'') + 
				' - Versão ' + isnull(convert(varchar(20), @nr_versao_proc),'0') + 
				case when object_name(@@procid) <> isnull(error_procedure(),object_name(@@procid)) then 
					' - Erro na Proc: ' + isnull(convert(varchar(100), error_procedure()), '') 
				else 
					'' 
				end + 
				' - Erro: '	 + isnull(convert(varchar(300), error_message()), '') + 
				case when isnull(error_line(), 0) <> 1 then 
					+ ' - linha: ' + convert(varchar(5),error_line()) 
				else 
					'' 
				end
	end
end catch
