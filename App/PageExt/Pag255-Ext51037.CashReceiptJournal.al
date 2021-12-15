pageextension 51037 "Setup Cash Receipt Journal" extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here
        modify("Document Date"){
            Visible = true;
        }
        addafter("Applies-to Doc. No.")
        {
            field("Applies-to Entry No."; Rec."Applies-to Entry No.")
            {
                ApplicationArea = All;
                Caption = 'Applied-to Entry No.', Comment = 'ESM="Liq. por N° Mov."';
            }
            field("Posting Group"; Rec."Posting Group")
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

        modify("Currency Code")
        {
            Visible = true;
        }
    }

    var
        SLSetupMgt: Codeunit "Setup Localization";
}
