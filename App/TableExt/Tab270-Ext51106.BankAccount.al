tableextension 51106 "Setup Bank Account" extends "Bank Account"
{
    fields
    {
        // Add changes to table fields here 51000..51002,51004
        field(51000; "Bank Account Type"; Enum "ST Bank Account Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account Type', Comment = 'ESM="Tipo cuenta bancaria"';
        }
        field(51001; "Is Check Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is Check Bank', Comment = 'ESM="Banco Cheque"';
        }
        field(51002; "Bank Account CCI"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account CCI', Comment = 'ESM="N° Cuenta Banco"';
        }
        field(51030; "Process Type BBVA"; Option)
        {
            Caption = 'Process Type', Comment = 'ESM="Tipo Proceso"';
            OptionMembers = " ",Immediate,"Hour","Date";
            OptionCaption = ' ,Immediate,Hour,Date', Comment = 'ESM=" ,Inmediato,Hora,Fecha"';

            trigger OnValidate()
            begin
                IF "Process Type BBVA" <> "Process Type BBVA"::Hour THEN
                    "Process Hour" := "Process Hour"::" ";
            end;
        }
        field(51031; "Process Hour"; Option)
        {
            Caption = 'Process Hour', Comment = 'ESM="Proceso Hora"';
            OptionCaption = ' ,B = 11:00 a.m.,C = 03:00 p.m.,D = 07:00 p.m.';
            OptionMembers = " ","B = 11:00 a.m.","C = 03:00 p.m.","D = 07:00 p.m.";
        }
        //Legal Document
        field(51010; "Legal Document"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Legal Document', Comment = 'ESM="Documento Legal"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('03'));
        }
    }
}