page 51000 "Legal Document List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;
    SourceTable = "Legal Document";

    layout
    {
        area(Content)
        {
            repeater(ListDocumentsTypes)
            {
                field("Option Type"; "Option Type")
                {
                    ApplicationArea = All;
                }
                field("Type Code"; "Type Code")
                {
                    ApplicationArea = All;
                }
                field("Legal No."; "Legal No.")
                {
                    ApplicationArea = All;
                }
                field("Description"; "Description")
                {
                    ApplicationArea = All;
                }
                field("Serie Allow Alphanumeric"; "Serie Allow Alphanumeric")
                {
                    ApplicationArea = All;
                }
                field("Serie Lenght"; "Serie Lenght")
                {
                    ApplicationArea = All;
                }
                field("Number Allow Alphanumeric"; "Number Allow Alphanumeric")
                {
                    ApplicationArea = All;
                }
                field("Number Lenght"; "Number Lenght")
                {
                    ApplicationArea = All;
                }
                field("Min. Serie Lenght"; "Min. Serie Lenght")
                {
                    ApplicationArea = All;
                }
                field("Min. Number Lenght"; "Min. Number Lenght")
                {
                    ApplicationArea = All;
                }
                field("Adjust Serie"; "Adjust Serie")
                {
                    ApplicationArea = All;
                }
                field("Adjust Number"; "Adjust Number")
                {
                    ApplicationArea = All;
                }
                field("Description Type"; "Description Type")
                {
                    ApplicationArea = All;
                }
                field("Generic Code"; "Generic Code")
                {
                    ApplicationArea = All;
                }
                field("Alternative Code"; "Alternative Code")
                {
                    ApplicationArea = All;
                }
                field("TAX Code"; "TAX Code")
                {
                    ApplicationArea = All;
                }
                field(Affectation; Affectation)
                {
                    ApplicationArea = All;
                }
                field("Applied Level"; "Applied Level")
                {
                    ApplicationArea = All;
                }
                field("UN ECE 5305"; "UN ECE 5305")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}