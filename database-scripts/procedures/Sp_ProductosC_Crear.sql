ALTER PROC Sp_ProductosC_Crear
    @IC_Codigo            VARCHAR(20),
    @IC_Nombre            VARCHAR(200),
    @IC_Descripcion         VARCHAR(200),
    @IID_Categoria          INT,
    @IID_UnidadMedida          INT,
    @IID_Marca          INT,
    @IC_SKU              VARCHAR(100),
    @IC_Usuario_Creacion  VARCHAR(50)
As
BEGIN
  SET NOCOUNT ON;
    DECLARE
        @VID         INT,
        @VID_Estado  INT
  Begin try
     BEGIN TRANSACTION;



    IF EXISTS(Select 1 From Tm_Productos Where lower(C_Codigo) = lower(@IC_Codigo))
    BEGIN
        THROW 50001, 'Codigo de producto ya existe.', 1;
    END

    IF EXISTS(Select 1 From Tm_Productos Where lower(C_Nombre) = lower(@IC_Nombre))
    BEGIN
        THROW 50001, 'Nombre de producto ya existe.', 1;
    END

    Select @VID_Estado = ID
    From Tm_Estados
    Where C_Codigo = 'ACT'

     INSERT INTO Tm_Productos
     (C_UUID, C_Codigo, C_Nombre, C_Descripcion,
      ID_Categoria, ID_UnidadMedida, ID_Marca, ID_Estado,
      C_SKU,
      C_Usuario_Creacion)
     VALUES
      (NEWID(), @IC_Codigo, @IC_Nombre, @IC_Descripcion,
       @IID_Categoria, @IID_UnidadMedida, @IID_Marca, @VID_Estado,
       @IC_SKU,
       @IC_Usuario_Creacion)

     SET @VID = SCOPE_IDENTITY()

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
     Where T1.ID = @VID

     COMMIT TRANSACTION;
   End Try
   BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
   end catch
END
go

