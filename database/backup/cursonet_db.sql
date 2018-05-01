/*
 Navicat Premium Data Transfer

 Source Server         : zserver-mysql
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : cursonet_db

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 01/05/2018 19:51:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_admin
-- ----------------------------
DROP TABLE IF EXISTS `tbl_admin`;
CREATE TABLE `tbl_admin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ',
  `apellido` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ',
  `foto` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'foto del profesor/administrador',
  `user` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pass` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `es_admin` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `cursos` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT 'ids de los cursos permitidos separados por ,',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ',
  `telefono` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `fax` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fecha` datetime(0) NOT NULL,
  `sintesis` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'sistesis o CV',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user`) USING BTREE,
  INDEX `admin`(`es_admin`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de administradores y profesores\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_admin
-- ----------------------------
INSERT INTO `tbl_admin` VALUES (1, 'Luis Eduardo', 'De lima', '20114819_me1.jpg', 'delimce', '2bcd4da7472eb4fbda1beaa706780761', 1, '0', 'prof.delima@gmail.com', '04143490299', '8590299', '2015-05-18 09:40:35', 'licenciado en computación de la facultad de ciencia y tecnologia de la universidad de Carabobo \r\n2004', NULL, NULL);
INSERT INTO `tbl_admin` VALUES (2, 'Nancy', 'Tovar', '01092644_nancy.jpeg', 'nancy', 'f89cfa0844f9b919ec4ea6c564fe39cb', 0, '14,16,17,18', 'nancytovar13@gmail.com', '04143484834', '', '2018-02-23 06:19:52', '            ', NULL, NULL);
INSERT INTO `tbl_admin` VALUES (3, 'Wilmer', 'Mendoza', NULL, 'wmendoza', '827ccb0eea8a706c4c34a16891f84e7b', 0, '4,7,8', 'wilmer.mendoza@novatec.com.ve', '04165195801', '02127612401', '2014-02-15 01:29:02', '            ', NULL, NULL);
INSERT INTO `tbl_admin` VALUES (4, 'Rosangela', 'Dangelo', NULL, 'rodapa', 'bc5953883f38110501e842fb14c76d2b', 1, '0', 'rodapa@gmail.com', '', '', '2018-03-06 07:09:25', 'Administradora Cursonet', NULL, NULL);

-- ----------------------------
-- Table structure for tbl_cartelera
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cartelera`;
CREATE TABLE `tbl_cartelera`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curso_id` int(10) UNSIGNED NOT NULL,
  `grupo_id` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `mensaje` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `fecha_c` datetime(0) NOT NULL COMMENT 'fecha de creado el mensaje',
  `destaca` tinyint(1) NULL DEFAULT 0 COMMENT 'si el mensaje destaca',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `curso_id`(`curso_id`) USING BTREE,
  INDEX `grupo_id`(`grupo_id`) USING BTREE,
  CONSTRAINT `cartelera_fk` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'mensajes en la cartelera para las secciones' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_cartelera
-- ----------------------------
INSERT INTO `tbl_cartelera` VALUES (10, 14, 0, '<p><span style=\"color: #008080;\"><strong>Les deseo muchos &eacute;xitos en este semestre, como consecuencia de un trabajo productivo</strong></span></p>', '2014-11-05 10:10:49', 1);
INSERT INTO `tbl_cartelera` VALUES (11, 15, 0, '<p><strong><span style=\"color: #0000ff;\">Exitos en este nuevo semestre y trabajo productivo</span></strong></p>', '2014-11-05 10:12:09', 1);
INSERT INTO `tbl_cartelera` VALUES (12, 13, 0, '<ul>\r\n<li><strong><span style=\"color: #0000ff;\">Bienvenid@s al nuevo semestre! colaboremos,&nbsp; para que la producci&oacute;n sea exitosa!!</span></strong></li>\r\n</ul>', '2015-04-11 09:45:14', 1);
INSERT INTO `tbl_cartelera` VALUES (15, 16, 0, '<p><em><strong><span style=\"color: #008080;\">BIENVENIDOS(AS)AL INICIO DE UN NUEVO SEMESTRE CON SU COOPERACION, OBTENDREMOS EXITOS</span></strong></em></p>', '2018-02-18 11:11:24', 1);

-- ----------------------------
-- Table structure for tbl_contenido
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contenido`;
CREATE TABLE `tbl_contenido`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `curso_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `autor` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'id del autor del tema',
  `titulo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `contenido` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `borrador` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'si es un borrador  o no',
  `fecha` datetime(0) NOT NULL,
  `leido` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'cantidad de veces leido',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `fecha`(`fecha`) USING BTREE,
  INDEX `curso_id`(`curso_id`) USING BTREE,
  CONSTRAINT `contenido_fk` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de contenidos x curso\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_contenido
-- ----------------------------
INSERT INTO `tbl_contenido` VALUES (49, 13, 2, 'CAPITULO I    ', '<p><strong><span style=\"color: #0000ff;\">PORTADA</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">PLANTEAMIENTO DEL PROBLEMA</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">INTERROGANTES DE LA INVESTIGACI&Oacute;N</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">OBJETIVOS DE LA INVESTIGACI&Oacute;N</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">JUSTIFICACI&Oacute;N DE LA INVESTIGACI&Oacute;N</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">BIBLIOGRAFIA</span></strong></p>', 0, '2015-04-11 08:10:18', 126);
INSERT INTO `tbl_contenido` VALUES (50, 13, 2, 'CAPITULO II  Y III', '<p><strong><span style=\"color: #0000ff;\">PORTADA</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">MARCO TEORICO</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">ANTECEDENTES DEL PROBLEMA</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">BASES TE&Oacute;RICAS</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">OPERACIONALIZACI&Oacute;N DE VARIABLES</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">DEFINICI&Oacute;N DE T&Egrave;RMINOS</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">MARCO METODOL&Oacute;GICO</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">BIBLIOGRAFIA</span></strong></p>', 0, '2015-04-11 09:11:23', 292);
INSERT INTO `tbl_contenido` VALUES (51, 13, 2, 'ORGANIZACIÓN DE LA ASIGNATURA  ', '<p><strong><span style=\"color: #0000ff;\">PLAN DE EVALUACI&Oacute;N</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">CRONOGRAMA DE ACTIVIDADES</span></strong></p>', 0, '2015-04-11 09:13:06', 30);
INSERT INTO `tbl_contenido` VALUES (52, 14, 2, 'INVESTIGACION CIENTIFICA        ', '<p><strong><span style=\"color: #0000ff;\">INVESTIGACION CIENTIFICA. DEFINICION</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">CLASIFICACION DE LA INVESTIGACION CIENTIFICA</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">INVESTIGACION DOCUMENTAL</span></strong></p>', 0, '2017-01-23 08:20:49', 39);
INSERT INTO `tbl_contenido` VALUES (53, 14, 2, 'TRABAJOS DE INVESTIGACION      ', '<p><strong><span style=\"color: #0000ff;\">TRABAJOS DE INVESTIGACI&Oacute;N. TIPOS</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">LA MONOGRAFIA. ESTRUCTURA</span></strong></p>', 0, '2017-01-23 08:18:00', 12);
INSERT INTO `tbl_contenido` VALUES (55, 14, 2, 'ORGANIZACION DE LA ASIGNATURA    ', '<p><strong><span style=\"color: #0000ff;\">PLAN DE EVALUACI&Oacute;N</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">CRONOGRAMA DE ACTIVIDADES</span></strong></p>', 0, '2017-01-23 08:22:39', 2);
INSERT INTO `tbl_contenido` VALUES (56, 15, 2, 'INVESTIGACION EN EDUCACION MENCION QUIMICA    ', '<p><span style=\"color: #0000ff;\"><strong>INVESTIGACI&Oacute;N EDUCATIVA. DEFINICI&Oacute;N</strong></span></p>\r\n<p><span style=\"color: #0000ff;\"><strong>AN&Aacute;LISIS CR&Iacute;TICO DE LA INVESTIGACI&Oacute;N EN EDUCACI&Oacute;N EN EL CONTEXTO MUNDIAL, NACIONAL Y REGIONAL</strong></span></p>\r\n<p><span style=\"color: #0000ff;\"><strong>IDENTIFICACI&Oacute;N DE LAS AREAS Y LINEAS DE INVESTIGACI&Oacute;N DE QU&Iacute;MICA </strong></span></p>\r\n<p>&nbsp;</p>', 0, '2015-05-09 10:26:28', 445);
INSERT INTO `tbl_contenido` VALUES (57, 15, 2, 'METODOS DE INVESTIGACI0N CUANTITATIVA EN EDUCACION MENCION QUIMICA       ', '<p><strong><span style=\"color: #0000ff;\">AREAS DE LA INVESTIGACI&Oacute;N CUANTITATIVA</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">IDENTIFICACI&Oacute;N DE LAS CARACTER&Iacute;STICAS DE LA METODOLOG&Iacute;A CUANTITATIVA</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">METODO HIPOTETICO-DEDUCTIVO</span></strong></p>', 0, '2015-05-12 11:39:19', 252);
INSERT INTO `tbl_contenido` VALUES (58, 15, 2, 'MÉTODOS DE INVESTIGACIÓN CUALITATIVA EN EDUCACIÓN MENCIÓN QUÍMICA  ', '<p><strong><span style=\"color: #0000ff;\">IDENTIFICACI&Oacute;N DE LAS CARACTER&Iacute;STICAS DE LA METODOLOG&Iacute;A CUALITATIVA</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">M&Eacute;TODOS CUALITATIVOS:</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">HERMEN&Eacute;UTICO</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">FENOMENOL&Oacute;GICO</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">ETNOGR&Aacute;FICO</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">INVESTIGACI&Oacute;N ACCI&Oacute;N</span></strong></p>', 0, '2015-04-02 02:32:51', 292);
INSERT INTO `tbl_contenido` VALUES (59, 15, 2, 'TÉCNICAS E INSTRUMENTOS DE RECOLECCIÓN Y ANÁLISIS DE INFORMACIÓN  ', '<p><strong><span style=\"color: #0000ff;\">T&Eacute;CNICAS&nbsp; DE RECOLECCI&Oacute;N</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">INSTRUMENTOS DE RECOLECCI&Oacute;N</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">T&Eacute;CNICAS DE AN&Aacute;LISIS DE INFORMACI&Oacute;N</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">INSTRUMENTOS DE AN&Aacute;LISIS DE INFORMACI&Oacute;N</span></strong></p>', 0, '2015-04-02 02:34:01', 87);
INSERT INTO `tbl_contenido` VALUES (60, 15, 2, 'ETICA E INVESTIGACION EDUCATIVA    ', '<p><span style=\"color: #0000ff;\"><strong>DEONTOLOG&Iacute;A DE LA INVESTIGACION</strong></span></p>\r\n<p><span style=\"color: #0000ff;\"><strong>ESTABLECIMIENTO DE LAS NORMAS ETICAS</strong></span></p>', 0, '2015-06-25 10:03:34', 165);
INSERT INTO `tbl_contenido` VALUES (61, 15, 2, 'LA ASIGNATURA', '<p><strong><span style=\"color: #0000ff;\">PLAN DE EVALUACI&Oacute;N </span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">CRONOGRAMA DE EVALUACI&Oacute;N</span></strong></p>', 0, '2014-11-02 01:20:43', 103);
INSERT INTO `tbl_contenido` VALUES (62, 16, 2, 'Organización de la asignatura  ', '<ul>\r\n<li>Plan de evaluaci&oacute;n</li>\r\n<li>Cronograma de actividades</li>\r\n<li>Definicionesjecuci&oacute;n</li>\r\n<li>Ejecuci&oacute;n</li>\r\n</ul>', 0, '2017-10-01 02:05:47', 166);
INSERT INTO `tbl_contenido` VALUES (63, 16, 2, 'Basamento de la asignatura   ', '<ul style=\"list-style-type: circle;\">\r\n<li>Preliminares</li>\r\n<li>Tipos de ense&ntilde;anza</li>\r\n</ul>', 0, '2017-10-01 02:11:09', 1193);
INSERT INTO `tbl_contenido` VALUES (64, 16, 2, 'Planes y programas  ', '<ul>\r\n<li>Planes</li>\r\n<li>Programas</li>\r\n</ul>', 0, '2017-10-01 02:13:06', 538);
INSERT INTO `tbl_contenido` VALUES (65, 16, 2, 'Estrategias de Enseñanza y Evaluación  ', '<ul>\r\n<li>Tipos de Estrategias</li>\r\n</ul>', 0, '2017-10-01 02:17:46', 289);
INSERT INTO `tbl_contenido` VALUES (66, 16, 2, 'Propuesta  ', '<ul>\r\n<li>Propuesta</li>\r\n</ul>', 0, '2017-10-01 02:19:59', 112);
INSERT INTO `tbl_contenido` VALUES (67, 18, 2, ' AMBIENTE - ECOLOGIA - .-RECURSOS NATURALES', '<ol>\r\n<li>INVESTIGACION:</li>\r\n<li>OBSERVACION,</li>\r\n<li>DESCRIPCION,</li>\r\n<li>ANALISIS,</li>\r\n<li>EXPLICACION</li>\r\n<li>Y MODIFICACION&nbsp; &nbsp;</li>\r\n</ol>\r\n<p>&nbsp;</p>', 0, '2018-03-04 12:58:10', 46);
INSERT INTO `tbl_contenido` VALUES (68, 18, 2, 'RECURSOS NATURALES CONTAMINANTES  ', '<ol>\r\n<li>PROCESOS</li>\r\n<li>TRANSPORTE</li>\r\n<li>TRANSFORMACION DE LOS CONTAMINANTES</li>\r\n</ol>', 0, '2018-03-04 01:00:46', 3);
INSERT INTO `tbl_contenido` VALUES (69, 18, 2, 'MATERIALES QUIMICOS   ', '<p>EFECTOS DE LOS MATERIALES QUIMICOS EN EL AMBIENTE</p>', 0, '2018-03-04 01:01:36', 1);
INSERT INTO `tbl_contenido` VALUES (70, 18, 2, 'PROPUESTA', '<p>DESCRIPCION DE UNA SITUACION RELACIONADA CON EL ENTORNO Y LA QUIMICA AMBIENTAL</p>', 0, '2018-02-28 02:41:16', 1);
INSERT INTO `tbl_contenido` VALUES (71, 17, 2, 'LA ESPECIE HUMANA COMO COMPONENTE DE LA BIOSFERA', '', 0, '2018-03-10 04:10:57', 3);
INSERT INTO `tbl_contenido` VALUES (72, 17, 2, 'LA EVOLUCION Y LA RELACION: SER HUMANO- BIOSFERA', '', 0, '2018-03-10 04:16:47', 0);
INSERT INTO `tbl_contenido` VALUES (73, 17, 2, 'ECOLOGIA Y DESARROLLO DE LA SOCIEDAD MODERNA', '', 0, '2018-03-10 04:19:36', 0);

-- ----------------------------
-- Table structure for tbl_contenido_grupo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contenido_grupo`;
CREATE TABLE `tbl_contenido_grupo`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `contenido_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `grupo_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `content`(`contenido_id`) USING BTREE,
  INDEX `grupo`(`grupo_id`) USING BTREE,
  CONSTRAINT `FK_contenido_grupo_1` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_contenido_grupo_fk` FOREIGN KEY (`grupo_id`) REFERENCES `tbl_grupo` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'relacion contenidos por grupo' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_contenido_recurso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contenido_recurso`;
CREATE TABLE `tbl_contenido_recurso`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `contenido_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'id del registro del contenido',
  `recurso_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'id del registro del archivo',
  `tipo` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `contenido_id`(`contenido_id`) USING BTREE,
  INDEX `recurso_id`(`recurso_id`) USING BTREE,
  CONSTRAINT `tbl_contenido_recurso_fk` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tbl_contenido_recurso_fk1` FOREIGN KEY (`recurso_id`) REFERENCES `tbl_recurso` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 795 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de recursos x contenidos\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_contenido_recurso
-- ----------------------------
INSERT INTO `tbl_contenido_recurso` VALUES (670, 60, 167, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (671, 60, 196, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (672, 60, 197, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (673, 60, 306, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (674, 59, 246, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (675, 59, 247, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (676, 59, 249, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (677, 56, 172, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (678, 56, 173, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (695, 49, 422, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (696, 49, 445, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (697, 51, 167, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (698, 51, 177, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (699, 51, 219, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (700, 51, 220, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (701, 51, 398, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (702, 51, 422, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (703, 51, 446, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (704, 51, 447, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (705, 51, 247, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (706, 51, 249, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (712, 53, 177, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (713, 53, 310, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (714, 53, 429, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (715, 53, 434, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (716, 52, 241, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (717, 52, 247, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (735, 57, 247, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (736, 57, 249, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (737, 61, 177, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (738, 61, 219, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (739, 61, 220, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (740, 61, 429, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (741, 61, 430, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (742, 61, 450, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (743, 61, 451, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (748, 55, 167, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (749, 55, 219, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (750, 55, 220, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (764, 63, 348, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (765, 63, 368, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (766, 63, 172, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (767, 63, 217, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (768, 63, 218, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (769, 63, 350, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (770, 63, 352, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (771, 63, 397, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (772, 64, 179, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (773, 64, 188, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (774, 64, 242, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (775, 64, 243, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (776, 64, 368, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (777, 64, 350, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (778, 64, 352, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (779, 65, 180, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (780, 65, 183, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (781, 65, 366, 1);
INSERT INTO `tbl_contenido_recurso` VALUES (782, 66, 227, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (790, 62, 177, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (791, 62, 219, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (792, 62, 220, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (793, 62, 227, 0);
INSERT INTO `tbl_contenido_recurso` VALUES (794, 62, 368, 0);

-- ----------------------------
-- Table structure for tbl_curso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_curso`;
CREATE TABLE `tbl_curso`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `alias` varchar(22) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'nombre corto del curso',
  `resp` int(10) NOT NULL DEFAULT 0 COMMENT 'persona respondable',
  `fecha_creado` datetime(0) NOT NULL,
  `duracion` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'tiempo q dura',
  `descripcion` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `notas` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `alias`(`alias`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla con la informacion de los cursos (materias a dictar)\r\n' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_curso
-- ----------------------------
INSERT INTO `tbl_curso` VALUES (13, 'Seminario: Proyecto de Investigación', 'Seminario', 1, '2014-10-22 11:44:42', '1 semestre', 'Seminario: Proyecto de Investigación', '', NULL, NULL);
INSERT INTO `tbl_curso` VALUES (14, 'Técnicas Documentales', 'tecnicasDoc', 1, '2014-10-24 08:33:07', '1 semestre', 'Técnicas Documentales', '', NULL, NULL);
INSERT INTO `tbl_curso` VALUES (15, 'Investigación Educativa', 'InvestigacionE', 1, '2014-10-24 08:34:15', '1 semestre', 'Investigación Educativa', '', NULL, NULL);
INSERT INTO `tbl_curso` VALUES (16, 'Didáctica y Evaluación de la Química', 'Didáctica', 1, '2017-01-22 03:09:55', '6', '', '', NULL, NULL);
INSERT INTO `tbl_curso` VALUES (17, 'Ecología Humana', 'ecologia', 1, '2018-02-23 06:18:50', '6 meses', '', '', NULL, NULL);
INSERT INTO `tbl_curso` VALUES (18, 'Química Ambiental', 'quimica', 1, '2018-02-23 06:19:31', '6 meses', '', '', NULL, NULL);

-- ----------------------------
-- Table structure for tbl_equipo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_equipo`;
CREATE TABLE `tbl_equipo`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `grupo_id` int(10) UNSIGNED NOT NULL COMMENT 'id del grupo',
  `nombre` varchar(180) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'nombre del equipo',
  `descripcion` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `grupo_id`(`grupo_id`) USING BTREE,
  CONSTRAINT `tbl_equipo_fk` FOREIGN KEY (`grupo_id`) REFERENCES `tbl_grupo` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de equipos de secciones para proy y foros' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_equipo
-- ----------------------------
INSERT INTO `tbl_equipo` VALUES (1, 3, 'Nº 1', 'Equipo de trabajo para el proyecto de Investigacion');
INSERT INTO `tbl_equipo` VALUES (2, 3, 'Nº 2', 'integrantes del equipo del proyecto de investigacion');
INSERT INTO `tbl_equipo` VALUES (3, 3, 'Nº 3', 'Equipo de trabajo para el proyecto de Investigacion');
INSERT INTO `tbl_equipo` VALUES (4, 3, 'Nº 4', 'Equipo de trabajo para el proyecto de Investigacion');
INSERT INTO `tbl_equipo` VALUES (5, 3, 'Nº 5', 'Equipo de trabajo para el proyecto de Investigacion');
INSERT INTO `tbl_equipo` VALUES (6, 3, 'Nº 6', 'Equipo de trabajo para el proyecto de Investigacion');
INSERT INTO `tbl_equipo` VALUES (7, 3, 'Nº 7', 'Equipo de trabajo para el proyecto de Investigacion');
INSERT INTO `tbl_equipo` VALUES (8, 3, 'Nº 8', 'Equipo de trabajo para el proyecto de Investigación');
INSERT INTO `tbl_equipo` VALUES (9, 3, 'Nº 9', 'Equipo de trabajo para el proyecto de Investigacón');
INSERT INTO `tbl_equipo` VALUES (10, 3, 'Nº 10', 'Equipo de trabajo para el proyecto de Investigación');
INSERT INTO `tbl_equipo` VALUES (11, 6, '1-71', NULL);
INSERT INTO `tbl_equipo` VALUES (12, 6, '2-71', NULL);
INSERT INTO `tbl_equipo` VALUES (14, 7, '1-90', NULL);
INSERT INTO `tbl_equipo` VALUES (15, 7, '2-90', NULL);
INSERT INTO `tbl_equipo` VALUES (16, 7, '3-90', NULL);
INSERT INTO `tbl_equipo` VALUES (17, 6, '3-71', NULL);
INSERT INTO `tbl_equipo` VALUES (18, 6, 'tttt', 'dfddf');

-- ----------------------------
-- Table structure for tbl_equipo_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_equipo_estudiante`;
CREATE TABLE `tbl_equipo_estudiante`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipo_id` int(10) UNSIGNED NOT NULL,
  `est_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `equipo_id`, `est_id`) USING BTREE,
  INDEX `equipo_id`(`equipo_id`) USING BTREE,
  INDEX `est_id`(`est_id`) USING BTREE,
  CONSTRAINT `tbl_equipo_estudiante_fk` FOREIGN KEY (`equipo_id`) REFERENCES `tbl_equipo` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tbl_equipo_estudiante_fk1` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla que asocia un estudiante a un equipo' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_estudiante`;
CREATE TABLE `tbl_estudiante`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_number` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `nombre` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `apellido` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `foto` varchar(90) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'foto del estudiante',
  `sexo` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fecha_nac` datetime(0) NOT NULL,
  `telefono_p` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `telefono_c` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `email` varchar(55) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `msn` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `twitter` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `carrera` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `nivel` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `universidad` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `internet_acc` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NO',
  `internet_zona` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NINGUNA',
  `user` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pass` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fecha_creado` datetime(0) NOT NULL,
  `activo` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `clave_preg` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT 'pregunta para recordar clave de alumno',
  `clave_resp` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT 'respuesta para recordar clave de alumno',
  `api_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'token para micro servicios',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_number`(`id_number`) USING BTREE,
  INDEX `activo`(`activo`) USING BTREE,
  INDEX `user`(`user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 470 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de estudiantes de los cursos' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_estudiante
-- ----------------------------
INSERT INTO `tbl_estudiante` VALUES (444, '21457338', 'virginia', 'malpica', '25124047_virginia.jpg', 'F', '1992-08-02 23:59:59', '04124370819', '02418594430', 'malpicavirginia@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'virginiam', 'ce452432ffe7a2d1ae0bd58f9aec6878', '2018-02-22 10:28:31', 1, 'nombre de mi mama                                        ', 'deyanira', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (445, '24342082', 'Endris', 'Chirinos', '18125654_endris.jpg', 'M', '1994-11-11 23:59:59', '04128365468', '', 'endrisjavierch@gmail.com', '', '', '', '', '', 'SI', 'Cybercafe', 'Endris', '316ce8fbd3b1cb87b6ba3b11e528d96b', '2018-02-22 10:29:11', 1, 'mi identidad', 'cedula', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (446, '18646232', 'Wilcer', 'Reyes', '23031414_1504886792587.jpg', 'M', '1986-10-08 23:59:59', '02455417939', '04123472440', 'wilcereyesgv@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'wilcer', '011a85892a52fab99d5d06845f496c6e', '2018-02-22 10:30:14', 1, 'nombre de mi madre          ', 'gloria', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (447, '20785484', 'Asdrubal', 'León', '28045613_306890_10201175936667593_614901359_n_001.jpg', 'M', '1990-06-11 23:59:59', '', '04266391634', 'joseasdru_007@hotmail.com', '', '', '', '', '', 'SI', 'Hogar', 'Asdrubal', 'a0cbc7ced095df2f0aeb7913617b6964', '2018-02-22 10:31:26', 1, 'quien          ', 'yo', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (448, '20665131', 'Yosleidy', 'Colina', '25065002_FB_IMG_15196079033750672.jpg', 'F', '1993-01-01 23:59:59', '04124763529', '04124763529', 'yatahis@gmail.com', '', '', '', '', '', 'SI', 'Cybercafe', 'yatahis', 'dacaf6406791c80813711bf65531cab2', '2018-02-22 10:32:05', 1, 'nombre de mi madre          ', 'marbi', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (449, '23428078', 'Jose', 'Chinea', '25120715_18527631_1332875773462322_7036115422533104199_n.jpg', 'M', '1993-08-21 23:59:59', '04261448124', '04261448124', 'chineajose1993@gmail.com', '', '', '', '', '', 'SI', 'Cybercafe', 'chinea', 'b44f0f5001ffd18dd5e5992b4c51d6a8', '2018-02-22 10:47:48', 1, 'mi segundo nombre          ', 'ramon', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (450, '25179956', 'Eluz ', 'Pinto', '20072932_IMG_20180204_163534.jpg', 'F', '1995-12-08 23:59:59', '04263518535', '02418486880', 'pintoeluz1995@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'eluz', 'c1cd3387f128028766a7fffe8b45dc2c', '2018-02-22 10:48:35', 1, 'nombre de mama', 'carmen', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (451, '24705865', 'ysmari', 'brett', '01040535_PhotoGrid_1438092076799.jpg', 'F', '1996-01-12 23:59:59', '04244370021', '04244370021', 'ysmaribrett12@gmail.com', 'ysmaribrett12@gmail.com', '@ysma10', 'educacion', 'estudiante', 'didactica', 'SI', 'Hogar', 'ysmaribrett12', '443fbb181a901721a10be1f4deb03258', '2018-02-22 10:26:26', 1, 'lugar secreto                                        ', 'aguide', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (452, '3390809', 'coromoto', 'alvarado', NULL, 'F', '1980-01-01 23:59:59', '04264427419', 'o4264427419', 'nancytovar13@gmail.com', '', '', '', 'nancy', '', 'SI', 'Laboratorio', 'coromoto', 'dd086c49ae8ff4e7ac9ede2a47bb165c', '2018-02-22 10:27:21', 1, 'nombre de mascota', 'pinina', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (453, '14514211', 'luis ', 'DE LIMA', NULL, 'M', '1980-01-01 23:59:59', '', '', 'delimce@gmail.com', '', '', '', '', '', '', '', 'ldelima', '25d55ad283aa400af464c76d713c07ad', '2018-03-10 04:51:18', 0, 'como se llamaba mi mascota', 'pinina', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (454, '23440631', 'Angela', 'Morgado', '05042553_Screenshot_2018-03-05-17-53-48.png', 'F', '1993-12-16 23:59:59', '', '', 'Angelamorgadomedina@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'Angela1993', '1118c12d40b33ccfb5ff1880a242b9c6', '2018-03-17 03:47:04', 1, 'Película favorita', 'minions', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (455, '16447285', 'luis', 'tarazona', '14020226_lt.jpg', 'M', '1981-10-28 23:59:59', '', '', 'luistarazonac@hotmail.com', '', '', '', '', '', 'SI', 'Laboratorio', 'luistarazona', '1dd582ed071c050774b9b2b4c662dd57', '2018-03-06 04:58:07', 1, 'color favorito          ', 'azul', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (456, '10225951', 'belkis', 'torres', NULL, 'F', '1970-04-07 23:59:59', '', '', 'torres154@gmail.com', '', '', '', '', '', 'SI', 'Laboratorio', 'belkisjosefa', 'dda1e5e68b71873aec34fbf10ecc1f2b', '2018-03-06 04:50:03', 1, 'color favorito', 'azul', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (457, '24630868', 'edrys ', 'maldonado olaizola', '07051627_27624764_1864060833665263_4563755316836532938_o.jpg', 'M', '1995-03-19 23:59:59', '04161421489', '02453414730', 'edrys_maldonado@hotmail.com', '', '', '', '', '', 'SI', 'Hogar', 'edrysmaldonado16', 'e8f2165f02e67e30f1ecacf3f953d9ad', '2018-03-06 08:39:13', 1, 'nombre de mi amor                    ', 'williams', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (458, '24630400', 'maria', 'perez', NULL, 'F', '1995-02-24 23:59:59', '04244574327', '02453412444', 'mariayojhanap@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'mariaperez24', '78eadbc573e205cc06779d51315805ca', '2018-03-06 08:53:43', 1, 'nombre de mi hijo', 'juan david', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (459, '26273793', 'edimar ', 'perez', NULL, 'F', '1996-10-11 23:59:59', '04125053369', '02453415649', 'adrianaedimar@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'edimarperez11', '8ffacaf7bc9a381f2d1c0c1fd082f213', '2018-03-06 09:09:21', 1, 'nombre de mi mama', 'coro', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (460, '23417056', 'maryury', 'sanchez santamaria', NULL, 'F', '1994-09-09 23:59:59', '04125053369', '02453411145', 'maryury.9santamaria@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'maryurysantamaria1', '35338e47745c6e37daefa05acd9aa460', '2018-03-06 09:24:09', 1, 'nombre de mi mama ', 'chela', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (461, '21153806', 'eulise', 'bravo', NULL, 'M', '1993-03-28 23:59:59', '04144089975', '02416198061', 'elnnegro@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'eulisebravo28', '85195db90c34e0a75a407d14f3ab2d8d', '2018-03-07 05:54:09', 1, 'nombre de mi perro ', 'leon', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (462, '24449115', 'andri', 'aguilar', NULL, 'F', '1995-06-24 23:59:59', '04144352917', '02418921260', 'andrimar-aguilar@hotmail.com', '', '', '', '', '', 'SI', 'Hogar', 'andriaguilar24', '80217cd003576e5ae33961e62c542a48', '2018-03-07 05:58:25', 1, 'mi apodo', 'socorro', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (463, '26151930', 'ariana', 'zambrano', NULL, 'M', '1996-05-15 23:59:59', '04243418386', '', 'arianazambrano2013@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'arizambrano15', '4fe38155f2e6dfa77920fcdb0fc9aa94', '2018-03-07 06:08:37', 1, 'mi apodo', 'negra', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (464, '234322013', 'daine', 'casamayor', NULL, 'F', '1993-09-22 23:59:59', '04128815652', '', 'dainecasamayor93@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'daine1993', '9b91e4d21c951c506d7766118589cdd6', '2018-03-07 06:14:17', 1, 'mi gran amor ', 'mi hijo', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (465, '19949182', 'adriana isamar', 'ainaga villamizar', NULL, 'M', '1990-12-10 23:59:59', '04243250555', '04145862421', 'adrisainagv@gmail.com', '', '', 'distribuidora ainaga', 'administradora', 'contadora', 'SI', 'Cybercafe', 'adriana', '830e58d3d0cd66c9a4557ef4cc316ee4', '2018-03-17 03:45:03', 1, 'cual es la carrera que me gusta', 'patologia forense', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (466, '9448175', 'eglee', 'rivas', NULL, 'F', '1957-08-15 23:59:59', '04144110806', '', 'egleerivas94@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'egleerivas15', '4de8e58ebaadeb1202090dda9e617593', '2018-03-09 09:20:37', 1, 'mi apodo', 'china', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (467, '22223999', 'heixa', 'rodriguez', NULL, 'F', '1993-04-08 23:59:59', '04167348169', '', 'heixa.rdrgz@gmail.com', '', '', '', '', '', 'SI', 'Hogar', 'heixa08', 'db63adeb9311fef536cde2658183e8dd', '2018-03-09 09:46:44', 1, 'mi pasion', 'la biologia', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (468, '19322939', 'LISSETH', 'AGUERO', '12095955_26910858_10214773694636705_160143812686230382_o.jpg', 'F', '1989-05-22 23:59:59', '', '04120383005', 'joshil22@hotmail.com', '', '', '', '', '', 'NO', 'Cybercafe', 'lisaguero', '9b796a57f282e7cc4c6552d1ceb7f134', '2018-03-17 11:16:00', 1, 'nombre de mi hijo', 'miguel angel', NULL, NULL, NULL);
INSERT INTO `tbl_estudiante` VALUES (469, '20511605', 'jose', 'malave', NULL, 'M', '1990-03-02 23:59:59', '04262505938', '04144052475', 'mjose.gvf.uc052@hotmail.com', '', '', '', '', '', 'SI', 'Hogar', 'mjose220', '20447070dca2bb4fbb51912b9cbf44c4', '2018-03-12 06:06:52', 1, 'ciudad del pais origen de mama', 'guayaquil', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tbl_evaluacion
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion`;
CREATE TABLE `tbl_evaluacion`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `autor` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `nombre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `curso_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `contenido_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `grupo_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fecha` datetime(0) NOT NULL,
  `fecha_fin` datetime(0) NOT NULL,
  `npreg` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'nro de preguntas',
  `tipo` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 seleccion, 2 desarrollo',
  `nivel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 whatever, 1 easy, 2 normal, 3 hard',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `contenido`(`contenido_id`) USING BTREE,
  INDEX `curso_grupo`(`curso_id`, `grupo_id`) USING BTREE,
  CONSTRAINT `evaluacion_fk` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'tabla de evaluaciones' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_evaluacion_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion_estudiante`;
CREATE TABLE `tbl_evaluacion_estudiante`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `est_id` int(10) UNSIGNED NOT NULL,
  `eval_id` int(10) UNSIGNED NOT NULL,
  `nota` float(5, 2) NOT NULL DEFAULT -1.00,
  `correccion` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'comentario del profesor',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `est_id`(`est_id`) USING BTREE,
  INDEX `eval_id`(`eval_id`) USING BTREE,
  CONSTRAINT `evaluacion_estudiante_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `evaluacion_estudiante_fk1` FOREIGN KEY (`eval_id`) REFERENCES `tbl_evaluacion` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de notas de los estudiantes x evaluacion\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_evaluacion_pregunta
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion_pregunta`;
CREATE TABLE `tbl_evaluacion_pregunta`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `curso_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `eval_id` int(10) UNSIGNED NULL DEFAULT 0,
  `tipo` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 des, 1 seleccion',
  `pregunta` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nivel` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'nivel de complejidad, para el caso de las preguntas tipo seleccion',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `evaluacion`(`eval_id`) USING BTREE,
  INDEX `tipo`(`tipo`, `nivel`) USING BTREE,
  CONSTRAINT `FK_evaluacion_preguntas_1` FOREIGN KEY (`eval_id`) REFERENCES `tbl_evaluacion` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 10240 kB; (`eval_id`) REFER `cursonet/evaluacio' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_evaluacion_respuesta
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion_respuesta`;
CREATE TABLE `tbl_evaluacion_respuesta`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `est_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `preg_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `respuesta` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pregunta`(`est_id`) USING BTREE,
  INDEX `estudiante`(`preg_id`) USING BTREE,
  CONSTRAINT `evaluacion_respuesta_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `evaluacion_respuesta_fk1` FOREIGN KEY (`preg_id`) REFERENCES `tbl_evaluacion_pregunta` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'tabla de respuestas de los estudiantes por evaluacion\r\nrevis' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_evaluacion_respuesta_s
-- ----------------------------
DROP TABLE IF EXISTS `tbl_evaluacion_respuesta_s`;
CREATE TABLE `tbl_evaluacion_respuesta_s`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `est_id` int(10) UNSIGNED NOT NULL,
  `preg_id` int(10) UNSIGNED NOT NULL,
  `resp_opc` int(11) NOT NULL COMMENT 'opcion de la respuesta que contesto el estudiante',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `est_id`(`est_id`) USING BTREE,
  INDEX `preg_id`(`preg_id`) USING BTREE,
  CONSTRAINT `evaluacion_respuesta_s_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `evaluacion_respuesta_s_fk1` FOREIGN KEY (`preg_id`) REFERENCES `tbl_evaluacion_pregunta` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_feedback
-- ----------------------------
DROP TABLE IF EXISTS `tbl_feedback`;
CREATE TABLE `tbl_feedback`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'nombre completo',
  `perfil` enum('est','admin') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'est' COMMENT 'est o admin',
  `email` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT NULL,
  `tipo_com` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 general, 2 sugerencia, 3 bug',
  `comentario` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'el comentario',
  `pro` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'pros de la herramienta',
  `contra` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'contras de la herramienta',
  `suject_extra_info` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'informacion extra del sujeto',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `perfil`(`perfil`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de comentarios,mejoras, sugerencias o felicitaciones d' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_feedback
-- ----------------------------
INSERT INTO `tbl_feedback` VALUES (1, 'hector fernando sequera mirabal', 'est', 'hectorseq20@hotmail.com', '2008-02-26', 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tbl_foro
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro`;
CREATE TABLE `tbl_foro`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `autor` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `curso_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `contenido_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `grupo_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `equipo_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `titulo` tinytext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `resumen` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT 'breve resumen si se desea',
  `content` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fecha_post` datetime(0) NOT NULL,
  `fecha_fin` datetime(0) NOT NULL COMMENT 'fecha en que termina el tiempo para hacer post',
  `leido` smallint(6) NOT NULL DEFAULT 0 COMMENT 'campo para determinar los comentarios nuevos, por defecto el numero total de comentarios cuando se abre el foro',
  `nota` smallint(6) NOT NULL DEFAULT 0 COMMENT 'porcentaje si es 0 no es evaluado',
  `corregido` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 falta por evaluar, 1 evaluado',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `contenido_id`(`contenido_id`) USING BTREE,
  INDEX `curso_id`(`curso_id`) USING BTREE,
  CONSTRAINT `tbl_foro_ibfk_1` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'tabla de foros\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_foro
-- ----------------------------
INSERT INTO `tbl_foro` VALUES (2, 2, 13, 49, 3, 0, 'FORO Nº 1', NULL, '<table style=\"width: 100%;\" border=\"0\" cellspacing=\"4\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td>\r\n<p><strong><span style=\"color: #0000ff;\">Foro virtual sobre Planteamiento del problema, Objetivos de la Investigaci&oacute;n Generales y Espec&iacute;ficos, interrogantes de la investigaci&oacute;n. Justificaci&oacute;n. Lineas de investigaci&oacute;n</span></strong></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>', '2015-07-28 00:00:00', '2015-07-31 23:59:59', 21, 5, 0);
INSERT INTO `tbl_foro` VALUES (3, 2, 13, 50, 3, 0, 'FORO Nº 2', NULL, '<p><strong>F<span style=\"color: #0000ff;\">oro sobre Marco Te&oacute;rico, Antecedentes. Bases te&oacute;ricas, psicol&oacute;gicas y legales. Operacionalizaci&oacute;n de variables. Definici&oacute;n de T&eacute;rminos</span></strong></p>', '2015-05-11 00:00:00', '2015-05-15 23:59:59', 18, 5, 0);
INSERT INTO `tbl_foro` VALUES (4, 2, 13, 50, 3, 0, 'FORO Nº 3', NULL, '<p><span style=\"color: #0000ff;\"><strong>Foro sobre Marco Metodol&oacute;gico: tipo de estudio, nivel de la investigaci&oacute;n. Poblaci&oacute;n y Muestra. T&eacute;cnicas e instrumentos de recolecci&oacute;n de la informaci&oacute;n.&nbsp;</strong></span></p>', '2015-06-15 00:00:00', '2015-06-19 23:59:59', 18, 5, 0);
INSERT INTO `tbl_foro` VALUES (5, 2, 14, 52, 5, 0, 'Foro 2', NULL, '<p><strong><span style=\"color: #0000ff;\">&nbsp;Investigaci&oacute;n Documental</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">rango de 45 a 50 palabras,</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">no deben ser repetidos</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">&nbsp;los participantes deben colocar foto</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; solo comentarios &uacute;nicos</span></strong></p>', '2017-02-09 00:00:00', '2017-03-24 23:59:59', 4, 5, 0);
INSERT INTO `tbl_foro` VALUES (6, 2, 14, 52, 2, 0, 'FORO Nº 2', NULL, '<p><strong><span style=\"color: #0000ff;\">Centro de informaci&oacute;n documental</span></strong></p>', '2015-05-19 00:00:00', '2015-05-23 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (7, 2, 14, 52, 5, 0, 'FORO Nº 3', NULL, '<p><span style=\"color: #0000ff;\"><strong>CDI.Diferentes tipos. Caso UC</strong></span></p>', '2017-02-09 00:00:00', '2017-03-24 23:59:59', 1, 5, 0);
INSERT INTO `tbl_foro` VALUES (8, 2, 14, 52, 5, 0, 'FORO Nº 1', NULL, '<p><span style=\"color: #0000ff;\"><strong>Clasificaci&oacute;n de la Investigaci&oacute;n Cient&iacute;fica</strong></span></p>\r\n<p><span style=\"color: #0000ff;\"><strong>rango de 45 a 50 palabras, </strong></span></p>\r\n<p><span style=\"color: #0000ff;\"><strong>no deben ser repetidos </strong></span></p>\r\n<p><span style=\"color: #0000ff;\"><strong>&nbsp;los participantes deben colocar foto</strong></span></p>\r\n<p><strong><span style=\"color: #0000ff;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; solo comentarios &uacute;nicos</strong></span></strong></p>', '2017-02-09 00:00:00', '2017-03-24 23:59:59', 9, 5, 0);
INSERT INTO `tbl_foro` VALUES (9, 2, 14, 52, 1, 0, 'FORO Nº 2', NULL, '<p><strong><span style=\"color: #0000ff;\">Centro de informaci&oacute;n documental. Diferentes formas de presentaci&oacute;n de la Investigaci&oacute;n Cient&iacute;fica. Tipos y caracter&iacute;sticas</span></strong></p>', '2015-07-30 00:00:00', '2015-08-02 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (10, 2, 14, 53, 2, 0, 'FORO Nº 3', NULL, '<p><span style=\"color: #0000ff;\"><strong>Diferentes formas de presentaci&oacute;n de la Investigaci&oacute;n Cient&iacute;fica. Tipos y caracter&iacute;sticas</strong></span></p>', '2015-06-09 00:00:00', '2015-06-13 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (11, 2, 15, 56, 4, 0, 'FORO Nº 1', NULL, '<p><span style=\"color: #0000ff;\"><strong>los comentarios deben estar en el rango de las 45 a 50 palabras, </strong></span></p>\r\n<ol start=\"1\">\r\n<li><span style=\"color: #0000ff;\"><strong>no deben ser repetidos </strong></span></li>\r\n<li><span style=\"color: #0000ff;\"><strong>&nbsp;los participantes deben colocar foto</strong></span></li>\r\n<li><span style=\"color: #0000ff;\"><strong>solo comentarios &uacute;nicos</strong></span></li>\r\n</ol>\r\n<p><span style=\"color: #0000ff;\"><strong>Foro sobre las L&iacute;neas de investigaci&oacute;n relacionandolas con la situaci&oacute;n de la investigaci&oacute;n en la menci&oacute;n Qu&iacute;mica&nbsp; en el contexto mundial, nacional y regional</strong></span></p>', '2015-04-29 00:00:00', '2015-05-03 23:59:59', 14, 5, 0);
INSERT INTO `tbl_foro` VALUES (12, 2, 15, 57, 4, 0, 'FORO Nº 2', NULL, '<p><strong><span style=\"color: #0000ff;\">Foro virtual sobre m&eacute;todo Hipot&eacute;tico Deductivo. Definici&oacute;n, caracter&iacute;sticas, etapas, aportes</span></strong></p>', '2015-05-13 00:00:00', '2015-05-17 23:59:59', 22, 5, 0);
INSERT INTO `tbl_foro` VALUES (13, 2, 15, 58, 4, 0, 'FORO Nº 3', NULL, '<p><strong><span style=\"color: #0000ff;\">m&eacute;todo Hermen&eacute;utico, Fenomenol&oacute;gico, Etnogr&aacute;fico, Investigaci&oacute;n Acci&oacute;n. Definici&oacute;n, caracter&iacute;sticas, etapas, aportes.</span></strong></p>', '2015-05-20 00:00:00', '2015-05-24 23:59:59', 15, 5, 0);
INSERT INTO `tbl_foro` VALUES (14, 2, 15, 60, 4, 0, 'FORO Nº 4', NULL, '<p><span style=\"color: #0000ff;\">desarrollo de la&nbsp; conciencia &eacute;tica del docente investigador</span></p>', '2015-06-25 00:00:00', '2015-06-29 23:59:59', 13, 5, 0);
INSERT INTO `tbl_foro` VALUES (15, 2, 15, 58, 4, 0, 'Foro nº 3a', NULL, '<p><strong><span style=\"color: #0000ff;\">Aportes sobre diferencias entre el paradigma cualitativo y cuantitativo</span></strong></p>', '2015-05-27 00:00:00', '2015-06-01 23:59:59', 23, 10, 0);
INSERT INTO `tbl_foro` VALUES (17, 2, 14, 53, 5, 0, 'Foro Nº 5', NULL, '<p><strong><span style=\"color: #0000ff;\">Normas sobre los siguientes puntos:</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">Diferentes tipos de Ficha bibliografica</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">Citas con parafraseo</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">Citas textuales de mas de 40 palabras</span></strong></p>\r\n<p><strong><span style=\"color: #0000ff;\">Citas textuales hasta 40 palabras</span></strong></p>\r\n<p><span style=\"color: #0000ff;\"><strong>Toma de notas</strong></span></p>', '2017-02-14 00:00:00', '2017-03-24 23:59:59', 0, 0, 0);
INSERT INTO `tbl_foro` VALUES (18, 2, 13, 50, 3, 0, 'Foro nº 3a', NULL, '<p><strong><span style=\"color: #0000ff;\">Marco Metodol&oacute;gico. opiniones personales sobre el tema.Sustituye al conversatorio n&ordm; 3</span></strong></p>', '2015-06-22 00:00:00', '2015-06-26 23:59:59', 27, 0, 0);
INSERT INTO `tbl_foro` VALUES (19, 2, 15, 56, 4, 0, 'FORO Nº 1a', NULL, '<p><span style=\"color: #3366ff;\"><strong>Foro que sustituye a conversatorio N&ordm; 2, &nbsp;sobre el capitulo I, Planteamiento del problema, interrogantes, objetivos y justificaci&oacute;n&nbsp;</strong></span></p>', '2015-07-02 00:00:00', '2015-07-06 23:59:59', 12, 0, 0);
INSERT INTO `tbl_foro` VALUES (20, 2, 14, 53, 5, 0, 'Foro N 7', NULL, '<p><span style=\"color: #0000ff;\"><strong>&nbsp;subrayado, el resumen, esquema y mapas y su aplicaci&oacute;n en la monograf&iacute;a</strong></span></p>', '2017-02-14 00:00:00', '2017-03-24 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (21, 2, 14, 53, 5, 0, 'Foro n 6', NULL, '<p><span style=\"color: #0000ff;\"><strong>LA MONOGRAF&Iacute;A. Normas<br /></strong></span></p>', '2017-02-14 00:00:00', '2017-03-24 23:59:59', 16, 5, 0);
INSERT INTO `tbl_foro` VALUES (22, 2, 14, 53, 5, 0, 'Foro n 4', NULL, '<p>Tipos de investigaci&oacute;n</p>', '2017-02-09 00:00:00', '2017-03-24 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (23, 2, 16, 63, 0, 0, 'Foro n 3', NULL, '<p>&nbsp;Influencia de los programas de la asignatura Qu&iacute;mica en la ense&ntilde;anza y aprendizaje en Venezuela</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>&nbsp;</p>', '2018-02-19 00:00:00', '2018-04-30 23:59:59', 17, 5, 0);
INSERT INTO `tbl_foro` VALUES (24, 2, 16, 63, 0, 0, 'Foro n 2', NULL, '<p>Diferentes tipos de Ense&ntilde;anza</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>&nbsp;</p>', '2018-02-19 00:00:00', '2018-04-30 23:59:59', 24, 5, 0);
INSERT INTO `tbl_foro` VALUES (25, 2, 16, 63, 0, 0, 'Foro n 1', NULL, '<p>&nbsp;</p>\r\n<p>Definiciones relacionadas con la Did&aacute;ctica</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>&nbsp;</p>', '2018-02-19 00:00:00', '2018-04-30 23:59:59', 32, 5, 0);
INSERT INTO `tbl_foro` VALUES (26, 2, 16, 64, 0, 0, 'Foro N 4', NULL, '<p>PEIC: Proyecto Educativo Integral Comunitario</p>\r\n<p>Caracter&iacute;sticas</p>\r\n<p>Alcances</p>', '2018-03-05 00:00:00', '2018-04-30 23:59:59', 11, 5, 0);
INSERT INTO `tbl_foro` VALUES (27, 2, 16, 64, 0, 0, 'Foro N 5', NULL, '<p>Analisis de Programas Educativos de la Asignatura Quimica</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', '2018-03-05 00:00:00', '2018-04-30 23:59:59', 3, 5, 0);
INSERT INTO `tbl_foro` VALUES (28, 2, 16, 64, 0, 0, 'Foro n 6', NULL, '<p>Proyecto de Aprendizaje</p>\r\n<p>Descripcion</p>\r\n<p>Ejemplos</p>', '2018-03-05 00:00:00', '2018-04-30 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (29, 2, 16, 65, 0, 0, 'Foro N 7', NULL, '<p>Estrategias de Ense&ntilde;anza</p>\r\n<p>&nbsp;</p>', '2018-04-08 00:00:00', '2018-04-30 23:59:59', 1, 5, 0);
INSERT INTO `tbl_foro` VALUES (30, 2, 16, 65, 0, 0, 'Foro N 8', NULL, '<p>Estrategias de Evaluacion</p>', '2018-04-08 00:00:00', '2018-04-30 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (31, 2, 18, 67, 0, 0, 'foro n 1', NULL, '<p>Investigue y luego comente haciendo alusi&oacute;n a lo investigado, en acuerdo o desacuerdo,</p>\r\n<p>concepto de AMBIENTE</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', '2018-03-04 00:00:00', '2018-04-30 23:59:59', 10, 5, 0);
INSERT INTO `tbl_foro` VALUES (32, 2, 18, 67, 0, 0, 'foro n 2', NULL, '<p>nvestigue y luego comenta</p>\r\n<p>concepto de Ecologia</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>&nbsp;</p>', '2018-03-04 00:00:00', '2018-04-30 23:59:59', 7, 5, 0);
INSERT INTO `tbl_foro` VALUES (33, 2, 18, 67, 0, 0, 'foro  n 3', NULL, '<p>Investigue y luego comente haciendo alusi&oacute;n a lo investigado, en acuerdo o desacuerdo,</p>\r\n<p>concepto de Recursos Naturales</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', '2018-03-10 00:00:00', '2018-04-30 23:59:59', 6, 5, 0);
INSERT INTO `tbl_foro` VALUES (34, 2, 18, 67, 0, 0, 'foro n 4', NULL, '<p>Investigue y luego comente haciendo alusi&oacute;n a lo investigado, en acuerdo o desacuerdo,</p>\r\n<p>concepto de AMBIENTE</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>Investigue y luego comente haciendo alusi&oacute;n a lo investigado, en acuerdo o desacuerdo,</p>\r\n<p>concepto de AMBIENTE</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;Relacione los tres conceptos estudiados</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', '2018-03-04 00:00:00', '2018-04-30 23:59:59', 1, 5, 0);
INSERT INTO `tbl_foro` VALUES (35, 2, 18, 69, 0, 0, 'foro  n 5', NULL, '<p>Defina MATERIALES QUIMICOS CONTAMINANTES</p>', '2018-03-07 00:00:00', '2018-04-30 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (36, 2, 18, 70, 0, 0, 'Foro n 6', NULL, '<p>Sintesis de la propuesta</p>', '2018-03-07 00:00:00', '2018-04-30 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (37, 2, 17, 71, 9, 0, 'foro n 1', NULL, '<p><span class=\"style3\">M&oacute;dulo de discusi&oacute;n :</span>&nbsp; foro n 1</p>\r\n<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>Ecolog&iacute;a</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>Defina, con sustento bibliografico</p>\r\n<p>ECOLOGIA HUMANA</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', '2018-04-08 00:00:00', '2018-04-30 23:59:59', 2, 5, 0);
INSERT INTO `tbl_foro` VALUES (38, 2, 17, 72, 9, 0, 'foro n 2', NULL, '<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>RELACION HISTORICA DE LA EVOLUCION DEL SER HUMANO Y LA BIOSFERA</p>\r\n<p>ECOLOGIA Y EL HOMBRE</p>\r\n<p>ECOSISTEMAS HUMANIZADOS</p>', '2018-04-08 00:00:00', '2018-04-30 23:59:59', 0, 5, 0);
INSERT INTO `tbl_foro` VALUES (39, 2, 17, 73, 9, 0, 'foro  n 3', NULL, '<p>Foro de 45 a 50 palabras</p>\r\n<p>Un solo aspecto por comentario</p>\r\n<p>Un comentario por d&iacute;a</p>\r\n<p>Foto que identifique</p>\r\n<p>COMPORTAMIENTO SOCIAL HUMANO</p>\r\n<p>NIVELES HUMANIZADOS DE SOCIABILIDAD</p>\r\n<p>MODELOS DE FUTURO</p>\r\n<p>PERSPECTIVAS DE LA RAZA HUMANA</p>', '2018-04-08 00:00:00', '2018-04-30 23:59:59', 0, 5, 0);

-- ----------------------------
-- Table structure for tbl_foro_comentario
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro_comentario`;
CREATE TABLE `tbl_foro_comentario`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `foro_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `tipo_sujeto` enum('admin','est') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'est' COMMENT 'si responde un estudiante o un admin',
  `sujeto_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `content` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `fecha_post` datetime(0) NOT NULL,
  `valido` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'si es 0 no ha sido evaluado, 1 fue aceptado',
  `response` int(11) NOT NULL DEFAULT 0 COMMENT 'para saber si el coment es resp de otro post',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sujeto`(`tipo_sujeto`, `sujeto_id`) USING BTREE,
  INDEX `foro_id`(`foro_id`) USING BTREE,
  CONSTRAINT `foro_comentario_fk` FOREIGN KEY (`foro_id`) REFERENCES `tbl_foro` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1124 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'tabla de comentarios x foro' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_foro_comentario
-- ----------------------------
INSERT INTO `tbl_foro_comentario` VALUES (254, 2, 'admin', 2, '<p><span style=\"color: #0000ff;\"><strong>Buenos d&iacute;as para tod@s!</strong></span></p>', '2015-04-13 08:51:46', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (255, 2, 'est', 369, 'Según (Ramírez 1996, p.61). Los objetivos de investigación son metas que se traza el investigador en relación con los aspectos que desea indagar y conocer. Estos expresan un resultado o producto de la labor investigativa. Así Los objetivos generales son las metas centrales y los objetivos específicos expresan metas concretas', '2015-04-13 19:49:22', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (256, 2, 'est', 374, 'Rodríguez, Ochoa y Pineda (2007) señalan que la justificación de la investigación “es la explicación de las razones que motivan el estudio, sobre el soporte de los criterios de evaluación que hace relevante, importante, interesante y novedosa a la investigación” (p.48)', '2015-04-14 20:44:41', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (257, 2, 'est', 370, 'Méndez (1988), citado por Hurtado  1999)propone que para describir la situación problemática debe seguir el siguiente esquema mental de trabajo: observación, diagnóstico, pronóstico y control del pronóstico. Es de hacer notar que estos pasos no deben escribirse como títulos, pero deben estar implícitos en la redacción del planteamiento del problema.', '2015-04-15 02:36:38', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (258, 2, 'est', 375, 'En opinión, la justificación de investigación se fundamenta en describir la importancia del estudio y a quien beneficia, para resolver una problemática antes plateada. Para Arias (1999) \"Deben seÑalarse las razones por las cuales se realiza la investigación y sus posibles aportes desde el punto de vista teórico y práctico\"', '2015-04-15 07:50:43', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (259, 2, 'admin', 2, '<p><strong><span style=\"color: #ff0000;\">Buenos d&iacute;as, por favor coloquen su foto</span></strong></p>', '2015-04-15 08:15:57', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (260, 2, 'est', 375, 'En opinión, la justificación de investigación se fundamenta en describir la importancia del estudio y a quien beneficia, para resolver una problemática antes plateada. Para Arias (1999) \"Deben seÑalarse las razones por las cuales se realiza la investigación y sus posibles aportes desde el punto de vista teórico y práctico\" (p.13).', '2015-04-15 08:20:45', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (261, 2, 'est', 374, 'Rodriguez, Ochoa y Pineda (2007) señalan que la justificación de la investigación \"es la explicación de las razones que motivan el estudio, sobre el soporte de los criterios de evaluación que hace relevante, importante, interesante y novedosa a la investigación. En dos palabras, se hace ofertable\" (p.48)', '2015-04-15 08:35:16', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (262, 2, 'est', 368, 'Las líneas de investigación, orientan y plantean el grado que abarcara la investigación; El Hamra, S. Y Chacón, Y. (2010) dicen que \"permitirán analizar las necesidades de conocimientos y tecnologías para generar acciones y resolver problemáticas que afecten el entorno, contribuyendo a la alfabetización científica\"(p.1)', '2015-04-15 20:26:35', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (263, 2, 'est', 367, 'Yo opino, que los objetivos responde el para que y porque se esta realizando la investigación, los objetivos específicos son cada uno de los pasos propuestos para lograr el objetivo general, lo que quiere decir, que este  expresa el resultado que se desea alcanzar en la investigación.', '2015-04-16 04:37:01', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (264, 2, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenos d&iacute;as</span></strong></p>', '2015-04-16 09:22:04', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (265, 2, 'est', 373, 'según, Oscar A. Zapata, creador del texto Herramientas para elaborar tesis e investigaciones socio-educativas, explica la construcción del planteamiento del problema como: «La de-limitación clara y precisa del objeto de investigación. Esto es configurado en la perspectiva teórica que asumimos para tratar el problema planteado con la pregunta central».', '2015-04-16 17:49:46', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (266, 2, 'est', 372, 'Desde la visión de  Gary (2007) es  evidente que a partir de una pregunta correctamente planteada se facilita la selección del diseño de investigación apropiado, las variables en estudio, el análisis de los resultados y la generación de conclusiones.  Teniendo en cuenta siempre la actualidad, viabilidad, pertinencia y precisión.', '2015-04-16 17:58:33', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (267, 2, 'est', 375, '<p>En opini&oacute;n, la justificaci&oacute;n de investigaci&oacute;n se fundamenta en describir la importancia del estudio y a quien beneficia, para resolver una problem&aacute;tica <span style=\"background-color: #ff0000;\">plateada</span>. Para Arias (1999) \"Deben se&Ntilde;alarse las razones por las cuales se realiza la investigaci&oacute;n y sus posibles aportes desde el punto de vista te&oacute;rico y pr&aacute;ctico\" (p.13).</p>', '2015-04-16 23:06:43', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (268, 2, 'est', 366, 'Yo pienso, que la portada es el pilar fundamental de un proyecto de investigación, es decir, membrete indica la institución donde se realizo dicho trabajo, el título  proyecta el que, para que y porque de la  investigación, los autores identifican a los emisores del contenido.', '2015-04-17 04:49:56', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (269, 2, 'est', 376, 'Tamayo (2002) describe que el objetivo general \"consiste en enunciar lo que se desea conocer, lo que se desea buscar y lo que se pretende realizar en la investigacion; es decir, el enunciado claro y preciso de las metas que se persiguen en la investigacion a realizar\"(p.138)', '2015-04-17 13:42:02', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (270, 2, 'est', 383, 'la justificación de una investigación resalta el propósito que se quiere lograr con dicha investigación, pero de manera razonable, según IUTA en su blog en linea\"en la justificación de la investigación se procede a definir POR QUÉ, y PARA QUÉ se desarrolla el tema de estudio\" (s/f)', '2015-04-17 18:32:18', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (271, 2, 'est', 378, 'Según Arias (2006), un objetivo general expresa \"el fin concreto de la investigación en correspondencia directa con la formulación del problema\"  y los objetivos específicos \"indican con precisión los conceptos, variables o dimensiones que serán objeto de estudio. Se derivan del objetivo general y contribuyen al logro de éste\"', '2015-04-17 20:49:00', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (272, 11, 'est', 392, 'Debido al carácter social de la carrera Educación, existe un nexo bien estructurado entre las líneas de investigación que posee el departamento en este marco y la investigación en la mención, es por ello que se puede notar el énfasis en las líneas que destacan estrategias y aplicaciones educativas.', '2015-04-30 09:13:45', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (274, 11, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenos d&iacute;as!</span></strong></p>', '2015-04-30 09:20:23', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (275, 11, 'est', 391, '¡Amigos! Es necesario saber que una investigación se entiende como un nuevo conocimiento que incrementa los postulados teóricos de una determinada ciencia. En nuestro caso, se hace necesario que esas investigaciones se encuentren orientadas y delimitas, rol de las líneas de investigación;  y así fortalecer la ciencia de la educación.', '2015-04-30 16:55:48', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (276, 11, 'est', 395, 'En mi opinion, una linea de investigación es una secuencia a seguir, disciplinaria, para llevar un control del conocimiento que se quiere construir por el interes de una determinada area en especifico. Para Barrios (1990), es considerada como el eje ordenador de la actividad investigativa que posee una base racional', '2015-04-30 20:42:03', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (277, 11, 'est', 398, 'Se puede decir, que la investigación va mucho más allá que solo la recopilación de cierta información, debido a que también se trata del descubrimiento de nuevos conocimientos necesarios para llevar a cabo ciertos trabajos de investigación científica, tomando como guía las líneas de investigación.', '2015-04-30 20:51:18', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (278, 11, 'est', 390, 'Las líneas de investigación son parámetros concretos que proporcionan una guía para el proyecto a investigar. Estas se basan en  necesidades y posibles logros requeridos por la carrera, personalmente pienso que  las líneas de investigación de la mención química están bien logradas con temáticas acertadas ayudando a obtener mayor conocimiento.', '2015-05-01 11:54:23', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (279, 11, 'est', 394, 'Puedo decir que las lineas de investigación son pasos u orientaciones la cual esta conformada  por una temática y una subtematica así mismo , las ya mencionadas están regidas por una comisión curricular de la facultad o el departamento de dicha mención', '2015-05-01 13:55:30', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (281, 11, 'est', 399, 'Cabe decir, que la linea de investigación incluye un conjunto de proyectos de investigación en un eje temático los suficientemente amplio y con orientación disciplinaria sobre un mismo campo, para construir o planificar el conocimiento científico que permita generar corrientes de pensamientos.', '2015-05-01 23:02:38', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (285, 11, 'est', 394, 'Es importante añadir que las lineas de investigación son orientaciones u pasos los cuales  están conformada por temáticas y subtemáticas .Morles, Rojas y Vivas (1991) consideran \"las lineas de investigación un cuerpo de problemas que se ubican en torno a un eje temático común que demandan respuestas mediante la investigación\".', '2015-05-02 15:27:32', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (286, 11, 'est', 393, 'Considero que las líneas de investigación son enfoques disciplinarios, los cuales permiten englobar procesos, prácticas y perspectivas del análisis, que son necesarias porque nos guían al mejoramiento de la investigación en el área educativa;  estas líneas de investigación son sectoriales ya que son establecidas por el departamento.', '2015-05-02 16:41:34', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (288, 11, 'est', 399, 'la linea de investigación es el conjunto de ideas en un eje temático, que proporcionan el descubrimientos de nuevos conocimientos con orientación disciplinaria sobre un mismo campo especifico, en función de guía para el proyecto a investigar.', '2015-05-02 20:15:08', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (289, 11, 'est', 399, 'las lineas de investigación son medidas  especificas que sirven de guía para llevar acabo ciertos trabajos de investigación, de esta manera permitirá el incremento de nuevos conocimientos en una determinada ciencia.', '2015-05-03 09:59:35', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (291, 11, 'est', 397, 'Becerra (1994), define la línea de investigación como “el conjunto de proyectos en una o más temáticas de investigación, que permiten el estudio de problemas de diversa índole” En otras palabras es la unión de muchos puntos de interés y las investigaciones realizadas por un grupo de personas.', '2015-05-03 11:39:08', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (292, 11, 'est', 397, 'Becerra (1994), define la linea de investigacion como “el conjunto de proyectos en una o mas tematicas de investigacion, que permiten el estudio de problemas de diversa indole” Para mi criterio, no es mas que la union de muchos puntos de interes y las investigaciones realizadas por un grupo de personas.', '2015-05-03 11:50:11', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (301, 3, 'est', 374, 'Con respecto a los antecedentes de la investigación, en esta sección  “se expone el respaldo teórico que fundamenta la investigación. Éste amplia la descripción del problema, presentando inicialmente documentos que preceden, se relacionan y soportan en gran medida el desarrollo de la investigación” (Rodríguez, 2002, p.58).', '2015-05-11 07:55:32', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (302, 3, 'est', 375, 'Según Silva (2006) \" el marco teórico es una visión panorámica del contenido temático que gira alrededor del problema planteado, lo que implica la revisión de literatura especializada, revistas científicas, informes de investigación y cualquier otro medio, escrito o audiovisual, que contenga información específica sobre el tema a investigar\" (p. 64)', '2015-05-11 14:11:58', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (303, 3, 'est', 369, 'Según Bavaresco (2006) las bases teóricas tienen que ver con las teorías que brindan al investigador el apoyo dentro del conocimiento del objeto de estudio; cada problema posee algún referente teórico, lo que indica, que el investigador no puede hacer abstracción por el desconocimiento, salvo estudios soportados en investigaciones puras.', '2015-05-11 22:42:00', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (304, 3, 'est', 367, 'Según  Stracuzzi y Pestana (2010),el  marco teórico crea una   interrelación  con la investigación  fundamentándola, es decir, integra la teoría con la investigación, abordando los conceptos  de manera  coordinada y coherente fundamentales en la misma ,afrontando  el  problema con los propósitos y generar una visión completa de la temática a tratar.<br />\r\n<br />\r\n<br />', '2015-05-12 06:32:23', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (305, 3, 'est', 368, 'La operacionalización de variables consiste según Sabino, C. (1992)  “Luego de haber precisado los factores que intervienen en un problema, de haberlos definido y analizado (…). Debemos entonces organizar estas relaciones observadas, de modo tal que podamos construir un esquema coherente que nos exprese el cuadro general del problema”.', '2015-05-12 11:05:39', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (306, 3, 'est', 371, 'Según Arias (2006a), \"los antecedentes de la investigación son los avances y el estado actual del conocimiento en un área determinada y sirven de modelo o ejemplo para futuras investigaciones\" (p. 106). Es decir son todos aquellos trabajos de investigación que preceden al que se esta realizando.', '2015-05-12 14:17:07', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (307, 3, 'est', 368, 'La operacionalizaciÃ³n de variables consiste segÃºn Sabino (1992) â€œLuego de haber precisado los factores que intervienen en un problema, de haberlos definido y analizado (â€¦). Debemos entonces organizar estas relaciones observadas, de modo tal que podamos construir un esquema coherente que nos exprese el cuadro general del problemaâ€.(p.69)<br />', '2015-05-12 16:43:54', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (308, 3, 'est', 383, 'Las bases teóricas constituyen todo el trabajo de la investigación. En tal sentido, Hernandez, Fernández y Baptista (2000), destacan que el marco teórico cumple varias funciones dentro de un estudio, tales como: ayudar a prevenir errores que se han cometido en trabajos previos; orienta sobre como habrá de realizarse el estudio.(P62)', '2015-05-12 19:40:32', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (309, 3, 'est', 378, 'Según Pinto (2011) \"La operacionalizacion de las variables está estrechamente vinculada al tipo de técnica o metodología empleada para la recolección de datos, compatible con los objetivos  y el tipo de investigación, la cual pueden ser cualitativa o cuantitativa. \"', '2015-05-13 05:28:36', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (310, 12, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenos d&iacute;as!</span></strong></p>', '2015-05-13 09:34:22', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (312, 3, 'est', 366, '<br />\r\nOpino que, la definición de términos es de menester en una investigación ya que ayuda a entender al lector las palabras desconocidas sobre el tema, incentivándolo en la lectura. Por lo tanto, se comprenderá el proyecto que se va a tratar, asimilando las palabras, para una mayor retroalimentación.<br />', '2015-05-13 20:36:35', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (313, 3, 'est', 367, 'Según  Stracuzzi y Pestana (2010) ¨ el marco teórico crea una   interrelación  con la investigación  fundamentándola, integra la teoría con la investigación, abordando los conceptos  de manera  coordinada y coherente fundamentales, abordando así, el  problema con los propósitos y generar una visión  completa de la temática a tratar¨ (p .62)<br />\r\n<br />\r\n<br />', '2015-05-14 04:51:01', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (314, 3, 'est', 376, 'Según Tamayo (2002) \"en los antecedentes se trata de hacer una síntesis conceptual de las investigaciones  o trabajos realizados sobre el problema formulado, con el fin determinar el enfoque metodológico de la misma investigación\"  (p. 146). Puesto que, con los antecedentes se busca aprovechar las teorías existentes sobre el problema.', '2015-05-14 08:05:30', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (315, 3, 'est', 383, 'Las bases teÃ³ricas constituyen el trabajo de  investigaciÃ³n, Hernandez, FernÃ¡ndez y Baptista (2000), destacan que el “marco teÃ³rico cumple varias funciones dentro de un estudio, tales como: ayudar a prevenir errores que se han cometido en trabajos previos; orienta sobre como habrÃ¡ de realizarse el estudio“.(P62)', '2015-05-14 13:32:00', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (317, 12, 'est', 391, 'En la investigación cuantitativa la realidad estudiada se entiende  o conoce por medio de relaciones numéricas y se busca establecer la causas y efectos de los fenómenos para comprenderlos. Logrando así, seguir unos pasos concretos y sistemáticos para dicho objetivo; llegando a conclusiones que se pueden generalizar.', '2015-05-14 19:00:09', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (318, 3, 'est', 372, 'La definición de términos básico es el significado preciso , en el contexto a los conceptos principales en el problema formulado. Según Tamayo (1993), la definición de términos básicos \"es la aclaración del sentido en que se utilizan las palabras o conceptos empleados en la identificación y formulación del problema.\" (p. 78).', '2015-05-14 19:46:35', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (319, 3, 'est', 370, 'Yo opino, que el marco teórico referencial es de gran importancia por cuanto permite ubicar, dentro de un contexto de ideas y planteamientos el estudio que aspira realizar. cabe destacar que toda investigación debe estar apoyada por investigaciones anteriores, ya que permiten darle aun mas valor.', '2015-05-14 19:52:59', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (320, 3, 'est', 373, 'Según Fidias (1999) las bases teóricas “representan el bagaje teórico que sustenta el estudio y por supuesto debe concentrarse en los aspectos teóricos relacionados con las variables estudiadas\"(s/p). En esta sección, se contrastan las posiciones teóricas de distintos autores reconocidos y se enuncia justificadamente la postura del investigador. <br />', '2015-05-14 20:53:46', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (322, 12, 'est', 399, 'Método hipotético deductivo es la metodología por excelencia que utiliza un científico, que consiste en hacer observaciones manipulativas y análisis a partir de las cuales se formulan hipótesis que serán comprobadas mediante experimentos controlados, aunque no es la única forma de hacer ciencia es la más utilizada y valida.', '2015-05-14 21:35:00', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (323, 12, 'est', 393, 'El método deductivo va de lo general a lo específico,  parte de las premisas y llega a las conclusiones mediante ciertas reglas. Este método consiste en investigar, analizar y comprobar datos basado en los números, es el más empleado por las ciencias.', '2015-05-15 09:03:38', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (324, 12, 'est', 395, 'Este método se vale de números, estadísticas y cuantificación para la realización de una investigación, la idea que presenta es recoger datos para categorizarlos e interpretarlos, para luego estructurar  toda esta información partiendo de un hecho lógico y coherente,  y así poder plantear el problema a investigar.', '2015-05-15 09:23:43', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (326, 3, 'est', 372, 'La definiciÃ³n de tÃ©rminos bÃ¡sico es el significado preciso  de los conceptos principales en el problema formulado. SegÃºn Tamayo (1993), la definiciÃ³n de tÃ©rminos bÃ¡sicos \"es la aclaraciÃ³n del sentido en que se utilizan las palabras o conceptos empleados en la identificaciÃ³n y formulaciÃ³n del problema.\" (p. 78).', '2015-05-15 12:19:45', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (327, 12, 'est', 398, 'En mi opinión, el método hipotético deductivo es aquella metodología que partiendo de unas premisas teóricas dadas llega a unas conclusiones determinadas a través de un procedimiento cálculo formal. Por otra parte, para que pueda usarse esta metodología debe de tomarse en cuenta las fases de dicho método.', '2015-05-15 12:50:54', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (329, 12, 'est', 392, 'Ante un fenomeno existente, un investigador puede establecer una o varias hipotesis en cuanto a las razones o soluciones de tal hecho; para ello es necesario estudiar el fenomeno, de modo que la informacion recolectada muestre resultados cuantificables objetivos, que daran credibilidad tanto a la investigacion como al autor.', '2015-05-15 15:45:54', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (330, 12, 'est', 394, 'Desde mi perspectiva,  se considera un método científico cuantitativo  ya que, es un conjunto de procedimientos mediante los cuales el investigador buscar solucionar  un problema planteado, el cual se rige en  emitir hipótesis y comprobar con datos disponibles si están de acuerdo con dichas hipótesis.<br />', '2015-05-15 19:29:20', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (331, 12, 'est', 390, 'Personalmente considero la investigación cuantitativa como un método factible para el desarrollo de una problemática, ya que, esta se basa en los números para el análisis de datos e información. Además esto proporciona un gran beneficio para estudios a nivel científico, logrando así un fin idóneo del proyecto planteado.', '2015-05-15 20:17:06', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (332, 3, 'est', 378, 'Según Sabino (2003), “los antecedentes de la investigación se refieren a los estudios de investigaciones previas relacionadas con el problema planteado, es decir investigaciones realizadas anteriormente y que guardan alguna vinculación con el objeto de estudio” (p.25).', '2015-05-15 20:34:36', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (335, 12, 'est', 399, 'Según Pascual, J (1996),Es la metodología por excelencia  que utiliza un científico, que consiste en hacer observaciones  manipulativas y análisis a partir de las cuales se formula una hipótesis que serán comprobadas mediante experimentos,  aunque no es  la única forma de hacer ciencia, es la más utilizada y validad.(Pág. 9-43).', '2015-05-15 22:52:14', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (336, 12, 'est', 391, 'Profesora mi comentario es un análisis propio.', '2015-05-16 09:33:59', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (337, 12, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenos d&iacute;as!</span></strong></p>', '2015-05-16 09:37:55', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (338, 12, 'est', 391, 'Considero que la  realidad estudiada por la investigación cuantitativa se entiende o conoce por medio de relaciones numéricas y se busca establecer la causas y efectos de los fenómenos para comprenderlos. Logrando así,  seguir unos pasos concretos y sistemáticos para dicho objetivo; llegando a conclusiones que se pueden generalizar.', '2015-05-16 09:44:50', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (339, 12, 'est', 392, 'Considero que ante un fenomeno existente, un investigador puede establecer una o varias hipotesis en cuanto a las razones o soluciones de tal hecho; para ello es necesario estudiar el fenomeno, de modo que la informacion recolectada muestre resultados cuantificables objetivos, que daran credibilidad  a la investigacion y al autor.', '2015-05-16 10:08:15', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (340, 12, 'est', 395, 'En mi opinión, considero que la idea que presenta el método cuantitativo, es recoger datos para categorizarlos  e interpretarlos, luego estructurar toda esta información partiendo de un hecho lógico y así poder plantear el problema a investigar, en su realización se vale de números, estadísticas y cuantificación.', '2015-05-16 10:42:03', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (341, 12, 'est', 394, 'Desde mi perspectiva el método hipotético deductivo son  un conjunto de procedimientos mediante los cuales el investigador busca solucionar un problema planteado. Este método tiene varios pasos esenciales los cuales son: observación del fenómeno, creación de la hipótesis y verificación de la verdad de los enunciados deducidos.', '2015-05-16 10:54:43', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (342, 12, 'est', 399, 'Según Pascual (1996), Es la metodología por excelencia  que utiliza un científico, que consiste en hacer observaciones  manipulativas y análisis a partir de las cuales se formula una hipótesis que serán comprobadas mediante experimentos,  aunque no es  la única forma de hacer ciencia, es la más utilizada y validad.(Pág. 9-43).', '2015-05-16 13:38:59', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (345, 12, 'est', 397, 'En pocas palabras puedo definir este metodo como el hecho de descubrir un problema mediante la observacion de fenomenos sin explicacion, analizando los datos de la naturaleza escogiendo los esenciales y admitiendo solo hipotesis contrastables, cuya verdad o falsedad se puede demostrar experimentalmente.', '2015-05-16 18:53:25', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (346, 12, 'est', 401, 'Este método es utilizado por el investigador para hacer de su actividad una práctica científica, partiendo de la observación; para de esta manera crear una hipótesis que pueda explicar los fenómenos observados y luego realizar la comprobación o verificación de la verdad, comparando la teoría creada (hipótesis) con la experiencia.', '2015-05-16 22:39:30', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (350, 12, 'est', 394, 'Desde mi  perspectiva   lo considero un método científico cualitativo , ya que se estima como  un conjunto de procedimientos mediante el cual el investigador busca solucionar un problema planteado , además  se rige en emitir hipótesis y comprobar los datos disponibles con leyes universales establecidas.', '2015-05-17 11:08:51', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (351, 12, 'est', 397, 'En pocas palabras puedo definir el metodo hipotetico deductivo como el hecho de descubrir un problema mediante la observacion de fenomenos sin explicacion, analizando asi los datos de la naturaleza escogiendo los esenciales admitiendo solo hipotesis contrastables, es decir cuya verdad o falsedad se puede demostrar experimentalmente.', '2015-05-17 13:27:06', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (352, 12, 'est', 401, 'El mÃ©todo hipotético-deductivo es utilizado por el investigador para hacer de su actividad una prÃ¡ctica cientÃ­fica, partiendo de la observaciÃ³n; para de esta manera crear una hipÃ³tesis que explique los fenÃ³menos observados y luego realizar la comprobaciÃ³n o verificaciÃ³n de la verdad, comparando la teorÃ­a creada con la experiencia.', '2015-05-17 21:54:42', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (353, 13, 'est', 391, '¡Estimados compañeros! les refiero desde mí pensar  que el método cualitativo tiene como tarea fundamental tratar  el significado que tienen los eventos (Experiencias, actos, procesos, interacciones, realidad) desde un enfoque descriptivo, subjetivo y característico. En consecuencia, se logra comprender la realidad desde  reflexiones, interpretaciones  y conclusiones; generadas desde ese panorama.', '2015-05-20 22:21:51', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (354, 13, 'est', 395, 'En mi opinión, el método cualitativo trata de buscar ciertas cualidades en un acontecimiento dado, el ¿por qué? Y ¿cómo?, y su objetivo principal es describir dichas cualidades; no permite análisis estadístico, ni de medición, porque éste busca el entendimiento en profundidad en lugar de exactitud.', '2015-05-21 08:31:32', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (355, 13, 'est', 393, 'En mi opinión el método cualitativo se encarga de buscar el significado de las cosas, realizando registros narrativos de los fenómenos, los cuales son estudiados mediante la observación o entrevistas. Este método no realiza mediciones sino que capta las diferencias cualitativas y es utilizado particularmente en las ciencias sociales.', '2015-05-21 10:00:59', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (356, 13, 'est', 394, 'Desde mi perspectiva el método de investigación cualitativa trata de conocer los hechos, procesos, estructuras y personas es su totalidad, además tiene un enfoque humanista  y parte del mundo conocido (no de teorías).Tiene como objetivo la descripción de cualidades de un fenómeno mediante la observación no controlada.', '2015-05-21 18:20:44', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (357, 13, 'est', 392, 'En cuanto al paradigma cualitativo Cook (1986) expresa que este “postula una concepcion global fenomenologica interesada en comprender la conducta humana desde el propio marco de referencia de quien actua; fundamentado en la realidad, orientado a los descubrimientos, exploratorio, expansionista, subjetiva, orientada al proceso y propia de la antropologia social”.', '2015-05-21 20:10:08', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (358, 13, 'est', 399, 'En mi opinión el método cualitativo es una técnica  de investigación que alude a las cualidades, donde los investigadores  hacen registros narrativos de los fenómenos que son estudiados  mediante la observación participante  y las entrevistas no estructuradas, busca adquirir información en profundidad para poder comprender el comportamiento humano.', '2015-05-21 22:52:34', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (359, 13, 'est', 401, '<p>Desde mi punto de vista; la investigac&iacute;on cualitativa es un m&eacute;todo que se encuentra centrado en la fenomenolog&iacute;a y la <strong><span style=\"background-color: #ff0000;\">vomprensi&oacute;n,</span> </strong>el cual permite identificar por medio de la observaci&oacute;n la naturaleza profunda de las realidades y asi, luego realizar un registro narrativo de los datos obtenidos.</p>', '2015-05-22 09:51:37', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (360, 13, 'est', 393, 'En mi opinión el método cualitativo se encarga de buscar el significado de las cosas, realizando registros narrativos de los fenómenos; este método solo capta cualidades diferenciadoras mas no mide, es utilizado particularmente en las ciencias sociales; se basa en principios teóricos como la fenomenología, la hermenéutica, la interacción social.', '2015-05-22 13:03:28', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (361, 13, 'est', 392, 'Referente al paradigma cualitativo Cook (1986) expresa que  “postula una concepcion global fenomenologica interesada en comprender la conducta humana desde el propio marco de referencia de quien actua; fundamentado en la realidad, orientado a los descubrimientos, exploratorio, expansionista, subjetiva, orientada al proceso y propia de la antropologia social”. (p. 04)', '2015-05-22 15:29:46', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (363, 13, 'est', 394, 'Desde mi perspectiva el método de investigación cualitativo trata de conocer los hechos , procesos ,estructuras y personas en su totalidad ,además posee un enfoque humanista y parte del mundo conocido (no de teorías) , utilizando como modalidad las entrevistas y las observaciones  no controladas.', '2015-05-22 18:20:55', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (364, 13, 'est', 398, 'Personalmente considero, que la investigación cualitativa es una de las dos metodologías más usadas, la cual, busca identificar la naturaleza profunda de las realidades. Dicha investigación atraviesa diversas disciplinas y participa de una gran variedad de discursos o perspectivas teóricas y engloba numerosos métodos y estrategias de recogida de datos.', '2015-05-22 22:43:22', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (365, 13, 'est', 397, 'Entre los metodos de investigacion cuantitativa destaca la hermeneutica que desde mi punto de vista puedo definirla como un método que no es mas que la interpretacion  o discusión de los resultados que arrojen los datos que todo investigador debe realizar como cierre final de una investigacion precisa.', '2015-05-22 23:05:21', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (367, 13, 'est', 398, '<p>En mi opini&oacute;n, la investigaci&oacute;n cualitativa es uno de los dos paradigmas <strong><span style=\"background-color: #ff6600;\">m&aacute;s utilizados,</span></strong> el cual, busca identificar la naturaleza profunda de las realidades. Dicha investigaci&oacute;n atraviesa diversas disciplinas y participa de una gran variedad de discursos o perspectivas te&oacute;ricas y engloba numerosos m&eacute;todos y estrategias de recolecci&oacute;n de datos.</p>', '2015-05-23 10:29:34', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (369, 13, 'est', 401, 'Desde mi punto de vista: la investigación cualitativa es un método que se encuentra centrado en la fenomenología y la comprensión. Dicho método,  permite identificar por medio de la observación la naturaleza profunda de las realidades, tambien permite  realizar registros narrativos de los datos que se obtienen.', '2015-05-23 17:10:10', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (370, 13, 'est', 390, 'Personalmente considero  la  investigación cualitativa como aquella que busca obtener información profunda y así entender un comportamiento. De sus métodos, la IAP (Investigación Acción Participación),  puedo decir que es de los más adecuados al momento de determinar una problemática, ya que, este se aboca de manera directa con la comunidad.', '2015-05-23 17:10:27', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (375, 15, 'est', 392, 'Dentro de las diferencias que puedo observar entre cada paradigma, esta el tipo de preguntas que estos se plantean, pues el metodo cuantitativo busca resultados en torno a magnitud, es decir medir el cuanto del objeto de estudio, mientras que el cualitativo busca estudiar la descripcion y variacion del fenomeno', '2015-05-27 15:52:54', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (376, 15, 'est', 399, 'En mi opinión la  diferencia fundamental entre ambas metodologías es que la cuantitativa estudia la asociación o relación entre variables cuantificadas y la cualitativa asume la relatividad derivada de la imprescindible consideración de las características particulares de cada situación social y de la lugaridad desde donde produce conocimientos el investigador.', '2015-05-27 22:20:08', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (377, 15, 'est', 395, 'Los paradigmas cualitativo y cuantitativo se diferencian en cuanto a sus cualidades, en mi opinión, el método cuantitativo se caracteriza por recoger datos valiéndose de números, estadísticas y cuantificación, por el contrario el método cualitativo va mas allá, porque el busca analizar describir e interpretar en profundidad los datos investigados.', '2015-05-28 07:38:09', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (378, 15, 'est', 395, 'Los paradigmas cualitativo y cuantitativo se diferencian por sus cualidades, en mi opinión, el método cualitativo se caracteriza por producir información en los casos estudiados, sin generalizar ya que parte sin hipótesis, en cambio el método cuantitativo mediante esas hipótesis que puede plantearse, las verifica por el método lógico empírico.', '2015-05-28 10:36:19', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (379, 15, 'est', 393, 'Yo considero que estos dos  métodos poseen muchas diferencias, entre las cuales se encuentra la técnica de recolección de información, el cualitativo realiza observación participante, entrevista abierta y grupos de discusión, mientras que el cuantitativo realiza observación directa, no participativa, experimentación y medición de características con instrumentos.', '2015-05-28 11:24:13', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (380, 15, 'est', 394, 'Desde mi punto de vista  el método cualitativo es fenomenológico además  orienta al proceso  de investigación, asume una realidad dinámica, es holística  y  subjetivo. No obstante, el  método cualitativo es empírico analítico ya que  orienta al resultado, asume una realidad estable, es particularista  y  objetivo.', '2015-05-28 18:23:15', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (381, 15, 'est', 398, 'En cuanto a las diferencias que pueden encontrarse en ambos paradigmas, considero que: el paradigma cuantitativo aplica la deducción para llegar a una conclusión, la cual, se realiza a través de experimentación, mientras que el cualitativo, trata de identificar la naturaleza profunda de las realidades.<br />\r\n<br />', '2015-05-28 20:10:21', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (382, 15, 'est', 392, 'Bueno, el método fenomenológico buscará cómo las personas experimentan un fenómeno, por lo tanto el investigador se valdrá de datos tanto cualitativos principalmente, pero también cuantitativos. Ahora bien, aunque se valga de herramientas numéricas no significa por esto que sea un método cuantitativo, sino se enriquece por determinada herramienta.', '2015-05-28 20:23:08', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (383, 15, 'est', 399, 'En mi opinión la diferencia entre ambas metodologías es que la cuantitativa se interesa por descubrir, verificar, o identificar relaciones causales y la cualitativa asume la relatividad derivada de la imprescindible consideración de las características particulares de cada situación social y de la lugaridad desde donde produce conocimientos el investigador.', '2015-05-29 09:52:01', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (384, 15, 'est', 398, 'Considero que el paradigma cualitativo, utiliza las técnicas de observación, entrevistas y empleo de documentos para así identificar la naturaleza profunda de las realidades; cabe destacar, que dentro de este paradigma podemos encontrar el método etnográfico que es útil para la identificación observación y análisis de dichas realidades.', '2015-05-29 10:01:24', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (385, 15, 'est', 395, 'Los paradigmas cualitativo y cuantitativo se diferencian por sus cualidades, en mi opinión, el método cualitativo se caracteriza por producir información en los casos estudiados sin generalizar, y éste parte sin hipótesis, en cambio el método cuantitativo mediante esas hipótesis que puede plantearse, las verifica por el método lógico empírico.', '2015-05-29 10:10:40', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (386, 15, 'est', 390, 'Personalmente opino que estos métodos se diferencian estructuralmente, ya que, si tomamos el método cuantitativo este nos dirige de manera más directa a una respuesta, mientras que el cualitativo nos lleva a un punto más profundo entendiendo así comportamientos. También diría que su funcionalidad difiere dependiendo del área a estudiar.', '2015-05-29 15:58:59', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (387, 15, 'est', 392, 'Al estudiar la fenomenologia los problemas a nivel de comportamiento buscando interpretar y contextualizar la informacion, expreso que si se pueden llegar a generalizar las coincidencias en diferentes sujetos, solo si estos han sufrido un hecho en donde sean iguales las variables de fenomeno y contexto. Ejemplo: un robo colectivo.', '2015-05-30 12:27:39', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (388, 15, 'est', 391, 'Pienso que la investigación cuantitativa y cualitativa persiguen el mismo propósito; conocer la realidad de la manera más probable. El primero se enfoca en lo lógico y numérico, es decir, es objetivo. Pero el  cualitativo se funda en lo interpretativo, circunstancial y experimentador de los sujetos;  eso lo hace subjetivo.', '2015-05-30 12:54:25', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (389, 15, 'est', 401, '<p>El paradigma cuantitativo esta ligado a la perspectiva distributiva de la investigaci&oacute;n social, persigue la descripci&oacute;n apoyandose en t&eacute;cnicas estad&iacute;sticas (encuesta y an&aacute;lisis estad&iacute;stico). En cambio, el paradigma cualitativo esta ligado a la perspectiva estructural y <strong><span style=\"background-color: #ff6600;\">dielectica</span></strong>, basandose en t&eacute;cnicas de an&aacute;lisis del lenguaje (entrevista y grupo de discusi&oacute;n).</p>', '2015-05-30 17:51:12', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (390, 15, 'est', 397, 'De acuerdo a lo estudiado, a mi criterio una diferencia marcada entre estos 2 metodos, es que el paradigma cualitativo descubre conceptos y teorias después de recolectar los datos, mientras que el paradigma cuantitativo emplea conceptos y teorias preconcebidos para luego determinar cuales datos pueden ser recolectados y cuales no.', '2015-05-30 21:44:44', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (391, 15, 'est', 400, 'Existen ciertas diferencias entre ambas metodologías, la cualitativa está centrada en la fenomenología y comprensión es subjetiva, exploratoria, inductiva y descriptiva “no generalizable”  basada en una realidad dinámica y la cuantitativa está basada en la inducción probabilística del positivismo lógico es objetiva, confirmatoria, inferencial, deductiva “generalizable”.', '2015-06-01 09:47:36', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (392, 15, 'est', 391, 'En el carácter interpretativo hago énfasis  en lo fenomenológico, debido que tiene como objetivo entender el significado que tienen los eventos (Experiencias, procesos e interacciones) para las personas que serán estudiadas; mediante una  metodología centrada en la observación sin prejuicio, la entrevista, el diálogo narrativo; el investigador es un observador.', '2015-06-01 11:54:21', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (393, 15, 'est', 392, 'En primer lugar, la percepcion, ya que cada persona representa de manera singular su entorno, asimismo la interpretacion, debido a que nuestros conocimientos y experiencias previas nos pueden orientar en torno a situaciones puntuales, por tanto un individuo puede discrepar en un punto especifico al momento de dar un testimonio.', '2015-06-01 12:26:15', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (394, 15, 'est', 391, 'En ese sentido, la hermenéutica refleja profundamente lo interpretativo de la realidad para los sujetos;  ya que, centra su interés en el contexto histórico,  social, político,  económico y emocional de los individuos y su influencia en la percepción. En consecuencia,  comprendiendo así el desarrollo de esa realidad.', '2015-06-01 13:37:48', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (395, 15, 'est', 393, 'Yo considero que observación participante es una técnica donde el investigador aparte de observar también se involucra con lo investigado. Es una de las técnicas mas completas porque luego de realizar la observación esta plantea propuestas y soluciones; es muy utilizado por las ciencias sociales.', '2015-06-01 15:28:53', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (396, 15, 'est', 390, 'Opino que se diferencian estructuralmente, ya que, el método cuantitativo nos dirige más directamente a una respuesta por que usa magnitudes numéricas y herramientas estadísticas, mientras que el cualitativo nos lleva a un punto más profundo entendiendo así¬ comportamientos. También diría que su funcionalidad difiere dependiendo del Área a estudiar.', '2015-06-01 17:23:26', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (397, 15, 'est', 398, 'Considero que el método etnográfico, se utiliza en la descripción y análisis de un campo social específico, una escena cultural determinada (una localidad, un barrio, una práctica social, una institución u otro tipo de campo), sin perjuicio de la aplicación de otros métodos y técnicas de recolección, síntesis y análisis.', '2015-06-01 18:31:03', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (420, 4, 'est', 374, 'Para Arias (2006), las técnicas de recolección de información son \"las distintas formas o maneras de obtener la información\"(p.111), siendo ejemplos de técnicas: la observación directa,  la encuesta en sus dos modalidades: oral y escrita (cuestionario), la entrevista,  el análisis documental,  el análisis de contenidos, entre otros', '2015-06-15 11:02:37', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (421, 4, 'est', 375, 'En el marco metodolÓgico, el nivel de investigaciÓn se refiere según Arias (1999) \"al grado de profundidad con que se aborda un objeto o fenÓmeno. Aquí se indicará si se trata de una investigaciÓn exploratoria, descriptiva o explicativa. En cualquiera de los casos es recomendable justificar el nivel adoptado\". (p.19)', '2015-06-15 11:11:04', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (422, 4, 'est', 371, 'Según Arias (1999), el marco metodológico es \"el cómo se realizará el estudio para responder al problema planteado\". (Pág. 19), es decir, es cómo será sustentada dicha investigación, donde el tipo de investigación, las técnicas y procedimientos, población y muestra serán utilizados para llevar a cabo dicho estudio.', '2015-06-16 17:20:06', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (423, 4, 'est', 376, 'Para Tamayo (2002),la población incluye la totalidad de unidades de análisis o entidades de población que integran dicho fenómeno y que deben cuantificarse para un determinado estudio integrando un conjunto N de entidades que participan de una determinada característica.', '2015-06-17 10:41:50', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (424, 4, 'est', 369, 'Según Hernández. (et al.) (2005). La muestra es un subgrupo de la población sobre el cual se recolectaran datos, y tiene que definirse o delimitarse con precisión, este deberá ser representativo de dicha población. El investigador pretende que los resultados encontrados en la muestra logren extrapolarse a la población. (p.173)', '2015-06-17 21:41:35', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (425, 4, 'est', 368, 'Respecto al nivel de la investigación, se menciona que depende del tipo de investigación que se este desarrollando ademàs de la linea de investigación a la que este sujeta el estudio, según Arias (1997)“es el grado de profundidad con que se aborda un objeto o fenomeno“ (p.47)', '2015-06-18 07:25:57', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (426, 4, 'est', 383, '<p>El tipo de investigaci&oacute;n permite determinar los pasos a seguir durante el desarrollo de la investigacion, al respecto Palella y Martins (2010) &ldquo; se refiere a la clase de estudio que se va a realizar. Orienta sobre la <strong><span style=\"background-color: #ff6600;\">finalida</span> </strong>general del estudio y sobre la manera de recoger las informaciones o datos necesarios&ldquo; (p. 88)</p>', '2015-06-18 07:37:53', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (427, 4, 'est', 367, 'Según Palella y Martins (2010) “la poblaciòn en una investigación es el conjunto de unidades de las que se desea obtener información y sobre las que se van a generar conclusiones, y la muestra es la escogencia de una parte representativa de una población“(p. 105)', '2015-06-18 08:35:39', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (428, 4, 'est', 378, 'La Población según Hurtado (2000), está constituida por el conjunto de seres en los cuales se va a estudiar el evento, y que además comparten, como características comunes, los criterios de inclusión: es la población a quienes estarán referidas las conclusiones del estudio (p.124)', '2015-06-18 15:22:56', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (429, 4, 'est', 378, 'Arias (2004) define la técnica de recolección de datos como el procedimiento o forma particular de obtener datos e información (p. 65) y los instrumentos como un dispositivo o formato (en papel o digital), que se utiliza para obtener, registrar o almacenar información (p. 67)', '2015-06-18 15:37:26', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (430, 4, 'est', 370, 'En mi opinion  , el marco metodologico esta referido al conjunto de procedimientos logicos y operacionales implicitos   en todo proceso de investigacion,entre otras palabras, el fin esencial del marco metodologico se situa a través de un lenguaje claro y sencillo de los métodos e instrumentos que se emplearon.', '2015-06-18 18:10:16', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (431, 4, 'est', 372, 'La muestra es la que puede determinar la  problemática ya que es capaz de generar los datos con los cuales se identifican las fallas. Según  Tamayo, M (1997), afirma que la muestra ¨ es el grupo de individuos que se toma de la población, para estudiar un fenómeno estadístico¨ (p.38)', '2015-06-18 19:00:56', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (432, 4, 'est', 376, 'Para Tamayo (2002),la población incluye la totalidad de unidades de análisis o la población que integran dicho fenómeno y que deben cuantificarse para un determinado estudio, integrando un conjunto N de entidades que participan de una determinada característica.(p. 176).', '2015-06-18 19:28:13', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (433, 4, 'est', 370, 'En mi opinión, el marco metodológico está referido al conjunto de procedimientos lógicos y operacionales implícitos en todo proceso de investigación, entre otras palabras, el fin esencial del marco metodológico se sitúa a través de un lenguaje claro y sencillo de los métodos e instrumentos que se emplearon.', '2015-06-19 07:14:52', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (434, 4, 'est', 373, 'Segun fidias Arias (1999). Metodología consiste en una descripción sistematica y detallada de las técnicas y procedimientos que seràn utilizados. Por lo general se incluyen en el procedimiento metodológico los instrumentos y técnicas de recolección de datos y anàlisis.', '2015-06-19 13:38:21', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (435, 4, 'est', 372, 'La muestra es la que puede determinar la problemática ya que es capaz de generar los datos con los cuales se identifican las fallas. Según Tamayo (1997), afirma que la muestra ¨ es el grupo de individuos que se toma de la población, para estudiar un fenómeno estadístico¨ (p.38)<br />', '2015-06-19 14:39:59', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (436, 4, 'est', 366, 'Según RENa (2008) enfatiza que la selección de una buena técnica e instrumentos de recolección de la información para un trabajo de investigación, es necesario cuando se llega al marco metodológico porque juegan un papel importante, pues de este depende el éxito del trabajo, tomando en cuenta sus diferencias.', '2015-06-19 15:30:53', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (437, 4, 'est', 378, 'Para Arias (1999), las técnicas de recolección de datos son las distintas formas de obtener la información, ejemplo: la observación directa, la encuesta en sus dos modalidades,  el análisis documental y el contenido; los instrumentos son los medios materiales que se emplean para recoger y almacenar información. (p. 53)', '2015-06-19 19:10:32', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (438, 18, 'est', 367, 'Yo pienso, que las técnicas de una  investigación es el como, es decir, es un método eficaz para recabar información veraz y  necesaria para el desarrollo de  instrumentos metodológicos, por lo tanto  en algunos casos se emplean algunos tipos de técnicas analíticas mediante la observación y medición de datos con el fin de crear una estrategia  reflexiva y que le credibilidad a la investigación.', '2015-06-23 04:51:19', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (439, 18, 'est', 370, 'Yo pienso que el marco metodológico comprende  el conjunto de acciones destinadas a describir y analizar el fondo del problema planteado, a través de procedimientos específicos que incluye las técnicas de observación y recolección de datos, determinando el “cómo” se realizará el estudio, esta tarea consiste en hacer activa los conceptos y elementos del problema que estudiamos, al respecto  a esto Arias (2006) explica  el marco metodológico como el “Conjunto de pasos, técnicas y procedimientos que se emplean para formular y resolver problemas” (p.16). Este método se basa en la formulación de hipótesis las cuales pueden ser confirmadas o descartadas por medios de investigaciones relacionadas al problema.', '2015-06-23 08:27:53', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (440, 18, 'est', 366, 'En mi opinion el Marco Metodologico, se utiliza para tener en cuenta los pasos que se van a utilizar en la investigacion. Es decir, el metodo. De la misma manera, RENa (2008) enfatiza que es posible hablar de una metodologia de la ciencia aplicable a todos los campos del saber donde se recogen las pautas presentes en cualquier proceder cientifico para la solucion de un problema. Por otro lado, todo metodo esta compuesto por una serie de pasos para alcanzar una meta utilizando tecnicas e instrumentos para la recoleccion de la informacion.', '2015-06-23 13:15:35', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (441, 18, 'est', 371, 'En mi opinión, una técnica de recolección de datos es el (cómo) vamos a obtener esos datos, y el instrumento es el (qué) vamos a utilizar para obtener la información, como por ejemplo si mi técnica es una encuesta oral, el instrumento que utilizaría seria un grabador. Con respecto a las técnicas e instrumentos de recolección de datos, Arias (2006a) \"se entenderá por técnica, el procedimiento o forma particular de obtener datos o información\" (Pág. 68). En palabras del mismo autor, \"un instrumento de recolección de datos es cualquier recurso, dispositivo (en papel o digital) que se utiliza para obtener, registrar o almacenar información\" (Pág. 69)', '2015-06-23 17:55:15', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (442, 18, 'est', 374, 'El marco metodológico constituye la médula del estudio, es decir, responde al como se realizó el estudio. Con respecto a esto, se habla en esta sección del procedimiento general para lograr de manera precisa el objetivo de la investigación; por lo que la metodología nos presenta los métodos y técnicas que la guían, expresando concretamente, mediante un diseño, como ha de proceder el proceso investigativo.<br />\r\nComenzando generalmente por enunciar el tipo de estudio que se realizará, tomando en cuenta las preguntas de investigación, los objetivos planteados y/o las hipótesis formuladas ya que, cada tipo especifico de investigación tiene una estrategia para su tratamiento metodológico en virtud del horizonte que se prevé.       <br />', '2015-06-23 18:11:38', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (443, 18, 'est', 375, '<p>En opini&oacute;n, el marco metodol&oacute;gico es en donde se describe la profundidad y estrategia que se emplea para el abordaje de la problem&aacute;tica en la investigaci&oacute;n. Si bien, en el cap&iacute;tulo I se plante&oacute; y justific&oacute; el problema, en el cap&iacute;tulo II se establecieron las teor&iacute;as en las que se fundamenta, en el cap&iacute;tulo III basic&aacute;mente se analiza lo anterior para definir el nivel y tipo de investigaci&oacute;n, as&iacute; como las t&eacute;cnicas de recogida de informaci&oacute;n que necesita la misma. Es pues que Arias (1999) afirma que es \"...el como se realizar&aacute; el estudio para responder al problema <strong><span style=\"background-color: #ff6600;\">plateado..</span></strong>.\" (p.19) por tanto es como un pre&aacute;mbulo a la acci&oacute;n, define los &uacute;ltimos detalles para comenzar a realizar la parte pr&aacute;ctica de la investigaci&oacute;n.</p>', '2015-06-23 20:14:28', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (444, 18, 'est', 369, '<p>En mi opini&oacute;n el marco metodol&oacute;gico se refiere a como se realizara la investigaci&oacute;n ya que se fundamenta en el uso de m&eacute;todos, t&eacute;cnicas, instrumentos y estrategias; por lo tanto el dise&ntilde;o de la investigaci&oacute;n es un plan global que integra de un modo coherente, t&eacute;cnicas de recogidas de datos, an&aacute;lisis y objetivo que ayudan a observar que tan trascendental ha sido la investigaci&oacute;n , de tal modo que se deben considerar las variables del objeto en estudio y el contexto donde se realizara el trabajo.<span style=\"background-color: #ff9900;\"><strong> De esta manera es imprescindible denotar la confiabilidad y validez del instrumento al cual deben adaptarse en la naturaleza investigaci&oacute;n desarrollada.</strong></span></p>', '2015-06-23 22:26:21', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (445, 18, 'est', 372, 'En mi opinión, como casi en todo lo que hacemos en nuestra vida tiene formas, maneras y métodos de hacerlo que son eficientes y beneficiosas a los fines, la investigación no escapa a ello, en este sentido, el marco metodológico ofrece   una serie de procedimientos, técnicas, registros y reglas que permitan de una manera adecuada y sencilla alcanzar los objetivos de la investigación.', '2015-06-24 10:36:05', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (446, 18, 'est', 367, 'Yo pienso, que las técnicas de una  investigación es el como, es decir, es un método eficaz para recabar información veraz y  necesaria para el desarrollo de  instrumentos metodológicos, por lo tanto  en algunos casos se emplean algunos tipos de técnicas analíticas mediante la observación para investigar los datos necesarios, y por otra parte, la medición de antecedentes con el fin de crear una estrategia  reflexiva y que le de credibilidad a la investigación.<br />\r\n.<br />\r\n<br />', '2015-06-24 13:33:03', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (448, 18, 'est', 374, 'Una vez seleccionado el o los métodos de trabajo, es menester construir la plataforma de trabajo, para ello se diseña la investigación; el diseño de investigación es pues el soporte de trabajo que utilizará el investigador en su proceso investigativo. Sierra (1992) lo define como “la concepción de la forma de realizar la prueba que supone toda investigación científica y social, tanto en la disposición y enlace de los elementos… como en el plan a seguir en la obtención y tratamiento de los datos necesarios…”(p.124). Es decir, es un proceso activo que conduce a la especificación de la estructura metodológica que resolverá determinado problema de investigación; sirve como guía al investigador para alcanzar los objetivos y contestar las interrogantes que se han planteado. Rodríguez, Ochoa y Pineda (2006) clasifican los diseños de investigación en: Diseños fundamentados en Métodos cuantitativos (diseño experimental, no experimental) y diseños fundamentados en métodos cualitativos (estudios etnográficos, estudios de caso e investigación acción-participante).', '2015-06-24 16:18:46', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (449, 18, 'est', 368, 'En mi opinión general, el marco metodológico es la parte de la investigación que indica y describe, la manera de como se va a desarrollar el estudio es decir trata los medios, la técnica, el tipo y en que nivel se expondrá el método que se empleara para la investigación. La metodología de la investigación debe cumplir con el propósito des estudio que se este realizando.', '2015-06-24 16:53:51', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (450, 18, 'est', 376, 'En mi opinión, cuando se habla de metodología es la fuerza principal que constituye la médula de un plan, en una investigación, puesto que se refiere a la descripción de las unidades de análisis en dicha  investigación, donde se utilizan como referencia las técnicas de observación y recolección de datos, los instrumentos, los procedimientos y las técnicas de análisis, esto a su vez es de vital importancia, ya que el planteamiento de una metodología adecuada garantiza que las relaciones que se establecen y los resultados o nuevos conocimientos obtenidos tengan el máximo grado de exactitud confiabilidad para nuestra investigación.', '2015-06-24 18:17:24', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (451, 18, 'est', 375, 'También en el marco metodológico, se define la población y muestra que se va a estudiar, las cuales estan orientadas a describir a las personas, objetos e instituciones involucradas en la investigación, que los autores consideren pertinentes para emprender su trabajo y abordar la problemática .  En ello,  Morales (1994) define la población como \"...el conjunto para el cual seran válidas las conclusiones que se obtengan y la muestra un subconjunto representativo de la población...\" (p.17), es por ello, que este tópico es de suma importancia para el trabajo de investigación, porque de la eficiencia con que se delimite la población y elección de una muestra representativa se pueden obtener resultados confiables.', '2015-06-24 19:54:13', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (452, 14, 'admin', 2, '<p><strong><span style=\"color: #008080;\">Buenos d&iacute;as!!</span></strong></p>', '2015-06-25 09:50:03', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (453, 14, 'est', 392, 'Considero que una conciencia etica debe permear todos los aspectos de la investigacion, desde el hecho de plantear una investigacion que sea moralmente responsable, pasando por dar el reconocimiento literario por medio de citas a los autores, hasta presentar con tino y objetividad los resultados obtenidos sin importar cuales fueren.', '2015-06-25 10:27:11', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (454, 14, 'est', 395, 'En mi opinión, lo que busca el investigador es resolver un problema de interés, realizando investigaciones que promuevan el bienestar común, cumpliendo con las normas de la ética del investigador como lo son las institucionales y gubernamentales, además éste debe compartir y mostrar sus resultados razonablemente.', '2015-06-25 10:48:57', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (455, 14, 'est', 391, 'Desde mi perspectiva la ética en la investigación implica tomar decisiones asertivas, además,  una reflexión previa que permita tomar los elementos de la investigación con responsabilidad y honestidad.  Haciendo de los recursos un puente para presentar un material íntegro, que no se encuentre viciado de plagió y resultados alterados.', '2015-06-25 11:59:23', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (456, 18, 'est', 367, 'Yo opino que cuando se emplea la técnica mediante la observación se emplea al estar participando activamente con la población en estudio, es decir, habría una observación participante por parte del investigador lo que consiste en estar en contacto con el objeto en estudio y recabar la información necesaria y construir un diagnostico, recabando el mayor numero de datos que aporte un avance significativo a la investigación.<br />\r\n<br />', '2015-06-25 12:14:46', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (457, 14, 'est', 390, 'Personalmente puedo exponer que la ética del investigador es primordial, esta involucra realizar investigaciones que aumenten el bienestar de la población estudiada. Así como también respetar todas las leyes constitucionales que se impliquen en dicho proceso y respetar los resultados que esta investigación arroje sin alterarlos ni modificarlos para beneficio.', '2015-06-25 13:15:50', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (458, 18, 'est', 366, 'Cabe destacar que, cada tipo de investigacion tiene metodos o pasos distintos, sin embargo segun RENa(2008) pasos de los Capitulos I y II en un proyecto de investigacion son los mismos.<br />\r\nPor otro lado, los pasos utilizados en el Marco Metodologico estan constituidos por el planteamiento de la hipotesis, sus variables, la identificacion de la poblacion, la muestra de investigacion, y el analisis de los resultados obtenidos de las encuestas u observaciones.<br />\r\nEn este caso, la formulacion de hipotesis: Son guias o explcaciones del fenomeno que se quiere investigar y se plantean como afirmaciones, suposiciones o preposiciones sobre la relacion entre dos o mas variables; la seleccion de una muestra de investigacion se trata de los sujetos u objetos que seran medidos, la cual dependera del objetivo de la investigacion y del diseño de la misma de acuerdo a sus caraceristicas de contenido(sjeto u objeto) lugar (territorio especifico) y tiempo (fecha) y por ultimo la recoleccion de datos para una investigacion: 1) seleccionar el instrumento de medicion 2) aplicar el instrumento de medicion 3) preparar las mediciones obtenidas: codiicar, tabular y analizar los datos obtenidos.', '2015-06-25 15:37:42', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (459, 14, 'est', 394, 'Desde mi perspectiva la ética del docente investigador debe ser obligatoria y responsable, evitando prejuicios a personas, además busca desarrollar la sensibilidad entre los seres humanos. El investigador tiene el compromiso ético con el procedimiento, la fuente y los resultados que genere la investigación.', '2015-06-25 17:13:01', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (460, 18, 'est', 372, 'lo hacen partiendo del método que estén utilizando, ya sea el cualitativo o el cuantitativo,determinado el método se determina las técnicas y mediante el cuando metodológico o la operacionalización de las variables los indicadores de los instrumentos y así hay coherencia entre lo planificado y expuesto teóricamente y lo ejecutado.', '2015-06-25 18:04:00', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (461, 18, 'est', 368, 'En mi opinión, la metodología de la investigación cumple con el propósito del objeto de estudio, esto quiere decir que la metodología o los pasos que se emplean en el desarrollo del estudio persigue desde el principio el enfoque principal desde la cuál se abordará la idea de investigación, pero sin limitar de esta manera el profundizar o indagar en  temas que se relacionan con distintas disciplinas pero sin desviarnos del objetivo general, planteado y esperado por dar respuesta en la hipótesis formulada.  Lo que anteriormente se plantea en pocas palabras es otorgar sentido y una linea especifica y general de entendimiento más completo del fenómeno que se esta estudiando .', '2015-06-25 18:32:41', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (462, 18, 'est', 370, 'Al hablar del método me refiero  al conjunto de operaciones ordenadas con que se pretende obtener un resultado dentro de la investigación y en mi opinión la hipótesis si debe estar en todas las investigaciones porque expresa una solución  posible racional y demostrable de un problema de investigación ,y se expresa como generalización o proposición ,esta puede ser puesta a prueba para verificar su validez.', '2015-06-25 18:57:09', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (463, 18, 'est', 370, 'Y aportando mas a lo que dice mi compañera francismar, en mi opinión  relacionándolo con nuestros primeros capítulos de nuestro trabajo especial de grado  las técnicas de recolección de datos que  hemos aplicado principalmente es la observación porque nos permitió toda la  información   necesaria de manera rápida y oportuna para tratar  el problema estudio.', '2015-06-25 19:19:49', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (464, 14, 'est', 401, 'La investigación educativa, tiene como propósito realizar una transformación en la sociedad, tanto en lo social, cultural y académico. Para lograr esto, la investigación se debe  realizar con ética,  aplicando y respetando las normas y principios existentes, evitando caer en la especulación, el plagio y la manipulación de resultados.', '2015-06-25 19:22:26', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (465, 18, 'est', 378, 'Considero, que el Marco metodológico es la herramienta fundamental en la investigación, pues es donde se realizan las pruebas de las hipótesis o teorías planteadas, además permite revisar los procedimientos que van ayudar, de manera factible, a solucionar el problema expuesto.   Según el tipo de investigación, se deben seguir ciertos pasos para facilitar el estudio, como son: el tipo y diseño de la investigación,  la muestra de la población a estudiar,  el tamaño y el espacio donde se desarrollara la investigación y por último la operacionalizacion de las variables. Por lo que el Marco metodológico puede definirse como el medio que permitirá, a la investigación, dar la solución al problema de manera práctica y no solamente con teorías, manteniendo una relación con los objetivos plantados para dicha investigación.', '2015-06-25 19:43:53', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (466, 18, 'est', 369, 'En mi opinión es imprescindible denotar la validez y confiabilidad del instrumento ya que esto tiene que ver con la naturaleza del contenido de la investigación porque a partir de la variable que se desee medir mediante la recolección de datos que se hace a través de un instrumento se determina la validez tanto del criterio como del contenido; por lo cual el instrumento debe reflejar un dominio especifico del contenido por lo que cada ítems debe representar a la variable; de esta manera la confiabilidad va de la mano de las condiciones del mismo instrumento ya que este debe dar resultados similares y coherentes por lo tanto se debe tomar en cuenta si el instrumento a utilizar mide adecuadamente la variable. Cabe  destacar  que si no se demuestra la confiabilidad y valides de los resultados de la investigación esto no puede ser tomado en serio. En el mismo orden de ideas los instrumentos de medición  para representar la variable del contenido cuentan con los diversos tipos como son: los cuestionarios, la escala de medición  como (la de Likert), el análisis de contenido, la observación, las pruebas e inventarios entre otros.', '2015-06-25 21:03:16', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (467, 18, 'est', 374, 'Basándome en lo que exponen Rodríguez Ochoa y Pineda (2006) sobre el diseño de la investigación-acción participante, involucra diversos diseños que pretenden resolver problemas concretos sin generalizar, ensayando enfoques participativos de investigación acción y reflexión así como herramientas analíticas para incorporar los saberes naturales y las necesidades de los actores sociales. En esta modalidad hay una inmersión del investigador en el lugar de estudio para una profundización de lo observado y una participación activa de la comunidad para la transformación de la realidad social.<br />\r\nSe hace necesario especificar que, en este diseño de investigación, la selección de la muestra es distinta a las otras modalidades, ya que se busca calidad, por lo que se escogen personas focales  que sirven como voces objetivas al reflejar las vivencias de la comunidad que se está estudiando.<br />', '2015-06-25 21:15:50', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (468, 14, 'est', 398, 'Considero que, el Docente Investigador debe comprender que a la hora de realizar un trabajo de investigación la ética debe ir de la mano con el mismo, para así tener como resultado un trabajo netamente autentico y sincerado es decir, que el investigador no debe alterar los resultados del mismo.', '2015-06-25 21:29:11', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (469, 18, 'est', 375, 'Siguiendo la idea de lo expuesto anteriormente, es pertinente mencionar que además del marco merodológico, en el capítulo I   támbien se coloca el nivel y tipo de investigación, as í como las técnicas de recogida de información, si bien no se describe su concepto pero si se inmiscuye; un ejemplo es en el planteamiento del problema que se adelanta a escribir el tipo de investigación a abordar.', '2015-06-25 21:58:12', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (470, 18, 'est', 383, 'Pienso que los aspectos metodológicos son esenciales y cada uno de estos son fundamentales para orientar y poder cumplir con el proceso de investigación del estudio que se esta llevando a cabo.  Por cuanto esos procedimientos son los que permiten guiar cualquier proyecto educativo que se quiere realizar, una vez seleccionado y formulado el problema de investigación, así como también delimitar sus objetivos y de esta forma transformar las condiciones del acto didáctico y mejorar la calidad educativa', '2015-06-26 09:16:25', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (471, 18, 'est', 376, 'En consiguiente con lo antes expuesto, para lograr la factibilidad debe hacerse un procedimiento ordenado en nuestro proyecto de investigación, que se sigue para establecer lo significativo de los hechos y fenómenos hacia los cuales esta encaminado el interés de la investigación, lo cual  es lo que constituye la metodología, que según Tamayo (2002) \"la metodología científicamente es un procedimiento general para lograr de manera precisa el objetivo de la investigación, por lo cual nos presenta los métodos y técnicas para la realización de la investigación.\" p. 175.', '2015-06-26 09:30:03', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (472, 14, 'est', 393, 'Yo opino que el docente  a la hora de realizar una investigación debe tener en cuenta ciertas cosas como: el método, el objeto de estudio, técnicas entre otros;  además la ética juega un papel importante en la investigación y el docente debe comprender esto para realizar el trabajo con responsabilidad.', '2015-06-26 15:46:22', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (473, 18, 'est', 372, 'en mi opinión yo defino el método como una serie de pasos para alcanzar una meta. De este modo los métodos de investigación describirían los pasos para alcanzar el fin de la investigación. Estos métodos o pasos determinaran como se recogen los datos y como se analizan, lo cual llevará a las conclusiones (meta).', '2015-06-26 17:09:12', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (474, 18, 'est', 371, 'Referente a las técnicas e instrumentos de recolección de datos, en mi opinión varían de acuerdo al tipo de investigación, porque estos van a depender de la(s) variable(s) formulada(s), no es que estas técnicas e instrumentos sean menos importantes que otros, sino que deben tener una estrecha relación con dicha(s) variable(s), por ejemplo el problema formulado es la efectividad de la enseñanza experimental de la química en los estudiantes de 4º año sección \"B\" del L.B. \"Cirilo Alberto\", la variable principal es la efectividad de la enseñanza experimental, entonces la  o las técnicas e instrumentos deben estar en estrecha relación a determinar cual es esa efectividad, puede ser aplicando una encuesta escrita-cuestionario o una entrevista estructurada- guía de entrevista. Según Sabino (1996) \"...En cuanto al contenido éste queda expresado en la delimitación de los datos concretos que necesitamos conseguir; se realiza, por lo tanto, en una serie de ítems que no son otra cosa que los indicadores bajo la forma de preguntas, de elementos a observar, etc. De este modo, el instrumento sintetiza en si toda la labor previa de investigación: resume los aportes del marco teórico al seleccionar datos que corresponden a los indicadores y, por lo tanto, a las variables o conceptos utilizados; pero también expresa todo lo que tiene de específicamente empírico nuestro objeto de estudio, pues sintetiza, a través de las técnicas de recolección que emplea, el diseño concreto escogido para el trabajo.\" (Pág 156-157)', '2015-06-26 21:55:37', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (475, 14, 'est', 400, 'La ética es la obligación de una conducta correcta. Desde el punto de vista de la investigación, un acto ético se ejerce responsablemente , evitando el perjuicio a personas, que a veces se realiza inconscientemente, por estar vinculado el daño a los métodos que el investigador utiliza para sus objetivos.', '2015-06-27 14:39:01', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (476, 14, 'est', 397, 'En pocas palabras puedo definir que la etica de un investigador debe estar regida por la busqueda de la verdad y la honestidad, para que la obtencion de los resultados de la investigacion correspondan a los que se obtuvieron en el proceso, sin distorsionar  los fenómenos hallados para beneficio.', '2015-06-27 17:09:43', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (477, 14, 'est', 394, '<p>Desde mi perspectiva la &Atilde;&copy;tica del docente investigador debe ser <strong><span style=\"background-color: #ffcc00;\">obligatoria</span></strong> y responsable, evitando prejuicios a personas, adem&Atilde;&iexcl;s busca desarrollar la sensibilidad entre los seres humanos. El investigador tiene el compromiso &Atilde;&copy;tico con el procedimiento, la fuente ,los resultados y el efecto que genere la investigaci&oacute;n. </p>', '2015-06-27 17:32:32', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (478, 14, 'est', 399, 'Todo docente debe desempeñar su rol como investigador a través de la investigación educativa, que tiene el propósito de transformar  la sociedad, de esta manera el docente debe actuar en todo momento apegado a las normas éticas de su profesión, ya que este es modelo a seguir por sus estudiantes.', '2015-06-27 18:59:21', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (479, 19, 'est', 397, 'Sampier (2010)  Afirma en su libro “Metodologia de la investigación” que los objetivos de una investigacion buscan contribuir a resolver el problema, mencionandose cual es y de que manera se piensa que el estudio ayudara a resolverlo expresándose con claridad para evitar posibles desviaciones en el proceso.', '2015-07-02 19:31:25', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (480, 19, 'est', 395, 'En mi opinión, el planteamiento del problema dependerá del propósito en general y complejidad que tiene la investigación, para exponer el problema a investigar se deben hacer algunas preguntas relacionadas con el tema que se va a estudiar, teniendo en cuenta investigaciones anteriores para poderle dar profundad de estudio.', '2015-07-03 07:16:34', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (482, 19, 'est', 392, '<p>Hurtado (2008) manifiesta que en una investigacion, la justificaci&oacute;n debe responder a los por ques de la investigacion: por que ese tema, por que esos eventos de estudio, por que <strong><span style=\"background-color: #ffcc00;\">esas unidades</span></strong> esas unidades de estudio, por qu&eacute; ese contexto, por qu&eacute; ese nivel de investigaci&oacute;n.</p>', '2015-07-03 15:41:33', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (483, 19, 'est', 398, 'Hernández (2003) manifiesta  que, identifica los objetivos de la investigación como un aspecto a considerar en el planteamiento del problema junto con las preguntas de investigación. Los objetivos de la investigación tienen como finalidad de señalar lo que se pretende y a lo que se aspita en la investigación.', '2015-07-03 20:11:14', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (485, 19, 'est', 391, 'El planteamiento del problema; la justificación y los objetivos (general y específicos) son la trinidad del primer capítulo y la médula de la investigación. El primero plantea la descripción del problema; el segundo el porqué y el último la metas y propósito a cumplir. Concretar tales pilares debe ser una tarea principal, ardua y coherente.', '2015-07-04 14:36:46', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (487, 19, 'est', 394, 'Según Baptista, Hernández y Fernández  (2010) “ Plantear  del problema no es sino afinar y estructurar más formalmente la idea de la investigación “(pag36) para la realización del planteamiento del problema es fundamental delimitar , saber plasmar la idea y estar familiarizado con la investigación que desea realizar.', '2015-07-04 16:16:41', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (491, 19, 'est', 399, '<br />\r\nSegún Ferrari (2007), justificar una investigación es exponer las razones por las cuales se quiere realizar. Toda investigación debe realizarse con un propósito definido, debe explicar porque es conveniente la investigación y qué o cuáles son los beneficios que se esperan con el conocimiento obtenido. <br />', '2015-07-04 21:41:08', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (493, 19, 'est', 401, 'Baptista, Hernández y Fernández (2003) manifiesta, El capítulo I define los enfoques cuantitativo y cualitativo de la investigación. Asimismo, presenta las etapas del proceso de investigación de manera genérica  (pag 9). En consecuencia  es importante del capítulo I , ya que orienta al investigador hasta donde llegara con la investigación.<br />', '2015-07-05 13:27:17', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (494, 19, 'est', 400, 'La función del planteamiento del problema consiste en revelarle al investigador si su proyecto de investigación es viable, dentro de sus tiempos y recursos disponibles,los objetivos reflejan los propósitos reales de la investigación,y la justificación expone de manera lógica aspectos como: Propósito de la investigación,conveniencia, aportes sociales,aporte teórico,utilidad metodológica.', '2015-07-06 09:50:47', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (495, 19, 'est', 391, 'El planteamiento del problema; la justificacionn y los objetivos (general y especificos) son la trinidad del primer capítulo y la médula de la investigación. El primero plantea la descripción del problema; el segundo el porqué y el último la metas y propósito a cumplir, es mí opinión.', '2015-07-06 14:30:11', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (497, 19, 'est', 393, 'Baptista,Fernandez,Hernandez (2010) Los objetivos deben expresarse con claridsd para evitar posibles desviaciones en el proceso de investigacion; Esto quiere decir que deben senalar lo que se aspira con la investigacion y son utilizado como guia de estudio y contribuyen a la resolucion de un problema.', '2015-07-06 20:33:40', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (498, 19, 'est', 390, 'Bisquerra (2009) “hay que justificar por qué es importante que se lleve a cabo la investigación como respuesta al problema planteado. Se trata de un paso más, pero igualmente necesario, que permite calibrar tanto el valor del problema como el potencial de cualquier problema de investigación diseñado para darle respuesta”.', '2015-07-06 20:47:12', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (499, 21, 'admin', 2, '<p><span style=\"color: #0000ff;\"><strong>Buenos d&iacute;as!</strong></span></p>', '2015-07-18 09:07:55', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (500, 21, 'est', 377, 'Buenas Tardes profesora, cuando estamos realizando la introducción debemos nombrar el contenido que se va a desarrollar en la monografia ¿cierto?<br />\r\nejemplo:<br />\r\n... los bicombustibles son.....<br />\r\n-combustibles fósiles<br />\r\n-Influencia de los combustibles fosiles en el ambiente<br />\r\n-Biocombustibles mas conocidos<br />\r\n-Importancia de los biocombustibles en el medio ambiente<br />\r\n-Paises que desarrollan biocombustibles<br />\r\n¿cómo realizaría la redaccion para normbrar el contenido profe?', '2015-07-19 14:13:02', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (501, 21, 'admin', 2, '<p><span style=\"color: #0000ff;\"><strong>Buenas tardes!!</strong></span></p>', '2015-07-19 15:20:58', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (502, 21, 'admin', 2, '<p><span style=\"color: #0000ff;\"><strong>Buenos d&iacute;as!</strong></span></p>', '2015-07-20 10:33:05', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (503, 21, 'est', 380, 'Prof tengo dudas con la conclusion. usted dijo que era una conclusion personal pero no se como arrancar. tiene algun tipo de estructura? <br />\r\ny la otra preguntita prof es si hay un maximo de citas en la monografia?', '2015-07-21 08:02:39', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (504, 21, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenos d&iacute;as!</span></strong></p>', '2015-07-21 08:51:39', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (505, 21, 'admin', 2, '<p><span style=\"color: #0000ff;\"><strong>Buenos d&iacute;as!</strong></span></p>', '2015-07-22 10:19:12', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (506, 21, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenos d&iacute;as! faltan 5 dias para cerrar el ciclo de asesor&iacute;as calificadas</span></strong></p>', '2015-07-23 09:07:32', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (507, 21, 'est', 377, '<p>Buenas tardes profesora cuando vamos a hacer el desarrollo del contenido debemos colocar lo mas importante basado en nuestra monografia? Y disculpe cuando es la entrega de la misma, otra cosita cuando nos referimos a delimitar el titulo es hablar algo en especifico del tema o no?</p>', '2015-07-25 17:23:04', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (508, 21, 'est', 380, 'PROFESORA COMO ESTA? ACABO DE LEER EL COMENTARIO DE ILDEMARO Y LA VERDAD YO DESDE EL PRINCIPIO TENIA DUDAS CON MI TITULO, PODRIA CAMBIARLO DE \"LA QUIMICA Y LA COSMETOLOGIA: LOS ACEITES ESENCIALES\" A \"PROCESOS QUIMICOS DETRAS DE LA OBTENCION DE EL ACEITE ESENCIAL DE MANDARIANA\" (POR EJEMPLO? O LO DELIMITO AUN MAS HABLANDO DE UN PROCESO EN ESPECIFICO?', '2015-07-28 16:09:06', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (509, 2, 'est', 378, 'Según define Tamayo y Tamayo (1995)la elaboración o formulación del problema,  consiste en la estructuración de toda la investigación en su conjunto, de tal modo que cada una de las piezas resulte parte de un todo y que ese todo forme un cuerpo lógico de investigación.(p.65)', '2015-07-28 18:26:18', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (510, 21, 'est', 381, 'Buenas noches profesora, si voy a entregar en físico el trabajo, que día debe ser? leo que es el lunes 27, es decir, ya paso? o es el martes de la semana que viene? O hasta este viernes? respecto al trabajo, debo indicar indice de contenido? cual seria la estructura del indice? Sobre el titulo, escogimos el siguiente: PETROCASAS: USO DE LOS POLÍMEROS COMO UNA ALTERNATIVA EN LA CONSTRUCCIÓN DE VIVIENDAS. Saludos', '2015-07-28 19:20:18', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (511, 2, 'est', 375, 'Los objetivos de Investigación para Grau, Correa y Rojas (1999) \"son la guía del estudio; expresan de manera muy sintética qué se pretende con la investigación,  guardan relación directa con las actividades, comenzando con un verbo infinitivo o señalando una intención de cambio en algún aspecto de interés particular\". (p.1)', '2015-07-29 05:30:23', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (512, 21, 'admin', 2, '<p><span style=\"color: #0000ff;\"><strong>Buenos d&iacute;as, se llev&oacute; el foro de asesor&iacute;as del 28 de julio al 31 del mismo mes, ya que hab&iacute;a una pregunta que responder, cualquier duda pregunten por aqui, a mi correo o cell&nbsp;</strong></span></p>', '2015-07-29 10:40:17', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (513, 2, 'est', 371, 'Según Arias (1999) el planteamiento del problema “consiste en describir de manera amplia la situación objeto de estudio ubicándola en un contexto que permita comprender su origen y relaciones” (Pág. 9). Es decir, especificar cuál es el problema que se desea tratar ubicándolo en tiempo y espacio.', '2015-07-29 20:12:39', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (514, 21, 'est', 382, 'Buenas tardes profesora en representación del grupo conformado por dulce romero José Galea Raiza Andrade y mi persona tenemos una duda con respecto a las citas, queríamos saber si esas citas textuales tienen que regirse por las normas APA o las normas UPEL…..GRACIAS', '2015-07-30 16:32:36', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (515, 21, 'est', 382, 'Ah profe otra duda en nombre del grupo, en la conclusión de la monografía tenemos que hacer una compilación de las conclusiones de cada uno de los integrantes del grupo.', '2015-07-30 16:57:27', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (518, 21, 'est', 381, 'Buenos días, como esta profesora? Entre el material de consulta del curso, en el modulo Trabajos de Investigación, me indica la existencia de un archivo que se denomina \"normas para la monografia\" y cuando trato de acceder al archivo me indica que no se encuentra en el servidor. Cuales serian las normas a seguir? Otra cosa, la monografia que estamos realizando es sobre el uso de los polimeros en la construcción de viviendas, la conceptualización creo debe ser exacta, al conceptualizar se debe citar la fuente y si es muy larga?. Podría ampliarse la entrega hasta el lunes? La verdad es que tenemos demasiadas dudas aún, y no sabemos si estamos haciendo el trabajo correctamente.', '2015-07-31 07:37:40', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (519, 21, 'est', 381, 'Disculpe profesora, sobre la entrega hasta el lunes, no haga caso a esa pregunta, llame a Ildemaro y nos aclaro la duda mas grande que teniamos', '2015-07-31 08:07:28', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (589, 8, 'admin', 2, '<p><strong><em><span style=\"color: #0000ff;\">FELIZ NOCHE</span></em></strong></p>', '2017-02-22 20:18:54', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (594, 8, 'admin', 2, '<p><em><strong><span style=\"color: #000080;\">Feliz dia!</span></strong></em></p>', '2017-02-23 13:37:05', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (670, 8, 'admin', 2, '<p><strong><em><span style=\"color: #0000ff;\">bUENAS NOCHES</span></em></strong></p>', '2017-03-07 20:03:09', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (671, 5, 'admin', 2, '<p><em><strong><span style=\"color: #0000ff;\">BUENAS NOCHES</span></strong></em></p>', '2017-03-07 20:07:47', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (729, 8, 'admin', 2, '<p><strong><em><span style=\"color: #0000ff;\">BUENOS DIAS</span></em></strong></p>', '2017-03-14 10:06:52', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (750, 5, 'admin', 2, '<p><strong><em><span style=\"color: #0000ff;\">BUENOS DIAS</span></em></strong></p>', '2017-03-15 10:48:19', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (988, 27, 'admin', 2, '<p><span style=\"color: #0000ff;\"><strong>Buenas noches|</strong></span></p>', '2017-12-01 16:36:29', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1010, 25, 'admin', 2, '<p style=\"margin-left: 60px;\">Bienvenid|s al primer foro de la asignatura. lean y sigan las instrucciones!!</p>', '2018-02-19 08:57:25', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1011, 25, 'est', 445, 'Según Escudero (1980, 117), “Es la Ciencia que objeta la organización y orientación de situaciones de enseñanza-aprendizaje de carácter instructivo, aplicada a la formación del individuo en estrecha dependencia de su educación integral\", En  la educación  estudia e interviene en el proceso de  la formación intelectual del educando.', '2018-02-25 11:54:47', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1012, 25, 'est', 449, 'Establece Ibarra  (1965) “Que la didáctica se refiere a la dirección del aprendizaje del alumnado y tiene como objeto el estudio de los métodos, técnicas, procedimientos y formas, examinados desde un punto de vista general para lograr el desarrollo del educando y generar su desarrollo individual”', '2018-02-25 12:07:51', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1013, 25, 'est', 444, 'Según Rivilla (2009)La didáctica \"Es la disciplina de estudio fundamentada en la actividad de enseñanza en cuanto propicia el aprendizaje formativo en diversos contextos especializados en las técnicas y métodos destinados a plasmar las pautas de las teorías pedagógicas con interés de elementos y procesos que intervienen en el aprendizaje\"', '2018-02-25 12:55:04', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1014, 25, 'est', 444, 'Según Rivilla (2009) Didáctica \"Es la disciplina de estudio fundamentada en la actividad de enseñanza donde propicia el aprendizaje formativo de diversos contextos especializados en técnicas y métodos destinados a plasmar las pautas de las teorías pedagógicas con interés de elementos y procesos que intervienen en el aprendizaje\"', '2018-02-25 13:27:48', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1015, 25, 'est', 448, 'Define T.  Fernández (1999)<br />\r\n“Didáctica es una ciencia aplicada que tiene como objeto el proceso de instrucción formativa integral e integrada posibilitando la aprehensión de la cultura y el desarrollo individual y social del ser humano tomando en cuenta todos los aspectos para su desarrollo individual', '2018-02-25 18:55:39', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1016, 25, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">FELIZ NOCHE!</span></strong></p>', '2018-02-26 18:46:22', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1017, 25, 'est', 446, 'De acuerdo con Fernández/Sarramona/Tarín(2013), en su Tecnología Didáctica: “La didáctica es la rama de la pedagogía que se ocupa de orientar la acción<br />\r\neducadora sistemática, y en sentido más amplio: “Como la dirección total del<br />\r\naprendizaje” es decir, que abarca el estudio de los métodos de enseñanza y los<br />\r\nrecursos que ha de aplicar el educador o educadora para estimular positivamente el aprendizaje y la formación integral y armónica de los y las educandos”', '2018-02-27 03:28:30', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1018, 25, 'est', 444, 'Según Rivilla (2009) Didáctica \"Es la disciplina de estudio fundamentada en la actividad de enseñanza donde propicia el aprendizaje de diversos contextos especializados en técnicas y métodos destinados a plasmar las pautas de las teorías pedagógicas con interés de elementos y procesos que intervienen en el aprendizaje\"(p.7).', '2018-02-27 06:56:26', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1019, 25, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">FELIZ DIA!</span></strong></p>', '2018-02-28 09:59:14', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1020, 25, 'est', 447, '(Díaz Barriga, 1992:23). “Es una disciplina teórica, histórica y política. Tiene  carácter teórico porque responde a concepciones sobre la educación, la sociedad, el saber y la ciencia; es histórica, ya que sus propuestas responden a momentos históricos específicos y es política porque su propuesta está dentro de un proyecto social\"', '2018-02-28 15:44:03', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1021, 25, 'est', 446, 'Según Mattos(2008), sostiene que: \"La didáctica es la disciplina pedagógica de carácter práctico<br />\r\ny normativo que tiene por objeto especifico la técnica de la enseñanza, esto es,<br />\r\nla técnica de incentivar y de orientar eficazmente a sus alumnos y alumnas en el<br />\r\naprendizaje\" pag 25', '2018-03-01 03:41:31', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1022, 25, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">FELIZ TARDE</span></strong></p>', '2018-03-01 10:20:53', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1023, 25, 'est', 451, 'Según Nereci (1985). \"Es el conjunto de procedimientos y normas destinadas a dirigir el aprendizaje de la manera más eficiente que sea posible\"', '2018-03-01 15:54:26', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1024, 25, 'est', 451, 'según  Sánchez (2003) define didáctica como “la ciencia que estudia el proceso de enseñanza – aprendizaje y la fundamentación del proyecto curricular; tanto uno como otro se llevan a cabo en una realidad especifica: el aula, en la que simplemente se implementa el currículo”', '2018-03-01 16:03:45', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1025, 25, 'est', 446, 'Según Mattos(2008), sostiene : \"La didáctica es la disciplina pedagógica de carácter práctico<br />\r\ny normativo que tiene por objeto especifico la técnica de la enseñanza, esto es,<br />\r\nla técnica de incentivar y de orientar a sus estudiantes en el<br />\r\naprendizaje\" pag 25', '2018-03-02 03:51:10', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1026, 25, 'est', 450, 'Nerici  (1979:54) “La Didáctica esta constituida por un conjunto de procedimientos y normas destinados a dirigir el aprendizaje de la manera mas eficiente posible”', '2018-03-02 23:01:29', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1027, 24, 'est', 444, 'Según Ramirez (2015)\"Son actividades extensiva que los docentes de todos los niveles educativos se encuentran con procesos de enseñanzas-aprendizaje diferentes teniendo en cuenta que el docente debe ser visual explica con ilustraciones, lector-escritor con lecturas previas a clases y auditivo se manifiesta en motivación\" pag(2)', '2018-03-03 15:43:52', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1028, 24, 'admin', 2, '<p><strong>BUENOS DIAS!</strong></p>', '2018-03-04 09:02:52', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1029, 25, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">BUENOS DIAS!</span></strong></p>', '2018-03-04 09:09:21', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1030, 25, 'est', 451, 'según Sánchez (2003) define didáctica como “la ciencia que estudia el proceso de enseñanza – aprendizaje y la fundamentación del proyecto curricular; tanto uno como otro se llevan a cabo en una realidad especifica: el aula, en la que simplemente se implementa el currículo”', '2018-03-04 09:58:57', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1031, 25, 'est', 446, 'De acuerdo con Luis A de Mattos(2099:28)plantea \"La didáctica es la disciplina pedagógica de carácter práctico y normativo que tiene por objeto especifico la técnica de la enseñanza, esto es,la técnica de incentivar y de orientar eficazmente a sus estudiantes en el aprendizaje\"', '2018-03-05 08:04:11', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1032, 25, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">BUENAS TARDES!</span></strong></p>', '2018-03-05 15:05:44', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1033, 24, 'est', 446, 'Para  Dewey (2009:52) plantea “todo ser humano aprende haciendo, significando que debemos actuar de manera práctica y concreta en todos los momentos de la vida, reflejando en nuestro comportamiento las ideas, es conocido como enseñanza”. <br />\r\nPor tanto, la enseñanza de tipo  abierta, viene  centrado en intereses, necesidades y posibilidades de los alumnos<br />', '2018-03-06 20:13:28', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1034, 31, 'est', 446, 'Según  LODA(2006)señala “sistema de elementos de naturaleza física, química, biológica o socio cultural, en constante dinámica por la acción humana o natural” http://www.uc.edu.ve/mega_uc/archivos/leyes/a_ley_organica_ambiente_2007.pdf<br />\r\nEn tal sentido, ambiente es el entorno donde el ser humano se desenvuelve, desarrolla y prolonga su vida, señalando flora y fauna como elementos fundamentales de este. <br />', '2018-03-06 20:29:26', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1035, 31, 'est', 455, 'Se puede decir que el ambiente es aquel entorno o espacio donde coexisten una diversidad de organismos vivos,incluyendo recursos naturales ..', '2018-03-07 04:44:47', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1036, 24, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">BUENAS TARDES!</span></strong></p>', '2018-03-07 11:36:19', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1037, 23, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">BUENAS TARDES!</span></strong></p>', '2018-03-07 11:38:39', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1038, 25, 'admin', 2, '<div id=\"com_1037\">\r\n<p><strong><span style=\"color: #0000ff;\">BUENAS TARDES!</span></strong></p>\r\n</div>', '2018-03-07 11:40:53', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1039, 24, 'est', 446, 'Para Dewey (2009:52) plantea “todo ser humano aprende haciendo, significando que debemos actuar de manera práctica y concreta en todo momento de la vida, reflejando en nuestras ideas, es conocido como enseñanza”. <br />\r\nPor tanto, la enseñanza de tipo abierta, viene centrado en intereses, necesidades y posibilidades de los alumnos', '2018-03-07 15:59:06', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1040, 25, 'est', 448, 'Define T. Fernández (1999)<br />\r\n“Didáctica es una ciencia aplicada que tiene como objeto el proceso de instrucción formativa integral e integrada posibilitando la aprehensión de la cultura y el desarrollo individual y social del ser humano tomando en cuenta todos los aspectos para su desarrollo individual” (p.68).<br />', '2018-03-08 07:46:22', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1041, 24, 'est', 444, 'Según Monzón (2016) “Son distintas acciones del profesor provocando cambios en los educandos con el fin de un logro en función a  objetivos propuestos”, Los métodos de razonamiento siendo un número posible a utilizar en la facultad humana permitiendo resolver problemas clasificada en deductivo, inductivo y analógico. (p.7)', '2018-03-08 17:55:40', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1042, 24, 'est', 451, 'según Díaz y Hernández (1998) expresan que \"la investigación sobre estrategias de enseñanza ha abordado aspectos como el diseño y el empleo de objetivos de enseñanza, preguntas insertadas, ilustraciones, modos de respuesta, organizadores anticipados, redes semánticas, mapas conceptuales y esquemas de estructuración de textos, entre otros\".', '2018-03-09 06:37:29', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1043, 25, 'est', 450, 'Según Titone, R. (1981)\"Ciencia que debe comprender y guiar al aprendizaje integrador de la cultura y que al tiempo posibilita al hombre para incorporarse creativamente a la cultura. Disciplina científica a la que corresponde guiar la enseñanza, tiene un componente normativo que en forma de saber tecnológico pretende formular recomendaciones para guiar la acción; es prescriptiva en orden a esa acción.', '2018-03-09 12:04:18', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1044, 25, 'est', 450, 'De acuerdo con Sevillano, M. L. (2004): \"Ciencia teórico, practico, normativa que guía de forma intencional el proceso optimizador de la enseñanza y el aprendizaje, en un contexto determinado e interactivo, posibilitando la aprehensión de la cultura con el fin de conseguir el desarrollo integral del estudiante.', '2018-03-09 12:12:14', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1045, 24, 'est', 447, 'Hernández(1997:18). Señala dos dimensiones cruzadas para situar las metodologías de enseñanza. Una es el grado de objetividad del conocimiento. Situándose en  el conocimiento de tipo académico y formalizado, mientras que en el subjetivo se sitúan las experiencias o concepciones personales. Otra es la actividad del docente o alumnado.', '2018-03-09 18:34:17', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1046, 24, 'est', 445, 'Ryan y Decí (2000). La enseñanza debe ser general y los procesos deben adaptarse a la forma y facilidad del individuo para procesar la información y se realiza de manera intrínseca en las actividades escolares y convertir a los estudiantes en autores de su enseñanza y desarrollo.', '2018-03-10 14:09:32', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1047, 24, 'est', 445, 'Ryan y Decí (2000).\"La enseñanza debe ser general y los procesos deben adaptarse a la forma y facilidad del individuo para procesar la información y se realiza de manera intrínseca en las actividades escolares y convertir a los estudiantes en autores de su enseñanza y desarrollo.\"', '2018-03-10 14:22:04', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1048, 32, 'est', 446, 'para Ernst Haeckel (2009:12) define Ecología \" Ciencia que estudia las relaciones de los seres vivos entre sí y con su entorno\"<br />\r\nEn este sentido, La ecología analiza también la distribución y la abundancia de los seres vivos, es decir factores abióticos y abióticos', '2018-03-13 05:54:28', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1049, 25, 'admin', 2, '<p><span style=\"color: #0000ff;\">BUENOS DIAS!</span></p>', '2018-03-13 10:01:44', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1050, 24, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">BUENOS DIAS</span></strong></p>', '2018-03-13 11:21:08', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1051, 25, 'est', 450, 'De acuerdo con Sevillano, (2004): \"Ciencia teórico, practico, normativa que guía de forma intencional el proceso optimizador de la enseñanza y el aprendizaje, en un contexto determinado e interactivo, posibilitando la aprehensión de la cultura con el fin de conseguir el desarrollo integral del estudiante\"pag(15)', '2018-03-13 19:25:48', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1052, 24, 'est', 450, 'Según Fuentes y Álvarez, (1998: 20) señala que “Para que el estudiante aprenda es necesario que, mediante la comunicación, establezca determinadas relaciones y nexos afectivos con el contenido objeto de estudio, así mismo, tiene que comprender la estructura del contenido que sistematizará, para lograr desarrollar su propio aprendizaje.', '2018-03-13 21:38:58', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1053, 31, 'est', 455, 'El ambiente; son todos aquellos factores que nos rodean (vivientes y no vivientes) y que afectan directamente a los organismos (como nosotros). <br />\r\nEl ambiente de un niño en la ciudad de Valencia es distinto al de una niña en la ciudad de Aragua, aunque compartan algunos factores comunes, como el hecho de que ambos viven en un área urbana, pero tienen diferentes climas y vegetación, e incluso distintas condiciones culturales.<br />\r\n Es decir, el ambiente no está constituido sólo por factores físico-naturales, sino por factores sociales, económicos, culturales, históricos, etc. De ahí que no debemos confundir al ambiente, con la naturaleza, ni tampoco con la ecología y por eso es un error decir que la ecología de la Ciudad de Valencia está muy alterada, cuando lo que queremos decir es que el ambiente de la ciudad de Aragua se ha transformado completamente en menos de cincuenta años.<br />', '2018-03-14 13:46:53', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1054, 32, 'est', 455, 'Según; Edgar González-Gaudiano. (1999).Define;” La ecología como una ciencia que estudia las relaciones entre los seres vivos entre sí y las relaciones de los seres vivos con su entorno físico de materia y energía. Por ejemplo, la ecología estudia asuntos relacionados con los murciélagos y los insectos de los cuales se alimentan, pero también del beneficio que produce a los agricultores el que haya menos insectos que dañen las cosechas.”<br />\r\nhttp://anea.org.mx.<br />\r\n Entonces se puede referir que  por medio de la Ecología se puede comprender temas muy concretos como el problema de los incendios forestales en la temporada de sequias, hasta temas muy amplios como el cambio del clima planetario por la acumulación de los llamados gases de efecto invernadero y sus consecuencias en los seres vivos. <br />', '2018-03-14 13:54:31', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1055, 33, 'est', 455, 'Según; diana-ecologia805. (2011).Define a los recursos naturales como aquellos bienes materiales y servicios que proporciona la naturaleza sin alteración por parte del ser humano; y que son valiosos para las sociedades humanas por contribuir a su bienestar y desarrollo de manera directa (materias primas, minerales, alimentos) o indirecta (servicios ecológicos indispensables para la continuidad de la vida en el planeta.<br />\r\nhttp://www.zonaeconomica.com/definicion/recursos-naturales.<br />\r\nPor lo tanto los recursos naturales como el agua, el aire son prescindibles para la vida y hay que conservarlos o diseñar políticas ambientalistas en pro de su resguardo.<br />', '2018-03-14 14:10:19', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1056, 31, 'admin', 2, '<p><span style=\"color: #008080;\"><strong>BUENAS TARDES!</strong></span></p>', '2018-03-15 13:28:22', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1057, 32, 'est', 446, 'Para Ernst Haeckel (2009:12) define Ecología \" Ciencia que estudia las relaciones de los seres vivos entre sí y con su entorno\"<br />\r\nEn este sentido, La ecología analiza también la distribución y la abundancia de los seres vivos, es decir factores abióticos y abióticos como resultado de la mencionada relación.', '2018-03-16 03:32:21', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1058, 25, 'est', 451, 'Define Medina R. (1987)<br />\r\n“La Didáctica es el estudio de la educación intelectual del hombre y del conocimiento sistemático que ayuda al alumno a auto conocerse facilitándole las pautas para que elija la más adecuada para lograr su plena realización personal\" (pág.7). Es decir, una disciplina que comprende y mejora los procesos de aprendizaje.', '2018-03-16 08:03:24', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1059, 24, 'est', 445, 'López, B. (2007) Cuando estudia las características específicas de la docencia advierte que se reflejan dos modos fundamentales, dando origen a los modelos comúnmente aceptados: el modelo centrado en la enseñanza (modelo de trasmisión de información, expositivo) y el modelo centrado en el aprendizaje (modelo de facilitación del aprendizaje, interactivo).', '2018-03-16 09:26:03', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1060, 23, 'est', 446, 'Machado (2011:25) sugiere que parte del rechazo que muchas veces la asignatura provoca en los alumnos parte de que la misma se dicta desde un gran nivel de<br />\r\nabstracción teórica. <br />\r\nEn este sentido,La consideración de que los contenidos impartidos en bachillerato están muy alejados de la realidad provoca una<br />\r\ndesconexión', '2018-03-17 06:46:11', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1061, 31, 'est', 455, 'Ambiente son todos aquellos factores que nos rodean,estos pueden ser vivientes y no vivientes así como también sociales y culturales los cuales no se deben confundir con la naturaleza', '2018-03-17 10:15:23', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1062, 31, 'est', 468, 'Ambiente espacio donde se desarrolla la vida de los seres vivos y permite la interacción de los mismos. También esta conformado por elementos abióticos (sin vida) y por elementos artificiales.', '2018-03-17 11:43:22', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1063, 32, 'est', 468, 'Ernst Haeckel (1869) define Ecología \"estudio de las relaciones mutuas de los organismos con su medio ambiente físico y biótico\".', '2018-03-17 12:02:07', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1064, 31, 'admin', 2, '<p><span style=\"color: #008080;\"><strong>BUENAS TARDES</strong></span></p>', '2018-03-17 12:27:05', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1065, 32, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">MUY BUENAS TARDES</span></strong></p>', '2018-03-17 12:35:18', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1066, 33, 'est', 446, 'Andaluz Westreiche(2010:52) \"establece que los recursos naturales son todos aquellos componentes de la naturaleza susceptibles de ser aprovechados para la satisfacción de las necesidades de los seres humanos y que tienen un valor actual o potencial en el mercado, por contribuir a su bienestar y a su desarrollo de manera directa o indirecta.<br />\r\n<br />', '2018-03-17 21:02:47', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1067, 23, 'est', 444, 'Según López (2013) “El estudio de la química puesto un alto nivel de dificultad, debido a  estrategias tradicionales en el nivel universitario, aunque la conexión de la vida cotidiana y la química influye positivamente a la formación del estudio de esta ciencia para el desarrollo científico del país.” (p.364)', '2018-03-19 13:27:49', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1068, 25, 'admin', 2, '<p>BUENAS TARDES, PASADO MA&Ntilde;ANA ME OPERAN, Y SALGO DR</p>\r\n<p><strong><span style=\"color: #0000ff;\">E REPOSO, COINCIDIENDO, UNA SEMANA, CON SEMANA SANTA. USTEDES PUEDEN TRABAJAR SOBRE LAS MICROCLASES Y LA PROPUESTA PARA SU PRESENTACION</span></strong></p>', '2018-03-20 13:21:59', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1069, 24, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">E REPOSO, COINCIDIENDO, UNA SEMANA, CON SEMANA SANTA. USTEDES PUEDEN TRABAJAR SOBRE LAS MICROCLASES Y LA PROPUESTA PARA SU PRESENTACION</span></strong></p>', '2018-03-20 13:33:33', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1070, 23, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">E REPOSO, COINCIDIENDO, UNA SEMANA, CON SEMANA SANTA. USTEDES PUEDEN TRABAJAR SOBRE LAS MICROCLASES Y LA PROPUESTA PARA SU PRESENTACION</span></strong></p>', '2018-03-20 13:34:42', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1071, 26, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">E REPOSO, COINCIDIENDO, UNA SEMANA, CON SEMANA SANTA. USTEDES PUEDEN TRABAJAR SOBRE LAS MICROCLASES Y LA PROPUESTA PARA SU PRESENTACION</span></strong></p>', '2018-03-20 13:35:25', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1072, 23, 'est', 444, 'Según López (2013) El estudio de la química puesto un alto nivel de dificultad, debido a estrategias tradicionales en el nivel universitario, aunque la conexión de la vida cotidiana y la química influye positivamente a la formación del estudio de esta ciencia para el desarrollo científico del país.(p.364)<br />', '2018-03-21 09:02:34', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1073, 31, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">BUENOS DIAS!</span></strong></p>', '2018-03-21 10:44:15', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1074, 32, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">BUENOS DIAS, MA&Ntilde;ANA ME OPERAN Y SALGO DE REPOSO, APROVECHEN PARA HACER LAS INVESTIGACIONES DE LAS LECTURAS, CUALQUIER DUDA LLAMEN AL CELULAR</span></strong></p>', '2018-03-21 10:51:02', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1075, 33, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">BUENOS DIAS, MA&Ntilde;ANA ME OPERAN Y SALGO DE REPOSO, APROVECHEN PARA HACER LAS INVESTIGACIONES DE LAS LECTURAS, CUALQUIER DUDA LLAMEN AL CELULAR</span></strong></p>', '2018-03-21 10:54:00', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1076, 37, 'admin', 2, '<p><strong><span style=\"color: #008080;\">BUENOS DIAS</span></strong></p>', '2018-03-21 11:06:19', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1077, 25, 'est', 449, 'Establece Ibarra (1965) “Que la didáctica se refiere a la dirección del aprendizaje del alumnado y tiene como objeto el estudio de los métodos, técnicas, procedimientos y formas, examinados desde un punto de vista general para lograr el desarrollo del educando y generar su desarrollo individual”(P.45)<br />', '2018-03-21 15:35:50', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1078, 33, 'est', 446, 'Andaluz Westreiche(2010:52) \"establece que los recursos naturales son aquellos componentes de la naturaleza susceptibles de ser aprovechados para la satisfacción de las necesidades de los seres humanos y que tienen valor actual o potencial en el mercado, por contribuir a su bienestar y a su desarrollo de diversas maneras.', '2018-03-22 06:41:34', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1079, 26, 'est', 446, 'Según Faria (2011:35), Proyecto Educativo Integral Comunitario (PEIC), es un proyecto institucional a partir del cual  se construye, planifica y desarrollan acciones entre todos los actores que hacen vida en la institución y la comunidad.<br />\r\nEs decir, es un proceso reflexivo, participativo y abierto con los sectores del entorno educativo, en atención a las prioridades socio-comunitarias.', '2018-03-22 06:45:50', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1080, 27, 'est', 446, 'Buen dia prof. espero todo le salga bien. espero su respuesta para seguir al siguiente foro', '2018-03-22 06:46:50', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1081, 25, 'est', 451, 'De acuerdo con Medina (1987) “La Didáctica es el estudio de la educación intelectual del hombre y del conocimiento sistemático que ayuda al alumno a auto conocerse facilitándole las pautas para que elija la más adecuada para lograr su plena realización personal y ser un mejor individuo\" (pág.7).', '2018-03-22 07:08:10', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1082, 23, 'est', 447, 'Machado (2006:45) es necesario que los docentes puedan articular la vida cotidiana con el mundo submicroscópico de la química, a fin de que el conocimiento transmitido sea necesario, comprensible y útil; porque  aquello que los alumnos no pueden comprender terminarán aprendiéndolo de memoria a fin de aprobar la asignatura.', '2018-03-22 08:06:46', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1083, 26, 'est', 446, 'Según Faria (2011:35), Proyecto Educativo Integral Comunitario (PEIC), es un proyecto institucional a partir del cual se construye, planifica y desarrollan acciones entre todos los actores que hacen vida en la institución y la comunidad.<br />\r\nEs decir, es un proceso reflexivo, participativo y abierto con los sectores del entorno educativo, en atención a las prioridades socio-comunitarias.<br />\r\nCaracterísticas:<br />\r\n*     Integralidad.<br />\r\n*     Heterogeneidad<br />\r\n*     Construcción compartida<br />\r\n*     Participación.', '2018-03-23 07:07:19', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1084, 33, 'est', 468, 'Los recursos naturales son aquellos bienes que pueden obtenerse de la naturaleza sin mediar la intervención de la mano del hombre.', '2018-03-24 08:54:03', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1085, 23, 'est', 445, 'Correa (2005) Los resultados demuestran que los estudiantes de un grupo experimental logran alcanzar mayores niveles de respuestas correctas con mayor grado de conciencia y generalización, evidenciándose la efectividad de diversas estrategia cuando se imparten los temas con dinamismo e integración, se genera relevancia e interés en la asignatura.', '2018-03-25 19:09:30', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1086, 24, 'est', 450, 'Novak y Gowin (1988:25) “se basan en la teoría del aprendizaje significativo señalando que los elementos fundamentales de los modelos conceptuales (esquemas y mapas conceptuales) actúan de andamios que facilitan la enseñanza y el aprendizaje, donde el alumno relaciona la estructura cognitiva previa que tiene con la nueva información”', '2018-03-26 06:51:45', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1087, 26, 'est', 446, 'v<br />\r\nv<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\nSegún Faria (2011:35), Proyecto Educativo Integral Comunitario (PEIC), es un proyecto institucional a partir del cual se construye, planifica y desarrollan acciones entre todos los actores que hacen vida en la institución y la comunidad.<br />\r\nEs decir, es un proceso reflexivo, participativo y abierto con los sectores del entorno educativo, en atención a las prioridades socio-comunitarias.<br />\r\nCaracterísticas:<br />\r\n* Integralidad.<br />\r\n* Heterogeneidad<br />\r\n* Construcción compartida<br />\r\n* Participación.<br />\r\nEntre sus alcances es una vez determinada la posibles soluciones se procede a jerarquizarlas parea determinar las posibles soluciones a  la situación problemática. Se puede cambiar las condiciones negativas a condiciones positivas.<br />\r\nEl problema se trasforma en la situación esperada que se alcanzada mediante la solución del problema.<br />\r\nLa raíz será los medios para la solución del problema.<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />\r\n<br />', '2018-03-30 11:35:22', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1088, 31, 'est', 455, 'El ambiente son todos aquellos actores que nos rodean,estos pueden ser factores vivientes y no vivientes los cuales afectan directamente la vida de los que habitan en el.', '2018-03-30 14:27:32', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1089, 24, 'est', 448, 'Según Morrison (1920) “Establece los siguientes tipos de enseñanza, según su naturaleza, objetivos, procesos de enseñanza y productos del aprendizaje: Tipo Científico, Tipo de Apreciación, Tipo de Artes Prácticas, Tipo de Lenguaje y Artes, Tipo de Práctica Pura”', '2018-04-02 14:26:41', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1090, 23, 'est', 450, '(Díaz y Hernández; 2002: 39) señalan que la quimica debe ser enseñada desde La perspectiva ausubeliana, considerando que el aprendizaje significativo “es aquel que conduce a la creación de estructuras de conocimientos mediante la relación sustantiva entre la nueva información y las ideas previas de los estudiantes”', '2018-04-02 16:55:49', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1091, 23, 'est', 445, 'Acosta y García (2012), Manifiestan que los docentes de la Química de la Universidad del Zulia , utilizan una variedad de estrategias prácticas como organizadores, señaladores, ilustraciones, gráficos y preguntas intercaladas, mapas conceptuales para lograr la motivación del alumnado en cuanto al área de la Química y despertar su interés.', '2018-04-05 09:55:28', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1092, 25, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-07 14:29:06', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1093, 24, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-07 14:34:14', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1094, 23, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-07 14:41:56', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1095, 26, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-07 14:45:23', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1096, 31, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-07 14:58:13', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1097, 32, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-07 15:00:42', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1098, 33, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-07 15:09:16', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1099, 37, 'admin', 2, '<p><span style=\"color: #0000ff;\">Buenas tardes!</span></p>', '2018-04-07 15:14:04', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1100, 26, 'est', 445, 'Pérez Esclarín(2004), Integrar la ciencia y el humanismo, para promover la reflexión ética sobre los avances tecnológicos e impulsar el equilibrio entre la moral y la moral de la competencia en relación directa con el entorno social y la del estudiante, su evolución y el éxito.', '2018-04-07 17:32:43', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1101, 26, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-08 11:42:48', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1102, 26, 'est', 446, 'Según Faria (2011:35), El PEIC, es un proyecto institucional a partir del cual se construye, planifica y desarrollan acciones entre todos los actores que hacen vida en la institución y la comunidad.<br />\r\nEs decir, es un proceso reflexivo, participativo y abierto con los sectores del entorno educativo, en atención a las prioridades', '2018-04-10 04:37:12', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1103, 34, 'est', 446, 'Para Solarte (2008:25)\"el ambiente es un sistema dinámico definido por las interacciones físicas, biológicas, sociales y culturales, percibidas o no, entre los seres humanos y los demás seres vivientes y todos los elementos del medio en el cual se desenvuelven\"<br />\r\npor tanto; todos estos elementos son de carácter natural o sean transformados o creados por el hombre.', '2018-04-10 04:43:19', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1104, 24, 'est', 448, 'Según Morrison (1920) “Establece el Plan de Unidades Didácticas que consiste en los siguientes tipos de enseñanza, según su naturaleza, objetivos, procesos de enseñanza y productos del aprendizaje: Tipo Científico, Tipo de Apreciación, Tipo de Artes Prácticas, Tipo de Lenguaje y Artes, Tipo de Práctica Pura”', '2018-04-10 09:53:54', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1105, 24, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas Tardes</span></strong>!</p>', '2018-04-10 15:02:35', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1106, 26, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-10 15:09:11', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1107, 27, 'admin', 2, '<p><strong>Buenas Tardes!</strong></p>', '2018-04-10 15:10:54', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1108, 24, 'est', 450, 'Novak y Gowin (1988:25) “se basan en la teoría del aprendizaje significativo señalando que los elementos fundamentales de los modelos conceptuales (esquemas y mapas conceptuales) actúan de andamios que facilitan la enseñanza y el aprendizaje” tal como lo apreciamos en la asignatura recursos y medios audiovisuales.', '2018-04-11 07:04:11', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1109, 24, 'est', 451, 'según Díaz y Hernández (1998) expresan que \"la investigación sobre estrategias de enseñanza ha abordado aspectos como el diseño y el empleo de objetivos de enseñanza, preguntas insertadas, ilustraciones, modos de respuesta, organizadores anticipados, redes semánticas, mapas conceptuales y esquemas de estructuración de textos, entre otros\".', '2018-04-11 07:07:27', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1110, 24, 'est', 449, 'según Godino (2016)\"es un sistema de métodos para dar instrucciones, ideas y principios que se les enseñan a alguien para formar un conjunto de conocimientos,como el Método activo Es cuando se toma en cuenta la participación del alumno y sus actividades son las que logran su misma motivación\"(p.45)', '2018-04-11 10:48:28', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1111, 23, 'est', 449, 'según Hernández (2000): enseñanza de la Química vinculada<br />\r\ncon la vida diaria y la realidad nacional del proceso de aprendizaje del alumno, así como en su proceso de enseñanza y este enfoque ha despertando en los docentes la necesidad y prioridad de una actualización en contenidos y metodologías pedagógicas innovadoras.(p.56)', '2018-04-11 11:10:47', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1112, 24, 'est', 449, 'según Godino (2016): es un sistema de métodos para dar instrucciones, ideas y principios que se les enseñan a alguien para formar un conjunto de conocimientos,como el Método activo Es cuando se toma en cuenta la participación del alumno y sus actividades son las que logran su misma motivación.(p.45)', '2018-04-11 11:11:52', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1113, 26, 'est', 444, 'según Garcia (2012) Es un plan de acción combinado con principios pedagógicos  que busca mejorar la educación impartida  como el funcionamiento del plantel, elaborado por los actores del plantel,  caracterizándose por la relación  social de aprender en interacción con grupos laborando simulaciones  y representaciones teatrales de la comunidad (p.78)', '2018-04-11 11:20:50', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1114, 23, 'est', 449, 'Según Hernández (2000): enseñanza de la Química vinculada con la vida diaria y la realidad nacional del proceso de aprendizaje del alumno, así como en su proceso de enseñanza y este enfoque ha despertado en los docentes la necesidad y prioridad de una actualización en contenidos y metodologías pedagógicas innovadoras.(p.56)', '2018-04-11 11:22:54', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1116, 23, 'est', 448, 'Díaz (1998) \"afirma que los estudiantes de bachillerato demandan, para la mayor comprensión de los contenidos, que utilicen en las clases un mayor número de ejemplos actuales y de la vida, además de actividades en equipo y visitas a algún lugar donde se presente el tema, como en las industrias\"', '2018-04-11 11:51:57', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1117, 24, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes</span></strong></p>', '2018-04-11 12:40:27', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1118, 23, 'admin', 2, '<p><strong><span style=\"color: #003300;\">Buenas tardes</span></strong></p>', '2018-04-11 12:49:24', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1119, 26, 'admin', 2, '<p><strong><span style=\"color: #0000ff;\">Buenas tardes!</span></strong></p>', '2018-04-11 12:52:33', 1, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1120, 23, 'est', 451, 'Machado (2006) “Parte del rechazo que muchas veces la asignatura de química provoca en los alumnos es originada por su nivel de abstracción teórica, que comienza con el mundo submicroscópico de la química, es decir, aquel que no puede llegarse a observar de manera directa”', '2018-04-11 13:31:06', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1121, 23, 'est', 450, 'Durango (2015:35), señala que para lograr una excelente motivación en los estudiantes hacia la asignatura de química, es importante impartir  prácticas de laboratorio como una estrategia didáctica alternativa para desarrollar las competencias básicas en el proceso de enseñanza-aprendizaje de la química y relacionarla con la vida diaria.', '2018-04-11 14:07:20', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1122, 23, 'est', 451, 'Machado (2006)afirma:<br />\r\nParte del rechazo que muchas veces la asignatura de química provoca en los alumnos es originada por su nivel de abstracción teórica, que comienza con el mundo submicroscópico de la química, es decir, aquel que no puede llegarse a observar de manera directa. (p.14)', '2018-04-11 14:53:24', 0, 0);
INSERT INTO `tbl_foro_comentario` VALUES (1123, 26, 'est', 445, 'Según Cepal (2004), Se fundamenta PEIC en una concepción holística y específica del hecho educativo, donde se analizan las aspiraciones sentidas por el colectivo que conforma el plantel y su entorno, para generar alternativas que permitan el mejoramiento de la calidad de la educación como un hecho de significación social.', '2018-04-11 14:54:39', 0, 0);

-- ----------------------------
-- Table structure for tbl_foro_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro_estudiante`;
CREATE TABLE `tbl_foro_estudiante`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'tabla que guarda la nota del estudiante en el foro',
  `est_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `foro_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `nota` float(6, 3) NOT NULL DEFAULT -1.000,
  `correccion` mediumtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT 'descripcion de la correccion',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `est_id`(`est_id`) USING BTREE,
  INDEX `foro_id`(`foro_id`) USING BTREE,
  CONSTRAINT `foro_estudiante_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `foro_estudiante_fk1` FOREIGN KEY (`foro_id`) REFERENCES `tbl_foro` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_foro_estudiante
-- ----------------------------
INSERT INTO `tbl_foro_estudiante` VALUES (1, 452, 25, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (2, 451, 25, 14.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (3, 449, 25, 14.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (4, 445, 25, 20.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (5, 448, 25, 17.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (6, 447, 25, 18.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (7, 444, 25, 19.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (8, 450, 25, 15.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (9, 446, 25, 16.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (10, 453, 25, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (11, 452, 24, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (12, 451, 24, 20.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (13, 449, 24, 18.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (14, 445, 24, 19.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (15, 448, 24, 19.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (16, 453, 24, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (17, 447, 24, 20.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (18, 444, 24, 20.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (19, 450, 24, 18.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (20, 446, 24, 20.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (21, 452, 23, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (22, 451, 23, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (23, 449, 23, 18.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (24, 445, 23, 19.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (25, 448, 23, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (26, 453, 23, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (27, 447, 23, 19.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (28, 444, 23, 19.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (29, 450, 23, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (30, 446, 23, 20.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (31, 468, 31, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (32, 446, 31, 20.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (33, 455, 31, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (34, 456, 31, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (35, 452, 26, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (36, 451, 26, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (37, 449, 26, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (38, 445, 26, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (39, 448, 26, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (40, 453, 26, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (41, 447, 26, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (42, 444, 26, 19.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (43, 450, 26, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (44, 446, 26, 20.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (45, 452, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (46, 451, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (47, 449, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (48, 445, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (49, 448, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (50, 453, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (51, 447, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (52, 444, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (53, 450, 27, 0.000, NULL, NULL, NULL);
INSERT INTO `tbl_foro_estudiante` VALUES (54, 446, 27, 0.000, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tbl_foro_respuesta
-- ----------------------------
DROP TABLE IF EXISTS `tbl_foro_respuesta`;
CREATE TABLE `tbl_foro_respuesta`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `com_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `prof_id` int(10) NOT NULL COMMENT 'id del profesor que responde',
  `content` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `fecha` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `com_id`(`com_id`) USING BTREE,
  CONSTRAINT `foro_respuesta_fk` FOREIGN KEY (`com_id`) REFERENCES `tbl_foro_comentario` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 606 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'las respuesta que hace el profesor a los comentarios en el f' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_foro_respuesta
-- ----------------------------
INSERT INTO `tbl_foro_respuesta` VALUES (105, 258, 2, 'falta foto y pag de la cita', '2015-04-15 08:09:14');
INSERT INTO `tbl_foro_respuesta` VALUES (106, 256, 2, 'menos de 45 palabras', '2015-04-15 08:14:09');
INSERT INTO `tbl_foro_respuesta` VALUES (107, 260, 2, 'mas de 50 palabras', '2015-04-16 09:18:58');
INSERT INTO `tbl_foro_respuesta` VALUES (108, 266, 2, 'falta foto', '2015-04-17 09:45:19');
INSERT INTO `tbl_foro_respuesta` VALUES (109, 265, 2, 'mejorar la cita, solo apellido y año', '2015-04-17 09:47:42');
INSERT INTO `tbl_foro_respuesta` VALUES (110, 268, 2, 'y la fecha?', '2015-04-17 09:50:35');
INSERT INTO `tbl_foro_respuesta` VALUES (111, 271, 2, 'falta pag y foto', '2015-04-18 10:41:41');
INSERT INTO `tbl_foro_respuesta` VALUES (112, 279, 2, 'menos de 45 palabras', '2015-05-02 14:07:52');
INSERT INTO `tbl_foro_respuesta` VALUES (113, 281, 2, 'menos de 45 palabras', '2015-05-02 14:08:22');
INSERT INTO `tbl_foro_respuesta` VALUES (118, 285, 2, 'falta pag', '2015-05-04 17:31:15');
INSERT INTO `tbl_foro_respuesta` VALUES (119, 288, 2, 'menos de 45 palabras', '2015-05-04 17:32:31');
INSERT INTO `tbl_foro_respuesta` VALUES (120, 289, 2, 'menos de 45 palabras', '2015-05-04 17:32:53');
INSERT INTO `tbl_foro_respuesta` VALUES (121, 291, 2, 'falta pag', '2015-05-04 17:33:29');
INSERT INTO `tbl_foro_respuesta` VALUES (127, 304, 2, 'mejorar redacción', '2015-05-12 11:14:45');
INSERT INTO `tbl_foro_respuesta` VALUES (128, 305, 2, 'falta página, no se coloca inicial del nombre, solo apellido', '2015-05-12 11:25:40');
INSERT INTO `tbl_foro_respuesta` VALUES (129, 306, 2, 'que significa la a al lado del año?', '2015-05-13 09:37:07');
INSERT INTO `tbl_foro_respuesta` VALUES (130, 308, 2, 'tiene mas de 50 palabras, la cita va entre comillas', '2015-05-13 09:39:20');
INSERT INTO `tbl_foro_respuesta` VALUES (131, 309, 2, 'falta página', '2015-05-13 09:40:15');
INSERT INTO `tbl_foro_respuesta` VALUES (132, 318, 2, 'mas de 50 palabras', '2015-05-15 11:39:10');
INSERT INTO `tbl_foro_respuesta` VALUES (135, 317, 2, 'quien dice esto?', '2015-05-15 11:44:57');
INSERT INTO `tbl_foro_respuesta` VALUES (136, 322, 2, 'quien es el autor(a) de este comentario?', '2015-05-15 11:45:43');
INSERT INTO `tbl_foro_respuesta` VALUES (137, 323, 2, 'de quien es el comentario, tiene menos de 45 palabras', '2015-05-15 11:47:01');
INSERT INTO `tbl_foro_respuesta` VALUES (138, 324, 2, 'fundamentación teórica', '2015-05-15 11:47:58');
INSERT INTO `tbl_foro_respuesta` VALUES (139, 335, 2, 'la cita solo lleva apellido sin inicial del nombre', '2015-05-16 09:29:42');
INSERT INTO `tbl_foro_respuesta` VALUES (140, 329, 2, 'quien es el autor de este comentario?', '2015-05-16 09:32:20');
INSERT INTO `tbl_foro_respuesta` VALUES (141, 330, 2, 'mejorar redacción', '2015-05-16 09:33:21');
INSERT INTO `tbl_foro_respuesta` VALUES (142, 336, 2, 'Hola Ramos, redáctelo nuevamente y coloque que es suyo', '2015-05-16 09:36:58');
INSERT INTO `tbl_foro_respuesta` VALUES (143, 332, 2, 'menos de 45 palabras', '2015-05-16 09:42:42');
INSERT INTO `tbl_foro_respuesta` VALUES (144, 341, 2, 'este no es el comentario evaluado anteriormente', '2015-05-17 10:40:31');
INSERT INTO `tbl_foro_respuesta` VALUES (145, 345, 2, 'menos de 45 palabras', '2015-05-17 10:42:47');
INSERT INTO `tbl_foro_respuesta` VALUES (146, 346, 2, 'cual método?', '2015-05-17 10:43:25');
INSERT INTO `tbl_foro_respuesta` VALUES (149, 355, 2, 'solo observación o entrevistas? no realiza medicines?', '2015-05-22 09:11:00');
INSERT INTO `tbl_foro_respuesta` VALUES (150, 356, 2, 'mejorar la redacción', '2015-05-22 09:12:08');
INSERT INTO `tbl_foro_respuesta` VALUES (151, 357, 2, 'falta pag de la cita', '2015-05-22 09:13:13');
INSERT INTO `tbl_foro_respuesta` VALUES (152, 359, 2, 'corregir y mejorar redaccion', '2015-05-23 09:45:53');
INSERT INTO `tbl_foro_respuesta` VALUES (153, 364, 2, 'mejorar redacción, cualitativa, va mas alla de ser metodología es un paradigma', '2015-05-23 09:49:02');
INSERT INTO `tbl_foro_respuesta` VALUES (159, 375, 2, 'En cuanto al paradigma cualitativo, si hablas del método fenomenológico ,  existen autores que consideran que si se investigan diferentes sujetos ante el mismo fenómeno, se puede llegar a generalizar sus coincidencias. Que opinas de esto?', '2015-05-27 16:19:40');
INSERT INTO `tbl_foro_respuesta` VALUES (160, 376, 2, 'Se esta comentando sobre dos paradigmas, ya en cuanto a la cantidad o magnitud lo hace Martínez', '2015-05-28 09:22:42');
INSERT INTO `tbl_foro_respuesta` VALUES (161, 377, 2, 'ya Martínez comenta la característica numerica', '2015-05-28 09:25:15');
INSERT INTO `tbl_foro_respuesta` VALUES (162, 378, 2, 'el método cualitativo no generaliza, porque parte sin hipótesis?', '2015-05-29 09:24:15');
INSERT INTO `tbl_foro_respuesta` VALUES (163, 379, 2, 'por que se llama observación participante?', '2015-05-29 09:28:33');
INSERT INTO `tbl_foro_respuesta` VALUES (164, 380, 2, 'El paradigma cualitativo, abarca la metodología fenomenológica, ya Martínez trabaja con ella', '2015-05-29 09:32:07');
INSERT INTO `tbl_foro_respuesta` VALUES (165, 381, 2, 'De que forma identifica la naturaleza profunda de la realidad?', '2015-05-29 09:34:50');
INSERT INTO `tbl_foro_respuesta` VALUES (166, 382, 2, 'En cuanto al paradigma cualitativo, si hablas del método fenomenológico , existen autores que consideran que si se investigan diferentes sujetos ante el mismo fenómeno, se puede llegar a generalizar sus coincidencias. Que opinas de esto?', '2015-05-29 09:39:01');
INSERT INTO `tbl_foro_respuesta` VALUES (167, 383, 2, 'cuando se habla de situación social, con cual metodología pudiese trabajar el paradigma cualitativo?', '2015-06-01 11:04:15');
INSERT INTO `tbl_foro_respuesta` VALUES (168, 384, 2, 'el método etnográfico se utiliza en que casos?', '2015-06-01 11:05:51');
INSERT INTO `tbl_foro_respuesta` VALUES (169, 385, 2, 'y  en ese caso, cuando puede generalizar, el método Hipotético Deductivo?', '2015-06-01 11:08:44');
INSERT INTO `tbl_foro_respuesta` VALUES (170, 386, 2, 'Por que señalas que el paradigma cualitativo lleva a una respuesta mas directa?', '2015-06-01 11:10:40');
INSERT INTO `tbl_foro_respuesta` VALUES (171, 387, 2, 'para la fenomenología, el sujeto y el objeto están íntimamente ligados, en el caso de un robo colectivo, que características del sujeto pudiesen, resultar en diferencias al momento señalar resultados?', '2015-06-01 11:27:44');
INSERT INTO `tbl_foro_respuesta` VALUES (172, 388, 2, 'Diferentes los paradigmas cualitativo y cuantitativo, cuando señalas el carácter interpretativo del primero, te refieres a que metodología y cual es su basamento?', '2015-06-01 11:34:45');
INSERT INTO `tbl_foro_respuesta` VALUES (173, 389, 2, 'Existen autores que señalan que la principal diferencia entre el paradigma  cualitativo y el cuantitativo alude a técnicas de recolección y análisis de  datos. Que opinas de lo anterior?', '2015-06-01 12:05:50');
INSERT INTO `tbl_foro_respuesta` VALUES (174, 390, 2, 'El paradigma cualitativo, descubre teorías después de recolectar datos? como hace ésto?', '2015-06-01 12:10:44');
INSERT INTO `tbl_foro_respuesta` VALUES (175, 391, 2, 'Cual es el basamento del caracter subjetivo del paradigma cualitativo?', '2015-06-01 12:12:26');
INSERT INTO `tbl_foro_respuesta` VALUES (176, 392, 2, 'el método fenomenológico esta siendo analizado por Martínez, sin embargo existe una metodología perteneciente al paradigma cualitativo que hace énfasis en la interpretación', '2015-06-01 12:16:44');
INSERT INTO `tbl_foro_respuesta` VALUES (187, 423, 2, 'menos de 45 palabras', '2015-06-18 13:07:53');
INSERT INTO `tbl_foro_respuesta` VALUES (188, 426, 2, 'mas de 50 palabras', '2015-06-18 13:11:30');
INSERT INTO `tbl_foro_respuesta` VALUES (189, 432, 2, 'sigue las pautas, entre 45 y 50 palabras', '2015-06-19 12:50:48');
INSERT INTO `tbl_foro_respuesta` VALUES (190, 429, 2, 'un solo comentario por dia', '2015-06-19 12:54:10');
INSERT INTO `tbl_foro_respuesta` VALUES (191, 428, 2, 'menos de 45 palabras', '2015-06-19 12:54:47');
INSERT INTO `tbl_foro_respuesta` VALUES (192, 431, 2, 'en las citas, solo apellido con la fecha', '2015-06-19 12:57:19');
INSERT INTO `tbl_foro_respuesta` VALUES (193, 434, 2, 'en las citas, solo apellido con la fecha\\r\\n', '2015-06-22 08:27:59');
INSERT INTO `tbl_foro_respuesta` VALUES (194, 438, 2, 'como se utiliza la observación?', '2015-06-23 09:40:32');
INSERT INTO `tbl_foro_respuesta` VALUES (195, 439, 2, 'cuál método? siempre se formulan hipótesis?', '2015-06-23 09:42:12');
INSERT INTO `tbl_foro_respuesta` VALUES (196, 440, 2, 'cuáles son los pasos de este método?', '2015-06-24 10:03:51');
INSERT INTO `tbl_foro_respuesta` VALUES (197, 441, 2, 'En el marco metodológico, las técnicas e instrumentos de recolección de datos, varían de acuerdo al tipo de investigación? por que?', '2015-06-24 10:11:30');
INSERT INTO `tbl_foro_respuesta` VALUES (198, 442, 2, 'al hablar del diseño, en que consiste?', '2015-06-24 10:16:26');
INSERT INTO `tbl_foro_respuesta` VALUES (199, 443, 2, 'Se define el nivel, tipo de investigación y  las técnicas de recogida de información solo en el marco metodológico?', '2015-06-24 10:21:23');
INSERT INTO `tbl_foro_respuesta` VALUES (200, 444, 2, 'mas detalle sobre esto', '2015-06-24 11:26:22');
INSERT INTO `tbl_foro_respuesta` VALUES (201, 445, 2, 'y como lo hacen?', '2015-06-24 11:27:12');
INSERT INTO `tbl_foro_respuesta` VALUES (202, 446, 2, 'como se utiliza la observación?\\r\\n', '2015-06-25 09:31:42');
INSERT INTO `tbl_foro_respuesta` VALUES (203, 448, 2, 'Cual es el diseño de la investigación acción- participante?', '2015-06-25 09:37:07');
INSERT INTO `tbl_foro_respuesta` VALUES (204, 449, 2, 'como se logra que La metodología de la investigación cumpla con el propósito del estudio que se  realiza.', '2015-06-25 09:41:21');
INSERT INTO `tbl_foro_respuesta` VALUES (205, 451, 2, 'Se define el nivel, tipo de investigación y las técnicas de recogida de información solo en el marco metodológico?\\r\\n', '2015-06-25 09:43:30');
INSERT INTO `tbl_foro_respuesta` VALUES (206, 450, 2, 'y como se logra esta confiabilidad?', '2015-06-25 09:47:46');
INSERT INTO `tbl_foro_respuesta` VALUES (207, 459, 2, 'menos de 45 palabras', '2015-06-27 15:33:48');
INSERT INTO `tbl_foro_respuesta` VALUES (209, 485, 2, 'mas de 50 palabras', '2015-07-06 13:35:15');
INSERT INTO `tbl_foro_respuesta` VALUES (212, 500, 2, 'Buenas tardes Ildemaro, así es, en la introducción, la primera parte es el inicio, donde se redactará de forma general un párrafo, sobre el tema en cuestión, luego en el desarrollo se colocan los títulos de los temas que se van a tratar,  y al final las diferentes secciones que conforman la monografía\\r\\nuna sugerencia puede ser ...  en la presente monografía, se han seleccionado los aspectos mas importantes de este tema, son los siguientes:', '2015-07-19 15:19:37');
INSERT INTO `tbl_foro_respuesta` VALUES (213, 503, 2, 'Hola Lisneydi, buenos días, la conclusión es del equipo, sobre el trabajo,  se toman en cuenta los diferentes aspectos que se han tratado en la monografía, y por cada uno se hace una conclusión. para finalizar se puede concluir con cualquier recomendación para mejorar el trabajo, u otra investigación que recomienda el equipo como complemento para la que se hizo.\r\nEn cuanto a las citas, no hay un máximo, recuerda que todos los autores deben aparecer en la bibliografía', '2015-07-21 08:46:29');
INSERT INTO `tbl_foro_respuesta` VALUES (214, 507, 2, 'Buenos días Ildemaro, No entiendo la pregunta, intuyo que es lo siguiente, el contenido se refiere, únicamente a los títulos que se señalan en el desarrollo de la introducción    delimitar un tema es determinar hasta donde se va cubrir el asunto sobre el que se realiza la investigación documental.  La entrega es esta semana para todos los alumnos, el lunes 27 algunos estudiantes lo van a entregar en físico', '2015-07-26 10:37:09');
INSERT INTO `tbl_foro_respuesta` VALUES (215, 508, 2, 'Buenas tardes Lisneydi, esta bien el segundo: PROCESOS QUÍMICOS  PARA LA OBTENCIÓN DEL ACEITE ESENCIAL DE MANDARINA \r\nCualquier duda, comunicate conmigo , a través de mensajes , recuerda que la monografía se entrega por correo el viernes', '2015-07-28 16:42:38');
INSERT INTO `tbl_foro_respuesta` VALUES (216, 510, 2, 'Buenos días Josemary, el trabajo no se va a entregar en físico, lo recibiré en mi correo, hay plazo hasta el viernes 31 de julio, asimismo me puedes enviar a mi correo lo que hayan hecho y se los devuelvo con correcciones. Feliz día!\r\nhablando del indice, es la estructura que les di en clase, en la parte de desarrollo, colocan los subtitulos de su trabajo, con las respectivas pags', '2015-07-29 10:32:35');
INSERT INTO `tbl_foro_respuesta` VALUES (217, 514, 2, 'Hola Andrés, por  las normas UPEL', '2015-07-30 20:21:48');
INSERT INTO `tbl_foro_respuesta` VALUES (218, 515, 2, 'una conclusión por todo el equipo, tomando en cuenta los diferentes aspectos que investigaron', '2015-07-30 20:24:27');
INSERT INTO `tbl_foro_respuesta` VALUES (219, 518, 2, 'Buenos tardes Josemary, las normas se dieron en clase, este foro se abrió el 18 de julio para aclarar dudas, se cierra hoy, sin embargo, he llamado a  estudiantes de cada uno de los grupos  para preguntarles sobre lo que pudiese hacer falta, el único equipo que no llamé, no tiene teléfono ninguno de sus integrantes. al no recibir comunicación de ellos, a cursonet, a mi correo o a mi cell, pensé que estaban bien! Feliz tarde para todos!', '2015-07-31 12:56:06');
INSERT INTO `tbl_foro_respuesta` VALUES (222, 498, 2, 'falto pag al final de la cita', '2015-08-06 10:11:08');
INSERT INTO `tbl_foro_respuesta` VALUES (541, 1011, 2, 'puede pasar al foro 2', '2018-02-26 18:37:06');
INSERT INTO `tbl_foro_respuesta` VALUES (542, 1012, 2, 'falta pag', '2018-02-26 18:39:06');
INSERT INTO `tbl_foro_respuesta` VALUES (543, 1013, 2, 'falta pag', '2018-02-26 18:41:41');
INSERT INTO `tbl_foro_respuesta` VALUES (544, 1015, 2, 'cerrar comillas y colocar pag', '2018-02-26 18:44:32');
INSERT INTO `tbl_foro_respuesta` VALUES (545, 1017, 2, 'fijate en el número de palabras', '2018-02-28 09:55:58');
INSERT INTO `tbl_foro_respuesta` VALUES (546, 1018, 2, 'pasa al siguiente foro', '2018-02-28 09:57:50');
INSERT INTO `tbl_foro_respuesta` VALUES (547, 1020, 2, 'pase al siguiente foro', '2018-03-01 10:18:16');
INSERT INTO `tbl_foro_respuesta` VALUES (548, 1021, 2, 'el número de palabras es de 45 a 50', '2018-03-01 10:19:56');
INSERT INTO `tbl_foro_respuesta` VALUES (549, 1027, 2, 'existen formas, sistemas y tecnicas, mencione alguna de', '2018-03-04 09:01:19');
INSERT INTO `tbl_foro_respuesta` VALUES (550, 1024, 2, 'lea instrucciones', '2018-03-04 09:04:57');
INSERT INTO `tbl_foro_respuesta` VALUES (551, 1023, 2, 'mas de 45 palabras', '2018-03-04 09:05:40');
INSERT INTO `tbl_foro_respuesta` VALUES (552, 1025, 2, 'tirne menos de 45 palabras, lea las instrucciones', '2018-03-04 09:07:31');
INSERT INTO `tbl_foro_respuesta` VALUES (553, 1026, 2, 'menos de 45 palabras', '2018-03-04 09:08:16');
INSERT INTO `tbl_foro_respuesta` VALUES (554, 1031, 2, 'pasa al proximo foro', '2018-03-05 15:00:08');
INSERT INTO `tbl_foro_respuesta` VALUES (555, 1033, 2, 'mas de 50 palabras', '2018-03-07 11:33:35');
INSERT INTO `tbl_foro_respuesta` VALUES (556, 1035, 2, 'tiene 21 palabras', '2018-03-09 12:36:23');
INSERT INTO `tbl_foro_respuesta` VALUES (557, 1034, 2, 'pase al proximo foro', '2018-03-09 12:45:26');
INSERT INTO `tbl_foro_respuesta` VALUES (558, 1040, 2, 'pasa al siguiente foro', '2018-03-13 09:55:38');
INSERT INTO `tbl_foro_respuesta` VALUES (559, 1044, 2, 'falta pagina, en referencia, cierra comillas en la cita textual', '2018-03-13 09:59:44');
INSERT INTO `tbl_foro_respuesta` VALUES (560, 1039, 2, 'pasa al otro foro', '2018-03-13 10:37:22');
INSERT INTO `tbl_foro_respuesta` VALUES (561, 1041, 2, 'pasa al siguiente foro', '2018-03-13 10:40:26');
INSERT INTO `tbl_foro_respuesta` VALUES (562, 1030, 2, 'no cumple con instrucciones', '2018-03-13 10:43:14');
INSERT INTO `tbl_foro_respuesta` VALUES (563, 1042, 2, 'no has aprobado el foro 1', '2018-03-13 10:44:51');
INSERT INTO `tbl_foro_respuesta` VALUES (564, 1045, 2, 'pasa al siguiente foro', '2018-03-13 11:14:55');
INSERT INTO `tbl_foro_respuesta` VALUES (565, 1047, 2, 'existen formas, sistemas y tecnicas, mencione alguna de', '2018-03-13 11:18:52');
INSERT INTO `tbl_foro_respuesta` VALUES (566, 1053, 2, 'lee las instrucciones, tiene mas de 50 palabras', '2018-03-15 13:25:59');
INSERT INTO `tbl_foro_respuesta` VALUES (567, 1048, 2, 'menos de 45 palabras', '2018-03-15 13:32:37');
INSERT INTO `tbl_foro_respuesta` VALUES (568, 1054, 2, 'no puede cambiar foro sin  aprobar el anterior', '2018-03-15 13:35:22');
INSERT INTO `tbl_foro_respuesta` VALUES (569, 1055, 2, 'no puede cambiar foro sini ha aprobado el anterior', '2018-03-15 13:36:35');
INSERT INTO `tbl_foro_respuesta` VALUES (570, 1061, 2, 'lee las instrucciones', '2018-03-17 12:25:10');
INSERT INTO `tbl_foro_respuesta` VALUES (571, 1062, 2, 'lee las instrucciones', '2018-03-17 12:25:54');
INSERT INTO `tbl_foro_respuesta` VALUES (572, 1057, 2, 'pase al siguiente foro', '2018-03-17 12:31:23');
INSERT INTO `tbl_foro_respuesta` VALUES (573, 1063, 2, 'no puede cambiar foro si no ha aprobado el anterior', '2018-03-17 12:33:17');
INSERT INTO `tbl_foro_respuesta` VALUES (574, 1058, 2, 'los comentarios deben ser de 45 a 50 palabras', '2018-03-20 13:14:32');
INSERT INTO `tbl_foro_respuesta` VALUES (575, 1051, 2, 'pase al foro siguiente', '2018-03-20 13:17:05');
INSERT INTO `tbl_foro_respuesta` VALUES (576, 1052, 2, 'de que tipo de aprendizaje habla, de ejemplo con asignatura o contenido', '2018-03-20 13:30:43');
INSERT INTO `tbl_foro_respuesta` VALUES (577, 1059, 2, 'pase al proximo foro', '2018-03-20 13:31:45');
INSERT INTO `tbl_foro_respuesta` VALUES (578, 1060, 2, 'pase al siguiente foro', '2018-03-20 13:40:45');
INSERT INTO `tbl_foro_respuesta` VALUES (579, 1067, 2, 'esta nota textual no debe ir entre comillas tiene mas de 40 palabras', '2018-03-20 13:43:14');
INSERT INTO `tbl_foro_respuesta` VALUES (580, 1066, 2, 'mas de 50 palabras', '2018-03-21 10:56:19');
INSERT INTO `tbl_foro_respuesta` VALUES (581, 1077, 2, 'pasa al próximo foro,  la cita no debe ir entre comillas, tiene mas de 40 palabras ( lo tomaré en cuenta a partir del próximo foro)', '2018-04-07 14:18:36');
INSERT INTO `tbl_foro_respuesta` VALUES (582, 1081, 2, 'Pasa al próximo foro, esta cita no va entre comillas, tiene mas de 40 palabras( lo tomaré en cuenta a partir del próximo foro)', '2018-04-07 14:20:28');
INSERT INTO `tbl_foro_respuesta` VALUES (583, 1086, 2, 'solicité ejemplo de un tipo de aprendizaje, tome en cuenta una asignatura del pensum de Química', '2018-04-07 14:32:10');
INSERT INTO `tbl_foro_respuesta` VALUES (584, 1089, 2, 'tiene 38 palabras, son de 45 a 50', '2018-04-07 14:33:31');
INSERT INTO `tbl_foro_respuesta` VALUES (585, 1090, 2, 'no ha aprobado el foro anterior', '2018-04-07 14:36:53');
INSERT INTO `tbl_foro_respuesta` VALUES (586, 1085, 2, 'pase al siguiente foro', '2018-04-07 14:40:27');
INSERT INTO `tbl_foro_respuesta` VALUES (587, 1082, 2, 'pase al siguiente foro', '2018-04-07 14:41:18');
INSERT INTO `tbl_foro_respuesta` VALUES (588, 1079, 2, 'de 45 a 50 palabras', '2018-04-07 14:44:35');
INSERT INTO `tbl_foro_respuesta` VALUES (589, 1080, 2, 'todo salió bien, gracias por preguntar. Feliz tarde!', '2018-04-07 14:46:27');
INSERT INTO `tbl_foro_respuesta` VALUES (590, 1088, 2, 'recuerda que los comentarios son de 45 a 50 palabras', '2018-04-07 14:57:19');
INSERT INTO `tbl_foro_respuesta` VALUES (591, 1084, 2, 'Lea las instrucciones, no puede cambiar de foro sin aprobar el anterior', '2018-04-07 15:04:32');
INSERT INTO `tbl_foro_respuesta` VALUES (592, 1078, 2, 'esta cita tiene mas de 4o palabras, no va entre comillas( lo paso por este foro)', '2018-04-07 15:07:55');
INSERT INTO `tbl_foro_respuesta` VALUES (593, 1100, 2, 'Este foro es sobre el PEIC: Proyecto Educativo Integral Comunitario', '2018-04-08 11:41:59');
INSERT INTO `tbl_foro_respuesta` VALUES (594, 1104, 2, 'pasa al próximo foro', '2018-04-10 15:01:31');
INSERT INTO `tbl_foro_respuesta` VALUES (595, 1102, 2, 'pasa al próximo foro', '2018-04-10 15:04:54');
INSERT INTO `tbl_foro_respuesta` VALUES (596, 1102, 2, 'buenas tardes bachiller Reyes, le informo que hay varios estudiantes que van a presentar la micro clase, el dia jueves en la mañana, espero su llamada', '2018-04-10 15:08:09');
INSERT INTO `tbl_foro_respuesta` VALUES (597, 1103, 2, 'mas de 50', '2018-04-10 15:15:17');
INSERT INTO `tbl_foro_respuesta` VALUES (598, 1103, 2, 'bachiller Reyes, no ha enviado lecturas base de sus comentarios, ellas deben cuidar las normas bibliográficas el jueves en la mañana realizaremos conversatorio', '2018-04-10 15:17:02');
INSERT INTO `tbl_foro_respuesta` VALUES (599, 1108, 2, 'pasa al próximo foro', '2018-04-11 12:37:52');
INSERT INTO `tbl_foro_respuesta` VALUES (600, 1109, 2, 'pasa al próximo foro', '2018-04-11 12:38:41');
INSERT INTO `tbl_foro_respuesta` VALUES (601, 1112, 2, 'pasa al próximo foro', '2018-04-11 12:39:33');
INSERT INTO `tbl_foro_respuesta` VALUES (602, 1114, 2, 'pasa al próximo foro', '2018-04-11 12:44:05');
INSERT INTO `tbl_foro_respuesta` VALUES (603, 1116, 2, 'que pasa con los de química?', '2018-04-11 12:48:43');
INSERT INTO `tbl_foro_respuesta` VALUES (604, 1113, 2, 'pasa al próximo foro', '2018-04-11 12:51:19');
INSERT INTO `tbl_foro_respuesta` VALUES (605, 1090, 2, 'este foro es sobre la influencia de los programas de quimica', '2018-04-11 12:55:59');

-- ----------------------------
-- Table structure for tbl_grupo
-- ----------------------------
DROP TABLE IF EXISTS `tbl_grupo`;
CREATE TABLE `tbl_grupo`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) UNSIGNED NOT NULL,
  `nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT ' ',
  `descripcion` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `prof_id` int(10) UNSIGNED NOT NULL COMMENT 'profesor responsable',
  `turno` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 presencial, 1 semi p, 2 a distancia',
  `fecha_creado` datetime(0) NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fecha`(`fecha_creado`) USING BTREE,
  INDEX `curso_id`(`curso_id`) USING BTREE,
  CONSTRAINT `tbl_grupo_fk` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de grupos o secciones\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_grupo
-- ----------------------------
INSERT INTO `tbl_grupo` VALUES (2, 14, '90', 'estudiantado de la noche', 2, 0, '2014-10-26 01:39:39', NULL, NULL);
INSERT INTO `tbl_grupo` VALUES (3, 13, '71', 'ESTUDIANTADO DE LA ASIGNATURA SEMINARIO', 2, 0, '2014-10-26 05:07:03', NULL, NULL);
INSERT INTO `tbl_grupo` VALUES (4, 15, '71', 'Alumnado de InvestigaciÃ³n Educativa', 2, 0, '2014-10-31 02:26:29', NULL, NULL);
INSERT INTO `tbl_grupo` VALUES (5, 14, 'Sección 71', 'Estudiantes de técnicas metodológicas', 2, 0, '2017-01-23 07:07:56', NULL, NULL);
INSERT INTO `tbl_grupo` VALUES (6, 16, 'Sección 71', 'Sección de la tarde', 2, 0, '2017-01-27 10:34:15', NULL, NULL);
INSERT INTO `tbl_grupo` VALUES (7, 16, 'Sección 90', 'Curso de la noche', 2, 0, '2017-01-29 11:33:05', NULL, NULL);
INSERT INTO `tbl_grupo` VALUES (8, 18, 'Sección 71', 'Unica sección para quimica', 2, 0, '2018-03-06 07:23:04', NULL, NULL);
INSERT INTO `tbl_grupo` VALUES (9, 17, 'Sección 71', 'sección única de Ecología', 2, 0, '2018-03-06 07:21:50', NULL, NULL);

-- ----------------------------
-- Table structure for tbl_grupo_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_grupo_estudiante`;
CREATE TABLE `tbl_grupo_estudiante`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `curso_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `est_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `grupo_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `curso_id`(`curso_id`) USING BTREE,
  INDEX `est_id`(`est_id`) USING BTREE,
  INDEX `grupo_id`(`grupo_id`) USING BTREE,
  CONSTRAINT `grupo_estudiante_fk` FOREIGN KEY (`curso_id`) REFERENCES `tbl_curso` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `grupo_estudiante_fk1` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tbl_grupo_estudiante_fk` FOREIGN KEY (`grupo_id`) REFERENCES `tbl_grupo` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 157 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_grupo_estudiante
-- ----------------------------
INSERT INTO `tbl_grupo_estudiante` VALUES (140, 16, 444, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (141, 16, 445, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (142, 16, 446, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (143, 16, 447, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (144, 16, 448, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (145, 16, 449, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (146, 16, 450, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (147, 16, 451, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (148, 16, 452, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (150, 16, 453, 6, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (151, 18, 446, 8, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (152, 18, 456, 8, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (153, 18, 455, 8, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (154, 18, 468, 8, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (155, 17, 465, 9, NULL, NULL);
INSERT INTO `tbl_grupo_estudiante` VALUES (156, 17, 454, 9, NULL, NULL);

-- ----------------------------
-- Table structure for tbl_log_admin
-- ----------------------------
DROP TABLE IF EXISTS `tbl_log_admin`;
CREATE TABLE `tbl_log_admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) UNSIGNED NOT NULL,
  `fecha_in` datetime(0) NOT NULL COMMENT 'fecha en que accede',
  `ip_acc` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ip de donde accede',
  `info_cliente` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'informacion sobre el so y el browser del cliente',
  `curso_id` int(10) NULL DEFAULT 0 COMMENT 'curso con el que ingreso por defecto',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_log_id`(`admin_id`) USING BTREE,
  CONSTRAINT `admin_log_id` FOREIGN KEY (`admin_id`) REFERENCES `tbl_admin` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 467 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_log_admin
-- ----------------------------
INSERT INTO `tbl_log_admin` VALUES (2, 1, '2014-05-26 01:04:17', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (3, 1, '2014-05-26 01:04:41', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (4, 1, '2014-05-26 01:05:12', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 8);
INSERT INTO `tbl_log_admin` VALUES (5, 1, '2014-05-26 01:07:49', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (6, 2, '2014-05-26 01:08:34', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (7, 2, '2014-05-26 01:09:32', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (8, 1, '2014-05-26 01:09:45', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (13, 1, '2014-05-26 01:12:41', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (15, 2, '2014-05-26 01:13:14', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 4);
INSERT INTO `tbl_log_admin` VALUES (16, 2, '2014-05-26 01:16:07', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 4);
INSERT INTO `tbl_log_admin` VALUES (17, 1, '2014-05-26 03:34:31', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (18, 1, '2014-05-26 04:29:48', '192.168.56.101', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (19, 1, '2014-10-22 08:25:28', '200.82.187.198', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (20, 1, '2014-10-22 08:35:29', '200.82.187.198', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36', 5);
INSERT INTO `tbl_log_admin` VALUES (21, 1, '2014-10-22 08:36:35', '200.82.187.198', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36', 4);
INSERT INTO `tbl_log_admin` VALUES (22, 1, '2014-10-22 10:03:54', '200.82.187.198', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36', 4);
INSERT INTO `tbl_log_admin` VALUES (23, 2, '2014-10-22 10:08:58', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 4);
INSERT INTO `tbl_log_admin` VALUES (24, 1, '2014-10-22 11:43:29', '181.17.254.26', 'Mozilla/5.0 (Linux; Android 4.4.4; Nexus 4 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.102 Mobile Safari/537.36', 4);
INSERT INTO `tbl_log_admin` VALUES (25, 2, '2014-10-23 11:21:24', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (26, 1, '2014-10-24 08:32:21', '186.93.72.183', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36', 4);
INSERT INTO `tbl_log_admin` VALUES (27, 1, '2014-10-24 08:34:43', '186.93.72.183', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (28, 2, '2014-10-26 01:36:21', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (29, 1, '2014-10-26 02:45:42', '201.210.56.64', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (30, 2, '2014-10-26 02:52:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (31, 2, '2014-10-26 04:40:16', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (32, 2, '2014-10-26 04:45:23', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (33, 2, '2014-10-26 06:43:38', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (34, 2, '2014-10-27 04:00:24', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (35, 1, '2014-10-27 04:27:02', '186.88.11.44', 'Mozilla/5.0 (Linux; Android 4.4.4; Nexus 4 Build/KTU84P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.102 Mobile Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (36, 2, '2014-10-27 04:33:07', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (37, 2, '2014-10-27 05:26:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 14);
INSERT INTO `tbl_log_admin` VALUES (38, 2, '2014-10-28 09:03:00', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (39, 2, '2014-10-28 10:20:59', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (40, 2, '2014-10-28 10:43:31', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (41, 2, '2014-10-28 06:55:14', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (42, 2, '2014-10-29 05:18:12', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 14);
INSERT INTO `tbl_log_admin` VALUES (43, 2, '2014-10-30 10:52:40', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (44, 2, '2014-10-31 08:50:01', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (45, 1, '2014-10-31 10:23:45', '186.93.72.183', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (46, 2, '2014-10-31 11:02:18', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (47, 2, '2014-10-31 12:16:00', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (48, 2, '2014-10-31 02:22:27', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (49, 2, '2014-10-31 10:04:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (50, 2, '2014-11-01 09:24:36', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (51, 2, '2014-11-02 11:23:32', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (52, 2, '2014-11-03 07:49:54', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (53, 2, '2014-11-04 08:42:53', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (54, 2, '2014-11-05 09:53:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (55, 2, '2014-11-06 10:01:28', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (56, 2, '2014-11-07 10:25:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (57, 2, '2014-11-08 09:53:03', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (58, 2, '2014-11-08 09:59:26', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (59, 2, '2014-11-08 11:53:03', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (60, 2, '2014-11-08 11:55:39', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (61, 2, '2014-11-08 11:56:58', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (62, 2, '2014-11-08 12:00:18', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (63, 2, '2014-11-08 12:01:51', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (64, 2, '2014-11-08 12:03:24', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (65, 2, '2014-11-08 12:05:05', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (66, 2, '2014-11-08 12:07:26', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (67, 2, '2014-11-08 12:08:46', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (68, 2, '2014-11-08 12:11:25', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (69, 2, '2014-11-09 02:12:07', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (70, 2, '2014-11-09 02:35:21', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (71, 2, '2014-11-09 02:37:48', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (72, 2, '2014-11-09 02:45:21', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (73, 2, '2014-11-10 08:15:15', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (74, 2, '2014-11-11 08:16:31', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (75, 1, '2014-11-11 08:04:42', '190.78.219.242', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (76, 2, '2014-11-11 08:25:08', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 14);
INSERT INTO `tbl_log_admin` VALUES (77, 2, '2014-11-12 08:22:36', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (78, 2, '2014-11-12 09:14:17', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 14);
INSERT INTO `tbl_log_admin` VALUES (79, 2, '2014-11-13 06:26:07', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (80, 2, '2014-11-15 11:01:23', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (81, 2, '2014-11-15 11:14:32', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (82, 2, '2014-11-18 07:07:06', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (83, 2, '2014-11-19 08:53:12', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (84, 2, '2014-11-19 10:02:51', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (85, 2, '2014-11-19 05:48:23', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (86, 2, '2014-11-20 10:11:11', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (87, 2, '2014-11-20 07:14:21', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (88, 2, '2014-11-20 07:21:59', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (89, 2, '2014-11-20 07:23:48', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 14);
INSERT INTO `tbl_log_admin` VALUES (90, 2, '2014-11-21 11:49:56', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (91, 2, '2014-11-21 12:00:00', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (92, 2, '2014-11-23 09:30:51', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 14);
INSERT INTO `tbl_log_admin` VALUES (93, 2, '2014-11-24 07:33:09', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (94, 2, '2014-11-24 05:37:59', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (95, 2, '2014-11-25 07:46:18', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (96, 2, '2014-11-25 08:14:22', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (97, 2, '2014-11-25 08:15:31', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 14);
INSERT INTO `tbl_log_admin` VALUES (98, 2, '2014-11-27 10:55:58', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (99, 2, '2014-12-01 09:16:00', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (100, 2, '2014-12-01 08:08:19', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (101, 2, '2014-12-02 09:22:41', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (102, 2, '2014-12-02 11:52:31', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (103, 2, '2014-12-03 08:52:11', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (104, 2, '2014-12-04 08:42:32', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (105, 2, '2014-12-05 03:52:30', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (106, 2, '2014-12-05 04:04:26', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (107, 2, '2014-12-05 04:05:25', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 13);
INSERT INTO `tbl_log_admin` VALUES (108, 2, '2014-12-05 04:11:30', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (109, 2, '2014-12-05 04:14:20', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 14);
INSERT INTO `tbl_log_admin` VALUES (110, 2, '2014-12-06 03:04:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (111, 2, '2014-12-08 07:25:14', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (112, 2, '2014-12-26 07:23:29', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 15);
INSERT INTO `tbl_log_admin` VALUES (113, 2, '2015-01-06 03:16:08', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (114, 2, '2015-01-08 11:23:39', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (115, 2, '2015-01-12 08:35:34', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (116, 2, '2015-01-12 10:01:03', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (117, 2, '2015-01-12 10:04:46', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (118, 2, '2015-01-12 10:22:04', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (119, 2, '2015-01-12 11:14:56', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (120, 2, '2015-01-12 12:25:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (121, 2, '2015-01-12 12:33:19', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (122, 2, '2015-01-12 12:40:01', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (123, 2, '2015-01-12 12:41:34', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (124, 2, '2015-01-12 12:47:57', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (125, 2, '2015-01-12 01:12:07', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (126, 2, '2015-01-12 01:20:10', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (127, 2, '2015-01-12 01:23:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (128, 2, '2015-01-12 01:40:31', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (129, 2, '2015-01-12 01:57:33', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (130, 2, '2015-01-12 02:09:36', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (131, 2, '2015-01-12 02:28:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (132, 2, '2015-01-12 09:34:15', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (133, 2, '2015-01-17 12:05:56', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (134, 2, '2015-01-19 09:57:37', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (135, 2, '2015-01-19 12:57:36', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (136, 2, '2015-01-20 06:11:26', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (137, 2, '2015-01-20 07:15:30', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (138, 2, '2015-01-22 08:38:12', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (139, 2, '2015-01-27 12:28:01', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (140, 2, '2015-01-29 06:28:49', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (141, 2, '2015-01-30 10:49:30', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (142, 2, '2015-02-02 06:50:19', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (143, 2, '2015-02-05 12:30:15', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (144, 2, '2015-02-08 10:44:01', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (145, 2, '2015-02-08 01:34:05', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (146, 2, '2015-02-09 07:41:54', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (147, 2, '2015-02-17 10:24:58', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (148, 2, '2015-02-17 01:49:10', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (149, 2, '2015-02-18 09:47:00', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (150, 2, '2015-02-19 11:01:19', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (151, 2, '2015-02-20 12:03:25', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (152, 2, '2015-02-21 11:23:55', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (153, 2, '2015-02-24 10:15:25', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (154, 2, '2015-02-25 10:54:57', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (155, 2, '2015-02-27 08:14:17', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (156, 2, '2015-02-27 02:17:27', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (157, 2, '2015-02-28 11:42:00', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (158, 2, '2015-03-01 08:36:37', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (159, 2, '2015-03-02 09:11:14', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (160, 2, '2015-03-02 10:13:38', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (161, 2, '2015-03-02 04:16:32', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (162, 2, '2015-03-03 08:18:59', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (163, 2, '2015-03-03 03:48:54', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (164, 2, '2015-03-05 01:24:47', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (165, 2, '2015-03-06 01:03:13', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (166, 2, '2015-03-23 12:44:47', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (167, 2, '2015-03-27 06:53:06', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (168, 2, '2015-03-27 07:32:49', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (169, 2, '2015-03-27 08:19:26', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (170, 2, '2015-04-02 02:17:47', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (171, 2, '2015-04-07 01:08:31', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (172, 2, '2015-04-10 01:26:29', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (173, 2, '2015-04-10 01:29:01', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (174, 2, '2015-04-10 01:30:59', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (175, 2, '2015-04-11 08:56:45', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (176, 1, '2015-04-11 08:08:01', '201.210.56.64', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36 Edge/12.0', 15);
INSERT INTO `tbl_log_admin` VALUES (177, 2, '2015-04-13 08:44:22', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (178, 2, '2015-04-13 08:49:41', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (179, 2, '2015-04-13 10:09:16', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (180, 2, '2015-04-14 10:05:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (181, 2, '2015-04-14 09:04:13', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (182, 2, '2015-04-14 10:52:42', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (183, 2, '2015-04-15 08:08:26', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (184, 2, '2015-04-15 10:28:21', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (185, 2, '2015-04-16 09:16:43', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (186, 2, '2015-04-16 04:18:10', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (187, 2, '2015-04-17 09:44:09', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (188, 2, '2015-04-17 09:51:38', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (189, 2, '2015-04-18 10:38:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (190, 2, '2015-04-18 03:32:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (191, 2, '2015-04-24 08:36:36', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (192, 2, '2015-04-26 11:07:12', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (193, 2, '2015-04-28 08:26:25', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (194, 2, '2015-04-30 09:14:07', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (195, 2, '2015-04-30 07:59:48', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (196, 2, '2015-05-02 02:05:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (197, 2, '2015-05-02 04:53:47', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (198, 2, '2015-05-03 10:15:12', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (199, 2, '2015-05-04 05:29:17', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (200, 2, '2015-05-05 10:20:12', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (201, 2, '2015-05-06 03:04:23', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (202, 2, '2015-05-07 09:14:12', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (203, 1, '2015-05-08 06:26:54', '64.212.161.53', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (204, 2, '2015-05-09 09:49:19', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (205, 2, '2015-05-09 09:53:44', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (206, 2, '2015-05-11 09:20:30', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (207, 2, '2015-05-12 11:06:56', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (208, 2, '2015-05-13 09:32:54', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (209, 2, '2015-05-14 07:56:16', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (210, 2, '2015-05-15 11:35:58', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (211, 2, '2015-05-16 09:27:04', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (212, 2, '2015-05-16 12:20:23', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (213, 2, '2015-05-17 10:35:24', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (214, 2, '2015-05-18 10:03:53', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (215, 1, '2015-05-18 08:52:57', '201.210.56.64', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.152 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (216, 1, '2015-05-18 09:21:45', '201.210.56.64', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.152 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (217, 2, '2015-05-20 08:32:19', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (218, 2, '2015-05-20 10:14:10', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (219, 2, '2015-05-22 09:02:34', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (220, 2, '2015-05-23 09:38:34', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (221, 2, '2015-05-24 11:53:34', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (222, 2, '2015-05-25 07:03:57', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (223, 2, '2015-05-27 08:57:07', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (224, 2, '2015-05-27 04:10:23', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (225, 2, '2015-05-28 09:17:13', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (226, 2, '2015-05-29 09:15:29', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (227, 2, '2015-05-30 09:05:05', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (228, 2, '2015-06-01 11:02:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (229, 2, '2015-06-02 08:52:49', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (230, 2, '2015-06-02 01:53:19', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (231, 2, '2015-06-03 09:19:24', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (232, 2, '2015-06-04 09:24:47', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (233, 2, '2015-06-05 01:09:13', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (234, 2, '2015-06-06 12:04:48', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (235, 2, '2015-06-08 08:48:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (236, 2, '2015-06-09 11:30:43', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (237, 2, '2015-06-09 12:22:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (238, 2, '2015-06-11 10:06:58', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (239, 2, '2015-06-12 08:20:41', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (240, 2, '2015-06-14 11:07:33', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (241, 2, '2015-06-16 08:26:42', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (242, 2, '2015-06-18 01:05:00', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (243, 2, '2015-06-19 12:49:03', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (244, 2, '2015-06-22 08:22:07', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (245, 2, '2015-06-23 09:38:44', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (246, 2, '2015-06-24 10:01:34', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (247, 2, '2015-06-25 09:25:29', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (248, 2, '2015-06-25 01:18:43', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (249, 2, '2015-06-26 04:49:02', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (250, 2, '2015-06-27 03:31:13', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (251, 2, '2015-06-30 12:41:45', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (252, 2, '2015-07-01 08:58:10', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (253, 2, '2015-07-02 10:43:07', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (254, 2, '2015-07-03 01:52:08', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (255, 2, '2015-07-04 09:13:25', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (256, 2, '2015-07-04 08:34:53', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (257, 2, '2015-07-06 01:34:14', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (258, 2, '2015-07-10 12:33:05', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (259, 2, '2015-07-11 09:48:20', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (260, 2, '2015-07-13 08:40:23', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (261, 2, '2015-07-15 08:24:48', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (262, 2, '2015-07-17 01:56:57', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (263, 2, '2015-07-18 09:06:46', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (264, 2, '2015-07-19 12:26:19', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (265, 2, '2015-07-19 02:55:03', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (266, 2, '2015-07-20 10:31:55', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (267, 2, '2015-07-21 08:36:16', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (268, 2, '2015-07-22 10:17:49', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (269, 2, '2015-07-22 04:23:43', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (270, 2, '2015-07-23 09:02:05', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (271, 2, '2015-07-23 03:57:57', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (272, 2, '2015-07-24 11:57:56', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (273, 2, '2015-07-24 05:50:21', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (274, 2, '2015-07-25 10:12:44', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (275, 2, '2015-07-26 10:08:18', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (276, 2, '2015-07-26 10:21:57', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (277, 2, '2015-07-26 03:35:24', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (278, 2, '2015-07-26 03:55:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (279, 2, '2015-07-27 10:39:32', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (280, 2, '2015-07-27 06:12:17', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (281, 2, '2015-07-28 04:32:10', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (282, 2, '2015-07-28 07:05:11', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (283, 2, '2015-07-29 10:23:15', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (284, 2, '2015-07-29 06:41:35', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (285, 2, '2015-07-30 10:03:12', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (286, 2, '2015-07-30 12:15:32', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (287, 2, '2015-07-30 08:19:56', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (288, 2, '2015-07-31 12:41:46', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (289, 2, '2015-07-31 10:06:24', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (290, 2, '2015-08-02 03:04:30', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (291, 2, '2015-08-03 08:32:42', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (292, 2, '2015-08-03 09:40:27', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (293, 2, '2015-08-03 11:45:17', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (294, 2, '2015-08-03 04:18:14', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (295, 2, '2015-08-04 08:59:58', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (296, 2, '2015-08-04 09:50:40', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (297, 2, '2015-08-05 09:31:36', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (298, 2, '2015-08-05 01:52:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (299, 2, '2015-08-05 05:57:29', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (300, 2, '2015-08-06 10:01:35', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (301, 2, '2015-08-06 10:14:27', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (302, 2, '2015-08-07 01:38:10', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (303, 2, '2015-08-10 08:58:17', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (304, 2, '2015-08-11 06:33:46', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (305, 2, '2015-08-12 12:32:38', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (306, 2, '2015-08-13 12:27:13', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (307, 2, '2015-08-13 09:32:21', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (308, 2, '2015-08-14 02:25:09', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (309, 2, '2015-08-23 04:16:50', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (310, 2, '2015-09-01 09:08:38', '201.210.56.64', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (311, 1, '2015-09-04 04:22:37', '64.212.161.58', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (312, 1, '2015-11-18 03:32:47', '64.212.161.58', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (313, 1, '2016-11-28 01:41:54', '190.202.53.186', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (314, 1, '2016-11-29 09:20:19', '190.72.95.253', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (315, 1, '2017-01-21 06:54:35', '190.79.108.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (316, 1, '2017-01-21 07:13:45', '190.79.108.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (317, 2, '2017-01-22 09:39:53', '201.211.210.68', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (318, 1, '2017-01-22 03:07:57', '190.79.108.44', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5 Build/M4B30Z) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.91 Mobile Safari/537.36', 15);
INSERT INTO `tbl_log_admin` VALUES (319, 2, '2017-01-23 06:37:31', '201.211.210.68', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 14);
INSERT INTO `tbl_log_admin` VALUES (320, 2, '2017-01-23 08:14:21', '201.211.210.68', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (321, 2, '2017-01-24 10:47:53', '200.93.25.228', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (322, 2, '2017-01-24 11:04:24', '200.93.25.228', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (323, 2, '2017-01-25 12:22:35', '200.109.19.102', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (324, 2, '2017-01-25 08:01:39', '200.109.19.102', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (325, 2, '2017-01-27 09:09:45', '200.109.19.102', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (326, 2, '2017-01-29 11:29:47', '200.109.19.102', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (327, 2, '2017-02-08 07:19:23', '200.44.204.177', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (328, 2, '2017-02-09 12:24:01', '200.44.204.177', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 14);
INSERT INTO `tbl_log_admin` VALUES (329, 2, '2017-02-09 01:10:36', '200.44.204.177', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (330, 2, '2017-02-09 09:17:41', '200.44.204.177', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (331, 2, '2017-02-10 01:41:28', '200.44.204.177', 'Mozilla/5.0 (Linux; Android 4.0.4; V8200plus Build/IMM76I) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.111 Mobile Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (332, 2, '2017-02-10 08:02:45', '200.44.204.177', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (333, 2, '2017-02-11 11:14:38', '200.44.204.177', 'Mozilla/5.0 (Linux; Android 4.4.2; Q79 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.85 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (334, 2, '2017-02-13 05:54:32', '200.44.204.177', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (335, 2, '2017-02-13 07:37:12', '200.44.204.177', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (336, 2, '2017-02-14 02:05:05', '200.44.204.177', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (337, 2, '2017-02-14 07:19:14', '200.44.204.177', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (338, 2, '2017-02-15 08:16:27', '200.44.204.177', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (339, 2, '2017-02-17 05:25:36', '201.211.223.138', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (340, 2, '2017-02-19 09:02:47', '201.211.223.138', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (341, 2, '2017-02-20 07:51:01', '201.211.223.138', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (342, 2, '2017-02-20 08:07:04', '201.211.223.138', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (343, 2, '2017-02-20 08:07:11', '201.211.223.138', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (344, 2, '2017-02-22 08:03:37', '201.211.223.138', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (345, 2, '2017-02-23 01:33:33', '201.211.223.138', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (346, 2, '2017-02-24 07:06:39', '201.211.223.138', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (347, 2, '2017-02-28 08:07:42', '201.211.222.240', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (348, 2, '2017-03-02 09:24:14', '201.211.216.241', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (349, 2, '2017-03-03 08:14:41', '201.211.203.197', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (350, 1, '2017-03-03 10:09:15', '201.249.176.90', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (351, 1, '2017-03-03 10:25:08', '201.249.176.90', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36', 13);
INSERT INTO `tbl_log_admin` VALUES (352, 1, '2017-03-03 01:32:10', '201.249.176.90', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (353, 1, '2017-03-03 01:33:10', '201.249.176.90', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (354, 2, '2017-03-03 04:08:34', '201.211.203.197', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (355, 2, '2017-03-05 07:16:47', '201.211.203.197', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (356, 2, '2017-03-07 07:57:24', '201.249.22.98', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (357, 2, '2017-03-08 07:25:37', '201.249.22.98', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (358, 2, '2017-03-10 07:52:23', '201.249.22.98', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (359, 2, '2017-03-12 03:14:16', '201.249.22.98', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (360, 1, '2017-03-13 02:31:15', '190.202.53.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (361, 2, '2017-03-14 10:02:29', '201.249.22.98', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (362, 2, '2017-03-15 10:41:39', '201.249.22.98', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (363, 2, '2017-03-16 10:45:23', '201.249.21.164', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (364, 2, '2017-03-17 10:57:07', '201.249.21.164', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (365, 2, '2017-03-18 10:18:21', '201.249.21.164', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (366, 2, '2017-03-19 11:20:16', '201.249.21.164', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (367, 1, '2017-03-19 08:34:24', '200.84.48.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (368, 2, '2017-03-21 09:39:25', '190.199.235.58', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (369, 2, '2017-03-21 10:10:09', '190.199.235.58', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (370, 2, '2017-03-22 10:43:39', '190.199.235.58', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (371, 2, '2017-03-23 12:02:28', '200.109.13.232', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (372, 2, '2017-03-23 06:48:51', '200.109.13.232', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (373, 2, '2017-03-24 02:40:32', '200.109.13.232', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (374, 2, '2017-03-24 03:46:23', '200.109.13.232', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (375, 2, '2017-03-25 10:34:04', '200.109.13.232', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (376, 2, '2017-03-26 02:31:18', '200.109.13.232', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (377, 2, '2017-03-27 02:17:24', '200.109.13.232', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (378, 2, '2017-03-30 03:51:13', '201.211.192.75', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (379, 2, '2017-04-03 04:19:25', '201.211.192.75', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (380, 2, '2017-04-04 12:19:15', '201.211.192.75', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (381, 2, '2017-04-06 11:00:52', '201.211.192.75', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (382, 2, '2017-04-07 03:51:18', '201.211.192.75', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (383, 2, '2017-04-08 02:58:19', '201.211.192.75', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (384, 2, '2017-04-17 04:10:15', '201.249.31.108', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (385, 2, '2017-04-18 04:35:39', '201.249.31.108', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (386, 2, '2017-04-18 07:25:01', '201.249.31.108', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (387, 2, '2017-04-18 07:34:16', '201.249.31.108', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (388, 2, '2017-04-27 04:03:40', '200.109.12.137', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (389, 1, '2017-05-02 02:04:28', '201.249.176.90', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (390, 1, '2017-05-04 10:51:30', '138.122.4.110', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (391, 2, '2017-10-01 12:56:31', '201.210.74.59', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (392, 2, '2017-10-01 01:30:08', '201.210.74.59', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (393, 2, '2017-10-01 03:19:35', '201.210.74.59', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (394, 2, '2017-10-01 04:46:43', '201.249.11.215', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (395, 1, '2017-10-01 05:09:45', '190.202.223.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (396, 2, '2017-10-02 09:51:57', '201.249.11.215', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (397, 2, '2017-10-03 03:27:19', '201.249.11.215', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (398, 2, '2017-10-04 02:48:44', '200.44.208.220', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (399, 2, '2017-10-05 09:14:41', '200.44.208.220', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (400, 2, '2017-10-06 09:45:40', '200.90.75.11', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (401, 2, '2017-10-09 07:50:56', '200.90.75.11', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (402, 2, '2017-10-16 04:00:01', '201.211.198.42', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (403, 2, '2017-10-17 11:54:13', '201.211.198.42', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (404, 2, '2017-10-18 08:52:53', '201.211.198.42', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (405, 2, '2017-10-19 04:21:53', '201.211.198.42', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (406, 2, '2017-10-23 07:51:20', '201.211.198.42', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (407, 2, '2017-10-24 02:44:22', '201.211.198.42', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (408, 2, '2017-10-25 01:38:09', '201.211.198.42', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (409, 2, '2017-10-31 12:14:23', '190.205.245.235', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (410, 2, '2017-11-05 01:05:39', '201.210.70.248', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (411, 2, '2017-11-11 09:42:42', '200.90.84.78', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (412, 2, '2017-11-17 03:49:04', '200.90.84.78', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (413, 2, '2017-11-20 05:28:52', '201.210.66.183', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (414, 2, '2017-11-23 05:01:34', '201.210.66.183', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (415, 2, '2017-11-29 05:29:07', '201.210.66.183', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (416, 2, '2017-11-30 03:25:52', '201.249.25.187', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (417, 2, '2017-12-01 04:23:30', '200.93.7.160', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (418, 2, '2017-12-04 05:25:16', '200.93.7.160', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (419, 2, '2017-12-05 03:56:04', '200.93.7.160', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (420, 2, '2017-12-10 12:39:03', '201.249.6.56', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (421, 2, '2017-12-10 03:12:50', '201.249.6.56', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (422, 1, '2018-02-07 12:12:23', '186.167.243.169', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (423, 2, '2018-02-18 10:34:49', '200.44.202.120', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (424, 2, '2018-02-19 08:39:58', '200.44.202.120', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (425, 2, '2018-02-19 08:38:45', '200.44.202.120', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (426, 2, '2018-02-20 08:10:30', '200.44.202.120', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (427, 1, '2018-02-21 01:05:16', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (428, 2, '2018-02-22 09:57:53', '200.44.202.120', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (429, 1, '2018-02-22 10:32:46', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (430, 1, '2018-02-22 10:40:55', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (431, 1, '2018-02-22 10:42:33', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (432, 1, '2018-02-23 06:17:41', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (433, 2, '2018-02-26 06:31:52', '201.249.6.167', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (434, 2, '2018-02-28 09:52:47', '201.249.6.167', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (435, 2, '2018-03-01 10:13:46', '201.249.6.167', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (436, 2, '2018-03-04 07:58:07', '201.249.6.167', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (437, 1, '2018-03-04 10:29:16', '201.208.230.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (438, 1, '2018-03-04 10:38:00', '201.208.230.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (439, 2, '2018-03-04 12:47:15', '201.249.6.167', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (440, 1, '2018-03-05 07:57:32', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (441, 2, '2018-03-05 02:51:51', '200.44.217.194', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (442, 2, '2018-03-06 04:42:41', '200.44.217.194', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (443, 1, '2018-03-06 07:07:40', '201.210.249.233', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (444, 4, '2018-03-06 07:20:47', '201.210.249.233', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (445, 2, '2018-03-07 11:28:31', '200.44.217.194', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (446, 2, '2018-03-09 12:31:58', '200.44.217.194', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (447, 2, '2018-03-10 03:23:09', '200.44.217.194', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (448, 1, '2018-03-10 04:30:16', '190.79.86.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (449, 2, '2018-03-11 01:22:54', '201.249.13.165', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (450, 2, '2018-03-13 09:46:16', '201.249.13.165', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (451, 2, '2018-03-13 09:46:17', '201.249.13.165', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (452, 2, '2018-03-15 01:22:09', '201.249.13.165', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (453, 2, '2018-03-17 11:11:57', '201.249.13.165', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (454, 2, '2018-03-17 12:16:16', '201.249.13.165', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (455, 2, '2018-03-20 01:07:05', '190.205.250.160', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (456, 2, '2018-03-21 10:41:01', '190.205.250.160', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (457, 2, '2018-04-02 05:55:50', '200.109.28.241', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (458, 2, '2018-04-07 02:15:23', '200.109.28.241', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (459, 2, '2018-04-08 11:33:31', '200.109.28.241', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (460, 4, '2018-04-09 03:29:54', '190.202.194.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (461, 2, '2018-04-09 09:07:57', '201.210.70.11', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (462, 2, '2018-04-10 02:59:46', '201.210.70.11', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (463, 2, '2018-04-11 12:35:14', '201.210.70.11', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', 16);
INSERT INTO `tbl_log_admin` VALUES (464, 1, '2018-04-11 03:04:01', '190.202.194.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (465, 1, '2018-04-11 06:21:33', '192.168.0.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', 16);
INSERT INTO `tbl_log_admin` VALUES (466, 1, '2018-04-22 02:46:29', '172.16.0.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36', 16);

-- ----------------------------
-- Table structure for tbl_log_est
-- ----------------------------
DROP TABLE IF EXISTS `tbl_log_est`;
CREATE TABLE `tbl_log_est`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `est_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fecha_in` datetime(0) NOT NULL COMMENT 'fecha en que accede',
  `ip_acc` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'ip de donde accede',
  `info_cliente` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'informacion sobre el so y el browser del cliente',
  `contenidos` varchar(220) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT 'ids, de los contenidos revisados (separados por coma)',
  `descargas` varchar(220) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT 'ids de las descargas realizadas (separadas por coma)',
  `links` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT 'ids de los links visitados',
  `soporte_a` smallint(6) NOT NULL DEFAULT 0 COMMENT 'veces que a hecho consultas por tema',
  `soporte_t` smallint(6) NOT NULL DEFAULT 0 COMMENT 'veces que ha pedido ayuda a soporte tecnico',
  `ncontenidos` smallint(6) NOT NULL DEFAULT 0 COMMENT 'numero de contenidos descargados',
  `ndescargas` smallint(6) NOT NULL DEFAULT 0 COMMENT 'numero de descargas hechas',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `estudiante_id`(`est_id`) USING BTREE,
  INDEX `fecha`(`fecha_in`) USING BTREE,
  CONSTRAINT `log_est_fk` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5861 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de log de ingreso al sistema x estudiante\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_log_est
-- ----------------------------
INSERT INTO `tbl_log_est` VALUES (5620, 444, '2018-02-17 04:08:37', '201.210.80.178', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5621, 444, '2018-02-17 04:15:38', '201.210.80.178', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5622, 444, '2018-02-17 04:44:16', '201.210.80.178', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5623, 445, '2018-02-18 12:49:25', '200.90.84.210', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5624, 445, '2018-02-18 01:15:36', '200.90.84.210', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5625, 446, '2018-02-18 02:54:36', '186.167.243.174', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5626, 447, '2018-02-19 07:02:02', '186.167.250.173', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5627, 448, '2018-02-20 07:08:27', '190.202.86.22', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5628, 450, '2018-02-20 07:24:57', '190.198.20.58', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5629, 453, '2018-02-22 10:34:41', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5630, 453, '2018-02-22 10:39:37', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5631, 453, '2018-02-22 10:41:33', '190.38.147.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0,65', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5632, 446, '2018-02-23 03:10:00', '186.167.245.107', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0,62,63,66,65', '0', '0', 0, 0, 4, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5633, 447, '2018-02-23 06:08:52', '186.167.248.57', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,63,66,62,62,62,63,66', '0,220,177,219,220,227,368,348', '0', 0, 0, 7, 7, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5634, 446, '2018-02-24 05:38:13', '186.167.251.36', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0,63,62', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5635, 444, '2018-02-25 10:59:43', '190.205.252.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5636, 444, '2018-02-25 11:01:54', '190.205.252.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5637, 452, '2018-02-25 11:14:34', '200.44.202.241', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:42.0) Gecko/20100101 Firefox/42.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5638, 444, '2018-02-25 11:22:57', '190.205.252.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5639, 445, '2018-02-25 11:37:14', '201.210.85.143', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,62', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5640, 445, '2018-02-25 11:38:41', '201.210.85.143', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,62,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5641, 449, '2018-02-25 11:56:31', '201.210.85.143', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,65', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5642, 449, '2018-02-25 11:57:45', '201.210.85.143', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,65,66,64,63,63', '0', '0', 0, 0, 5, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5643, 444, '2018-02-25 12:36:43', '190.205.252.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,63,63', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5644, 444, '2018-02-25 01:16:39', '190.205.252.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5645, 444, '2018-02-25 01:30:50', '190.205.252.92', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5646, 448, '2018-02-25 06:47:33', '200.93.16.182', 'Mozilla/5.0 (Linux; Android 4.4.2; 4009S Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Mobile Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5647, 446, '2018-02-27 03:09:59', '186.167.250.205', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5648, 444, '2018-02-27 06:30:16', '200.44.193.190', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5649, 444, '2018-02-27 06:44:09', '200.44.193.190', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5650, 444, '2018-02-27 06:48:06', '200.44.193.190', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5651, 444, '2018-02-27 06:50:01', '200.44.193.190', 'Mozilla/5.0 (Windows NT 6.1; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5652, 444, '2018-02-27 09:24:30', '200.44.193.190', 'Mozilla/5.0 (Windows NT 6.1; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5653, 444, '2018-02-27 06:25:43', '200.44.193.190', 'Mozilla/5.0 (Windows NT 6.1; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5654, 444, '2018-02-27 08:09:05', '200.44.193.190', 'Mozilla/5.0 (Windows NT 6.1; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5655, 447, '2018-02-28 04:43:55', '186.167.250.41', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,62,65,65,63,62,64,62,63,62,62,62', '0', '0', 0, 0, 11, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5656, 447, '2018-02-28 03:02:58', '186.167.251.67', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,62,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5657, 446, '2018-03-01 03:36:45', '186.167.250.2', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0,63,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5658, 451, '2018-03-01 03:38:29', '186.167.248.203', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,62', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5659, 451, '2018-03-01 03:39:17', '186.167.248.203', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,62,65,66,64,63,63,63', '0,368', '0', 0, 0, 7, 1, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5660, 444, '2018-03-01 05:49:27', '200.44.193.190', 'Mozilla/5.0 (Windows NT 6.1; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5661, 446, '2018-03-02 03:48:55', '186.167.242.240', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5662, 451, '2018-03-02 05:47:30', '186.167.251.67', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5663, 450, '2018-03-02 10:53:57', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,62', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5664, 450, '2018-03-02 10:57:17', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5665, 446, '2018-03-03 05:18:11', '186.167.249.120', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 1, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5666, 447, '2018-03-03 06:19:28', '186.167.249.15', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,63,64,63', '0,368', '0', 0, 0, 3, 1, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5667, 447, '2018-03-03 06:32:59', '186.167.249.15', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5668, 444, '2018-03-03 02:12:52', '200.93.29.33', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5669, 451, '2018-03-04 09:57:50', '186.167.243.148', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5670, 453, '2018-03-04 10:40:28', '201.208.230.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5671, 446, '2018-03-05 07:09:13', '186.167.243.77', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,63,63', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5672, 454, '2018-03-05 04:15:28', '200.90.77.187', 'Mozilla/5.0 (Linux; Android 4.4.2; TR10CS1 Build/KVT49L) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5673, 444, '2018-03-06 09:18:16', '150.186.32.6', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5674, 444, '2018-03-06 09:21:26', '150.186.32.6', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5675, 448, '2018-03-06 10:48:59', '186.167.245.92', 'Mozilla/5.0 (Linux; Android 4.2.2; C2105 Build/15.3.A.1.17) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.68 Mobile Safari/537.36', '0,62', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5676, 446, '2018-03-06 07:09:10', '186.167.250.212', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5677, 446, '2018-03-06 07:15:35', '186.167.250.212', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,68,70,67,63,63', '0', '0', 0, 0, 6, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5678, 446, '2018-03-06 08:11:50', '186.167.243.3', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5679, 460, '2018-03-06 09:35:45', '186.92.69.143', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5680, 457, '2018-03-06 09:41:57', '186.92.69.143', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5681, 446, '2018-03-07 03:34:07', '186.167.248.220', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5682, 455, '2018-03-07 04:39:41', '186.167.243.182', 'Mozilla/5.0 (Linux; Android 4.4.2; GT-I9192 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,67', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5683, 457, '2018-03-07 05:09:34', '190.37.80.194', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5684, 446, '2018-03-07 03:54:49', '186.167.242.33', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,68,67', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5685, 460, '2018-03-07 05:38:16', '186.92.165.32', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5686, 446, '2018-03-08 03:33:11', '186.167.248.177', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,67', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5687, 455, '2018-03-08 04:08:46', '186.167.242.116', 'Mozilla/5.0 (Linux; Android 4.4.2; GT-I9192 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,67', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5688, 448, '2018-03-08 07:38:01', '190.202.86.22', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36', '0,62', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5689, 448, '2018-03-08 07:38:35', '190.202.86.22', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36', '0,63', '0,368,348', '0', 0, 0, 1, 2, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5690, 449, '2018-03-08 03:29:14', '186.95.207.243', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,62,66,62,65,63', '0', '0', 0, 0, 5, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5691, 444, '2018-03-08 05:01:29', '200.44.199.30', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5692, 446, '2018-03-08 05:03:08', '186.167.249.6', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5693, 444, '2018-03-08 05:43:33', '200.44.199.30', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5694, 444, '2018-03-08 05:51:45', '200.44.199.30', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5695, 450, '2018-03-08 09:12:42', '190.203.80.76', 'Mozilla/5.0 (Linux; U; Android 2.3.5; es-ve; CM980 Build/HuaweiCM980) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5696, 450, '2018-03-08 09:12:46', '190.203.80.76', 'Mozilla/5.0 (Linux; U; Android 2.3.5; es-ve; CM980 Build/HuaweiCM980) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5697, 450, '2018-03-08 09:13:01', '190.203.80.76', 'Mozilla/5.0 (Linux; U; Android 2.3.5; es-ve; CM980 Build/HuaweiCM980) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5698, 450, '2018-03-08 09:13:11', '190.203.80.76', 'Mozilla/5.0 (Linux; U; Android 2.3.5; es-ve; CM980 Build/HuaweiCM980) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5699, 450, '2018-03-08 09:13:48', '190.203.80.76', 'Mozilla/5.0 (Linux; U; Android 2.3.5; es-ve; CM980 Build/HuaweiCM980) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5700, 451, '2018-03-09 06:14:54', '186.167.243.130', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5701, 451, '2018-03-09 06:28:00', '186.167.243.130', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5702, 451, '2018-03-09 07:45:43', '186.167.249.5', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5703, 450, '2018-03-09 11:56:35', '200.229.155.9', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5704, 447, '2018-03-09 05:49:28', '186.167.251.21', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5705, 447, '2018-03-09 05:49:32', '186.167.251.21', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,62,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5706, 446, '2018-03-10 06:00:35', '186.167.250.129', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5707, 444, '2018-03-10 11:55:07', '201.211.212.215', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', '0,63,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5708, 445, '2018-03-10 01:44:39', '201.211.199.133', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,65,64,63', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5709, 445, '2018-03-10 02:01:29', '201.211.199.133', 'Mozilla/5.0 (Linux; Android 4.1.2; GT-I8190 Build/JZO54K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5710, 447, '2018-03-10 02:08:05', '186.167.242.225', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5711, 447, '2018-03-10 02:08:05', '186.167.242.225', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5712, 447, '2018-03-10 02:12:54', '186.167.242.225', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5713, 445, '2018-03-10 02:19:58', '201.211.199.133', 'Mozilla/5.0 (Linux; Android 4.1.2; GT-I8190 Build/JZO54K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5714, 444, '2018-03-10 07:42:39', '190.205.244.124', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5715, 444, '2018-03-10 07:42:39', '190.205.244.124', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5716, 444, '2018-03-10 07:42:39', '190.205.244.124', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5717, 446, '2018-03-11 07:02:39', '186.167.244.214', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5718, 450, '2018-03-11 11:45:16', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5719, 444, '2018-03-11 12:27:28', '201.210.76.17', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5720, 444, '2018-03-11 08:00:41', '200.90.78.165', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5721, 444, '2018-03-11 08:00:41', '200.90.78.165', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5722, 468, '2018-03-12 09:43:31', '186.92.80.179', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5723, 468, '2018-03-12 09:54:48', '186.92.80.179', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5724, 468, '2018-03-12 02:29:37', '190.38.41.41', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5725, 468, '2018-03-12 02:29:40', '190.38.41.41', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5726, 469, '2018-03-12 06:07:41', '186.185.109.214', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5727, 465, '2018-03-12 07:15:13', '190.38.55.219', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5728, 460, '2018-03-12 07:17:02', '186.92.35.174', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5729, 446, '2018-03-13 05:28:21', '186.167.243.137', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5730, 444, '2018-03-13 06:07:29', '190.205.253.146', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5731, 468, '2018-03-13 10:00:23', '186.92.184.185', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5732, 468, '2018-03-13 10:00:24', '186.92.184.185', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5733, 450, '2018-03-13 07:22:53', '190.199.248.45', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,62,64', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5734, 460, '2018-03-13 07:55:48', '190.38.37.72', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5735, 446, '2018-03-13 09:03:53', '186.167.250.243', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67,65,63,62', '0', '0', 0, 0, 5, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5736, 461, '2018-03-13 11:13:50', '186.167.249.72', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5737, 444, '2018-03-14 07:21:03', '200.90.64.143', 'Mozilla/5.0 (Windows NT 6.1; rv:58.0) Gecko/20100101 Firefox/58.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5738, 450, '2018-03-14 10:17:15', '186.188.33.61', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5739, 450, '2018-03-14 10:17:29', '186.188.33.61', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5740, 450, '2018-03-14 10:22:53', '186.188.33.61', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5741, 455, '2018-03-14 01:39:22', '200.90.80.183', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,67', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5742, 455, '2018-03-14 02:03:34', '200.90.80.183', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,67,67', '0', '0', 1, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5743, 446, '2018-03-15 04:04:05', '186.167.251.57', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5744, 450, '2018-03-15 10:28:44', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5745, 446, '2018-03-16 03:30:12', '186.167.249.237', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,67,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5746, 451, '2018-03-16 07:45:36', '186.167.249.209', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5747, 451, '2018-03-16 07:45:59', '186.167.249.209', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5748, 445, '2018-03-16 08:41:16', '200.90.84.236', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.87 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5749, 451, '2018-03-16 09:47:23', '186.167.248.141', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5750, 451, '2018-03-16 10:45:22', '186.167.248.141', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5751, 451, '2018-03-16 05:49:08', '186.167.251.191', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5752, 446, '2018-03-17 06:31:11', '186.167.250.232', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,67,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5753, 468, '2018-03-17 09:43:07', '186.92.68.41', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5754, 455, '2018-03-17 09:57:43', '186.167.242.4', 'Mozilla/5.0 (Linux; Android 4.4.2; GT-I9192 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,67,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5755, 468, '2018-03-17 10:01:03', '186.92.68.41', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5756, 455, '2018-03-17 10:18:00', '186.167.251.190', 'Mozilla/5.0 (Linux; Android 4.4.2; GT-I9192 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,67', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5757, 468, '2018-03-17 11:20:03', '186.92.68.41', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,67,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5758, 455, '2018-03-17 11:34:16', '186.167.248.153', 'Mozilla/5.0 (Linux; Android 4.4.2; GT-I9192 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,67', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5759, 454, '2018-03-17 03:51:26', '200.90.90.103', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36', '0,71', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5760, 454, '2018-03-17 03:52:21', '200.90.90.103', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5761, 454, '2018-03-17 03:53:06', '200.90.90.103', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36', '0,71', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5762, 446, '2018-03-17 08:51:47', '186.167.249.243', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5763, 446, '2018-03-18 10:14:12', '186.167.242.164', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5764, 446, '2018-03-19 06:57:59', '186.167.245.153', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5765, 446, '2018-03-19 09:50:47', '186.167.248.64', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,67,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5766, 444, '2018-03-19 12:57:50', '190.199.243.232', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5767, 444, '2018-03-19 01:26:27', '190.199.243.232', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5768, 444, '2018-03-19 01:30:24', '190.199.243.232', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5769, 446, '2018-03-19 08:52:24', '186.167.251.160', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5770, 444, '2018-03-20 05:18:47', '200.90.82.164', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5771, 446, '2018-03-20 06:03:22', '186.167.251.51', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5772, 451, '2018-03-20 07:59:35', '200.90.74.206', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5773, 446, '2018-03-20 08:01:47', '186.167.249.104', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,62,64,67', '0', '0', 0, 0, 4, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5774, 444, '2018-03-21 08:59:45', '200.109.1.82', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5775, 450, '2018-03-21 11:53:15', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5776, 449, '2018-03-21 03:29:49', '186.95.207.243', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,62,62', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5777, 447, '2018-03-22 06:13:05', '186.167.249.203', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5778, 446, '2018-03-22 06:39:57', '186.167.249.252', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,67,63,65,65,64', '0', '0', 0, 0, 5, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5779, 451, '2018-03-22 07:01:25', '186.167.249.194', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5780, 447, '2018-03-22 07:31:01', '186.167.248.150', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5781, 447, '2018-03-22 07:31:01', '186.167.248.150', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,64,64,63', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5782, 447, '2018-03-22 08:05:21', '186.167.248.150', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,63,63,63', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5783, 447, '2018-03-22 08:20:37', '186.167.248.150', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,64', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5784, 450, '2018-03-22 07:38:30', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5785, 446, '2018-03-22 08:47:03', '186.167.248.101', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5786, 466, '2018-03-22 09:55:38', '190.153.70.231', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5787, 446, '2018-03-23 07:02:02', '186.167.248.119', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0,62,63,62,65,64,67', '0', '0', 0, 0, 6, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5788, 447, '2018-03-23 07:38:34', '186.167.244.170', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63,64', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5789, 445, '2018-03-23 08:32:53', '200.44.221.221', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5790, 445, '2018-03-23 08:32:55', '200.44.221.221', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '0,62,65,63', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5791, 446, '2018-03-23 02:23:09', '186.167.248.48', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5792, 451, '2018-03-24 07:21:58', '186.167.243.123', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63,62', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5793, 468, '2018-03-24 08:40:43', '186.92.77.203', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,67,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5794, 446, '2018-03-24 11:00:21', '186.167.248.161', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5795, 446, '2018-03-25 07:58:44', '186.167.243.134', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5796, 445, '2018-03-25 06:52:24', '201.249.4.169', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5797, 445, '2018-03-25 06:52:33', '201.249.4.169', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,62,63', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5798, 450, '2018-03-26 06:36:46', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5799, 446, '2018-03-26 01:03:58', '186.167.244.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5800, 444, '2018-03-26 07:12:05', '200.90.91.20', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5801, 469, '2018-03-26 07:33:37', '190.152.131.57', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5802, 446, '2018-03-27 02:28:29', '186.167.250.148', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5803, 446, '2018-03-27 08:31:22', '186.167.242.54', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5804, 446, '2018-03-27 07:49:12', '186.167.251.194', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5805, 446, '2018-03-28 07:25:02', '186.167.251.22', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63,64', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5806, 446, '2018-03-29 08:30:32', '186.167.250.20', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5807, 444, '2018-03-29 10:56:24', '200.44.206.184', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5808, 444, '2018-03-30 11:23:51', '201.210.67.38', 'Mozilla/5.0 (Windows NT 6.1; rv:59.0) Gecko/20100101 Firefox/59.0', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5809, 446, '2018-03-30 11:29:57', '200.84.44.219', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,64,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5810, 455, '2018-03-30 02:09:03', '186.167.243.55', 'Mozilla/5.0 (Linux; Android 4.4.2; GT-I9192 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,67,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5811, 455, '2018-03-30 02:37:31', '186.167.243.55', 'Mozilla/5.0 (Linux; Android 4.4.2; GT-I9192 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,67', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5812, 446, '2018-04-01 08:05:11', '186.167.244.89', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5813, 446, '2018-04-01 05:22:40', '186.167.250.141', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5814, 446, '2018-04-02 05:59:29', '186.167.245.224', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5815, 448, '2018-04-02 01:47:05', '186.185.70.127', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,62,62,65,66,62,63,63', '0', '0', 0, 0, 7, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5816, 450, '2018-04-02 03:11:07', '200.229.155.213', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5817, 450, '2018-04-02 04:53:39', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5818, 446, '2018-04-03 05:04:03', '186.167.248.168', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5819, 451, '2018-04-03 07:59:17', '186.167.250.234', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63,62', '0,368', '0', 0, 0, 2, 1, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5820, 446, '2018-04-04 04:23:42', '186.167.242.141', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5821, 445, '2018-04-04 10:23:59', '186.167.248.157', 'Mozilla/5.0 (Linux; Android 4.2.2; GT-I8200 Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.109 Mobile Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5822, 446, '2018-04-05 04:39:22', '186.167.242.236', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5823, 445, '2018-04-05 09:30:45', '190.199.225.153', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5824, 445, '2018-04-05 09:31:27', '190.199.225.153', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '0,65,64', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5825, 445, '2018-04-05 09:33:13', '190.199.225.153', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5826, 444, '2018-04-05 09:14:37', '200.90.67.235', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5827, 446, '2018-04-06 05:11:18', '186.167.250.3', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5828, 448, '2018-04-06 09:21:48', '186.167.245.186', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5829, 448, '2018-04-06 11:41:48', '186.167.248.211', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5830, 448, '2018-04-06 12:30:43', '186.167.248.211', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5831, 446, '2018-04-06 07:07:59', '186.167.242.171', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5832, 455, '2018-04-07 06:25:13', '186.167.245.58', 'Mozilla/5.0 (Linux; Android 4.4.2; GT-I9192 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36', '0,67,67', '0', '0', 0, 0, 2, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5833, 445, '2018-04-07 03:24:27', '186.167.244.93', 'Mozilla/5.0 (Linux; U; Android 4.1.2; es-es; GT-I8190 Build/JZO54K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30', '0,63,62,64', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5834, 446, '2018-04-07 04:09:54', '186.167.243.96', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63,62,64,67', '0', '0', 0, 0, 4, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5835, 445, '2018-04-07 05:01:35', '200.44.197.19', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,64,64,64', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5836, 444, '2018-04-07 06:32:39', '200.109.19.207', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5837, 445, '2018-04-08 09:28:32', '186.167.251.52', 'Mozilla/5.0 (Linux; Android 4.2.2; GT-I8200 Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.109 Mobile Safari/537.36', '0,64', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5838, 446, '2018-04-08 12:29:57', '186.167.248.103', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,64', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5839, 455, '2018-04-09 02:34:02', '190.205.249.39', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,67', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5840, 448, '2018-04-09 04:16:54', '186.167.249.135', 'Mozilla/5.0 (Linux; Android 4.2.2; C2105 Build/15.3.A.1.17) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.68 Mobile Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5841, 446, '2018-04-10 04:28:44', '186.167.244.26', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,64,67,64,67', '0', '0', 0, 0, 4, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5842, 448, '2018-04-10 09:29:54', '186.167.243.98', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63,63,63', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5843, 444, '2018-04-10 10:00:27', '201.249.18.251', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5844, 448, '2018-04-10 10:02:40', '186.167.250.209', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0', '0', '0', 0, 0, 0, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5845, 450, '2018-04-11 06:55:27', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5846, 451, '2018-04-11 07:06:18', '190.142.9.158', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5847, 450, '2018-04-11 08:58:58', '200.82.201.86', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5848, 449, '2018-04-11 10:31:38', '190.206.4.18', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '0,63,64', '0,368', '0', 0, 0, 2, 1, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5849, 444, '2018-04-11 11:12:49', '190.206.4.18', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '0,64', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5850, 449, '2018-04-11 11:21:12', '190.206.4.18', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5851, 444, '2018-04-11 11:30:15', '190.206.4.18', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5852, 449, '2018-04-11 11:35:18', '190.206.4.18', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5853, 448, '2018-04-11 11:44:42', '186.167.251.140', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5854, 450, '2018-04-11 01:08:43', '200.82.201.86', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63,64,63', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5855, 451, '2018-04-11 01:24:53', '186.167.244.15', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63,63,64', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5856, 445, '2018-04-11 02:29:19', '200.90.64.188', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5857, 445, '2018-04-11 02:35:54', '200.90.64.188', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '0,63,63,64', '0', '0', 0, 0, 3, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5858, 451, '2018-04-11 02:49:05', '186.167.245.15', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5859, 451, '2018-04-11 02:54:55', '186.167.245.15', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);
INSERT INTO `tbl_log_est` VALUES (5860, 445, '2018-04-11 03:02:41', '200.90.64.188', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36', '0,63', '0', '0', 0, 0, 1, 0, NULL, NULL);

-- ----------------------------
-- Table structure for tbl_mensaje_admin
-- ----------------------------
DROP TABLE IF EXISTS `tbl_mensaje_admin`;
CREATE TABLE `tbl_mensaje_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 admin to admin, 1 student to admin',
  `urgencia` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `de` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'remite',
  `para` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'admin_id',
  `subject` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fecha` datetime(0) NOT NULL COMMENT 'fecha de la ultima modificacion',
  `leido` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT 'si esta leido o no',
  `destinatario` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'campo que indica el destinatario del mensaje enviado, en caso de que sea individual o grupo',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tipo`(`tipo`) USING BTREE,
  INDEX `para`(`para`) USING BTREE,
  INDEX `de`(`de`) USING BTREE,
  CONSTRAINT `FK_mensaje_admin_1` FOREIGN KEY (`para`) REFERENCES `tbl_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 7168 kB; (`to`) REFER `edunet2/admin`(`id`) ON ' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_mensaje_admin
-- ----------------------------
INSERT INTO `tbl_mensaje_admin` VALUES (76, 1, 'Normal', 441, 2, '[CONSULTA] ', '<p>La didactica es una forma estrategica para evaluar y crear una estrategia de aprendizaje basada en un area en particular .En este caso se realizara en funcion a la asignatura de quimica basado en un tema en especifico.</p>', '2017-10-08 04:30:58', 1, NULL);
INSERT INTO `tbl_mensaje_admin` VALUES (77, 1, 'Normal', 446, 2, 'duda', '<p>Buenos dias prof, ya pude ingresar al sistema y ahora donde me ubico para los foros</p>', '2018-02-23 03:12:33', 1, NULL);
INSERT INTO `tbl_mensaje_admin` VALUES (78, 1, 'Normal', 446, 2, 'Duda', '<p>Buen dia prof, espero se encuentre bien. le escribo para aclarar dos dudas:</p>\r\n<p>1. xq el foro no fue aprobado si busque otra fuente y conte las palabras y estoy dentro de los parametros</p>\r\n<p>&nbsp;</p>\r\n<p>2. yo estoy en una electiva de quimica mabiental con usted y creo que va hacer por este curso, y solo me sale didactica&nbsp;</p>', '2018-03-03 05:40:45', 1, NULL);
INSERT INTO `tbl_mensaje_admin` VALUES (79, 1, 'Normal', 455, 2, '[CONSULTA] ', '<p>saludos estimada facilitadora, muy buenos los topicos se&ntilde;alados para la investigaci&oacute;n y descripci&oacute;n, siempre es bueno recordar tan importantes aspectos que salvaguardan nuestro planeta unico y hermoso la tierra.</p>', '2018-03-14 02:13:39', 1, NULL);

-- ----------------------------
-- Table structure for tbl_mensaje_est
-- ----------------------------
DROP TABLE IF EXISTS `tbl_mensaje_est`;
CREATE TABLE `tbl_mensaje_est`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 student to student, 1 profe to student',
  `urgencia` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `de` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'remite',
  `para` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'estudiante_id',
  `subject` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fecha` datetime(0) NOT NULL COMMENT 'fecha de la ultima modificacion',
  `leido` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT 'si esta leido o no',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tipo`(`tipo`) USING BTREE,
  INDEX `para`(`para`) USING BTREE,
  CONSTRAINT `FK_mensaje_est_1` FOREIGN KEY (`para`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 167 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 7168 kB; (`to`) REFER `edunet2/estudiante`(`id`' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_mensaje_est
-- ----------------------------
INSERT INTO `tbl_mensaje_est` VALUES (137, 1, 'Normal', 2, 445, 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-02-26 18:36:23', 0);
INSERT INTO `tbl_mensaje_est` VALUES (138, 1, 'Normal', 2, 444, 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-02-28 09:57:09', 0);
INSERT INTO `tbl_mensaje_est` VALUES (139, 1, 'Normal', 2, 447, 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-01 10:17:30', 1);
INSERT INTO `tbl_mensaje_est` VALUES (142, 1, 'Normal', 2, 446, '[RESPUESTA]  Duda', '<p>llama para aclarar</p>', '2018-03-04 08:03:52', 1);
INSERT INTO `tbl_mensaje_est` VALUES (143, 1, 'Normal', 2, 446, 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-05 14:58:45', 1);
INSERT INTO `tbl_mensaje_est` VALUES (144, 1, 'Normal', 2, 446, 'Su ultimo comentario en el Módulo foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-09 12:44:13', 1);
INSERT INTO `tbl_mensaje_est` VALUES (145, 1, 'Normal', 2, 448, 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-13 09:54:46', 1);
INSERT INTO `tbl_mensaje_est` VALUES (146, 1, 'Normal', 2, 446, 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-13 10:36:39', 1);
INSERT INTO `tbl_mensaje_est` VALUES (147, 1, 'Normal', 2, 444, 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-13 10:39:45', 0);
INSERT INTO `tbl_mensaje_est` VALUES (148, 1, 'Normal', 2, 447, 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-13 11:14:21', 1);
INSERT INTO `tbl_mensaje_est` VALUES (149, 1, 'Normal', 2, 446, 'Su ultimo comentario en el Módulo foro n 2 Ha sido aprobado.', 'Su ultimo comentario en el Módulo foro n 2 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-17 12:29:58', 1);
INSERT INTO `tbl_mensaje_est` VALUES (150, 1, 'Normal', 2, 450, 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-20 13:15:48', 0);
INSERT INTO `tbl_mensaje_est` VALUES (151, 1, 'Normal', 2, 445, 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-20 13:31:10', 0);
INSERT INTO `tbl_mensaje_est` VALUES (152, 1, 'Normal', 2, 446, 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-03-20 13:40:02', 1);
INSERT INTO `tbl_mensaje_est` VALUES (153, 1, 'Normal', 2, 449, 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-07 14:18:00', 0);
INSERT INTO `tbl_mensaje_est` VALUES (154, 1, 'Normal', 2, 451, 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-07 14:26:33', 1);
INSERT INTO `tbl_mensaje_est` VALUES (155, 1, 'Normal', 2, 444, 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-07 14:38:13', 0);
INSERT INTO `tbl_mensaje_est` VALUES (156, 1, 'Normal', 2, 445, 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-07 14:40:03', 0);
INSERT INTO `tbl_mensaje_est` VALUES (157, 1, 'Normal', 2, 447, 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-07 14:40:57', 0);
INSERT INTO `tbl_mensaje_est` VALUES (158, 1, 'Normal', 2, 446, 'Su ultimo comentario en el Módulo foro  n 3 Ha sido aprobado.', 'Su ultimo comentario en el Módulo foro  n 3 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-07 15:08:20', 1);
INSERT INTO `tbl_mensaje_est` VALUES (159, 1, 'Normal', 2, 448, 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-10 15:00:54', 1);
INSERT INTO `tbl_mensaje_est` VALUES (160, 1, 'Normal', 2, 446, 'Su ultimo comentario en el Módulo Foro N 4 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro N 4 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-10 15:04:22', 0);
INSERT INTO `tbl_mensaje_est` VALUES (161, 1, 'Normal', 2, 450, 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-11 12:37:22', 0);
INSERT INTO `tbl_mensaje_est` VALUES (162, 1, 'Normal', 2, 451, 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 2 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-11 12:38:49', 1);
INSERT INTO `tbl_mensaje_est` VALUES (163, 1, 'Normal', 2, 449, 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-11 12:43:31', 0);
INSERT INTO `tbl_mensaje_est` VALUES (164, 1, 'Normal', 2, 449, 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.', 'Su ultimo comentario en el Módulo Foro n 3 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-11 12:44:24', 0);
INSERT INTO `tbl_mensaje_est` VALUES (165, 1, 'Normal', 1, 455, 'Su ultimo comentario en el Módulo foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-11 15:05:03', 0);
INSERT INTO `tbl_mensaje_est` VALUES (166, 1, 'Normal', 1, 468, 'Su ultimo comentario en el Módulo foro n 1 Ha sido aprobado.', 'Su ultimo comentario en el Módulo foro n 1 Ha sido aprobado.<br>Gracias por participar en el foro', '2018-04-11 15:06:01', 0);

-- ----------------------------
-- Table structure for tbl_plan_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_estudiante`;
CREATE TABLE `tbl_plan_estudiante`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'item del plan evaluador que corresponde',
  `est_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'id del estudiante que tiene la nota',
  `nota` float(9, 4) NULL DEFAULT 0.0000 COMMENT 'nota real obtenida por el estudiante',
  `correccion` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'justificacion de la nota colocada',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `est_id`(`est_id`) USING BTREE,
  CONSTRAINT `plan_estudiante_fk` FOREIGN KEY (`item_id`) REFERENCES `tbl_plan_item` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `plan_estudiante_fk1` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla que almacena la nota del estudiante en cada item segun' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_plan_evaluador
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_evaluador`;
CREATE TABLE `tbl_plan_evaluador`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `grupo_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `titulo` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ',
  `en_base` tinyint(3) NOT NULL DEFAULT 0 COMMENT 'campo que explica en base a que porcentaje se evalua, la nota final',
  `redondeo` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'redondeo de notas al final',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `grupo_id`(`grupo_id`) USING BTREE,
  CONSTRAINT `tbl_plan_evaluador_fk` FOREIGN KEY (`grupo_id`) REFERENCES `tbl_grupo` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'tabla de planes\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_plan_evaluador
-- ----------------------------
INSERT INTO `tbl_plan_evaluador` VALUES (1, 3, 'PLAN DE EVALUACIÓN', 20, 1);
INSERT INTO `tbl_plan_evaluador` VALUES (3, 5, 'PLAN DE EVALUACION', 20, 1);
INSERT INTO `tbl_plan_evaluador` VALUES (4, 4, 'PLAN DE EVALUACION', 20, 1);
INSERT INTO `tbl_plan_evaluador` VALUES (5, 6, 'DIDACTICA Y EVALUACION DE LA QUIMICA', 20, 1);
INSERT INTO `tbl_plan_evaluador` VALUES (6, 7, 'Evaluacion', 20, 1);
INSERT INTO `tbl_plan_evaluador` VALUES (7, 6, 'DIDACTICA Y EVALUACION DE LA QUIMICA', 20, 1);
INSERT INTO `tbl_plan_evaluador` VALUES (8, 8, 'PLAN DE QUIMICA AMBIENTAL', 20, 1);

-- ----------------------------
-- Table structure for tbl_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `tbl_plan_item`;
CREATE TABLE `tbl_plan_item`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `titulo` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tipo` enum('foro','eval','proy','otro') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'foro' COMMENT 'el tipo de la actividad',
  `id_act` int(11) NOT NULL DEFAULT 0 COMMENT 'el id de la actividad en el caso de que sea foro,eval,proy sino es 0',
  `porcentaje` float(9, 4) NOT NULL DEFAULT 0.0000 COMMENT 'expresado en % sobre la nota final',
  `en_base` float(9, 4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `plan_id`(`plan_id`) USING BTREE,
  INDEX `tipo_act`(`tipo`, `id_act`) USING BTREE,
  CONSTRAINT `plan_item_fk` FOREIGN KEY (`plan_id`) REFERENCES `tbl_plan_evaluador` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de item a evaluar en el plan\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_plan_item
-- ----------------------------
INSERT INTO `tbl_plan_item` VALUES (2, 1, 'FORO Nº 2', 'foro', 3, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (3, 1, 'FORO Nº 3', 'foro', 4, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (5, 1, 'CONVERSATORIO Nº 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (6, 1, 'CONVERSATORIO Nº 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (7, 1, 'CONVERSATORIO Nº 3', 'foro', 18, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (9, 1, 'TALLER Nº 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (10, 1, 'TALLER Nº 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (11, 1, 'TALLER Nº 3', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (12, 1, 'CAP I', 'otro', 0, 15.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (13, 1, 'CAP II', 'otro', 0, 15.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (14, 1, 'CAP III', 'otro', 0, 15.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (15, 1, 'PROYECTO DE INVESTIGACIÓN', 'proy', 1, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (32, 3, 'FORO Nº 1', 'foro', 8, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (33, 3, 'FORO Nº 2', 'foro', 6, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (34, 3, 'FORO Nº 3', 'foro', 10, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (35, 3, 'TRABAJO Nº 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (36, 3, 'TRABAJO Nº 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (37, 3, 'EXPOSICION Nº 1', 'foro', 17, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (38, 3, 'EXPOSICION Nº 2', 'otro', 0, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (39, 3, 'CONVERSATORIO Nº 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (40, 3, 'CONVERSATORIO Nº 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (41, 3, 'CONVERSATORIO Nº 3', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (42, 3, 'CONVERSATORIO Nº 4', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (43, 3, 'ASESORIA GRUPAL Nº 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (44, 3, 'ASESORIA GRUPAL Nº 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (45, 3, 'ASESORIA GRUPAL Nº 3', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (46, 3, 'ASESORIA GRUPAL Nº 4', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (47, 3, 'MONOGRAFIA', 'otro', 0, 15.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (48, 4, 'EXPOSICION Nº 1', 'otro', 0, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (49, 4, 'EXPOSICION Nº 2', 'otro', 0, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (50, 4, 'FORO Nº 1', 'foro', 11, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (51, 4, 'FORO Nº 2', 'foro', 12, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (52, 4, 'FORO Nº 3', 'foro', 13, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (53, 4, 'FORO Nº 4', 'foro', 14, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (54, 4, 'TRABAJO Nº 1', 'foro', 15, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (55, 4, 'TRABAJO Nº 2', 'otro', 0, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (56, 4, 'ASESORIA GRUPAL Nº 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (57, 4, 'ASESORIA GRUPAL Nº 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (58, 4, 'ASESORIA GRUPAL Nº 3', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (60, 4, 'CONVERSATORIO Nº 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (61, 4, 'CONVERSATORIO Nº 2', 'foro', 19, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (62, 4, 'trabajo de investigacion', 'otro', 0, 15.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (63, 1, 'FORO Nº 1', 'foro', 2, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (64, 5, 'Foro n 1', 'foro', 25, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (65, 5, 'Foro n 2', 'foro', 24, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (66, 5, 'Foro n 3', 'foro', 23, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (67, 5, 'Foro N 4', 'foro', 26, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (68, 5, 'Foro N 5', 'foro', 27, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (69, 5, 'Foro n 6', 'foro', 28, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (70, 5, 'Foro N 7', 'foro', 29, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (71, 5, 'Foro N 8', 'foro', 30, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (72, 6, 'Foro N 1', 'foro', 25, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (73, 6, 'Foro N 2', 'foro', 24, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (74, 6, 'Foro N 3', 'foro', 23, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (75, 6, 'Foro N 4', 'foro', 26, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (76, 6, 'Foro N 5', 'foro', 27, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (77, 6, 'Foro n 6', 'foro', 28, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (78, 6, 'Foro N 7', 'foro', 29, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (79, 6, 'Foro N 8', 'foro', 30, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (80, 5, 'Micro Clase 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (81, 5, 'Micro Clase 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (82, 5, 'Micro Clase 3', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (83, 5, 'Micro Clase 4', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (84, 5, 'Micro Clase 5', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (85, 5, 'Micro Clase 6', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (86, 5, 'Micro Clase 7', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (87, 5, 'Micro Clase 8', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (88, 5, 'Conversatorio', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (89, 5, 'Propuesta Didáctica', 'proy', 2, 15.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (90, 6, 'Micro Clase 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (91, 6, 'Micro Clase 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (92, 6, 'Micro Clase 3', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (93, 6, 'Micro Clase 4', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (94, 6, 'Micro Clase 5', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (95, 6, 'Micro Clase 6', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (96, 6, 'Micro Clase 7', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (97, 6, 'Micro Clase 8', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (98, 6, 'Conversatorio', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (99, 6, 'Propuesta Didáctica', 'proy', 2, 15.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (100, 7, 'foro n 1', 'foro', 25, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (101, 7, 'foro n 2', 'foro', 24, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (102, 7, 'foro  n 3', 'foro', 23, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (103, 8, 'foro n 1', 'foro', 31, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (104, 8, 'foro n 2', 'foro', 32, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (105, 8, 'foro  n 3', 'foro', 33, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (106, 8, 'foro n 4', 'foro', 34, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (107, 8, 'foro  n 5', 'foro', 35, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (108, 8, 'Foro n 6', 'foro', 36, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (109, 8, 'Lectura n 1', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (110, 8, 'Lectura n 2', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (111, 8, 'Lectura n 3', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (112, 8, 'Lectura n 4', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (113, 8, 'Lectura n 5', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (114, 8, 'Lectura n 6', 'otro', 0, 5.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (115, 8, 'Conversatorio n 1', 'otro', 0, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (116, 8, 'Conversatorio n 2', 'otro', 0, 10.0000, 20.0000);
INSERT INTO `tbl_plan_item` VALUES (117, 8, 'Propuesta', 'otro', 0, 20.0000, 20.0000);

-- ----------------------------
-- Table structure for tbl_pregunta_opcion
-- ----------------------------
DROP TABLE IF EXISTS `tbl_pregunta_opcion`;
CREATE TABLE `tbl_pregunta_opcion`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `preg_id` int(10) UNSIGNED NOT NULL,
  `opcion` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `correcta` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `preg_id`(`preg_id`) USING BTREE,
  CONSTRAINT `pregunta_opcion_fk` FOREIGN KEY (`preg_id`) REFERENCES `tbl_evaluacion_pregunta` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'opciones para las preguntas de opcion multiple\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_proyecto
-- ----------------------------
DROP TABLE IF EXISTS `tbl_proyecto`;
CREATE TABLE `tbl_proyecto`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(125) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `autor` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `curso_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `contenido_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `grupo` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `enunciado` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT 'enunciado del proyecto',
  `fecha_entrega` datetime(0) NOT NULL,
  `fecha_edit` datetime(0) NULL DEFAULT NULL,
  `nota` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fecha_entrega`(`fecha_entrega`) USING BTREE,
  INDEX `contenido_id`(`contenido_id`) USING BTREE,
  CONSTRAINT `proyecto_fk` FOREIGN KEY (`contenido_id`) REFERENCES `tbl_contenido` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'tabla de proyectos\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_proyecto
-- ----------------------------
INSERT INTO `tbl_proyecto` VALUES (1, 'PROYECTO DE INVESTIGACION', 2, 13, 50, 3, '<p><strong><span style=\"color: #0000ff;\">Entrega del cap&iacute;tulo I, II y III del proyecto de investigaci&oacute;n&nbsp;</span></strong></p>', '2015-07-27 23:59:59', '2015-07-22 10:20:25', 100);
INSERT INTO `tbl_proyecto` VALUES (2, 'propuesta Didáctica', 1, 16, 66, 0, '<p><strong><em><span style=\"color: #000080;\">Portada</span></em></strong></p>\r\n<p><strong><em><span style=\"color: #000080;\">Introducci&oacute;n</span></em></strong></p>\r\n<p><strong><em><span style=\"color: #000080;\">Planteamiento del Problem</span></em></strong>a</p>\r\n<p><strong><em><span style=\"color: #000080;\">Objetivo</span></em></strong></p>\r\n<p><strong><em><span style=\"color: #000080;\">Planificac{on de la Propuesta</span></em></strong></p>\r\n<p><em><strong><span style=\"color: #000080;\">Conclusion</span></strong></em></p>', '2017-03-28 23:59:59', '2017-03-03 04:23:15', 15);

-- ----------------------------
-- Table structure for tbl_proyecto_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `tbl_proyecto_estudiante`;
CREATE TABLE `tbl_proyecto_estudiante`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proy_id` int(11) NOT NULL DEFAULT 0,
  `est_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `rec_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'id del recurso q fue subido por el estudiante',
  `correccion` mediumtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT 'justificacion de la nota colocada',
  `nota` float(5, 2) NOT NULL DEFAULT -1.00,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `proy_id`(`proy_id`) USING BTREE,
  INDEX `est_id`(`est_id`) USING BTREE,
  CONSTRAINT `proyecto_estudiante_fk` FOREIGN KEY (`proy_id`) REFERENCES `tbl_proyecto` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `proyecto_estudiante_fk1` FOREIGN KEY (`est_id`) REFERENCES `tbl_estudiante` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'tabla de notas de estudiantes en proyectos\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbl_proyecto_recurso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_proyecto_recurso`;
CREATE TABLE `tbl_proyecto_recurso`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proy_id` int(11) NOT NULL DEFAULT 0,
  `rec_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tipo` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 archivo, 1 enlace, 2 video',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `proy_id`(`proy_id`) USING BTREE,
  INDEX `rec_id`(`rec_id`) USING BTREE,
  CONSTRAINT `tbl_proyecto_recurso_fk` FOREIGN KEY (`proy_id`) REFERENCES `tbl_proyecto` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tbl_proyecto_recurso_fk1` FOREIGN KEY (`rec_id`) REFERENCES `tbl_recurso` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'tabla relacion que recursos tiene cada proyecto\r\nrevision VE' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_proyecto_recurso
-- ----------------------------
INSERT INTO `tbl_proyecto_recurso` VALUES (16, 1, 177, 0);
INSERT INTO `tbl_proyecto_recurso` VALUES (17, 1, 398, 0);
INSERT INTO `tbl_proyecto_recurso` VALUES (18, 1, 422, 0);
INSERT INTO `tbl_proyecto_recurso` VALUES (19, 1, 429, 0);
INSERT INTO `tbl_proyecto_recurso` VALUES (20, 1, 430, 0);
INSERT INTO `tbl_proyecto_recurso` VALUES (21, 2, 177, 0);
INSERT INTO `tbl_proyecto_recurso` VALUES (22, 2, 200, 0);
INSERT INTO `tbl_proyecto_recurso` VALUES (23, 2, 227, 0);

-- ----------------------------
-- Table structure for tbl_recurso
-- ----------------------------
DROP TABLE IF EXISTS `tbl_recurso`;
CREATE TABLE `tbl_recurso`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 descargable, 1 link, 2, video, 3 leible',
  `fecha` datetime(0) NOT NULL,
  `size` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ' COMMENT 'cuanto pesa',
  `dir` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'path o url',
  `add_by` enum('admin','est') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'admin',
  `persona` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'id de la persona quien lo agrego',
  `descripcion` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `download` smallint(6) NOT NULL DEFAULT 0 COMMENT 'numero de veces descargado',
  `fuente` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'fuente del archivo ejemplo youtube',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `tipo`(`tipo`) USING BTREE,
  INDEX `add_by_persona`(`add_by`, `persona`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 471 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tabla de recursos subidos por el admin o estudiantes\r\nrevisi' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbl_recurso
-- ----------------------------
INSERT INTO `tbl_recurso` VALUES (161, 0, '2009-11-27 11:14:27', '1.00 MB', 'bre_his_edu_vzla.pdf', 'admin', 2, NULL, 122, '');
INSERT INTO `tbl_recurso` VALUES (166, 0, '2009-11-27 11:36:20', '0.03 MB', 'PAUTAS PARA LA ELABORACION DE TRABAJOS.doc', 'admin', 2, 'Pautas generales para la elaboración de trabajos', 125, '');
INSERT INTO `tbl_recurso` VALUES (167, 0, '2009-11-27 11:42:03', '0.39 MB', 'Como_nace_un_paradigma.pps', 'admin', 2, 'Señala la posibilidad de origen de un modelo o Paradigma', 183, '');
INSERT INTO `tbl_recurso` VALUES (168, 1, '2009-11-27 04:48:07', '', 'http://www.slideshare.net/nancyvillagomez16/control-de-gestin-304639', 'admin', 2, 'presentación de los indicadores de gestión', 0, '');
INSERT INTO `tbl_recurso` VALUES (171, 0, '2009-12-01 07:18:24', '0.03 MB', 'PAUTAS PARA LA ELABORACION DE TRABAJOS[1].doc', 'admin', 2, 'PAUTAS PARA LA ELABORACIÓN DE TRABAJOS EN LA ASIGNATURA PRESUPUESTO', 88, '');
INSERT INTO `tbl_recurso` VALUES (172, 1, '2009-12-03 08:35:21', '', 'http://www.educar.org/articulos/laboratorioquimica.asp', 'admin', 2, NULL, 0, '');
INSERT INTO `tbl_recurso` VALUES (173, 1, '2009-12-03 08:48:00', '', 'http://www.eduteka.org/SoftQuimica.php', 'admin', 2, NULL, 0, '');
INSERT INTO `tbl_recurso` VALUES (177, 0, '2010-02-02 08:37:39', '0.03 MB', 'CONECTORES.doc', 'admin', 2, 'Conectores', 231, '');
INSERT INTO `tbl_recurso` VALUES (179, 0, '2010-02-11 08:35:27', '1.04 MB', 'Elprocesodeenseanza.pdf', 'admin', 2, 'diferentes tendencias de la planificación', 181, '');
INSERT INTO `tbl_recurso` VALUES (180, 0, '2010-03-04 08:54:51', '0.21 MB', 'estrategias.pdf', 'admin', 2, NULL, 114, '');
INSERT INTO `tbl_recurso` VALUES (182, 0, '2010-03-04 07:20:26', '0.14 MB', 'modulodeevaluacion.pdf', 'admin', 2, NULL, 82, '');
INSERT INTO `tbl_recurso` VALUES (183, 0, '2010-03-05 07:18:00', '0.03 MB', 'ESTRATEGIAS DIDACTICAS.mht', 'admin', 2, NULL, 141, '');
INSERT INTO `tbl_recurso` VALUES (188, 0, '2010-05-11 09:15:12', '0.05 MB', 'Analisis de Programas de Estudio.doc', 'admin', 2, NULL, 157, '');
INSERT INTO `tbl_recurso` VALUES (189, 0, '2010-05-25 07:55:31', '0.22 MB', 'Los Sistemas de Control de Gestion Estrategica para las organizaciones.doc', 'admin', 2, NULL, 137, '');
INSERT INTO `tbl_recurso` VALUES (190, 0, '2010-05-25 07:58:09', '0.09 MB', 'Control.ppt', 'admin', 2, NULL, 59, '');
INSERT INTO `tbl_recurso` VALUES (193, 0, '2011-02-25 09:20:58', '0.02 MB', 'Plan_Ev postG.xls', 'admin', 2, NULL, 11, '');
INSERT INTO `tbl_recurso` VALUES (194, 0, '2011-02-25 09:21:26', '0.04 MB', 'CRON DE ACT PostG.doc', 'admin', 2, NULL, 26, '');
INSERT INTO `tbl_recurso` VALUES (195, 1, '2011-02-25 09:22:25', '', 'http://www.youtube.com/watch?v=Uuq6QCQJyRc', 'admin', 2, NULL, 0, '');
INSERT INTO `tbl_recurso` VALUES (196, 0, '2011-02-25 09:38:44', '0.13 MB', 'BIOETICA.pps', 'admin', 2, NULL, 41, '');
INSERT INTO `tbl_recurso` VALUES (197, 0, '2011-02-25 09:39:07', '0.10 MB', 'Sabiduria.pps', 'admin', 2, NULL, 37, '');
INSERT INTO `tbl_recurso` VALUES (198, 0, '2011-02-25 09:39:37', '0.14 MB', 'Escenarios.para la toma de decisionespps.pps', 'admin', 2, NULL, 0, '');
INSERT INTO `tbl_recurso` VALUES (199, 0, '2011-02-25 09:39:41', '0.14 MB', 'Escenarios.para la toma de decisionespps.pps', 'admin', 2, NULL, 0, '');
INSERT INTO `tbl_recurso` VALUES (200, 0, '2011-02-25 09:42:03', '0.07 MB', 'FODA.doc', 'admin', 2, NULL, 19, '');
INSERT INTO `tbl_recurso` VALUES (201, 1, '2011-03-07 08:56:35', '', 'http://books.google.co.ve/books?id=seyjkUgT1f0C&printsec=frontcover&dq=pensamiento+lateral&hl=es&ei=l_B0TfT9GZL2gAewysCwBg&sa=X&oi=book_result&ct=result&resnum=1&ved=0CCQQ6AEwAA#v=onepage&q&f=false', 'admin', 2, 'Manual de Edward De Bono sobre Pensamiento Lateral', 0, '');
INSERT INTO `tbl_recurso` VALUES (202, 1, '2011-03-07 09:03:00', '', 'http://www.youtube.com/watch?v=u_zPldJo0tY', 'admin', 2, NULL, 0, '');
INSERT INTO `tbl_recurso` VALUES (203, 1, '2011-03-14 05:15:11', '', 'http://books.google.com/books?id=cTM8mm34AwYC&lpg=PP1&dq=tecnicas%20para%20la%20toma%20de%20decisiones&hl=es&pg=PA2#v=onepage&q&f=false', 'admin', 2, 'Guia de tècnicas para la Toma de decisiones', 0, '');
INSERT INTO `tbl_recurso` VALUES (204, 1, '2011-03-14 05:25:07', '', 'http://books.google.com/books?id=ab58g9_Z5CoC&lpg=PA168&dq=tecnicas%20para%20la%20toma%20de%20decisiones&hl=es&pg=PR6#v=onepage&q&f=false', 'admin', 2, NULL, 0, '');
INSERT INTO `tbl_recurso` VALUES (205, 1, '2011-03-15 05:27:38', '', 'http://books.google.com/books?id=-HaZW5xhMVgC&lpg=PP1&dq=simplicidad%20de%20Edward%20de%20Bono&hl=es&pg=PP1#v=onepage&q&f=false', 'admin', 2, 'Existen formas mas sencillas de hacer las cosas, hay que invertir esfuerzo en buscarlas...', 0, '');
INSERT INTO `tbl_recurso` VALUES (206, 1, '2011-03-22 10:51:59', '', 'http://books.google.com/books?id=Q-sd9FQvczQC&lpg=PP1&dq=empowerment&hl=es&pg=PA4#v=onepage&q&f=false', 'admin', 2, 'Una guia para facultar o empoderar a nuestro equipo', 0, '');
INSERT INTO `tbl_recurso` VALUES (208, 0, '2011-03-24 08:31:41', '0.50 MB', '2982651-Blanchard-Ken-A-la-carga.pdf', 'admin', 2, 'A la Carga!', 139, '');
INSERT INTO `tbl_recurso` VALUES (210, 0, '2011-03-25 08:47:14', '0.30 MB', 'sombreros[1].ppsx', 'admin', 2, 'Seis sombreros para pensar de Edward De Bono', 0, '');
INSERT INTO `tbl_recurso` VALUES (217, 1, '2011-04-04 01:09:25', '', 'http://books.google.com/books?id=P-ephICf5JwC&lpg=PA3&dq=didactica&hl=es&pg=PA3#v=onepage&q=didactica&f=false', 'admin', 2, 'manual de Didactica', 0, '');
INSERT INTO `tbl_recurso` VALUES (218, 1, '2011-04-04 01:17:59', '', 'http://books.google.com/books?id=I4bsSl5N7dcC&lpg=PP1&hl=es&pg=PA9#v=onepage&q&f=false', 'admin', 2, 'Didactica de hoy', 0, '');
INSERT INTO `tbl_recurso` VALUES (219, 0, '2011-04-04 01:34:09', '0.01 MB', 'Conversatorio.docx', 'admin', 2, 'descripcion de un conversatorio', 168, '');
INSERT INTO `tbl_recurso` VALUES (220, 0, '2011-04-04 01:35:02', '0.09 MB', 'Foros. descripcion, utilidad.doc', 'admin', 2, 'Foro, concepto, usos', 248, '');
INSERT INTO `tbl_recurso` VALUES (221, 1, '2011-04-05 03:18:30', '', 'http://www.tecnoedu.com/Soft/Quimica.php', 'admin', 2, NULL, 0, '');
INSERT INTO `tbl_recurso` VALUES (227, 0, '2011-04-07 09:40:33', '0.02 MB', 'temas para la propuesta didactica.doc', 'admin', 2, 'temas para la propuesta didactica', 148, '');
INSERT INTO `tbl_recurso` VALUES (241, 0, '2011-04-26 09:16:33', '0.11 MB', 'Clasificación de la Investigación.ppt', 'admin', 2, 'Clasificacion que permite conocer la importancia de las tecnicas documentales', 47, '');
INSERT INTO `tbl_recurso` VALUES (242, 0, '2011-05-18 11:04:25', '0.09 MB', 'FASES  DEL PEIC.ppt', 'admin', 2, 'Fases del Proyecto Educativo Integral Comunitario', 89, '');
INSERT INTO `tbl_recurso` VALUES (243, 0, '2011-05-18 11:05:36', '0.10 MB', 'ETAPAS DE UN PROYECTO DE APRENDIZAJE.ppt', 'admin', 2, 'Etapas de un Proyecto de Aprendizaje', 86, '');
INSERT INTO `tbl_recurso` VALUES (244, 0, '2011-05-20 01:15:46', '0.05 MB', 'PLAN DE EVALUACION DE TECNICAS DOCUMENTALES.doc', 'admin', 2, 'PLAN DE EVALUACION', 8, '');
INSERT INTO `tbl_recurso` VALUES (245, 0, '2011-05-20 08:41:13', '0.04 MB', 'Cronograma de tecnicas documentales.doc', 'admin', 2, 'Cronograma de Actividades de la asignatura Tecnicas documentales', 8, '');
INSERT INTO `tbl_recurso` VALUES (246, 1, '2011-05-20 10:14:40', '', 'http://books.google.com/books?id=RH_v8jDiHIQC&lpg=PP1&dq=metodologia%20de%20investigacion&hl=es&pg=PA25#v=onepage&q&f=false', 'admin', 2, 'Metodologìa de la Investigaciôn', 0, '');
INSERT INTO `tbl_recurso` VALUES (247, 1, '2011-05-20 10:20:50', '', 'http://books.google.com/books?id=BhymmEqkkJwC&lpg=PA1&hl=es&pg=PA45#v=onepage&q&f=false', 'admin', 2, 'El Proceso de la Investigaciòn Cientifica de Mario Tamayo', 0, '');
INSERT INTO `tbl_recurso` VALUES (248, 1, '2011-05-20 10:26:09', '', 'http://books.google.com/books?id=ir_Y4_6wU2wC&lpg=PP1&dq=centros%20de%20informaci%C3%B2n&hl=es&pg=PA11#v=onepage&q&f=false', 'admin', 2, 'Guia para la instalaciòn de un centro de informaciòn', 0, '');
INSERT INTO `tbl_recurso` VALUES (249, 1, '2011-05-20 10:30:48', '', 'http://books.google.com/books?id=M_N1CzTB2D4C&lpg=PP1&dq=trabajo%20de%20investigaci%C3%B2n&hl=es&pg=PP1#v=onepage&q&f=false', 'admin', 2, 'Elaboraciòn de trabajo de investigaciòn Rebeca Landeau', 0, '');
INSERT INTO `tbl_recurso` VALUES (251, 0, '2011-06-20 08:05:19', '0.03 MB', 'Aprendizajes esperados en la asignatura quimica inorganica.doc', 'admin', 2, 'contenidos conceptuales, actitudinales y procedimentales', 58, '');
INSERT INTO `tbl_recurso` VALUES (252, 0, '2011-06-27 01:08:41', '0.01 MB', 'Trabajo de investigación nº 1.docx', 'admin', 2, NULL, 10, '');
INSERT INTO `tbl_recurso` VALUES (253, 0, '2011-06-27 01:09:03', '0.02 MB', 'Trabajo de Investigacion Esquema Nº 2.doc', 'admin', 2, NULL, 13, '');
INSERT INTO `tbl_recurso` VALUES (254, 1, '2011-07-03 08:40:16', '', 'http://books.google.co.ve/books?id=4-4ZDg-63aQC&lpg=PP1&hl=es&pg=PA41#v=onepage&q&f=false', 'admin', 2, 'libro sobre la investigaciòn en la evaluaciòn cual es la mas conveniente', 0, '');
INSERT INTO `tbl_recurso` VALUES (256, 1, '2011-07-03 08:53:38', '', 'http://books.google.co.ve/books?id=1SzT9Ij_NNMC&lpg=PP1&hl=es&pg=PA16#v=onepage&q&f=false', 'admin', 2, 'Evaluacion', 0, '');
INSERT INTO `tbl_recurso` VALUES (280, 0, '2012-02-07 11:03:32', '0.03 MB', 'Trabajo de investigacion para el congreso.doc', 'admin', 2, 'pautas para trabajo de investigacion', 11, '');
INSERT INTO `tbl_recurso` VALUES (306, 1, '2012-05-12 11:03:38', ' ', 'http://www.youtube.com/watch?v=q3X1xEYhew0', 'admin', 2, 'la vaca', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (307, 1, '2012-05-14 11:05:44', ' ', 'http://books.google.co.ve/books?id=OWBokj2RqBYC&printsec=frontcover&dq=comportamiento+organizacional,+robbins&hl=es&sa=X&ei=5CaxT6_oN6WJ6AGywdHGCQ&ved=0CDIQ6AEwAA#v=onepage&q=comportamiento%20organizacional%2C%20robbins&f=false', 'admin', 2, 'Comportamiento organizacional de Robbins,S (1999)', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (308, 0, '2012-05-14 11:41:54', '0.06 MB', 'CRON DE ACT PostG C ORG.doc', 'admin', 2, 'plan de evaluaciòn- Cronograma de Actividades ', 35, NULL);
INSERT INTO `tbl_recurso` VALUES (310, 0, '2012-05-22 01:48:16', '0.02 MB', 'Guia para elaborar ensayo.pdf', 'admin', 2, 'Guia para ensayos', 60, NULL);
INSERT INTO `tbl_recurso` VALUES (311, 0, '2012-05-30 10:09:05', '0.24 MB', 'Roles de los gerentes.pdf', 'admin', 2, 'trabajo de investigaciòn de la UCLA  ', 56, NULL);
INSERT INTO `tbl_recurso` VALUES (312, 0, '2012-05-30 11:59:21', '0.02 MB', 'Bibliografia CO.doc', 'admin', 2, 'Bibliografia del curso Comportamiento Organizacional (ultima revisiòn: 30/05/2012)', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (314, 0, '2012-06-01 06:19:19', '0.05 MB', 'Competencias personales y gerenciales de los Directores y Subdirectores de las Escuelas Básicas.docx', 'admin', 2, 'Competencias de los gerentes de la ULA', 38, NULL);
INSERT INTO `tbl_recurso` VALUES (315, 0, '2012-06-10 12:17:04', '0.25 MB', 'Trabajo Final.doc', 'admin', 2, '', 61, NULL);
INSERT INTO `tbl_recurso` VALUES (316, 0, '2012-06-11 10:11:20', '0.02 MB', 'Guía para cursonet con trab final.doc', 'admin', 2, 'pasos para cursonet', 31, NULL);
INSERT INTO `tbl_recurso` VALUES (345, 0, '2012-10-29 12:54:09', '0.04 MB', 'PLAN DE EVALUACION QUIMICA 2012-2.doc', 'admin', 2, '', 25, NULL);
INSERT INTO `tbl_recurso` VALUES (348, 0, '2012-10-31 02:23:03', '0.03 MB', 'didactica.doc', 'admin', 2, '', 68, NULL);
INSERT INTO `tbl_recurso` VALUES (350, 1, '2012-11-14 07:33:38', ' ', 'http://www.educarchile.cl/Portal.Base/Web/VerContenido.aspx?ID=116688', 'admin', 2, 'Programas de Quimica  (Ministerio de Educación de Chile)', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (351, 0, '2012-11-14 07:46:10', '2.42 MB', 'experimento para jóvenes.pdf', 'admin', 2, 'experimentos para el aula', 14, NULL);
INSERT INTO `tbl_recurso` VALUES (352, 1, '2012-11-14 08:09:33', ' ', 'http://bitacora.rena.edu.ve/descarga-los-programas-educativos-para-las-materias-de-bachillerato/', 'admin', 2, 'Programas educativos- subsistema Media Diversificada', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (354, 0, '2012-11-19 05:43:16', '0.12 MB', 'Presupuestos TRABAJO DE EQUIPO.doc', 'admin', 2, 'ejemplo de trabajo biliográfico en equipo', 13, NULL);
INSERT INTO `tbl_recurso` VALUES (355, 1, '2012-11-19 05:44:41', ' ', 'http://www.onapre.gob.ve', 'admin', 2, '', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (356, 0, '2012-11-19 07:33:00', '0.04 MB', 'Presupuesto. Reseña histórica y otras consideraciones.doc', 'admin', 2, 'Material de lectura para el foro nº1', 29, NULL);
INSERT INTO `tbl_recurso` VALUES (357, 0, '2012-11-19 07:36:50', '0.11 MB', 'Presupuesto. nociones teóricas generales.doc', 'admin', 2, 'Lectura de Presupuesto', 19, NULL);
INSERT INTO `tbl_recurso` VALUES (358, 0, '2012-11-28 07:42:47', '0.05 MB', 'EVALUACION DE MICRO CLASE.doc', 'admin', 2, 'Formato de Evaluación de Micro Clase', 20, NULL);
INSERT INTO `tbl_recurso` VALUES (359, 0, '2012-11-28 07:46:44', '0.09 MB', 'misión 1.ppt', 'admin', 2, 'elementos ', 13, NULL);
INSERT INTO `tbl_recurso` VALUES (360, 0, '2012-11-28 07:52:50', '0.09 MB', 'visión.ppt', 'admin', 2, 'elementos de la visión', 8, NULL);
INSERT INTO `tbl_recurso` VALUES (364, 0, '2013-01-15 11:05:33', '0.05 MB', 'control de gestion.pps', 'admin', 2, '', 15, NULL);
INSERT INTO `tbl_recurso` VALUES (365, 0, '2013-01-22 10:04:39', '0.03 MB', 'PAUTAS propuesta quimica.doc', 'admin', 2, 'Pautas para el desarrollo y conformación de la Propuesta Didáctica', 18, NULL);
INSERT INTO `tbl_recurso` VALUES (366, 1, '2013-01-30 09:14:55', ' ', 'http://www.slideshare.net/cynthiazata/estrategias-de-enseanza-1415782', 'admin', 2, 'Que son las estrategias?', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (368, 0, '2013-02-06 10:51:48', '0.11 MB', 'Evaluacion micro clase individual.doc', 'admin', 2, 'Evaluación micro clase', 51, NULL);
INSERT INTO `tbl_recurso` VALUES (369, 0, '2013-02-15 07:32:08', '0.02 MB', 'Guía para la propuesta didáctica.doc', 'admin', 2, '', 20, NULL);
INSERT INTO `tbl_recurso` VALUES (391, 0, '2013-05-07 03:13:49', '0.04 MB', 'PIRAMIDE DE HANS KELSEN.doc', 'admin', 2, '', 5, NULL);
INSERT INTO `tbl_recurso` VALUES (392, 0, '2013-05-07 03:14:16', '0.12 MB', 'Pirámide de Hans Kelsen.ppt', 'admin', 2, '', 4, NULL);
INSERT INTO `tbl_recurso` VALUES (396, 1, '2013-05-29 08:17:29', ' ', 'http://es.wikipedia.org/wiki/Control_de_gesti%C3%B3n', 'admin', 2, 'DescripciÃ³n general de Control de GestiÃ³n', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (397, 1, '2013-05-29 08:19:46', ' ', 'http://www.monografias.com/trabajos82/estructura-del-sistema-educativo-venezolano/estructura-del-sistema-educativo-venezolano.shtml', 'admin', 2, 'OrganizaciÃ³n del sistema educativo venezolano', 0, NULL);
INSERT INTO `tbl_recurso` VALUES (398, 0, '2013-11-10 12:43:24', '0.07 MB', 'LINEAS DE INVESTIGACION QUÍMICA Y BIOLOGÍA.doc', 'admin', 2, 'Líneas de investigación', 67, NULL);
INSERT INTO `tbl_recurso` VALUES (403, 0, '2014-01-29 09:18:15', '0.04 MB', 'PLAN DE EVALUACION DE TEC DOC 71.doc', 'admin', 2, '', 21, NULL);
INSERT INTO `tbl_recurso` VALUES (404, 0, '2014-01-29 09:18:44', '0.04 MB', 'PLAN DE EVALUACION DE TEC DOC 90.doc', 'admin', 2, '', 2, NULL);
INSERT INTO `tbl_recurso` VALUES (412, 0, '2014-02-07 08:27:37', '0.04 MB', 'PLAN DE EVALUACIÓN INVES EDUCATIVA 2S-2013.doc', 'admin', 2, 'plan para evaluar el 2s-2013', 14, NULL);
INSERT INTO `tbl_recurso` VALUES (413, 0, '2014-02-08 12:34:08', '0.06 MB', 'PAUTAS PARA EXPOSICION DE INVESTIGACION EDUCATIVA.doc', 'admin', 2, 'ASPECTOS QUE SE TOMARAN COMO GUIA EN LA EXPOSICION', 10, NULL);
INSERT INTO `tbl_recurso` VALUES (414, 0, '2014-02-08 12:35:20', '0.06 MB', 'PAUTAS DE EXPOSICION DE SEMINARIO.doc', 'admin', 2, 'GUIA PARA EXPOSICION EN SEMINARIO', 5, NULL);
INSERT INTO `tbl_recurso` VALUES (415, 0, '2014-02-08 12:36:38', '0.05 MB', 'PAUTAS EXPOSICION TECNICAS DOCUMENTALES.doc', 'admin', 2, 'ORIENTACIONES PARA LA EXPOSICION EN TEC. DOCUMENTALES', 34, NULL);
INSERT INTO `tbl_recurso` VALUES (416, 0, '2014-02-11 07:58:48', '0.03 MB', 'CRONOGRAMA DE TECNICAS DOCUMENTALES 2-2013 71.doc', 'admin', 2, 'Actividades de la asignatura para el 2S- 2013 secc 71', 10, NULL);
INSERT INTO `tbl_recurso` VALUES (417, 0, '2014-02-11 07:59:46', '0.03 MB', 'CRONOGRAMA DE TECNICAS DOCUMENTALES 2-2013 90.doc', 'admin', 2, 'Actividades de la asignatura para el 2s-2013 secc 90', 8, NULL);
INSERT INTO `tbl_recurso` VALUES (421, 0, '2014-05-09 11:57:55', '0.03 MB', 'CRONOGRAMA REVISADO DE TEC DOCUMENTALES 2-2013.doc', 'admin', 2, '', 11, NULL);
INSERT INTO `tbl_recurso` VALUES (422, 0, '2014-06-18 11:23:32', '0.41 MB', 'NORMAS TRABAJOS BIOLOGIA Y QUÍMICA.ppt', 'admin', 2, 'Algunas normas para los trabajos de Investigación', 81, NULL);
INSERT INTO `tbl_recurso` VALUES (427, 0, '2014-10-27 07:06:42', '0.03 MB', 'CRONOGRAMA DE TECNICAS DOCUMENTALES U-2014.doc', 'admin', 2, 'ACTIVIDADES DE TECNICAS DOCUMENTALES', 3, NULL);
INSERT INTO `tbl_recurso` VALUES (428, 0, '2014-10-27 07:07:26', '0.04 MB', 'PLAN DE EVALUACION DE TEC DOC U-2014.doc', 'admin', 2, 'PLAN DE EVALUACIÃ“N DE TECNICAS DOCUMENALES', 2, NULL);
INSERT INTO `tbl_recurso` VALUES (429, 0, '2014-11-02 12:02:51', '0.02 MB', 'propuestas para investigar.doc', 'admin', 2, 'temas sugeridos para investigar', 66, NULL);
INSERT INTO `tbl_recurso` VALUES (430, 0, '2014-11-02 12:23:21', '0.06 MB', 'EvaluaciÃ³n de la presentaciÃ³n del trabajo.doc', 'admin', 2, 'EvaluaciÃ³n de la presentaciÃ³n de investigaciÃ³n de trabajos', 29, NULL);
INSERT INTO `tbl_recurso` VALUES (431, 0, '2014-11-02 01:22:44', '0.03 MB', 'Cronograma de Invest Educativa U-2014.doc', 'admin', 2, 'CRONOGRAMA DE INVESTIGACIÃ“N EDUCATIVA SEM U-2014', 11, NULL);
INSERT INTO `tbl_recurso` VALUES (433, 0, '2014-11-02 02:10:42', '0.04 MB', 'PLAN DE EVALUACIÃ“N INVES EDUCATIVA U-2014.doc', 'admin', 2, 'PLAN DE EVALUACIÃ“N DE INVESTIGACIÃ“N EDUCATIVA SEM U-2014', 8, NULL);
INSERT INTO `tbl_recurso` VALUES (434, 0, '2014-12-02 09:58:05', '0.02 MB', 'Normas para la monografÃ­a.doc', 'admin', 2, 'normas para la elaboraciÃ³n de la monografÃ­a', 27, NULL);
INSERT INTO `tbl_recurso` VALUES (445, 0, '2015-04-13 09:15:14', '0.03 MB', 'PAUTAS PARA CAPITULO I.doc', 'admin', 2, '', 23, NULL);
INSERT INTO `tbl_recurso` VALUES (446, 0, '2015-04-13 09:18:58', '0.03 MB', 'Cronograma de actividades del proyecto de investigación.doc', 'admin', 2, '', 3, NULL);
INSERT INTO `tbl_recurso` VALUES (447, 0, '2015-04-13 09:19:43', '0.04 MB', 'PLAN DE EVALUACION SEM PROY DE INVESTIGACIÓN.doc', 'admin', 2, '', 2, NULL);
INSERT INTO `tbl_recurso` VALUES (448, 0, '2015-04-14 09:59:20', '0.03 MB', 'CRONOGRAMA DE TECNICAS DOCUMENTALES 1-2015.doc', 'admin', 2, '', 9, NULL);
INSERT INTO `tbl_recurso` VALUES (449, 0, '2015-04-14 10:00:18', '0.04 MB', 'PLAN DE EVALUACION DE TEC DOC 1-2015.doc', 'admin', 2, '', 6, NULL);
INSERT INTO `tbl_recurso` VALUES (450, 0, '2015-04-24 09:05:52', '0.03 MB', 'Cronograma de Invest Educativa 1-2015.doc', 'admin', 2, '', 2, NULL);
INSERT INTO `tbl_recurso` VALUES (451, 0, '2015-04-24 09:06:13', '0.04 MB', 'PLAN DE EVALUACIÓN INVES EDUCATIVA 1-2015.doc', 'admin', 2, '', 2, NULL);
INSERT INTO `tbl_recurso` VALUES (461, 0, '2017-01-24 01:48:42', '0.02 MB', 'PLAN DE EVALUACION.odt', 'admin', 2, 'actividades de evaluacon', 1, NULL);
INSERT INTO `tbl_recurso` VALUES (462, 0, '2017-03-02 09:29:04', '0.03 MB', 'CRONOGRAMA DE ACTIVIDADES quim 2016-2.doc', 'admin', 2, 'Cronograma Didáctica 2-2016', 2, NULL);
INSERT INTO `tbl_recurso` VALUES (463, 0, '2017-03-02 09:31:08', '0.03 MB', 'Plan de evaluacion DIDACTICA 2016-2.doc', 'admin', 2, 'Plan de Evaluación Didáctica 2-2016', 3, NULL);
INSERT INTO `tbl_recurso` VALUES (464, 0, '2017-03-24 06:00:15', '0.05 MB', '20968726_propuesta didactica.docx', 'est', 420, NULL, 0, NULL);
INSERT INTO `tbl_recurso` VALUES (465, 0, '2017-03-25 04:53:47', '0.12 MB', '10481721_Propuesta educativa....docx', 'est', 434, NULL, 0, NULL);
INSERT INTO `tbl_recurso` VALUES (466, 0, '2017-03-26 03:03:24', '0.24 MB', '21477353_Propuesta Didactica.docx', 'est', 419, NULL, 0, NULL);
INSERT INTO `tbl_recurso` VALUES (467, 0, '2017-03-26 04:41:03', '0.05 MB', '24347383_PROPUESTA DIDÁCTICA.docx', 'est', 430, NULL, 0, NULL);
INSERT INTO `tbl_recurso` VALUES (468, 0, '2017-03-26 05:18:53', '0.06 MB', '22737809_UNIVERSIDAD DE CARABOBO.docx', 'est', 421, NULL, 0, NULL);
INSERT INTO `tbl_recurso` VALUES (469, 0, '2017-03-28 05:41:35', '0.05 MB', '19109699_quimica en la industria farmaceutica.docx', 'est', 422, NULL, 0, NULL);
INSERT INTO `tbl_recurso` VALUES (470, 0, '2017-03-28 09:32:29', '1.01 MB', '23435313_Popruesta de didactica.docx', 'est', 426, NULL, 0, NULL);

-- ----------------------------
-- Table structure for tbl_setup
-- ----------------------------
DROP TABLE IF EXISTS `tbl_setup`;
CREATE TABLE `tbl_setup`  (
  `id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `titulo` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `titulo_admin` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `modo` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `lenguaje` varchar(55) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `log` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `uni_nombre` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `uni_dir` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `uni_telefono` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ' ',
  `uni_fax` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uni_website` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uni_logo` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `signature` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `bienvenido_est` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'texto de bienvenida est',
  `fin_inscripcion` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'texto saliente al completar la insc',
  `formato_fecha` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'd/m/Y',
  `formato_fecha_db` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '%d/%m/%Y',
  `envio_email` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0 no envia email 1, envia email',
  `admin_email` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `titulo_ins` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `timezone` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'America/caracas' COMMENT 'zona horaria',
  `version` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'la version actual de cursonet',
  `dif_hora` smallint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'revision VE' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_setup
-- ----------------------------
INSERT INTO `tbl_setup` VALUES (1, 'Cursonet aprendizaje a distancia', 'Cursonet modo Profesor', 1, 'Castellano.php', 0, 'UNIVERSIDAD DE CARABOBO', '<p>CURSONET</p>', '', '', 'http://www.cursonet.net', '', '<div align=\"center\"><span style=\"color: #33ffff;\"><strong><span style=\"color: #ff6600;\">CURSONET 2017</span><br /></strong></span></div>', '<p align=\"center\"><strong><span style=\"color: #3333ff;\">Bienvenido a tus clases en linea </span></strong></p>', '<p><span style=\"color: #3300ff;\"><strong>Gracias por inscribirte, pronto me comunicar&eacute; contigo, no olvides mantenerte en contacto. cualquier duda puedes escribir a nancytovar13@gmail.com</strong></span></p>', 'd/m/Y', '%d/%m/%Y', 1, 'nancytovar13@gmail.com', 'Cursonet Inscripciones en Linea en la materia gerencia Ujap 2008', 'America/caracas', '1.9.2 beta', 30);

SET FOREIGN_KEY_CHECKS = 1;
