page 51012 "Detailed Retention Ledg. Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Detailed Retention Ledg. Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(DtldRetLedgerEntryRepeater)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Retention Legal Document"; "Retention Legal Document")
                {
                    ApplicationArea = All;
                }
                field("Retention No."; "Retention No.")
                {
                    ApplicationArea = All;
                }
                field("Retention Posting Date"; "Retention Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Doc. Legal Document"; "Vendor Doc. Legal Document")
                {
                    ApplicationArea = All;
                }
                field("Vendor Doc. Posting Date"; "Vendor Doc. Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Document Date"; "Vendor Document Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Document No."; "Vendor Document No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor External Document No."; "Vendor External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Amount Invoice"; "Amount Invoice")
                {
                    ApplicationArea = All;
                }
                field("Amount Invoice LCY"; "Amount Invoice LCY")
                {
                    ApplicationArea = All;
                }
                field("Amount Paid"; "Amount Paid")
                {
                    ApplicationArea = All;
                }
                field("Amount Paid LCY"; "Amount Paid LCY")
                {
                    ApplicationArea = All;
                }
                field("Amount Retention"; "Amount Retention")
                {
                    ApplicationArea = All;
                }
                field("Amount Retention LCY"; "Amount Retention LCY")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}