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
            }
            field("Correlative CUO"; "Correlative CUO")
            {
                ApplicationArea = All;
            }
            field(Opening; Opening)
            {
                ApplicationArea = All;
            }
            field("Posting Text"; "Posting Text")
            {
                ApplicationArea = All;
            }
            field("Setup Source Code"; "Setup Source Code")
            {
                ApplicationArea = All;
            }
            field("Source Currency Code"; "Source Currency Code")
            {
                ApplicationArea = All;
            }
            field("Source Currency Type"; "Source Currency Type")
            {
                ApplicationArea = All;
            }
            field("Source Currency Factor"; "Source Currency Factor")
            {
                ApplicationArea = All;
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

    actions
    {
        addlast(Reporting)
        {
            action(DayliVoucher)
            {
                ApplicationArea = All;
                Caption = 'Dayli Voucher', Comment = 'ESM="Voucher diario"';
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    DayliVoucher: Report "LU Daily Voucher";
                begin
                    GLEntry.SetRange("Document No.", "Document No.");
                    DayliVoucher.SetTableView(GLEntry);
                    DayliVoucher.Run();
                    GLEntry.Reset();
                end;
            }
        }
    }
}