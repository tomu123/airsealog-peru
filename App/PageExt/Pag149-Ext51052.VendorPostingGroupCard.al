pageextension 51052 "Setup Vendor Posting Gr. Card" extends "Vendor Posting Group Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(General)
        {
            group(Localization)
            {
                Caption = 'Setup Localization';
                field("Currency Exch. Type"; "Currency Exch. Type")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}