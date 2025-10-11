-- ALTER SESSION SET CONTAINER = CDB$ROOT;
-- CREATE USER C##sys1_JAD IDENTIFIED BY oracle;
-- CREATE USER C##sys2_JAD IDENTIFIED BY oracle;


-- CREATE PLUGGABLE DATABASE TP1PDB
-- ADMIN USER JAD_gestionnaire IDENTIFIED BY oracle
-- FILE_NAME_CONVERT = ('/opt/oracle/oradata/FREE/pdbseed/',
-- '/opt/oracle/oradata/FREE/tp1pdb/');     

ALTER SESSION SET CONTAINER = TP1PDB;
-- Ouvrir la PDB
ALTER PLUGGABLE DATABASE OPEN;

-- Utilisateurs
CREATE USER JAD_registrariat1 IDENTIFIED BY oracle;
CREATE USER JAD_registrariat2 IDENTIFIED BY oracle;
CREATE USER JAD_api IDENTIFIED BY oracle;
CREATE USER JAD_enseignant IDENTIFIED BY oracle;


-- Tables
CREATE TABLE JAD_registrariat1.etudiants (
    da_etudiant NUMBER PRIMARY KEY,
    nom_etudiant VARCHAR2(50),
    prenom_etudiant VARCHAR2(50)
);

CREATE TABLE JAD_registrariat1.cours (
    id_cours NUMBER PRIMARY KEY,
    nom VARCHAR2(50),
    professeur VARCHAR2(50)
);

CREATE TABLE JAD_api.groupes (
    id_groupe NUMBER PRIMARY KEY,
    professeur VARCHAR2(50)
);

CREATE TABLE JAD_api.semestres (
    id_semestre NUMBER PRIMARY KEY,
    nom_semestre VARCHAR2(50)
);

CREATE TABLE JAD_enseignant.evaluations (
    id_evaluation NUMBER PRIMARY KEY,
    id_etudiant NUMBER,
    id_cours NUMBER,
    note NUMBER(5,2)
);



-- Rôles
CREATE ROLE r_registrariat_JAD;
GRANT CREATE SESSION TO r_registrariat_JAD;
GRANT ALL ON JAD_registrariat1.etudiants to r_registrariat_JAD;
GRANT ALL ON JAD_registrariat1.cours to r_registrariat_JAD;

CREATE ROLE r_api_JAD;
GRANT CREATE SESSION TO r_api_JAD;
GRANT ALL ON JAD_api.groupes to r_api_JAD;
GRANT ALL ON JAD_api.semestres to r_api_JAD;

CREATE ROLE r_enseignant_JAD;
GRANT CREATE SESSION TO r_enseignant_JAD;
GRANT ALL ON JAD_enseignant.evaluations TO r_enseignant_JAD;

-- Profils
CREATE PROFILE p_gestion_JAD LIMIT
IDLE_TIME 30
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LOCK_TIME 5/1440
PASSWORD_LIFE_TIME 90
PASSWORD_GRACE_TIME 7;

CREATE PROFILE p_usager_JAD LIMIT
IDLE_TIME 10
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 20/1440
PASSWORD_LIFE_TIME 30
PASSWORD_GRACE_TIME 3;

-- Attribuer les rôles
-- GRANT r_gestion_JAD TO JAD_gestionnaire;
GRANT r_registrariat_JAD TO JAD_registrariat1;
GRANT r_registrariat_JAD TO JAD_registrariat2;
GRANT r_api_JAD TO JAD_api;
GRANT r_enseignant_JAD TO JAD_enseignant;

ALTER USER JAD_gestionnaire PROFILE p_gestion_JAD;
ALTER USER JAD_registrariat1 PROFILE p_usager_JAD;
ALTER USER JAD_registrariat2 PROFILE p_usager_JAD;
ALTER USER JAD_api PROFILE p_usager_JAD;
ALTER USER JAD_enseignant PROFILE p_usager_JAD;