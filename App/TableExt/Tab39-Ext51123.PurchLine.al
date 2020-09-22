tableextension 51123 "Purchase Standar Code" extends "Purchase Line"
{
    fields
    {
        field(51008; "Purchase Standard Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Standar Code';
            Editable = false;
        }
        field(51001; "Importation No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Importation No.', Comment = 'ESM="N° Importación"';
            TableRelation = Importation;
            trigger OnValidate()
            var
                Importation: Record Importation;
            begin
                CalcFields("Qty. to Assign");
                if "Qty. to Assign" <> 0 then begin
                    if xRec."Importation No." <> "Importation No." then begin
                        Message('No pueden cambiar el código de importación a una línea ya asignado');
                        Error('No pueden cambiar el código de importación a una línea ya asignado');
                    end;
                end;
                Importation.Get("Importation No.");
                if Importation.Status = Importation.Status::Closed then
                    Message('El estado de la importación debe estar abierta para continuar con el proceso');
                Importation.TestField(Importation.Status, Importation.Status::Open);

            end;
        }
    }


    var

}