-- Active: 1702159022160@@127.0.0.1@3306@bdmoneyinout

-- DROP DATABASE `bdmoneyinout`;

-- // ******************* CREAING FATHER TABLES ******************************//
CREATE DATABASE IF NOT EXISTS bdMoneyInOut;
USE bdMoneyInOut;

CREATE TABLE IF NOT EXISTS bdmoneyinout.tbPerson
(
	id    			INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	FirstName 		VARCHAR(30) NOT NULL,
    LastName        VARCHAR(30) NOT NULL,
    Email  	        VARCHAR(60) NOT NULL UNIQUE,
    
    PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbPeriodicity
(
    id          INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    PeriType    VARCHAR(30) NOT NULL UNIQUE,
    Descrip     VARCHAR(60),
    PRIMARY KEY (id)
)ENGINE = InnoDB;


-- //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- // ******************* CREAING SON TABLES ******************************//

-- //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CREATE TABLE IF NOT EXISTS bdmoneyinout.tbInputType
(
	id    			INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	InputType 		VARCHAR(30) NOT NULL UNIQUE,
    Descrip 	    VARCHAR(60),
    idPeriodicity   INT UNSIGNED,
    KEY idx_fk_idPeriodicity(idPeriodicity),    
    CONSTRAINT fk_inputType_peridicity FOREIGN KEY (idPeriodicity) REFERENCES tbPeriodicity (id) ON DELETE NO ACTION,    
    PRIMARY KEY (id)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS bdmoneyinout.tbExitType
(
	id    			INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	ExitType 		VARCHAR(30) NOT NULL UNIQUE,
    Descrip 	    VARCHAR(60),
    
    idPeriodicity   INT UNSIGNED,
    KEY idx_fk_idPeriodicity(idPeriodicity),    
    CONSTRAINT fk_exitType_peridicity FOREIGN KEY (idPeriodicity) REFERENCES tbPeriodicity (id) ON DELETE NO ACTION,
    PRIMARY KEY (id)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS bdmoneyinout.tbUser
(
	id    			INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	UserName  		VARCHAR(40) UNIQUE NOT NULL,
    passwrd         VARCHAR(100) NOT NULL,
    
    idPerson        INT UNSIGNED,
    PRIMARY KEY (id),
    KEY idx_fk_idPerson(idPerson),    
    CONSTRAINT fk_User_Person FOREIGN KEY (idPerson) REFERENCES tbPerson (id) ON DELETE CASCADE 
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdmoneyinout.tbMoneyBalnce
(
	id    			INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    idUser          INT UNSIGNED,
	Balance		    DECIMAL(10,2) DEFAULT 0 COMMENT 'To store the money left to every user',
    
    PRIMARY KEY (id),
    CONSTRAINT fk_MoneyBalnce_User FOREIGN KEY (idUser) REFERENCES tbUser (id) ON DELETE CASCADE 
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdmoneyinout.tbMoneyIncome
(
	id    			INT NOT NULL UNIQUE AUTO_INCREMENT,
	Amount 		    DECIMAL(10,2) DEFAULT 0 COMMENT 'Income quantity',
    DateMv          DATETIME NOT NULL,
    Descrip         VARCHAR(60) NOT NULL,
    
    idUser          INT UNSIGNED,
    idInputType     INT UNSIGNED,
    
    PRIMARY KEY (id),
    INDEX idx_fk_idUser(idUser),    
    CONSTRAINT fk_MoneyIncomeUser FOREIGN KEY (idUser) REFERENCES tbUser (id) ON DELETE CASCADE,
    INDEX idx_fk_idInputType(idInputType),    
    CONSTRAINT fk_MoneyIncomeInputType FOREIGN KEY (idInputType) REFERENCES tbInputType (id) ON DELETE CASCADE 
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdmoneyinout.tbMoneyOutGoing
(
	id    			INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	Amount 		    DECIMAL(10,2) DEFAULT 0 COMMENT 'Income quantity',
    DateMv          DATETIME NOT NULL,
    Descrip         VARCHAR(60) NOT NULL,
    
    idUser          INT UNSIGNED,
    idExitType      INT UNSIGNED,
    
    PRIMARY KEY (id),
    INDEX idx_fk_idUser(idUser),    
    CONSTRAINT fk_MoneyOutGoingUser FOREIGN KEY (idUser) REFERENCES tbUser (id) ON DELETE CASCADE,
    INDEX idx_fk_idExitType(idExitType),    
    CONSTRAINT fk_MoneyOutGoingInputType FOREIGN KEY (idExitType) REFERENCES tbExitType (id) ON DELETE CASCADE 
)ENGINE = InnoDB;
