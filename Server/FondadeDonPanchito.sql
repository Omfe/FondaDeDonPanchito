CREATE SCHEMA `FondadeDonPanchito`;
USE `FondadeDonPanchito` ;

CREATE  TABLE `Client` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `firstName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `lastName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `username` VARCHAR(250) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`id`) );


CREATE  TABLE `Item` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `itemName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `itemPrice` DECIMAL(4,2) NOT NULL ,
  `isActive` BIT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) );


CREATE  TABLE `Meal` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `mealPrice` DECIMAL(4,2) NOT NULL ,
  `mealName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `isActive` BIT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) );


CREATE  TABLE `Order` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `orderName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `orderNotes` VARCHAR(250) NULL DEFAULT NULL ,
  `orderedAt` DATETIME NOT NULL ,
  `Client_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`, `Client_id`) ,
  INDEX `fk_Order_Client_idx` (`Client_id` ASC) ,
  CONSTRAINT `fk_Order_Client`
    FOREIGN KEY (`Client_id` )
    REFERENCES `FondadeDonPanchito`.`Client` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE  TABLE `User` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `firstName` VARCHAR(250) NOT NULL DEFAULT '' ,
  `username` VARCHAR(250) NOT NULL DEFAULT '' ,
  `isAdmin` BIT(1) NOT NULL DEFAULT b'0' ,
  `password` VARCHAR(250) NOT NULL DEFAULT '' ,
  `lastName` VARCHAR(250) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`id`) );


CREATE  TABLE `Meal_has_Order` (
  `Meal_id` INT(11) UNSIGNED NOT NULL ,
  `Order_id` INT(11) UNSIGNED NOT NULL ,
  `Order_Client_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`Meal_id`, `Order_id`, `Order_Client_id`) ,
  INDEX `fk_Meal_has_Order_Order1_idx` (`Order_id` ASC, `Order_Client_id` ASC) ,
  INDEX `fk_Meal_has_Order_Meal1_idx` (`Meal_id` ASC) ,
  CONSTRAINT `fk_Meal_has_Order_Meal1`
    FOREIGN KEY (`Meal_id` )
    REFERENCES `FondadeDonPanchito`.`Meal` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Meal_has_Order_Order1`
    FOREIGN KEY (`Order_id` , `Order_Client_id` )
    REFERENCES `FondadeDonPanchito`.`Order` (`id` , `Client_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE  TABLE `Item_has_Order` (
  `Item_id` INT(11) UNSIGNED NOT NULL ,
  `Order_id` INT(11) UNSIGNED NOT NULL ,
  `Order_Client_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`Item_id`, `Order_id`, `Order_Client_id`) ,
  INDEX `fk_Item_has_Order_Order1_idx` (`Order_id` ASC, `Order_Client_id` ASC) ,
  INDEX `fk_Item_has_Order_Item1_idx` (`Item_id` ASC) ,
  CONSTRAINT `fk_Item_has_Order_Item1`
    FOREIGN KEY (`Item_id` )
    REFERENCES `FondadeDonPanchito`.`Item` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Order_Order1`
    FOREIGN KEY (`Order_id` , `Order_Client_id` )
    REFERENCES `FondadeDonPanchito`.`Order` (`id` , `Client_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE  TABLE `Item_has_Meal` (
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
    ON UPDATE NO ACTION);