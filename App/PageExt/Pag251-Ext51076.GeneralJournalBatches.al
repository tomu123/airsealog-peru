pageextension 51076 "ST General Journal Batches" extends "General Journal Batches"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Reason Code")
        {
            field("Is Batch Check"; "Is Batch Check")
            {
                ApplicationArea = All;
            }
            field("Bank Account No. FICO"; "Bank Account No. FICO")
            {
                ApplicationArea = All;
            }
        }

        //Payment Schedule Begin
        addlast(Control1)
        {
            field("OpenPaymentSchedule"; OpenPaymentScheduleCount)
            {
                ApplicationArea = All;
                Caption = 'Open Pay. Schedule';
                StyleExpr = StylePaymentSchedule;
                Editable = false;

                trigger OnAssistEdit();
                begin
                    GenerateJournalToPaymentSchedule;
                end;

                trigger OnDrillDown();
                begin
                    GenerateJournalToPaymentSchedule;
                end;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    GenerateJournalToPaymentSchedule;
                end;
            }
            field("OpenPaymentScheduleDetract"; OpenPaymentScheduleDetractionCount)
            {
                ApplicationArea = All;
                StyleExpr = StyleDetractionSchedule;
                Visible = false;

                trigger OnAssistEdit();
                begin
                    GenerateJournalToPaymentScheduleDetrac;
                end;

                trigger OnDrillDown();
                begin
                    GenerateJournalToPaymentScheduleDetrac;
                end;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    GenerateJournalToPaymentScheduleDetrac;
                end;
            }
        }
        //Payment Schedule End
    }

    trigger OnOpenPage()
    begin
        SLSetup.Get();
        DetractionPostingGroup := SLSetup."Detraction Posting Group";
    end;

    trigger OnAfterGetRecord()
    begin
        OpenPaymentScheduleCount := GetCountOpenPaymentSchedule("Bank Account No. FICO");
        if OpenPaymentScheduleCount <> 0 then
            StylePaymentSchedule := 'Unfavorable'
        else
            StylePaymentSchedule := 'StandardAccent';

        OpenPaymentScheduleDetractionCount := GetCountOpenPaymentScheduleDetrac('');
        if OpenPaymentScheduleDetractionCount <> 0 then
            StyleDetractionSchedule := 'Unfavorable'
        else
            StyleDetractionSchedule := 'StandardAccent';
    end;

    var
        SLSetup: Record "Setup Localization";
        ReportPrint: Codeunit "Test Report-Print";
        GenJnlManagement: Codeunit GenJnlManagement;
        IsPaymentTemplate: Boolean;
        OpenPaymentScheduleCount: Integer;
        OpenPaymentScheduleDetractionCount: Integer;
        gCRONOpendientes: Integer;
        gANTICIPOSPendientes: Integer;
        cuMPUtilities: Codeunit "Payment Schedule Utility";
        StylePaymentSchedule: Text;
        StyleDetractionSchedule: Text;
        gStyleAnticipos: Text;
        recGLSetup: Record "General Ledger Setup";
        DetractionPostingGroup: Code[30];
        recGenJBacth: Record "Gen. Journal Batch";
        gEnableActionSchedulePayment: Boolean;

    local procedure GetCountOpenPaymentSchedule(pBankAccountNo: Code[20]): Integer;
    var
        PaymentSchedule: Record "Payment Schedule";
        GenJnlTemplate: Record "Gen. Journal Template";
    begin
        GenJnlTemplate.Reset();
        GenJnlTemplate.SetRange(Type, GenJnlTemplate.Type::Payments);
        GenJnlTemplate.SetRange(Name, "Journal Template Name");
        if GenJnlTemplate.IsEmpty then
            exit(0);

        PaymentSchedule.Reset();
        PaymentSchedule.SetFilter(Status, '%1|%2',
                                              PaymentSchedule.Status::Procesado,
                                              PaymentSchedule.Status::"Por Pagar");
        case true of
            (Name = 'DETRAC') and (not "Is Batch Check"):
                begin
                    PaymentSchedule.SetRange("Posting Group", DetractionPostingGroup);
                    //PaymentSchedule.SetRange("Is Payment Check",false);
                end;
            (Name <> 'DETRAC') and (not "Is Batch Check") and ("Bank Account No. FICO" <> ''):
                begin
                    PaymentSchedule.SetRange("Reference Bank Acc. No.", "Bank Account No. FICO");
                    PaymentSchedule.SetRange("Is Payment Check", false);
                    PaymentSchedule.SetFilter("Posting Group", '<>%1', DetractionPostingGroup);
                end;
            (Name <> 'DETRAC') and ("Is Batch Check"):
                begin
                    PaymentSchedule.SetRange("Is Payment Check", true);
                    PaymentSchedule.SetFilter("Posting Group", '<>%1', DetractionPostingGroup);
                end;
        end;
        exit(PaymentSchedule.COUNT);
    end;

    local procedure GetCountOpenPaymentScheduleDetrac(pBankAccountNo: Code[20]): Integer;
    var
        PaymentSchedule: Record "Payment Schedule";
    begin
        //--CASO 2 PendIENTES PAGO DETRACCIONES
        PaymentSchedule.Reset();
        PaymentSchedule.SetFilter(PaymentSchedule.Status, '%1|%2', PaymentSchedule.Status::Procesado, PaymentSchedule.Status::"Por Pagar");
        PaymentSchedule.SetRange(PaymentSchedule."Reference Bank Acc. No.", pBankAccountNo);
        PaymentSchedule.SetRange("Posting Group", DetractionPostingGroup);
        OpenPaymentScheduleDetractionCount := (PaymentSchedule.COUNT);
        if OpenPaymentScheduleDetractionCount > 0 then
            StyleDetractionSchedule := 'Unfavorable'
        else
            StyleDetractionSchedule := 'StandardAccent';


        exit(PaymentSchedule.Count);
    end;

    local procedure GenerateJournalToPaymentSchedule();
    var
        PaymentSchedule: Record "Payment Schedule";
    begin
        if GetCountOpenPaymentSchedule(Name) > 0 then begin
            case true of
                (Name = 'DETRAC'): //and (not "Is Batch Check")
                    PaymentSchedule.fnCreateJnlLine("Journal Template Name", Name, DetractionPostingGroup, true);
                (Name <> 'DETRAC') and (not "Is Batch Check") and ("Bank Account No. FICO" <> ''):
                    PaymentSchedule.fnCreateJnlLine("Journal Template Name", Name, DetractionPostingGroup, false);
                (Name <> 'DETRAC') and ("Is Batch Check"):
                    begin
                        PaymentSchedule.fnSetIsCheck("Is Batch Check");
                        PaymentSchedule.fnCreateJnlLine("Journal Template Name", Name, DetractionPostingGroup, false);
                    end;
            end;
            //   if Name = DetractionPostingGroup then begin
            //      PaymentSchedule.fnCreateJnlLine("Journal Template Name",Name,DetractionPostingGroup,true);
            //   end else begin
            //      PaymentSchedule.fnSetIsCheck("Is Batch Check");
            //      PaymentSchedule.fnCreateJnlLine("Journal Template Name",Name,DetractionPostingGroup,false);
            //   end;
        end;
    end;

    local procedure GenerateJournalToPaymentScheduleDetrac();
    var
        PaymentSchedule: Record "Payment Schedule";
    begin
        if GetCountOpenPaymentScheduleDetrac(Name) > 0 then begin
            PaymentSchedule.fnCreateJnlLine("Journal Template Name", Name, DetractionPostingGroup, true);
        end;
    end;
}