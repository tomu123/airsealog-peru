tableextension 51097 "FT Sales Cr.Memo Line" extends "Sales Cr.Memo Line"
{
    fields
    {
        // Add changes to table fields here
        field(51015; "FT Free Title Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Free Title Line';
        }
    }
}