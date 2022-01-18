pageextension 51298 "ST Purch. Cr. Memo Subform" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
