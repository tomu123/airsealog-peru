codeunit 51002 "Inv. Bal. EBooks"
{
    trigger OnRun()
    begin

    end;

    /*
        local procedure OpenWindows(CreateFileFlag: Boolean)
        var
            ContaintText: Text[200];
        begin
            ContaintText := Processing;
            if CreateFileFlag then
                ContaintText += CreatingFile;
            Windows.Open(ContaintText);
        end;

        local procedure UpdateWindows(Number: Integer; Counter: Integer; Total: Integer)
        begin
            Windows.Update(Number, ROUND(Counter / Total * 10000, 2));
        end;

        local procedure CloseWindows()
        begin
            Windows.Close();
        end;

        //General Journal Books
        procedure GenInvBalBooks(pBookCode: Code[10]; IsEBook: Boolean)
        begin
            BookCode := pBookCode;
            if not NotRequestDate then
                if not SetDate() then
                    exit;
            if not CheckDateExists() then
                exit;
            OpenWindows(IsEBook);
            //CreateBookInvBal317();
            if IsEBook then
                CreateFileEBookFromInvBalBooks();
            CloseWindows();
        end;

        procedure CreateBookInvBal317()
        var
            EntryNo: Integer;
            TotalRecords: Integer;
            CountRecords: Integer;

            gDebitAmountP: Decimal;
            gCreditAmountP: Decimal;
            gDebitAmount: Decimal;
            gCreditAmount: Decimal;

            gCompanyInfo: Record "Company Information";
            gGLAccount: Record "G/L Account";
            recGLEntry: Record "G/L Entry";
            bMovimientoSInic: Boolean;
            bMovimientoSaldo: Decimal;
            gCampos: array[50] of Text[1024];

            gText002: Label 'Procesando  @1@@@@@@@@@@@@@\', comment = 'ENU="Procesando  @1@@@@@@@@@@@@@\"';
        begin
            EntryNo := 0;
            CountRecords := 0;
            case BookCode of
                '317':
                    begin
                        gGLAccount.RESET;
                        gGLAccount.SETRANGE("Date Filter", StartDate, EndDate);
                        gGLAccount.SETRANGE("Account Type", gGLAccount."Account Type"::Posting);
                        gGLAccount.SETFILTER("No.", '%1..%2', '1*', '9*');
                        gGLAccount.SETFILTER("No.", '<>%1', '0*');
                        gGLAccount.SETFILTER("No.", '<>%1', 'MS*');
                        TotalRecords := gGLAccount.Count;
                        IF gGLAccount.FINDSET THEN
                            REPEAT
                                bMovimientoSInic := FALSE;
                                recGLEntry.SETRANGE(recGLEntry."G/L Account No.", gGLAccount."No.");
                                recGLEntry.SETRANGE(recGLEntry.Apertura, TRUE);
                                IF recGLEntry.FINDSET THEN
                                    bMovimientoSInic := TRUE;

                                gDebitAmountP := 0;
                                gCreditAmountP := 0;
                                recGLEntry.SETRANGE(recGLEntry."G/L Account No.", gGLAccount."No.");
                                recGLEntry.SETRANGE(recGLEntry."Posting Date", StartDate, EndDate);
                                recGLEntry.SETRANGE(recGLEntry.Apertura, FALSE);
                                IF recGLEntry.FINDSET THEN BEGIN
                                    REPEAT
                                        gDebitAmountP += recGLEntry."Debit Amount";
                                        gCreditAmountP += recGLEntry."Credit Amount";
                                    UNTIL recGLEntry.NEXT = 0;
                                END;

                                bMovimientoSaldo := gDebitAmountP - gCreditAmountP;

                                IF (bMovimientoSInic) OR (bMovimientoSaldo <> 0) OR ((gDebitAmountP <> 0) OR (gCreditAmountP <> 0)) THEN BEGIN
                                    gCampos[1] := "#SetFormatDate"(gEndDate, TRUE);
                                    gCampos[2] := gGLAccount."No.";


                                    gDebitAmount := 0;
                                    gCreditAmount := 0;
                                    recGLEntry.SETRANGE(recGLEntry."G/L Account No.", gGLAccount."No.");
                                    recGLEntry.SETRANGE(recGLEntry.Apertura, TRUE);
                                    IF recGLEntry.FINDSET THEN BEGIN
                                        REPEAT
                                            gDebitAmount += recGLEntry."Debit Amount";
                                            gCreditAmount += recGLEntry."Credit Amount";
                                        UNTIL recGLEntry.NEXT = 0;
                                    END;

                                    IF gDebitAmount = 0 THEN BEGIN
                                        gCampos[3] := '0.00';
                                    END ELSE BEGIN
                                        gCampos[3] := DELCHR(FORMAT(gDebitAmount), '=', ',');
                                    END;

                                    IF gCreditAmount = 0 THEN BEGIN
                                        gCampos[4] := '0.00';
                                    END ELSE BEGIN
                                        gCampos[4] := DELCHR(FORMAT(gCreditAmount), '=', ',');
                                    END;

                                    //-------
                                    gDebitAmountP := 0;
                                    gCreditAmountP := 0;
                                    recGLEntry.SETRANGE(recGLEntry."G/L Account No.", gGLAccount."No.");
                                    recGLEntry.SETRANGE(recGLEntry."Posting Date", StartDate, EndDate);
                                    recGLEntry.SETRANGE(recGLEntry.Apertura, FALSE);
                                    IF recGLEntry.FINDSET THEN BEGIN
                                        REPEAT
                                            gDebitAmountP += recGLEntry."Debit Amount";
                                            gCreditAmountP += recGLEntry."Credit Amount";
                                        UNTIL recGLEntry.NEXT = 0;
                                    END;

                                    IF gDebitAmountP = 0 THEN BEGIN
                                        gCampos[5] := '0.00';
                                    END ELSE BEGIN
                                        gCampos[5] := DELCHR(FORMAT(gDebitAmountP), '=', ',');
                                    END;

                                    IF gCreditAmountP = 0 THEN BEGIN
                                        gCampos[6] := '0.00';
                                    END ELSE BEGIN
                                        gCampos[6] := DELCHR(FORMAT(gCreditAmountP), '=', ',');
                                    END;

                                    //--------
                                    IF (gDebitAmount + gDebitAmountP) = 0 THEN BEGIN
                                        gCampos[7] := '0.00';
                                    END ELSE BEGIN
                                        gCampos[7] := DELCHR(FORMAT(gDebitAmount + gDebitAmountP), '=', ',');
                                    END;

                                    IF (gCreditAmount + gCreditAmountP) = 0 THEN BEGIN
                                        gCampos[8] := '0.00'
                                    END ELSE BEGIN
                                        gCampos[8] := DELCHR(FORMAT(gCreditAmount + gCreditAmountP), '=', ',');
                                    END;


                                    gCampos[9] := '0.00';
                                    gCampos[10] := '0.00';
                                    IF (gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP) > 0 THEN BEGIN
                                        gCampos[9] := DELCHR(FORMAT(ABS((gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP))), '=', ',');

                                    END ELSE BEGIN
                                        gCampos[10] := DELCHR(FORMAT(ABS((gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP))), '=', ',');
                                    END;

                                    IF (gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP) = 0 THEN BEGIN
                                        gCampos[9] := '0.00';
                                        gCampos[10] := '0.00';
                                    END;

                                    gCampos[11] := '0.00';
                                    gCampos[12] := '0.00';


                                    gCampos[13] := '0.00';
                                    gCampos[14] := '0.00';
                                    IF (gGLAccount."Income/Balance" = gGLAccount."Income/Balance"::"Balance Sheet") THEN BEGIN
                                        IF (gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP) > 0 THEN BEGIN
                                            gCampos[13] := DELCHR(FORMAT(ABS((gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP))), '=', ',');
                                        END ELSE BEGIN
                                            gCampos[14] := DELCHR(FORMAT(ABS((gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP))), '=', ',');
                                        END;

                                        IF (gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP) = 0 THEN BEGIN
                                            gCampos[13] := '0.00';
                                            gCampos[14] := '0.00';
                                        END
                                    END;

                                    gCampos[15] := '0.00';
                                    gCampos[16] := '0.00';
                                    IF ((COPYSTR(gGLAccount."No.", 1, 1) = '7') OR (COPYSTR(gGLAccount."No.", 1, 1) = '6')) AND NOT (COPYSTR(gGLAccount."No.", 1, 2) = '79') OR (COPYSTR(gGLAccount."No.", 1, 1) = '8') THEN BEGIN
                                        IF (gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP) > 0 THEN BEGIN
                                            gCampos[15] := DELCHR(FORMAT(ABS((gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP))), '=', ',');
                                        END ELSE BEGIN
                                            gCampos[16] := DELCHR(FORMAT(ABS((gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP))), '=', ',');
                                        END;

                                        IF (gDebitAmount + gDebitAmountP) - (gCreditAmount + gCreditAmountP) = 0 THEN BEGIN
                                            gCampos[15] := '0.00';
                                            gCampos[16] := '0.00';
                                        END;
                                    END;

                                    gCampos[17] := '0.00';
                                    gCampos[18] := '0.00';
                                    gCampos[19] := '1';


                                    gFile.WRITE(gCampos[1] + '|' + gCampos[2] + '|' + gCampos[3] + '|' + gCampos[4] + '|' + gCampos[5] + '|' +
                                                gCampos[6] + '|' + gCampos[7] + '|' + gCampos[8] + '|' + gCampos[9] + '|' + gCampos[10] + '|' +
                                                gCampos[11] + '|' + gCampos[12] + '|' + gCampos[13] + '|' + gCampos[14] + '|' + gCampos[15] + '|' +
                                                gCampos[16] + '|' + gCampos[17] + '|' + gCampos[18] + '|' + gCampos[19] + '|');
                                END;
                                UpdateWindows(1, CountRecords, TotalRecords);
                            UNTIL gGLAccount.NEXT = 0;
                    end;
            end
        end;

        procedure CreateFileEBookFromInvBalBooks()
        var
            MyLineText: Text[1024];
            MySeparator: Text[10];
            TotalRecords: Integer;
            CountRecords: Integer;
            IsExistsFile: Boolean;
        begin
            CreateTempFile();
            CountRecords := 0;
            MySeparator := '|';
            case BookCode of
                '317':
                    begin
                        with GenJnlBookBuffer do begin
                            Reset();
                            if BookCode = '501' then
                                SetCurrentKey("G/L Account No.", "Posting Date");
                            if BookCode = '601' then
                                SetCurrentKey("Posting Date", "Transaction No.");
                            TotalRecords := Count;
                            if FindFirst() then
                                repeat
                                    MyLineText := '';
                                    CountRecords += 1;
                                    IsExistsFile := true;
                                    MyLineText += Period + MySeparator;//Field 01
                                    MyLineText += Format("Transaction CUO") + MySeparator;//Field 02
                                    MyLineText += "Correlative cuo" + MySeparator;//Field 03
                                    MyLineText += "G/L Account No." + MySeparator;//Field 04
                                    MyLineText += "Unit Operation Code" + MySeparator;//Field 05
                                    MyLineText += "Center Cost Code" + MySeparator;//Field 06
                                    MyLineText += "Currency Code" + MySeparator;//Field 07
                                    MyLineText += "VAT Registration Type" + MySeparator;//Field 08
                                    MyLineText += "VAT Registration No." + MySeparator;//Field 09
                                    MyLineText += "Legal Document No." + MySeparator;//Field 10
                                    MyLineText += "Serie Document" + MySeparator;//Field 11
                                    MyLineText += "Number Document" + MySeparator;//Field 12
                                    MyLineText += Format("Account Date", 0, '<Day,2>/<Month,2>/<Year4>') + MySeparator;//Field 13
                                    MyLineText += Format("Due Date", 0, '<Day,2>/<Month,2>/<Year4>') + MySeparator;//Field 14
                                    MyLineText += Format("Operation Date", 0, '<Day,2>/<Month,2>/<Year4>') + MySeparator;//Field 15
                                    MyLineText += "Gloss and description" + MySeparator;//Field 16
                                    MyLineText += "Gloss an description ref." + MySeparator;//Field 17
                                    MyLineText += Format("Debit Amount", 0, '<Precision,2:2><Standard Format,2>') + MySeparator;//Field 18
                                    MyLineText += Format("Credit Amount", 0, '<Precision,2:2><Standard Format,2>') + MySeparator;//Field 19
                                    MyLineText += MySeparator;//Field 20
                                    MyLineText += Format("Operation Status") + MySeparator;//Field 21
                                    MyLineText += "Free Field";//Field 22
                                    InsertLineToTempFile(MyLineText);
                                    UpdateWindows(2, CountRecords, TotalRecords);
                                until Next() = 0;
                        end;
                    end;
            end;
            if IsExistsFile then
                PostFileToControlFileRecord();
        end;


        local procedure CreateTempFile()
        begin
            TempFileBlob.CreateOutStream(ConstrutOutStream, TextEncoding::UTF8);
        end;

        procedure PostFileToControlFileRecord()
        var
            CompInf: Record "Company Information";
            ControlFile: Record "ST Control File";
            NewFileInStream: InStream;
            FileName: Text;
            FileExt: Text;
            FinalExtension: Text;
            EntryNo: Integer;
            ConfirmDownload: Label 'Do you want to download the following file?', Comment = 'ESM="¿Quieres descargar el siguiente archivo?"';
        begin
            CompInf.Get();
            TempFileBlob.CreateInStream(NewFileInStream);
            if TempFileBlob.HasValue() then
                FinalExtension := '00071111'
            else
                FinalExtension := '00071011';
            if BookCode = '317' then
                FileName := 'LE' + CompInf."VAT Registration No." + Format(EndDate, 0, '<Year4><Month,2>00') + BookCode + FinalExtension
            else
                FileName := 'LE' + CompInf."VAT Registration No." + Format(EndDate, 0, '<Year4><Month,2>000') + BookCode + FinalExtension;

            FileExt := 'txt';
            EntryNo := ControlFile.CreateControlFileRecord(BookCode, FileName, FileExt, StartDate, EndDate, NewFileInStream);
            if EntryNo <> 0 then
                if Confirm(ConfirmDownload, false) then begin
                    ControlFile.Get(EntryNo);
                    ControlFile.DownLoadFile(ControlFile);
                end;
        end;

        local procedure SetDate(): Boolean
        var
            SetDateToBook: Page "Set Date to Book";
        begin
            Clear(SetDateToBook);
            SetDateToBook.SetBookCode(BookCode);
            if SetDateToBook.RunModal() in [Action::LookupOK, Action::OK, Action::Yes] then begin
                SetDateToBook.SetFilterDate(StartDate, EndDate);
                exit(true);
            end;
            exit(false);
        end;

        procedure SetDate(pStartDate: Date; pEndDate: Date)
        begin
            StartDate := pStartDate;
            EndDate := pEndDate;
            NotRequestDate := true;
        end;

        local procedure CheckDateExists(): Boolean
        begin
            if (StartDate = 0D) or (EndDate = 0D) then
                Message(CheckDateExistsMessage);
            if EndDate > CalcDate('<+CM>', StartDate) then
                Message(ErrorSelectedDate);
            exit(not (StartDate = 0D) or (EndDate = 0D) or (EndDate > CalcDate('<+CM>', StartDate)));
        end;

        var
            StartDate: Date;
            EndDate: Date;
            BookCode: Code[10];
            NotRequestDate: Boolean;
            Windows: Dialog;
            ConstrutOutStream: OutStream;
            TempFileBlob: Codeunit "Temp Blob";
            Processing: Label 'Processing  #1#######################\', Comment = 'ESM="Procesando  #1#######################\"';
            CreatingFile: Label 'CreatingFile  #2#######################\', Comment = 'ESM="Creando archivo  #2#######################\"';
            CheckDateExistsMessage: Label 'Enter Start Date and End Date to continue.', Comment = 'ESM="Ingrese la fecha de inicio y fin para continuar."';
            ErrorSelectedDate: Label 'You can only generate the Electronic Book for one period at a time.', Comment = 'ESM="Solo puede generar un libro electrónico por periodo"';
            */
}