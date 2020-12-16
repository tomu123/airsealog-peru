pageextension 51107 "Setup Bank Account Card" extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bank Account No.")
        {
            field("Bank Account CCI"; Rec."Bank Account CCI")
            {
                ApplicationArea = All;
                Caption = 'Bank Account CCI', Comment = 'ESM="N° Cuenta CCI"';
            }
        }
        addbefore("Bank Account No.")
        {
            field("Bank Account Type"; Rec."Bank Account Type")
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
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Is Check Bank"; Rec."Is Check Bank")
                {
                    ApplicationArea = All;
                }
            }
        }
        //Legal Document Begin
        addbefore("Bank Account No.")
        {
            field("Legal Document"; Rec."Legal Document")
            {
                ApplicationArea = All;
                Caption = 'Legal Document', Comment = 'ESM="Documenta Legal"';
            }
            field("Process Type BBVA"; Rec."Process Type BBVA")
            {
                ApplicationArea = All;
            }
        }
        //Legal Document End

        addafter("Process Type BBVA")
        {
            field("Process Bank"; "Process Bank")
            {
                ApplicationArea = All;

            }
        }
    }

    var
        FirstField: Text;
        Report1320: Report 1320;
}