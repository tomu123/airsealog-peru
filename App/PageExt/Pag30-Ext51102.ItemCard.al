pageextension 51102 "Setup Item Card" extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Warehouse)
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
    }

    var
        FirstField: Text;
}