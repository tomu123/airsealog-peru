tableextension 51061 "ULN General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(51000; "Income G/L Account"; Code[20])
        {
            Caption = 'Income G/L Account', comment = 'ENU="Income G/L Account";ESP="Cuenta Financiera Ingresos";ESM="Cuenta Financiera Ingresos"';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51001; "Expenses G/L Account"; Code[20])
        {
            Caption = 'Expenses G/L Account', comment = 'ENU="Expenses G/L Account";ESP="Cuenta Financiera Gastos";ESM="Cuenta Financiera Gastos"';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51002; "Dflt.Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Shortcut Dimension 1 Code', comment = 'ENU="Shortcut Dimension 1 Code";ESM="Cód. dim. acceso dir. 1"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 1 Code"));
        }
        field(51003; "Dflt.Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Shortcut Dimension 2 Code', comment = 'ENU="Shortcut Dimension 2 Code";ESM="Cód. dim. acceso dir. 2"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 2 Code"));
        }
        field(51004; "Dflt.Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code', comment = 'ENU="Shortcut Dimension 3 Code";ESM="Cód. dim. acceso dir. 3"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 3 Code"));
        }
        field(51005; "Dflt.Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code', comment = 'ENU="Shortcut Dimension 4 Code";ESM="Cód. dim. acceso dir. 4"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 4 Code"));
        }
        field(51006; "Dflt.Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code', comment = 'ENU="Shortcut Dimension 5 Code";ESM="Cód. dim. acceso dir. 5"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 5 Code"));
        }
        field(51007; "Dflt.Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code', comment = 'ENU="Shortcut Dimension 6 Code";ESM="Cód. dim. acceso dir. 6"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 6 Code"));
        }
        field(51008; "Dflt.Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code', comment = 'ENU="Shortcut Dimension 7 Code";ESM="Cód. dim. acceso dir. 7"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 7 Code"));
        }
        field(51009; "Dflt.Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code', comment = 'ENU="Shortcut Dimension 8 Code";ESM="Cód. dim. acceso dir. 8"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 8 Code"));
        }
        field(51010; "Dflt.Shortcut Dimension 9 Code"; Code[20])
        {
            CaptionClass = '1,2,9';
            Caption = 'Shortcut Dimension 9 Code', comment = 'ENU="Shortcut Dimension 9 Code";ESM="Cód. dim. acceso dir. 9"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 9 Code"));
        }
        field(51011; "Dflt.Shortcut Dim. 10 Code"; Code[20])
        {
            CaptionClass = '1,2,10';
            Caption = 'Shortcut Dimension 10 Code', comment = 'ENU="Shortcut Dimension 10 Code";ESM="Cód. dim. acceso dir. 10"';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Shortcut Dimension 10 Code"));
        }
        field(51012; "Shortcut Dimension 9 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 9 Code', comment = 'ENU="Shortcut Dimension 9 Code";ESP="Cód. dim. acceso directo 9";ESM="Cód. dim. acceso directo 9"';
            DataClassification = ToBeClassified;
            AccessByPermission = TableData "Dimension Combination" = R;
            TableRelation = Dimension;
        }
        field(51013; "Shortcut Dimension 10 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 10 Code', comment = 'ENU="Shortcut Dimension 10 Code";ESP="Cód. dim. acceso directo 10";ESM="Cód. dim. acceso directo 10"';
            DataClassification = ToBeClassified;
            AccessByPermission = TableData "Dimension Combination" = R;
            TableRelation = Dimension;
        }
    }

    var
        myInt: Integer;
}