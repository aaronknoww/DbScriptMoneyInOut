
-- |||||||||||||||||| PERIODICITY ||||||||||

INSERT INTO tbperiodicity(id, `PeriType`,`Descrip`) VALUES(0,'recurrent','To search the movements that are always made.');
INSERT INTO tbperiodicity(id, `PeriType`,`Descrip`) VALUES(0,'extraordinary','To look for movements that are not done regularly.');


-- |||||||||||||||| TABLE INPUT TYPE VALUES |||||||||||||||||||||||

INSERT INTO tbinputtype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Agua','Pago de recibo de Agua');
INSERT INTO tbinputtype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Luz','Pago de recibo de Luz');
INSERT INTO tbinputtype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Gas','Pago de recibo de Gas');
INSERT INTO tbinputtype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Cable','Pago de recibo de Cable');

-- ||||||||||||||| TABLE EXIT TYPE VALUES |||||||||||||||||||||||||||||

INSERT INTO tbexittype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Agua','Pago de recibo de Agua');
INSERT INTO tbexittype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Luz','Pago de recibo de Luz');
INSERT INTO tbexittype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Gas','Pago de recibo de Gas');
INSERT INTO tbexittype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,1,'Cable','Pago de recibo de Cable');
INSERT INTO tbexittype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,2,'GastoCasa','Techar');
INSERT INTO tbexittype(id, `idPeriodicity`, `InputType`, `Descrip` ) VALUES(0,2,'GastoCasa','Enjarrar pared');

 