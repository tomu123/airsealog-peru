tableextension 51120 "Setup Sales Inv. Header" extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here 51050..51059
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
        field(51011; "VAT Registration Type"; Code[2])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Registration Type', Comment = 'ESM="Tipo Doc. Identidad"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('02'));
            ValidateTableRelation = false;
        }
        field(51012; "Legal Property Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Legal Property Type', Comment = 'ESM="Tipo de bien"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('30'));
            ValidateTableRelation = false;
        }
        field(51013; "Ext/Anul. User Id."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ext/Anul. User Id.', Comment = 'ESM="Ext/Anul. User Id."';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            Editable = false;
        }
        field(51030; "Manual Document Ref."; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Manual Document Ref.', Comment = 'ESM="Documento Manual Ref."';
        }
        field(51031; "Electronic Doc. Ref"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Electronic Doc. Ref.', Comment = 'ESM="Documento Electr??nico Ref."';
        }
        field(51032; "Applies-to Doc. No. Ref."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to Doc. No. Ref.', Comment = 'ESM="Liq. por N?? Documento Ref."';
            TableRelation = if ("Manual Document Ref." = Const(false)) "Sales Invoice Header"."No." where("Legal Status" = const(Success), "Legal Document" = field("Legal Document Ref."), "Sell-to Customer No." = field("Sell-to Customer No."));
            ValidateTableRelation = false;
        }
        field(51033; "Applies-to Serie Ref."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to Serie Ref.', Comment = 'ESM="Liq. serie doc. Ref."';
        }
        field(51034; "Applies-to Number Ref."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to Number Ref.', Comment = 'ESM="Liq. n??mero doc. Ref."';
        }
        field(51035; "Applies-to Document Date Ref."; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to Document Date Ref.', Comment = 'ESM="Liq. Fecha Emisi??n Ref."';
        }
        //Legal Document End

        field(51050; "Setup Source Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Code ULN', Comment = 'ESM="C??d. Origen ULN"';
            TableRelation = "Master Data".Code where("Type Table" = const('STPSOURCECODE'));
        }
        field(51051; "Posting Text"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Text', Comment = 'ESM="Texto registro"';
        }
        //Detracc BEGIN
        field(51020; "Sales Detraction"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Detraction', Comment = 'ESM="Detracci??n"';
        }
        field(51021; "Sales % Detraction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales % Detraction', Comment = 'ESM="% Detracci??n"';
        }

        field(51022; "Sales Amt Detraction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Amt Detraction', Comment = 'ESM="Importe detracci??n"';
        }

        field(51023; "Sales Amt Detraction (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Amt Detraction (LCY)', Comment = 'ESM="Importe detracci??n (DL)"';
        }

        field(51024; "Operation Type Detrac"; Code[2])
        {
            DataClassification = ToBeClassified;
            Caption = 'Operation Type Detraction', Comment = 'ESM="Tipo operaci??n detracci??n"';
        }

        field(51025; "Service Type Detrac"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Type Detraction', Comment = 'ESM="TIpo servicio detracci??n"';
        }
        field(51026; "Payment Method Code Detrac"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Method Code Detrac', Comment = 'ESM="C??d. Forma Pago Detracci??n"';
            TableRelation = "Payment Method";
        }
        field(59001; "Airsealog-Cargowise Inv No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cargowise Invoice No.', comment = 'ESM="No. Factura Cargowise"';
        }
        //Detracc END

        //Free title
        field(51015; "FT Free Title"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Free Title', Comment = 'ESM="T??tulo gratuito"';
            Editable = false;
        }

        //Internal Consumption
        field(51060; "Internal Consumption"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Internal Consumption', Comment = 'ESM="Consumo Interno"';
        }
    }
}
