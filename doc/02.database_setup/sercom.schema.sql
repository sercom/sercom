-- MySQL dump 10.13  Distrib 5.1.37, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: sercom
-- ------------------------------------------------------
-- Server version	5.1.37-1ubuntu5.5

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumno` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nota` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `alumno_usuario_id_exists` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumno_inscripto`
--

DROP TABLE IF EXISTS `alumno_inscripto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumno_inscripto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `condicional` tinyint(4) NOT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  `nota_practica` decimal(3,1) DEFAULT NULL,
  `nota_final` decimal(3,1) DEFAULT NULL,
  `nota_libreta` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`curso_id`,`alumno_id`),
  KEY `alumno_inscripto_alumno_id_exists` (`alumno_id`),
  KEY `alumno_inscripto_tutor_id_exists` (`tutor_id`),
  CONSTRAINT `alumno_inscripto_alumno_id_exists` FOREIGN KEY (`alumno_id`) REFERENCES `alumno` (`id`),
  CONSTRAINT `alumno_inscripto_curso_id_exists` FOREIGN KEY (`curso_id`) REFERENCES `curso` (`id`),
  CONSTRAINT `alumno_inscripto_tutor_id_exists` FOREIGN KEY (`tutor_id`) REFERENCES `docente_inscripto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1981 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit`
--

DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit` (
  `docente` char(40) DEFAULT NULL,
  `accion` char(40) DEFAULT NULL,
  `nota` char(40) DEFAULT NULL,
  `padron` char(10) DEFAULT NULL,
  `curso` char(20) DEFAULT NULL,
  `alumno` char(20) DEFAULT NULL,
  `ejercicio` char(20) DEFAULT NULL,
  `entrega` char(20) DEFAULT NULL,
  `nota_vieja` char(10) DEFAULT NULL,
  `dttm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caso_de_prueba`
--

DROP TABLE IF EXISTS `caso_de_prueba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caso_de_prueba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enunciado_id` int(11) DEFAULT NULL,
  `nombre` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`enunciado_id`,`nombre`),
  CONSTRAINT `caso_de_prueba_enunciado_id_exists` FOREIGN KEY (`enunciado_id`) REFERENCES `enunciado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comando`
--

DROP TABLE IF EXISTS `comando`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comando` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comando` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `retorno` int(11) DEFAULT NULL,
  `max_tiempo_cpu` int(11) DEFAULT NULL,
  `max_memoria` int(11) DEFAULT NULL,
  `max_tam_archivo` int(11) DEFAULT NULL,
  `max_cant_archivos` int(11) DEFAULT NULL,
  `max_cant_procesos` int(11) DEFAULT NULL,
  `max_locks_memoria` int(11) DEFAULT NULL,
  `terminar_si_falla` tinyint(4) NOT NULL,
  `rechazar_si_falla` tinyint(4) NOT NULL,
  `publico` tinyint(4) NOT NULL,
  `archivos_entrada` mediumblob,
  `archivos_a_comparar` mediumblob,
  `archivos_a_guardar` mediumblob NOT NULL,
  `activo` tinyint(4) NOT NULL,
  `child_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comando_ejecutado`
--

DROP TABLE IF EXISTS `comando_ejecutado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comando_ejecutado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diferencias` mediumblob,
  `child_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `comando_ejecutado_id_exists` FOREIGN KEY (`id`) REFERENCES `ejecucion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146490 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comando_fuente`
--

DROP TABLE IF EXISTS `comando_fuente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comando_fuente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tarea_id` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`tarea_id`,`orden`),
  CONSTRAINT `comando_fuente_tarea_id_exists` FOREIGN KEY (`tarea_id`) REFERENCES `tarea` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comando_fuente_ejecutado`
--

DROP TABLE IF EXISTS `comando_fuente_ejecutado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comando_fuente_ejecutado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comando_id` int(11) NOT NULL,
  `entrega_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`comando_id`,`entrega_id`),
  KEY `comando_fuente_ejecutado_entrega_id_exists` (`entrega_id`),
  CONSTRAINT `comando_fuente_ejecutado_id_exists` FOREIGN KEY (`id`) REFERENCES `comando_ejecutado` (`id`),
  CONSTRAINT `comando_fuente_ejecutado_comando_id_exists` FOREIGN KEY (`comando_id`) REFERENCES `comando` (`id`),
  CONSTRAINT `comando_fuente_ejecutado_entrega_id_exists` FOREIGN KEY (`entrega_id`) REFERENCES `entrega` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146475 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comando_prueba`
--

DROP TABLE IF EXISTS `comando_prueba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comando_prueba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tarea_id` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`tarea_id`,`orden`),
  CONSTRAINT `comando_prueba_tarea_id_exists` FOREIGN KEY (`tarea_id`) REFERENCES `tarea` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comando_prueba_ejecutado`
--

DROP TABLE IF EXISTS `comando_prueba_ejecutado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comando_prueba_ejecutado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comando_id` int(11) NOT NULL,
  `prueba_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`comando_id`,`prueba_id`),
  KEY `comando_prueba_ejecutado_prueba_id_exists` (`prueba_id`),
  CONSTRAINT `comando_prueba_ejecutado_id_exists` FOREIGN KEY (`id`) REFERENCES `comando_ejecutado` (`id`),
  CONSTRAINT `comando_prueba_ejecutado_comando_id_exists` FOREIGN KEY (`comando_id`) REFERENCES `comando` (`id`),
  CONSTRAINT `comando_prueba_ejecutado_prueba_id_exists` FOREIGN KEY (`prueba_id`) REFERENCES `prueba` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146490 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `correccion`
--

DROP TABLE IF EXISTS `correccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `correccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instancia_id` int(11) NOT NULL,
  `entregador_id` int(11) NOT NULL,
  `entrega_id` int(11) DEFAULT NULL,
  `corrector_id` int(11) NOT NULL,
  `asignado` datetime NOT NULL,
  `corregido` datetime DEFAULT NULL,
  `nota` decimal(3,1) DEFAULT NULL,
  `observaciones` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`instancia_id`,`entregador_id`),
  KEY `correccion_entregador_id_exists` (`entregador_id`),
  KEY `correccion_entrega_id_exists` (`entrega_id`),
  KEY `correccion_corrector_id_exists` (`corrector_id`),
  CONSTRAINT `correccion_corrector_id_exists` FOREIGN KEY (`corrector_id`) REFERENCES `docente_inscripto` (`id`),
  CONSTRAINT `correccion_entregador_id_exists` FOREIGN KEY (`entregador_id`) REFERENCES `entregador` (`id`),
  CONSTRAINT `correccion_entrega_id_exists` FOREIGN KEY (`entrega_id`) REFERENCES `entrega` (`id`),
  CONSTRAINT `correccion_instancia_id_exists` FOREIGN KEY (`instancia_id`) REFERENCES `instancia_examinacion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1261 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE trigger audit_insert_notas after insert on correccion for each row begin
insert into audit select ud.nombre, 'Nota Insertada', nota, au.usuario, cu.descripcion, au.nombre, ej.numero, ie.numero, NULL, NULL from correccion c join docente_inscripto di on (c.corrector_id=di.id) join usuario ud on (ud.id=di.docente_id) left join alumno_inscripto ai on (ai.id=c.entregador_id) left join usuario au on (au.id=ai.alumno_id) left join curso cu on (cu.id=ai.curso_id) left join instancia_de_entrega ie on (ie.id=c.instancia_id) left join ejercicio ej on (ej.id=ie.ejercicio_id) where c.id=NEW.id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE trigger audit_update_notas after update on correccion for each row begin
insert into audit select ud.nombre, 'Nota Actualizada', NEW.nota, au.usuario, cu.descripcion, au.nombre, ej.numero, ie.numero, OLD.nota, NULL from correccion c join docente_inscripto di on (c.corrector_id=di.id) join usuario ud on (ud.id=di.docente_id) left join alumno_inscripto ai on (ai.id=c.entregador_id) left join usuario au on (au.id=ai.alumno_id) left join curso cu on (cu.id=ai.curso_id) left join instancia_de_entrega ie on (ie.id=c.instancia_id) left join ejercicio ej on (ej.id=ie.ejercicio_id) where c.id=NEW.id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anio` int(11) NOT NULL,
  `cuatrimestre` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`anio`,`cuatrimestre`,`numero`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docente`
--

DROP TABLE IF EXISTS `docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `docente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombrado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `docente_usuario_id_exists` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docente_inscripto`
--

DROP TABLE IF EXISTS `docente_inscripto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `docente_inscripto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) NOT NULL,
  `docente_id` int(11) NOT NULL,
  `corrige` tinyint(4) NOT NULL,
  `observaciones` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`curso_id`,`docente_id`),
  KEY `docente_inscripto_docente_id_exists` (`docente_id`),
  CONSTRAINT `docente_inscripto_curso_id_exists` FOREIGN KEY (`curso_id`) REFERENCES `curso` (`id`),
  CONSTRAINT `docente_inscripto_docente_id_exists` FOREIGN KEY (`docente_id`) REFERENCES `docente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=376 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ejecucion`
--

DROP TABLE IF EXISTS `ejecucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ejecucion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inicio` datetime DEFAULT NULL,
  `fin` datetime DEFAULT NULL,
  `exito` int(11) DEFAULT NULL,
  `observaciones` text NOT NULL,
  `archivos` mediumblob,
  `child_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146496 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ejercicio`
--

DROP TABLE IF EXISTS `ejercicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ejercicio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `enunciado_id` int(11) NOT NULL,
  `grupal` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`curso_id`,`numero`),
  KEY `ejercicio_enunciado_id_exists` (`enunciado_id`),
  CONSTRAINT `ejercicio_curso_id_exists` FOREIGN KEY (`curso_id`) REFERENCES `curso` (`id`),
  CONSTRAINT `ejercicio_enunciado_id_exists` FOREIGN KEY (`enunciado_id`) REFERENCES `enunciado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrega`
--

DROP TABLE IF EXISTS `entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrega` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instancia_id` int(11) NOT NULL,
  `entregador_id` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`instancia_id`,`entregador_id`,`fecha`),
  KEY `entrega_entregador_id_exists` (`entregador_id`),
  CONSTRAINT `entrega_id_exists` FOREIGN KEY (`id`) REFERENCES `ejecucion` (`id`),
  CONSTRAINT `entrega_entregador_id_exists` FOREIGN KEY (`entregador_id`) REFERENCES `entregador` (`id`),
  CONSTRAINT `entrega_instancia_id_exists` FOREIGN KEY (`instancia_id`) REFERENCES `instancia_de_entrega` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146496 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entregador`
--

DROP TABLE IF EXISTS `entregador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entregador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nota` decimal(3,1) DEFAULT NULL,
  `nota_cursada` decimal(3,1) DEFAULT NULL,
  `observaciones` text NOT NULL,
  `activo` tinyint(4) NOT NULL,
  `child_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1984 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enunciado`
--

DROP TABLE IF EXISTS `enunciado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enunciado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) DEFAULT NULL,
  `anio` int(11) NOT NULL,
  `cuatrimestre` int(11) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `autor_id` int(11) DEFAULT NULL,
  `lenguaje_id` int(11) DEFAULT NULL,
  `creado` datetime NOT NULL,
  `archivos` mediumblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`nombre`,`anio`,`cuatrimestre`),
  KEY `enunciado_autor_id_exists` (`autor_id`),
  KEY `enunciado_lenguaje_id` (`lenguaje_id`),
  CONSTRAINT `enunciado_lenguaje_id` FOREIGN KEY (`lenguaje_id`) REFERENCES `lenguaje` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enunciado_tarea`
--

DROP TABLE IF EXISTS `enunciado_tarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enunciado_tarea` (
  `enunciado_id` int(11) NOT NULL,
  `tarea_id` int(11) NOT NULL,
  KEY `enunciado_tarea_enunciado_id_exists` (`enunciado_id`),
  KEY `enunciado_tarea_tarea_id_exists` (`tarea_id`),
  CONSTRAINT `enunciado_tarea_enunciado_id_exists` FOREIGN KEY (`enunciado_id`) REFERENCES `enunciado` (`id`),
  CONSTRAINT `enunciado_tarea_tarea_id_exists` FOREIGN KEY (`tarea_id`) REFERENCES `tarea` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `examen_final`
--

DROP TABLE IF EXISTS `examen_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examen_final` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anio` int(11) NOT NULL,
  `cuatrimestre` int(11) NOT NULL,
  `oportunidad` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`anio`,`cuatrimestre`,`oportunidad`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `responsable_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`curso_id`,`nombre`),
  KEY `grupo_responsable_id_exists` (`responsable_id`),
  CONSTRAINT `grupo_curso_id_exists` FOREIGN KEY (`curso_id`) REFERENCES `curso` (`id`),
  CONSTRAINT `grupo_responsable_id_exists` FOREIGN KEY (`responsable_id`) REFERENCES `alumno_inscripto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1984 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imagen`
--

DROP TABLE IF EXISTS `imagen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `tamanio` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `nombre_archivo` varchar(255) NOT NULL,
  `tipo_de_contenido` varchar(255) NOT NULL,
  `contenido` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `Pk` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instancia_examinacion`
--

DROP TABLE IF EXISTS `instancia_examinacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instancia_examinacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inicio` datetime NOT NULL,
  `fin` datetime NOT NULL,
  `observaciones` text NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `child_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instancia_de_entrega`
--

DROP TABLE IF EXISTS `instancia_de_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instancia_de_entrega` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ejercicio_id` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`ejercicio_id`,`numero`),
  CONSTRAINT `instancia_de_entrega_id_exists` FOREIGN KEY (`id`) REFERENCES `instancia_examinacion` (`id`),
  CONSTRAINT `instancia_de_entrega_ejercicio_id_exists` FOREIGN KEY (`ejercicio_id`) REFERENCES `ejercicio` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=454 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instancia_de_evaluacion_alumno`
--

DROP TABLE IF EXISTS `instancia_de_evaluacion_alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instancia_de_evaluacion_alumno` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `child_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`curso_id`,`tipo`),
  CONSTRAINT `instancia_de_evaluacion_alumno_id_exists` FOREIGN KEY (`id`) REFERENCES `instancia_examinacion` (`id`),
  CONSTRAINT `instancia_de_evaluacion_alumno_curso_id_exists` FOREIGN KEY (`curso_id`) REFERENCES `curso` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lenguaje`
--

DROP TABLE IF EXISTS `lenguaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lenguaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `mossnet_id` varchar(30) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `miembro`
--

DROP TABLE IF EXISTS `miembro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `miembro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grupo_id` int(11) NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `nota` decimal(3,1) DEFAULT NULL,
  `alta` datetime NOT NULL,
  `baja` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`grupo_id`,`alumno_id`),
  KEY `miembro_alumno_id_exists` (`alumno_id`),
  CONSTRAINT `miembro_alumno_id_exists` FOREIGN KEY (`alumno_id`) REFERENCES `alumno_inscripto` (`id`),
  CONSTRAINT `miembro_grupo_id_exists` FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pregunta_examen`
--

DROP TABLE IF EXISTS `pregunta_examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregunta_examen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `examen_id` int(11) DEFAULT NULL,
  `texto` varchar(5000) DEFAULT NULL,
  `tema_id` int(11) DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  `solucion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`examen_id`,`numero`),
  KEY `pregunta_examen_tema_id_exists` (`tema_id`),
  KEY `pregunta_examen_tipo_id_exists` (`tipo_id`),
  KEY `pregunta_examen_solucion_id_exists` (`solucion_id`),
  CONSTRAINT `pregunta_examen_examen_id_exists` FOREIGN KEY (`examen_id`) REFERENCES `examen_final` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pregunta_examen_solucion_id_exists` FOREIGN KEY (`solucion_id`) REFERENCES `solucion` (`id`) ON DELETE SET NULL,
  CONSTRAINT `pregunta_examen_tema_id_exists` FOREIGN KEY (`tema_id`) REFERENCES `tema_pregunta` (`id`),
  CONSTRAINT `pregunta_examen_tipo_id_exists` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_pregunta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prueba`
--

DROP TABLE IF EXISTS `prueba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prueba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entrega_id` int(11) NOT NULL,
  `caso_de_prueba_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`entrega_id`,`caso_de_prueba_id`),
  KEY `prueba_caso_de_prueba_id_exists` (`caso_de_prueba_id`),
  CONSTRAINT `prueba_id_exists` FOREIGN KEY (`id`) REFERENCES `comando_ejecutado` (`id`),
  CONSTRAINT `prueba_caso_de_prueba_id_exists` FOREIGN KEY (`caso_de_prueba_id`) REFERENCES `caso_de_prueba` (`id`),
  CONSTRAINT `prueba_entrega_id_exists` FOREIGN KEY (`entrega_id`) REFERENCES `entrega` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146489 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `respuesta`
--

DROP TABLE IF EXISTS `respuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `respuesta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `texto` varchar(5000) NOT NULL,
  `pregunta_id` int(11) NOT NULL,
  `revisada` tinyint(1) NOT NULL,
  `autor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `respuesta_pregunta_id_exists` (`pregunta_id`),
  KEY `respuesta_usuario` (`autor_id`),
  CONSTRAINT `respuesta_pregunta_id_exists` FOREIGN KEY (`pregunta_id`) REFERENCES `pregunta_examen` (`id`) ON DELETE CASCADE,
  CONSTRAINT `respuesta_usuario` FOREIGN KEY (`autor_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `creado` datetime NOT NULL,
  `permisos` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rol_usuario`
--

DROP TABLE IF EXISTS `rol_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol_usuario` (
  `rol_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  KEY `rol_usuario_rol_id_exists` (`rol_id`),
  KEY `rol_usuario_usuario_id_exists` (`usuario_id`),
  CONSTRAINT `rol_usuario_rol_id_exists` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id`),
  CONSTRAINT `rol_usuario_usuario_id_exists` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `solucion`
--

DROP TABLE IF EXISTS `solucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solucion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarea`
--

DROP TABLE IF EXISTS `tarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `child_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarea_fuente`
--

DROP TABLE IF EXISTS `tarea_fuente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarea_fuente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarea_prueba`
--

DROP TABLE IF EXISTS `tarea_prueba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarea_prueba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tema_pregunta`
--

DROP TABLE IF EXISTS `tema_pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tema_pregunta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`descripcion`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_pregunta`
--

DROP TABLE IF EXISTS `tipo_pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_pregunta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`descripcion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tutor`
--

DROP TABLE IF EXISTS `tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grupo_id` int(11) NOT NULL,
  `docente_id` int(11) NOT NULL,
  `alta` datetime NOT NULL,
  `baja` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pk` (`grupo_id`,`docente_id`),
  KEY `tutor_docente_id_exists` (`docente_id`),
  CONSTRAINT `tutor_docente_id_exists` FOREIGN KEY (`docente_id`) REFERENCES `docente_inscripto` (`id`),
  CONSTRAINT `tutor_grupo_id_exists` FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(10) NOT NULL,
  `contrasenia` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `creado` datetime NOT NULL,
  `observaciones` text,
  `activo` tinyint(4) NOT NULL,
  `child_name` varchar(255) DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `hash_ip` varchar(32) DEFAULT NULL,
  `hash_ts` datetime DEFAULT NULL,
  `paginador` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=1132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visita`
--

DROP TABLE IF EXISTS `visita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visita` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_key` varchar(40) NOT NULL,
  `created` datetime NOT NULL,
  `expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `visit_key` (`visit_key`)
) ENGINE=InnoDB AUTO_INCREMENT=55846 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visita_usuario`
--

DROP TABLE IF EXISTS `visita_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visita_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_key` varchar(40) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `visit_key` (`visit_key`),
  KEY `visita_usuario_usuario_id_exists` (`user_id`),
  CONSTRAINT `visita_usuario_usuario_id_exists` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `visita_usuario_visit_key_exists` FOREIGN KEY (`visit_key`) REFERENCES `visita` (`visit_key`)
) ENGINE=InnoDB AUTO_INCREMENT=23775 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-07-19  0:35:36
