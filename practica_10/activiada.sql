--Codigo de asignatura 503585
-- Seccion: 1

-- 1.-
INSERT INTO asistencias
    VALUES ("503585",
            "1",
            "011",
            2018451991,
            "06/25/2022 09:10:00");

-- 2.-
UPDATE alumnos
    set correo = "josgonzalez2018@udec.cl"
    where numeroMat = 2018451991;

-- 3.-
SELECT numeroMat,nombreLargo
    FROM alumnos WHERE
        (SELECT count(*) FROM asistencias 
        WHERE asistencias.numeroMat = alumnos.numeroMat
        AND codCurso = 503585
        AND seccion = 1) = 11

-- 4.-
SELECT DISTINCT asistencias.codCurso, nombreCurso
    FROM asignatura,asistencias 
    WHERE asignaturas.codCurso = asistencias.codCurso
    AND  asistencias.numeroMat = 2018451991


