-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июл 08 2018 г., 18:33
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_log` (IN `inputResult` VARCHAR(255))  NO SQL
INSERT INTO model_new_2(result) VALUES (inputResult)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_past_log` (IN `inputRes` VARCHAR(255), IN `inputInd` VARCHAR(255))  NO SQL
BEGIN
SET @id = 0;
SELECT id INTO @id FROM model_new WHERE indexs = inputInd;
INSERT INTO model_new_2(id, result) VALUES(@id, inputRes);
END$$

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
  `sv` varchar(128) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `model_new_2`
--

CREATE TABLE `model_new_2` (
  `id` int(128) NOT NULL,
  `result` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `model_new`
--
ALTER TABLE `model_new`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `indexs_3` (`indexs`),
  ADD KEY `indexs` (`indexs`,`sv`),
  ADD KEY `sv` (`sv`),
  ADD KEY `indexs_2` (`indexs`,`sv`);

--
-- Индексы таблицы `model_new_2`
--
ALTER TABLE `model_new_2`
  ADD KEY `time_2` (`id`,`result`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `model_new`
--
ALTER TABLE `model_new`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `model_new_2`
--
ALTER TABLE `model_new_2`
  MODIFY `id` int(128) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `model_new_2`
--
ALTER TABLE `model_new_2`
  ADD CONSTRAINT `model_new_2_ibfk_1` FOREIGN KEY (`id`) REFERENCES `model_new` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
