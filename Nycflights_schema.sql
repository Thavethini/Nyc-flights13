SET AUTOCOMMIT = 0;

START TRANSACTION;

DROP SCHEMA IF EXISTS nycflights;
CREATE SCHEMA Nycflights CHARACTER SET utf8MB4;
USE Nycflights;

-- Création de la table flights :
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
     flight_id int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
     year char(4) ,
     month char(2),
     day char(2), 
     dep_time SMALLINT UNSIGNED,
     sched_dep_time SMALLINT UNSIGNED,
     dep_delay SMALLINT,
     arr_time SMALLINT UNSIGNED,
     sched_arr_time SMALLINT UNSIGNED,
     arr_delay SMALLINT,
     carrier char(2),
     flight VARCHAR (4),
     tailnum char(6), 
     origin char(3),
     dest char(3),
     air_time SMALLINT UNSIGNED,
     distance SMALLINT UNSIGNED,
     hour char(2),
     minute char(2),
     time_hour VARCHAR(20)-- year+month+day+hour (sans les minutes)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ; 
SHOW WARNINGS ;-- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).

-- Création de la table airlines :
DROP TABLE IF EXISTS airlines ;
CREATE TABLE airlines ( 
     carrier char(2) PRIMARY KEY,
     name VARCHAR(30)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ; 
SHOW WARNINGS ;-- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).



-- Création de la table planes :
DROP TABLE IF EXISTS planes ;
CREATE TABLE planes 
(
     tailnum char (6) PRIMARY KEY,
 year char(4),
 type VARCHAR (25),
 manufacturer VARCHAR(30),
 model VARCHAR(20),
 engines TINYINT,
 seats SMALLINT,
 speed SMALLINT UNSIGNED,
 engine VARCHAR(15) 
     
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ; 
SHOW WARNINGS ;-- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).


-- Création de la table airports :
DROP TABLE IF EXISTS airports ;
CREATE TABLE airports 
(
     faa VARCHAR(3) PRIMARY KEY,
     name VARCHAR(55),
     lat SMALLINT UNSIGNED,
     lon SMALLINT,
     alt SMALLINT,
     tz TINYINT,
     dst VARCHAR(1),
     tzone VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ; 
SHOW WARNINGS ;-- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).


-- Création de la table weather :
DROP TABLE IF EXISTS weather ;
CREATE TABLE weather 
(    origin char(3),
     year char(4),
     month CHAR(2),
     day CHAR(2),
     hour CHAR(2),
     temp DECIMAL(5,2),
     dewp DECIMAL(4,2),
     humid DECIMAL(5,2),
     wind_dir SMALLINT,
     wind_speed SMALLINT,    -- ça passe sinon decimal ?
     wind_gust SMALLINT,
     precip TINYINT,         --
     pressure SMALLINT,
     visib TINYINT,
     time_hour VARCHAR(20),
     PRIMARY KEY (year, month, day, hour, origin) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ; 
SHOW WARNINGS ;-- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).

SET AUTOCOMMIT = 1;

-- FIN DE FICHIER SCHEMA