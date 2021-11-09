pageextension 51131 "ST Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Posting Date"){
            field("Document Date"; "Document Date"){
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
        addbefore("Document Type")
        {
            field("Document No"; "Document No.")
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
            field("Payables Account"; "Payables Account")
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
        //Payment Schedule
        addafter("Vendor No.")
        {
            field("Vendor Posting Group"; "Vendor Posting Group")
            {
                ApplicationArea = All;
            }
        }

        addafter("Exported to Payment File")
        {
            field("PS Not Show Payment Schedule"; "PS Not Show Payment Schedule")
            {
                ApplicationArea = All;
            }
        }

        addbefore("Due Date")
        {
            field("Accountant receipt date"; "Accountant receipt date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(UnapplyEntries)
        {
            action(UnapplyUniqueEntries)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Unapply Unique Entries';
                Ellipsis = true;
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                ToolTip = 'Unselect one or more ledger entries that you want to unapply this record.';

                trigger OnAction()
                var
                    STVendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
                begin
                    STVendEntryApplyPostedEntries.UnApplyVendLedgEntry("Entry No.");
                end;
            }
        }
    }

    var
        page29: Page 29;
}
