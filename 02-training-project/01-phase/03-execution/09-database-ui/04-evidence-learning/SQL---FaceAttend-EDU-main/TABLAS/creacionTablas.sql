CREATE OR REPLACE PROCEDURE creacionTablas()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Tabla TipoUsuario
    CREATE TABLE IF NOT EXISTS TipoUsuario (
        id INT PRIMARY KEY,
        tipo VARCHAR(20) NOT NULL
    );

    -- Tabla TipoAsistencia
    CREATE TABLE IF NOT EXISTS TipoAsistencia (
        id INT PRIMARY KEY,
        tipo VARCHAR(12) NOT NULL
    );

    -- Tabla Fecha
    CREATE TABLE IF NOT EXISTS Fecha (
        id TIMESTAMP PRIMARY KEY
    );

    -- Tabla Salon
    CREATE TABLE IF NOT EXISTS Salon (
        id INT PRIMARY KEY
    );

    -- Tabla Curso
    CREATE TABLE IF NOT EXISTS Curso (
        id INT PRIMARY KEY
    );

    -- Tabla Usuario
    CREATE TABLE IF NOT EXISTS Usuario (
        identificacion INT PRIMARY KEY,
        tipoUsuario INT NOT NULL,
        nombre VARCHAR(50) NOT NULL,
        apellidos VARCHAR(50) NOT NULL,
        telefono INT NOT NULL,
        correo VARCHAR(50) NOT NULL,
        contraseña VARCHAR(40) NOT NULL,
        FOREIGN KEY (tipoUsuario) REFERENCES TipoUsuario(id)
    );

    -- Tabla ParametrosPersona
    CREATE TABLE IF NOT EXISTS ParametrosPersona (
        idUsuario INT NOT NULL UNIQUE,
        rasgos VARCHAR(255) NOT NULL,
        FOREIGN KEY (idUsuario) REFERENCES Usuario(identificacion)
    );

    -- Tabla Jornada
    CREATE TABLE IF NOT EXISTS Jornada (
        id INT PRIMARY KEY,
        idSalon INT NOT NULL,
        idResponsable INT NOT NULL,
        idCurso INT NOT NULL,
        horaInicio time NOT NULL,
        horaFin time NOT NULL,
        FOREIGN KEY (idSalon) REFERENCES Salon(id),
        FOREIGN KEY (idResponsable) REFERENCES Usuario(identificacion),
        FOREIGN KEY (idCurso) REFERENCES Curso(id)
    );

    -- Tabla RegistroAsistencia
    CREATE TABLE IF NOT EXISTS RegistroAsistencia (
        idFecha TIMESTAMP NOT NULL,
        idEstudiante INT NOT NULL,
        idJornada INT NOT NULL,
        TipoAsistencia INT NOT NULL,
        horaEntrada time NOT NULL,
        horaSalidda time NULL,
        observacion VARCHAR(128),
        FOREIGN KEY (idFecha) REFERENCES Fecha(id),
        FOREIGN KEY (idEstudiante) REFERENCES Usuario(identificacion),
        FOREIGN KEY (idJornada) REFERENCES Jornada(id),
        FOREIGN KEY (TipoAsistencia) REFERENCES TipoAsistencia(id)
    );

    -- Tabla Log
    CREATE TABLE IF NOT EXISTS Log (
        id INT PRIMARY KEY,
        accion VARCHAR(10) NOT NULL,
        tabla VARCHAR(20) NOT NULL,
        idRegistroAfectado VARCHAR(50) NOT NULL,
        descripcion VARCHAR(128) NOT NULL,
        fecha TIMESTAMP NOT NULL
    );
END;
$$;

