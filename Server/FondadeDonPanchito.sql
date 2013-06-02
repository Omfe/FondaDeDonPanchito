SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `FondadeDonPanchito` DEFAULT CHARACTER SET latin1 ;
USE `FondadeDonPanchito` ;

-- -----------------------------------------------------
-- Table `FondadeDonPanchito`.`Item`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FondadeDonPanchito`.`Item` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `itemName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `itemPrice` DECIMAL(4,2) NOT NULL ,
  `isActive` TINYINT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FondadeDonPanchito`.`Meal`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FondadeDonPanchito`.`Meal` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `mealPrice` DECIMAL(4,2) NOT NULL ,
  `mealName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `isActive` TINYINT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FondadeDonPanchito`.`Order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FondadeDonPanchito`.`Order` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `orderName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `orderNotes` VARCHAR(250) NULL DEFAULT NULL ,
  `orderedAt` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FondadeDonPanchito`.`User`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FondadeDonPanchito`.`User` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `firstName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `username` VARCHAR(250) NOT NULL DEFAULT '' ,
  `isAdmin` TINYINT NOT NULL DEFAULT 0 ,
  `password` VARCHAR(250) NOT NULL DEFAULT '' ,
  `lastName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `token` VARCHAR(250) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FondadeDonPanchito`.`Meal_has_Order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FondadeDonPanchito`.`Meal_has_Order` (
  `Meal_id` INT(11) UNSIGNED NOT NULL ,
  `Order_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`Meal_id`, `Order_id`) ,
  INDEX `fk_Meal_has_Order_Order1_idx` (`Order_id` ASC) ,
  INDEX `fk_Meal_has_Order_Meal1_idx` (`Meal_id` ASC) ,
  CONSTRAINT `fk_Meal_has_Order_Meal1`
    FOREIGN KEY (`Meal_id` )
    REFERENCES `FondadeDonPanchito`.`Meal` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Meal_has_Order_Order1`
    FOREIGN KEY (`Order_id` )
    REFERENCES `FondadeDonPanchito`.`Order` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FondadeDonPanchito`.`Item_has_Order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FondadeDonPanchito`.`Item_has_Order` (
  `Item_id` INT(11) UNSIGNED NOT NULL ,
  `Order_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`Item_id`, `Order_id`) ,
  INDEX `fk_Item_has_Order_Order1_idx` (`Order_id` ASC) ,
  INDEX `fk_Item_has_Order_Item1_idx` (`Item_id` ASC) ,
  CONSTRAINT `fk_Item_has_Order_Item1`
    FOREIGN KEY (`Item_id` )
    REFERENCES `FondadeDonPanchito`.`Item` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Order_Order1`
    FOREIGN KEY (`Order_id` )
    REFERENCES `FondadeDonPanchito`.`Order` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `FondadeDonPanchito`.`Item_has_Meal`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `FondadeDonPanchito`.`Item_has_Meal` (
  `Item_id` INT(11) UNSIGNED NOT NULL ,
  `Meal_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`Item_id`, `Meal_id`) ,
  INDEX `fk_Item_has_Meal_Meal1_idx` (`Meal_id` ASC) ,
  INDEX `fk_Item_has_Meal_Item1_idx` (`Item_id` ASC) ,
  CONSTRAINT `fk_Item_has_Meal_Item1`
    FOREIGN KEY (`Item_id` )
    REFERENCES `FondadeDonPanchito`.`Item` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Meal_Meal1`
    FOREIGN KEY (`Meal_id` )
    REFERENCES `FondadeDonPanchito`.`Meal` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `FondadeDonPanchito` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
