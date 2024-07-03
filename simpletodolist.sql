-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2024 at 07:04 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simpletodolist`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_types`
--

CREATE TABLE `activity_types` (
  `id` int(11) NOT NULL,
  `activities` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `activity_types`
--

INSERT INTO `activity_types` (`id`, `activities`) VALUES
(1, 'Reunion'),
(2, 'Desarrollo / Diseño'),
(3, 'Preparacion de Datos / Captura de Datos'),
(4, 'Documentacion'),
(5, 'Investigacion'),
(6, 'Planeacion'),
(7, 'Coordinar'),
(8, 'Reportes'),
(9, 'Actividad Fisica');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Trabajo'),
(2, 'Personal'),
(3, 'Negocio');

-- --------------------------------------------------------

--
-- Table structure for table `days`
--

CREATE TABLE `days` (
  `id` int(11) NOT NULL,
  `day` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `days`
--

INSERT INTO `days` (`id`, `day`) VALUES
(1, 'Lunes'),
(2, 'Martes'),
(3, 'Miercoles'),
(4, 'Jueves'),
(5, 'Viernes'),
(6, 'Sabado'),
(7, 'Domingo');

-- --------------------------------------------------------

--
-- Table structure for table `importances`
--

CREATE TABLE `importances` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `importances`
--

INSERT INTO `importances` (`id`, `name`) VALUES
(1, 'Importante'),
(2, 'No Importante');

-- --------------------------------------------------------

--
-- Table structure for table `importance_levels`
--

CREATE TABLE `importance_levels` (
  `id` int(11) NOT NULL,
  `importance` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `importance_levels`
--

INSERT INTO `importance_levels` (`id`, `importance`) VALUES
(1, '1'),
(2, '2'),
(3, '3'),
(4, '4'),
(5, '5');

-- --------------------------------------------------------

--
-- Table structure for table `mental_focus`
--

CREATE TABLE `mental_focus` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mental_focus`
--

INSERT INTO `mental_focus` (`id`, `name`) VALUES
(1, 'Enfoque Profundo'),
(2, 'Desconectar'),
(3, 'Control');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`) VALUES
(3, 'actividades de supervisor'),
(4, 'desarrollo personal'),
(5, 'certificacion PCI'),
(6, 'administracion'),
(7, 'diversion'),
(8, 'fisico sano'),
(9, 'ISO'),
(10, 'mejora en casa'),
(11, 'programacion'),
(12, 'reportes'),
(13, 'tareas semanales');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `day` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `proactive` varchar(250) NOT NULL,
  `project_id` int(11) NOT NULL,
  `priority_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `importance_id` int(11) NOT NULL,
  `urgency_id` int(11) NOT NULL,
  `action_to_take` varchar(250) NOT NULL,
  `activity_type_id` int(11) NOT NULL,
  `mental_focus_id` int(11) NOT NULL,
  `delegate` tinyint(1) NOT NULL,
  `was_delegated` tinyint(1) NOT NULL,
  `due_date` date NOT NULL,
  `task_arrived` datetime NOT NULL DEFAULT current_timestamp(),
  `started` datetime DEFAULT NULL,
  `finish` datetime DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `duration_since_arrival` varchar(50) DEFAULT NULL,
  `comments` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `day`, `date`, `proactive`, `project_id`, `priority_id`, `category_id`, `importance_id`, `urgency_id`, `action_to_take`, `activity_type_id`, `mental_focus_id`, `delegate`, `was_delegated`, `due_date`, `task_arrived`, `started`, `finish`, `duration`, `duration_since_arrival`, `comments`, `status`) VALUES
(3, 'Lunes', '2024-06-19', 'nueva tarea', 8, 4, 1, 1, 1, 'Hazlo YA', 2, 1, 1, 1, '2024-06-30', '2024-07-01 02:02:01', '2024-07-01 00:00:00', '2024-07-01 03:24:56', '3:24:56.509099', '1:22:55.509099', 'aqui lo que tengo que hacer es una tarea', 'completed'),
(4, 'Martes', '2024-07-01', 'tengo que oir al gym', 8, 5, 2, 1, 1, 'Hazlo YA', 4, 2, 1, 1, '2024-06-30', '2024-07-01 02:11:26', '2024-07-01 00:00:00', NULL, NULL, NULL, 'ir al gym', 'in progress'),
(5, 'Domingo', '2024-06-30', 'ir al gym', 8, 5, 1, 1, 1, 'Hazlo YA', 9, 2, 1, 1, '2024-06-30', '2024-07-01 03:35:12', '2024-07-01 03:35:42', '2024-07-01 03:35:50', '0:00:08.591958', '0:00:38.591958', 'tengo que ir al gym', 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `urgency_levels`
--

CREATE TABLE `urgency_levels` (
  `id` int(11) NOT NULL,
  `urgency_level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `urgency_levels`
--

INSERT INTO `urgency_levels` (`id`, `urgency_level`) VALUES
(1, 'Urgente'),
(2, 'No Urgente');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_types`
--
ALTER TABLE `activity_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `days`
--
ALTER TABLE `days`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `importances`
--
ALTER TABLE `importances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `importance_levels`
--
ALTER TABLE `importance_levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mental_focus`
--
ALTER TABLE `mental_focus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `urgency_levels`
--
ALTER TABLE `urgency_levels`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_types`
--
ALTER TABLE `activity_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `days`
--
ALTER TABLE `days`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `importances`
--
ALTER TABLE `importances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `importance_levels`
--
ALTER TABLE `importance_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `mental_focus`
--
ALTER TABLE `mental_focus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `urgency_levels`
--
ALTER TABLE `urgency_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
