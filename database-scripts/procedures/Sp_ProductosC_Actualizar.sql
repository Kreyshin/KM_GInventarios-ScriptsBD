CREATE PROC Sp_ProductosC_Actualizar
    @IID        INT,
    @IC_Nombre            VARCHAR(200),
    @IC_Descripcion         VARCHAR(200),
    @IC_SKU             VARCHAR(100),
    @IID_Categoria          INT,
    @IID_UnidadMedida          INT,
    @IID_Marca          INT,
    @IID_Estado          INT,
    @IC_Usuario_Modificacion  VARCHAR(50)
As
BEGIN
  SET NOCOUNT ON;
  Begin try
    BEGIN TRANSACTION;

    IF NOT EXISTS(Select 1 From Tm_Productos Where ID = @IID)
    BEGIN
        THROW 50001, 'Prodcuto a actualizar no existe.', 1;
    END

    IF EXISTS(Select 1 From Tm_Productos Where lower(C_Nombre) = lower(@IC_Nombre) AND ID != @IID)
    BEGIN
        THROW 50001, 'Nombre de Almacen ya existe.', 1;
    END

    UPDATE Tm_Productos  SET
        C_Nombre              = IIF(@IC_Nombre = '', C_Nombre, @IC_Nombre),
        C_Descripcion         = IIF(@IC_Descripcion = '', C_Descripcion, @IC_Descripcion),
        ID_Categoria          = IIF(@IID_Categoria = '', ID_Categoria, @IID_Categoria),
        ID_UnidadMedida       = IIF(@IID_UnidadMedida = '', ID_UnidadMedida, @IID_UnidadMedida),
        ID_Marca            = IIF(@IID_Marca = '', ID_Marca, @IID_Marca),
        C_SKU            = IIF(@IC_SKU = '', C_SKU, @IC_SKU),
        ID_Estado             = IIF(@IID_Estado = 0, ID_Estado, @IID_Estado),
        C_Usuario_Modificacion = @IC_Usuario_Modificacion,
        F_Fecha_Modificacion  = GETDATE()
    Where ID = @IID

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

      COMMIT TRANSACTION;
   End Try
   BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
   end catch
END
go

