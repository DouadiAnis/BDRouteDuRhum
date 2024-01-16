1. Liste des bateaux participants

SELECT * FROM P02_bateau ;


2. Liste des bateaux dont le nom contient « or » ou « ef »

SELECT * FROM P02_bateau WHERE bateau_nom LIKE '%or%' OR '%ef%';


3. Liste des skippers dont le bateau à été lancé entre 2010 et 2018
-- Version 1 :  utilisation de INNER JOIN
SELECT * FROM P02_skipper S INNER JOIN P02_resultat R on S.skipper_id = R.skipper_id WHERE bateau_id IN(SELECT bateau_id FROM P02_bateau WHERE bateau_date BETWEEN 2010 AND 2018) ;

-- Version 2 :  Sans l'utilisation de INNER JOIN

SELECT S.* FROM P02_skipper S , P02_resultat R , P02_bateau B WHERE S.skipper_id = R.skipper_id AND B.bateau_id = R.bateau_id AND  bateau_date BETWEEN 2010 AND 2018 ;


4. Nombre de classes de bateaux

SELECT COUNT(DISTINCT bateau_classe) AS nombre_classe_bateaux FROM P02_bateau ;


5. Liste des bateaux dont un skipper a un nom qui commence entre B et L

-- Version 1 :  utilisation de INNER JOIN
SELECT B.bateau_id,bateau_nom,B.bateau_date,bateau_architecte,bateau_classe FROM P02_bateau B INNER JOIN P02_resultat R on B.bateau_id = R.bateau_id  WHERE  skipper_id IN(SELECT skipper_id FROM P02_skipper WHERE skipper_nom BETWEEN 'B%' AND 'L%');

-- Version 1 :  utilisation de NATURAL JOIN
SELECT bateau_id,bateau_nom,bateau_date,bateau_architecte,bateau_classe FROM P02_bateau  NATURAL JOIN P02_resultat  WHERE skipper_id IN(SELECT skipper_id FROM P02_skipper WHERE skipper_nom BETWEEN 'B%' AND 'L%');


6. Skippers des bateaux « APIVIA » et « SOGESTRAN - SEAFRIGO »


SELECT skipper_nom,skipper_prenom,skipper_age FROM P02_skipper NATURAL JOIN P02_resultat WHERE bateau_id IN(SELECT bateau_id FROM P02_bateau WHERE bateau_nom IN ('APIVIA', 'SOGESTRAN - SEAFRIGO'));


7. Noms des bateaux pilotés par un skipper prénommé «Nicolas»


SELECT bateau_nom  FROM P02_bateau NATURAL JOIN P02_resultat  WHERE  skipper_id IN(SELECT skipper_id FROM P02_skipper WHERE skipper_prenom  LIKE '%Nicolas%') ;

8. Résultats des bateaux dont le nom commence par « G »


 SELECT R.* FROM P02_resultat R NATURAL JOIN P02_bateau B  WHERE bateau_id IN (SELECT bateau_id FROM P02_bateau WHERE bateau_nom LIKE 'G%') ;

9. Nombre de skippers par jours de courses


SELECT resultat_jours,COUNT(bateau_id) AS nb_skipper FROM P02_resultat WHERE resultat_jours IS NOT NULL GROUP BY resultat_jours ;

10. Catégories ayant moins de 10 bateaux


SELECT bateau_classe AS categorie, COUNT(bateau_nom) AS NB_Bateaux FROM P02_bateau GROUP BY bateau_classe HAVING NB_Bateaux<=10 ;
