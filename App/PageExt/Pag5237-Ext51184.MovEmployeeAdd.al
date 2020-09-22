pageextension 51184 "Employee Ledger Entries" extends "Employee Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Payment Method Code")
        {
            field("Employee Posting Group"; "Employee Posting Group")
            {
                ApplicationArea = All;
            }

            field("Currency Code"; "Currency Code")
            {
                ApplicationArea = All;
            }

        }

        //Payment Schedule
        addafter("Entry No.")
        {
            field("PS Due Date"; "PS Due Date")
            {
                ApplicationArea = All;
            }
            field("PS Not Show Payment Schedule"; "PS Not Show Payment Schedule")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcFields("PS Not Show Payment Schedule");
    end;

    trigger OnAfterGetRecord()
    begin
        CalcFields("PS Not Show Payment Schedule");
    end;

    var
        myInt: Integer;
}