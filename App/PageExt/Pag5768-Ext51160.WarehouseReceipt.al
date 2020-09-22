pageextension 51160 "LD Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sorting Method")
        {
            field("Legal Document"; "Legal Document")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}