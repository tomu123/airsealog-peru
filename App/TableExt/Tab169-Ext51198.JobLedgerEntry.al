tableextension 51198 "ST Job Ledger Entry" extends "Job Ledger Entry"
{
    fields
    {
        // Add changes to table fields here 51000..51010
        field(51000; "ST Sale Cost to process"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Cost to process', Comment = 'ESM="Costo de venta para procesar"';
            Editable = false;
        }
        field(51001; "ST Sale Cost processed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sale Cost processed', Comment = 'ESM="Costo de venta procesado"';
            Editable = false;
        }
        field(51002; "ST Percentage Costed"; Decimal)
        {
            Caption = 'Percentage Costed', Comment = 'Porcentaje Costeado';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("SL Cost sale Entry".Percentage where("Job No." = field("Job No."), "Job Task No." = field("Job Task No."), "Job Planning Lines No." = field("Entry No.")));
            //No. Linea Pla. Proyecto=FIELD(Entry No.)))
        }
        field(51003; "ST Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Processed', Comment = 'ESM="Procesado"';
        }
        field(51004; "ST Percentage to cost"; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage to Cost', Comment = 'ESM="Procentaje a Costear"';
        }


    }

    var
        myInt: Integer;
}