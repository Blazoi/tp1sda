
-- DBA principal et son collègue
CREATE USER sys1 IDENTIFIED BY oracle;
CREATE USER sys2 IDENTIFIED BY oracle;
-- Rôle de DBA parce qu'ils sont les administrateurs de la base de données.
GRANT DBA TO sys1;
GRANT DBA TO sys2;

-- Gestionnaire
-- Permissions connect et resource parce qu'elles vont lui permettre de porter des modifications à la base de donnée sans pour autant égaler les DBAs.
CREATE USER gestionnaire IDENTIFIED BY oracle;
GRANT CONNECT, RESOURCE TO gestionnaire;

-- Registrariat:
-- Permission connect parce qu'ils ne font que gérer élèves et cours.
CREATE USER registrariat IDENTIFIED BY oracle
GRANT CONNECT ON etudiant, cours TO registrariat;

-- API
-- Permission connect parce qu'ils ne font que gérer élèves et cours.
CREATE USER api IDENTIFIED BY oracle
GRANT CONNECT ON groupe, semestre TO api;

-- Enseignant
-- Permission connect parce qu'ils ne font que gérer élèves et cours.
CREATE USER enseignant IDENTIFIED BY oracle
GRANT CONNECT ON evaluations TO enseignant;



CREATE PROFILE gestion LIMIT
;