
CREATE TABLE curso (
    id INTEGER PRIMARY KEY,
    anio INT NOT NULL,
    cuatrimestre INT NOT NULL,
    numero INT NOT NULL,
    descripcion VARCHAR(255)
);
CREATE UNIQUE INDEX curso_pk ON curso (anio, cuatrimestre, numero);

CREATE TABLE usuario (
    id INTEGER PRIMARY KEY,
    child_name VARCHAR(255),
    usuario VARCHAR(10) NOT NULL UNIQUE,
    contrasenia VARCHAR(255),
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telefono VARCHAR(255),
    creado TIMESTAMP NOT NULL,
    observaciones TEXT,
    activo TINYINT NOT NULL
);

CREATE TABLE docente (
    id INTEGER PRIMARY KEY,
    nombrado TINYINT NOT NULL
);

CREATE TABLE alumno (
    id INTEGER PRIMARY KEY,
    nota DECIMAL(3, 1)
);

CREATE TABLE tarea (
    id INTEGER PRIMARY KEY,
    child_name VARCHAR(255),
    nombre VARCHAR(30) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

CREATE TABLE dependencia (
    padre_id INTEGER NOT NULL CONSTRAINT tarea_id_exists REFERENCES tarea(id),
    hijo_id INTEGER NOT NULL CONSTRAINT tarea_id_exists REFERENCES tarea(id),
    orden INT,
    PRIMARY KEY (padre_id, hijo_id)
);

CREATE TABLE enunciado (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL UNIQUE,
    autor_id INT CONSTRAINT autor_id_exists REFERENCES docente(id),
    descripcion VARCHAR(255),
    creado TIMESTAMP NOT NULL
);

CREATE TABLE enunciado_tarea (
    enunciado_id INTEGER NOT NULL CONSTRAINT enunciado_id_exists REFERENCES enunciado(id),
    tarea_id INTEGER NOT NULL CONSTRAINT tarea_id_exists REFERENCES tarea(id),
    orden INT,
    PRIMARY KEY (enunciado_id, tarea_id)
);

CREATE TABLE caso_de_prueba (
    id INTEGER PRIMARY KEY,
    enunciado_id INT CONSTRAINT enunciado_id_exists REFERENCES enunciado(id),
    nombre VARCHAR(40) NOT NULL,
    parametros TEXT NOT NULL,
    retorno INT,
    tiempo_cpu FLOAT,
    descripcion VARCHAR(255)
);
CREATE UNIQUE INDEX caso_de_prueba_pk ON caso_de_prueba (enunciado_id, nombre);

CREATE TABLE ejercicio (
    id INTEGER PRIMARY KEY,
    curso_id INT NOT NULL CONSTRAINT curso_id_exists REFERENCES curso(id),
    numero INT NOT NULL,
    enunciado_id INT NOT NULL CONSTRAINT enunciado_id_exists REFERENCES enunciado(id),
    grupal TINYINT NOT NULL
);
CREATE UNIQUE INDEX ejercicio_pk ON ejercicio (curso_id, numero);

CREATE TABLE instancia_de_entrega (
    id INTEGER PRIMARY KEY,
    ejercicio_id INT NOT NULL CONSTRAINT ejercicio_id_exists REFERENCES ejercicio(id),
    numero INT NOT NULL,
    inicio TIMESTAMP NOT NULL,
    fin TIMESTAMP NOT NULL,
    procesada TINYINT NOT NULL,
    observaciones TEXT,
    activo TINYINT NOT NULL
);

CREATE TABLE instancia_tarea (
    instancia_id INTEGER NOT NULL CONSTRAINT instancia_id_exists REFERENCES instancia_de_entrega(id),
    tarea_id INTEGER NOT NULL CONSTRAINT tarea_id_exists REFERENCES tarea(id),
    orden INT,
    PRIMARY KEY (instancia_id, tarea_id)
);

CREATE TABLE docente_inscripto (
    id INTEGER PRIMARY KEY,
    curso_id INT NOT NULL CONSTRAINT curso_id_exists REFERENCES curso(id),
    docente_id INT NOT NULL CONSTRAINT docente_id_exists REFERENCES docente(id),
    corrige TINYINT NOT NULL,
    observaciones TEXT
);
CREATE UNIQUE INDEX docente_inscripto_pk ON docente_inscripto (curso_id, docente_id);

CREATE TABLE entregador (
    id INTEGER PRIMARY KEY,
    child_name VARCHAR(255),
    nota DECIMAL(3, 1),
    nota_cursada DECIMAL(3, 1),
    observaciones TEXT,
    activo TINYINT NOT NULL
);

CREATE TABLE grupo (
    id INTEGER PRIMARY KEY,
    curso_id INT NOT NULL CONSTRAINT curso_id_exists REFERENCES curso(id),
    nombre VARCHAR(20) NOT NULL,
    responsable_id INT CONSTRAINT responsable_id_exists REFERENCES alumno_inscripto(id) 
);

CREATE TABLE alumno_inscripto (
    id INTEGER PRIMARY KEY,
    curso_id INT NOT NULL CONSTRAINT curso_id_exists REFERENCES curso(id),
    alumno_id INT NOT NULL CONSTRAINT alumno_id_exists REFERENCES alumno(id),
    condicional TINYINT NOT NULL,
    tutor_id INT CONSTRAINT tutor_id_exists REFERENCES docente_inscripto(id) 
);
CREATE UNIQUE INDEX alumno_inscripto_pk ON alumno_inscripto (curso_id, alumno_id);

CREATE TABLE tutor (
    id INTEGER PRIMARY KEY,
    grupo_id INT NOT NULL CONSTRAINT grupo_id_exists REFERENCES grupo(id),
    docente_id INT NOT NULL CONSTRAINT docente_id_exists REFERENCES docente_inscripto(id),
    alta TIMESTAMP NOT NULL,
    baja TIMESTAMP
);
CREATE UNIQUE INDEX tutor_pk ON tutor (grupo_id, docente_id);

CREATE TABLE miembro (
    id INTEGER PRIMARY KEY,
    grupo_id INT NOT NULL CONSTRAINT grupo_id_exists REFERENCES grupo(id),
    alumno_id INT NOT NULL CONSTRAINT alumno_id_exists REFERENCES alumno_inscripto(id),
    nota DECIMAL(3, 1),
    alta TIMESTAMP NOT NULL,
    baja TIMESTAMP
);
CREATE UNIQUE INDEX miembro_pk ON miembro (grupo_id, alumno_id);

CREATE TABLE entrega (
    id INTEGER PRIMARY KEY,
    instancia_id INT NOT NULL CONSTRAINT instancia_id_exists REFERENCES instancia_de_entrega(id),
    entregador_id INT CONSTRAINT entregador_id_exists REFERENCES entregador(id),
    fecha TIMESTAMP NOT NULL,
    correcta TINYINT NOT NULL,
    observaciones TEXT
);
CREATE UNIQUE INDEX entrega_pk ON entrega (instancia_id, entregador_id, fecha);

CREATE TABLE correccion (
    id INTEGER PRIMARY KEY,
    instancia_id INT NOT NULL CONSTRAINT instancia_id_exists REFERENCES instancia_de_entrega(id),
    entregador_id INT NOT NULL CONSTRAINT entregador_id_exists REFERENCES entregador(id),
    entrega_id INT NOT NULL CONSTRAINT entrega_id_exists REFERENCES entrega(id),
    corrector_id INT NOT NULL CONSTRAINT corrector_id_exists REFERENCES docente_inscripto(id),
    asignado TIMESTAMP NOT NULL,
    corregido TIMESTAMP,
    nota DECIMAL(3, 1),
    observaciones TEXT
);
CREATE UNIQUE INDEX correccion_pk ON correccion (instancia_id, entregador_id);

CREATE TABLE tarea_ejecutada (
    id INTEGER PRIMARY KEY,
    child_name VARCHAR(255),
    tarea_id INT NOT NULL CONSTRAINT tarea_id_exists REFERENCES tarea(id),
    entrega_id INT NOT NULL CONSTRAINT entrega_id_exists REFERENCES entrega(id),
    inicio TIMESTAMP NOT NULL,
    fin TIMESTAMP,
    exito INT,
    observaciones TEXT
);
CREATE UNIQUE INDEX tarea_ejecutada_pk ON tarea_ejecutada (tarea_id, entrega_id);

CREATE TABLE prueba (
    id INTEGER PRIMARY KEY,
    tarea_ejecutada_id INT NOT NULL CONSTRAINT tarea_ejecutada_id_exists REFERENCES tarea_ejecutada(id),
    caso_de_prueba_id INT NOT NULL CONSTRAINT caso_de_prueba_id_exists REFERENCES caso_de_prueba(id),
    inicio TIMESTAMP NOT NULL,
    fin TIMESTAMP,
    pasada INT,
    observaciones TEXT
);
CREATE UNIQUE INDEX prueba_pk ON prueba (tarea_ejecutada_id, caso_de_prueba_id);

CREATE TABLE visita (
    id INTEGER PRIMARY KEY,
    visit_key VARCHAR(40) NOT NULL UNIQUE,
    created TIMESTAMP NOT NULL,
    expiry TIMESTAMP
);

CREATE TABLE visita_usuario (
    id INTEGER PRIMARY KEY,
    visit_key VARCHAR(40) NOT NULL UNIQUE,
    user_id INT CONSTRAINT usuario_id_exists REFERENCES usuario(id) 
);

CREATE TABLE rol (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion VARCHAR(255),
    creado TIMESTAMP NOT NULL,
    permisos TEXT NOT NULL
);

CREATE TABLE rol_usuario (
    rol_id INT NOT NULL,
    usuario_id INT NOT NULL
);

