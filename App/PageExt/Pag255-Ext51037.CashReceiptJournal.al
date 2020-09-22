pageextension 51037 "Setup Cash Receipt Journal" extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Applies-to Doc. No.")
        {
            field("Applies-to Entry No."; "Applies-to Entry No.")
            {
                ApplicationArea = All;
                Caption = 'Applied-to Entry No.';
            }
            field("Posting Group"; "Posting Group")
            {
                ApplicationArea = All;
                Editable = true;

                trigger OnValidate()
                begin
                    SLSetupMgt.ValidatePostingGroup(Rec);
                end;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    SLSetupMgt.LookUpPostingGroup(Rec);
                end;
            }
        }
    }

    var
        SLSetupMgt: Codeunit "Setup Localization";
}