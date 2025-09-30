CREATE PROC Sp_ProductosC_Eliminar
    @IID                      INT
As
BEGIN
  SET NOCOUNT ON;
  Begin try
    BEGIN TRAN;

    IF NOT EXISTS(Select 1 From Tm_Productos Where ID = @IID)
    BEGIN
        THROW 50001, 'Producto a eliminar no existe.', 1;
    END


    DELETE Tm_Productos
    Where ID = @IID

      COMMIT  TRAN;
   End Try
   BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
   end catch
END
go

