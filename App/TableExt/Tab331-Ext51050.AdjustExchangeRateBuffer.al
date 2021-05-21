tableextension 51050 "ULN Adj Exchange Rate Buffer" extends "Adjust Exchange Rate Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(51000; "Ref. Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ref. Source Type', Comment = 'ENU="Source Type";ESP="Tipo procedencia mov. Adjmt";ESM="Tipo procedencia mov. Adjmt"';
            OptionMembers = " ","Customer","Vendor","Bank Account","Fixed Asset";
        }

        field(51001; "Ref. Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ref. Source No.', Comment = 'ENU="Source No.";ESM="Cód. procedencia mov. Adjmt"';
            //TableRelation = IF ("Ref. Source Type"=CONST(Customer)) Customer ELSE IF ("Ref. Source Type"=CONST(Vendor)) Vendor ELSE IF ("Ref. Source Type"=CONST("Bank Account")) "Bank Account" ELSE IF ("Ref. Source Type"=CONST("Fixed Asset")) "Fixed Asset"
        }

        field(51002; "Ref. Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ref. Document No.', Comment = 'ENU="Document No.";ESM="Nº documento Adjmt"';
        }
    }

    var
        myInt: Integer;
}