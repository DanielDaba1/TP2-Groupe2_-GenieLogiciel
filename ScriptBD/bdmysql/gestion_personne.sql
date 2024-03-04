-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 03 mars 2024 à 23:43
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_personne`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `sp_delete_etudiant`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_etudiant` (`in_id` INT)   BEGIN
    IF EXISTS (SELECT * FROM etudiant WHERE id = in_id) THEN
        DELETE FROM etudiant WHERE id = in_id;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_delete_telephone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_telephone` (`in_id` INT)   BEGIN
    IF EXISTS (SELECT * FROM telephone WHERE id = in_id) THEN
        DELETE FROM telephone WHERE id = in_id;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_etudiant`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_etudiant` (`in_id` INT, `in_nom` VARCHAR(50), `in_postnom` VARCHAR(50), `in_prenom` VARCHAR(50), `in_sexe` VARCHAR(1), `in_matricule` VARCHAR(20))   BEGIN
    DECLARE id_count INT;
    SELECT COUNT(*) INTO id_count FROM etudiant WHERE id = in_id;
    
    IF id_count = 0 THEN
        INSERT INTO etudiant(id, nom, postnom, prenom, sexe, matricule) 
        VALUES (in_id, in_nom, in_postnom, in_prenom, in_sexe, in_matricule);
    ELSE
        UPDATE etudiant 
        SET nom = in_nom, postnom = in_postnom, prenom = in_prenom, sexe = in_sexe, matricule = in_matricule 
        WHERE id = in_id;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_telephone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_telephone` (`in_id` INT, `in_id_proprietaire` INT, `in_initial` VARCHAR(4), `in_numero` VARCHAR(9))   BEGIN
    DECLARE id_count INT;
    SELECT COUNT(*) INTO id_count FROM telephone WHERE id = in_id;
    
    IF id_count = 0 THEN
        INSERT INTO telephone(id, id_proprietaire, initial, numero) 
        VALUES (in_id, in_id_proprietaire, in_initial, in_numero);
    ELSE
        UPDATE telephone 
        SET id_proprietaire = in_id_proprietaire, initial = in_initial, numero = in_numero 
        WHERE id = in_id;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_liste_etudiants`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_liste_etudiants` ()   BEGIN
    SELECT etudiant.id, CONCAT(etudiant.nom, ' ', COALESCE(etudiant.postnom, ''), ' ', COALESCE(etudiant.prenom, '')) AS nom,
    etudiant.sexe, telephone.id AS idtel, CONCAT(telephone.initial, telephone.numero) AS numero
    FROM etudiant
    LEFT OUTER JOIN telephone 
    ON etudiant.id = telephone.id_proprietaire;
END$$

DROP PROCEDURE IF EXISTS `sp_select_etudiant`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_etudiant` ()   BEGIN
    SELECT id, nom, postnom, prenom, sexe, matricule FROM etudiant ORDER BY nom ASC;
END$$

DROP PROCEDURE IF EXISTS `sp_select_etudiants`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_etudiants` (`in_id` INT)   BEGIN
    SELECT id, nom, postnom, prenom, sexe, matricule FROM etudiant WHERE id = in_id;
END$$

DROP PROCEDURE IF EXISTS `sp_select_telephone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_telephone` (`in_id` INT)   BEGIN
    SELECT id, id_proprietaire, initial, numero FROM telephone WHERE id = in_id;
END$$

DROP PROCEDURE IF EXISTS `sp_select_telephones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_telephones` ()   BEGIN
    SELECT id, id_proprietaire, initial, numero FROM telephone ORDER BY numero ASC;
END$$

DROP PROCEDURE IF EXISTS `sp_select_telephones_personne`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_telephones_personne` (`in_id_personne` INT)   BEGIN
    SELECT id, id_proprietaire, initial, numero 
    FROM telephone 
    WHERE id_proprietaire = in_id_personne 
    ORDER BY numero ASC;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `id` int NOT NULL,
  `quartier` varchar(50) DEFAULT NULL,
  `commune` varchar(50) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `pays` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `domicile`
--

DROP TABLE IF EXISTS `domicile`;
CREATE TABLE IF NOT EXISTS `domicile` (
  `id` int NOT NULL,
  `id_personne` int NOT NULL,
  `id_adresse` int NOT NULL,
  `avenue` varchar(50) DEFAULT NULL,
  `numero_avenue` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_personne_domicile` (`id_personne`),
  KEY `fk_addresse_domicile` (`id_adresse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
CREATE TABLE IF NOT EXISTS `etudiant` (
  `id` int NOT NULL,
  `nom` varchar(50) NOT NULL,
  `postnom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `sexe` varchar(1) NOT NULL DEFAULT 'M',
  `matricule` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_personne` (`nom`,`postnom`,`prenom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`id`, `nom`, `postnom`, `prenom`, `sexe`, `matricule`) VALUES
(1, 'Isamuna', 'Nkembo', 'Josue', 'M', '22LIAGELJ253'),
(2, 'DANIEL', 'DABA', 'Dieumerci', 'M', '22LIAGELJ620114'),
(3, 'CHIRIMWAMI', 'BATUMIKE', 'Jonathan', 'M', '22LIAGELJ620354'),
(4, 'Maki', 'Ndrundro', 'Jeremie', 'M', '22LIAGELJ640354'),
(5, 'Richard', 'Bwale', 'Rich', 'M', '22LIAGELJ62354');

-- --------------------------------------------------------

--
-- Structure de la table `telephone`
--

DROP TABLE IF EXISTS `telephone`;
CREATE TABLE IF NOT EXISTS `telephone` (
  `id` int NOT NULL,
  `id_proprietaire` int NOT NULL,
  `initial` varchar(4) NOT NULL,
  `numero` varchar(9) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_personne_telephone` (`id_proprietaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `telephone`
--

INSERT INTO `telephone` (`id`, `id_proprietaire`, `initial`, `numero`) VALUES
(1, 1, '+250', '785623146'),
(2, 1, '+243', '081270036'),
(3, 2, '+243', '985645235'),
(4, 3, '+243', '815790584'),
(5, 3, '+242', '808256231');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `domicile`
--
ALTER TABLE `domicile`
  ADD CONSTRAINT `fk_addresse_domicile` FOREIGN KEY (`id_adresse`) REFERENCES `adresse` (`id`),
  ADD CONSTRAINT `fk_personne_domicile` FOREIGN KEY (`id_personne`) REFERENCES `etudiant` (`id`);

--
-- Contraintes pour la table `telephone`
--
ALTER TABLE `telephone`
  ADD CONSTRAINT `fk_personne_telephone` FOREIGN KEY (`id_proprietaire`) REFERENCES `etudiant` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
