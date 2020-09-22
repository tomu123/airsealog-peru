pageextension 51001 "Legal Doc. Sales Invoice List" extends "Sales Invoice List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Legal Document"; "Legal Document")
            {
                ApplicationArea = Basic, Suite;
            }

            field("Legal Status"; "Legal Status")
            {
                ApplicationArea = Basic, Suite;
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