-- Drop database if it exists
DROP DATABASE IF EXISTS gestion_personne;
-- Create database
CREATE DATABASE gestion_personne;
-- Switch to the new database
\c gestion_personne;

-- Create table "etudiant"
CREATE TABLE etudiant (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    postnom VARCHAR(50),
    prenom VARCHAR(50),
    sexe VARCHAR(1) DEFAULT 'M' NOT NULL,
    matricule VARCHAR(20),
    CONSTRAINT pk_etudiant PRIMARY KEY (id),
    CONSTRAINT uk_etudiant UNIQUE (nom, postnom, prenom)
);

-- Create table "telephone"
CREATE TABLE telephone (
    id SERIAL PRIMARY KEY,
    id_proprietaire INT NOT NULL,
    initial VARCHAR(4) NOT NULL,
    numero VARCHAR(9) NOT NULL,
    CONSTRAINT pk_telephone PRIMARY KEY (id),
    CONSTRAINT fk_telephone_etudiant FOREIGN KEY (id_proprietaire) REFERENCES etudiant (id)
);

-- Create table "adresse"
CREATE TABLE adresse (
    id SERIAL PRIMARY KEY,
    quartier VARCHAR(50),
    commune VARCHAR(50),
    ville VARCHAR(50),
    pays VARCHAR(50) NOT NULL
);

-- Create table "domicile"
CREATE TABLE domicile (
    id SERIAL PRIMARY KEY,
    id_personne INT NOT NULL,
    id_adresse INT NOT NULL,
    avenue VARCHAR(50),
    numero_avenue INT,
    CONSTRAINT pk_domicile PRIMARY KEY (id),
    CONSTRAINT fk_domicile_etudiant FOREIGN KEY (id_personne) REFERENCES etudiant (id),
    CONSTRAINT fk_domicile_adresse FOREIGN KEY (id_adresse) REFERENCES adresse (id)
);
