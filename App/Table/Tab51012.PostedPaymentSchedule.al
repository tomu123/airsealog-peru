table 51012 "Posted Payment Schedule"
{
    Caption = 'Posted Payment  Schedule';

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
                IF ABS("Total a Pagar") > ABS(Amount) THEN
                    ERROR('El Monto a Pagar no puede exceder al "Importe", ¡Revisar!');

                IF "Total a Pagar" > 0 THEN
                    "Total a Pagar" := ("Total a Pagar" * -1);
            end;
        }
        field(51011; "Preferred Bank Account Code"; code[45])
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred Bank Account Code';
            trigger OnValidate();
            var
                lcRecCustBankAccount: Record "Customer Bank Account";
                lcRecVendBankAccount: Record "Vendor Bank Account";
            begin
                CASE "Type Source" OF
                    "Type Source"::"Mov Clientes":
                        BEGIN
                            lcRecCustBankAccount.RESET;
                            lcRecCustBankAccount.SETRANGE("Customer No.", "VAT Registration No.");
                            lcRecCustBankAccount.SETRANGE(Code, "Preferred Bank Account Code");
                            IF lcRecCustBankAccount.FINDFIRST THEN BEGIN
                                "Reference Bank Acc. No." := lcRecCustBankAccount."Reference Bank Acc. No.";
                                "Bank Account No." := lcRecCustBankAccount."Bank Account No.";
                                //"Is Payment Check" := lcRecCustBankAccount."MPW Check"; Is Agr no
                            END ELSE BEGIN
                                "Reference Bank Acc. No." := '-';
                                "Bank Account No." := '-';
                                "Is Payment Check" := FALSE;
                            END;
                        END;
                    "Type Source"::"Mov Proveedores":
                        BEGIN
                            lcRecVendBankAccount.RESET;
                            lcRecVendBankAccount.SETRANGE("Vendor No.", "VAT Registration No.");
                            lcRecVendBankAccount.SETRANGE(Code, "Preferred Bank Account Code");
                            IF lcRecVendBankAccount.FINDFIRST THEN BEGIN
                                "Reference Bank Acc. No." := lcRecVendBankAccount."Reference Bank Acc. No.";
                                "Bank Account No." := lcRecVendBankAccount."Bank Account No.";
                                //"Is Payment Check" := lcRecVendBankAccount."MPW Check"; Is Agr
                            END ELSE BEGIN
                                "Reference Bank Acc. No." := '-';
                                "Bank Account No." := '-';
                                "Is Payment Check" := FALSE;
                            END;
                        END;
                END;
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
            OptionMembers = "Mov Proveedores","Mov Clientes";
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
            TableRelation = "User Setup";
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
            TableRelation = "Payment Method";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        recVendorLedgerEntry: Record "Vendor Ledger Entry";
        gNroDocumentoLiquidar: Code[70];
        lcRecVendLedgerEntry: Record "Vendor Ledger Entry";
        lcText0004: Label 'El documento %1 no se encuentra como pendiente.';
        lcRecCustLedgerEntry: Record "Cust. Ledger Entry";
        lcPgApplyVendEntries: Page "Apply Vendor Entries";
        lcPgApplyCustEntries: Page "Apply Customer Entries";
        recCustLedgerEntry: Record "Cust. Ledger Entry";
        gIsBatchCheck: Boolean;

    procedure fnNextLine(): Integer;
    var
        PostedPaymentSchedule: Record "Posted Payment Schedule";
    begin
        PostedPaymentSchedule.RESET;
        PostedPaymentSchedule.SETCURRENTKEY("Entry No.");
        PostedPaymentSchedule.SETFILTER("Entry No.", '<>%1', 0);
        IF PostedPaymentSchedule.FINDLAST THEN
            EXIT(PostedPaymentSchedule."Entry No." + 1)
        ELSE
            EXIT(1);
    end;
}

