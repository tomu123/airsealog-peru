pageextension 51132 "ST Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Document Date"; "Document Date")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Exported to Payment File")
        {
            field("Posting Text"; "Posting Text")
            {
                ApplicationArea = All;
            }
            field("Setup Source Code"; "Setup Source Code")
            {
                ApplicationArea = All;
            }
            field("Payment Terms Code"; "Payment Terms Code")
            {
                ApplicationArea = All;
            }
            field("Receivables Account"; "Receivables Account")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document No.")
        {
            field("Legal Document"; "Legal Document")
            {
                ApplicationArea = All;
            }

            field("Legal Status"; "Legal Status")
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