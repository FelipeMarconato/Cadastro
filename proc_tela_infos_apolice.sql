alter PROC dbo.p_a_pessoa_luis
(
    @where                  varchar(max)            = '',
    @orderby                varchar(max)            = '',
    @cd_retorno             int                     = null output,
    @nm_retorno             varchar(200)            = null output,
    @id_pessoa              int                     = null,
    @id_apolice             int                     = null,
    @id_ramo                int                     = null

)
    
as

 select @id_pessoa = isnull(@id_pessoa,convert(int, dbo.corpfc_extrai_valor_where(@where, 'id_pessoa')))
 select @id_apolice = isnull(@id_apolice,convert(int, dbo.corpfc_extrai_valor_where(@where, 'id_apolice')))
 select @id_ramo = isnull(@id_ramo,convert(int, dbo.corpfc_extrai_valor_where(@where, 'id_ramo')))

declare

 

@sql        varchar(max)

 

select @sql =  'select * from dbo.a_pessoa_luis'

 

 if @id_pessoa is not null
 begin
 select @sql = @sql + ' where id_pessoa = ' + CONVERT (varchar, @id_pessoa)
 end
 exec (@sql)