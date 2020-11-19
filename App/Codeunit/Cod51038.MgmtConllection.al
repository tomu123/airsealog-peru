codeunit 51038 "Mgmt Collection"
{
    trigger OnRun()
    begin

    end;

    var
        TempFileBlob: Codeunit "Temp Blob";
        ConstrutOutStream: OutStream;
        CompanyInformation: Record "Company Information";
        gTotalRecords: Integer;
        gTotalAmount: Decimal;
        CollectionPaymentBuffer: Record "Collection Payment Buffer" temporary;
        BankAccNoSBP: Text;
        SecuenceSBP: Text;

    procedure FindStructureCust(pCustNo: Code[20]) rBankAccountNo: Code[10]
    var
        Customer: Record Customer;
        CustomerBankAccount: Record "Customer Bank Account";
    begin
        rBankAccountNo := '';
        if Customer.get(pCustNo) then
            if CustomerBankAccount.Get(pCustNo, Customer."Preferred Bank Account Code") then
                rBankAccountNo := CustomerBankAccount."Reference Bank Acc. No.";
        exit(rBankAccountNo);
    end;

    procedure SetTotal(var pTotalRecords: Integer;
                        var pTotalAmount: Decimal)
    var
    begin
        gTotalAmount := pTotalAmount;
        gTotalRecords := pTotalRecords;
    end;

    procedure GenerateFilePaymentCollection(var ControlFile: Record "ST Control File";
                                            var pRecCollectionBuffer: Record "Collection Payment Buffer" temporary;
                                            pCollectionBank: Text;
                                            pBankNo: code[20])
    var
        lclNumberRecords: Integer;
        lclCampos: Text;
        IsExistsFile: Boolean;
        lclTotalRecord: Integer;
        lclRow: Integer;
        lclFecha: Date;
        lclFileName: Text;
        pProcessDate: Date;
        i: Integer;
        pTRecord: Text;
        TFileRecord: text;
        pCurrencyCode: Text;

    begin
        if NOT CONFIRM('Desea generar txt, cobranzas - recaudación', true) then
            exit;

        CompanyInformation.get;
        lclCampos := '';
        lclRow := 0;

        CreateTempFile();
        pRecCollectionBuffer.Reset();
        if pRecCollectionBuffer.FindFirst() then begin
            lclTotalRecord := pRecCollectionBuffer.Count;
            repeat
                lclCampos := '';
                pTRecord := pRecCollectionBuffer."Post Type";
                TFileRecord := pRecCollectionBuffer."Post File";

                pRecCollectionBuffer.CalcFields("Remaining Amount", "Remaining Amt. (LCY)");
                pCurrencyCode := pRecCollectionBuffer."Currency Code";
                IsExistsFile := true;
                lclRow += 1;
                case pCollectionBank of
                    'BCP':
                        begin
                            //Make Header
                            lclCampos := '';
                            if lclRow = 1 then begin
                                lclCampos := BCPHeaderStructure(pBankNo, Today, gTotalRecords, gTotalAmount, TFileRecord);
                                InsertLineToTempFile(lclCampos);
                            end;
                            // Make Detail
                            IF lclRow >= 1 THEN begin
                                lclCampos := BCPLineStructure(pRecCollectionBuffer, pBankNo, pTRecord);
                                InsertLineToTempFile(lclCampos);
                            end;
                        end;
                    'BBVA':
                        begin
                            lclCampos := '';
                            //Make Header
                            if lclRow = 1 then begin
                                lclCampos := BBVAHeaderStructure(pBankNo, pCurrencyCode, '000', pTRecord);
                                InsertLineToTempFile(lclCampos);
                            end;
                            // Make Detail
                            IF lclRow >= 1 then begin
                                lclCampos := BBVALineStructure(pRecCollectionBuffer);
                                InsertLineToTempFile(lclCampos);
                            end;
                            // Make LastRow
                            IF lclRow = gTotalRecords then begin
                                lclCampos := BBVATotalStructure(gTotalRecords, gTotalAmount);
                                InsertLineToTempFile(lclCampos);
                            end;
                        end;
                    'SCOTIA':
                        begin
                            lclCampos := '';
                            //Post H
                            if lclRow = 1 then begin
                                pProcessDate := Today;
                                lclCampos := SCOTIAHeaderStructure(pProcessDate, pBankNo, pCurrencyCode, gTotalRecords, gTotalAmount);
                                InsertLineToTempFile(lclCampos);
                            end;
                            // Post D
                            IF lclRow >= 1 THEN begin
                                lclCampos := SCOTIALineStructure(pRecCollectionBuffer, pBankNo, pCurrencyCode, pTRecord);
                                InsertLineToTempFile(lclCampos);
                            end;
                            //Post C
                            IF lclRow = gTotalRecords then begin
                                lclCampos := SCOTIATotalStructure(pBankNo, pCurrencyCode);
                                InsertLineToTempFile(lclCampos);
                            end;
                        end;
                    'INTERBANK':
                        begin
                            lclCampos := '';
                            //Post Header
                            if lclRow = 1 then begin
                                lclCampos := INTERBANKHeaderStructure(Today, pCurrencyCode, gTotalRecords, gTotalAmount, TFileRecord);
                                InsertLineToTempFile(lclCampos);
                            end;
                            // Post Quota/Detail
                            IF lclRow >= 1 THEN begin
                                lclCampos := INTERBANKQuotaPostStructure();
                                InsertLineToTempFile(lclCampos);

                                lclCampos := INTERBANKLinesStructure(pRecCollectionBuffer, pCurrencyCode, pTRecord);
                                InsertLineToTempFile(lclCampos);
                            end;
                        end;
                end;
            until pRecCollectionBuffer.Next = 0;

            pRecCollectionBuffer.Reset();

            if IsExistsFile then begin
                case pCollectionBank of
                    'BCP':
                        begin
                            lclFileName := 'CREP' + Format(Today);
                        end;
                    'BBVA':
                        begin
                            lclFileName := 'BBVA' + Format(Today);
                        end;
                    'SCOTIA':
                        begin
                            lclFileName := 'SCOTIA' + Format(Today);
                        end;
                    'INTERBANK':
                        begin
                            lclFileName := 'IBK' + Format(Today);
                        end;
                end;
                PostFileToControlFileRecord(lclFileName);
                lclCampos := '';
            end;
        end;
    end;

    procedure FindFillCollection(pBankCollection: Text;
                                pBankNo: code[20];
                                pCurrencyCode: Code[10];
                                pTFileCode: Text; pTRecord: Text;
                                pDateFrom: Date;
                                pDateTo: Date;
                                pSerieDoc: Text)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SetRange(CustLedgerEntry."Currency Code", pCurrencyCode);

        if (pDateFrom <> 0D) and (pDateTo <> 0D) then
            CustLedgerEntry.SetFilter("Date Filter", '%1..%2', pDateFrom, pDateTo);

        if pSerieDoc <> '' then
            CustLedgerEntry.SetFilter("Document No.", '%1', pSerieDoc + '*');

        CustLedgerEntry.SetFilter("Remaining Amount", '<>%1', 0);
        if CustLedgerEntry.FindFirst then
            repeat
                if IsCustomerBankAcc(CustLedgerEntry."Customer No.", pBankNo, pCurrencyCode) then
                    FillCollectionBuffer(CustLedgerEntry, pBankCollection, pBankNo, pTFileCode, pTRecord);
            until CustLedgerEntry.Next = 0;
    end;

    procedure FillCollectionBuffer(var pCustLedgerEntry: Record "Cust. Ledger Entry";
                                            pBankCollection: text;
                                            pBankNo: code[20];
                                            pTFileCode: text;
                                            pTRecord: Text)
    var
        STControlFile: Record "ST Control File";
    begin
        gTotalAmount := 0;
        gTotalRecords := 0;

        CollectionPaymentBuffer.Reset();
        CollectionPaymentBuffer.DeleteAll();

        pCustLedgerEntry.FindSet();
        repeat
            pCustLedgerEntry.CalcFields("Remaining Amount", "Remaining Amt. (LCY)");
            CollectionPaymentBuffer.Init();
            CollectionPaymentBuffer.TransferFields(pCustLedgerEntry, true);
            CollectionPaymentBuffer."Post File" := pTFileCode;
            CollectionPaymentBuffer."Post Type" := pTRecord;
            CollectionPaymentBuffer."Collection Bank" := pBankCollection;
            CollectionPaymentBuffer."Bank Account No." := pBankNo;
            CollectionPaymentBuffer.Insert();

            gTotalRecords += 1;
            if pCustLedgerEntry."Currency Code" = '' then
                gTotalAmount += pCustLedgerEntry."Remaining Amt. (LCY)"
            else
                gTotalAmount += pCustLedgerEntry."Remaining Amount";

        until pCustLedgerEntry.Next() = 0;

        GenerateFilePaymentCollection(STControlFile, CollectionPaymentBuffer, pBankCollection, pBankNo);
        CollectionPaymentBuffer.Reset();
    end;

    procedure MasterDataLookup(pCollectionBank: Text) rText: Text
    var
        MasterData: Record "Master Data";
        PageMasterData: Page "MasterData Lookup";
    begin
        MasterData.Reset();
        MasterData.SetRange("Type Table", pCollectionBank);
        if MasterData.FindSet() then begin
            PageMasterData.SetTableView(MasterData);
            PageMasterData.LookupMode(true);
            if PageMasterData.RunModal() = Action::LookupOK then begin
                PageMasterData.GetRecord(MasterData);
                if MasterData.Find then begin
                    rText := MasterData.Description;
                end;
            end;
            exit(rText);
        end;
    end;

    procedure ValidateRecordType(var TFileCode: Text; var TRecordCode: Text) rValue: Boolean
    var
    begin
        case TFileCode of
            'A':
                if TRecordCode = ' ' then begin
                    Message('Opcion No Aplica, valida solo pata tipo archivo: Remplazo.');
                    rValue := true;
                end;
            'R':
                if TRecordCode <> ' ' then begin
                    Message('Opcion no valida, solo se permite No Aplica');
                    rValue := true;
                end;
        end;
        exit(rValue);
    end;

    local procedure GetDate(pDate: Date): Text
    var
        TxtDay: Text;
        TxtMonth: Text;
        TxtYear: Text;
    begin
        TxtDay := FORMAT(DATE2DMY(pDate, 1));
        TxtMonth := FORMAT(DATE2DMY(pDate, 2));
        TxtYear := FORMAT(DATE2DMY(pDate, 3));
        IF STRLEN(TxtDay) = 1 THEN
            TxtDay := '0' + TxtDay;
        IF STRLEN(TxtMonth) = 1 THEN
            TxtMonth := '0' + TxtMonth;
        EXIT(TxtYear + TxtMonth + TxtDay);
    end;

    local procedure CreateTempFile()
    begin
        TempFileBlob.CreateOutStream(ConstrutOutStream, TextEncoding::UTF8);
    end;

    local procedure InsertLineToTempFile(LineText: Text[1024])
    begin
        ConstrutOutStream.WriteText(LineText);
        ConstrutOutStream.WriteText;
    end;

    local procedure IsCustomerBankAcc(pCustNo: code[20]; pBankNo: code[20]; pCurrencyCode: Text) rValue: Boolean
    var
        Customer: Record Customer;
        CustomerBankAccount: Record "Customer Bank Account";

    begin
        rValue := false;
        if Customer.get(pCustNo) then begin
            if (Customer."Preferred Bank Account Code" <> '') or (Customer."Preferred Bank Account Code ME" <> '') then
                case pCurrencyCode of
                    '':
                        begin
                            if CustomerBankAccount.get(pCustNo, Customer."Preferred Bank Account Code") then begin
                                if CustomerBankAccount."Reference Bank Acc. No." <> '' then
                                    rvalue := CustomerBankAccount."Reference Bank Acc. No." = pBankNo;
                            end;
                        end;
                    'USD':
                        begin
                            if CustomerBankAccount.get(pCustNo, Customer."Preferred Bank Account Code ME") then begin
                                if CustomerBankAccount."Reference Bank Acc. No." <> '' then
                                    rvalue := CustomerBankAccount."Reference Bank Acc. No." = pBankNo;
                            end;
                        end;
                end;
        end;
        exit(rValue)
    end;

    procedure PostFileToControlFileRecord(pFileName: Text)
    var
        CompInf: Record "Company Information";
        ControlFile: Record "ST Control File";
        UpdateControlFile: Record "ST Control File";
        NewFileInStream: InStream;
        FileName: Text;
        FileExt: Text;
        EntryNo: Integer;
        ConfirmDownload: Label 'Do you want to download the following file?', Comment = 'ESM="¿Quieres descargar el siguiente archivo?"';
    begin
        CompInf.Get();
        TempFileBlob.CreateInStream(NewFileInStream);
        FileExt := 'txt';
        EntryNo := ControlFile.CreateControlFileRecord('01', pFileName, FileExt, Today, Today, NewFileInStream);
        if EntryNo <> 0 then begin
            UpdateControlFile.Get(EntryNo);
            UpdateControlFile."Entry Type" := UpdateControlFile."Entry Type"::"Recaudación";
            UpdateControlFile.Modify();
            if Confirm(ConfirmDownload, false) then begin
                ControlFile.Get(EntryNo);
                ControlFile.DownLoadFile(ControlFile);
            end;
        end;
    end;

    local procedure BCPHeaderStructure(pBankNo: code[20]; pDate: date; pTotalRecords: Integer; pTotalAMountDoc: Decimal; pFileType: Text) rTxtHeaderBCP: Text
    var
        lclTemp: Text;
        lclAmountTxt: Text;
        BankAccount: Record "Bank Account";
    begin
        // CC 193 0 1596661 C ATRIA ENERGIA S.A.C                     20200609000000630000001842952113A
        // 1 – 2  	2 	Alfabético	Tipo de registro (CC = Cabecera) 
        rTxtHeaderBCP := 'CC';
        // 3 – 5  	3 	Numérico	Código de la Sucursal(de la Cta.de la Empresa Afiliada) 
        // 6 – 6  	1 	Numérico	Código de la moneda (de la Cta. De la Empresa Afiliada)  ( 0=soles, 1= Dólares)
        // 7 – 13  	7 	Numérico	Número de cuenta de la Empresa Afiliada 
        if BankAccount.GET(pBankNo) then begin
            rTxtHeaderBCP += COPYSTR(BankAccount."Bank Account No.", 1, 3);
            rTxtHeaderBCP += COPYSTR(BankAccount."Bank Account No.", 11, 1);
            rTxtHeaderBCP += COPYSTR(BankAccount."Bank Account No.", 4, 7);
        end;
        // 14 – 14 	1 	Alfabético	Tipo de validación (C = Completa) 
        rTxtHeaderBCP += 'C';

        // 15 – 54 	40 	Alfanumérico	Nombre de la Empresa Afiliada 
        lclTemp := CompanyInformation.Name + PADSTR('', 40 - STRLEN(CompanyInformation.Name), ' ');
        rTxtHeaderBCP += lclTemp;

        // 55 – 62 	8 	Numérico	Fecha de transmisión (AAAAMMDD) 
        rTxtHeaderBCP += GetDate(pDate);

        // 63 – 71  9 	Numérico	Cantidad total de registros enviados (en el detalle)
        lclTemp := PADSTR('', 9 - STRLEN(FORMAT(pTotalRecords)), '0') + FORMAT(pTotalRecords);
        rTxtHeaderBCP += lclTemp;

        // 72 – 86  	15 	Numérico	Monto total enviado (2 decimales)
        lclAmountTxt := DelChr(FORMAT(pTotalAMountDoc, 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
        lclTemp := PADSTR('', 15 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtHeaderBCP += lclTemp;

        // 87 – 87	1	Alfanumérico	Tipo de Archivo (“ ” o R = Archivo de Reemplazo, A = Archivo de Actualización)
        rTxtHeaderBCP += pFileType;

        // 88 – 93	6	Alfanumérico	Código Servicio (solo empresas que trabajan con servicios) 
        rTxtHeaderBCP += PADSTR('', 6, ' ');

        // 94 – 250  	157 		Filler (Libre) 
        rTxtHeaderBCP += PADSTR('', 157, ' ');
    end;

    local procedure BCPLineStructure(var pRecCollectionBuffer: Record "Collection Payment Buffer" temporary; pBankNo: code[20]; pTRecord: text) rTxtLineBCP: Text
    var
        lclTemp: Text;
        lclNumDocPago: Text;
        lclAmountTxt: Text;
        BankAccount: Record "Bank Account";
        lclSuministroNo: Text;
        lclDocNoNumber: Integer;
        lclDocType: Text;
    begin
        // DD1930159666100000000013079ZYL AGRO E I R L                        01-F001-0010246               2020040820200418000000020090498000000000000000000000000A       01F0010010246    C20480853424
        // 1 – 2  	2 	Alfabético	Tipo de registro (DD = Detalle) 
        rTxtLineBCP := 'DD';

        // 3 – 5  	3 	Numérico	Código de la Sucursal(de la Cta.de la Empresa Afiliada) 
        // 6 – 6  	1 	Numérico	Código de la moneda (de la Cta.de la Empresa Afiliada) 
        // 7 – 13 	7 	Numérico	Número de cuenta de la Empresa Afiliada 
        if BankAccount.GET(pBankNo) then begin
            rTxtLineBCP += COPYSTR(BankAccount."Bank Account No.", 1, 3);
            rTxtLineBCP += COPYSTR(BankAccount."Bank Account No.", 11, 1);
            rTxtLineBCP += COPYSTR(BankAccount."Bank Account No.", 4, 7);
        end;

        // 14 – 27 	14 	Alfanumérico	Código de identificación del Depositante 
        lclSuministroNo := pRecCollectionBuffer."No. Suministro";
        // lclSuministroNo := PADSTR('', 14, '0');

        lclTemp := PADSTR('', 14 - STRLEN(lclSuministroNo), '0') + lclSuministroNo;
        rTxtLineBCP += lclTemp;

        // 28 – 67 	40 	Alfanumérico	Nombre del Depositante 
        lclTemp := pRecCollectionBuffer."Customer Name" + PADSTR('', 40 - STRLEN(pRecCollectionBuffer."Customer Name"), ' ');
        rTxtLineBCP += lclTemp;

        // 68 – 97 	30 	Alfanumérico	Campo con información de retorno 
        if pRecCollectionBuffer."Legal Document" <> '' then
            lclNumDocPago := pRecCollectionBuffer."Legal Document" + '-' + pRecCollectionBuffer."Document No."
        else
            lclNumDocPago := '00-' + pRecCollectionBuffer."Document No.";

        lclTemp := lclNumDocPago + PADSTR('', 30 - STRLEN(lclNumDocPago), ' ');
        rTxtLineBCP += lclTemp;

        // 98 – 105 	8	Numérico	Fecha de emisión del cupón 
        rTxtLineBCP += GetDate(pRecCollectionBuffer."Document Date");

        // 106 – 113	8	Numérico	Fecha de vencimiento del cupón 
        rTxtLineBCP += GetDate(pRecCollectionBuffer."Due Date");

        // 114 – 128	15	Numérico	Monto del cupón (2 decimales)
        if pRecCollectionBuffer."Currency Code" = 'USD' then
            lclAmountTxt := DelChr(FORMAT(pRecCollectionBuffer."Remaining Amount", 0, '<Precision,2:2><Standard Format,0>'), '=', ',.')
        else
            lclAmountTxt := DelChr(FORMAT(pRecCollectionBuffer."Remaining Amt. (LCY)", 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');

        lclTemp := PADSTR('', 15 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineBCP += lclTemp;

        // 129 – 143	15	Numérico	Monto del mora (2 decimales)
        rTxtLineBCP += PADSTR('', 15, '0');

        // 144 – 152	9	Numérico	Monto mínimo (2 decimales) 
        rTxtLineBCP += PADSTR('', 9, '0');

        // 153	1	Alfabético	Tipo de registro de actualización (A = Registro a Agregar, M = Registro a Modificar, E = Registro a Eliminar)
        rTxtLineBCP += pTRecord;

        // 154 – 173 	20	Alfanumérico	Nro. Documento de Pago
        if pRecCollectionBuffer."Legal Document" <> '' then
            lclDocType := pRecCollectionBuffer."Legal Document"
        else
            lclDocType := '00';

        lclNumDocPago := lclDocType + delchr(pRecCollectionBuffer."Document No.", '=', '-');
        lclTemp := PADSTR('', 20 - STRLEN(lclNumDocPago), ' ') + lclNumDocPago;
        rTxtLineBCP += lclTemp;

        // Alinear a la derecha
        // Si es numérico, completar con ceros a la izquierda.
        // Si es alfanumérico, completar con espacios a la izquierda.
        // 174 – 189 	16	Alfanumérico	Nro. Documento de Identidad
        if Evaluate(lclDocNoNumber, pRecCollectionBuffer."Customer No.") then
            lclTemp := PADSTR('', 16 - STRLEN(pRecCollectionBuffer."Customer No."), ' ') + pRecCollectionBuffer."Customer No."
        else
            lclTemp := PADSTR('', 16 - STRLEN(pRecCollectionBuffer."Customer No."), '0') + pRecCollectionBuffer."Customer No.";

        rTxtLineBCP += lclTemp;
        // Alinear a la derecha
        // Si es numérico, completar con ceros a la izquierda.
        // Si es alfanumérico, completar con espacios a la izquierda.
        // 190 – 250  	61		Filler (Libre) 
        rTxtLineBCP += PADSTR('', 61, ' ');
    end;

    local procedure BBVAHeaderStructure(pBankNo: code[20]; pCurrencyCode: code[10]; pClase: Text; pFileType: Text) rTxtHeaderBBVA: Text
    var
        BankAccount: Record "Bank Account";
        STControlFile: Record "ST Control File";
        CurrencyCode: Text;
        FileName: Text;
        Correlativo: Text;
    begin
        // 1	Tipo de Registro	Núm.	1	2	2	OBL	Indicador de cabecera 01 (*)	01
        rTxtHeaderBBVA := '01';

        // 2	Ruc de la Empresa	Alfnúm.	3	13	11	OBL	Nro. de Ruc indicado en la ficha técnica	20501860329
        rTxtHeaderBBVA += CompanyInformation."VAT Registration No.";

        // 3	Número de clase	Núm.	14	16	3	OBL	Número proporcionado por el banco	123
        rTxtHeaderBBVA += pClase;

        // 4	Moneda	Alfnúm.	17	19	3	OBL	"PEN: Soles  USD:Dolares"	PEN
        if pCurrencyCode = '' then
            CurrencyCode := 'PEN'
        ELSE
            CurrencyCode := pCurrencyCode;

        rTxtHeaderBBVA += CurrencyCode;

        // 5	Fecha de Facturación	Alfnúm.	20	27	8	OBL	Colocar la fecha actual AAAAMMDD (**)	20190708
        rTxtHeaderBBVA += GetDate(Today);

        // 6	Versión	Núm.	28	30	3	OBL	Inicia en 000 y si se hace mas de una vez el envio seguira el consecutivo (***)	000
        FileName := 'BBVA' + Format(Today);
        STControlFile.Reset();
        STControlFile.SetRange("File Name", FileName);
        if STControlFile.count > 0 then begin
            Correlativo := format(STControlFile.Count);

            if strlen(Correlativo) = 1 then
                Correlativo := '00' + Correlativo;
            if strlen(Correlativo) = 2 then
                Correlativo := '0' + Correlativo;
        end else
            Correlativo := '000';

        rTxtHeaderBBVA += Correlativo;

        // 7	Vacio	Alfnúm.	31	37	7	OBL	Rellenar de Blancos	
        rTxtHeaderBBVA += PADSTR('', 7, ' ');

        // 8	Tipo de Actualización	Alfnúm.	38	38	1	OPC	T: Actualización Total (reemplaza la base de datos existente)  
        //   *Si no utilizan ninguna de las opciones(T, P o E) rellenar con espacio en blanco, el sistema tomara la opción contratada.T
        rTxtHeaderBBVA += pFileType;

        // 9	Vacio	Alfnúm.	39	360	322	OBL	Rellenar con espacios en Blanco	
        rTxtHeaderBBVA += PADSTR('', 322, ' ');

        // 					360	OBL = Obligatorio, OPC= Opcional 		
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    var
        FindPos: Integer;
    begin
        FindPos := STRPOS(String, FindWhat);
        WHILE FindPos > 0 DO BEGIN
            NewString += DELSTR(String, FindPos) + ReplaceWith;
            String := COPYSTR(String, FindPos + STRLEN(FindWhat));
            FindPos := STRPOS(String, FindWhat);
        END;
        NewString += String;
    end;

    local procedure CharConvert(var pText: Text) rText: Text
    var
        i: Integer;
        Long: Integer;
        RepTxt: Text;
        FindText: Text;
    begin
        RepTxt := '';
        Long := StrLen(pText);
        for i := 1 to Long do begin
            FindText := CopyStr(pText, i, Long);
            case FindText of
                'Ä,Á,À,á,à,Ã,ã,â,Â,ä':
                    RepTxt := 'A';
                'Ë,É,È,é,è,ê,Ê,ë':
                    RepTxt := 'E';
                'Ï,Í,Ì,í,ì,î,Î,ï':
                    RepTxt := 'I';
                'Ö,Ó,Ò,ó,ò,Õ,õ,ô,Ô,ö':
                    RepTxt := 'O';
                'Ü,Ú,Ù,ú,ù,û,Û,ü':
                    RepTxt := 'U';
                '±,Ñ,ñ':
                    RepTxt := 'N';
                'ÿ,ý,Ý':
                    RepTxt := 'Y';
                'Ð':
                    RepTxt := 'D';
                '",;,,,+':
                    RepTxt := ' ';
                '!,,#,$,%,/,(,\,¡,¿,´,~,[,},],`,<,>,_,),{,^,:,|,°,¬,=,?,º':
                    RepTxt := ' ';
            end;
        end;

        if RepTxt <> '' then
            ReplaceString(pText, FindText, RepTxt);

        exit(rText);
    end;

    local procedure BBVALineStructure(var pRecCollectionBuffer: Record "Collection Payment Buffer" temporary) rTxtLineBBVA: Text
    var
        DateLock: Text;
        TxtMonth: Text;
        lclTemp: Text;
        lclDoc: text;
        lclAmountTxt: Text;

    begin
        // 1	Tipo de Registro	Núm.	1	2	2	OBL	Indicador de detalle 02 (*)
        rTxtLineBBVA := '02';

        // 2	Nombre del Cliente	Alfnúm.	3	32	30	OBL	Indicar Razon Social o Nombre del Cliente
        lclTemp := pRecCollectionBuffer."Customer Name";
        if strlen(lclTemp) > 30 then
            lclTemp := copystr(lclTemp, 1, 30)
        else
            lclTemp := lclTemp + PadStr(lclTemp, 30 - StrLen(lclTemp), ' ');

        rTxtLineBBVA += lclTemp;

        // 3	Campo de Identificación del Pago	Núm./Alfnúm	33	80	48	OBL	Especificación Según Ficha Tecnica (**)
        // 	Campo de Identificación Adicional						
        // 	Campo Opcional del Pago			
        lclDoc := pRecCollectionBuffer."No. Suministro" +
                pRecCollectionBuffer."Customer No." +
                pRecCollectionBuffer."Legal Document" +
                delchr(pRecCollectionBuffer."Document No.", '=', ' -');
        if strlen(lclDoc) > 48 then
            lclDoc := copystr(lclDoc, 1, 48)
        else
            lclDoc := lclDoc + PadStr('', 48 - StrLen(lclDoc), ' ');

        rTxtLineBBVA += lclDoc;

        // 4	Fecha de Vencimiento	Alfnúm.	81	88	8	OBL	Vencimiento del Pago en AAAAMMDD
        rTxtLineBBVA += GetDate(pRecCollectionBuffer."Due Date");

        // 5	Fecha de Bloqueo	Alfnúm.	89	96	8	OBL	Fecha hasta la cual el banco tendra en sus sistemas dicho registro AAAAMMDD (1)
        rTxtLineBBVA += '20301231';

        // 6	Período del pago Facturado	Núm.	97	98	2	OBL	Período en el que se factura "01" ej Enero (2)
        TxtMonth := FORMAT(DATE2DMY(pRecCollectionBuffer."Document Date", 2));
        IF STRLEN(TxtMonth) = 1 THEN
            TxtMonth := '0' + TxtMonth;

        rTxtLineBBVA += TxtMonth;

        // 7	Importe Maximo a cobrar	Núm.	99	113	15	OBL	Se colocara 13 enteros y 2 decimales sin punto ni comas
        if pRecCollectionBuffer."Currency Code" = 'USD' then
            lclAmountTxt := DelChr(FORMAT(pRecCollectionBuffer."Remaining Amount", 0, '<Precision,2:2><Standard Format,0>'), '=', ',.')
        else
            lclAmountTxt := DelChr(FORMAT(pRecCollectionBuffer."Remaining Amt. (LCY)", 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');

        lclTemp := PADSTR('', 15 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineBBVA += lclTemp;

        // 8	Importe Minimo a cobrar	Núm.	114	128	15	OBL	Se colocara 13 enteros y 2 decimales sin punto ni comas
        if pRecCollectionBuffer."Currency Code" = 'USD' then
            lclAmountTxt := DelChr(FORMAT(pRecCollectionBuffer."Remaining Amount", 0, '<Precision,2:2><Standard Format,0>'), '=', ',.')
        else
            lclAmountTxt := DelChr(FORMAT(pRecCollectionBuffer."Remaining Amt. (LCY)", 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');

        lclTemp := PADSTR('', 15 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineBBVA += lclTemp;

        // 9	Información Adicional	Núm.	129	160	32	OBL	Uso exclusivo del banco se rella de ceros
        rTxtLineBBVA += PADSTR('', 32, '0');

        // 10	Cod. De Sub concepto 01	Núm.	161	162	2	OPC	Se colocar "01" en caso halla subconcepto, si no lo hubiera se coloca "00"
        rTxtLineBBVA += '00';

        // 11	Valor de Sub Concepto 01	Núm.	163	176	14	OPC	Se colocara el monto: 12 enteros y 2 decimales sin punto ni comas.Si no hay se coloca 14 ceros (S)
        rTxtLineBBVA += PADSTR('', 14, '0');

        // 12	Cod. De Sub concepto 02	Núm.	177	178	2	OPC	Se colocar "02" en caso halla subconcepto, si no lo hubiera se coloca "00"
        rTxtLineBBVA += '00';

        // 13	Valor de Sub Concepto 02	Núm.	179	192	14	OPC	Se colocara el monto: 12 enteros y 2 decimales sin punto ni comas.Si no hay se coloca 14 ceros (S)
        rTxtLineBBVA += PADSTR('', 14, '0');

        // 14	Cod. De Sub concepto 03	Núm.	193	194	2	OPC	Se colocar "03" en caso halla subconcepto, si no lo hubiera se coloca "00"
        rTxtLineBBVA += '00';

        // 15	Valor de Sub Concepto 03	Núm.	195	208	14	OPC	Se colocara el monto: 12 enteros y 2 decimales sin punto ni comas.Si no hay se coloca 14 ceros (S)
        rTxtLineBBVA += PADSTR('', 14, '0');

        // 16	Cod. De Sub concepto 04	Núm.	209	210	2	OPC	Se colocar "04" en caso halla subconcepto, si no lo hubiera se coloca "00"
        rTxtLineBBVA += '00';

        // 17	Valor de Sub Concepto 04	Núm.	211	224	14	OPC	Se colocara el monto: 12 enteros y 2 decimales sin punto ni comas.Si no hay se coloca 14 ceros (S)
        rTxtLineBBVA += PADSTR('', 14, '0');

        // 18	Cod. De Sub concepto 05	Núm.	225	226	2	OPC	Se colocar "05" en caso halla subconcepto, si no lo hubiera se coloca "00"
        rTxtLineBBVA += '00';

        // 19	Valor de Sub Concepto 05	Núm.	227	240	14	OPC	Se colocara el monto: 12 enteros y 2 decimales sin punto ni comas.Si no hay se coloca 14 ceros (S)
        rTxtLineBBVA += PADSTR('', 14, '0');

        // 20	Cod. De Sub concepto 06	Núm.	241	242	2	OPC	Se colocar "06" en caso halla subconcepto, si no lo hubiera se coloca "00"
        rTxtLineBBVA += '00';

        // 21	Valor de Sub Concepto 06	Núm.	243	256	14	OPC	Se colocara el monto: 12 enteros y 2 decimales sin punto ni comas.Si no hay se coloca 14 ceros (S)
        rTxtLineBBVA += PADSTR('', 14, '0');

        // 22	Cod. De Sub concepto 07	Núm.	257	258	2	OPC	Se colocar "07" en caso halla subconcepto, si no lo hubiera se coloca "00"
        rTxtLineBBVA += '00';

        // 23	Valor de Sub Concepto 07	Núm.	259	272	14	OPC	Se colocara el monto: 12 enteros y 2 decimales sin punto ni comas.Si no hay se coloca 14 ceros (S)
        rTxtLineBBVA += PADSTR('', 14, '0');

        // 24	Cod. De Sub concepto 08	Núm.	273	274	2	OPC	Se colocar "08" en caso halla subconcepto, si no lo hubiera se coloca "00"
        rTxtLineBBVA += '00';

        // 25	Valor de Sub Concepto 08	Núm.	275	288	14	OPC	Se colocara el monto: 12 enteros y 2 decimales sin punto ni comas.Si no hay se coloca 14 ceros (S)
        rTxtLineBBVA += PADSTR('', 14, '0');

        // 26	Vacio	Alfnúm.	289	360	72	OBL	Rellenar con espacios en Blanco
        // 					360	OBL = Obligatorio, OPC= Opcional 	
        rTxtLineBBVA += PADSTR('', 72, ' ');

    end;

    local procedure BBVATotalStructure(pTotalReg: Integer; pTotalAmoun: Decimal) rTxTotalBBVA: Text
    var
        lclAmountTxt: Text;
        lclTemp: Text;
    begin
        // 1	Tipo de Registro	Núm.	1	2	2	OBL	Indicador de totales 03 (*)	03
        rTxTotalBBVA := '03';

        // 2	Cantidad de Registros Cobrables	Núm.	3	11	9	OBL	Indica la cantidad de registro a cobrar (*)	El sistema deberá calcular esto
        rTxTotalBBVA += PADSTR('', 9 - STRLEN(format(pTotalReg)), '0') + format(pTotalReg);

        // 3	Total de los importes máximos a recaudar	Núm.	12	29	18	OBL	Es el total de la suma de los importes maximos de todos los registros (***)	El sistema deberá calcular esto
        lclAmountTxt := DelChr(FORMAT(pTotalAmoun, 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
        lclTemp := PADSTR('', 18 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxTotalBBVA += lclTemp;

        // 4	Total de los importes mínimos a recaudar	Núm.	30	47	18	OBL	Es el total de la suma de los importes minimos de todos los registros (****)	El sistema deberá calcular esto
        lclAmountTxt := DelChr(FORMAT(pTotalAmoun, 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
        lclTemp := PADSTR('', 18 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxTotalBBVA += lclTemp;

        // 5	Datos adicionales	Núm.	48	65	18	OBL	Rellenar de 18 ceros. Uso exclusivo del banco.	000000000000000000
        rTxTotalBBVA += PADSTR('', 18, '0');

        // 6	Vacio	Alfnúm.	66	360	295	OBL	Rellenar con espacios en Blanco	
        rTxTotalBBVA += PADSTR('', 295, ' ');

        // 					360	OBL = Obligatorio, OPC= Opcional 		

    end;

    local procedure SetValuesSCOTIA(var pBankAccountNo: Code[20]; var pCurrencyCode: Code[10]) rText: Text
    var
        BankAccount: Record "Bank Account";
        BankAccNoTxt: Text;
        Currecncy: Text;
    begin
        BankAccount.get(pBankAccountNo);
        case pCurrencyCode of
            '':
                begin
                    case BankAccount."Bank Account Type" of
                        BankAccount."Bank Account Type"::"Current Account":
                            Currecncy := '01';
                        BankAccount."Bank Account Type"::"Savings Account":
                            Currecncy := '07';
                    end;
                    SecuenceSBP := '001';
                end;
            'USD':
                begin
                    case BankAccount."Bank Account Type" of
                        BankAccount."Bank Account Type"::"Current Account":
                            Currecncy := '14';
                        BankAccount."Bank Account Type"::"Savings Account":
                            Currecncy := '83';
                    end;
                    SecuenceSBP := '002';
                end;
            else
                SecuenceSBP := '003';
        end;
        BankAccNoTxt := DelChr(BankAccount."Bank Account No.", '=', '- ');
        rText := CopyStr(BankAccNoTxt, 4, StrLen(BankAccNoTxt)) + CopyStr(BankAccNoTxt, 1, 3) + Currecncy + '  ';
        exit(rText);
    end;

    local procedure SCOTIAHeaderStructure(pProcessDate: date; pBankNo: code[20]; pCurrencyCode: code[10]; pTotalRecords: Integer; pTotalAmountDoc: Decimal) rTxtHeaderSB: Text
    var
        lclTemp: Text;
        lclAmountTxt: Text;
        lclAmount1: Decimal;
        lclAmount2: Decimal;
    begin
        //1 Tipo de registro
        rTxtHeaderSB := 'H';

        //2 Cuenta empresa
        // Debe ser de 12 o 14 caracteres. En caso de 12 por Ejm. N° cta: 000 1234567, 
        // colocar a la inversa: 123456700001, donde: 1234567 es Nro de cta ; 
        // 000 es el nro de agencia; 01=Tipo Cta Tipos de cta: 
        // 01=Cta.C.Soles; 07:Cta.C.US;14:Cta.A. Soles; 83:Cta.A.US

        rTxtHeaderSB += SetValuesSCOTIA(pBankNo, pCurrencyCode);

        if SecuenceSBP = '001' then begin
            lclAmount1 := pTotalAmountDoc;
            lclAmount2 := 0;
        end else begin
            lclAmount2 := pTotalAmountDoc;
            lclAmount1 := 0;
        end;

        //3 Secuencia/Servicio
        rTxtHeaderSB += SecuenceSBP;

        //4 Cantidad registros
        lclTemp := PADSTR('', 7 - STRLEN(FORMAT(pTotalRecords)), '0') + FORMAT(pTotalRecords);
        rTxtHeaderSB += lclTemp;

        //5 Total soles
        lclAmountTxt := DelChr(FORMAT(lclAmount1, 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
        lclTemp := PADSTR('', 17 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtHeaderSB += lclTemp;

        //6 Total dolares
        lclAmountTxt := DelChr(FORMAT(lclAmount2, 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
        lclTemp := PADSTR('', 17 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtHeaderSB += lclTemp;

        //7 RUC Empresa
        rTxtHeaderSB += CompanyInformation."VAT Registration No.";

        //8 Fecha envio
        rTxtHeaderSB += GetDate(pProcessDate);

        //9 Fecha vigencia
        rTxtHeaderSB += '20301231';

        //10    Filler
        rTxtHeaderSB += '000';

        //11    Dias mora
        rTxtHeaderSB += '900';

        //12    Tipo mora
        rTxtHeaderSB += '00';

        //13    Mora flat
        lclTemp := PADSTR('', 11, '0');
        rTxtHeaderSB += lclTemp;

        //14    Porcentaje mora
        lclTemp := PADSTR('', 8, '0');
        rTxtHeaderSB += lclTemp;

        //15    Monto fijo
        lclTemp := PADSTR('', 11, '0');
        rTxtHeaderSB += lclTemp;

        //16    Tipo descuento
        lclTemp := PADSTR('', 2, '0');
        rTxtHeaderSB += lclTemp;

        //17    Monto a descontar
        lclTemp := PADSTR('', 11, '0');
        rTxtHeaderSB += lclTemp;

        //18    Porcentaje descuento
        lclTemp := PADSTR('', 8, '0');
        rTxtHeaderSB += lclTemp;

        //19    Dias descuento
        lclTemp := PADSTR('', 3, '0');
        rTxtHeaderSB += lclTemp;

        //20    Fecha de inicio CA
        rTxtHeaderSB += GetDate(pProcessDate);

        //21    Fecha de fin CA
        rTxtHeaderSB += GetDate(pProcessDate);

        //22    Ind. mod de fechas
        rTxtHeaderSB += '1';

        //23    Filler
        lclTemp := PADSTR('', 124, ' ');
        rTxtHeaderSB += lclTemp;

        //24    Fin de registro
        rTxtHeaderSB += '*';
    end;

    local procedure SCOTIALineStructure(var pRecCollectionBuffer: Record "Collection Payment Buffer" temporary; pBankNo: code[20]; pCurrencyCode: code[10]; pTRecord: text) rTxtLineSB: Text
    var
        lclTemp: Text;
        lclAmountTxt: Text;
        lclName: Text;
    begin
        // TIPO DE REGISTRO CHAR(01) "D" 1 1 1
        rTxtLineSB := 'D';

        // CUENTA EMPRESA CHAR(14) CUENTA EMPRESA 2 15 14
        //2 Cuenta empresa
        rTxtLineSB += SetValuesSCOTIA(pBankNo, pCurrencyCode);

        // SECUENCIA/SERVICIO NUM(03) CODIGO DEL SERVICIO 16 18 3
        rTxtLineSB += SecuenceSBP;

        // CODIGO USUARIO CHAR(15) CODIGO DEL USUARIO 19 33 15
        lclTemp := pRecCollectionBuffer."No. Suministro";
        rTxtLineSB += lclTemp + PADSTR('', 15 - STRLEN(lclTemp), ' ');

        // NUMERO RECIBO CHAR(15) NUMERO DEL RECIBO O DOCUMENTO 34 48 15
        lclTemp := delchr(pRecCollectionBuffer."Document No.", '=', '-');
        rTxtLineSB += lclTemp + PADSTR('', 15 - STRLEN(lclTemp), ' ');

        // CODIGO AGRUPACION CHAR(11) RUC DE AGRUPACION DEUDA INSTITUCION 49 59 11
        rTxtLineSB += pRecCollectionBuffer."Customer No." + PADSTR('', 11 - STRLEN(pRecCollectionBuffer."Customer No."), '0');

        // SITUACION CHAR(01) 0:PENDIENTE 60 60 1
        rTxtLineSB += '0';

        // MONEDA DE COBRO NUM(04) 0000:SOLES 0001:DOLARES 61 64 4
        if pRecCollectionBuffer."Currency Code" = '' then
            rTxtLineSB += '0000'
        else
            if pRecCollectionBuffer."Currency Code" = 'USD' then
                rTxtLineSB += '0001';

        // NOMBRE DEL USUARIO CHAR(20) NOMBRE DEL USUARIO 65 84 20
        lclName := delchr(pRecCollectionBuffer."Customer Name", '=', 'ñ°-´');
        lclName := CopyStr(lclName, 1, 20);
        rTxtLineSB += lclName + PADSTR('', 20 - STRLEN(lclName), ' ');

        // REFERENCIA RECIBO CHAR(30) DESCRIPCION DE LA DEUDA 85 114 30
        rTxtLineSB += pRecCollectionBuffer.Description + PADSTR('', 30 - STRLEN(pRecCollectionBuffer.Description), ' ');

        // CONCEPTO A COBRAR 1 NUM(02) CODIGO DE CONCEPTO 1 115 116 2
        rTxtLineSB += '01';

        // IMPORTE A COBRAR 1 NUM(9,2) IMPORTE DEL CONCEPTO 1 117 127 11
        lclAmountTxt := DelChr(FORMAT(pRecCollectionBuffer."Remaining Amount", 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
        lclTemp := PADSTR('', 11 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineSB += lclTemp;

        // CONCEPTO A COBRAR 2 NUM(02) CODIGO DE CONCEPTO 2 128 129 2
        rTxtLineSB += '  ';

        // IMPORTE A COBRAR 2 NUM(9,2) IMPORTE DEL CONCEPTO 2 130 140 11
        lclAmountTxt := '0';
        lclTemp := PADSTR('', 11 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineSB += lclTemp;

        // CONCEPTO A COBRAR 3 NUM(02) CODIGO DE CONCEPTO 3 141 142 2
        rTxtLineSB += '  ';

        // IMPORTE A COBRAR 3 NUM(9,2) IMPORTE DEL CONCEPTO 3 143 153 11
        lclAmountTxt := '0';
        lclTemp := PADSTR('', 11 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineSB += lclTemp;

        // CONCEPTO A COBRAR 4 NUM(02) CODIGO DE CONCEPTO 4 154 155 2
        rTxtLineSB += '  ';

        // IMPORTE A COBRAR 4 NUM(9,2) IMPORTE DEL CONCEPTO 4 156 166 11
        lclAmountTxt := '0';
        lclTemp := PADSTR('', 11 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineSB += lclTemp;

        // CONCEPTO A COBRAR 5 NUM(02) CODIGO DE CONCEPTO 5 167 168 2
        rTxtLineSB += '  ';

        // IMPORTE A COBRAR 5 NUM(9,2) IMPORTE DEL CONCEPTO 5 169 179 11
        lclAmountTxt := '0';
        lclTemp := PADSTR('', 11 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineSB += lclTemp;

        // CONCEPTO A COBRAR 6 NUM(02) CODIGO DE CONCEPTO 6 180 181 2
        rTxtLineSB += '  ';

        // IMPORTE A COBRAR 6 NUM(9,2) IMPORTE DEL CONCEPTO 6 182 192 11
        lclAmountTxt := '0';
        lclTemp := PADSTR('', 11 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineSB += lclTemp;

        // TOTAL A COBRAR NUM(13,2) SUMATORIA DE CONCEPTO A COBRAR 193 207 15
        lclAmountTxt := DelChr(FORMAT(pRecCollectionBuffer."Remaining Amount", 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
        lclTemp := PADSTR('', 15 - STRLEN(lclAmountTxt), '0') + lclAmountTxt;
        rTxtLineSB += lclTemp;

        // SALDO DE LA DEUDA NUM(13,2) SALDO DEL DOCUMENTO 208 222 15
        rTxtLineSB += lclTemp;

        // PORCENTAJE MINIMO NUM(4,4) SOLO PARA PAGOS PARCIALES 223 230 8
        rTxtLineSB += PADSTR('', 8, '0');

        // ORDEN CRONOLOGICO NUM(01) 0:CRONOLOGICO 1:CUALQUIER FECHA 2:DEUDA CONSOLIDADA 231 231 1
        rTxtLineSB += '0';

        // FECHA DE EMISION CHAR(08) FECHA DE EMISION DEL RECIBO O DOCUMENTO 232 239 8
        rTxtLineSB += GetDate(pRecCollectionBuffer."Document Date");

        // FECHA DE VENCIMIENTO CHAR(08) FECHA DE VENCIMIENTO DEL RECIBO O DOC. 240 247 8
        rTxtLineSB += GetDate(pRecCollectionBuffer."Due Date");

        // DIAS DE PRORROGA NUM(03) PERMITE PAGAR DESPUES DEL VCTO 248 250 3
        rTxtLineSB += '000';

        // CUENTA CARGO CHAR(14) CUENTA CARGO 251 264 14
        rTxtLineSB += PADSTR('', 14, '0');

        // INDICADOR DE CARGO AUTOMATICO   01 = Cuotas Variables    02 = Cargo Automático 265 266 2
        rTxtLineSB += '01';

        // IND. TIPO DE AFILIACION  A= Adición  E= Eliminación M=Modificación  R=Reemplazo 267 267 1
        rTxtLineSB += pTRecord;

        // FECHA DE INICIO DE CARGO AUTOMATICO 268 275 8  // FECHA INICIO DE C.A CHAR(8) 
        rTxtLineSB += PADSTR('', 8, ' ');

        // FECHA FIN DE C.A CHAR(8) FECHA FIN DE CARGO AUTOMATICO 276 283 8 
        rTxtLineSB += PADSTR('', 8, ' ');

        //FILLER
        rTxtLineSB += PADSTR('', 6, ' ');

        // FIN DE REGISTRO CHAR(01) ULTIMA POSICION CON ASTERISCO "*" 290 290 1
        rTxtLineSB += '*';
    end;

    local procedure SCOTIATotalStructure(pBankNo: code[20]; pCurrencyCode: Code[10]) rTxtTotalSB: Text
    var
        lclTemp: Text;
        lclAmountTxt: Text;
    begin
        // TIPO DE REGISTRO CHAR(01) "D" 1 1 1
        rTxtTotalSB := 'C';

        //CUENTA EMPRESA
        rTxtTotalSB += SetValuesSCOTIA(pBankNo, pCurrencyCode);

        //SECUENCIA/SERVICIO
        rTxtTotalSB += SecuenceSBP;

        //CODIGO CONCEPTO
        rTxtTotalSB += '00';

        //DESCRIPCION CONCEPTO
        rTxtTotalSB += PADSTR('', 30, ' ');

        //AFECTO AL PAGO PARCIAL
        rTxtTotalSB += '0';

        //CUENTA DE ABONO
        rTxtTotalSB += PADSTR('', 14, '0');

        //FILLER
        rTxtTotalSB += PADSTR('', 200, ' ');

        //FIN DE REGISTRO
        rTxtTotalSB += '*';
    end;

    local procedure INTERBANKHeaderStructure(pProcessDate: date; pCurrencyCode: code[10]; pTotalRecords: Integer; pTotalAmount: Decimal; pTRecord: Text) rTxtHeaderIBK: Text
    var
        lclAmountTxt: Text;
        lclAmountTxt1: Text;
        lclAmountTxt2: Text;
        lclTemp: Text;
    begin
        // Registro de Cabecera	Longitud	Inicio	Fin	Tipo	Enteros	Decimales	Descripción
        // 1	Tipo de registro	2	1	2	N	2		Valor fijo (ver valores)
        rTxtHeaderIBK := '11';

        // 2	Código de grupo	2	3	4	N	2		Valor fijo (ver valores)
        rTxtHeaderIBK += '21';

        // 3	Código de rubro	2	5	6	N	2		Código asignado por el banco
        rTxtHeaderIBK += '00';

        // 4	Código de empresa	3	7	9	N	3		Código asignado por el banco
        rTxtHeaderIBK += '000';

        // 5	Código de servicio	2	10	11	N	2		Código asignado por el banco
        rTxtHeaderIBK += '00';

        // 6	Código de solicitud	2	12	13	N	2		Código que identifica a la solicitud 
        rTxtHeaderIBK += '00';

        // 7	Descripción de solicitud	30	14	43	A	30		Descripción de la solicitud
        rTxtHeaderIBK += PADSTR('', 30, ' ');

        // 8	Origen de la Solicitud	1	44	44	N	1		Modalidad de ingreso solo para Pago Automático caso contrario cero
        rTxtHeaderIBK += '0';

        // 9	Código de requerimiento	3	45	47	N	3		Valor fijo (ver valores)
        rTxtHeaderIBK += '002';

        // 10	Canal de envío	1	48	48	N	1		Valor fijo (ver valores)
        rTxtHeaderIBK += '0';

        // 11	Tipo de información	1	49	49	A	1		Tipo de información (ver valores) solo para Data Parcial y Data Completa caso contrario blanco
        rTxtHeaderIBK += pTRecord;

        // 12	Número de registros	15	50	64	N	15		Número de Registros de detalle 
        rTxtHeaderIBK += PADSTR('', 15 - StrLen(Format(pTotalRecords)), '0') + Format(pTotalRecords);

        // 13	Código único	10	65	74	N	10		Código asignado por el banco
        rTxtHeaderIBK += PADSTR('', 10, '0');

        // 14	Fecha de proceso	8	75	82	N	8		Fecha a cargar/grabación de la información (Formato YYYYMMDD)
        rTxtHeaderIBK += GetDate(pProcessDate);

        // 15	Fecha de Inicio de Cargos	8	83	90	N	8		Fecha de inicio de cargos recurrentes (Formato YYYYMMDD) solo para Pago Automático caso contrario ceros
        rTxtHeaderIBK += PADSTR('', 8, '0');

        // 16	Moneda	2	91	92	N	2		Código de la moneda (ver valores) en la que esta incrita la empresa  solo para Pago Automático caso contrario ceros
        rTxtHeaderIBK += '00';

        case pCurrencyCode of
            '':
                begin
                    lclAmountTxt1 := DelChr(FORMAT(pTotalAmount, 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
                    lclAmountTxt2 := PADSTR('', 15, '0');
                end;
            'USD':
                begin
                    lclAmountTxt2 := DelChr(FORMAT(pTotalAmount, 0, '<Precision,2:2><Standard Format,0>'), '=', ',.');
                    lclAmountTxt1 := PADSTR('', 15, '0');
                end;
        end;
        // 17	IrTxtHeaderIBKmporte total 1	15	93	107	N	13	2	Importe total en soles a cobrar (si la cobranza es en soles) solo para Data Completa, Importe total a cargar solo para Pago Automático caso contrario ceros
        lclTemp := PADSTR('', 15 - STRLEN(lclAmountTxt1), '0') + lclAmountTxt1;
        rTxtHeaderIBK += lclTemp;

        // 18	Importe total 2	15	108	122	N	13	2	Importe total en dólares a cobrar (si la cobranza es en dólares) solo para Data Completa caso contrario ceros
        lclTemp := PADSTR('', 15 - STRLEN(lclAmountTxt2), '0') + lclAmountTxt2;
        rTxtHeaderIBK += lclTemp;

        // 19	Tipo de Glosa	1	123	123	A	1		Tipo de glosa (ver valores) a utilizar en las notas de abono/débito solo para Pago Automático
        rTxtHeaderIBK += 'G';

        // 20	Glosa General	50	124	173	A	50		Relacionada al tipo de glosa solo para Pago Automático caso contrario blancos
        rTxtHeaderIBK += PADSTR('', 50, ' ');

        // 21	Libre	221	174	394	A	221		Blancos
        rTxtHeaderIBK += PADSTR('', 221, ' ');

        // 22	Tipo Formato	2	395	396	N	2		Valor fijo (ver valores)
        rTxtHeaderIBK += '02';

        // 23	Código fijo	4	397	400	N	4		Valor fijo (ver valores)
        rTxtHeaderIBK += '0000';

    end;

    local procedure INTERBANKQuotaPostStructure() rTxtQuotaIBK: Text
    var
    begin
        // 1	Tipo de registro	2	1	2	N	2		Valor fijo (ver valores)
        rTxtQuotaIBK += '12';

        // 2	Código de cuota	8	3	10	A	8		Si no maneja cuotas llenar con ceros
        rTxtQuotaIBK += PADSTR('', 8, '0');

        // 3	Número de conceptos	1	11	11	N	1		Si no maneja conceptos llenar con 1
        rTxtQuotaIBK += '1';

        // 4	Descripción del concepto 1	10	12	21	A	10		Si no maneja conceptos llenar la descripción 1
        rTxtQuotaIBK += PADSTR('', 10, '1');

        // 5	Descripción del concepto 2	10	22	31	A	10		Si no maneja conceptos llenar con blancos
        rTxtQuotaIBK += PADSTR('', 10, ' ');

        // 6	Descripción del concepto 3	10	32	41	A	10		Si no maneja conceptos llenar con blancos
        rTxtQuotaIBK += PADSTR('', 10, ' ');

        // 7	Descripción del concepto 4	10	42	51	A	10		Si no maneja conceptos llenar con blancos
        rTxtQuotaIBK += PADSTR('', 10, ' ');

        // 8	Descripción del concepto 5	10	52	61	A	10		Si no maneja conceptos llenar con blancos
        rTxtQuotaIBK += PADSTR('', 10, ' ');

        // 9	Descripción del concepto 6	10	62	71	A	10		Si no maneja conceptos llenar con blancos
        rTxtQuotaIBK += PADSTR('', 10, ' ');

        // 10	Descripción del concepto 7	10	72	81	A	10		Si no maneja conceptos llenar con blancos
        rTxtQuotaIBK += PADSTR('', 10, ' ');

        // 11	Libre	313	82	394	A	313		Blancos
        rTxtQuotaIBK += PADSTR('', 313, ' ');

        // 12	Tipo Formato	2	395	396	N	2		Valor fijo (ver valores)
        rTxtQuotaIBK += '02';

        // 13	Código fijo	4	397	400	N	4		Valor fijo (ver valores)
        rTxtQuotaIBK += '0000';
    end;

    local procedure INTERBANKLinesStructure(var pRecCollectionBuffer: Record "Collection Payment Buffer" temporary; pCurrencyCode: text; TRecord: Text) rTxtLinesIBK: Text
    var
        lclTemp: Text;
    begin
        // 1	Tipo de registro	2	1	2	N	2		Valor fijo (ver valores)
        rTxtLinesIBK := '13';

        // 2	Código de deudor	20	3	22	A	20		Código numérico o Alfanumérico (alineado a la izquierda)
        lclTemp := pRecCollectionBuffer."Customer No.";
        rTxtLinesIBK += lclTemp + PADSTR('', 20 - StrLen(lclTemp), ' ');

        // 3	Nombre del deudor	30	23	52	A	30		Nombre del Deudor solo para Data Parcial y Data Completa caso contrario espacios
        lclTemp := copystr(pRecCollectionBuffer."Customer Name", 1, 30);
        rTxtLinesIBK += lclTemp + PADSTR('', 30 - StrLen(lclTemp), ' ');

        // 4	Referencia 1	10	53	62	A	10		Referencia de Operación 1 solo para Data Parcial y Data Completa caso contrario espacios
        rTxtLinesIBK += PADSTR('', 10, ' ');

        // 5	Referencia 2	10	63	72	A	10		Referencia de Operación 2 solo para Data Parcial y Data Completa caso contrario espacios
        rTxtLinesIBK += PADSTR('', 10, ' ');

        // 6	Tipo de Operación	1	73	73	A	1		Tipo de operación (ver valores) solo para Data Completa caso contrario espacio
        rTxtLinesIBK += TRecord;

        // 7	Código de cuota	8	74	81	A	8		Código de Cuota (alineado a la izquierda) solo para Data Completa caso contrario espacios
        rTxtLinesIBK += PADSTR('', 8, ' ');

        // 8	Fecha de emisión	8	82	89	N	8		Fecha de emisión del documento a cobrar Formato YYYYMMDD solo para Data Completa caso contrario ceros
        rTxtLinesIBK += GetDate(pRecCollectionBuffer."Document Date");

        // 9	Fecha de vencimiento	8	90	97	N	8		Fecha de Vencimiento del documento a cobrar Formato YYYYMMDD solo para Data Completa caso contrario ceros
        rTxtLinesIBK += GetDate(pRecCollectionBuffer."Due Date");

        // 10	Número de documento	15	98	112	A	15		Número de Documento relacionado al cobro solo para Data Completa caso contrario espacios
        lclTemp := copystr(pRecCollectionBuffer."Document No.", 1, 15);
        rTxtLinesIBK += lclTemp + PADSTR('', 15 - StrLen(lclTemp), ' ');

        // 11	Moneda de la deuda	2	113	114	N	2		Código de la moneda (ver valores) en la que esta incrita la empresa solo para Data Completa caso contrario ceros
        case pCurrencyCode of
            '':
                rTxtLinesIBK += '01';
            'USD':
                rTxtLinesIBK += '10';
        end;

        // 12	Importe del concepto 1	9	115	123	N	7	2	Si no maneja conceptos enviar el importe de la deuda solo para Data Completa caso contrario ceros
        rTxtLinesIBK += PADSTR('', 9, ' ');

        // 13	Importe del concepto 2	9	124	132	N	7	2	Si no maneja conceptos enviar ceros solo para Data Completa caso contrario ceros
        rTxtLinesIBK += PADSTR('', 9, ' ');

        // 14	Importe del concepto 3	9	131	141	N	7	2	Si no maneja conceptos enviar ceros solo para Data Completa caso contrario ceros
        rTxtLinesIBK += PADSTR('', 9, ' ');

        // 15	Importe del concepto 4	9	142	150	N	7	2	Si no maneja conceptos enviar ceros solo para Data Completa caso contrario ceros
        rTxtLinesIBK += PADSTR('', 9, ' ');

        // 16	Importe del concepto 5	9	151	159	N	7	2	Si no maneja conceptos enviar ceros solo para Data Completa caso contrario ceros
        rTxtLinesIBK += PADSTR('', 9, ' ');

        // 17	Importe del concepto 6	9	160	168	N	7	2	Si no maneja conceptos enviar ceros solo para Data Completa caso contrario ceros
        rTxtLinesIBK += PADSTR('', 9, ' ');

        // 18	Importe del concepto 7	9	169	177	N	7	2	Si no maneja conceptos enviar ceros solo para Data Completa caso contrario ceros
        rTxtLinesIBK += PADSTR('', 9, ' ');

        // 19	Tipo de la cuenta Principal	1	178	178	A	1		Tipo de la cuenta en que se va a cargar solo para Pago Automático caso contrario espacio
        rTxtLinesIBK += ' ';

        // 20	Producto de la cuenta principal	3	179	181	A	3		Producto de la cuenta del cliente a quien se le debitara (si es cuenta de depósitos) solo para Pago Automático caso contrario espacios
        rTxtLinesIBK += PADSTR('', 3, ' ');

        // 21	Moneda de la cuenta Principal	2	182	183	A	2		Moneda de la cuenta del cliente a quien se le debitara (si es cuenta de depósitos) solo para Pago Automático caso contrario espacios
        rTxtLinesIBK += PADSTR('', 2, ' ');

        // 22	Numero de la cuenta Principal	20	184	203	A	20		Número de la cuenta del cliente a quien se le debitara solo para Pago Automático caso contrario espacios
        rTxtLinesIBK += PADSTR('', 20, ' ');

        // 23	Importe a abonar cuenta 1	15	204	218	N	13	2	Importe a abonar en la cuenta recaudadora 1 solo para Pago Automático caso contrario ceros
        rTxtLinesIBK += PADSTR('', 15, ' ');

        // 24	Tipo de la cuenta Secundaria	1	219	219	A	1		Tipo de la cuenta secundaria en que se va a cargar solo para Pago Automático caso contrario espacio
        rTxtLinesIBK += ' ';

        // 25	Producto de la cuenta Secundaria	3	220	222	A	3		Producto de la cuenta secundaria del cliente a quien se le debitara (si es cuenta de depósitos) solo para Pago Automático caso contrario espacios
        rTxtLinesIBK += '000';

        // 26	Moneda de la cuenta Secundaria	2	223	224	A	2		Moneda de la cuenta secundaria del cliente a quien se le debitara (si es cuenta de depósitos) solo para Pago Automático caso contrario espacios
        rTxtLinesIBK += '  ';

        // 27	Numero de la cuenta Secundaria	20	225	244	A	20		Número de la cuenta secundaria del cliente a quien se le debitara solo para Pago Automático caso contrario espacios
        rTxtLinesIBK += PADSTR('', 20, ' ');

        // 28	Importe a abonar cuenta 2	15	245	259	N	13	2	Importe a abonar en la cuenta recaudadora 2 solo para Pago Automático caso contrario ceros
        rTxtLinesIBK += PADSTR('', 15, '0');

        // 29	Glosa Particular	67	260	326	A	67		Relacionada al tipo de glosa solo para Pago Automático caso contrario espacios
        rTxtLinesIBK += PADSTR('', 67, ' ');

        // 30	Libre	68	327	394	A	68		Blancos
        rTxtLinesIBK += PADSTR('', 68, ' ');

        // 31	Tipo Formato	2	395	396	N	2		Valor fijo (ver valores)
        rTxtLinesIBK += '02';

        // 32	Código fijo	4	397	400	N	4		Valor fijo (ver valores)
        rTxtLinesIBK += PADSTR('', 4, ' ');

    end;
}
