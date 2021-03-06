table 59007 "Integration CRM Buffer 1"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Unidad de negocio"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unidad de negocio', Comment = 'ESM="Unidad de negocio"';
        }
        field(3; "Propuesta"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Propuesta', Comment = 'ESM="Propuesta"';
        }
        field(4; "Oportunidad"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Oportunidad', Comment = 'ESM="Oportunidad"';
        }
        field(5; "Cliente"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cliente', Comment = 'ESM="Cliente"';
        }
        field(6; "Tipo de cliente"; Option)
        {
            Caption = 'Tipo de cliente', Comment = 'ESM="Tipo de cliente"';
            OptionMembers = Regulado,Libre;
        }
        field(7; "Tipo de documento DP"; Option)
        {
            Caption = 'Tipo de documento DP', Comment = 'ESM="Tipo de documento DP"';
            OptionMembers = Contrato,Adenda;
        }
        field(8; "Nro. Documento 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. Documento 1', Comment = 'ESM="Nro. Documento"';
        }
        field(9; "Producto"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Producto', Comment = 'ESM="Producto"';
        }
        field(10; "Modelo documeento"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Modelo documeento', Comment = 'ESM="Modelo documeento"';
        }
        field(11; "Contrato principal"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contrato principal', Comment = 'ESM="Contrato principal"';
        }
        field(12; "Moneda_1"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Moneda_1', Comment = 'ESM="Moneda"';
        }
        field(13; "Penalidad Res. Contrato(%)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Penalidad Res. Contrato(%)', Comment = 'ESM="Penalidad por resoluci??n de contrato (%)"';
        }
        field(14; "Responsable Propietario"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Responsable Propietario', Comment = 'ESM="Responsable Propietario"';
        }
        field(15; "Nombre"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nombre', Comment = 'ESM="Nombre"';
        }
        field(16; "Fecha inicio contrato"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha inicio contrato', Comment = 'ESM="Fecha inicio contrato"';
        }
        field(17; "Fecha fin contrato"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha fin contrato', Comment = 'ESM="Fecha fin contrato"';
        }
        field(18; "Fecha inicio real contrato"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha inicio real contrato', Comment = 'ESM="Fecha inicio real contrato"';
        }
        field(19; "Fecha fin real contrato"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha fin real contrato', Comment = 'ESM="Fecha fin real contrato"';
        }
        field(20; "Fecha de firma contrato"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de firma contrato', Comment = 'ESM="Fecha de firma contrato"';
        }
        field(21; "Fecha de revisi??n"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de revisi??n', Comment = 'ESM="Fecha de revisi??n"';
        }
        field(22; "Fec. Resoluci??n observaciones"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fec. Resoluci??n observaciones', Comment = 'ESM="Fecha de resoluci??n de observaciones"';
        }
        field(23; "Fecha de env??o de contrato"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de env??o de contrato', Comment = 'ESM="Fecha de env??o de contrato"';
        }
        field(24; "Tipo de documento IF"; Option)
        {
            Caption = 'Tipo de documento', Comment = 'ESM="Tipo de documento"';
            OptionMembers = DNI,Pasaporte,"Carnet de Extranjer??a",Interno,RUC,RUT,NIT;
        }
        field(25; "Nro. documento"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. documento', Comment = 'ESM="Nro. documento"';
        }
        field(26; "Direcci??n IC"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Direcci??n IC', Comment = 'ESM="Direcci??n"';
        }
        field(27; "Pa??s"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Pa??s', Comment = 'ESM="Pa??s"';
        }
        field(28; "Departamento / Regi??n"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Departamento / Regi??n', Comment = 'ESM="Departamento / Regi??n"';
        }
        field(29; "Provincia"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Provincia', Comment = 'ESM="Provincia"';
        }
        field(30; "Distrito / Comuna"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Distrito / Comuna', Comment = 'ESM="Distrito / Comuna"';
        }
        field(31; "Representante Atria (1)"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Representante Atria (1)', Comment = 'ESM="Representante Atria (1)"';
        }
        field(32; "Representante Atria (2)"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Representante Atria (2)', Comment = 'ESM="Representante Atria (2)"';
        }
        field(33; "Representante cliente (1)"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Representante cliente (1)', Comment = 'ESM="Representante cliente (1)"';
        }
        field(34; "Cargo RL 1"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cargo RL 1', Comment = 'ESM="Cargo"';
        }
        field(35; "Direcci??n RL "; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Direcci??n RL ', Comment = 'ESM="Direcci??n"';
        }
        field(36; "Correo Electr??nico RL"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Correo Electr??nico RL', Comment = 'ESM="Correo Electr??nico"';
        }
        field(37; "tel??fono celular RL"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'tel??fono celular RL', Comment = 'ESM="tel??fono celular"';
        }
        field(38; "Representante cliente (2)"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Representante cliente (2)', Comment = 'ESM="Representante cliente (2)"';
        }
        field(39; "Cargo"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cargo', Comment = 'ESM="Cargo"';
        }
        field(40; "Direcci??n"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Direcci??n', Comment = 'ESM="Direcci??n"';
        }
        field(41; "Correo Electr??nico"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Correo Electr??nico', Comment = 'ESM="Correo Electr??nico"';
        }
        field(42; "tel??fono celular"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'tel??fono celular', Comment = 'ESM="tel??fono celular"';
        }
        field(43; "Nro. Partida"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. Partida', Comment = 'ESM="Nro. Partida"';
        }
        field(44; "Fecha escritura p??blica"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha escritura p??blica', Comment = 'ESM="Fecha escritura p??blica"';
        }
        field(45; "Notaria escritura p??blica"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Notaria escritura p??blica', Comment = 'ESM="Notaria escritura p??blica"';
        }
        field(46; "Ciudad escritura p??blica"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ciudad escritura p??blica', Comment = 'ESM="Ciudad escritura p??blica"';
        }
        field(47; "Aval cliente (1)"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Aval cliente (1)', Comment = 'ESM="Aval cliente (1)"';
        }
        field(48; "Aval cliente (2)"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Aval cliente (2)', Comment = 'ESM="Aval cliente (2)"';
        }
        field(49; "Aval cliente (3)"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Aval cliente (3)', Comment = 'ESM="Aval cliente (3)"';
        }
        field(50; "Aval cliente (4)"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Aval cliente (4)', Comment = 'ESM="Aval cliente (4)"';
        }
        field(51; "Es una migraci??n"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Es una migraci??n', Comment = 'ESM="Es una migraci??n"';
        }
        field(52; "Realizo enc. 6m despues inic."; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Realizo enc. 6m despues inic.', Comment = 'ESM="Realizo encuesta 6 meses despu??s de inicio"';
        }
        field(53; "Renovaci??n autom??tica"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renovaci??n autom??tica', Comment = 'ESM="Renovaci??n autom??tica"';
        }
        field(54; "Nro. de a??os a renovar"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. de a??os a renovar', Comment = 'ESM="Nro. de a??os a renovar"';
        }
        field(55; "Plazo solicitud no renov. (m)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plazo solicitud no renov. (m)', Comment = 'ESM="Plazo de solicitud de no renovaci??n (Meses)"';
        }
        field(56; "Derecho preferente"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Derecho preferente', Comment = 'ESM="Derecho preferente"';
        }
        field(57; "Plazo sol. Nvas cotizaciones"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plazo sol. Nvas cotizaciones', Comment = 'ESM="Plazo para solicitar nuevas cotizaciones (Meses)"';
        }
        field(58; "Cantidad de cot. solicitadas"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cantidad de cot. solicitadas', Comment = 'ESM="Cantidad de cotizaciones solicitadas"';
        }
        field(59; "Plazo inf. mejor oferta rec(D)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plazo inf. mejor oferta rec(D)', Comment = 'ESM="Plazo para informar mejor oferta recibida (D??as)"';
        }
        field(60; "Plazo inf. decisi??nDer.Pref(D)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plazo inf. decisi??nDer.Pref(D)', Comment = 'ESM="Plazo para inf. decisi??n derecho preferente (D??as)"';
        }
        field(61; "Plazo sol. aumentoPot/Ene.(M)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plazo sol. aumentoPot/Ene.(M)', Comment = 'ESM="Plazo solicitud aumento Potencia y Energ??a (Meses)"';
        }
        field(62; "Plz. R. solic. aumentoPot/EneD"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plz. R. solic. aumentoPot/EneD', Comment = 'ESM="Plazo respuesta solic. aumento Pot. y Ene. (D??as)"';
        }
        field(63; "Plazo de emisi??n de factura(D)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plazo de emisi??n de factura(D)', Comment = 'ESM="Plazo de emisi??n de factura (D??as)"';
        }
        field(64; "Plazo de pago (D??as)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plazo de pago (D??as)', Comment = 'ESM="Plazo de pago (D??as)"';
        }
        field(65; "Plz. Pago ent. fact (texto)-CI"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plz. Pago ent. fact (texto)-CI', Comment = 'ESM="Plazo de pago (d??as) desde entrega factura (texto) - Carga Inicial"';
        }
        field(66; "Plz. Corte No pago fact.(D??as)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plz. Corte No pago fact.(D??as)', Comment = 'ESM="Plazo de Corte por no pago factura (D??as)"';
        }
        field(67; "Plz.Peri. NoPagos prev. Resol."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plz.Peri. NoPagos prev. Resol.', Comment = 'ESM="Plazo de periodos no pagados antes de resoluci??n"';
        }
        field(68; "Plz. Incumpli. Gen. Resol. (D)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plz. Incumpli. Gen. Resol. (D)', Comment = 'ESM="Plazo Incumpli. generadora para resoluci??n (D??as)"';
        }
        field(69; "Margen real (US$/MWh)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Margen real (US$/MWh)', Comment = 'ESM="Margen real (US$/MWh)"';
        }
        field(70; "Contrato Atria S"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contrato Atria S', Comment = 'ESM="Contrato Atria"';
        }
        field(71; "Suministro"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Suministro', Comment = 'ESM="Suministro"';
        }
        field(72; "Nombre suministro"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nombre suministro', Comment = 'ESM="Nombre suministro"';
        }
        field(73; "Direcci??n concatenada"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Direcci??n concatenada', Comment = 'ESM="Direcci??n concatenada"';
        }
        field(74; "Distribuidora S"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Distribuidora S', Comment = 'ESM="Distribuidora"';
        }
        field(75; "Punto suministro"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Punto suministro', Comment = 'ESM="Punto suministro"';
        }
        field(76; "Barra de Referencia"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Barra de Referencia', Comment = 'ESM="Barra de Referencia"';
        }
        field(77; "Propietario S"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Propietario S', Comment = 'ESM="Propietario"';
        }
        field(78; "Moneda S"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Moneda S', Comment = 'ESM="Moneda"';
        }
        field(79; "Fecha de inicio (contrato)"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de inicio (contrato)', Comment = 'ESM="Fecha de inicio (contrato)"';
        }
        field(80; "Fecha de fin (contrato)"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de fin (contrato)', Comment = 'ESM="Fecha de fin (contrato)"';
        }
        field(81; "Fecha de migraci??n"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de migraci??n', Comment = 'ESM="Fecha de migraci??n"';
        }
        field(82; "Exceso potencia (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Exceso potencia (%)', Comment = 'ESM="Exceso potencia (%)"';
        }
        field(83; "Exceso energ??a (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Exceso energ??a (%)', Comment = 'ESM="Exceso energ??a (%)"';
        }
        field(84; "Potencia M??n. Facturable kW(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Potencia M??n. Facturable kW(%)', Comment = 'ESM="Potencia M??n. Facturable kW (%)"';
        }
        field(85; "Potencia Min. Fact. kW (Monto)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Potencia Min. Fact. kW (Monto)', Comment = 'ESM="Potencia Min. Facturable kW (Monto)"';
        }
        field(86; "Potencia Estacional"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Potencia Estacional', Comment = 'ESM="Potencia Estacional"';
        }
        field(87; "Precio Escalonado"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Precio Escalonado', Comment = 'ESM="Precio Escalonado"';
        }
        field(88; "Fecha de carta pre aviso"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de carta pre aviso', Comment = 'ESM="Fecha de carta pre aviso"';
        }
        field(89; "Fecha de carta distribuidora"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de carta distribuidora', Comment = 'ESM="Fecha de carta distribuidora"';
        }
        field(90; "CorrelativoCarta distribuidora"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'CorrelativoCarta distribuidora', Comment = 'ESM="Correlativo carta distribuidora"';
        }
        field(91; "Max. PC - HP (kW)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max. PC - HP (kW)', Comment = 'ESM="Max. PC - HP (kW)"';
        }
        field(92; "Max. PC - HFP (kW)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max. PC - HFP (kW)', Comment = 'ESM="Max. PC - HFP (kW)"';
        }
        field(93; "Mes"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Mes', Comment = 'ESM="Mes"';
        }
        field(94; "Potencia Contratada HP (kW)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Potencia Contratada HP (kW)', Comment = 'ESM="Potencia Contratada HP (kW)"';
        }
        field(95; "Potencia Contratada HFP (kW)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Potencia Contratada HFP (kW)', Comment = 'ESM="Potencia Contratada HFP (kW)"';
        }
        field(96; "Fecha de inicio P"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de inicio P', Comment = 'ESM="Fecha de inicio"';
        }
        field(97; "Fecha de fin P"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de fin P', Comment = 'ESM="Fecha de fin"';
        }
        field(98; "Moneda Precio energia HP y HFP"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Moneda Precio energia HP y HFP', Comment = 'ESM="Moneda Precio energia HP y HFP"';
        }
        field(99; "Tipo de cambio"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tipo de cambio', Comment = 'ESM="Tipo de cambio"';
        }
        field(100; "Precio energ??a HP/HFP(US$/MWh)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Precio energ??a HP/HFP(US$/MWh)', Comment = 'ESM="Precio energ??a HP y HFP (US$/MWh)"';
        }
        field(101; "Prec energ??a HP/HFP(O-Mon/kWh)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Prec energ??a HP/HFP(O-Mon/kWh)', Comment = 'ESM="Precio energ??a HP y HFP (OtrasMon/kWh)"';
        }
        field(102; "Contrato Atria"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contrato Atria', Comment = 'ESM="Contrato Atria"';
        }
        field(103; "Moneda"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Moneda', Comment = 'ESM="Moneda"';
        }
        field(104; "Propietario"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Propietario', Comment = 'ESM="Propietario"';
        }
        field(105; "Energ??a HP Index"; Option)
        {
            Caption = 'Energ??a HP Index', Comment = 'ESM="Energ??a HP Index"';
            OptionMembers = PPI,"PGN_US$",PGN_PEN,PBARRA;
        }
        field(106; "Valor Index Energ??a HP - PP"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Valor Index Energ??a HP - PP', Comment = 'ESM="Valor Index Energ??a HP - PP"';
        }
        field(107; "Mes Vigencia"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Mes Vigencia', Comment = 'ESM="Mes Vigencia"';
        }
        field(108; "A??o vigencia"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'A??o vigencia', Comment = 'ESM="A??o vigencia"';
        }
        field(109; "Energ??a HFP Index"; Option)
        {
            Caption = 'Energ??a HFP Index', Comment = 'ESM="Energ??a HFP Index"';
            OptionMembers = PPI,"PGN_US$",PGN_PEN,PBARRA;
        }
        field(110; "Valor Index Energ??a HFP - PP"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Valor Index Energ??a HFP - PP', Comment = 'ESM="Valor Index Energ??a HFP - PP"';
        }
        field(111; "Potencia Index"; Option)
        {
            Caption = 'Potencia Index', Comment = 'ESM="Potencia Index"';
            OptionMembers = PPI,"PGN_US$",PGN_PEN,PBARRA;
        }
        field(112; "Valor Index Potencia - PP"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Valor Index Potencia - PP', Comment = 'ESM="Valor Index Potencia - PP"';
        }
        field(113; "Importe financiamiento G"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Importe financiamiento G', Comment = 'ESM="Importe financiamiento"';
        }
        field(114; "Importe financiamiento LetrasG"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Importe financiamiento LetrasG', Comment = 'ESM="Importe financiamiento en letras"';
        }
        field(115; "Concepto del pr??stamo G"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Concepto del pr??stamo G', Comment = 'ESM="Concepto del pr??stamo"';
            OptionMembers = "Fines corporativos",Financiamiento,SAVA,"Libre disponibilidad";
        }
        field(116; "Contrato relacionado PPA CR"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contrato relacionado PPA CR', Comment = 'ESM="Contrato relacionado PPA"';
        }
        field(117; "Fecha inicio contrato rel. CR"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha inicio contrato rel. CR', Comment = 'ESM="Fecha de inicio contrato relacionado"';
        }
        field(118; "Fecha de fin contrato rel. CR"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de fin contrato rel. CR', Comment = 'ESM="Fecha de fin contrato relacionado"';
        }
        field(119; "Banco del cliente DBC 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Banco del cliente DBC 1', Comment = 'ESM="Banco del cliente"';
        }
        field(120; "Tipo cuenta bancaria DBC 1"; Option)
        {
            Caption = 'Tipo cuenta bancaria DBC 1', Comment = 'ESM="Tipo cuenta bancaria"';
            OptionMembers = "Cuenta Corriente",Soles,"D??lares";
        }
        field(121; "Nro. cuenta banc.cliente DBC 1"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. cuenta banc.cliente DBC 1', Comment = 'ESM="Nro. cuenta bancaria cliente"';
        }
        field(122; "CCI DBC 1"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'CCI DBC 1', Comment = 'ESM="CCI"';
        }
        field(123; "Nro. cuenta detracci??n DBC 1"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. cuenta detracci??n DBC 1', Comment = 'ESM="Nro. cuenta detracci??n"';
        }
        field(124; "Fecha de inicio"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de inicio', Comment = 'ESM="Fecha de inicio"';
        }
        field(125; "Fecha de fin"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de fin', Comment = 'ESM="Fecha de fin"';
        }
        field(126; "Energ??a m??nima esperada MWh"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Energ??a m??nima esperada MWh', Comment = 'ESM="Energ??a m??nima esperada MWh"';
        }
        field(127; "Fecha Inicio Repago DLL"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha Inicio Repago DLL', Comment = 'ESM="Fecha Inicio Repago DLL"';
        }
        field(128; "Consumo m??nimo anual (MWh)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Consumo m??nimo anual (MWh)', Comment = 'ESM="Consumo m??nimo anual (MWh)"';
        }
        field(129; "potencia contratada anual(MWh)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'potencia contratada anual(MWh)', Comment = 'ESM="potencia contratada anual (MWh)"';
        }
        field(130; "Fecha An??lisis cons. energ??a"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha An??lisis cons. energ??a', Comment = 'ESM="Fecha de an??lisis consumo energ??a"';
        }
        field(131; "Fec.Ini.??lt. peri. energ??a m??n"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fec.Ini.??lt. peri. energ??a m??n', Comment = 'ESM="Fecha de inicio ??ltimo periodo de energ??a m??nima"';
        }
        field(132; "Fec.fin.??lt.peri. energ??a m??n."; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fec.fin.??lt.peri. energ??a m??n.', Comment = 'ESM="Fecha de fin ??ltimo periodo de energ??a m??nima"';
        }
        field(133; "Ejec. negocios financieros 1"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejec. negocios financieros 1', Comment = 'ESM="Ejecutivo negocios financieros"';
        }
        field(134; "Cons.Total Energ??a espe. (MWh)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cons.Total Energ??a espe. (MWh)', Comment = 'ESM="Consumo total Energ??a esperada (MWh)"';
        }
        field(135; "M??x. energ??a m??n. espe. (MWh)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'M??x. energ??a m??n. espe. (MWh)', Comment = 'ESM="M??xima energ??a m??nima esperada (MWh)"';
        }
        field(136; "Cons.Ene.m??n. ??lt. Peri. (MWh)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cons.Ene.m??n. ??lt. Peri. (MWh)', Comment = 'ESM="Consumo energ??a m??nima ??ltimo periodo (MWh)"';
        }
        field(137; "Ejec. negocios financieros 2"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejec. negocios financieros 2', Comment = 'ESM="Ejecutivo negocios financieros"';
        }
        field(138; "Precio energ??a(US$/MWh) Letras"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Precio energ??a(US$/MWh) Letras', Comment = 'ESM="Precio energ??a (US$/MWh) en letras"';
        }
        field(139; "Ejec. negocios financieros 3"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejec. negocios financieros 3', Comment = 'ESM="Ejecutivo negocios financieros"';
        }
        field(140; "Importe financiamiento"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Importe financiamiento', Comment = 'ESM="Importe financiamiento"';
        }
        field(141; "Importe financiamiento letras"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Importe financiamiento letras', Comment = 'ESM="Importe financiamiento en letras"';
        }
        field(142; "Concepto del pr??stamo G2"; Option)
        {
            Caption = 'Concepto del pr??stamo G2', Comment = 'ESM="Concepto del pr??stamo G2"';
            OptionMembers = "Fines corporativos",Financiamiento,SAVA,"Libre disponibilidad";
        }
        field(143; "Contrato relacionado PPA"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contrato relacionado PPA', Comment = 'ESM="Contrato relacionado PPA"';
        }
        field(144; "Fecha de inicio contrato rel."; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de inicio contrato rel.', Comment = 'ESM="Fecha de inicio contrato relacionado"';
        }
        field(145; "Fecha de fin contrato rel."; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de fin contrato rel.', Comment = 'ESM="Fecha de fin contrato relacionado"';
        }
        field(146; "Banco del cliente DBC 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Banco del cliente DBC 2', Comment = 'ESM="Banco del cliente"';
        }
        field(147; "Tipo cuenta bancaria DBC 2"; Option)
        {
            Caption = 'Tipo cuenta bancaria DBC 2', Comment = 'ESM="Tipo cuenta bancaria"';
            OptionMembers = "Cuenta Corriente",Soles,"D??lares";
        }
        field(148; "Nro. cuenta banc.cliente DBC 2"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. cuenta banc.cliente DBC 2', Comment = 'ESM="Nro. cuenta bancaria cliente"';
        }
        field(149; "CCI DBC 2"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'CCI DBC 2', Comment = 'ESM="CCI"';
        }
        field(150; "Nro. cuenta detracci??n DBC 2"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. cuenta detracci??n DBC 2', Comment = 'ESM="Nro. cuenta detracci??n"';
        }
        field(151; "Monto Cuota"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Monto Cuota', Comment = 'ESM="Monto Cuota"';
        }
        field(152; "Monto Cuota en letras"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Monto Cuota en letras', Comment = 'ESM="Monto Cuota en letras"';
        }
        field(153; "N??mero cuotas financiamiento"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'N??mero cuotas financiamiento', Comment = 'ESM="N??mero de cuotas financiamiento"';
        }
        field(154; "N??mero cuotas finan. (letras)"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'N??mero cuotas finan. (letras)', Comment = 'ESM="N??mero de cuotas financiamiento (letras)"';
        }
        field(155; "Tasa  anual (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tasa  anual (%)', Comment = 'ESM="Tasa  anual (%)"';
        }
        field(156; "Tasa nominal anual (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tasa nominal anual (%)', Comment = 'ESM="Tasa nominal anual (%)"';
        }
        field(157; "Tasa efectiva anual (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tasa efectiva anual (%)', Comment = 'ESM="Tasa efectiva anual (%)"';
        }
        field(158; "Tasa efectiva anual en letras"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tasa efectiva anual en letras', Comment = 'ESM="Tasa efectiva anual en letras"';
        }
        field(159; "Tasa moratoria (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tasa moratoria (%)', Comment = 'ESM="Tasa moratoria (%)"';
        }
        field(160; "Fecha deuda distribuidora"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha deuda distribuidora', Comment = 'ESM="Fecha deuda distribuidora"';
        }
        field(161; "Distribuidora G"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Distribuidora G', Comment = 'ESM="Distribuidora"';
        }
        field(162; "Fecha de emisi??n pagare"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de emisi??n pagare', Comment = 'ESM="Fecha de emisi??n pagare"';
        }
        field(163; "D??a de pago"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'D??a de pago', Comment = 'ESM="D??a de pago"';
        }
        field(164; "Fecha primera cuota de pago"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha primera cuota de pago', Comment = 'ESM="Fecha primera cuota de pago"';
        }
        field(165; "Fecha ??ltima cuota de pago"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha ??ltima cuota de pago', Comment = 'ESM="Fecha ??ltima cuota de pago"';
        }
        field(166; "Ejec. negocios financieros G"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ejec. negocios financieros G', Comment = 'ESM="Ejecutivo negocios financieros"';
        }
        field(167; "Nro. de cuota"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Nro. de cuota', Comment = 'ESM="Nro. de cuota"';
        }
        field(168; "Saldo"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Saldo', Comment = 'ESM="Saldo"';
        }
        field(169; "Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Capital', Comment = 'ESM="Capital"';
        }
        field(170; "Intereses"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Intereses', Comment = 'ESM="Intereses"';
        }
        field(171; "Cuota"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cuota', Comment = 'ESM="Cuota"';
        }
        field(172; "D??as"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'D??as', Comment = 'ESM="D??as"';
        }
        field(173; "Fecha de pago"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fecha de pago', Comment = 'ESM="Fecha de pago"';
        }
        field(174; "IGV Intereses"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'IGV Intereses', Comment = 'ESM="IGV Intereses"';
        }
        field(175; "Cuota con IGV"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cuota con IGV', Comment = 'ESM="Cuota con IGV"';
        }


    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}