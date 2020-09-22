pageextension 51067 "Setup General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Transaction No."; "Transaction No.")
            {
                ApplicationArea = All;

            }
        }
        addafter("External Document No.")
        {
            field("Transaction CUO"; "Transaction CUO")
            {
                ApplicationArea = All;
                Caption = 'Transaction CUO';
            }
            field("Correlative CUO"; "Correlative CUO")
            {
                ApplicationArea = All;
                Caption = 'Correlative CUO';
            }
            field(Opening; Opening)
            {
                ApplicationArea = All;
                Caption = 'Opening';
            }
            field("Posting Text"; "Posting Text")
            {
                ApplicationArea = All;
                Caption = 'Posting Text';
            }
            field("Setup Source Code"; "Setup Source Code")
            {
                ApplicationArea = All;
                Caption = 'Source Code ULN';
            }
        }
        addafter("Global Dimension 2 Code")
        {
            field("Global Dimension 3 Code"; "Global Dimension 3 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,3';
            }
            field("Global Dimension 4 Code"; "Global Dimension 4 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,4';
            }
            field("Global Dimension 5 Code"; "Global Dimension 5 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';
            }
            field("Global Dimension 6 Code"; "Global Dimension 6 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,6';
            }
            field("Global Dimension 7 Code"; "Global Dimension 7 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,7';
            }
            field("Global Dimension 8 Code"; "Global Dimension 8 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,8';
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
        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
        }

        //Import
        addafter("External Document No.")
        {
            // control with underlying datasource
            field("Importation No."; "Importation No.")
            {
                ApplicationArea = All;
            }
        }
    }
}