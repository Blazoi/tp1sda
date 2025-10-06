-- Création de la BD
CREATE PLUGGABLE DATABASE TP1PDB
ADMIN USER admin IDENTIFIED BY oracle
FILE_NAME_CONVERT = ('/opt/oracle/oradata/FREE/pdbseed/',
'/opt/oracle/oradata/FREE/tp1pdb/')

-- Utilisateurs
-- DBA principal et son collègue
CREATE USER sys1 IDENTIFIED BY oracle;
CREATE USER sys2 IDENTIFIED BY oracle;
-- Rôle de SYSDBA parce qu'ils sont les administrateurs de la base de données.
GRANT SYSDBA TO sys1;
GRANT SYSDBA TO sys2;

-- Gestionnaire
CREATE USER JAD_gestionnaire IDENTIFIED BY oracle;

-- Registrariat:
CREATE USER JAD_registrariat IDENTIFIED BY oracle

-- API
CREATE USER JAD_api IDENTIFIED BY oracle

-- Enseignant
CREATE USER JAD_enseignant IDENTIFIED BY oracle

CREATE TABLE JAD_registrariat.etudiants (
    da_etudiant NUMBER PRIMARY KEY,
    nom VARCHAR2(50),
    prenom VARCHAR2(50)
);

CREATE TABLE JAD_registrariat.cours (
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
    nom VARCHAR2(50)
);

CREATE TABLE JAD_enseignant.evaluations (
    id_evaluation NUMBER PRIMARY KEY,
    id_etudiant NUMBER,
    id_cours NUMBER,
    note NUMBER(5,2)
);


-- Rôles
-- Toutes les permessions sur la base de donnée offertes au gestionnaire
CREATE role r_gestion;
GRANT DBA TO r_gestion;

-- Toutes les permessions offertes sur les tables respectives pour le reste des utilisateurs
CREATE ROLE r_registrariat;
GRANT CREATE SESSION TO r_registrariat;
GRANT RESOURCE TO r_registrariat;
GRANT ALL ON etudiants to r_registrariat;
GRANT ALL ON cours to r_registrariat;

CREATE ROLE r_api;
GRANT CREATE SESSION TO r_api;
GRANT RESOURCE TO r_api;
GRANT ALL ON groupes to r_api;
GRANT ALL ON semestres to r_api;

CREATE ROLE r_enseignant;
GRANT CREATE SESSION TO r_enseignant;
GRANT RESOURCE TO r_enseignant;
GRANT ALL ON evaluations TO r_enseignant;

-- Profils
-- Limitations sont beaucoup moins grandes ce qui rend ce profil moins restrictif
CREATE PROFILE p_gestion LIMIT
IDLE_TIME 30
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LOCK_TIME 5/1440
PASSWORD_LIFE_TIME 90
PASSWORD_GRACE_TIME 7

-- Limitations sont beaucoup plus strictes et standard avec des conséquences plus grandes
-- de tentatives de connexions échouées.
CREATE PROFILE p_usager LIMIT
IDLE_TIME 10
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 20/1440
PASSWORD_LIFE_TIME 30
PASSWORD_GRACE_TIME 3



GRANT r_gestion TO JAD_gestionnaire;
GRANT r_registrariat TO JAD_registrariat;
GRANT r_api TO JAD_api;
GRANT r_enseignant TO JAD_enseignant;