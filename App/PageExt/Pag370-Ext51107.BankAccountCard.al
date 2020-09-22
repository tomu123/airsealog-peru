pageextension 51107 "Setup Bank Account Card" extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bank Account No.")
        {
            field("Bank Account CCI"; "Bank Account CCI")
            {
                ApplicationArea = All;
                Caption = 'Bank Account CCI', Comment = 'ESM="N° Cuenta CCI"';
            }
        }
        addbefore("Bank Account No.")
        {
            field("Bank Account Type"; "Bank Account Type")
            {
                ApplicationArea = All;
                Caption = 'Bank Account Type', Comment = 'ESM="Tipo de cuenta banco"';
            }
        }

        addafter(Transfer)
        {
            group(SetupPersonalization)
            {
                Caption = 'Setup Localization', Comment = 'ESM="Configuración de localización"';
                field(FirstField; FirstField)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Is Check Bank"; "Is Check Bank")
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
                Caption = 'Legal Document', Comment = 'ESM="Documenta Legal"';
            }
        }
        //Legal Document End
    }

    var
        FirstField: Text;
        Report1320: Report 1320;
}