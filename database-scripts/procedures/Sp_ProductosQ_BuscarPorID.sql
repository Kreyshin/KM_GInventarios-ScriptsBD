CREATE PROC Sp_ProductosQ_BuscarPorID
    @IID   INT
As
BEGIN
  SET NOCOUNT ON;

  Begin try


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
     Where T1.ID = @IID

   End Try
   BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
   end catch
END
go

