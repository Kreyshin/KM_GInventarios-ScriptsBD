CREATE PROC Sp_ProductosQ_Consultar
    @IC_Codigo           VARCHAR(20) = '',
    @IC_Nombre           VARCHAR(200) = '',
    @IID_Categoria      INT = 0,
    @IID_UnidadMedida      INT = 0,
    @IID_Marca      INT = 0,
    @IID_Estado           INT = 0,
    @IC_SKU            VARCHAR(100) = ''
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY

        SELECT
       T1.ID,
       T1.C_Codigo,
       T1.C_Nombre,
       T1.C_Descripcion,
       T1.ID_Categoria,
       T2.C_Nombre C_Categoria,
       T1.ID_UnidadMedida,
       T3.C_Nombre C_UnidadMedida,
       T1.ID_Marca,
       T4.C_Nombre C_Marca,
       T1.ID_Estado,
       T5.C_Nombre C_Estado,
       T1.C_SKU
     From Tm_Productos T1 left Join Tm_Categoria T2 ON T1.ID_Categoria = T2.ID
                          Inner Join Tm_UnidadMedida T3 ON T1.ID_UnidadMedida = T3.ID
                          Left Join Tm_Marca T4 ON T1.ID_Marca = T4.ID
                          Inner Join Tm_Estados T5 ON T1.ID_Estado = T5.ID
    Where (@IC_Codigo = '' OR T1.C_Codigo like '%'+ @IC_Codigo + '%')
     And   (@IC_Nombre = '' OR T1.C_Nombre like '%'+ @IC_Nombre + '%')
     And   (@IID_Categoria = 0 OR T1.ID_Categoria = @IID_Categoria)
     And   (@IID_UnidadMedida = 0 OR T1.ID_UnidadMedida = @IID_UnidadMedida)
     And   (@IID_Marca = 0 OR T1.ID_Marca = @IID_Marca)
     AND   (@IID_Estado = 0 OR T1.ID_Estado = @IID_Estado)
     And   (@IC_SKU = '' OR T1.C_SKU like '%'+ @IC_SKU + '%')


    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    end catch
end
go

