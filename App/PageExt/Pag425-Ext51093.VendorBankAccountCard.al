pageextension 51093 "ST Vendor Bank Account Card" extends "Vendor Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Name)
        {
            field("Vend. Name/Business Name"; "Vend. Name/Business Name")
            {
                ApplicationArea = All;
            }
        }

        addafter(General)
        {
            group(SetupLocalization)
            {
                Caption = 'Setup localization', Comment = 'ESM="Configuración localización"';
                field("Bank Account Type"; "Bank Account Type")
                {
                    ApplicationArea = All;
                }
                field("Bank Type Check"; "Bank Type Check")
                {
                    ApplicationArea = All;
                }
                field("Check Manager"; "Check Manager")
                {
                    ApplicationArea = All;
                }
                field("Reference Bank Acc. No."; "Reference Bank Acc. No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account CCI"; "Bank Account CCI")
                {
                    ApplicationArea = All;
                }
            }
        }
        //Legal Document Begin
        addbefore("Bank Account No.")
        {
            field("Legal Document"; "Legal Document")
            {
                ApplicationArea = All;
            }
        }
        //Legal Document End
    }
}