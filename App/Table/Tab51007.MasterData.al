table 51007 "Master Data"
{
    DataClassification = ToBeClassified;
    //51000..51004,51040..51060
    fields
    {
        field(51000; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
        }
        field(51001; "Type Table"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type Table';
        }
        field(51002; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }
        field(51003; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(51004; "Amount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount %';
        }
        field(1; "G/L Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "G/L Entry Transaction No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51040; "Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Dimension Code';
            TableRelation = Dimension;
        }
        field(51041; "Dimension Value Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"));
        }
        field(51042; "Type Table ref"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51043; "Code ref"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}