-- CREAR TABLAS
CALL creacionTablas();

-- ELIMINAR TABLAS
CALL eliminarTablas();

-- INSERTAR DATOS A LAS TABLAS
CALL insercionDatos();

-- LLAMAR LAS VISTAS
SELECT * FROM vistaTipoUsuario;
SELECT * FROM vistaTipoAsistencia;
SELECT * FROM vistaFecha;
SELECT * FROM vistaSalon;
SELECT * FROM vistaCurso;
SELECT * FROM vistaUsuario;
SELECT * FROM vistaParametrosPersona;
SELECT * FROM vistaJornada;
SELECT * FROM vistaRegistroAsistencia;