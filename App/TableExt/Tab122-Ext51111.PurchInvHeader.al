tableextension 51111 "Setup Purch. Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here 51024..51025,51050..51059
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
            DataClassification = ToBeClassified;
            Caption = 'Legal Document Ref.', Comment = 'ESM="Documento legal Ref."';
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
        field(51030; "Manual Document Ref."; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Manual Document Ref.', Comment = 'ESM="Documento Manual Ref."';
        }
        field(51031; "Electronic Doc. Ref"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Electronic Doc. Ref', Comment = 'ESM="Doc. ELectr??nico Ref."';
        }
        field(51032; "Applies-to Doc. No. Ref."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to Doc. No. Ref', Comment = 'ESM="Liq. por N?? Documento Ref."';
            TableRelation = if ("Manual Document Ref." = Const(false)) "Purch. Inv. Header"."No." where("Legal Status" = const(Success), "Legal Document" = field("Legal Document Ref."), "Buy-from Vendor No." = field("Buy-from Vendor No."));
            ValidateTableRelation = false;
        }
        field(51033; "Applies-to Serie Ref."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to Serie Ref', Comment = 'ESM="Liq. por Serie Ref."';
        }
        field(51034; "Applies-to Number Ref."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies-to Number Ref.', Comment = 'ESM="Liq. por numero Ref."';
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

        //Detracc BEIGN
        field(51003; "Purch. Detraction"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch Detraction', Comment = 'ESM="Detracci??n"';
        }
        field(51004; "Purch. % Detraction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. % Detraction', Comment = 'ESM="% Detracci??n"';
        }
        field(51005; "Purch. Detraction Operation"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Detraction Operation', Comment = 'ESM="Detracci??n Operaci??n"';
        }
        field(51006; "Purch. Amount Detraction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Detraction', Comment = 'ESM="Importe detracci??n"';
        }
        field(51007; "Purch Date Detraction"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Detraction Date', Comment = 'ESM="Fecha Detracci??n"';
        }
        field(51008; "Type of Service"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of service', Comment = 'ESM="Tipo de servicio"';
        }
        field(51009; "Type of Operation"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of operation', Comment = 'ESM="Tipo de operaci??n"';
        }
        field(51010; "Purch Amount Detraction LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Detraction LCY', Comment = 'ESM="Importe detracci??n (DL)"';
        }
        //Detracc End

        //Ubigeo Begin
        field(51020; "Retention RH Gross Amount"; Decimal)
        {
            Caption = 'Retention RH Gross amount', Comment = 'ESM="Importe Bruto RH"';
            DataClassification = ToBeClassified;
        }
        field(51021; "Retention RH Fourth Amount"; Decimal)
        {
            Caption = 'Retention RH Fourth Amount', Comment = 'ESM="Importe de cuarta RH"';
            DataClassification = ToBeClassified;
        }
        field(51022; "Retention RH Electronic"; Boolean)
        {
            Caption = 'Retention RH Electronic', Comment = 'ESM="Retenci??n electr??nica RH"';
            DataClassification = ToBeClassified;
        }
        field(51060; "RH Suspension"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'RH Suspension', Comment = 'ESM="Suspenci??n RH"';
        }
        field(51061; "RH Suspension Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'RH Suspension Date', Comment = 'ESM="Fecha Suspenci??n RH"';
        }
        field(51062; "RH Suspension Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'RH Suspension Number', Comment = 'ESM="N??mero Suspenci??n RH"';
        }
        //Ubigeo End

        //Import Begin
        field(51018; "Importation No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Importation No.', Comment = 'ESM="N?? Importaci??n"';
            TableRelation = Importation;
        }

        field(51014; "Nationalization"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Nationalization', Comment = 'ESM="Nacionalizaci??n"';
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No', Comment = 'ESM=" ,S??,No"';
        }
        field(51015; "Income Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Income Type', Comment = 'ESM="Tipo de ingreso"';
            TableRelation = "Legal Document"."Legal No." WHERE("Option Type" = filter("SUNAT Table"), "Type Code" = filter('31'));
        }
        field(51016; "Service Provided Mode"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Provider Mode', Comment = 'ESM="Modo de proveedor de servicios"';
            TableRelation = "Legal Document"."Legal No." WHERE("Option Type" = filter("SUNAT Table"), "Type Code" = filter('32'));

        }
        field(51017; "Exemptions from Operations"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Exemptions from Operations', Comment = 'ESM="Exenciones de operaciones"';
            TableRelation = "Legal Document"."Legal No." WHERE("Option Type" = filter("SUNAT Table"), "Type Code" = filter('33'));
        }
        //Import End

        field(51055; "Accountant receipt date"; date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accountant receipt date', Comment = 'ESM="Fecha recepci??n contabilidad"';
            Editable = false;
        }
    }
}