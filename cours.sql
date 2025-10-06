-- Rôles
-- Toutes les permessions sur la base de donnée offertes au gestionnaire
CREATE role r_gestion;
GRANT DBA TO r_gestion;

-- Toutes les permessions offertes sur les tables respectives pour le reste des utilisateurs
CREATE ROLE r_registrariat;
GRANT CREATE SESSION TO r_registrariat;
GRANT ALL PRIVILEGES ON etudiants to r_registrariat;
GRANT ALL PRIVILEGES ON cours to r_registrariat;

CREATE ROLE r_api;
GRANT CREATE SESSION TO r_api;
GRANT ALL PRIVILEGES ON groupes to r_api;
GRANT ALL PRIVILEGES ON semestres to r_api;

CREATE ROLE r_enseignant;
GRANT CREATE SESSION TO r_enseignant;
GRANT ALL PRIVILEGES ON evaluations TO r_enseignant;

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


-- Utilisateurs
-- DBA principal et son collègue
CREATE USER sys1 IDENTIFIED BY oracle;
CREATE USER sys2 IDENTIFIED BY oracle;
-- Rôle de SYSDBA parce qu'ils sont les administrateurs de la base de données.
GRANT SYSDBA TO sys1;
GRANT SYSDBA TO sys2;

-- Gestionnaire
CREATE USER gestionnaire IDENTIFIED BY oracle;
GRANT r_gestion TO gestionnaire;

-- Registrariat:
CREATE USER registrariat IDENTIFIED BY oracle
GRANT r_registrariat TO registrariat;

-- API
CREATE USER api IDENTIFIED BY oracle
GRANT r_api TO api;

-- Enseignant
CREATE USER enseignant IDENTIFIED BY oracle
GRANT r_enseignant TO enseignant;
