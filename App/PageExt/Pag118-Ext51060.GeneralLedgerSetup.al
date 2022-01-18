pageextension 51060 "ULN General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Print VAT specification in LCY")
        {
            field("Income G/L Account"; Rec."Income G/L Account")
            {
                ApplicationArea = All;
            }
            field("Expenses G/L Account"; Rec."Expenses G/L Account")
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