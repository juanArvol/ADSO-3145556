-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_Curso()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(10);
    v_descripcion VARCHAR(128);
BEGIN
    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se insertó un nuevo Curso: ' || NEW.id;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se actualizó el Curso "' || OLD.id || '" a "' || NEW.id || '"';

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_idAfectado := OLD.id;
        v_descripcion := 'Se eliminó el Curso: ' || OLD.id;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'Curso',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_Curso_insert
AFTER INSERT ON Curso
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Curso();

CREATE TRIGGER trg_Curso_update
AFTER UPDATE ON Curso
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Curso();

CREATE TRIGGER trg_Curso_delete
AFTER DELETE ON Curso
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Curso();


-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_Fecha()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(20);
    v_descripcion VARCHAR(128);
BEGIN
    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se insertó una nueva fecha: ' || NEW.id;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se actualizó la fecha "' || OLD.id || '" a "' || NEW.id || '"';

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_idAfectado := OLD.id;
        v_descripcion := 'Se eliminó la fecha: ' || OLD.id;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'Fecha',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_Fecha_insert
AFTER INSERT ON Fecha
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Fecha();

CREATE TRIGGER trg_Fecha_update
AFTER UPDATE ON Fecha
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Fecha();

CREATE TRIGGER trg_Fecha_delete
AFTER DELETE ON Fecha
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Fecha();


-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_Jornada()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(10);
    v_descripcion VARCHAR(128);
BEGIN
    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se insertó la Jornada: ' || NEW.id;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se actualizó la Jornada ' || OLD.id;

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_idAfectado := OLD.id;
        v_descripcion := 'Se eliminó la Jornada: ' || NEW.id;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'Jornada',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_Jornada_insert
AFTER INSERT ON Jornada
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Jornada();

CREATE TRIGGER trg_Jornada_update
AFTER UPDATE ON Jornada
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Jornada();

CREATE TRIGGER trg_Jornada_delete
AFTER DELETE ON Jornada
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Jornada();


-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_ParametrosPersona()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(10);
    v_descripcion VARCHAR(128);
BEGIN
    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_idAfectado := NEW.idUsuario;
        v_descripcion := 'Se insertaron los parámetros del usuario: ' || NEW.idUsuario;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_idAfectado := NEW.idUsuario;
        v_descripcion := 'Se actualizaron los parámetros de ' || OLD.idUsuario;

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_idAfectado := OLD.idUsuario;
        v_descripcion := 'Se eliminaron los parámetros del usuario: ' || OLD.idUsuario;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'ParametrosPersona',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_ParametrosPersona_insert
AFTER INSERT ON ParametrosPersona
FOR EACH ROW
EXECUTE FUNCTION funcionLog_ParametrosPersona();

CREATE TRIGGER trg_ParametrosPersona_update
AFTER UPDATE ON ParametrosPersona
FOR EACH ROW
EXECUTE FUNCTION funcionLog_ParametrosPersona();

CREATE TRIGGER trg_ParametrosPersona_delete
AFTER DELETE ON ParametrosPersona
FOR EACH ROW
EXECUTE FUNCTION funcionLog_ParametrosPersona();


-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_RegistroAsistencia()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(50);
    v_descripcion VARCHAR(128);
BEGIN

    v_idAfectado := 
        COALESCE(TO_CHAR(CASE WHEN TG_OP = 'DELETE' THEN OLD.idFecha ELSE NEW.idFecha END, 'YYYY-MM-DD HH24:MI:SS'), '') 
        || ' - ' ||
        COALESCE(CASE WHEN TG_OP = 'DELETE' THEN OLD.idEstudiante ELSE NEW.idEstudiante END, 0)
        || ' - ' ||
        COALESCE(CASE WHEN TG_OP = 'DELETE' THEN OLD.idJornada ELSE NEW.idJornada END, 0);

    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_descripcion := 'Se insertó un nuevo Registro de Asistencia del estudiante ' || NEW.idEstudiante || ' en jornada ' || NEW.idJornada;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_descripcion := 'Se actualizó el Registro de Asistencia del estudiante ' || NEW.idEstudiante || ' en jornada ' || NEW.idJornada;

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_descripcion := 'Se eliminó el Registro de Asistencia del estudiante ' || NEW.idEstudiante || ' en jornada ' || NEW.idJornada;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'RegistroAsistencia',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_RegistroAsistencia_insert
AFTER INSERT ON RegistroAsistencia
FOR EACH ROW
EXECUTE FUNCTION funcionLog_RegistroAsistencia();

CREATE TRIGGER trg_RegistroAsistencia_update
AFTER UPDATE ON RegistroAsistencia
FOR EACH ROW
EXECUTE FUNCTION funcionLog_RegistroAsistencia();

CREATE TRIGGER trg_RegistroAsistencia_delete
AFTER DELETE ON RegistroAsistencia
FOR EACH ROW
EXECUTE FUNCTION funcionLog_RegistroAsistencia();


-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_Salon()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(10);
    v_descripcion VARCHAR(128);
BEGIN
    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se insertó un nuevo salón: ' || NEW.id;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se actualizó el salón "' || OLD.id || '" a "' || NEW.id || '"';

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_idAfectado := OLD.id;
        v_descripcion := 'Se eliminó el salón: ' || OLD.id;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'Salon',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_Salon_insert
AFTER INSERT ON Salon
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Salon();

CREATE TRIGGER trg_Salon_update
AFTER UPDATE ON Salon
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Salon();

CREATE TRIGGER trg_Salon_delete
AFTER DELETE ON Salon
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Salon();


-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_TipoAsistencia()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(10);
    v_descripcion VARCHAR(128);
BEGIN
    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se insertó un nuevo tipo de asistencia: ' || NEW.tipo;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se actualizó el tipo de asistencia ' || OLD.id || ' de "' || OLD.tipo || '" a "' || NEW.tipo || '"';

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_idAfectado := OLD.id;
        v_descripcion := 'Se eliminó el tipo de asistencia: ' || OLD.tipo;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'TipoAsistencia',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_TipoAsistencia_insert
AFTER INSERT ON TipoAsistencia
FOR EACH ROW
EXECUTE FUNCTION funcionLog_TipoAsistencia();

CREATE TRIGGER trg_TipoAsistencia_update
AFTER UPDATE ON TipoAsistencia
FOR EACH ROW
EXECUTE FUNCTION funcionLog_TipoAsistencia();

CREATE TRIGGER trg_TipoAsistencia_delete
AFTER DELETE ON TipoAsistencia
FOR EACH ROW
EXECUTE FUNCTION funcionLog_TipoAsistencia();


-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_TipoUsuario()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(10);
    v_descripcion VARCHAR(128);
BEGIN
    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se insertó un nuevo tipo de usuario: ' || NEW.tipo;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_idAfectado := NEW.id;
        v_descripcion := 'Se actualizó el tipo de usuario ' || OLD.id || ' de "' || OLD.tipo || '" a "' || NEW.tipo || '"';

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_idAfectado := OLD.id;
        v_descripcion := 'Se eliminó el tipo de usuario: ' || OLD.tipo;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'TipoUsuario',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_TipoUsuario_insert
AFTER INSERT ON TipoUsuario
FOR EACH ROW
EXECUTE FUNCTION funcionLog_TipoUsuario();

CREATE TRIGGER trg_TipoUsuario_update
AFTER UPDATE ON TipoUsuario
FOR EACH ROW
EXECUTE FUNCTION funcionLog_TipoUsuario();

CREATE TRIGGER trg_TipoUsuario_delete
AFTER DELETE ON TipoUsuario
FOR EACH ROW
EXECUTE FUNCTION funcionLog_TipoUsuario();


-- FUNCIÓN

CREATE OR REPLACE FUNCTION funcionLog_Usuario()
RETURNS TRIGGER AS $$
DECLARE
    v_accion VARCHAR(10);
    v_idAfectado VARCHAR(10);
    v_descripcion VARCHAR(128);
BEGIN
    -- Determinar acción
    IF TG_OP = 'INSERT' THEN
        v_accion := 'INSERT';
        v_idAfectado := NEW.identificacion;
        v_descripcion := 'Se insertó el usuario: ' || NEW.nombre || ' ' || NEW.apellidos;

    ELSIF TG_OP = 'UPDATE' THEN
        v_accion := 'UPDATE';
        v_idAfectado := NEW.identificacion;
        v_descripcion := 'Se actualizó el usuario ' || OLD.identificacion;

    ELSIF TG_OP = 'DELETE' THEN
        v_accion := 'DELETE';
        v_idAfectado := OLD.identificacion;
        v_descripcion := 'Se eliminó el usuario: ' || NEW.nombre || ' ' || NEW.apellidos;
    END IF;

    -- Insertar en Log
    INSERT INTO Log(id, accion, tabla, idRegistroAfectado, descripcion, fecha)
    VALUES (
        (SELECT COALESCE(MAX(id), 0) + 1 FROM Log),   -- ID autogenerado
        v_accion,
        'Usuario',
        v_idAfectado,
        v_descripcion,
        NOW()
    );

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

CREATE TRIGGER trg_Usuario_insert
AFTER INSERT ON Usuario
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Usuario();

CREATE TRIGGER trg_Usuario_update
AFTER UPDATE ON Usuario
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Usuario();

CREATE TRIGGER trg_Usuario_delete
AFTER DELETE ON Usuario
FOR EACH ROW
EXECUTE FUNCTION funcionLog_Usuario();
