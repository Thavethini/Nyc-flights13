SHOW DATABASES;
USE Nycflights;
SOURCE C:\Users\x\Documents\R\Nycflights-db\Nycflights_schema.sql
SOURCE C:\Users\x\Documents\R\Nycflights-db\Nycflights_data.sql


SELECT * FROM planes WHERE year IS NULL;

SELECT count(*) FROM weather;
SELECT count(*) FROM flights;
SELECT count(*) FROM planes;
SELECT count(*) FROM airports;
SELECT count(*) FROM airlines;

SELECT dest
 FROM flights
 RIGHT JOIN airports ON flights.dest = airports.faa
 WHERE dest IS NULL;

select count(distinct dest) from flights ;
select distinct dest AS dest_uniq from flights; 



select count(*) from (select distinct flights.tailnum from flights left join planes on planes.tailnum=flights.tailnum where planes.tailnum is null) as A;

#Pour trouver les clés présentes dans flights mais pas dans weather :
CREATE INDEX ind_flights ON flights (year, month, day, hour, origin); -- pour accélérer les requêtes. 

SELECT DISTINCT year, month, day, hour, origin 
    FROM flights 
        WHERE (year, month, day, hour, origin) 
            NOT IN (SELECT DISTINCT year, month, day, hour, origin FROM weather);



#Erratum : dans mon message plus haut (envoyé le 18/03 à 11:52), j'ai dit que l'index (copié ci-dessous) permettait d’accélérer la requête SQL qui suivait. C'est complètement faux car dans ma clause WHERE, les valeurs des variables/colonnes citées ne sont pas renseignées.
CREATE INDEX id_flights ON flights (year, month, day, hour, origin); -- pour accélérer les requêtes. 






--Projet nycflights :Pour pouvoir créer une FK entre flights et weather, il fallait trouver les enregistrements présents dans fligths mais pas dans weather pour les injecter dans weather.
 
La requête SQL qui permettait cette recherche, composé d'un SELECT imbriqué, est beaucoup trop longue à s'exécuter. 
Ci-dessous, une proposition qui optimise cette requête :
--------------------------------------------------------------------------
-- On crée des tables temporaires sur flights et weather qui vont 
-- contenir le résultat des deux 'SELECT DISTINCT' sur (year, month, day, hour, origin) :
CREATE TEMPORARY TABLE temp_flight AS (SELECT DISTINCT year, month, day, hour, origin FROM flights); 
CREATE TEMPORARY TABLE temp_weather AS (SELECT DISTINCT year, month, day, hour, origin FROM weather);

-- Pour accélérer nos requêtes sur ces tables temporaire, on leur affecte la PK(year, month, day, hour, origin FROM flights) 
-- qui est unique et non null puisqu'elle a été précédement générée par un 'SELECT DISTINCT' :
ALTER TABLE temp_flight ADD PRIMARY KEY (year, month, day, hour, origin) ;
ALTER TABLE temp_weather ADD PRIMARY KEY (year, month, day, hour, origin) ;

-- On lance la requête pour trouver les PK présentes dans flights mais pas dans weather (81 lignes) :
SELECT * FROM temp_flight WHERE (year, month, day, hour, origin) NOT IN (SELECT * FROM temp_weather) ;  

-- L'EXPLAIN suivant montre comment la requête précédente s'exécute :
EXPLAIN SELECT * FROM temp_flight WHERE (year, month, day, hour, origin) NOT IN (SELECT * FROM temp_weather) ;

-- Ajout des 81 lignes absentes de la table weather mais présentes dans la table flights :
INSERT INTO weather (year, month, day, hour, origin) 
    SELECT * FROM temp_flight 
        WHERE (year, month, day, hour, origin) 
            NOT IN (SELECT * FROM temp_weather) ;
 --------------------------------------------------------------------------