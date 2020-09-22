tableextension 51078 "Setup Gen Journal Batch" extends "Gen. Journal Batch"
{
    fields
    {
        // Add changes to table fields here
        field(51002; "Bank Account No. FICO"; Code[20])
        {
            Caption = 'FICO Bank Account No.';
            TableRelation = "Bank Account"."No.";
            trigger OnValidate();
            var
                BankAccount: Record "Bank Account";
            begin
                if "Bank Account No. FICO" <> '' then
                    exit;
                BankAccount.Get("Bank Account No. FICO");
            end;
        }
        field(51003; Deposits; Boolean)
        {
            Caption = 'Deposits';
        }
        field(51004; "Static Value"; Boolean)
        {
            Caption = 'Static Value';
        }
        field(51005; "Is Batch Check"; Boolean)
        {
            Caption = 'Is Batch Check';
        }
    }

    var
        Page43: page 43;
        recor172: Record 172;
}
