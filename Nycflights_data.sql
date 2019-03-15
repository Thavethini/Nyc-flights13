USE Nycflights;

TRUNCATE TABLE flights;

-- Chargement de la table flights depuis un fichier csv.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/flights.csv'
INTO TABLE flights
FIELDS TERMINATED BY ',' -- separateur: ;|
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'  -- '\r\n' for windows
ignore 1 lines               -- 0 lines ça marche
-- (col_name1, col_name2, col_name3)
(year,month,day,@vdep_time,sched_dep_time,@vdep_delay,@varr_time,sched_arr_time,@varr_delay,carrier,flight,@vtailnum,origin,dest,@vair_time,distance,hour,minute,time_hour)
SET 
dep_time = nullif(@vdep_time,'NA'),
dep_delay = nullif(@vdep_delay,'NA'),
arr_time = nullif(@varr_time,'NA'),
arr_delay = nullif(@varr_delay,'NA'),
tailnum = nullif(@vtailnum,'NA'),
air_time = nullif(@vair_time,'NA');
SHOW WARNINGS ; -- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).


-- Chargement de la table airlines depuis un fichier csv.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/airlines.csv'
INTO TABLE airlines
FIELDS TERMINATED BY ',' -- separateur: ;|
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'  -- '\r\n' for windows
ignore 1 lines               -- 0 lines ça marche
-- (col_name1, col_name2, col_name3)
(carrier,name);
SHOW WARNINGS ; -- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).


-- Chargement de la table planes depuis un fichier csv.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/planes.csv'
INTO TABLE planes
FIELDS TERMINATED BY ',' -- separateur: ;|
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'  -- '\r\n' for windows
ignore 1 lines               -- 0 lines ça marche
-- (col_name1, col_name2, col_name3)
(tailnum,@vyear,type,manufacturer,model,engines,seats,@vspeed,engine)
SET
year = nullif(@vyear,'NA'),
speed = nullif(@vspeed,'NA');
SHOW WARNINGS ; -- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).


-- Chargement de la table airports depuis un fichier csv.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/airports.csv'
INTO TABLE airports
FIELDS TERMINATED BY ',' -- separateur: ;|
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'  -- '\r\n' for windows
ignore 1 lines               -- 0 lines ça marche
-- (col_name1, col_name2, col_name3)
(faa,name,lat,lon,alt,tz,dst,tzone);
SHOW WARNINGS ; -- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).


-- Chargement de la table weather depuis un fichier csv.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nycflights/weather.csv'
INTO TABLE weather
FIELDS TERMINATED BY ',' -- separateur: ;|
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'  -- '\r\n' for windows
ignore 1 lines               -- 0 lines ça marche
-- (col_name1, col_name2, col_name3)
(origin,year,month,day,hour,@vtemp,@vdewp,@vhumid,@vwind_dir,@vwind_speed,@vwind_gust,precip,@vpressure,visib,time_hour)
SET
temp = nullif(@vtemp,'NA'),
dewp = nullif(@vdewp,'NA'),
humid = nullif(@vhumid,'NA'),
wind_dir = nullif(@vwind_dir,'NA'),
wind_speed = nullif(@vwind_speed,'NA'),
wind_gust = nullif(@vwind_gust,'NA'),
pressure = nullif(@vpressure,'NA');
SHOW WARNINGS ; -- Permet de capturer les erreurs et warnings générés par la rêquete précédente (en mode d'exécution manuel).

INSERT INTO airports (faa, name)
	VALUES ('BQN', 'Rafael Hernandez Airport'),
		('PSE', 'Mercedita Airport'),
		('SJU', 'San Juan Airport'),
		('STT', 'Cyril E. King Airport');

ALTER TABLE flights
ADD CONSTRAINT FK_airports_flights FOREIGN KEY(dest)
REFERENCES airports(faa);

ALTER TABLE flights
ADD CONSTRAINT FK_airp_flights FOREIGN KEY(origin)
REFERENCES airports(faa);

ALTER TABLE flights
ADD CONSTRAINT FK_airl_flights FOREIGN KEY(carrier)
REFERENCES airlines(carrier);

ALTER TABLE weather
ADD CONSTRAINT FK_airp_weather FOREIGN KEY(origin)
REFERENCES airports(faa);

INSERT INTO planes (tailnum)
SELECT distinct tailnum FROM flights
WHERE tailnum NOT IN (SELECT tailnum FROM planes)

ALTER TABLE flights
ADD CONSTRAINT FK_flights_planes FOREIGN KEY(tailnum)
REFERENCES planes(tailnum);

SET AUTOCOMMIT = 1;

-- FIN DE FICHER DATA