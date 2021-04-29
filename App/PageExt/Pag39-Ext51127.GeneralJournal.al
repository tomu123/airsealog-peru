pageextension 51127 "ST General Journal" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Due Date"; "Due Date")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Posting Date"; "Document Date")
        modify("Document Date")
        {
            Visible = true;
        }
        addafter("Applies-to Doc. No.")
        {

            field("Applies-to Entry No."; "Applies-to Entry No.")
            {
                ApplicationArea = all;
                Caption = 'Applied-to Entry No.';
            }
        }
        addbefore("Currency Code")
        {
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
        addafter(Comment)
        {
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
            }
            field("Job Task No."; "Job Task No.")
            {
                ApplicationArea = All;
                trigger onvalidate()
                var
                    myInt: Integer;
                begin
                    if ("Job No." <> '') and ("Job Task No." <> '') then
                        "Job Quantity" := 1;

                end;
            }
            field("Job Quantity"; "Job Quantity")
            {
                ApplicationArea = All;
            }

        }
        modify("Applies-to Doc. No.")
        {
            Editable = true;
            Visible = true;
        }
        modify("Document Type")
        {
            Visible = true;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        moveafter("Bal. Account Type"; "Bal. Account No.")

    }
    actions
    {
        addlast("F&unctions")
        {
            group("Planilla")
            {
                Image = Planning;
                action("Imp. Planilla")
                {
                    ApplicationArea = all;
                    Caption = 'Importar Planilla';
                    Image = ImportExcel;
                    Promoted = false;
                    RunObject = Report "GenJournalReturn";


                }

            }

        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                recgenJoLin: Record 81;
            begin
                recgenJoLin.Reset;
                recgenJoLin.SetRange("Journal Template Name", "Journal Template Name");
                recgenJoLin.SetRange("Journal Batch Name", "Journal Batch Name");
                if recgenJoLin.FindSet() then begin
                    repeat
                        if recgenJoLin."Applies-to Doc. No." <> '' then begin
                            if recgenJoLin."Applies-to Entry No." = 0 then
                                Error('El numero movimiento aplicado no puede estar vacio');

                        end;
                    until recgenJoLin.Next = 0;
                end;

            end;

        }

    }

    var
        SLSetupMgt: Codeunit "Setup Localization";

}