-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`dojos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dojos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `updated_at` DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ninjas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ninjas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `age` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `updated_at` DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `dojo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ninjas_dojos_idx` (`dojo_id` ASC) VISIBLE,
  CONSTRAINT `fk_ninjas_dojos`
    FOREIGN KEY (`dojo_id`)
    REFERENCES `mydb`.`dojos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE mydb;

-- Consulta: crea 3 dojos nuevos
INSERT INTO dojos (name)
VALUES 
('Dojo1'),
('Dojo2'),
('Dojo3');
-- Consulta: elimina los 3 dojos que acabas de crear (al elimitar sin clausula WHERE, me genera un error por que tengo activado el modo de actualizacion segura, para esto tengo que eliminar uno a uno por id)
DELETE FROM dojos;  -- error
DELETE FROM dojos WHERE id = 1 or id = 2 or id = 3; 
  
-- Consulta: crea 3 dojos nuevos
INSERT INTO dojos (name)
VALUES 
('Dojo4'),
('Dojo5'),
('Dojo6');

-- Consulta: crea 3 ninjas que pertenezcan al primer dojo
INSERT INTO ninjas (first_name, lastname, age, dojo_id)
VALUES 
('nameninja1', 'lastnameninja1', 10, 7),
('nameninja2', 'lastnameninja2', 20, 7),
('nameninja3', 'lastnameninja3', 30, 7);

-- Consulta: crea 3 ninjas que pertenezcan al segundo dojo
INSERT INTO ninjas (first_name, lastname, age, dojo_id)
VALUES 
('nameninja4', 'lastnameninja4', 40, 8),
('nameninja5', 'lastnameninja5', 50, 8),
('nameninja6', 'lastnameninja6', 60, 8);

-- Consulta: crea 3 ninjas que pertenezcan al tercer dojo
INSERT INTO ninjas (first_name, lastname, age, dojo_id)
VALUES 
('nameninja7', 'lastnameninja7', 5, 9),
('nameninja8', 'lastnameninja8', 10, 9),
('nameninja9', 'lastnameninja9', 15, 9);

-- Consulta: recupera todos los ninjas del primer dojo
SELECT * FROM ninjas WHERE dojo_id = 7;

-- Consulta: recupera todos los ninjas del último dojo
SELECT * FROM ninjas WHERE dojo_id = 9;

-- Consulta: recupera el dojo del último ninja
SELECT dojos.name FROM dojos, ninjas WHERE dojos.id = ninjas.dojo_id and ninjas.first_name = 'nameninja9';
