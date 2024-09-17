-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-09-2024 a las 22:10:47
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `fegs-soft-react`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ahorros_obligatorios`
--

CREATE TABLE `ahorros_obligatorios` (
  `idobligatorio` int(11) NOT NULL,
  `ahorro_ordinario` int(11) DEFAULT NULL,
  `ahorro_permanente` int(11) DEFAULT NULL,
  `usuariobli` int(11) DEFAULT NULL,
  `beneficios` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ahorros_obligatorios`
--

INSERT INTO `ahorros_obligatorios` (`idobligatorio`, `ahorro_ordinario`, `ahorro_permanente`, `usuariobli`, `beneficios`, `fecha`) VALUES
(3, 0, 0, 9, NULL, '2024-06-25 07:11:43'),
(4, 1000, 1000, 10, NULL, '2024-06-25 07:14:10'),
(5, 0, 0, 12, NULL, '2024-06-25 07:53:19'),
(6, 5000, 4555, 17, 3, '2024-08-27 23:38:59'),
(7, 0, 0, 29, 3, '2024-09-05 12:20:04');

--
-- Disparadores `ahorros_obligatorios`
--
DELIMITER $$
CREATE TRIGGER `after_update_ahorros_obligatorios` AFTER UPDATE ON `ahorros_obligatorios` FOR EACH ROW BEGIN
    -- Verificar si el campo 'ahorro_ordinario' fue modificado
    IF NEW.ahorro_ordinario <> OLD.ahorro_ordinario THEN
        INSERT INTO seg_ahorros_obligatorios (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.ahorro_ordinario - OLD.ahorro_ordinario, NEW.usuariobli, 'Ahorros obligatorios', 'Ahorro ordinario', NOW());
    END IF;

    -- Verificar si el campo 'ahorro_permanente' fue modificado
    IF NEW.ahorro_permanente <> OLD.ahorro_permanente THEN
        INSERT INTO seg_ahorros_obligatorios (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.ahorro_permanente - OLD.ahorro_permanente, NEW.usuariobli, 'Ahorros obligatorios', 'Ahorro permanente', NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ahorros_voluntarios`
--

CREATE TABLE `ahorros_voluntarios` (
  `idahorros` int(11) NOT NULL,
  `vista` int(11) DEFAULT NULL,
  `programado` int(11) DEFAULT NULL,
  `vacacional` int(11) DEFAULT NULL,
  `previo_vivienda` int(11) DEFAULT NULL,
  `usuariovolu` int(11) DEFAULT NULL,
  `beneficios` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ahorros_voluntarios`
--

INSERT INTO `ahorros_voluntarios` (`idahorros`, `vista`, `programado`, `vacacional`, `previo_vivienda`, `usuariovolu`, `beneficios`, `fecha`) VALUES
(1, 500, 300, 100, 100, 1, NULL, '2023-05-01 10:00:00'),
(4, 10000, 5000, 7000, 9000, 11, NULL, '2024-06-25 07:51:07'),
(5, 10000, 0, 0, 0, 11, NULL, '2024-06-25 07:57:04'),
(6, 15000, 10000, 0, 0, 20, NULL, '2024-08-01 15:28:35'),
(7, 4000, 6777, 8000, 400, 17, 2, '2024-08-27 23:38:30'),
(8, 4000, 6777, 8000, 400, 17, 2, '2024-08-27 23:38:30'),
(9, 500, 300, 400, 0, 29, 2, '2024-09-05 12:19:55');

--
-- Disparadores `ahorros_voluntarios`
--
DELIMITER $$
CREATE TRIGGER `after_update_ahorros_voluntarios` AFTER UPDATE ON `ahorros_voluntarios` FOR EACH ROW BEGIN
    -- Verificar si el campo 'vista' fue modificado
    IF NEW.vista <> OLD.vista THEN
        INSERT INTO seg_ahorros_voluntarios (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.vista - OLD.vista, NEW.usuariovolu, 'Ahorros voluntarios', 'Vista', NOW());
    END IF;

    -- Verificar si el campo 'programado' fue modificado
    IF NEW.programado <> OLD.programado THEN
        INSERT INTO seg_ahorros_voluntarios (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.programado - OLD.programado, NEW.usuariovolu, 'Ahorros voluntarios', 'Programado', NOW());
    END IF;

    -- Verificar si el campo 'vacacional' fue modificado
    IF NEW.vacacional <> OLD.vacacional THEN
        INSERT INTO seg_ahorros_voluntarios (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.vacacional - OLD.vacacional, NEW.usuariovolu, 'Ahorros voluntarios', 'Vacacional', NOW());
    END IF;

    -- Verificar si el campo 'previo_vivienda' fue modificado
    IF NEW.previo_vivienda <> OLD.previo_vivienda THEN
        INSERT INTO seg_ahorros_voluntarios (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.previo_vivienda - OLD.previo_vivienda, NEW.usuariovolu, 'Ahorros voluntarios', 'Previo vivienda', NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aso_bene`
--

CREATE TABLE `aso_bene` (
  `usuario` int(11) NOT NULL,
  `beneficios` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aso_bene`
--

INSERT INTO `aso_bene` (`usuario`, `beneficios`) VALUES
(1, 2),
(7, 1),
(7, 1),
(9, 3),
(9, 3),
(9, 3),
(9, 3),
(10, 3),
(11, 2),
(12, 3),
(11, 2),
(20, 2),
(29, 2),
(29, 3),
(29, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beneficios`
--

CREATE TABLE `beneficios` (
  `idbeneficios` int(11) NOT NULL,
  `tipo_beneficios` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `beneficios`
--

INSERT INTO `beneficios` (`idbeneficios`, `tipo_beneficios`) VALUES
(1, 'Creditos'),
(2, 'Ahorros Voluntarios'),
(3, 'Ahorros Obligatorios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creditos`
--

CREATE TABLE `creditos` (
  `idcreditos` int(11) NOT NULL,
  `rotativo` int(11) NOT NULL,
  `SEC` int(11) NOT NULL,
  `novedades_varias` int(11) NOT NULL,
  `compra_cartera` int(11) NOT NULL,
  `usuariocredi` int(11) NOT NULL,
  `beneficios` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `creditos`
--

INSERT INTO `creditos` (`idcreditos`, `rotativo`, `SEC`, `novedades_varias`, `compra_cartera`, `usuariocredi`, `beneficios`, `fecha`) VALUES
(1, 500, 200, 100, 300, 7, NULL, '2023-05-01 10:00:00'),
(3, 500, 1000, 200, 300, 17, 1, '2024-08-26 23:32:23'),
(4, 0, 0, 0, 0, 29, 1, '2024-09-05 12:20:13');

--
-- Disparadores `creditos`
--
DELIMITER $$
CREATE TRIGGER `after_update_creditos` AFTER UPDATE ON `creditos` FOR EACH ROW BEGIN
    -- Verificar si el campo 'rotativo' fue modificado
    IF NEW.rotativo <> OLD.rotativo THEN
        INSERT INTO seg_creditos (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.rotativo - OLD.rotativo, NEW.usuariocredi, 'Credito', 'Rotativo', NOW());
    END IF;

    -- Verificar si el campo 'SEC' fue modificado
    IF NEW.SEC <> OLD.SEC THEN
        INSERT INTO seg_creditos (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.SEC - OLD.SEC, NEW.usuariocredi, 'Credito', 'SEC', NOW());
    END IF;

    -- Verificar si el campo 'novedades_varias' fue modificado
    IF NEW.novedades_varias <> OLD.novedades_varias THEN
        INSERT INTO seg_creditos (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.novedades_varias - OLD.novedades_varias, NEW.usuariocredi, 'Credito', 'Novedades varias', NOW());
    END IF;

    -- Verificar si el campo 'compra_cartera' fue modificado
    IF NEW.compra_cartera <> OLD.compra_cartera THEN
        INSERT INTO seg_creditos (monto, usuario, beneficios, tipo_monto, fecha)
        VALUES (NEW.compra_cartera - OLD.compra_cartera, NEW.usuariocredi, 'Credito', 'Compra cartera', NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idrol` int(11) NOT NULL,
  `rol` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `rol`) VALUES
(1, 'Administrador'),
(2, 'Asesora'),
(3, 'Asociado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seg_ahorros_obligatorios`
--

CREATE TABLE `seg_ahorros_obligatorios` (
  `idsegO` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `usuario` int(11) NOT NULL,
  `beneficios` varchar(20) NOT NULL,
  `tipo_monto` varchar(50) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seg_ahorros_obligatorios`
--

INSERT INTO `seg_ahorros_obligatorios` (`idsegO`, `monto`, `usuario`, `beneficios`, `tipo_monto`, `fecha`) VALUES
(1, 1200.00, 5, '3', 'Ordinario', '2023-05-01 10:00:00'),
(2, 1200.00, 5, '3', 'Ordinario', '2023-05-01 10:00:00'),
(3, 0.00, 9, '3', 'Tipo de monto', '2024-06-25 07:10:13'),
(4, 0.00, 9, '3', 'Tipo de monto', '2024-06-25 07:10:18'),
(5, 0.00, 9, '3', 'Tipo de monto', '2024-06-25 07:10:22'),
(6, 0.00, 9, '3', 'Tipo de monto', '2024-06-25 07:11:43'),
(7, 0.00, 10, '3', 'Tipo de monto', '2024-06-25 07:14:10'),
(8, 0.00, 12, '3', 'Tipo de monto', '2024-06-25 07:53:19'),
(9, 5000.00, 17, 'Ahorros obligatorios', 'Ahorro ordinario', '2024-08-27 16:39:34'),
(10, 4555.00, 17, 'Ahorros obligatorios', 'Ahorro permanente', '2024-08-27 16:39:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seg_ahorros_voluntarios`
--

CREATE TABLE `seg_ahorros_voluntarios` (
  `idsegV` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `usuario` int(11) NOT NULL,
  `beneficios` varchar(20) NOT NULL,
  `tipo_monto` varchar(50) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seg_ahorros_voluntarios`
--

INSERT INTO `seg_ahorros_voluntarios` (`idsegV`, `monto`, `usuario`, `beneficios`, `tipo_monto`, `fecha`) VALUES
(1, 1000.00, 1, '2', 'Vista', '2023-05-01 10:00:00'),
(2, 1000.00, 1, '2', 'Vista', '2023-05-01 10:00:00'),
(4, 0.00, 11, '2', 'Tipo de monto', '2024-06-25 07:51:07'),
(5, 0.00, 11, '2', 'Tipo de monto', '2024-06-25 07:57:04'),
(6, 0.00, 20, '2', 'Tipo de monto', '2024-08-01 15:28:35'),
(7, 4000.00, 17, 'Ahorros voluntarios', 'Vista', '2024-08-27 16:38:52'),
(8, 6777.00, 17, 'Ahorros voluntarios', 'Programado', '2024-08-27 16:38:52'),
(9, 8000.00, 17, 'Ahorros voluntarios', 'Vacacional', '2024-08-27 16:38:52'),
(10, 400.00, 17, 'Ahorros voluntarios', 'Previo vivienda', '2024-08-27 16:38:52'),
(11, 4000.00, 17, 'Ahorros voluntarios', 'Vista', '2024-08-27 16:38:55'),
(12, 6777.00, 17, 'Ahorros voluntarios', 'Programado', '2024-08-27 16:38:55'),
(13, 8000.00, 17, 'Ahorros voluntarios', 'Vacacional', '2024-08-27 16:38:55'),
(14, 400.00, 17, 'Ahorros voluntarios', 'Previo vivienda', '2024-08-27 16:38:55'),
(15, 10000.00, 11, 'Ahorros voluntarios', 'Vista', '2024-09-16 16:35:15'),
(16, 20000.00, 20, 'Ahorros voluntarios', 'Vista', '2024-09-16 16:35:56'),
(17, 10000.00, 20, 'Ahorros voluntarios', 'Vista', '2024-09-16 16:36:26'),
(18, -15000.00, 20, 'Ahorros voluntarios', 'Vista', '2024-09-16 16:36:43'),
(19, 20000.00, 20, 'Ahorros voluntarios', 'Programado', '2024-09-16 16:37:32'),
(20, 10000.00, 20, 'Ahorros voluntarios', 'Programado', '2024-09-16 16:38:07'),
(21, -20000.00, 20, 'Ahorros voluntarios', 'Programado', '2024-09-16 16:38:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seg_creditos`
--

CREATE TABLE `seg_creditos` (
  `idsegC` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `usuario` int(11) NOT NULL,
  `beneficios` varchar(20) NOT NULL,
  `tipo_monto` varchar(50) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seg_creditos`
--

INSERT INTO `seg_creditos` (`idsegC`, `monto`, `usuario`, `beneficios`, `tipo_monto`, `fecha`) VALUES
(1, 1500.00, 7, '1', 'Rotativo', '2023-05-01 10:00:00'),
(2, 1500.00, 7, '1', 'Rotativo', '2023-05-01 10:00:00'),
(3, 0.00, 13, '1', 'Tipo de monto', '2024-06-25 08:17:15'),
(4, 500.00, 17, 'Credito', 'Rotativo', '2024-08-26 16:33:00'),
(5, 1000.00, 17, 'Credito', 'SEC', '2024-08-26 16:33:00'),
(6, 200.00, 17, 'Credito', 'Novedades varias', '2024-08-26 16:33:00'),
(7, 300.00, 17, 'Credito', 'Compra cartera', '2024-08-26 16:33:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `Nombre` varchar(150) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Documento` int(15) DEFAULT NULL,
  `Clave` varchar(100) DEFAULT NULL,
  `rol` int(11) DEFAULT NULL,
  `creditos` tinyint(1) DEFAULT NULL,
  `ahorros_obligatorio` tinyint(1) DEFAULT NULL,
  `ahorros_voluntario` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `Nombre`, `Correo`, `Documento`, `Clave`, `rol`, `creditos`, `ahorros_obligatorio`, `ahorros_voluntario`) VALUES
(1, 'Juan Perez', 'juan.perez@example.com', 123456789, 'password123', 3, 1, 1, 1),
(7, 'Emanuel', 'emanuel@example.com', 123456789, 'emanuel123', 3, 1, 1, 1),
(8, 'Emanuel', 'juan.perez@example.com', 123456789, 'password1234567', 1, 1, 1, 1),
(9, 'Carlos', 'carlo123@gmail.com', 43051196, 'carlos123', 3, NULL, NULL, NULL),
(10, 'Bryhan', 'bryhan@gmail.com', 12005, 'bryhan17', 3, NULL, NULL, NULL),
(11, 'luisa', 'lu@gmail.com', 259388, 'luisa1993', 3, NULL, NULL, NULL),
(12, 'jaime', 'jaime@gmail.com', 111111, '1234567', 3, NULL, NULL, NULL),
(14, 'Eliza', 'Eliza123@gmail.com', 12345678, '$2b$10$ZUgXf1tUZo12hzRKCkQ/yeawyF5RknNbghiqu9cUDMO397t7acaFW', 1, NULL, NULL, NULL),
(15, '12345678', '234234243', 42342434, '42342434', 3, NULL, NULL, NULL),
(16, 'german', 'jaime123@gmail.com', 123132122, '12345678', 3, NULL, NULL, NULL),
(17, 'pablito', 'jaime88@gmail.com', 2147483647, '5323543645', 3, NULL, NULL, NULL),
(19, '43543534554', 'dasdasdasd', 543543534, '$2b$10$aq81gEy7CpFQpc0hq8A4Pe20YsRqCQVePA4/TX0K42c8X5Aw0zF5e', 3, NULL, NULL, NULL),
(20, 'emanuel', 'ger123@gmail.com', 8304923, '$2b$10$ebXT5dzWfEEleBL/qfHvw.8rjOPI5i..Q6lvJ/Bdo6mW2i9IfTTSK', 3, NULL, NULL, NULL),
(21, 'fsafsafsaf', 'dsadsadsad', 2147483647, '$2b$10$RfawNcfqT63aJ6JUViLRuOypqTfHW2kPeceNj66LTE8jY9EJqwskW', 3, NULL, NULL, NULL),
(22, 'fsdfsdfdf', 'sfdsdfsdf', 2147483647, '$2b$10$GcNz29XFwkwoYkoc7Fy2welh9IoTc0t1Brgx7p1VubslDwfEk6vwG', 3, NULL, NULL, NULL),
(23, 'Allan', 'allan123@gmail.com', 2147483647, '$2b$10$anFKYFRzB/B/g1ihfTRQAu9/DcDl5cN3nBf4OL/1ahnM79hSS.Bde', 2, NULL, NULL, NULL),
(29, 'pepito', 'pepito31@gmail.com', 12131415, '$2b$10$en3IgQosclwmJdMXpQbhjuW0ebEHzAW7zEio0uTbCAudLMK.HxGyi', 3, NULL, NULL, NULL),
(30, 'liliana', 'liliana123@gmail.com', 1231231232, '$2b$10$MG.2HohBGeTHPmZTdpTQb.6KoY6rKHZpOECJfpEhVpLyWvumaCovm', 2, NULL, NULL, NULL),
(31, 'ana', 'ana123@gmail.com', 2147483647, '$2b$10$Zb4jYnbYgWph.uR0TUje4.ff73TrM2gW7I3j4cIgL.0lOQVoGkEKO', 2, NULL, NULL, NULL),
(32, 'palomita', 'paloma123@gmail.com', 2147483647, '$2b$10$NpIvPYz5pjWlqzjlV41XvO/HdX1Tyr/L/uVtcYGrGouFg3d5E5rky', 3, NULL, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ahorros_obligatorios`
--
ALTER TABLE `ahorros_obligatorios`
  ADD PRIMARY KEY (`idobligatorio`),
  ADD KEY `ahorros_obligatorios_ibfk_1` (`usuariobli`),
  ADD KEY `ahorros_obligatorios_ibfk_2` (`beneficios`);

--
-- Indices de la tabla `ahorros_voluntarios`
--
ALTER TABLE `ahorros_voluntarios`
  ADD PRIMARY KEY (`idahorros`),
  ADD KEY `ahorros_voluntarios_ibfk_1` (`usuariovolu`),
  ADD KEY `ahorros_voluntarios_ibfk_2` (`beneficios`);

--
-- Indices de la tabla `aso_bene`
--
ALTER TABLE `aso_bene`
  ADD KEY `aso_bene_ibfk_1` (`usuario`),
  ADD KEY `aso_bene_ibfk_2` (`beneficios`);

--
-- Indices de la tabla `beneficios`
--
ALTER TABLE `beneficios`
  ADD PRIMARY KEY (`idbeneficios`);

--
-- Indices de la tabla `creditos`
--
ALTER TABLE `creditos`
  ADD PRIMARY KEY (`idcreditos`),
  ADD KEY `creditos_ibfk_1` (`usuariocredi`),
  ADD KEY `creditos_ibfk_2` (`beneficios`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indices de la tabla `seg_ahorros_obligatorios`
--
ALTER TABLE `seg_ahorros_obligatorios`
  ADD PRIMARY KEY (`idsegO`);

--
-- Indices de la tabla `seg_ahorros_voluntarios`
--
ALTER TABLE `seg_ahorros_voluntarios`
  ADD PRIMARY KEY (`idsegV`);

--
-- Indices de la tabla `seg_creditos`
--
ALTER TABLE `seg_creditos`
  ADD PRIMARY KEY (`idsegC`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rol` (`rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ahorros_obligatorios`
--
ALTER TABLE `ahorros_obligatorios`
  MODIFY `idobligatorio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ahorros_voluntarios`
--
ALTER TABLE `ahorros_voluntarios`
  MODIFY `idahorros` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `beneficios`
--
ALTER TABLE `beneficios`
  MODIFY `idbeneficios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `creditos`
--
ALTER TABLE `creditos`
  MODIFY `idcreditos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `seg_ahorros_obligatorios`
--
ALTER TABLE `seg_ahorros_obligatorios`
  MODIFY `idsegO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `seg_ahorros_voluntarios`
--
ALTER TABLE `seg_ahorros_voluntarios`
  MODIFY `idsegV` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `seg_creditos`
--
ALTER TABLE `seg_creditos`
  MODIFY `idsegC` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ahorros_obligatorios`
--
ALTER TABLE `ahorros_obligatorios`
  ADD CONSTRAINT `ahorros_obligatorios_ibfk_1` FOREIGN KEY (`usuariobli`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ahorros_obligatorios_ibfk_2` FOREIGN KEY (`beneficios`) REFERENCES `beneficios` (`idbeneficios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ahorros_voluntarios`
--
ALTER TABLE `ahorros_voluntarios`
  ADD CONSTRAINT `ahorros_voluntarios_ibfk_1` FOREIGN KEY (`usuariovolu`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ahorros_voluntarios_ibfk_2` FOREIGN KEY (`beneficios`) REFERENCES `beneficios` (`idbeneficios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `aso_bene`
--
ALTER TABLE `aso_bene`
  ADD CONSTRAINT `aso_bene_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `aso_bene_ibfk_2` FOREIGN KEY (`beneficios`) REFERENCES `beneficios` (`idbeneficios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `creditos`
--
ALTER TABLE `creditos`
  ADD CONSTRAINT `creditos_ibfk_1` FOREIGN KEY (`usuariocredi`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `creditos_ibfk_2` FOREIGN KEY (`beneficios`) REFERENCES `beneficios` (`idbeneficios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
