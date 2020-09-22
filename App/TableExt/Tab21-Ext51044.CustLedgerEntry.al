tableextension 51044 "Setup Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        // Add changes to table fields here 51002..51004,51020..51025
        field(51002; "Source Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Currency Factor', Comment = 'ESM="Factor div. origen"';
        }
        field(51004; "Posting Text"; Text[250])
        {
            Caption = 'Posting Text', Comment = 'ESM="Texto registro"';
        }
        field(51005; "Setup Source Code"; Enum "ST Source Code Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Code ULN', Comment = 'ESM="Cód. Origen ULN"';
        }
        field(51020; "Payment Terms Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Terms Code', Comment = 'ESM="Cód. Términos de pago"';
            TableRelation = "Payment Terms";
        }
        field(51021; "Receivables Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receivables Account', Comment = 'ESM="Cuenta de cobranza"';
        }
        //Legal Document Begin
        field(51000; "Legal Document"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Legal Document', Comment = 'ESM="Documento Legal"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('10'));
            ValidateTableRelation = false;
        }

        field(51001; "Legal Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Legal Status', Comment = 'ESM="Estado Legal"';
            OptionMembers = "Success","Anulled","OutFlow";
            OptionCaption = 'Success,Anulled,OutFlow', Comment = 'ESM="Normal,Anulado,Extornado"';
        }
        //Legal Document End
    }

    var
        record21: Record 25;
}