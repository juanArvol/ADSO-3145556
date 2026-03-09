-- Vista TipoUsuario
CREATE OR REPLACE VIEW vistaTipoUsuario AS
SELECT *
FROM TipoUsuario;

-- Vista TipoAsistencia
CREATE OR REPLACE VIEW vistaTipoAsistencia AS
SELECT *
FROM TipoAsistencia;

-- Vista Fecha
CREATE OR REPLACE VIEW vistaFecha AS
SELECT *
FROM Fecha;

-- Vista Salon
CREATE OR REPLACE VIEW vistaSalon AS
SELECT *
FROM Salon;

-- Vista Curso
CREATE OR REPLACE VIEW vistaCurso AS
SELECT *
FROM Curso;

-- Vista Usuario
CREATE OR REPLACE VIEW vistaUsuario AS
SELECT 
    u.identificacion,
    u.nombre,
    u.apellidos,
    u.telefono,
    u.correo,
    u.contraseña,
    
    -- Datos del tipo de usuario
    u.tipoUsuario AS idTipoUsuario,
    tu.tipo AS tipoUsuarioNombre

FROM Usuario u
JOIN TipoUsuario tu ON u.tipoUsuario = tu.id;

-- Vista ParametrosPersona
CREATE OR REPLACE VIEW vistaParametrosPersona AS
SELECT *
FROM ParametrosPersona;

-- Vista Jornada
CREATE OR REPLACE VIEW vistaJornada AS
SELECT 
    j.id,
    j.horaInicio,
    j.horaFin,

    -- Salon
    s.id AS idSalon,

    -- Responsable
    u.identificacion AS idResponsable,
    u.nombre AS responsableNombre,
    u.apellidos AS responsableApellidos,

    -- Curso
    c.id AS idCurso

FROM Jornada j
JOIN Salon s ON j.idSalon = s.id
JOIN Usuario u ON j.idResponsable = u.identificacion
JOIN Curso c ON j.idCurso = c.id;

-- Vista RegistroAsistencia
CREATE OR REPLACE VIEW vistaRegistroAsistencia AS
SELECT 
    ra.idFecha,
    f.id AS fecha,

    ra.idEstudiante,
    est.nombre AS estudianteNombre,
    est.apellidos AS estudianteApellidos,

    ra.idJornada,
    j.horaInicio,
    j.horaFin,

    ra.TipoAsistencia AS idTipoAsistencia,
    ta.tipo AS tipoAsistencia,

    ra.horaEntrada,
    ra.horaSalidda,
    ra.observacion
FROM RegistroAsistencia ra
JOIN Fecha f ON ra.idFecha = f.id
JOIN Usuario est ON ra.idEstudiante = est.identificacion
JOIN Jornada j ON ra.idJornada = j.id
JOIN TipoAsistencia ta ON ra.TipoAsistencia = ta.id;
