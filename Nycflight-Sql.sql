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