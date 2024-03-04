-- Insert or Update etudiant
DROP FUNCTION IF EXISTS sp_insert_etudiant(INTEGER, VARCHAR(50), VARCHAR(50), VARCHAR(50), CHAR(1), VARCHAR(20));
CREATE OR REPLACE FUNCTION sp_insert_etudiant(
    _id INTEGER,
    _nom VARCHAR(50),
    _postnom VARCHAR(50),
    _prenom VARCHAR(50),
    _sexe CHAR(1),
    _matricule VARCHAR(20)
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS(SELECT * FROM etudiant WHERE id = _id) THEN
        INSERT INTO etudiant(id, nom, postnom, prenom, sexe, matricule)
        VALUES (_id, _nom, _postnom, _prenom, _sexe, _matricule);
    ELSE
        UPDATE etudiant
        SET nom = _nom, postnom = _postnom, prenom = _prenom,
            sexe = _sexe, matricule = _matricule
        WHERE id = _id;
    END IF;
END;
$$;

-- Delete etudiant
DROP FUNCTION IF EXISTS sp_delete_etudiant(INTEGER);
CREATE OR REPLACE FUNCTION sp_delete_etudiant(_id INTEGER)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS(SELECT * FROM etudiant WHERE id = _id) THEN
        DELETE FROM etudiant WHERE id = _id;
    END IF;
END;
$$;

-- Select all etudiant
DROP FUNCTION IF EXISTS sp_select_etudiant();
CREATE OR REPLACE FUNCTION sp_select_etudiant()
RETURNS TABLE (
    id INTEGER,
    nom VARCHAR(50),
    postnom VARCHAR(50),
    prenom VARCHAR(50),
    sexe CHAR(1),
    matricule VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM etudiant ORDER BY nom ASC;
END;
$$;

-- Select one etudiant
DROP FUNCTION IF EXISTS sp_select_etudiants(INTEGER);
CREATE OR REPLACE FUNCTION sp_select_etudiants(_id INTEGER)
RETURNS TABLE (
    id INTEGER,
    nom VARCHAR(50),
    postnom VARCHAR(50),
    prenom VARCHAR(50),
    sexe CHAR(1),
    matricule VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM etudiant WHERE id = _id;
END;
$$;

-- Insert or Update telephone
DROP FUNCTION IF EXISTS sp_insert_telephone(INTEGER, INTEGER, VARCHAR(4), VARCHAR(9));
CREATE OR REPLACE FUNCTION sp_insert_telephone(
    _id INTEGER,
    _id_proprietaire INTEGER,
    _initial VARCHAR(4),
    _numero VARCHAR(9)
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS(SELECT * FROM telephone WHERE id = _id) THEN
        INSERT INTO telephone(id, id_proprietaire, initial, numero)
        VALUES (_id, _id_proprietaire, _initial, _numero);
    ELSE
        UPDATE telephone
        SET id_proprietaire = _id_proprietaire,
            initial = _initial,
            numero = _numero
        WHERE id = _id;
    END IF;
END;
$$;

-- Delete telephone
DROP FUNCTION IF EXISTS sp_delete_telephone(INTEGER);
CREATE OR REPLACE FUNCTION sp_delete_telephone(_id INTEGER)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS(SELECT * FROM telephone WHERE id = _id) THEN
        DELETE FROM telephone WHERE id = _id;
    END IF;
END;
$$;

-- Select all telephone
DROP FUNCTION IF EXISTS sp_select_telephones();
CREATE OR REPLACE FUNCTION sp_select_telephones()
RETURNS TABLE (
    id INTEGER,
    id_proprietaire INTEGER,
    initial VARCHAR(4),
    numero VARCHAR(9)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM telephone ORDER BY numero ASC;
END;
$$;

-- Select all telephone of etudiant
DROP FUNCTION IF EXISTS sp_select_telephones_personne(INTEGER);
CREATE OR REPLACE FUNCTION sp_select_telephones_personne(_id_personne INTEGER)
RETURNS TABLE (
    id INTEGER,
    id_proprietaire INTEGER,
    initial VARCHAR(4),
    numero VARCHAR(9)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM telephone WHERE id_proprietaire = _id_personne ORDER BY numero ASC;
END;
$$;

-- Select one etudiant
DROP FUNCTION IF EXISTS sp_select_telephone(INTEGER);
CREATE OR REPLACE FUNCTION sp_select_telephone(_id INTEGER)
RETURNS TABLE (
    id INTEGER,
    id_proprietaire INTEGER,
    initial VARCHAR(4),
    numero VARCHAR(9)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM telephone WHERE id = _id;
END;
$$;

-- Stored Procedure for report of etudiants
DROP FUNCTION IF EXISTS sp_liste_etudiants();
CREATE OR REPLACE FUNCTION sp_liste_etudiants()
RETURNS TABLE (
    id INTEGER,
    nom VARCHAR(150),
    sexe CHAR(1),
    idtel INTEGER,
    numero VARCHAR(13)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.id,
        CONCAT(e.nom, ' ', COALESCE(e.postnom, ''), ' ', COALESCE(e.prenom, '')) AS nom,
        e.sexe,
        t.id AS idtel,
        CONCAT(t.initial, t.numero) AS numero
    FROM
        etudiant e
        LEFT OUTER JOIN telephone t ON e.id = t.id_proprietaire;
END;
$$;

-- Execute the following statement after creating all functions to enable CALL syntax
SET client_min_messages TO error;


-- Insertion des étudiants
SELECT sp_insert_etudiant(1, 'Isamuna', 'Nkembo', 'Josue', 'M', '22LIAGELJ253');
SELECT sp_insert_etudiant(2, 'Daniel', 'daba', 'Dieumerci', 'M', '22LIAGELJ620114');
SELECT sp_insert_etudiant(3, 'Chirimwami', 'Batumike', 'Jonathan', 'M', '22LIAGELJ610354');
SELECT sp_insert_etudiant(4, 'Maki', 'Ndrundro', 'Jeremie', 'M', '22LIAGELJ640354');
SELECT sp_insert_etudiant(5, 'Richard', 'Bwale', 'Rich', 'M', '22LIAGELJ62354');

-- Modification de la taille de la colonne numero dans la table telephone
ALTER TABLE telephone
ALTER COLUMN numero TYPE VARCHAR(20);

-- Insertion des téléphones
SELECT sp_insert_telephone(1, 1, '+250', '78562314');
SELECT sp_insert_telephone(2, 1, '+243', '0812700368');
SELECT sp_insert_telephone(3, 2, '+243', '985645235');
SELECT sp_insert_telephone(4, 3, '+243', '815790584');
SELECT sp_insert_telephone(5, 3, '+242', '808256231');
