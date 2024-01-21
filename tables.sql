-- Active: 1702159022160@@127.0.0.1@3306@bdmoneyinout

-- DROP DATABASE `bdmoneyinout`;

-- // ******************* CREAING FATHER TABLES ******************************//
CREATE DATABASE IF NOT EXISTS bdMoneyInOut;
USE bdMoneyInOut;

CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbPerson
(
	id    			SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	FirstName 		VARCHAR(30) NOT NULL,
    LastName        VARCHAR(30) NOT NULL,
    Email  	        VARCHAR(60) NOT NULL UNIQUE,
    
    PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbPeriodicity
(
    id          TINYINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    PeriType    VARCHAR(30) NOT NULL UNIQUE,
    Descrip     VARCHAR(60),
    PRIMARY KEY (id)
)ENGINE = InnoDB;

-- Table to store every type of inner or outter movement
CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbTypeCatalogue
(
	id    			SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	TypeC	 		VARCHAR(30) NOT NULL UNIQUE,
    Descrip         VARCHAR(30) NULL,
        
    PRIMARY KEY (id)
)ENGINE = InnoDB;

-- To separate every catolog entry in groups
CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbGroupInOut
(
	id    			SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	TypeG	 		VARCHAR(30) NOT NULL UNIQUE,
    Descrip         VARCHAR(30) NULL,
        
    PRIMARY KEY (id)
)ENGINE = InnoDB;

-- To store diferents buildings like a house o restaurant.
CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbRealState
(
	id    			SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	Building 		VARCHAR(30) NOT NULL UNIQUE,
    Street          VARCHAR(30) NULL,
    Num				VARCHAR(10) NULL,
    Descrip         VARCHAR(30) NULL,
        
    PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbAutomovil
(
	id    			SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	Make	 		VARCHAR(30) NOT NULL UNIQUE,
    Model           VARCHAR(30) NULL,
    Yearr			VARCHAR(4)  NULL,
    Descrip         VARCHAR(30) NULL,
        
    PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbDependent
(
	id    			SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	FirstName		VARCHAR(30) NOT NULL,
    LastName        VARCHAR(30) NOT NULL,
    Birth           DATETIME    NOT NULL,
        
    PRIMARY KEY (id)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbCreditCard
(
	id    			SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	CardName 		VARCHAR(30) NOT NULL UNIQUE,
    Institution     VARCHAR(30) NOT NULL,
    CreditLine 	    DECIMAL(10,2) DEFAULT(0.0),
    AproveDate      DATETIME NOT NULL,
    Descrip         VARCHAR(30) NULL,
        
    PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdMoneyInOut.tbOutcomeType
(
    id          TINYINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    OutType     VARCHAR(30) NOT NULL UNIQUE,
    Descrip     VARCHAR(60),
    PRIMARY KEY (id)
)ENGINE = InnoDB;


-- //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- // ******************* CREAING SON TABLES ******************************//

-- //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CREATE TABLE IF NOT EXISTS bdmoneyinout.tbUser
(
	id    			SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	UserName  		VARCHAR(40) UNIQUE NOT NULL,
    passwrd         VARCHAR(100) NOT NULL,
    
    idPerson        SMALLINT UNSIGNED,
    PRIMARY KEY (id),
    KEY idx_fk_idPerson(idPerson),    
    CONSTRAINT fk_User_Person FOREIGN KEY (idPerson) REFERENCES tbPerson (id) ON DELETE CASCADE 
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS bdmoneyinout.tbMovement
(
	id    			INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	Amount 		    DECIMAL(10,2) DEFAULT 0 COMMENT 'Income or Outcome quantity',
	Balance		    DECIMAL(10,2) DEFAULT 0 COMMENT 'Money after store movement',
    DateMv          DATETIME NOT NULL,
    Descrip         VARCHAR(60) NOT NULL,
    
    idUser          SMALLINT UNSIGNED,
    idCatalogue     SMALLINT UNSIGNED,
    idGroup			SMALLINT UNSIGNED,
    idPeriodicity	TINYINT  UNSIGNED,
    
    PRIMARY KEY (id),
    INDEX idx_fk_idUser(idUser),    
    CONSTRAINT fk_Movement_User FOREIGN KEY (idUser) REFERENCES tbUser (id) ON DELETE NO ACTION,
       
    CONSTRAINT fk_Movement_TypeCatalogue FOREIGN KEY (idCatalogue) REFERENCES tbtypecatalogue (id) ON DELETE NO ACTION ,    
    CONSTRAINT fk_Movement_GroupInOut FOREIGN KEY (idGroup) REFERENCES tbgroupinout (id) ON DELETE NO ACTION,
    CONSTRAINT fk_Movement_Periodicity FOREIGN KEY (idPeriodicity) REFERENCES tbperiodicity (id) ON DELETE NO ACTION
)ENGINE = InnoDB;

-- todo: terminar esta tabla
CREATE TABLE IF NOT EXISTS bdmoneyinout.tbOutcomeDetail
(
	id    			INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	
    idTypeOut	 	TINYINT UNSIGNED NOT NULL,
    idOutTable      SMALLINT UNSIGNED NOT NULL, -- TO STORE ID FROM 4 TABLES OF OUTCOMES.
    idMovement 		INT UNSIGNED NOT NULL,   
    
    PRIMARY KEY (id),
    CONSTRAINT fk_OutcomeDetail_TypeOut FOREIGN KEY (idTypeOut) REFERENCES tboutcometype (id) ON DELETE NO ACTION,
    INDEX idx_fk_idTypeOut(idTypeOut),    
    CONSTRAINT fk_OutcomeDetail_Movement FOREIGN KEY (idMovement) REFERENCES tbmovement (id) ON DELETE NO ACTION,
    
    CONSTRAINT fk_OutcomeDetail_RealState  FOREIGN KEY (idOutTable) REFERENCES tbrealstate  (id) ON DELETE NO ACTION,
    CONSTRAINT fk_OutcomeDetail_Automovil  FOREIGN KEY (idOutTable) REFERENCES tbautomovil  (id) ON DELETE NO ACTION,
    CONSTRAINT fk_OutcomeDetail_Dependent  FOREIGN KEY (idOutTable) REFERENCES tbdependent  (id) ON DELETE NO ACTION,
    CONSTRAINT fk_OutcomeDetail_CreditCard FOREIGN KEY (idOutTable) REFERENCES tbcreditcard (id) ON DELETE NO ACTION    
    
)ENGINE = InnoDB;

-- TODO:HACER LA TABLA PARA REGISTRAR TODOS LOS MOVIMIENTOS DE ENTRADA Y SALIDA


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
