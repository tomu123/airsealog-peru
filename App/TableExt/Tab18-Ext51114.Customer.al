tableextension 51114 "ST Customer" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(51008; "Preferred Bank Account Code ME"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred Bank Acc. Code ME', Comment = 'ESM="Banco Recaudación ME"';
            TableRelation = "Customer Bank Account".Code where("Customer No." = field("No."));
        }
        //Consult RUC Begin
        field(51005; "SUNAT Status"; Text[30])
        {
            Caption = 'SUNAT Status', Comment = 'ESM="Estado SUNAT"';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51006; "SUNAT Condition"; Text[30])
        {
            Caption = 'SUNAT Condition', Comment = 'ESM="Condición SUNAT"';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51007; "Ubigeo"; Text[30])
        {
            Caption = 'Ubigeo';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //Consult RUC End

        //Legal Document
        field(51000; "VAT Registration Type"; Code[2])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Registration Type', Comment = 'ESM="Tipo Doc. Identidad"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('02'));
            ValidateTableRelation = false;
            trigger OnValidate()
            begin
                ValidateVATRegistration();
            end;
        }

        //Ubigeo Begin **********************************************************************************************************
        modify(County)
        {
            TableRelation = Ubigeo."District Code" where("Province Code" = field(City), "Departament Code" = field("Post Code"));
        }
        //Ubigeo End **********************************************************************************************************
    }

    var
        ErrorVatRegistrationNo: label 'The length of the document does not meet the required length and format.', Comment = 'ESM="El numero de documento no cumple con el formato requerido."';

    local procedure ValidateVATRegistration()
    begin
        if "VAT Registration No." <> '' then
            if (("VAT Registration Type" <> '') and ("VAT Registration Type" = '1') and (StrLen("VAT Registration No.") <> 8)) or
                (("VAT Registration Type" <> '') and ("VAT Registration Type" = '6') and (StrLen("VAT Registration No.") <> 11)) then
                Error(ErrorVatRegistrationNo);
    end;
}