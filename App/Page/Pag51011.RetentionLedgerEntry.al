page 51011 "Retention Ledger Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Retention Ledger Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(RetentionRepeater)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Retention Legal Document"; "Retention Legal Document")
                {
                    ApplicationArea = All;
                }
                field("Retention No."; "Retention No.")
                {
                    ApplicationArea = All;
                }
                field("Retention Posting Date"; "Retention Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Amount Retention"; "Amount Retention")
                {
                    ApplicationArea = All;
                }
                field("Amount Retention LCY"; "Amount Retention LCY")
                {
                    ApplicationArea = All;
                }
                field("Amount Paid"; "Amount Paid")
                {
                    ApplicationArea = All;
                }
                field("Amount Paid LCY"; "Amount Paid LCY")
                {
                    ApplicationArea = All;
                }
                field("Amount Invoice"; "Amount Invoice")
                {
                    ApplicationArea = All;
                }
                field("Amount Invoice LCY"; "Amount Invoice LCY")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Reversed)
                {
                    ApplicationArea = All;
                }
                field("Reversion Date"; "Reversion Date")
                {
                    ApplicationArea = All;
                }
                field("Reversion Motive"; "Reversion Motive")
                {
                    ApplicationArea = All;
                }
                field("Electronic Status"; "Electronic Status")
                {
                    ApplicationArea = All;
                    Visible = ShowElectronic;
                }
                field("Electronic Response"; "Electronic Response")
                {
                    ApplicationArea = All;
                    Visible = ShowElectronic;
                }
                field("Elec. Response Description"; "Elec. Response Description")
                {
                    ApplicationArea = All;
                    Visible = ShowElectronic;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Navigation)
        {
            action(Detailed)
            {
                ApplicationArea = All;
                Caption = 'Detailed';
                Image = ViewDetails;
                RunObject = page "Detailed Retention Ledg. Entry";
                RunPageLink = "Retention No." = field("Retention No.");
            }
            action(RetentionReport)
            {
                ApplicationArea = All;
                Caption = 'Retention Report';
                Image = Report;
                RunObject = report "RET Retention Report";
            }
        }
        area(Processing)
        {
            group(RetentionActions)
            {
                Caption = 'Retention Action';
                action(Anulle)
                {
                    ApplicationArea = All;
                    Caption = 'Anulled';
                    Image = Cancel;
                    trigger OnAction()
                    begin
                        if IsEmpty then
                            exit;
                        if Reversed then
                            Error('La retención tiene el estado revertido.');
                        Reversed := true;
                        Modify();
                        Message('Retención N° %1 anulada correctamente.', "Retention No.");
                    end;
                }

                action(ElectronicReversed)
                {
                    ApplicationArea = All;
                    Caption = 'Electronic Reverse';
                    Image = Cancel;
                    trigger OnAction()
                    begin
                        if IsEmpty then
                            exit;
                        if Reversed then
                            Error('La retención tiene el estado revertido.');
                        Error('Proveedor de facturación electrónica no seleccionado.');
                        Validate(Reversed, true);
                        Modify();
                        Message('Retención N° %1 anulada correctamente.', "Retention No.");
                    end;
                }
            }
            group(GroupPDT626)
            {
                Caption = 'PDT 626';
                action(PDT626)
                {
                    ApplicationArea = All;
                    Caption = 'PDT - 626';
                    Image = Export1099;
                    trigger OnAction()
                    begin
                        RetentionMgt.CreatePDT626();
                    end;
                }
                action(ShowFilesPDT626)
                {
                    ApplicationArea = All;
                    Caption = 'Show File PDT';
                    Image = Table;
                    RunObject = page "ST Control File List";
                    RunPageLink = "File ID" = const('0626');
                }
            }

        }
    }

    trigger OnOpenPage()
    begin
        SLSetup.Get();
        ShowElectronic := SLSetup."Retention Agent Option" in [SLSetup."Retention Agent Option"::"Only Electronic", SLSetup."Retention Agent Option"::"Physical and Electronics"];
    end;

    var
        SLSetup: Record "Setup Localization";
        RetentionMgt: Codeunit "Retention Management";
        ShowElectronic: Boolean;
}