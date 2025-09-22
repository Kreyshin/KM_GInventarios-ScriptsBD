create table Tm_Productos
(
    ID                     int identity
        primary key
        unique,
    C_UUID                 uniqueidentifier default newid()   not null,
    C_Codigo               varchar(50)                        not null collate Modern_Spanish_CI_AS,
    C_Nombre               varchar(200)                       not null collate Modern_Spanish_CI_AS,
    C_Descripcion          varchar(300)                       not null collate Modern_Spanish_CI_AS,
    ID_Categoria           int
        references Tm_Categoria,
    ID_UnidadMedida        int                                not null
        references Tm_UnidadMedida,
    ID_Marca               int
        references Tm_Marca,
    ID_Estado              tinyint
        references Tm_Estados,
    C_Usuario_Creacion     varchar(50)                        not null collate Modern_Spanish_CI_AS,
    F_Fecha_Creacion       datetime         default getdate() not null,
    C_Usuario_Modificacion varchar(50) collate Modern_Spanish_CI_AS,
    F_Fecha_Modificacion   datetime,
    C_SKU                  varchar(100) collate Modern_Spanish_CI_AS

)
go

