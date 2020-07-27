/*
 Navicat MySQL Data Transfer

 Source Server         : develemento-vultr
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : cursonet_db

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 05/08/2020 22:09:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for tbl_admin
-- ----------------------------
DROP TABLE IF EXISTS `tbl_admin`;
CREATE TABLE `tbl_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL DEFAULT ' ',
  `apellido` varchar(45) NOT NULL DEFAULT ' ',
  `foto` varchar(100) DEFAULT NULL COMMENT 'foto del profesor/administrador',
  `img` blob,
  `user` varchar(45) NOT NULL DEFAULT '',
  `pass` varchar(250) NOT NULL DEFAULT '',
  `es_admin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `email` varchar(45) NOT NULL DEFAULT ' ',
  `telefono` varchar(45) DEFAULT 'NO',
  `fax` varchar(40) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `sintesis` text COMMENT 'sistesis o CV',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user` (`user`) USING BTREE,
  KEY `admin` (`es_admin`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de administradores y profesores\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_admin_curso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_admin_curso`;
CREATE TABLE `tbl_admin_curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) unsigned NOT NULL,
  `curso_id` int(11) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `admin_id` (`admin_id`) USING BTREE,
  KEY `curso_id` (`curso_id`) USING BTREE,
  CONSTRAINT `tbl_admin_curso_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `tbl_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_admin_curso_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for tbl_cartelera
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cartelera`;
CREATE TABLE `tbl_cartelera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curso_id` int(10) unsigned NOT NULL,
  `grupo_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `mensaje` text,
  `fecha_c` datetime NOT NULL COMMENT 'fecha de creado el mensaje',
  `destaca` tinyint(1) DEFAULT '0' COMMENT 'si el mensaje destaca',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `curso_id` (`curso_id`) USING BTREE,
  KEY `grupo_id` (`grupo_id`) USING BTREE,
  CONSTRAINT `cartelera_fk` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='mensajes en la cartelera para las secciones';

-- ----------------------------
-- Table structure for tbl_contenido
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contenido`;
CREATE TABLE `tbl_contenido` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curso_id` int(10) unsigned NOT NULL DEFAULT '0',
  `autor` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'id del autor del tema',
  `titulo` varchar(255) NOT NULL DEFAULT '',
  `contenido` longtext NOT NULL,
  `borrador` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'si es un borrador  o no',
  `fecha` datetime NOT NULL,
  `leido` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'cantidad de veces leido',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `fecha` (`fecha`) USING BTREE,
  KEY `curso_id` (`curso_id`) USING BTREE,
  CONSTRAINT `contenido_fk` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de contenidos x curso\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_contenido_grupo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contenido_grupo`;
CREATE TABLE `tbl_contenido_grupo` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `contenido_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grupo_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `content` (`contenido_id`) USING BTREE,
  KEY `grupo` (`grupo_id`) USING BTREE,
  CONSTRAINT `FK_contenido_grupo_1` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_contenido_grupo_fk` FOREIGN KEY (`grupo_id`) REFERENCES `tbl_grupo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='relacion contenidos por grupo';

-- ----------------------------
-- Table structure for tbl_contenido_recurso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contenido_recurso`;
CREATE TABLE `tbl_contenido_recurso` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contenido_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'id del registro del contenido',
  `recurso_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'id del registro del archivo',
  `tipo` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `contenido_id` (`contenido_id`) USING BTREE,
  KEY `recurso_id` (`recurso_id`) USING BTREE,
  CONSTRAINT `tbl_contenido_recurso_fk` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_contenido_recurso_fk1` FOREIGN KEY (`recurso_id`) REFERENCES `tbl_recurso` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=860 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de recursos x contenidos\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_curso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_curso`;
CREATE TABLE `tbl_curso` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` tinytext NOT NULL,
  `alias` varchar(22) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'nombre corto del curso',
  `fecha_creado` datetime NOT NULL,
  `duracion` varchar(40) DEFAULT NULL COMMENT 'tiempo q dura',
  `descripcion` tinytext,
  `resp` int(10) unsigned DEFAULT NULL,
  `notas` tinytext,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `publico` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `alias` (`alias`) USING BTREE,
  KEY `tbl_curso_resp_foreign` (`resp`) USING BTREE,
  CONSTRAINT `tbl_curso_resp_foreign` FOREIGN KEY (`resp`) REFERENCES `tbl_admin` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla con la informacion de los cursos (materias a dictar)\r\n';

-- ----------------------------
-- Table structure for tbl_equipo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_equipo`;
CREATE TABLE `tbl_equipo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `grupo_id` int(10) unsigned NOT NULL COMMENT 'id del grupo',
  `nombre` varchar(180) NOT NULL COMMENT 'nombre del equipo',
  `descripcion` tinytext,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `grupo_id` (`grupo_id`) USING BTREE,
  CONSTRAINT `tbl_equipo_fk` FOREIGN KEY (`grupo_id`) REFERENCES `tbl_grupo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de equipos de secciones para proy y foros';

-- ----------------------------
-- Table structure for tbl_equipo_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_equipo_estudiante`;
CREATE TABLE `tbl_equipo_estudiante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipo_id` int(10) unsigned NOT NULL,
  `est_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`equipo_id`,`est_id`) USING BTREE,
  KEY `equipo_id` (`equipo_id`) USING BTREE,
  KEY `est_id` (`est_id`) USING BTREE,
  CONSTRAINT `tbl_equipo_estudiante_fk` FOREIGN KEY (`equipo_id`) REFERENCES `tbl_equipo` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_equipo_estudiante_fk1` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla que asocia un estudiante a un equipo';

-- ----------------------------
-- Table structure for tbl_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_estudiante`;
CREATE TABLE `tbl_estudiante` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_number` varchar(30) NOT NULL DEFAULT '',
  `nombre` varchar(45) NOT NULL DEFAULT '',
  `apellido` varchar(45) NOT NULL DEFAULT '',
  `foto` longblob COMMENT 'foto del estudiante',
  `sexo` char(1) NOT NULL DEFAULT '',
  `fecha_nac` date DEFAULT NULL,
  `telefono_p` varchar(45) DEFAULT 'NO',
  `telefono_c` varchar(45) DEFAULT 'NO',
  `email` varchar(55) NOT NULL DEFAULT '',
  `msn` varchar(30) DEFAULT 'NO',
  `twitter` varchar(30) DEFAULT 'NO',
  `carrera` varchar(40) DEFAULT 'NO',
  `nivel` varchar(45) DEFAULT 'NO',
  `universidad` varchar(45) DEFAULT 'NO',
  `internet_acc` varchar(2) DEFAULT 'NO',
  `internet_zona` varchar(45) DEFAULT 'NINGUNA',
  `user` varchar(45) NOT NULL DEFAULT '',
  `pass` varchar(250) NOT NULL DEFAULT '',
  `fecha_creado` datetime NOT NULL,
  `activo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `clave_preg` varchar(200) NOT NULL DEFAULT ' ' COMMENT 'pregunta para recordar clave de alumno',
  `clave_resp` varchar(200) NOT NULL DEFAULT ' ' COMMENT 'respuesta para recordar clave de alumno',
  `share_info` tinyint(1) NOT NULL DEFAULT '1',
  `notify_msg` tinyint(1) NOT NULL DEFAULT '0',
  `notify_forum` tinyint(1) NOT NULL DEFAULT '0',
  `notify_exam` tinyint(1) NOT NULL DEFAULT '0',
  `token` varchar(100) DEFAULT NULL COMMENT 'token para micro servicios',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id_number` (`id_number`) USING BTREE,
  UNIQUE KEY `token` (`token`) USING BTREE,
  KEY `activo` (`activo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=500 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de estudiantes de los cursos';

-- ----------------------------
-- Table structure for tbl_evaluacion
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion`;
CREATE TABLE `tbl_evaluacion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `autor` int(10) unsigned NOT NULL DEFAULT '0',
  `nombre` varchar(50) NOT NULL DEFAULT '',
  `curso_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contenido_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grupo_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `fecha` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `npreg` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'nro de preguntas',
  `tipo` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 seleccion, 2 desarrollo',
  `nivel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 whatever, 1 easy, 2 normal, 3 hard',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `contenido` (`contenido_id`) USING BTREE,
  KEY `curso_grupo` (`curso_id`,`grupo_id`) USING BTREE,
  CONSTRAINT `evaluacion_fk` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='tabla de evaluaciones';

-- ----------------------------
-- Table structure for tbl_evaluacion_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion_estudiante`;
CREATE TABLE `tbl_evaluacion_estudiante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `est_id` int(10) unsigned NOT NULL,
  `eval_id` int(10) unsigned NOT NULL,
  `nota` float(5,2) NOT NULL DEFAULT '-1.00',
  `correccion` mediumtext NOT NULL COMMENT 'comentario del profesor',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `est_id` (`est_id`) USING BTREE,
  KEY `eval_id` (`eval_id`) USING BTREE,
  CONSTRAINT `evaluacion_estudiante_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE,
  CONSTRAINT `evaluacion_estudiante_fk1` FOREIGN KEY (`eval_id`) REFERENCES `tbl_evaluacion` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de notas de los estudiantes x evaluacion\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_evaluacion_pregunta
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion_pregunta`;
CREATE TABLE `tbl_evaluacion_pregunta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curso_id` int(10) unsigned NOT NULL DEFAULT '0',
  `eval_id` int(10) unsigned DEFAULT '0',
  `tipo` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 des, 1 seleccion',
  `pregunta` text NOT NULL,
  `nivel` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'nivel de complejidad, para el caso de las preguntas tipo seleccion',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `evaluacion` (`eval_id`) USING BTREE,
  KEY `tipo` (`tipo`,`nivel`) USING BTREE,
  CONSTRAINT `FK_evaluacion_preguntas_1` FOREIGN KEY (`eval_id`) REFERENCES `tbl_evaluacion` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='InnoDB free: 10240 kB; (`eval_id`) REFER `cursonet/evaluacio';

-- ----------------------------
-- Table structure for tbl_evaluacion_respuesta
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion_respuesta`;
CREATE TABLE `tbl_evaluacion_respuesta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `est_id` int(10) unsigned NOT NULL DEFAULT '0',
  `preg_id` int(10) unsigned NOT NULL DEFAULT '0',
  `respuesta` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pregunta` (`est_id`) USING BTREE,
  KEY `estudiante` (`preg_id`) USING BTREE,
  CONSTRAINT `evaluacion_respuesta_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE,
  CONSTRAINT `evaluacion_respuesta_fk1` FOREIGN KEY (`preg_id`) REFERENCES `tbl_evaluacion_pregunta` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='tabla de respuestas de los estudiantes por evaluacion\r\nrevis';

-- ----------------------------
-- Table structure for tbl_evaluacion_respuesta_s
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion_respuesta_s`;
CREATE TABLE `tbl_evaluacion_respuesta_s` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `est_id` int(10) unsigned NOT NULL,
  `preg_id` int(10) unsigned NOT NULL,
  `resp_opc` int(11) NOT NULL COMMENT 'opcion de la respuesta que contesto el estudiante',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `est_id` (`est_id`) USING BTREE,
  KEY `preg_id` (`preg_id`) USING BTREE,
  CONSTRAINT `evaluacion_respuesta_s_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE,
  CONSTRAINT `evaluacion_respuesta_s_fk1` FOREIGN KEY (`preg_id`) REFERENCES `tbl_evaluacion_pregunta` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for tbl_foro
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro`;
CREATE TABLE `tbl_foro` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `autor` int(10) unsigned NOT NULL DEFAULT '0',
  `curso_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contenido_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grupo_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `equipo_id` int(10) unsigned DEFAULT NULL,
  `titulo` tinytext NOT NULL,
  `resumen` text COMMENT 'breve resumen si se desea',
  `content` longtext NOT NULL,
  `fecha_post` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL COMMENT 'fecha en que termina el tiempo para hacer post',
  `leido` smallint(6) NOT NULL DEFAULT '0' COMMENT 'campo para determinar los comentarios nuevos, por defecto el numero total de comentarios cuando se abre el foro',
  `nota` smallint(6) NOT NULL DEFAULT '0' COMMENT 'porcentaje si es 0 no es evaluado',
  `corregido` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 falta por evaluar, 1 evaluado',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `contenido_id` (`contenido_id`) USING BTREE,
  KEY `curso_id` (`curso_id`) USING BTREE,
  CONSTRAINT `tbl_foro_ibfk_1` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='tabla de foros\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_foro_comentario
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro_comentario`;
CREATE TABLE `tbl_foro_comentario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `foro_id` int(11) unsigned NOT NULL DEFAULT '0',
  `tipo_sujeto` enum('admin','est') NOT NULL DEFAULT 'est' COMMENT 'si responde un estudiante o un admin',
  `sujeto_id` int(10) unsigned NOT NULL,
  `content` longtext,
  `fecha_post` datetime DEFAULT NULL,
  `valido` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'si es 0 no ha sido evaluado, 1 fue aceptado',
  `response` int(11) NOT NULL DEFAULT '0' COMMENT 'para saber si el coment es resp de otro post',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sujeto` (`tipo_sujeto`,`sujeto_id`) USING BTREE,
  KEY `foro_id` (`foro_id`) USING BTREE,
  CONSTRAINT `foro_comentario_fk` FOREIGN KEY (`foro_id`) REFERENCES `tbl_foro` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1309 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='tabla de comentarios x foro';

-- ----------------------------
-- Table structure for tbl_foro_comentario_like
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro_comentario_like`;
CREATE TABLE `tbl_foro_comentario_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comentario_id` int(11) NOT NULL,
  `tipo_sujeto` enum('admin','est') NOT NULL DEFAULT 'est' COMMENT 'si responde un estudiante o un admin',
  `sujeto_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `comentario_id` (`comentario_id`) USING BTREE,
  KEY `tipo_sujeto` (`tipo_sujeto`,`sujeto_id`) USING BTREE,
  CONSTRAINT `tbl_foro_comentario_like_ibfk_1` FOREIGN KEY (`comentario_id`) REFERENCES `tbl_foro_comentario` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for tbl_foro_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro_estudiante`;
CREATE TABLE `tbl_foro_estudiante` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'tabla que guarda la nota del estudiante en el foro',
  `est_id` int(11) unsigned NOT NULL DEFAULT '0',
  `foro_id` int(11) unsigned NOT NULL DEFAULT '0',
  `nota` float(6,3) NOT NULL DEFAULT '-1.000',
  `correccion` mediumtext COMMENT 'descripcion de la correccion',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `est_id` (`est_id`) USING BTREE,
  KEY `foro_id` (`foro_id`) USING BTREE,
  CONSTRAINT `foro_estudiante_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE,
  CONSTRAINT `foro_estudiante_fk1` FOREIGN KEY (`foro_id`) REFERENCES `tbl_foro` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for tbl_foro_respuesta
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro_respuesta`;
CREATE TABLE `tbl_foro_respuesta` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `comentario_id` int(11) NOT NULL DEFAULT '0',
  `tipo_sujeto` enum('admin','est') NOT NULL DEFAULT 'est' COMMENT 'si responde un estudiante o un admin',
  `sujeto_id` int(10) NOT NULL COMMENT 'id del profesor que responde',
  `content` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `com_id` (`comentario_id`) USING BTREE,
  KEY `tipo_sujeto` (`tipo_sujeto`,`sujeto_id`) USING BTREE,
  CONSTRAINT `tbl_foro_respuesta_ibfk_1` FOREIGN KEY (`comentario_id`) REFERENCES `tbl_foro_comentario` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=647 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='las respuesta que hace el profesor a los comentarios en el f';

-- ----------------------------
-- Table structure for tbl_grupo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_grupo`;
CREATE TABLE `tbl_grupo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) unsigned NOT NULL,
  `nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT ' ',
  `descripcion` text,
  `prof_id` int(11) unsigned DEFAULT NULL COMMENT 'profesor responsable',
  `turno` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 presencial, 1 semi p, 2 a distancia',
  `fecha_creado` datetime NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fecha` (`fecha_creado`) USING BTREE,
  KEY `curso_id` (`curso_id`) USING BTREE,
  KEY `prof_id` (`prof_id`) USING BTREE,
  CONSTRAINT `tbl_grupo_fk` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_grupo_ibfk_1` FOREIGN KEY (`prof_id`) REFERENCES `tbl_admin` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de grupos o secciones\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_grupo_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_grupo_estudiante`;
CREATE TABLE `tbl_grupo_estudiante` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) unsigned NOT NULL DEFAULT '0',
  `est_id` int(11) unsigned NOT NULL DEFAULT '0',
  `grupo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `curso_id` (`curso_id`) USING BTREE,
  KEY `est_id` (`est_id`) USING BTREE,
  KEY `grupo_id` (`grupo_id`) USING BTREE,
  CONSTRAINT `grupo_estudiante_fk` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grupo_estudiante_fk1` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_grupo_estudiante_fk` FOREIGN KEY (`grupo_id`) REFERENCES `tbl_grupo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for tbl_log_admin
-- ----------------------------
DROP TABLE IF EXISTS `tbl_log_admin`;
CREATE TABLE `tbl_log_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) unsigned NOT NULL,
  `fecha_in` datetime NOT NULL COMMENT 'fecha en que accede',
  `ip_acc` varchar(45) CHARACTER SET utf8 NOT NULL COMMENT 'ip de donde accede',
  `info_cliente` tinytext CHARACTER SET utf8 NOT NULL COMMENT 'informacion sobre el so y el browser del cliente',
  `curso_id` int(10) DEFAULT '0' COMMENT 'curso con el que ingreso por defecto',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `admin_log_id` (`admin_id`) USING BTREE,
  CONSTRAINT `admin_log_id` FOREIGN KEY (`admin_id`) REFERENCES `tbl_admin` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=664 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for tbl_log_est
-- ----------------------------
DROP TABLE IF EXISTS `tbl_log_est`;
CREATE TABLE `tbl_log_est` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `est_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fecha_in` datetime DEFAULT NULL COMMENT 'fecha en que accede',
  `ip_acc` varchar(45) NOT NULL DEFAULT '' COMMENT 'ip de donde accede',
  `info_cliente` tinytext NOT NULL COMMENT 'informacion sobre el so y el browser del cliente',
  `contenidos` varchar(220) DEFAULT '0' COMMENT 'ids, de los contenidos revisados (separados por coma)',
  `descargas` varchar(220) DEFAULT '0' COMMENT 'ids de las descargas realizadas (separadas por coma)',
  `links` varchar(20) DEFAULT '0' COMMENT 'ids de los links visitados',
  `soporte_a` smallint(6) NOT NULL DEFAULT '0' COMMENT 'veces que a hecho consultas por tema',
  `soporte_t` smallint(6) NOT NULL DEFAULT '0' COMMENT 'veces que ha pedido ayuda a soporte tecnico',
  `ncontenidos` smallint(6) NOT NULL DEFAULT '0' COMMENT 'numero de contenidos descargados',
  `ndescargas` smallint(6) NOT NULL DEFAULT '0' COMMENT 'numero de descargas hechas',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `estudiante_id` (`est_id`) USING BTREE,
  KEY `fecha` (`fecha_in`) USING BTREE,
  CONSTRAINT `log_est_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de log de ingreso al sistema x estudiante\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_mensaje_admin
-- ----------------------------
DROP TABLE IF EXISTS `tbl_mensaje_admin`;
CREATE TABLE `tbl_mensaje_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 admin to admin, 1 student to admin',
  `urgencia` varchar(20) NOT NULL DEFAULT '0',
  `de` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'remite',
  `para` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'admin_id',
  `subject` varchar(200) NOT NULL DEFAULT '',
  `content` longtext NOT NULL,
  `fecha` datetime NOT NULL COMMENT 'fecha de la ultima modificacion',
  `leido` tinyint(1) unsigned DEFAULT '0' COMMENT 'si esta leido o no',
  `destinatario` varchar(100) DEFAULT NULL COMMENT 'campo que indica el destinatario del mensaje enviado, en caso de que sea individual o grupo',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tipo` (`tipo`) USING BTREE,
  KEY `para` (`para`) USING BTREE,
  KEY `de` (`de`) USING BTREE,
  CONSTRAINT `FK_mensaje_admin_1` FOREIGN KEY (`para`) REFERENCES `tbl_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='InnoDB free: 7168 kB; (`to`) REFER `edunet2/admin`(`id`) ON ';

-- ----------------------------
-- Table structure for tbl_mensaje_est
-- ----------------------------
DROP TABLE IF EXISTS `tbl_mensaje_est`;
CREATE TABLE `tbl_mensaje_est` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 student to student, 1 profe to student',
  `urgencia` varchar(20) NOT NULL DEFAULT '0',
  `de` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'remite',
  `para` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'estudiante_id',
  `subject` varchar(200) NOT NULL DEFAULT '',
  `content` longtext NOT NULL,
  `fecha` datetime NOT NULL COMMENT 'fecha de la ultima modificacion',
  `leido` tinyint(1) unsigned DEFAULT '0' COMMENT 'si esta leido o no',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tipo` (`tipo`) USING BTREE,
  KEY `para` (`para`) USING BTREE,
  CONSTRAINT `FK_mensaje_est_1` FOREIGN KEY (`para`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='InnoDB free: 7168 kB; (`to`) REFER `edunet2/estudiante`(`id`';

-- ----------------------------
-- Table structure for tbl_mensaje_est_enviado
-- ----------------------------
DROP TABLE IF EXISTS `tbl_mensaje_est_enviado`;
CREATE TABLE `tbl_mensaje_est_enviado` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `est_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'remite',
  `tipo` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 student to student, 1 profe to student',
  `urgencia` varchar(20) NOT NULL DEFAULT '0',
  `para` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'estudiante_id',
  `subject` varchar(200) NOT NULL DEFAULT '',
  `content` longtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tipo` (`tipo`) USING BTREE,
  KEY `para` (`para`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='InnoDB free: 7168 kB; (`to`) REFER `edunet2/estudiante`(`id`';

-- ----------------------------
-- Table structure for tbl_plan_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_estudiante`;
CREATE TABLE `tbl_plan_estudiante` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'item del plan evaluador que corresponde',
  `est_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'id del estudiante que tiene la nota',
  `nota` float(9,4) DEFAULT '0.0000' COMMENT 'nota real obtenida por el estudiante',
  `correccion` mediumtext COMMENT 'justificacion de la nota colocada',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `item_id` (`item_id`) USING BTREE,
  KEY `est_id` (`est_id`) USING BTREE,
  CONSTRAINT `plan_estudiante_fk` FOREIGN KEY (`item_id`) REFERENCES `tbl_plan_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `plan_estudiante_fk1` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla que almacena la nota del estudiante en cada item segun';

-- ----------------------------
-- Table structure for tbl_plan_evaluador
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_evaluador`;
CREATE TABLE `tbl_plan_evaluador` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `grupo_id` int(10) unsigned NOT NULL DEFAULT '0',
  `titulo` varchar(60) CHARACTER SET utf8 NOT NULL DEFAULT ' ',
  `en_base` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'campo que explica en base a que porcentaje se evalua, la nota final',
  `redondeo` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'redondeo de notas al final',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `grupo_id` (`grupo_id`) USING BTREE,
  CONSTRAINT `tbl_plan_evaluador_fk` FOREIGN KEY (`grupo_id`) REFERENCES `tbl_grupo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='tabla de planes\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_item`;
CREATE TABLE `tbl_plan_item` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) unsigned NOT NULL DEFAULT '0',
  `titulo` varchar(120) DEFAULT NULL,
  `tipo` enum('foro','eval','proy','otro') NOT NULL DEFAULT 'foro' COMMENT 'el tipo de la actividad',
  `id_act` int(11) NOT NULL DEFAULT '0' COMMENT 'el id de la actividad en el caso de que sea foro,eval,proy sino es 0',
  `porcentaje` float(9,4) NOT NULL DEFAULT '0.0000' COMMENT 'expresado en % sobre la nota final',
  `en_base` float(9,4) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `plan_id` (`plan_id`) USING BTREE,
  KEY `tipo_act` (`tipo`,`id_act`) USING BTREE,
  CONSTRAINT `plan_item_fk` FOREIGN KEY (`plan_id`) REFERENCES `tbl_plan_evaluador` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de item a evaluar en el plan\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_pregunta_opcion
-- ----------------------------
DROP TABLE IF EXISTS `tbl_pregunta_opcion`;
CREATE TABLE `tbl_pregunta_opcion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `preg_id` int(10) unsigned NOT NULL,
  `opcion` tinytext,
  `correcta` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `preg_id` (`preg_id`) USING BTREE,
  CONSTRAINT `pregunta_opcion_fk` FOREIGN KEY (`preg_id`) REFERENCES `tbl_evaluacion_pregunta` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='opciones para las preguntas de opcion multiple\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_proyecto
-- ----------------------------
DROP TABLE IF EXISTS `tbl_proyecto`;
CREATE TABLE `tbl_proyecto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(125) NOT NULL,
  `autor` int(10) unsigned NOT NULL DEFAULT '0',
  `curso_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contenido_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grupo` smallint(5) unsigned NOT NULL DEFAULT '0',
  `enunciado` longtext NOT NULL COMMENT 'enunciado del proyecto',
  `fecha_entrega` datetime NOT NULL,
  `fecha_edit` datetime DEFAULT NULL,
  `nota` smallint(6) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fecha_entrega` (`fecha_entrega`) USING BTREE,
  KEY `contenido_id` (`contenido_id`) USING BTREE,
  CONSTRAINT `proyecto_fk` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='tabla de proyectos\nrevision VE';

-- ----------------------------
-- Table structure for tbl_proyecto_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_proyecto_estudiante`;
CREATE TABLE `tbl_proyecto_estudiante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proy_id` int(11) NOT NULL DEFAULT '0',
  `est_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rec_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'id del recurso q fue subido por el estudiante',
  `correccion` mediumtext NOT NULL COMMENT 'justificacion de la nota colocada',
  `nota` float(5,2) NOT NULL DEFAULT '-1.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `proy_id` (`proy_id`) USING BTREE,
  KEY `est_id` (`est_id`) USING BTREE,
  CONSTRAINT `proyecto_estudiante_fk` FOREIGN KEY (`proy_id`) REFERENCES `tbl_proyecto` (`id`) ON DELETE CASCADE,
  CONSTRAINT `proyecto_estudiante_fk1` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='tabla de notas de estudiantes en proyectos\nrevision VE';

-- ----------------------------
-- Table structure for tbl_proyecto_recurso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_proyecto_recurso`;
CREATE TABLE `tbl_proyecto_recurso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proy_id` int(11) NOT NULL DEFAULT '0',
  `rec_id` int(10) unsigned NOT NULL DEFAULT '0',
  `tipo` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 archivo, 1 enlace, 2 video',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `proy_id` (`proy_id`) USING BTREE,
  KEY `rec_id` (`rec_id`) USING BTREE,
  CONSTRAINT `tbl_proyecto_recurso_fk` FOREIGN KEY (`proy_id`) REFERENCES `tbl_proyecto` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_proyecto_recurso_fk1` FOREIGN KEY (`rec_id`) REFERENCES `tbl_recurso` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='tabla relacion que recursos tiene cada proyecto\r\nrevision VE';

-- ----------------------------
-- Table structure for tbl_recurso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_recurso`;
CREATE TABLE `tbl_recurso` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 descargable, 1 link, 2, video, 3 leible',
  `fecha` datetime DEFAULT NULL,
  `dir` tinytext NOT NULL COMMENT 'path o url',
  `add_by` enum('admin','est') NOT NULL DEFAULT 'admin',
  `persona` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'id de la persona quien lo agrego',
  `descripcion` tinytext,
  `downloads` smallint(6) NOT NULL DEFAULT '0' COMMENT 'numero de veces descargado',
  `fuente` varchar(100) DEFAULT NULL COMMENT 'fuente del archivo ejemplo youtube',
  `size` varchar(10) NOT NULL DEFAULT ' ' COMMENT 'cuanto pesa',
  `mime` varchar(80) DEFAULT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `filepath` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `tipo` (`tipo`) USING BTREE,
  KEY `add_by_persona` (`add_by`,`persona`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=596 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tabla de recursos subidos por el admin o estudiantes\r\nrevisi';

-- ----------------------------
-- Table structure for tbl_setup
-- ----------------------------
DROP TABLE IF EXISTS `tbl_setup`;
CREATE TABLE `tbl_setup` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `titulo` tinytext,
  `titulo_admin` tinytext,
  `modo` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lenguaje` varchar(55) NOT NULL DEFAULT '',
  `log` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `uni_nombre` varchar(100) NOT NULL DEFAULT '',
  `uni_dir` tinytext,
  `uni_telefono` varchar(45) NOT NULL DEFAULT ' ',
  `uni_fax` varchar(45) DEFAULT NULL,
  `uni_website` varchar(45) DEFAULT NULL,
  `uni_logo` varchar(250) DEFAULT NULL,
  `signature` tinytext,
  `bienvenido_est` text COMMENT 'texto de bienvenida est',
  `fin_inscripcion` text COMMENT 'texto saliente al completar la insc',
  `formato_fecha` varchar(8) DEFAULT 'd/m/Y',
  `formato_fecha_db` varchar(8) DEFAULT '%d/%m/%Y',
  `envio_email` tinyint(3) unsigned DEFAULT '0' COMMENT '0 no envia email 1, envia email',
  `admin_email` varchar(150) DEFAULT NULL,
  `titulo_ins` tinytext,
  `timezone` varchar(40) DEFAULT 'America/caracas' COMMENT 'zona horaria',
  `version` varchar(30) DEFAULT NULL COMMENT 'la version actual de cursonet',
  `dif_hora` smallint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='revision VE';

-- ----------------------------
-- Table structure for tbl_soporte
-- ----------------------------
DROP TABLE IF EXISTS `tbl_soporte`;
CREATE TABLE `tbl_soporte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona_id` int(10) NOT NULL,
  `tipo` enum('est','admin') NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `contenido` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;