DROP DATABASE IF EXISTS proyecto_final;
CREATE DATABASE proyecto_final CHARACTER SET utf8mb4;
USE proyecto_final;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PROYECTO_FINAL
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PROYECTO_FINAL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PROYECTO_FINAL` DEFAULT CHARACTER SET utf8 ;
USE `PROYECTO_FINAL` ;

-- -----------------------------------------------------
-- Table `PROYECTO_FINAL`.`PROVEEDOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROYECTO_FINAL`.`PROVEEDOR` ;

CREATE TABLE IF NOT EXISTS `PROYECTO_FINAL`.`PROVEEDOR` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NULL,
  `telefono` VARCHAR(45) NULL,
  `fax` VARCHAR(45) NULL,
  `nif` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE INDEX `id_proveedor_UNIQUE` (`id_proveedor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROYECTO_FINAL`.`MARCA_PROVEEDOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROYECTO_FINAL`.`MARCA_PROVEEDOR` ;

CREATE TABLE IF NOT EXISTS `PROYECTO_FINAL`.`MARCA_PROVEEDOR` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `nombre_marca` VARCHAR(45) NULL,
  `id_proveedor` INT NULL,
  PRIMARY KEY (`id_marca`),
  UNIQUE INDEX `id_marca_UNIQUE` (`id_marca` ASC) VISIBLE,
  INDEX `fk_MARCA_PROVEEDOR_PROVEEDOR1_idx` (`id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_MARCA_PROVEEDOR_PROVEEDOR1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `PROYECTO_FINAL`.`PROVEEDOR` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROYECTO_FINAL`.`GAFAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROYECTO_FINAL`.`GAFAS` ;

CREATE TABLE IF NOT EXISTS `PROYECTO_FINAL`.`GAFAS` (
  `id_gafas` INT NOT NULL AUTO_INCREMENT,
  `id_marca` INT NULL,
  `graduacion_cristales` VARCHAR(45) NULL,
  `tipo_montura` VARCHAR(45) NULL,
  `color_montura` VARCHAR(45) NULL,
  `color_cristal` VARCHAR(45) NULL,
  `precio` INT NULL,
  PRIMARY KEY (`id_gafas`),
  UNIQUE INDEX `id_gafas_UNIQUE` (`id_gafas` ASC) VISIBLE,
  INDEX `fk_GAFAS_MARCA_PROVEEDOR1_idx` (`id_marca` ASC) VISIBLE,
  CONSTRAINT `fk_GAFAS_MARCA_PROVEEDOR1`
    FOREIGN KEY (`id_marca`)
    REFERENCES `PROYECTO_FINAL`.`MARCA_PROVEEDOR` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROYECTO_FINAL`.`CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROYECTO_FINAL`.`CLIENTE` ;

CREATE TABLE IF NOT EXISTS `PROYECTO_FINAL`.`CLIENTE` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `direccion_postal` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `registro` DATE NULL,
  `recomendado_por` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `id_cliente_UNIQUE` (`id_cliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROYECTO_FINAL`.`EMPLEADOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROYECTO_FINAL`.`EMPLEADOS` ;

CREATE TABLE IF NOT EXISTS `PROYECTO_FINAL`.`EMPLEADOS` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `id_empleado_UNIQUE` (`id_empleado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROYECTO_FINAL`.`VENTAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROYECTO_FINAL`.`VENTAS` ;

CREATE TABLE IF NOT EXISTS `PROYECTO_FINAL`.`VENTAS` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `id_empleado` INT NOT NULL,
  `id_cliente` INT NULL,
  `fecha` DATE NULL,
  PRIMARY KEY (`id_venta`),
  UNIQUE INDEX `id_venta_UNIQUE` (`id_venta` ASC) VISIBLE,
  INDEX `fk_VENTAS_EMPLEADOS_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `fk_VENTAS_CLIENTE1_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_VENTAS_EMPLEADOS`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `PROYECTO_FINAL`.`EMPLEADOS` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENTAS_CLIENTE1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `PROYECTO_FINAL`.`CLIENTE` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROYECTO_FINAL`.`VENTAS_ITEMS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PROYECTO_FINAL`.`VENTAS_ITEMS` ;

CREATE TABLE IF NOT EXISTS `PROYECTO_FINAL`.`VENTAS_ITEMS` (
  `id_venta` INT NOT NULL,
  `id_gafas` INT NOT NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`id_gafas`, `id_venta`),
  INDEX `fk_VENTAS_ITEMS_VENTAS1_idx` (`id_venta` ASC) VISIBLE,
  CONSTRAINT `fk_VENTAS_ITEMS_VENTAS1`
    FOREIGN KEY (`id_venta`)
    REFERENCES `PROYECTO_FINAL`.`VENTAS` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENTAS_ITEMS_GAFAS1`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `PROYECTO_FINAL`.`GAFAS` (`id_gafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- tabla clientes:

INSERT INTO `proyecto_final`.`cliente` (`nombre`, `direccion_postal`, `telefono`, `email`, `registro`) VALUES ('Juan Perez', '08006', '(+34) 678564120', 'juanperez@gmail.com', '2018-06-22');
INSERT INTO `proyecto_final`.`cliente` (`nombre`, `direccion_postal`, `telefono`, `email`, `registro`, `recomendado_por`) VALUES ('Marta Campos', '90679', '(+34) 3987087926 ', 'martacampos@hotmail.com', '2018-06-28', 'Juan Perez');
INSERT INTO `proyecto_final`.`cliente` (`nombre`, `direccion_postal`, `telefono`, `email`, `registro`, `recomendado_por`) VALUES ('Joaquin Fernandez ', '08023', '(+34) 456825333 ', 'juaquin88@gmail.com', '2018-07-17', 'Juan Perez');
INSERT INTO `proyecto_final`.`cliente` (`nombre`, `direccion_postal`, `telefono`, `email`, `registro`, `recomendado_por`) VALUES ('Ignacio Garcia', '08011', '(+34) 123456789', 'ignaciogarcia@hotmail.com', '2018-07-18', 'Marta Campos');


-- tabla empleados:
INSERT INTO `proyecto_final`.`empleados` (`nombre`, `apellido`) VALUES ('Marc', 'Puig');
INSERT INTO `proyecto_final`.`empleados` (`nombre`, `apellido`) VALUES ('Luca', 'Passini');
INSERT INTO `proyecto_final`.`empleados` (`nombre`, `apellido`) VALUES ('Dayan', 'Garcia Perez');

-- tabla proveedor:
INSERT INTO `proyecto_final`.`proveedor` (`nombre`, `direccion`, `telefono`, `fax`, `nif`) VALUES ('Gafalandia', 'Via Laietana, 36, 08003 Barcelona', '(+34) 456123789', '456123777', 'a1111111b');
INSERT INTO `proyecto_final`.`proveedor` (`nombre`, `direccion`, `telefono`, `fax`, `nif`) VALUES ('Glassnew', 'Avinguda Meridiana, 216, 08027 Barcelona', '(+34) 555666777', '555666788', 'b2222222n');
INSERT INTO `proyecto_final`.`proveedor` (`nombre`, `direccion`, `telefono`, `fax`, `nif`) VALUES ('Seeit', 'Arrabal Dalt, 4, 25633 Palau de Noguera, Lleida', '(+34) 333222111', '333222114', 'n3333333b');


-- tabla marca:
INSERT INTO `proyecto_final`.`marca_proveedor` (`nombre_marca`, `id_proveedor`) VALUES ('Hawkers', '1');
INSERT INTO `proyecto_final`.`marca_proveedor` (`nombre_marca`, `id_proveedor`) VALUES ('Ray-band', '1');
INSERT INTO `proyecto_final`.`marca_proveedor` (`nombre_marca`, `id_proveedor`) VALUES ('Miu Miu', '1');
INSERT INTO `proyecto_final`.`marca_proveedor` (`nombre_marca`, `id_proveedor`) VALUES ('Bakley', '2');
INSERT INTO `proyecto_final`.`marca_proveedor` (`nombre_marca`, `id_proveedor`) VALUES ('Dior', '3');
INSERT INTO `proyecto_final`.`marca_proveedor` (`nombre_marca`, `id_proveedor`) VALUES ('Emporio Armani', '3');


-- tabla ventas:
INSERT INTO `proyecto_final`.`ventas` (`id_empleado`, `id_cliente`, `fecha`) VALUES ('1', '1', '2018-06-22');
INSERT INTO `proyecto_final`.`ventas` (`id_empleado`, `id_cliente`, `fecha`) VALUES ('2', '1', '2018-06-25');
INSERT INTO `proyecto_final`.`ventas` (`id_empleado`, `id_cliente`, `fecha`) VALUES ('2', '2', '2018-06-28');
INSERT INTO `proyecto_final`.`ventas` (`id_empleado`, `id_cliente`, `fecha`) VALUES ('3', '3', '2018-07-17');
INSERT INTO `proyecto_final`.`ventas` (`id_empleado`, `id_cliente`, `fecha`) VALUES ('1', '2', '2018-07-17');
INSERT INTO `proyecto_final`.`ventas` (`id_empleado`, `id_cliente`, `fecha`) VALUES ('3', '4', '2018-07-18');
INSERT INTO `proyecto_final`.`ventas` (`id_empleado`, `id_cliente`, `fecha`) VALUES ('3', '4', '2018-07-29');


-- tabla gafas:
INSERT INTO `proyecto_final`.`gafas` (`id_marca`, `graduacion_cristales`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES ('1', '0.25-0.5', 'metálica', 'plateado', 'tranparente', '50');
INSERT INTO `proyecto_final`.`gafas` (`id_marca`, `graduacion_cristales`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES ('1', '0.5-3.0', 'flotante', 'tranparente', 'amarillo', '90');
INSERT INTO `proyecto_final`.`gafas` (`id_marca`, `graduacion_cristales`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES ('2', '1.5-3.0', 'pasta', 'negro', 'tranparente', '55');
INSERT INTO `proyecto_final`.`gafas` (`id_marca`, `graduacion_cristales`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES ('3', '0.25-1.0', 'pasta', 'azul', 'azul', '85');
INSERT INTO `proyecto_final`.`gafas` (`id_marca`, `graduacion_cristales`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES ('3', '0.25-0.5', 'pasta', 'plateado', 'negro', '60');
INSERT INTO `proyecto_final`.`gafas` (`id_marca`, `graduacion_cristales`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES ('4', '0.25-0.5', 'metálica', 'plateado', 'tranparente', '100');
INSERT INTO `proyecto_final`.`gafas` (`id_marca`, `graduacion_cristales`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES ('5', '0.25-0.5', 'flotante', 'tranparente', 'tranparente', '120');
INSERT INTO `proyecto_final`.`gafas` (`id_marca`, `graduacion_cristales`, `tipo_montura`, `color_montura`, `color_cristal`, `precio`) VALUES ('6', '0.25-3.0', 'metálica', 'plateado', 'negro', '90');

-- tabla ventas_items:
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('1', '8', '1');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('1', '7', '1');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('2', '3', '2');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('3', '5', '1');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('3', '2', '2');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('4', '1', '3');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('5', '4', '1');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('6', '6', '1');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('6', '8', '1');
INSERT INTO `proyecto_final`.`ventas_items` (`id_venta`, `id_gafas`, `cantidad`) VALUES ('7', '1', '1');

