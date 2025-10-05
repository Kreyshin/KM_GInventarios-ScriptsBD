create table Tm_Almacenes
(
    ID                    int identity
        primary key,
    C_Codigo              varchar(20) collate Modern_Spanish_CI_AS
        constraint Tm_Almacenes_COD_pk
            unique,
    C_Nombre              varchar(200) collate Modern_Spanish_CI_AS
        constraint Tm_Almacenes_Nombre_pk
            unique,
    C_Direccion           varchar(200) collate Modern_Spanish_CI_AS,
    ID_TipoAlmacen        int
        constraint Tm_Almacenes_Tm_TipoAlmacen_ID_fk
            references Tm_TipoAlmacen,
    ID_Estado             int,
    C_Usuario_Creacion    varchar(50) collate Modern_Spanish_CI_AS,
    F_Fecha_Creacion      datetime         default getdate(),
    C_Usuario_Modifiacion varchar(50) collate Modern_Spanish_CI_AS,
    F_Fecha_Modificacion  datetime         default getdate(),
    C_Ubigeo              varchar(50) collate Modern_Spanish_CI_AS,
    C_Telefono            varchar(20) collate Modern_Spanish_CI_AS,
    C_Latitud             varchar(200) collate Modern_Spanish_CI_AS,
    C_Longitud            varchar(100) collate Modern_Spanish_CI_AS,
    ID_Sucursal           int,
    C_UUID                uniqueidentifier default newid()
)
go

exec sp_addextendedproperty 'MS_Description', 'Id global para la homolagacion en otras BDs.', 'SCHEMA', 'dbo', 'TABLE',
     'Tm_Almacenes', 'COLUMN', 'C_UUID'
go
