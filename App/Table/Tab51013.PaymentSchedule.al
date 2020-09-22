table 51013 "Payment Schedule"
{
    DataClassification = ToBeClassified;
    Caption = 'Payment Schedule';

    fields
    {
        field(51001; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
        }
        field(51002; "VAT Registration No."; code[12])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Registration No.';
        }
        field(51003; "External Document No."; code[35])
        {
            DataClassification = ToBeClassified;
            Caption = 'External Document No.';
        }
        field(51004; "Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Date';
        }

        field(51005; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        field(51006; "Delay Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Delay Days';
        }
        field(51007; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Currency Code';
        }
        field(51008; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(51009; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount LCY';
        }
        field(51010; "Total a Pagar"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total a Pagar';
            trigger OnValidate();
            begin
                if ABS("Total a Pagar") > ABS(Amount) THEN
                    Error('El Monto a Pagar no puede exceder al "Importe", ¡Revisar!');

                if "Total a Pagar" > 0 THEN
                    "Total a Pagar" := ("Total a Pagar" * -1);
            end;
        }
        field(51011; "Preferred Bank Account Code"; code[45])
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred Bank Account Code';
            trigger OnValidate();
            begin
                CASE "Type Source" OF
                    "Type Source"::"Customer Entries":
                        begin
                            CustBankAccount.Reset();
                            CustBankAccount.SetRange("Customer No.", "VAT Registration No.");
                            CustBankAccount.SetRange(Code, "Preferred Bank Account Code");
                            if CustBankAccount.FindFirst() then begin
                                "Reference Bank Acc. No." := CustBankAccount."Reference Bank Acc. No.";
                                "Bank Account No." := CustBankAccount."Bank Account No.";
                                "Is Payment Check" := CustBankAccount."Bank Type Check";
                            end else begin
                                "Reference Bank Acc. No." := '-';
                                "Bank Account No." := '-';
                                "Is Payment Check" := false;
                            end;
                        end;
                    "Type Source"::"Vendor Entries":
                        begin
                            VendBankAccount.Reset();
                            VendBankAccount.SetRange("Vendor No.", "VAT Registration No.");
                            VendBankAccount.SetRange(Code, "Preferred Bank Account Code");
                            if VendBankAccount.FindFirst() then begin
                                "Reference Bank Acc. No." := VendBankAccount."Reference Bank Acc. No.";
                                "Bank Account No." := VendBankAccount."Bank Account No.";
                                "Is Payment Check" := VendBankAccount."Bank Type Check";
                            end else begin
                                "Reference Bank Acc. No." := '-';
                                "Bank Account No." := '-';
                                "Is Payment Check" := false;
                            end;
                        end;
                    "Type Source"::"Employee Entries":
                        begin
                            if EmplBankAccount.Get("VAT Registration No.", "Preferred Bank Account Code") then begin
                                "Reference Bank Acc. No." := EmplBankAccount."Payment Bank Account No.";
                                "Bank Account No." := EmplBankAccount."Bank Account No.";
                                "Is Payment Check" := EmplBankAccount."Bank Type Check";
                            end else begin
                                "Reference Bank Acc. No." := '-';
                                "Bank Account No." := '-';
                                "Is Payment Check" := false;
                            end;
                        end;
                end;
            end;
        }
        field(51012; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = Pendiente,Procesado,"Por Pagar",Pagado;

        }
        field(51013; "Calculate Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculate Date';
        }
        field(51014; "Document No."; Code[90])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';
        }
        field(51015; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Date';
        }
        field(51016; "Bank Account No."; Code[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account No.';
        }
        field(51017; "Reference Bank Acc. No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference Bank';
            trigger OnValidate()
            begin
                CheckPermissionReferenceBankNo();
            end;

            trigger OnLookup()
            var
                SLSetupMgt: Codeunit "Setup Localization";
                MyCurrencyCode: Code[10];
                RestricteBankAccList: Page "ST Restrict Bank Account List";
                BankAcc: Record "Bank Account";
            begin
                if Status <> Status::Pendiente then
                    exit;
                CheckPermissionReferenceBankNo();
                Clear(RestricteBankAccList);
                BankAcc.Reset();
                BankAcc.SetRange("Currency Code", "Currency Code");
                RestricteBankAccList.LookupMode(true);
                RestricteBankAccList.Editable(false);
                RestricteBankAccList.SetTableView(BankAcc);
                RestricteBankAccList.SetRecord(BankAcc);
                if RestricteBankAccList.RunModal() in [Action::LookupOK, Action::OK, Action::Yes] then begin
                    RestricteBankAccList.GetRecord(BankAcc);
                    "Reference Bank Acc. No." := BankAcc."No.";
                end;
            end;
        }
        field(51018; "Document No. Post"; Code[35])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No. Post';
        }
        field(51019; "Source Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Entry No.';
        }
        field(51020; "Type Source"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type Source';
            OptionMembers = "Vendor Entries","Customer Entries","Employee Entries";
        }
        field(51021; "Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Group';
        }
        field(51022; "Process Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Process Date';
        }
        field(51023; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Date';
        }
        field(51024; "Payment Terms Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(51025; "Vend./Cust. Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vend./Cust. Account No.';
        }
        field(51026; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Date';
        }
        field(51027; "Process Date 2"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Process Date 2';
        }
        field(51028; "Business Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Business Name';
        }
        field(51029; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(51030; "Original Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Original Amount';
        }
        field(51031; "Service Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Type';
        }
        field(51032; "Description Service"; Text[90])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description Service';
        }
        field(51033; "% Detraction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = '% Detraction';
        }
        field(51034; "Operation Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Operation Type';
        }
        field(51035; "Description OP."; Text[90])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description OP.';
        }
        field(51036; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Assigned User ID';
            TableRelation = User;
        }
        field(51037; "Setup Source Code"; Enum "ST Source Code Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Code ULN';
        }
        field(51038; "Source User Id."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Source User Id.';

        }
        field(51039; "Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(51040; "Is Payment Check"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is Payment Check';
            //TableRelation = "Payment Method";
        }
    }
    keys
    {
        key(PrimaryKey; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        CustBankAccount: Record "Customer Bank Account";
        VendBankAccount: Record "Vendor Bank Account";
        EmplBankAccount: Record "ST Employee Bank Account";
    //Msg: TextConst ENU = 'Hello from my method';

    trigger OnInsert();
    begin

    end;

    local procedure CheckPermissionReferenceBankNo()
    var
        Cust: Record Customer;
        Vend: Record Vendor;
        Empl: Record Employee;
    begin
        case "Type Source" of
            "Type Source"::"Customer Entries":
                begin
                    Cust.Get("VAT Registration No.");
                    if (Cust."Preferred Bank Account Code" = '') and
                        (Cust."Preferred Bank Account Code ME" = '') then
                        Cust.TestField("Preferred Bank Account Code");
                end;
            "Type Source"::"Vendor Entries":
                begin
                    Vend.Get("VAT Registration No.");
                    if (Vend."Preferred Bank Account Code" = '') and
                        (Vend."Preferred Bank Account Code ME" = '') then
                        Vend.TestField("Preferred Bank Account Code");
                end;
            "Type Source"::"Employee Entries":
                begin
                    Empl.Get("VAT Registration No.");
                    if (Empl."Preferred Bank Account Code MN" = '') and
                        (Empl."Preferred Bank Account Code ME" = '') then
                        Empl.TestField("Preferred Bank Account Code MN");
                end;
        end;
    end;

    procedure fnCreateJnlLine(pJournalTemplateName: Code[20]; pJournalBatchName: Code[20]; pGrupDetrac: Code[30]; pDetrac: Boolean)
    var
        SLSetup: Record "Setup Localization";
        lcRecGenJnlBatch: Record "Gen. Journal Batch";
        lcRecGenJnllLine: Record "Gen. Journal Line";
        lcRecBankAccount: Record "Bank Account";
        lcRecVendorBankAccount: Record "Vendor Bank Account";
        lcRecVendor: Record Vendor;
        Employee: Record Employee;
        lcCuNoSeriesMgt: Codeunit "NoSeriesManagement";
        lcCuGenJnlManagement: Codeunit "GenJnlManagement";
        lcLineNo: Integer;
        lcAppliedTotalAmount: Decimal;
        lcDocumentNo: Code[20];
        lclAmountUSD: Decimal;
        lclAmountSoles: Decimal;
        lclLineasUSD: Boolean;
        lclLineasSOL: Boolean;
        lcFilterVendorBankAccount: Code[250];
        lcText0002: label 'Cronograma Pago  %1';
    begin
        if pDetrac then begin
            lcRecGenJnlBatch.Get(pJournalTemplateName, 'DETRAC');
            lcRecGenJnlBatch.TestField(Name);
            //Verificar si existe generado las Lineas en el diario
            if CheckIfExistsGenJnlLine(pJournalTemplateName, 'DETRAC') THEN
                EXIT;
        end else begin
            lcRecGenJnlBatch.Get(pJournalTemplateName, pJournalBatchName);
            lcRecGenJnlBatch.TestField(Name);
            //Verificar si existe generado las Lineas en el diario
            if CheckIfExistsGenJnlLine(pJournalTemplateName, pJournalBatchName) THEN
                EXIT;
        end;

        lcLineNo := 0;
        lcAppliedTotalAmount := 0;
        if lcRecGenJnlBatch."No. Series" <> '' then begin
            CLEAR(lcCuNoSeriesMgt);
            lcDocumentNo := lcCuNoSeriesMgt.TryGetNextNo(lcRecGenJnlBatch."No. Series", WorkDate);
        end;

        //--
        lclLineasUSD := false;
        lclLineasSOL := false;

        fnCorrectedJnlLine(pJournalTemplateName, pJournalBatchName, pGrupDetrac, pDetrac);

        //++ begin ULN::RRR 21/12/2018
        PaymentSchedule.Reset();
        PaymentSchedule.SetFilter(Status, '%1|%2',
             PaymentSchedule.Status::Procesado,
             PaymentSchedule.Status::"Por Pagar");
        CASE true OF
            (pJournalBatchName = 'DETRAC'):
                begin
                    PaymentSchedule.SetRange("Posting Group", pGrupDetrac);
                    PaymentSchedule.SetRange("Is Payment Check", false);
                end;
            (pJournalBatchName <> 'DETRAC') and (not IsBatchCheck) and (lcRecGenJnlBatch."Bank Account No. FICO" <> ''):
                begin
                    PaymentSchedule.SetRange("Reference Bank Acc. No.", lcRecGenJnlBatch."Bank Account No. FICO");
                    PaymentSchedule.SetRange("Is Payment Check", false);
                    PaymentSchedule.SetFilter("Posting Group", '<>%1', pGrupDetrac);
                end;
            (pJournalBatchName <> 'DETRAC') and (IsBatchCheck):
                begin
                    PaymentSchedule.SetRange("Is Payment Check", true);
                    PaymentSchedule.SetFilter("Posting Group", '<>%1', pGrupDetrac);
                end;
        end;

        if PaymentSchedule.ISEMPTY THEN
            Error('No tiene movimentos pendientes.');
        //++ end ULN::RRR 21/12/2018

        if PaymentSchedule.FINDSET THEN
            REPEAT
                lcLineNo += 10000;
                lcRecGenJnllLine.Init();
                lcRecGenJnllLine."Journal Template Name" := lcRecGenJnlBatch."Journal Template Name";

                //--------------------
                if pDetrac then
                    lcRecGenJnllLine."Journal Batch Name" := 'DETRAC'
                else
                    lcRecGenJnllLine."Journal Batch Name" := lcRecGenJnlBatch.Name;
                lcRecGenJnllLine."Copy VAT Setup to Jnl. Lines" := lcRecGenJnlBatch."Copy VAT Setup to Jnl. Lines";

                lcRecGenJnllLine."Line No." := lcLineNo;
                lcRecGenJnllLine."Document No." := lcDocumentNo;


                case PaymentSchedule."Type Source" of
                    PaymentSchedule."Type Source"::"Vendor Entries":
                        lcRecGenJnllLine.Validate("Account Type", lcRecGenJnllLine."Account Type"::Vendor);
                    PaymentSchedule."Type Source"::"Customer Entries":
                        lcRecGenJnllLine.Validate("Account Type", lcRecGenJnllLine."Account Type"::Customer);
                    PaymentSchedule."Type Source"::"Employee Entries":
                        lcRecGenJnllLine.Validate("Account Type", lcRecGenJnllLine."Account Type"::Employee);
                end;

                lcRecGenJnllLine.Validate("Account No.", PaymentSchedule."VAT Registration No.");
                lcRecGenJnllLine.Validate("Posting Date", WorkDate);

                //------------------------------------------
                case PaymentSchedule."Type Source" of
                    PaymentSchedule."Type Source"::"Vendor Entries":
                        begin
                            recVendorLedgerEntry.Reset();
                            recVendorLedgerEntry.SetRange("Entry No.", PaymentSchedule."Source Entry No.");
                            if recVendorLedgerEntry.FindFirst() then begin
                                AppliedDocumentNo := recVendorLedgerEntry."Document No.";
                            end;


                            VendLedgEntry.Reset();
                            VendLedgEntry.SetRange("Entry No.", PaymentSchedule."Source Entry No.");
                            VendLedgEntry.SetRange(Open, true);
                            if VendLedgEntry.COUNT = 0 THEN
                                Error(Text0004, AppliedDocumentNo);

                            //ApplyVendorEntries.SetGenJnlLine(lcRecGenJnllLine, lcRecGenJnllLine.FIELDNO("Applies-to Doc. No."));
                            //ApplyVendorEntries.SETTABLEVIEW(VendLedgEntry);
                            //VendLedgEntry.FINDSET;
                            //VendLedgEntry.CALCFIELDS("Remaining Amount");
                            //ApplyVendorEntries.fnExternalOpen;
                            //-----
                            //ApplyVendorEntries.fnExternalQueryClose(VendLedgEntry);
                            //-----
                            VendLedgEntry.FindFirst();

                            //lcRecGenJnllLine.SetAmountWithVendLedgEntry;
                            lcRecGenJnllLine."Applies-to Doc. Type" := VendLedgEntry."Document Type";
                            lcRecGenJnllLine."Applies-to Doc. No." := VendLedgEntry."Document No.";
                            lcRecGenJnllLine."Posting Group" := VendLedgEntry."Vendor Posting Group";
                            lcRecGenJnllLine."Source Currency Factor" := VendLedgEntry."Source Currency Factor";
                            lcRecGenJnllLine."External Document No." := VendLedgEntry."External Document No.";
                            lcRecGenJnllLine."Dimension Set ID" := VendLedgEntry."Dimension Set ID";
                            lcRecGenJnllLine."Shortcut Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
                            lcRecGenJnllLine."Shortcut Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
                            lcRecGenJnllLine."Applies-to Entry No." := VendLedgEntry."Entry No.";
                            lcRecVendor.Get(VendLedgEntry."Vendor No.");
                            lcRecGenJnllLine."Check Name" := lcRecVendor.Name;
                            //++ begin ULN::RRR  002     2018.01.30    v.001
                            //VendLedgEntry.CALCFIELDS("Vendor Name");
                            lcRecGenJnllLine.Description := VendLedgEntry.Description;

                            if (PaymentSchedule."Currency Code" = '') OR (lcRecVendor."Preferred Bank Account Code ME" = '') THEN
                                lcRecGenJnllLine."Recipient Bank Account" := lcRecVendor."Preferred Bank Account Code"
                            else
                                lcRecGenJnllLine."Recipient Bank Account" := lcRecVendor."Preferred Bank Account Code ME";

                            if lcRecGenJnllLine."Posting Text" = '' THEN
                                lcRecGenJnllLine."Posting Text" := VendLedgEntry."Posting Text";
                            if lcRecGenJnllLine."Posting Text" = '' THEN
                                lcRecGenJnllLine."Posting Text" := VendLedgEntry."Vendor Name";
                            lcRecGenJnllLine."Payment Method Code" := PaymentSchedule."Payment Method Code";
                            //++ end ULN::RRR  002     2018.01.30    v.001
                            //--
                            lcRecGenJnllLine.Validate("Currency Code", PaymentSchedule."Currency Code");
                            lcRecGenJnllLine.Validate(Amount, PaymentSchedule."Total a Pagar");
                            lcRecGenJnllLine.Validate(Amount, PaymentSchedule."Total a Pagar" * -1);

                            //lcRecGenJnllLine.Description := STRSUBSTNO(lcText0001) +' ' + PaymentSchedule."Nro Comprobante" ;//ULN::RRR  002     2018.01.30    v.001
                        end;
                    PaymentSchedule."Type Source"::"Customer Entries":
                        begin
                            CustLEdgerEntry2.Reset();
                            CustLEdgerEntry2.SetRange("Entry No.", PaymentSchedule."Source Entry No.");
                            if CustLEdgerEntry2.FINDFIRST then begin
                                AppliedDocumentNo := CustLEdgerEntry2."Document No.";
                            end;


                            CustLedgerEntry.Reset();
                            CustLedgerEntry.SetRange("Entry No.", PaymentSchedule."Source Entry No.");
                            CustLedgerEntry.SetRange(Open, true);
                            if CustLedgerEntry.COUNT = 0 THEN
                                Error(Text0004, AppliedDocumentNo);

                            ApplyCustomerEntries.SetGenJnlLine(lcRecGenJnllLine, lcRecGenJnllLine.FIELDNO("Applies-to Doc. No."));
                            ApplyCustomerEntries.SETTABLEVIEW(CustLedgerEntry);
                            CustLedgerEntry.FINDSET;
                            CustLedgerEntry.CALCFIELDS("Remaining Amount");
                            ApplyCustomerEntries.fnExternalOpen;
                            //-----
                            ApplyCustomerEntries.fnExternalCustomerQueryClose(CustLedgerEntry);
                            //-----
                            //lcRecGenJnllLine.SetAmountWithVendLedgEntry;
                            lcRecGenJnllLine."Applies-to Doc. Type" := CustLedgerEntry."Document Type";
                            lcRecGenJnllLine."Applies-to Doc. No." := CustLedgerEntry."Document No.";
                            lcRecGenJnllLine."Posting Group" := CustLedgerEntry."Customer Posting Group";
                            lcRecGenJnllLine."Source Currency Factor" := CustLedgerEntry."Source Currency Factor";
                            lcRecGenJnllLine."External Document No." := CustLedgerEntry."External Document No.";
                            lcRecGenJnllLine."Dimension Set ID" := CustLedgerEntry."Dimension Set ID";
                            lcRecGenJnllLine."Shortcut Dimension 1 Code" := CustLedgerEntry."Global Dimension 1 Code";
                            lcRecGenJnllLine."Shortcut Dimension 2 Code" := CustLedgerEntry."Global Dimension 2 Code";
                            lcRecGenJnllLine."Applies-to Entry No." := CustLedgerEntry."Entry No.";
                            lcRecGenJnllLine."Check Name" := CustLedgerEntry.Description;
                            //++ begin ULN::RRR  002     2018.01.30    v.001

                            if lcRecGenJnllLine."Posting Text" = '' THEN
                                lcRecGenJnllLine."Posting Text" := CustLedgerEntry."Posting Text";
                            if lcRecGenJnllLine."Posting Text" = '' THEN
                                lcRecGenJnllLine."Posting Text" := CustLedgerEntry.Description;
                            lcRecGenJnllLine.Description := CustLedgerEntry."Customer Name";
                            lcRecGenJnllLine."Payment Method Code" := PaymentSchedule."Payment Method Code";
                            //++ end ULN::RRR  002     2018.01.30    v.001

                            lcRecGenJnllLine.Validate(Amount, PaymentSchedule."Total a Pagar" * -1);//ULN::RRR  002     2018.01.30    v.001
                        end;
                    PaymentSchedule."Type Source"::"Employee Entries":
                        begin
                            EmplLedgerEntry.Reset();
                            EmplLedgerEntry.SetRange("Entry No.", PaymentSchedule."Source Entry No.");
                            if EmplLedgerEntry.FindFirst() then
                                AppliedDocumentNo := EmplLedgerEntry."Document No.";

                            EmplLedgerEntry.Reset();
                            EmplLedgerEntry.SetRange("Entry No.", PaymentSchedule."Source Entry No.");
                            EmplLedgerEntry.SetRange(Open, true);
                            if EmplLedgerEntry.COUNT = 0 THEN
                                Error(Text0004, AppliedDocumentNo);

                            EmplLedgerEntry.FindFirst();

                            lcRecGenJnllLine."Applies-to Doc. Type" := EmplLedgerEntry."Document Type";
                            lcRecGenJnllLine."Applies-to Doc. No." := EmplLedgerEntry."Document No.";
                            lcRecGenJnllLine."Posting Group" := EmplLedgerEntry."Employee Posting Group";
                            lcRecGenJnllLine."Source Currency Factor" := EmplLedgerEntry."Source Currency Factor";
                            lcRecGenJnllLine."External Document No." := EmplLedgerEntry."External Document No.";
                            lcRecGenJnllLine."Dimension Set ID" := EmplLedgerEntry."Dimension Set ID";
                            lcRecGenJnllLine."Shortcut Dimension 1 Code" := EmplLedgerEntry."Global Dimension 1 Code";
                            lcRecGenJnllLine."Shortcut Dimension 2 Code" := EmplLedgerEntry."Global Dimension 2 Code";
                            lcRecGenJnllLine."Applies-to Entry No." := EmplLedgerEntry."Entry No.";
                            Employee.Get(EmplLedgerEntry."Employee No.");
                            lcRecGenJnllLine."Check Name" := CopyStr(Employee.FullName(), 1, 100);
                            //++ begin ULN::RRR  002     2018.01.30    v.001
                            //EmplLedgerEntry.CALCFIELDS("Vendor Name");
                            lcRecGenJnllLine.Description := EmplLedgerEntry.Description;

                            if (PaymentSchedule."Currency Code" = '') OR (Employee."Preferred Bank Account Code ME" = '') THEN
                                lcRecGenJnllLine."Recipient Bank Account" := Employee."Preferred Bank Account Code MN"
                            else
                                lcRecGenJnllLine."Recipient Bank Account" := Employee."Preferred Bank Account Code ME";

                            if lcRecGenJnllLine."Posting Text" = '' THEN
                                lcRecGenJnllLine."Posting Text" := EmplLedgerEntry."Posting Text";
                            if lcRecGenJnllLine."Posting Text" = '' THEN
                                lcRecGenJnllLine."Posting Text" := Employee.FullName();
                            lcRecGenJnllLine."Payment Method Code" := PaymentSchedule."Payment Method Code";
                            //++ end ULN::RRR  002     2018.01.30    v.001
                            //--
                            lcRecGenJnllLine.Validate("Currency Code", PaymentSchedule."Currency Code");
                            lcRecGenJnllLine.Validate(Amount, PaymentSchedule."Total a Pagar");
                            lcRecGenJnllLine.Validate(Amount, PaymentSchedule."Total a Pagar" * -1);

                            //lcRecGenJnllLine.Description := STRSUBSTNO(lcText0001) +' ' + PaymentSchedule."Nro Comprobante" ;//ULN::RRR  002     2018.01.30    v.001
                        end;
                end;

                //-----------------------
                lcRecGenJnllLine."Posting No. Series" := lcRecGenJnlBatch."Posting No. Series";

                //lcAppliedTotalAmount += PaymentSchedule."Total a Pagar";//PaymentSchedule.Importe;
                //++ begin ULN::RRR 
                if not IsBatchCheck THEN
                    lcAppliedTotalAmount += PaymentSchedule."Total a Pagar"
                else begin
                    lcRecBankAccount.Reset();
                    lcRecBankAccount.SetRange("Is Check Bank", true);
                    lcRecBankAccount.SetRange("Currency Code", PaymentSchedule."Currency Code");
                    lcRecBankAccount.Find('-');
                    lcRecGenJnllLine.Validate("Bal. Account Type", lcRecGenJnllLine."Bal. Account Type"::"Bank Account");
                    lcRecGenJnllLine.Validate("Bal. Account No.", lcRecBankAccount."No.");
                    lcRecGenJnllLine.Validate("Bank Payment Type", lcRecGenJnllLine."Bank Payment Type"::"Computer Check");
                end;

                //--ACOMULADOR SOLES & DOLARES
                lclAmountUSD += PaymentSchedule."Total a Pagar"; //PaymentSchedule.Importe;
                lclAmountSoles += lcRecGenJnllLine."Amount (LCY)";

                if lcRecGenJnllLine."Currency Code" = 'USD' THEN
                    lclLineasUSD := true;
                if lcRecGenJnllLine."Currency Code" = '' THEN
                    lclLineasSOL := true;
                //---------

                //Adicional
                lcRecGenJnllLine."Setup Source Code" := lcRecGenJnllLine."Setup Source Code"::"Payment Schedule";
                lcRecGenJnllLine."ST Control Entry No." := PaymentSchedule."Entry No.";
                //--PROCESO ORIGEN   
                //begin ULN::RHF 003 (++) 
                fnProcessOrigen(PaymentSchedule, lcRecGenJnllLine);
                //end ULN::RHF 003(++)
                //---------
                lcRecGenJnllLine.Insert(true);
                //lcRecGenJnllLine.fnSetSourceCode;

                //---una vez generado al diario se cambia el estado a "Por Pagar"
                PaymentSchedule.Status := PaymentSchedule.Status::"Por Pagar";
                PaymentSchedule.MODIFY;
            //
            UNTIL PaymentSchedule.NEXT = 0;


        if (lcAppliedTotalAmount <> 0) and (not IsBatchCheck) then begin
            lcLineNo += 10000;
            lcRecGenJnllLine.INIT;
            lcRecGenJnllLine."Journal Template Name" := lcRecGenJnlBatch."Journal Template Name";

            if pDetrac then
                lcRecGenJnllLine."Journal Batch Name" := 'DETRAC'
            else
                lcRecGenJnllLine."Journal Batch Name" := lcRecGenJnlBatch.Name;

            lcRecGenJnllLine."Copy VAT Setup to Jnl. Lines" := lcRecGenJnlBatch."Copy VAT Setup to Jnl. Lines";

            lcRecGenJnllLine."Line No." := lcLineNo;
            lcRecGenJnllLine."Document No." := lcDocumentNo;
            lcRecGenJnllLine.Validate("Account Type", lcRecGenJnllLine."Account Type"::"Bank Account");

            CASE true OF
                (pDetrac) and (not IsBatchCheck):
                    begin
                        lcRecGenJnllLine.Validate("Account No.", '');
                        lcRecGenJnllLine."Posting Date" := WorkDate;
                        lcRecGenJnllLine."Due Date" := WorkDate;
                    end;
                (not pDetrac) and (IsBatchCheck):
                    begin
                        lcRecBankAccount.Reset();
                        lcRecBankAccount.SetRange("Is Check Bank", true);
                        lcRecBankAccount.FINDFIRST;
                        lcRecGenJnllLine.Validate("Account No.", lcRecBankAccount."No.");
                        lcRecGenJnllLine.Validate("Posting Date", WorkDate);
                    end else begin
                                lcRecGenJnlBatch.TestField("Bank Account No. FICO");
                                lcRecGenJnllLine.Validate("Account No.", lcRecGenJnlBatch."Bank Account No. FICO");
                                lcRecGenJnllLine.Validate("Posting Date", WorkDate);
                            end;
            end;

            //   if pDetrac then begin
            //     lcRecGenJnllLine.Validate("Account No.",'');
            //     lcRecGenJnllLine."Posting Date":= WorkDate;  
            //     lcRecGenJnllLine."Due Date"    := WorkDate;
            //   end else begin
            //     lcRecGenJnllLine.Validate("Account No.",lcRecGenJnlBatch.Name);
            //     lcRecGenJnllLine.Validate("Posting Date",WorkDate);  
            //   end;


            lcRecGenJnllLine."Posting No. Series" := lcRecGenJnlBatch."Posting No. Series";

            //--[SOLES]
            if ABS(lclAmountUSD) = ABS(lclAmountSoles) then begin
                //LINEAS EN SOLES Y BANCO EN DOLARES
                if lcRecGenJnllLine."Currency Code" = 'USD' then begin
                    lcAppliedTotalAmount := (lclAmountUSD / (1 / lcRecGenJnllLine."Currency Factor") * -1);

                    //LINEAS EN SOLES Y BANCO EN SOLES
                end else
                    if lcRecGenJnllLine."Currency Code" = '' then begin
                        lcAppliedTotalAmount := (lclAmountSoles * -1);
                    end;

                //--[LINEAS SOLO DOLARES Y LINEAS COMBINADAS DOLARES&SOLES]
            end else begin
                //--LINEAS COMBINADAS DOLARES&SOLES
                if (lclLineasUSD = true) and (lclLineasSOL = true) then begin
                    //BANCO EN DOLARES 
                    if lcRecGenJnllLine."Currency Code" = 'USD' then begin
                        lcAppliedTotalAmount := (lclAmountSoles / (1 / lcRecGenJnllLine."Currency Factor") * -1);

                        //BANCO EN SOLES
                    end else
                        if lcRecGenJnllLine."Currency Code" = '' then begin
                            lcAppliedTotalAmount := (lclAmountSoles * -1);
                        end;

                    //--LINEAS SOLO DOLARES
                end else begin
                    //LINEAS EN DOLARES Y BANCO EN DOLARES 
                    if lcRecGenJnllLine."Currency Code" = 'USD' then begin
                        lcAppliedTotalAmount := (lclAmountUSD * -1);

                        //LINEAS EN DOLARES Y BANCO EN SOLES
                    end else
                        if lcRecGenJnllLine."Currency Code" = '' then begin
                            lcAppliedTotalAmount := (lclAmountSoles * -1);
                        end;
                end;
            end;

            //--
            if lcAppliedTotalAmount > 0 THEN
                lcAppliedTotalAmount := lcAppliedTotalAmount * -1;

            lcRecGenJnllLine.Validate(Amount, lcAppliedTotalAmount);

            //--
            lcRecGenJnllLine.Description := STRSUBSTNO(lcText0002, lcRecGenJnllLine."Source No.");
            lcRecGenJnllLine."External Document No." := PaymentSchedule."Document No.";
            //Adicional
            lcRecGenJnllLine."Setup Source Code" := lcRecGenJnllLine."Setup Source Code"::"Payment Schedule";
            //lcRecGenJnllLine."ST Control Entry No." := PaymentSchedule."Entry No.";
            //----------------------
            lcRecGenJnllLine.Insert(true);
            //lcRecGenJnllLine.fnSetSourceCode;

        end;


        if lcLineNo <> 0 THEN
            lcCuGenJnlManagement.TemplateSelectionFromBatch(lcRecGenJnlBatch);
    end;

    local procedure CheckIfExistsGenJnlLine(JournalTemplateName: Code[10]; JournalBatchName: Code[10]): Boolean
    var
        GenJnlLine: Record "Gen. Journal Line";
        MsgExistJournal: Label 'Existen registros en el diario, revisar información para evitar Errores';
        SeeHere: Label 'Ver Diario';
    begin
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJnlLine.FindSet() then begin
            Parameter[1] := 'TemplateName';
            ParameterValue[1] := JournalTemplateName;
            Parameter[2] := 'BatchName';
            ParameterValue[2] := JournalBatchName;
            SLSetupMgt.AlertAndViewWhitNotification(MsgExistJournal, SeeHere, Codeunit::"Payment Schedule Utility", 'ViewTemplateBatch', Parameter, ParameterValue);
            exit(true);
        end;
        exit(false);
    end;

    procedure fnSetIsCheck(pIsBatchCheck: Boolean)
    begin
        IsBatchCheck := pIsBatchCheck;
    end;

    procedure fnCorrectedJnlLine(pJournalTemplateName: Code[20]; pJournalBatchName: Code[20]; pGrupDetrac: Code[30]; pDetrac: Boolean)
    var
        lcRecGLSetup: Record "General Ledger Setup";
        lcPgPaymentScheduleMPW: Page "Payment Schedule";
        lcRecGenJnlBatch: Record "Gen. Journal Batch";
        lcRecBankAccount: Record "Bank Account";
        lcRecVendorBankAccount: Record "Vendor Bank Account";
        lcRecVendor: Record Vendor;
        lcCuNoSeriesMgt: Codeunit "NoSeriesManagement";
        lcCuGenJnlManagement: Codeunit "GenJnlManagement";
        lcLineNo: Integer;
        lcAppliedTotalAmount: Decimal;
        lcDocumentNo: Code[20];
        lclAmountUSD: Decimal;
        lclAmountSoles: Decimal;
        lclLineasUSD: Boolean;
        lclLineasSOL: Boolean;
        lcFilterVendorBankAccount: Code[250];
    begin
        if pDetrac then begin
            lcRecGenJnlBatch.Get(pJournalTemplateName, 'DETRAC');
            lcRecGenJnlBatch.TestField(Name);
            //Verificar si existe generado las Lineas en el diario
            if CheckIfExistsGenJnlLine(pJournalTemplateName, 'DETRAC') THEN
                EXIT;
        end else begin
            lcRecGenJnlBatch.Get(pJournalTemplateName, pJournalBatchName);
            lcRecGenJnlBatch.TestField(Name);
            //Verificar si existe generado las Lineas en el diario
            if CheckIfExistsGenJnlLine(pJournalTemplateName, pJournalBatchName) THEN
                EXIT;
        end;

        //++ begin ULN::RRR 21/12/2018
        PaymentSchedule.Reset();
        PaymentSchedule.SetFilter(Status, '%1|%2',
             PaymentSchedule.Status::Procesado,
             PaymentSchedule.Status::"Por Pagar");
        CASE true OF
            (pJournalBatchName = 'DETRAC'):
                begin //and (not IsBatchCheck)
                    PaymentSchedule.SetRange("Posting Group", pGrupDetrac);
                    //PaymentSchedule.SetRange("Is Payment Check",false);
                end;
            (pJournalBatchName <> 'DETRAC') and (not IsBatchCheck) and (lcRecGenJnlBatch."Bank Account No. FICO" <> ''):
                begin
                    PaymentSchedule.SetRange("Reference Bank Acc. No.", lcRecGenJnlBatch."Bank Account No. FICO");
                    PaymentSchedule.SetRange("Is Payment Check", false);
                end;
            (pJournalBatchName <> 'DETRAC') and (IsBatchCheck):
                PaymentSchedule.SetRange("Is Payment Check", true);
        //(IsBatchCheck) : PaymentSchedule.SetRange("Is Payment Check",true);
        end;

        if PaymentSchedule.FINDSET THEN
            REPEAT
                CASE PaymentSchedule."Type Source" OF
                    PaymentSchedule."Type Source"::"Customer Entries":
                        begin
                            CustLedgerEntry.Reset();
                            CustLedgerEntry.SetRange("Entry No.", PaymentSchedule."Source Entry No.");
                            CustLedgerEntry.SetRange(Open, true);
                            PaymentSchedule.MARK(CustLedgerEntry.ISEMPTY);
                        end;
                    PaymentSchedule."Type Source"::"Vendor Entries":
                        begin
                            VendLedgEntry.Reset();
                            VendLedgEntry.SetRange("Entry No.", PaymentSchedule."Source Entry No.");
                            VendLedgEntry.SetRange(Open, true);
                            PaymentSchedule.MARK(VendLedgEntry.ISEMPTY);
                        end;
                end;
            UNTIL PaymentSchedule.NEXT = 0;

        PaymentSchedule.MARKEDONLY(true);

        if PaymentSchedule.COUNT = 0 THEN
            EXIT;
        //++ end ULN::RRR 21/12/2018
        CLEAR(lcPgPaymentScheduleMPW);
        lcPgPaymentScheduleMPW.fnSetViewActions(true);
        lcPgPaymentScheduleMPW.SETTABLEVIEW(PaymentSchedule);
        MESSAGE('Existen programaciones de pago con estado no pendiente. Se deben eliminar las siguiente programaciones.');
        lcPgPaymentScheduleMPW.RUNMODAL;
    end;



    procedure fnProcessOrigen(VAR pRecPaymentSchedule: Record "Payment Schedule"; VAR pRecGenJnlLine: Record "Gen. Journal Line")
    var
        lclProcesoOrigen: text[120];
    begin
        //begin ULN::RHF 003 (++)
        /*CASE pRecPaymentSchedule."Setup Source Code" OF
            pRecPaymentSchedule."Setup Source Code"::" ":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::" ";
            pRecPaymentSchedule."Setup Source Code"::"Alq Agua":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Alq Agua";
            pRecPaymentSchedule."Setup Source Code"::"Alq Arbit":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Alq Arbit";
            pRecPaymentSchedule."Setup Source Code"::"Alq Luz":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Alq Luz";
            pRecPaymentSchedule."Setup Source Code"::"Alq Mante":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Alq Mante";
            pRecPaymentSchedule."Setup Source Code"::"Alq Otros":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Alq Otros";
            pRecPaymentSchedule."Setup Source Code"::Alquiler:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::Alquiler;
            pRecPaymentSchedule."Setup Source Code"::Anticipo:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::Anticipo;
            pRecPaymentSchedule."Setup Source Code"::"Applied-To AGR":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Applied-To AGR";
            pRecPaymentSchedule."Setup Source Code"::"Applied-To Provision Extranet Vendors":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Setup Source Code"::"Applied-To Provision Extranet Vendors";
            pRecPaymentSchedule."Setup Source Code"::"Bounce AGR":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Bounce AGR";
            pRecPaymentSchedule."Setup Source Code"::"Carta Fianza Cab":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Carta Fianza Cab";
            pRecPaymentSchedule."Setup Source Code"::"Carta Fianza Det":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Carta Fianza Det";
            pRecPaymentSchedule."Setup Source Code"::"Compesation Leasing":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Compesation Leasing";
            //lcRecPaymentSchledule."Setup Source Code"::ControlAnticipo       : pRecGenJnlLine."Setup Source Code" := pRecGenJnlLine."Setup Source Code"::ControlAnticipo;
            pRecPaymentSchedule."Setup Source Code"::Cronograma:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::Cronograma;
            pRecPaymentSchedule."Setup Source Code"::Devolucion:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::Devolucion;
            pRecPaymentSchedule."Setup Source Code"::DirectPurchase:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::DirectPurchase;
            pRecPaymentSchedule."Setup Source Code"::"Fact Compra Masivo":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Fact Compra Masivo";
            pRecPaymentSchedule."Setup Source Code"::Garantia:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::Garantia;
            pRecPaymentSchedule."Setup Source Code"::Leasing:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::Leasing;
            pRecPaymentSchedule."Setup Source Code"::"Leasing-default":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Leasing-default";
            pRecPaymentSchedule."Setup Source Code"::"Leasing-Sure":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Leasing-Sure";
            pRecPaymentSchedule."Setup Source Code"::"Pagare Det":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Pagare Det";
            pRecPaymentSchedule."Setup Source Code"::"Payment AGR":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Payment AGR";
            pRecPaymentSchedule."Setup Source Code"::"Payment Refunds":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Payment Refunds";
            pRecPaymentSchedule."Setup Source Code"::Provision:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::Provision;
            pRecPaymentSchedule."Setup Source Code"::"Provision AGR":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Provision AGR";
            pRecPaymentSchedule."Setup Source Code"::"Provision Alquiler":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Provision Alquiler";
            pRecPaymentSchedule."Setup Source Code"::"Provision General":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Provision General";
            pRecPaymentSchedule."Setup Source Code"::"Provision Purch. Order Items":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Provision Purch. Order Items";
            pRecPaymentSchedule."Setup Source Code"::"Provision Purch. Order Service":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Provision Purch. Order Service";
            pRecPaymentSchedule."Setup Source Code"::"Provision Sales Order":
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::"Provision Sales Order";
            pRecPaymentSchedule."Setup Source Code"::Requisition:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::Requisition;
            pRecPaymentSchedule."Setup Source Code"::UpdArrendLeasing:
                pRecGenJnlLine."Process Source" := pRecGenJnlLine."Process Source"::UpdArrendLeasing;

        end;*/
        //begin ULN::RHF 003 (++)  

    end;

    var
        recVendorLedgerEntry: Record "Vendor Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLEdgerEntry2: Record "Cust. Ledger Entry";

        EmplLedgerEntry: Record "Employee Ledger Entry";
        EmplLedgerEntry2: Record "Employee Ledger Entry";
        ApplyVendorEntries: Page "Apply Vendor Entries";
        ApplyCustomerEntries: Page "Apply Customer Entries";
        PaymentSchedule: Record "Payment Schedule";
        SLSetupMgt: Codeunit "Setup Localization";
        IsBatchCheck: Boolean;
        AppliedDocumentNo: Code[70];
        Parameter: array[4] of Text;
        ParameterValue: array[4] of Text;
        Text0004: Label 'El documento %1 no se encuentra como pendiente.';
}