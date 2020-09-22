tableextension 51155 "LD FA Class" extends "FA Class"
{
    fields
    {
        // Add changes to table fields here 51000..51005
        field(51000; "LD Intangible Status"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Intagible Status';
        }
    }

    var
        myInt: Integer;
}