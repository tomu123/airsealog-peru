pageextension 51104 "Setup Fixed Asset Card" extends "Fixed Asset Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Maintenance)
        {
            group(SetupLocalization)
            {
                Caption = 'Setup Localization';
                field(FirstField; FirstField)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
            }
        }
        //Legal Document Begin
        addafter(General)
        {
            group(Locatization)
            {
                Caption = 'Localization', Comment = 'ESM="Localización"';
                field("LD Fixed Asset Type"; "LD Fixed Asset Type")
                {
                    ApplicationArea = All;
                }
                field("LD Fixed Asset Status"; "LD Fixed Asset Status")
                {
                    ApplicationArea = All;
                }
                field("LD Depreciation Method"; "LD Depreciation Method")
                {
                    ApplicationArea = All;
                }
                field("LD Brand"; "LD Brand")
                {
                    ApplicationArea = All;
                }
                field("LD Model"; "LD Model")
                {
                    ApplicationArea = All;
                }
                field("LD Intagible Type"; "LD Intagible Type")
                {
                    ApplicationArea = All;
                    Editable = "LD Intangible Status";
                }
                field("LD Job No."; "LD Job No.")
                {
                    ApplicationArea = All;
                }
                field("LD Job Task No."; "LD Job Task No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        //Legal Document End
    }

    var
        FirstField: Text;

}