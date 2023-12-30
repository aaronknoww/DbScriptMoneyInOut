-- Active: 1702159022160@@127.0.0.1@3306@bdmoneyinout

-- CALL addUser('Aaron','Hernandez','aaronhdz1919@gmail.com','aaronknow19','lamaquina',110000.00 );
DROP PROCEDURE IF EXISTS addUser;
DELIMITER // 
CREATE PROCEDURE addUser(IN FirstN VARCHAR(30), IN LastN VARCHAR(30), IN mail VARCHAR(60),
        IN UserN VARCHAR(40), pass VARCHAR(40), IN Amount DECIMAL(10,2))
BEGIN
    DECLARE newId  INT DEFAULT 0;
    DECLARE sql_error TINYINT DEFAULT FALSE;
    
    START TRANSACTION;
    INSERT INTO tbPerson(id, `FirstName`, `LastName`, `Email`) 
                VALUES(0,FirstN, LastN, mail);
    
    SELECT MAX(id) into newId FROM tbPerson;

    INSERT INTO tbUser(id, `idPerson`, `UserName`, `passwrd`) 
                VALUES(0, newId, UserN, pass);
    
    SELECT MAX(id) into newId FROM tbUser;
        INSERT INTO tbMoneyBalnce(id, `idUser`, `Balance`)
                    VALUES(0,newId,Amount);					

    IF (sql_error = FALSE) THEN
		COMMIT; -- Si no hay error ejecuta todas las transacciones
	ELSE
		ROLLBACK; -- Si encutra algun error en 1 de las transacciones deja las tablas en su estado original.

	END IF;      
    	
    
END //
DELIMITER ;

-- |||  ADD INCOME PROCEDURE  |||||

DROP PROCEDURE IF EXISTS addIncome;
DELIMITER // 
CREATE PROCEDURE addIncome(IN userId INT, IN idType INT , IN quantity DECIMAL(10,2), IN dateIn DATETIME, IN dcp VARCHAR(60))
BEGIN

    DECLARE newId  INT UNSIGNED DEFAULT 1000;
    DECLARE res DECIMAL (10,2) DEFAULT 0.0;
    DECLARE sql_error TINYINT DEFAULT FALSE;
    
    THIS_PROC: BEGIN

    SELECT COUNT(*) INTO newId FROM tbuser WHERE userId = id;
 
    IF( newId < 1)THEN			
      SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT = 'ERROR USER ID DOES NOT EXIST';
			LEAVE THIS_PROC; -- Sale del procedimiento debido a que no hay condiciones para continuar con la ejecucion.
	END IF;
    
     SELECT COUNT(*) INTO newId FROM tbInputType WHERE idType = id;
 
    IF( newId < 1)THEN			
      SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT = 'ERROR: THERE INPUT TYPE DOES NOT EXIST';
			LEAVE THIS_PROC; -- Sale del procedimiento debido a que no hay condiciones para continuar con la ejecucion.
	END IF;

    START TRANSACTION;

    SELECT id INTO newId FROM tbuser WHERE userId = id;

    SELECT Balance INTO res FROM tbmoneybalnce WHERE id = userId;

    SET res = res + quantity;

    INSERT INTO tbmoneyincome(id, `idInputType`, `idUser`, `Amount`, `DateMv`, `Descrip`) 
                VALUES(0,idType, userId, quantity, dateIn, dcp);
    
    UPDATE bdmoneyinout.tbmoneybalnce SET Balance =  res WHERE (tbmoneybalnce.idUser = userId);
    
    IF (sql_error = FALSE) THEN
		COMMIT; -- Si no hay error ejecuta todas las transacciones
	ELSE
		ROLLBACK; -- Si encutra algun error en 1 de las transacciones deja las tablas en su estado original.

	END IF;      
    	
	END; --  END OF PROCEDURE.
END //
DELIMITER ;






-- |||||||||||||| ADDOUTGOING |||||||||||||||||
DROP PROCEDURE IF EXISTS addOutGoing;
DELIMITER //
CREATE PROCEDURE addOutGoing(IN idType INT , IN userId INT , IN quantity DECIMAL(10,2), IN dateIn DATETIME, IN dcp VARCHAR(60))
BEGIN

    DECLARE newId  INT UNSIGNED DEFAULT 1000;
    DECLARE res DECIMAL (10,2) DEFAULT 0.0;
    DECLARE sql_error TINYINT DEFAULT FALSE;
    
    THIS_PROC: BEGIN

    SELECT COUNT(*) INTO newId FROM tbuser WHERE userId = idUser;
 
    IF( newId < 1)THEN			
      SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT = 'ERROR USER ID DOES NOT EXIST';
			LEAVE THIS_PROC; -- Sale del procedimiento debido a que no hay condiciones para continuar con la ejecucion.
	END IF;
    
    SELECT COUNT(*) INTO newId FROM tbInputType WHERE userId = idUser;
    IF( newId < 1)THEN			
      SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT = 'ERROR USER ID DOES NOT EXIST';
			LEAVE THIS_PROC; -- Sale del procedimiento debido a que no hay condiciones para continuar con la ejecucion.
	END IF;

    START TRANSACTION;

    SELECT id INTO newId FROM tbuser WHERE userId = idUser;

    SELECT Balance INTO res FROM tbmoneybalnce WHERE idUser = userId;

    SET res = res - quantity;

    INSERT INTO tbMonesOutGoing(id, `idInputType`, `idUser`, `Amount`, `DateMv`, `Descrip`) 
                VALUES(0,idType, userId, quantity, dateIn, dcp);
     UPDATE bdmoneyinout.tbmoneybalnce SET Balance =  res WHERE (tbmoneybalnce.idUser = userId);
        
    IF (sql_error = FALSE) THEN
		COMMIT; -- Si no hay error ejecuta todas las transacciones
	ELSE
		ROLLBACK; -- Si encutra algun error en 1 de las transacciones deja las tablas en su estado original.

	END IF;      
    	
	END; --  END OF PROCEDURE.
END //
DELIMITER ;


-- |||||||||*********** procedure to know how much money income ************** ||||||||||||||

-- /// TODO: ESTE PROCEDIMENTO NO ESTA LISTO 

DROP PROCEDURE IF EXISTS estadisticaVentas;
DELIMITER // 
CREATE PROCEDURE queryMoneyIncome(IN userId INT, IN period INT, initialDate DATETIME, finalDate DATETIME )
BEGIN

-- period -----> Enter a number between 1 and 3 to indicate whether the consultation is for 1.- week, 2.- month, or 3.- year.
-- fechaIncial--> The date on which the query begins cannot be less than 2023.
-- fechaFinal --> The date on which the query ends cannot be bigger than curret date.

     DECLARE sql_error TINYINT DEFAULT FALSE;
     
     THIS_PROC: BEGIN
     
     
		IF( ( (SELECT NOW() )>initialDate ) OR ( ( SELECT NOW() > finalDate) ) OR ( ( initialDate > finalDate) ) ) 
			THEN 
            
            -- Si encuentra algun erro en las fechas se sale de la consulta y genera un error.
            
            SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT='WRONG QUERY DATE';
            LEAVE THIS_PROC;
        END IF;
    
    
    
		IF(periodo=1) THEN
        
		-- MUESTRA LA CONSULTA AGRUPANDO RESULTADOS POR SEMANA.
        
		
			
			 SELECT week(DateMv) as weekM, DATE_FORMAT(tbMoneyIncome.DateMv, '%d-%m-%Y %T')  AS 'DateMove', 
				tbMoneyIncome.Amount, sum(Amount) AS 'Income by week'
				FROM tbMoneyIncome				
				WHERE (DateMv>=initialDate)
				AND (DateMv<=finalDate)
				AND (idUser = userId)
				GROUP BY weekM
                WITH ROLLUP;
		                             
               
		ELSEIF(periodo=2) THEN
        
        -- MUESTRA LA CONSULTA AGRUPANDO RESULTADOS POR MES.
        
			SET lc_time_names = 'es_ES'; -- Para poner los nombres de los meses en espa;ol
        
		    SELECT monthname(fechaMov) as Mes, ifnull(muebles.NombreMueble, 'TOTAL') AS Mueble, DATE_FORMAT(movimientos_financieros.fechaMov, '%d-%m-%Y %T')  AS 'FechadeVenta', 
				movimientos_financieros.cantidad AS 'Precio', sum(cantidad) AS 'VentasPorMes'
				FROM ventas
				INNER JOIN movimientos_financieros ON movimientos_financieros.id = ventas.id 
				INNER JOIN muebles ON idMuebles2=idMuebles
				WHERE (movimientos_financieros.fechaMov>=fechaInicial)
				AND (movimientos_financieros.fechaMov<=fechaFinal)
				GROUP BY Mes, muebles.idMuebles
                WITH ROLLUP;
        			
        ELSEIF(periodo=3) THEN
        
        -- MUESTRA LA CONSULTA AGRUPANDO RESULTADOS POR AÑO.
        
			 SELECT year(fechaMov) as Anio, ifnull(muebles.NombreMueble, 'TOTAL') AS Mueble, DATE_FORMAT(movimientos_financieros.fechaMov, '%d-%m-%Y %T')  AS 'FechadeVenta', 
				movimientos_financieros.cantidad AS 'Precio', sum(cantidad) AS 'VentasPorAnio'
				FROM ventas
				INNER JOIN movimientos_financieros ON movimientos_financieros.id = ventas.id 
				INNER JOIN muebles ON idMuebles2=idMuebles
				WHERE (movimientos_financieros.fechaMov>=fechaInicial)
				AND (movimientos_financieros.fechaMov<=fechaFinal)
				GROUP BY Anio, muebles.idMuebles
                WITH ROLLUP;
            
		ELSE
        
			SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT='FECHA DE CONSULTA, INCORRECTA';
            LEAVE THIS_PROC;
		END IF;
     END; -- Fin del procedimiento.
 
    
END //
DELIMITER ;



