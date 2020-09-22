tableextension 51060 "Import Value Entry" extends "Value Entry"
{
    fields
    {
        field(51001; "Importation No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Importation No.';
        }
        field(51002; "Nationalization"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Nationalization';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
    }
}