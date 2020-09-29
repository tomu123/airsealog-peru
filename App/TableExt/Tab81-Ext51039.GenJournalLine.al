tableextension 51039 "Setup Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        //Fields ids permission 51004..51005,51030..51039,,51045..51049,51050..51060
        //Legal Document Begin
        field(51000; "Legal Document"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Legal Document', Comment = 'ESM="Documento Legal"';
        }

        field(51001; "Legal Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Legal Status', Comment = 'ESM="Estado legal"';
            OptionMembers = Success,Anulled,OutFlow;
            OptionCaption = 'Success,Anulled,OutFlow', Comment = 'ESM="Normal,Anulado,Extornado"';
        }

        field(51002; "Legal Document Ref."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Legal Document Ref.', Comment = 'ESM="Documento Legal Ref."';
        }
        field(51003; "VAT Registration Type"; Code[2])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Registration Type', Comment = 'ESM="Tipo Doc. Identidad"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('02'));
            ValidateTableRelation = false;
        }
        //Legal Document End
        field(51004; "Applies-to Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to Entry No.', comment = 'ESM="Liq. por id. movimiento"';
            TableRelation = if ("Account Type" = const(Customer)) "Cust. Ledger Entry" where("Customer No." = field("Account No."), "Document No." = field("Applies-to Doc. No."), Open = const(true)) else
            if ("Account Type" = const(Vendor)) "Vendor Ledger Entry" where("Vendor No." = field("Account No."), "Document No." = field("Applies-to Doc. No."), Open = const(true)) else
            if ("Account Type" = const(Employee)) "Employee Ledger Entry" where("Employee No." = field("Account No."), "Document No." = field("Applies-to Doc. No."), Open = const(true));
            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                EmplLedgEntry: Record "Employee Ledger Entry";
            begin
                if "Applies-to Entry No." = 0 then
                    exit;
                case "Account Type" of
                    "Account Type"::Customer:
                        begin
                            CustLedgEntry.Get("Applies-to Entry No.");
                            Validate("Applies-to Doc. No.", CustLedgEntry."Document No.");
                        end;
                    "Account Type"::Vendor:
                        begin
                            VendLedgEntry.Get("Applies-to Entry No.");
                            Validate("Applies-to Doc. No.", VendLedgEntry."Document No.");
                        end;
                    "Account Type"::Employee:
                        begin
                            EmplLedgEntry.Get("Applies-to Entry No.");
                            Validate("Applies-to Doc. No.", EmplLedgEntry."Document No.");
                        end;
                end;
            end;
        }
        field(51005; "Posting Text"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Text', comment = 'ESM="Texto registro"';
            ;
            trigger
            OnValidate();
            var
                Character: Text;
                CharacterInvalid: Label 'Cannot enter the stick character "|" in the text field register for the correct display of electronic books.',
                 Comment = 'ESM="No se puede ingresar el caracter palote "|" en el campo texto registro por la correcta visualización de libros electronicos."';
            begin
                Character := '';
                Character := DelChr("Posting Text", '=', DELCHR("Posting Text", '=', '|'));
                IF StrLen(Character) <> 0 THEN
                    Error(CharacterInvalid);
            end;
        }
        field(51017; "Bulk Payment Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bulk Payment Type', comment = 'ESM="Tipo de pago masivo"';
        }
        field(51020; "Check Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Check Name', Comment = 'ESM="Nombre Cheque"';
        }
        field(51030; "Setup Source Code"; Enum "ST Source Code Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Code ULN', Comment = 'ESM="Cód. Origen proceso"';
        }
        field(51031; "Source Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Currency Factor', Comment = 'ESM="Factor divisa origen"';
        }
        field(51032; "ST Control Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Control Entry No.', Comment = 'ESM="N° Mov. Ref. Control"';
        }
        field(51033; "Source User Id."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Source User Id.', Comment = 'ESM="Id. Usuario Origen"';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(51034; "Ref. Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ref. Source type', Comment = 'ESM="Ref. Tipo de origen"';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset', comment = 'ESM=" ,Cliente,Proveedor,Banco,Activo Fijo"';
        }
        field(51035; "Ref. Source No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ref. Source No.', Comment = 'ESM="Ref. Cód. Origen"';
        }
        field(51036; "Ref. Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ref. Document No.', Comment = 'ESM="Ref. N° Documento"';
        }
        field(51037; "Payment Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Bank Account No.', Comment = 'ESM="N° Banco empleado pago"';
            //TableRelation = "ST Employee Bank Account"."Payment Bank Account No." where("Employee No." = field("Employee No."));
            TableRelation = if ("Account Type" = const(Employee)) "ST Employee Bank Account"."Payment Bank Account No." where("Employee No." = field("Account No."));
            ValidateTableRelation = false;
        }
        field(51038; "Payment is check"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment is check', Comment = 'ESM="Pago es cheque"';
        }
        field(51039; "Income/Balance"; Option)
        {
            Caption = 'Income/Balance', Comment = 'ESM="Ingresos/Saldo"';
            OptionCaption = ' ,Income Statement,Balance Sheet', Comment = 'ESM=" ,Resultado,Balance"';
            OptionMembers = " ","Income Statement","Balance Sheet";
        }
        field(51045; "Applies-to Acc. Group Mixed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to accountant group mixed', Comment = 'ESM="Liq. Grupo contable mixto"';
        }
        modify("Recipient Bank Account")
        {
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Bank Account".Code WHERE("Customer No." = FIELD("Account No."))
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Account No."))
            ELSE
            IF ("Account Type" = CONST(Employee)) "ST Employee Bank Account".Code WHERE("Employee No." = FIELD("Account No."))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) "Customer Bank Account".Code WHERE("Customer No." = FIELD("Bal. Account No."))
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Bal. Account No."))
            ELSE
            IF ("Bal. Account Type" = CONST(Employee)) "ST Employee Bank Account".Code WHERE("Employee No." = FIELD("Bal. Account No."));

            trigger OnAfterValidate()
            var
                CustBankAcc: Record "Customer Bank Account";
                VendBankAcc: Record "Vendor Bank Account";
                EmplBankAcc: Record "ST Employee Bank Account";
            begin
                if "Recipient Bank Account" <> '' then begin
                    if "Account Type" = "Account Type"::Customer then begin
                        CustBankAcc.Get("Account No.", "Recipient Bank Account");
                        "Payment Bank Account No." := CustBankAcc."Reference Bank Acc. No.";
                        "Payment is check" := CustBankAcc."Bank Type Check";
                    end else
                        if "Account Type" = "Account Type"::Vendor then begin
                            VendBankAcc.Get("Account No.", "Recipient Bank Account");
                            "Payment Bank Account No." := VendBankAcc."Reference Bank Acc. No.";
                            "Payment is check" := VendBankAcc."Bank Type Check";
                        end else
                            if "Account Type" = "Account Type"::Employee then begin
                                EmplBankAcc.Get("Account No.", "Recipient Bank Account");
                                "Payment Bank Account No." := EmplBankAcc."Payment Bank Account No.";
                                "Payment is check" := EmplBankAcc."Bank Type Check";
                            end;
                end else begin
                    "Payment Bank Account No." := '';
                    "Payment is check" := false;
                end;
            end;
        }

        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No.") then begin
                                if GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Balance Sheet" then
                                    "Income/Balance" := "Income/Balance"::"Balance Sheet"
                                else
                                    "Income/Balance" := "Income/Balance"::"Income Statement";
                            end;
                        end;
                    else
                        "Income/Balance" := "Income/Balance"::" ";
                end;
                "Source User Id." := UserId;
            end;
        }
        //Retentions Begin
        field(51010; "Retention No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention No.', Comment = 'ESM="N° Retención"';
        }
        field(51011; "Retention Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention Amount', Comment = 'ESM="Importe retención"';
        }
        field(51012; "Retention Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention Amount LCY', Comment = 'ESM="Importe retención DL"';
        }
        field(51013; "Applied Retention"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Applied Retention', Comment = 'ESM="Aplicar retención"';
            trigger OnValidate()
            begin
                if not "Applied Retention" then begin
                    DeleteLineForRetention();
                    "Retention Amount" := 0;
                    "Retention Amount LCY" := 0;
                    "Retention Applies-to Entry No." := 0;
                    "Apply Retention To Line" := false;
                    exit;
                end;
                TestField("Account Type", "Account Type"::Vendor);
                TestField("Posting Date");
                TestField("Applies-to Entry No.");
                TestField("Applies-to Doc. No.");
                RetentionMgt.ValidateRetention("Applied Retention", "Account No.", "Applies-to Doc. No.", "Posting Date");
            end;
        }
        field(51014; "Apply Retention To Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Apply Retention To Line', Comment = 'ESM="Aplicación a linea retención"';
        }
        field(51015; "Retention Applies-to Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention Applies-to Entry No.', Comment = 'ESM="N° Mov. aplicado retención"';
        }
        field(51016; "Manual Retention"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Manual Retention', Comment = 'ESM="Retención manual"';
        }
        field(51028; "Reference to apply No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference to apply No.', Comment = 'ESM="N° de aplicación referencia retención"';
        }
        field(51050; "Source Entry No. apply to ret."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Entry No. apply to ret.', Comment = 'ESM="N° Linea Origen retención en diario"';
        }
        field(51051; "Internal Control Bool"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                SetAutomateRetention();
            end;
        }
        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            begin
                SetAutomateRetention();
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                SetAutomateRetention();
            end;
        }
        //Retentions End

        //Import
        field(51006; "Importation No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Importation No.', Comment = 'ESP="N° Importación"';
            TableRelation = Importation;
        }
    }

    trigger OnAfterDelete()
    begin
        if Rec."Setup Source Code" <> Rec."Setup Source Code"::"Payment Schedule" then
            exit;
        if Rec."ST Control Entry No." = 0 then
            exit;
        PaymentSchedule.Get("ST Control Entry No.");
        PaymentSchedule.Status := PaymentSchedule.Status::Procesado;
        PaymentSchedule.Modify();
    end;

    var
        GLAccount: Record "G/L Account";
        RetentionMgt: Codeunit "Retention Management";
        PaymentSchedule: record "Payment Schedule";

    local procedure SetAutomateRetention()
    begin
        if ("Account Type" = "Account Type"::Vendor) and ("Account No." <> '') and
            ("Posting Date" <> 0D) and ("Applies-to Doc. No." <> '') and ("Amount (LCY)" <> 0) then
            RetentionMgt.SetAutomateRetentionCheck("Applied Retention", "Account No.", "Posting Date", "Applies-to Doc. No.", "Amount (LCY)");
    end;

    local procedure DeleteLineForRetention()
    var
        DelGenJnlLine: Record "Gen. Journal Line";
        UpdateGenJnlLine: Record "Gen. Journal Line";
    begin
        if IsEmpty then
            exit;
        DelGenJnlLine.Reset();
        DelGenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        DelGenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
        DelGenJnlLine.SetRange("Source Entry No. apply to ret.", "Line No.");
        if DelGenJnlLine.FindFirst() then begin
            UpdateGenJnlLine.Reset();
            UpdateGenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
            UpdateGenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
            UpdateGenJnlLine.SetRange("Account Type", "Account Type"::"Bank Account");
            if UpdateGenJnlLine.FindFirst() then begin
                UpdateGenJnlLine.Validate("Amount (LCY)", UpdateGenJnlLine."Amount (LCY)" + "Retention Amount LCY");
                UpdateGenJnlLine.Modify();
            end;
            DelGenJnlLine.Delete();
        end;
    end;
}