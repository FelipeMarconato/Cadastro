ALTER proc dbo.p_excluir_apolice_luis
(
	@where					varchar(max)			= '',
	@orderby				varchar(max)			= '',
	@cd_retorno				int						= null output,
	@nm_retorno				varchar(200)			= null output,
	@id_apolice				int 					= null output
)
as
/*
BEGIN TRAN
EXEC dbo.p_excluir_apolice_luis @id_apolice = '1'
SELECT * FROM DBO.A_APOLICE_CAD_LUIS
ROLLBACK
*/

if (SELECT DT_FIM_VIGENCIA FROM DBO.A_APOLICE_CAD_LUIS
WHERE 1=1
AND id_apolice = @id_apolice)  > (select Dt_movimento_contabil from corp_modulo
						          where cd_tp_modulo = 3)
		begin 


		select
			@cd_retorno = 1,
			@nm_retorno = 'Não pode excluir!!!'
		return
	END

DELETE FROM DBO.A_APOLICE_CAD_LUIS
		WHERE ID_APOLICE = @id_apolice
	   			
			select
			@cd_retorno = -1,
			@nm_retorno = 'EXCLUIDO!!!!'
			RETURN