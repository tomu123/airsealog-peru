table 59009 "Inv. Bal. Book Buffer"
{
    DataClassification = ToBeClassified;
    Caption = 'Inv. Bal. Book Buffer', Comment = 'ESM="Libros Inventarios y Balances"';

    fields
    {
        field(59000; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59001; "Period"; Text[12])
        {
            DataClassification = ToBeClassified;
        }
        field(59002; "Transaction CUO"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59003; "Correlative cuo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59004; "G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'G/L Account No.', Comment = 'ESM="N° Cuenta"';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting), Blocked = CONST(false));
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
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