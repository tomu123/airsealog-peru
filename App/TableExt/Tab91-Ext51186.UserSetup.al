tableextension 51186 "PR User Setup" extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(51004; "PR Automatic Delegate Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Automatic delegate active', Comment = 'ESM="Delegar automático"';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if not "PR Automatic Delegate Active" then
                    exit;
                TestField(Substitute);
            end;
        }

        //Payment Schedule
        field(51000; "View Schedule"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'View Schedule ', Comment = 'ESM="Ver Cronograma"';
        }
    }

    var
        myInt: Integer;
}