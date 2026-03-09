CREATE OR REPLACE PROCEDURE insercionDatos()
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO TipoUsuario VALUES
    (1, 'Estudiante'),
    (2, 'Padre de familia'),
    (3, 'Profesor'),
    (4, 'Administrador'),
    (5, 'Supervisor');

    INSERT INTO TipoAsistencia VALUES
    (1, 'Asistencia'),
    (2, 'Retardo'),
    (3, 'Falta');

    CALL insertarFecha();

    CALL insertarSalon();

    CALL insertarCurso();

    CALL insertarUsuario();

    CALL insertarJornadas();

    CALL insertarRegistroAsistencia();
END;
$$;

CREATE OR REPLACE PROCEDURE insertarFecha()
LANGUAGE plpgsql
AS $$
DECLARE
    fecha_inicio DATE := CURRENT_DATE;   -- puedes cambiarla por la fecha que quieras
    fecha DATE;
    contador INT := 0;
BEGIN
    -- Buscar el siguiente lunes
    fecha := fecha_inicio + ((1 - EXTRACT(DOW FROM fecha_inicio))::INT + 7) % 7;

    -- Insertar fechas por 40 semanas -> 40 * 5 = 200 días laborales
    WHILE contador < 40 * 5 LOOP
        
        -- Si es lunes a viernes (1 a 5)
        IF EXTRACT(DOW FROM fecha) BETWEEN 1 AND 5 THEN
            INSERT INTO Fecha(id) VALUES (fecha);
            contador := contador + 1;
        END IF;

        -- Avanzar un día
        fecha := fecha + INTERVAL '1 day';
    END LOOP;
END;
$$;

CREATE OR REPLACE PROCEDURE insertarSalon()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT;
BEGIN
    -- Insertar salones 100 a 115
    FOR i IN 100..115 LOOP
        INSERT INTO Salon(id) VALUES (i)
        ON CONFLICT (id) DO NOTHING;
    END LOOP;

    -- Insertar salones 200 a 220
    FOR i IN 200..220 LOOP
        INSERT INTO Salon(id) VALUES (i)
        ON CONFLICT (id) DO NOTHING;
    END LOOP;

END;
$$;

CREATE OR REPLACE PROCEDURE insertarCurso()
LANGUAGE plpgsql
AS $$
DECLARE
    grado INT;
    grupo INT;
BEGIN
    -- Grados de 6 a 11
    FOR grado IN 6..11 LOOP
        -- Grupos de 1 a 5 (601-605, 701-705, etc.)
        FOR grupo IN 1..5 LOOP
            INSERT INTO Curso(id)
            VALUES (grado * 100 + grupo)
            ON CONFLICT (id) DO NOTHING;
        END LOOP;
    END LOOP;
END;
$$;

CREATE OR REPLACE PROCEDURE insertarUsuario()
LANGUAGE plpgsql
AS $$
DECLARE
    nombres TEXT[] := ARRAY[
        'Juan','Maria','Carlos','Laura','Andres','Sofia',
        'Pedro','Valentina','Daniel','Camila','Mateo','Gabriela'
    ];

    apellidos TEXT[] := ARRAY[
        'Gomez','Rodriguez','Perez','Martinez','Gonzalez',
        'Lopez','Hernandez','Diaz','Moreno','Ramirez','Torres','Vargas'
    ];

    nombreSel TEXT;
    apellidoSel TEXT;
    numeroAleatorio INT;
BEGIN
    FOR i IN 1..1000 LOOP

        -- Escoger nombre y apellido aleatorios
        nombreSel := nombres[FLOOR(RANDOM() * array_length(nombres, 1) + 1)::INT];
        apellidoSel := apellidos[FLOOR(RANDOM() * array_length(apellidos, 1) + 1)::INT];

        -- Número aleatorio para correo/contraseña
        numeroAleatorio := FLOOR(RANDOM() * 9000 + 1000)::INT;  -- entre 1000 y 9999

        INSERT INTO Usuario (identificacion, tipoUsuario, nombre, apellidos, telefono, correo, contraseña)
        VALUES (
            i,  -- identificacion
            
            -- tipoUsuario con probabilidades
            CASE
                WHEN RANDOM() < 0.50 THEN 1   -- 50% Estudiante
                WHEN RANDOM() < 0.70 THEN 2   -- 20% Padre
                WHEN RANDOM() < 0.85 THEN 3   -- 15% Profesor
                WHEN RANDOM() < 0.95 THEN 4   -- 10% Admin
                ELSE 5                        -- 5% Supervisor
            END,

            nombreSel,       -- nombre real aleatorio
            apellidoSel,     -- apellido real aleatorio
            300000000 + FLOOR(RANDOM() * 1000000)::INT,  -- teléfono de 9 dígitos

            LOWER(nombreSel || '.' || apellidoSel || numeroAleatorio || '@gmail.com'), -- correo formado
            LOWER(nombreSel || '_' || apellidoSel || '_' || numeroAleatorio) -- contraseña generada
        );
    END LOOP;
END $$;


CREATE OR REPLACE PROCEDURE insertarJornadas()
LANGUAGE plpgsql
AS $$
DECLARE
    cantidad INT := 100;  -- puedes cambiar a 50 si quieres
    i INT;

    salonSel INT;
    responsableSel INT;
    cursoSel INT;

    horaInicioSel TIME;
    horaFinSel TIME;

    horariosInicio TIME[] := ARRAY['06:00', '08:00', '10:00'];
    horariosFin TIME[]    := ARRAY['08:00', '10:00', '12:00'];

BEGIN
    FOR i IN 1..cantidad LOOP
        
        -- Seleccionar un salón existente
        SELECT id INTO salonSel
        FROM Salon
        ORDER BY RANDOM()
        LIMIT 1;

        -- Seleccionar un RESPONSABLE que sea PROFESOR (tipoUsuario = 3)
        SELECT identificacion INTO responsableSel
        FROM Usuario
        WHERE tipoUsuario = 3
        ORDER BY RANDOM()
        LIMIT 1;

        -- Seleccionar un curso existente
        SELECT id INTO cursoSel
        FROM Curso
        ORDER BY RANDOM()
        LIMIT 1;

        -- Seleccionar un horario al azar entre los 3 disponibles
        PERFORM pg_sleep(0);  -- evita repetición del random en algunos sistemas
                
        SELECT
            horariosInicio[(FLOOR(RANDOM() * 3) + 1)::INT],
            horariosFin[(FLOOR(RANDOM() * 3) + 1)::INT]
        INTO horaInicioSel, horaFinSel;

        -- Insertar jornada
        INSERT INTO Jornada(id, idSalon, idResponsable, idCurso, horaInicio, horaFin)
        VALUES (
            i,
            salonSel,
            responsableSel,
            cursoSel,
            horaInicioSel,
            horaFinSel
        );

    END LOOP;
END;
$$;

CREATE OR REPLACE PROCEDURE insertarRegistroAsistencia()
LANGUAGE plpgsql
AS $$
DECLARE
    cantidad INT := 5000;  -- Puedes cambiarlo

    fechaSel TIMESTAMP;
    estudianteSel INT;
    jornadaSel INT;
    tipoAsis INT;

    horaInicioJ TIME;
    horaFinJ TIME;

    horaEntradaSel TIME;
    horaSalidaSel TIME;

    obs TEXT;
BEGIN
    FOR i IN 1..cantidad LOOP
        
        -- Seleccionar fecha existente
        SELECT id INTO fechaSel
        FROM Fecha
        ORDER BY RANDOM()
        LIMIT 1;

        -- Seleccionar estudiante (tipoUsuario = 1)
        SELECT identificacion INTO estudianteSel
        FROM Usuario
        WHERE tipoUsuario = 1
        ORDER BY RANDOM()
        LIMIT 1;

        -- Jornada aleatoria entre 1 y 100
        jornadaSel := FLOOR(RANDOM() * 100 + 1);

        -- Obtener horas de la jornada
        SELECT horaInicio, horaFin
        INTO horaInicioJ, horaFinJ
        FROM Jornada
        WHERE id = jornadaSel;

        -- Si la jornada no existe, continuar
        IF horaInicioJ IS NULL THEN
            CONTINUE;
        END IF;

        -- Elegir TipoAsistencia con probabilidades
        tipoAsis := CASE
            WHEN RANDOM() < 0.95 THEN 1   -- 95% asistencia normal
            ELSE 2                        -- 5% retardo
        END;

        -- Calcular horaEntrada según tipoAsistencia
        IF tipoAsis = 1 THEN
            -- Entrada antes del inicio: entre -20 y 0 minutos
            horaEntradaSel := horaInicioJ - ((FLOOR(RANDOM() * 20)::INT) || ' minutes')::interval;

            obs := NULL;
        ELSE
            -- Retardo: 1 hora después del inicio
            horaEntradaSel := (horaInicioJ + INTERVAL '1 hour')::time;

            obs := 'RETARDO';
        END IF;

        -- horaSalida = fin de jornada
        horaSalidaSel := horaFinJ;

        -- Insertar registro
        INSERT INTO RegistroAsistencia(
            idFecha,
            idEstudiante,
            idJornada,
            TipoAsistencia,
            horaEntrada,
            horaSalidda,
            observacion
        )
        VALUES(
            fechaSel,
            estudianteSel,
            jornadaSel,
            tipoAsis,
            horaEntradaSel,
            horaSalidaSel,
            obs
        );

    END LOOP;
END;
$$;
