-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июл 07 2018 г., 13:02
-- Версия сервера: 10.1.33-MariaDB
-- Версия PHP: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tmp_new`
--
CREATE DATABASE IF NOT EXISTS `tmp_new` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `tmp_new`;

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_model` (IN `time` VARCHAR(128) CHARSET utf8, IN `levelname` VARCHAR(128) CHARSET utf8, IN `CoefficientsOfX` VARCHAR(128) CHARSET utf8, IN `freeCoefficients` VARCHAR(256) CHARSET utf8, IN `result` VARCHAR(128) CHARSET utf8)  NO SQL
INSERT into model_new_2(time, levelname, message, freeCoefficients, result ) VALUES(time, levelname, CoefficientsOfX, freeCoefficients, result)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_model` (IN `ind` VARCHAR(128) CHARSET utf8, IN `insv` VARCHAR(128) CHARSET utf8)  NO SQL
INSERT into model_new(indexs, sv) VALUES(ind, insv)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `model_new`
--

CREATE TABLE `model_new` (
  `indexs` varchar(128) NOT NULL,
  `sv` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `model_new_2`
--

CREATE TABLE `model_new_2` (
  `time` varchar(128) NOT NULL,
  `levelname` varchar(128) NOT NULL,
  `message` varchar(128) NOT NULL,
  `freeCoefficients` varchar(128) NOT NULL,
  `result` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `model_new`
--
ALTER TABLE `model_new`
  ADD KEY `indexs` (`indexs`,`sv`),
  ADD KEY `sv` (`sv`),
  ADD KEY `indexs_2` (`indexs`,`sv`);

--
-- Индексы таблицы `model_new_2`
--
ALTER TABLE `model_new_2`
  ADD KEY `time` (`time`,`levelname`,`message`,`freeCoefficients`,`result`),
  ADD KEY `time_2` (`time`,`levelname`,`message`,`freeCoefficients`,`result`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
