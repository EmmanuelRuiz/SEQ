-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-05-2016 a las 19:09:15
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 7.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `koans`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `directores`
--

CREATE TABLE `directores` (
  `id_director` int(5) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `RFC` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `directores`
--

INSERT INTO `directores` (`id_director`, `nombre`, `apellido`, `clave`, `email`, `RFC`) VALUES
(101, 'LOL', 'LOL', 'LOL', 'LOL', 'LOL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escuelas`
--

CREATE TABLE `escuelas` (
  `id_escuela` int(5) NOT NULL,
  `nombre_escuela` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `id_zonaEscolar` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `escuelas`
--

INSERT INTO `escuelas` (`id_escuela`, `nombre_escuela`, `direccion`, `id_zonaEscolar`) VALUES
(501, 'Colegio de Estudios Cientificos y Tecnologicos', 'allá', 601);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escuelasprofesores`
--

CREATE TABLE `escuelasprofesores` (
  `id_escuelaProfesor` int(5) NOT NULL,
  `id_profesor` int(5) NOT NULL,
  `id_escuela` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `escuelasprofesores`
--

INSERT INTO `escuelasprofesores` (`id_escuelaProfesor`, `id_profesor`, `id_escuela`) VALUES
(1, 501, 201);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

CREATE TABLE `profesores` (
  `id_profesor` int(5) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `RFC` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `profesores`
--

INSERT INTO `profesores` (`id_profesor`, `nombre`, `apellido`, `clave`, `email`, `RFC`) VALUES
(201, 'Julián', 'Villegas Alonzo', 'Julian', 'julian@outlook.com', 'B8');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supervisores`
--

CREATE TABLE `supervisores` (
  `id_supervisor` int(5) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `RFC` varchar(50) NOT NULL,
  `id_zonaEscolar` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `supervisores`
--

INSERT INTO `supervisores` (`id_supervisor`, `nombre`, `apellido`, `clave`, `email`, `RFC`, `id_zonaEscolar`) VALUES
(1, 'Emmanuel', 'Ruiz Estrada', 'Emmanuel', 'emmanuelre123@outlook.com', 'B7', 601);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zonasescolares`
--

CREATE TABLE `zonasescolares` (
  `id_zonaEscolar` int(5) NOT NULL,
  `cod_zona` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `zonasescolares`
--

INSERT INTO `zonasescolares` (`id_zonaEscolar`, `cod_zona`) VALUES
(601, '010'),
(602, '020'),
(603, '040'),
(604, '044'),
(605, '045'),
(606, '048'),
(607, '053');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `directores`
--
ALTER TABLE `directores`
  ADD PRIMARY KEY (`id_director`),
  ADD UNIQUE KEY `id_director` (`id_director`);

--
-- Indices de la tabla `escuelas`
--
ALTER TABLE `escuelas`
  ADD PRIMARY KEY (`id_escuela`),
  ADD UNIQUE KEY `id_escuela` (`id_escuela`);

--
-- Indices de la tabla `escuelasprofesores`
--
ALTER TABLE `escuelasprofesores`
  ADD PRIMARY KEY (`id_escuelaProfesor`),
  ADD UNIQUE KEY `id_escuelaProfesor` (`id_escuelaProfesor`),
  ADD KEY `id_profesor` (`id_profesor`),
  ADD KEY `id_escuela` (`id_escuela`);

--
-- Indices de la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD PRIMARY KEY (`id_profesor`),
  ADD UNIQUE KEY `id_profesor` (`id_profesor`);

--
-- Indices de la tabla `supervisores`
--
ALTER TABLE `supervisores`
  ADD PRIMARY KEY (`id_supervisor`),
  ADD UNIQUE KEY `id_supervisor` (`id_supervisor`);

--
-- Indices de la tabla `zonasescolares`
--
ALTER TABLE `zonasescolares`
  ADD PRIMARY KEY (`id_zonaEscolar`),
  ADD UNIQUE KEY `id_zonaEscolar` (`id_zonaEscolar`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `directores`
--
ALTER TABLE `directores`
  MODIFY `id_director` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;
--
-- AUTO_INCREMENT de la tabla `escuelas`
--
ALTER TABLE `escuelas`
  MODIFY `id_escuela` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=502;
--
-- AUTO_INCREMENT de la tabla `escuelasprofesores`
--
ALTER TABLE `escuelasprofesores`
  MODIFY `id_escuelaProfesor` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `profesores`
--
ALTER TABLE `profesores`
  MODIFY `id_profesor` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;
--
-- AUTO_INCREMENT de la tabla `supervisores`
--
ALTER TABLE `supervisores`
  MODIFY `id_supervisor` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `zonasescolares`
--
ALTER TABLE `zonasescolares`
  MODIFY `id_zonaEscolar` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=608;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
