table 51101 "Hist. Divisas"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(51000; "Fecha"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51001; "T.C Pasivo"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51002; "T.C Activo"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51003; "Modif. Usuario"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51004; "Ult. Fecha Modif."; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51005; "FechaCompleta"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(51006; "No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51007; Registrado; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No")
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