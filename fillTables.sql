

-- |||||||||||||||||| PERIODICITY ||||||||||

INSERT INTO tbperiodicity(id, `PeriType`,`Descrip`) VALUES(0,'recurrent','To search the movements that are always made.');
INSERT INTO tbperiodicity(id, `PeriType`,`Descrip`) VALUES(0,'extraordinary','To look for movements that are not done regularly.');

-- ||||||||||||||| TABLE PERSON VALUES |||||||||||||||||||||||||||||
INSERT INTO tbperson(id,`FirstName`,`LastName`,`Email` ) VALUES(0,'Aaron', 'Hernandez', 'aaronhdz1919@gmail.com');
INSERT INTO tbperson(id,`FirstName`,`LastName`,`Email` ) VALUES(0,'Obinze', 'Hernandez', 'aaroncount19@gmail.com');



-- ----------------------------------------------------------
-- ***************** SON TABLES *****************************
-- -----------------------------------------------------------


-- ||||||||||||||| TABLE USER VALUES   |||||||||||||||||||||||||||||
-- INSERT INTO tbUser(id, idPerson, `UserName`, passwrd) VALUES(0,1,'AaronKnow', '1234');
-- INSERT INTO tbUser(id, idPerson, `UserName`, passwrd) VALUES(0,2,'Obinze1984', '1234');

-- ||||||||||| Fill Money Balance Table |||||||||||

-- INSERT INTO tbmoneybalnce(id, idUser,`Balance`)	VALUES(0,1,175000.00);
-- INSERT INTO tbmoneybalnce(id, idUser,`Balance`) VALUES(0,2,10000.00);

-- |||||||||||||||| TABLE INPUT TYPE VALUES |||||||||||||||||||||||

INSERT INTO tbinputtype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Nomina','Nomina de Foxconn');
INSERT INTO tbinputtype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,2,'Ahorro','Pago de ahorro de Foxconn');
INSERT INTO tbinputtype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,2,'Comida','Venta de Comida');
INSERT INTO tbinputtype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Mueble','Venta de Mueble');

-- ||||||||||||||| TABLE EXIT TYPE VALUES |||||||||||||||||||||||||||||

INSERT INTO tbexittype(id, `idPeriodicity`, `ExitType`, `Descrip` ) VALUES(0,1,'Agua','Pago de recibo de Agua');
INSERT INTO tbexittype(id, `idPeriodicity`, `ExitType`, `Descrip` ) VALUES(0,1,'Luz','Pago de recibo de Luz');
INSERT INTO tbexittype(id, `idPeriodicity`, `ExitType`, `Descrip` ) VALUES(0,1,'Gas','Pago de recibo de Gas');
INSERT INTO tbexittype(id, `idPeriodicity`, `ExitType`, `Descrip` ) VALUES(0,1,'Cable','Pago de recibo de Cable');
INSERT INTO tbexittype(id, `idPeriodicity`, `ExitType`, `Descrip` ) VALUES(0,2,'GastoCasa','Techar');
INSERT INTO tbexittype(id, `idPeriodicity`, `ExitType`, `Descrip` ) VALUES(0,2,'Enjarrar','Gasto Casa');
        

-- ||||||||||||||| FILL TABLES WITH PROCEDURE ADD USER -> PERSON, USER AND MONEY INCOME ||||||||||||||
CALL addUser('Aaron','Hernandez','aar@gmail.com','aaronknow19','lamaquina',110000.00 );

--  addIncome(IN userId INT, IN idType INT , IN quantity DECIMAL(10,2), IN dateIn DATETIME, IN dcp VARCHAR(60))

CALL addIncome(1, 1, 4000.00, '2023-12-24 19:30:01', 'Pago de nomina semana 52'); 

-- addOutGoing(idType, userId, quantity DECIMAL(10,2), dateIn DATETIME, dcp VARCHAR(60))
CALL addOutGoing(1, 1, 750.00, '2023-12-15 19:30:01', 'Agua de la casa');

-- TODO: ESTAN PROBADOS LOS 2 PROCEDIMENTOS, HAY QUE TERMINAR EL QUE ESTA PENDIENTE 


 