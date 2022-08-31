REM   Script: Projet Base de Données Pokémon - MADAD Sarra et LOUATY Nour El-Houda
REM   Projet BDD fini.

-- Création de la table Equipe.
CREATE TABLE Equipe (    
   idEquipe decimal(10,0) constraint pk_equipe primary key,    
   nom varchar(15),    
   couleur varchar(15)    
       
);

-- Création de la table Joueur.
CREATE TABLE Joueur (    
   pseudonyme varchar(15) constraint pk_joueur primary key,   
   idEquipe decimal(10,0) constraint fk_joueur references Equipe(idEquipe),   
   personnage varchar(15),    
   sexe varchar(15),   
   niveau decimal(5,0) 
       
);

-- Création de la table Pokemon.
CREATE TABLE Pokemon (   
   idPokemon decimal(10,0) constraint pk_pokemon primary key,  
   pseudonyme varchar(15) constraint fk_pokemon references Joueur(pseudonyme),  
   nom varchar(15),   
   espece varchar(15),  
   pointCombat decimal(5,0)  
      
);

-- Création de la table Emplacement.
CREATE TABLE Emplacement (    
   idEmplacement decimal(10,0) constraint pk_emplacement primary key,   
   latitude float,   
   longitude float   
       
);

-- Création de la table Arene.
CREATE TABLE Arene (   
   idArene decimal(10,0) constraint pk_arene primary key,  
   idEmplacement decimal(10,0) constraint fk_arene references Emplacement(idEmplacement),  
   nom varchar(15)  
      
)  
;

INSERT INTO Equipe VALUES( '1', 'Intuition', 'Jaune');

INSERT INTO Equipe VALUES( '2', 'Sagesse', 'Bleu');

INSERT INTO Equipe VALUES( '3', 'Bravoure', 'Rouge');

INSERT INTO Joueur VALUES( 'Shadow', '1', 'Smith','F', '10');

INSERT INTO Joueur VALUES( 'Root', '2', 'Alice', 'F', '20');

INSERT INTO Joueur VALUES( 'Admin', '1', 'Bob', 'M', '1');

INSERT INTO Emplacement VALUES( '1', '49.0350369', '2.0696998');

INSERT INTO Emplacement VALUES( '2', '48.857848', '2.295253');

INSERT INTO Emplacement VALUES( '3', '-74.0445', '40.6892');

INSERT INTO Arene VALUES( '1', '3', 'Liberte');

INSERT INTO Arene VALUES( '2', '1', 'Lune');

INSERT INTO Arene VALUES( '3', '2', 'Star');

INSERT INTO Pokemon VALUES( '1', 'Shadow', 'Bulbizarre', 'Graine', '1071');

INSERT INTO Pokemon  VALUES( '25', 'Root', 'Pikachu', 'Souris', '887');

INSERT INTO Pokemon VALUES( '103', 'Admin', 'Noadkoko', 'Fruitpalme', '190');

INSERT INTO Pokemon  VALUES( '150', 'Root', 'Mewtwo', 'Génétique', '4144');

INSERT INTO Pokemon VALUES( '107', 'Shadow', 'Tygnon', 'Puncheur', '204');

-- Création de la table Apparition.
CREATE TABLE Apparition (      
         idPokemon decimal(10,0) constraint fk_apparition references Pokemon(idPokemon),      
         idEmplacement decimal(10,0) constraint fk2_apparition references Emplacement(idEmplacement),      
         horaire DATE NOT NULL,      
         duree decimal(4,0),      
         constraint pk_apparition primary key (idPokemon, idEmplacement, horaire)  
);

INSERT INTO Apparition VALUES ( '25', '3', '25-oct-2016', '3');

INSERT INTO Apparition VALUES ( '1', '2', '09-oct-2016', '10');

INSERT INTO Apparition VALUES ( '107', '3', '02-oct-2016', '5');

INSERT INTO Apparition VALUES ( '103', '1', '25-oct-2016', '15');

INSERT INTO Apparition VALUES ( '25', '1', '01-sep-2016', '20');

INSERT INTO Pokemon VALUES ('19', 'Admin', 'Rattata', 'Souris', '20');

INSERT INTO Joueur VALUES ('Moustache', '', '', '', '');

INSERT INTO Pokemon VALUES ('39', 'Moustache', 'Rondoudou', 'Bouboule', '4145') 
;

INSERT INTO Joueur VALUES ('Flavius', '2', 'Ruth', 'M', '20');

INSERT INTO Joueur VALUES ('Asterix', '1', 'Ruth', 'M', '5');

-- Création de la table Defense.
CREATE TABLE Defense (        
   idArene decimal(10,0) constraint fk_defense references Arene(idArene),     
   idEquipe decimal(10,0) constraint fk2_defense references Equipe(idEquipe),      
   dateControle DATE NOT NULL,   
   constraint pk_defense primary key (idArene, idEquipe, dateControle)   
   );

INSERT INTO Defense VALUES( '1', '1', '10-oct-2016');

INSERT INTO Defense VALUES( '2', '1', '01-sep-2016');

INSERT INTO Defense VALUES( '3', '2', '10-oct-2016');

-- La colonne 'dateControle' fait partie de la clé primaire, elle est donc par conséquent NOT NULL (ne peut pas être vide) et doit avoir son champ rempli. Ce n'est pas le cas ici, d'où cette erreur.
INSERT INTO Defense VALUES( '2', '3', '');

-- Question 7.
UPDATE Joueur 
SET niveau='15' 
WHERE sexe='F';

-- Question 8.
DELETE FROM Pokemon WHERE espece LIKE 'fruit%';

-- Question 8.
On ne peut pas supprimer ce tuple car elle contient une clé primaire qui a des 'enfants'. Il faut donc d'abord supprimer les tuples qui font référence à cette clé (ses 'enfants') dans les autres tables avant de supprimer celle-ci.
DELETE FROM Pokemon WHERE espece LIKE 'Fruit%';

-- Question 8.
DELETE FROM Pokemon WHERE espece LIKE '%fruit%';

-- Question 9.
On ne peut pas supprimer ce tuple car elle contient une clé primaire qui a des 'enfants'. Il faut donc d'abord supprimer les tuples qui font référence à cette clé (ses 'enfants') dans les autres tables avant de supprimer celle-ci.
DELETE FROM Joueur WHERE pseudonyme LIKE 'Admin';

-- Question 10.
SELECT * FROM Arene WHERE nom LIKE 'Lune%'   
OR nom LIKE 'lune%'   
OR nom LIKE '%lune%';

-- Question 11.
SELECT * FROM Pokemon WHERE nom LIKE 'P%'   
OR nom LIKE 'p%';

-- Question 12.
SELECT * FROM Joueur WHERE pseudonyme NOT LIKE '%a%'  
AND pseudonyme NOT LIKE 'A%';

-- Question 13.
SELECT * FROM Pokemon  
ORDER BY pointCombat DESC;

-- Question 14.
SELECT AVG (duree) FROM Apparition;

-- Question 15.
SELECT COUNT(*) FROM Apparition WHERE horaire LIKE '%%-OCT-16';

-- Question 16.
SELECT * FROM Pokemon WHERE espece LIKE (SELECT espece FROM Pokemon WHERE nom = 'Pikachu');

-- Question 17.
SELECT * FROM Joueur WHERE niveau > (SELECT AVG (niveau) FROM Joueur);

-- Pour vérification de la requête précédente.
SELECT AVG (niveau) FROM Joueur;

-- Question 18.
SELECT * FROM Pokemon WHERE pointCombat = (SELECT MAX (pointCombat) FROM Pokemon);

-- Question 19.
SELECT count(*) FROM Defense d, Equipe e WHERE e.nom LIKE 'Intuition' AND d.idEquipe=e.idEquipe;

-- Question 20.
SELECT horaire FROM Apparition a, Pokemon p WHERE p.nom LIKE 'Tygnon' AND a.idPokemon = p.idPokemon;

-- Question 21.
SELECT pseudonyme FROM Joueur j, Arene a, Defense d WHERE a.nom LIKE 'Lune' AND d.idArene = a.idArene AND d.idEquipe = j.idEquipe;

-- Question 23.
SELECT espece, AVG (pointCombat) FROM Pokemon GROUP BY espece;

-- Question 24.
SELECT j.pseudonyme, e.nom, count (p.pseudonyme)    
FROM Joueur j full join  Equipe e on j.idEquipe=e.idEquipe   
full join Pokemon p on j.pseudonyme=p.pseudonyme   
GROUP BY j.pseudonyme, e.nom;

-- Question 25.
SELECT p.nom, SUM(duree) FROM Pokemon p  
FULL JOIN Apparition a ON a.idPokemon=p.idPokemon GROUP BY p.nom;

-- Question 26.
SELECT a.nom, MAX(dateControle) FROM Arene a, Defense d WHERE d.idArene=a.idArene GROUP BY a.nom;

-- Question 27.
SELECT p.nom, p.espece, count(a.idPokemon) FROM Pokemon p, Apparition a WHERE p.idPokemon=a.idPokemon HAVING count(a.idPokemon)>=2 GROUP BY p.nom, p.espece;

-- Question 28.
SELECT p.nom, p.espece, a.duree FROM Pokemon p, Apparition a WHERE p.idPokemon=a.idPokemon AND a.duree>5;

-- Question 22.
SELECT j.pseudonyme, count(p.idPokemon) FROM Joueur j left join Pokemon p ON p.pseudonyme=j.pseudonyme GROUP BY j.pseudonyme;

-- Question 29.
CREATE OR REPLACE PROCEDURE Classement_Pokemon 
IS 
BEGIN 
    FOR ligne IN ( 
    SELECT nom, (SELECT COUNT(*) FROM Apparition a WHERE a.idPokemon = p.idPokemon) AS Nombre_App 
    FROM Pokemon p 
    ORDER BY (SELECT COUNT(*) FROM Apparition a WHERE a.idPokemon = p.idPokemon) DESC 
    ) LOOP 
            dbms_output.put_line('Nom Pokémon : ' || ligne.nom || ' est apparu ' || ligne.Nombre_App || ' fois.'); 
            END LOOP; 
END;
/

-- Appel de la procédure question 29 pour le test.
EXECUTE Classement_Pokemon


-- Question 30.
CREATE OR REPLACE FUNCTION Nombre_Joueur 
RETURN NUMBER 
AS 
    nombre NUMBER :=0; 
BEGIN 
    FOR ligne IN ( 
    SELECT j.pseudonyme FROM Joueur j, Pokemon p, Emplacement e, Apparition a 
    WHERE j.pseudonyme = p.pseudonyme AND p.idPokemon = a.idPokemon AND e.idEmplacement = a.idEmplacement 
    AND e.latitude = (SELECT MAX(e2.latitude) FROM Emplacement e2) 
    ) LOOP 
        nombre := nombre + 1; 
    END LOOP; 
    RETURN(nombre); 
END;
/

-- Question 31.
CREATE OR REPLACE FUNCTION Equipe_Dominante 
RETURN VARCHAR2 
AS 
    nom_Equipe VARCHAR2(20); 
    num_Intuition NUMBER := 0; 
    num_Sagesse NUMBER := 0; 
    num_Bravoure NUMBER := 0; 
BEGIN 
    FOR row IN (SELECT idEquipe FROM Defense) LOOP 
    IF row.idEquipe = 1 THEN 
        num_Intuition := num_Intuition + 1; 
    ELSIF row.idEquipe = 2 THEN 
        num_Sagesse := num_Sagesse + 1; 
    ELSE 
        num_Bravoure := num_Bravoure + 1; 
    END IF; 
END LOOP; 
 
IF num_Intuition > num_Sagesse AND num_Intuition > num_Bravoure THEN nom_Equipe := 'Intuition'; 
ELSIF num_Sagesse > num_Intuition AND num_Sagesse > num_Bravoure THEN nom_Equipe := 'Sagesse'; 
ELSIF num_Bravoure > num_Sagesse AND num_Bravoure > num_Intuition THEN nom_Equipe := 'Bravoure'; 
ELSE nom_Equipe := 'NULL'; 
END IF; 
RETURN(nom_Equipe); 
END; 
    
/

-- Question 32.
CREATE OR REPLACE FUNCTION Plage_de_Date(nom_Equipe VARCHAR2)  
RETURN VARCHAR2  
AS  
    date_Pokemon VARCHAR2(50) := '';  
   
BEGIN  
    FOR ligne IN (SELECT horaire FROM Joueur j, Pokemon p, Equipe e, Apparition a 
    WHERE e.nom = nom_Equipe AND j.idEquipe = e.idEquipe AND j.pseudonyme = p.pseudonyme AND p.idPokemon = a.idPokemon)  
    LOOP  
        date_Pokemon := TO_CHAR(ligne.horaire)|| ' ' || date_Pokemon;  
END LOOP;  
RETURN(date_Pokemon);  
END;  
    
/

