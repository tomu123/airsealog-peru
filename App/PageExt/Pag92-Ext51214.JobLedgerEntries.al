pageextension 51214 "ST Job Ledger Entries" extends "Job Ledger Entries"
{
    PromotedActionCategories = 'New,Process,Report,Entry,Industrial Seat', Comment = 'ESM="Nuevo,Proceso,Reporte,Mov.,Asiento Industrial"';

    layout
    {
        // Add changes to page layout here
        addafter("Dimension Set ID")
        {
            field("ST Sale Cost to process"; "ST Sale Cost to process")
            {
                ApplicationArea = All;
            }
            field("ST Sale Cost processed"; "ST Sale Cost processed")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("F&unctions")
        {
            group(IndustrialSeat)
            {
                action(SalesCostToProcess)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Cost to process', Comment = 'ESM="Procesar costo de venta"';
                    Image = PostApplication;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        if not Confirm('¿Desea procesar costo de venta?', false) then
                            exit;
                        SalesCostToProcess();
                    end;
                }
                action(MarkJobNonProcess)
                {
                    ApplicationArea = All;
                    Caption = 'Mark job non process', Comment = 'ESM="Marcar proy. no procesado"';
                    Image = SelectLineToApply;
                    Promoted = true;
                    //PromotedIsBig = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        if not Confirm('¿Desea marcar selección para proyecto no procesado?', false) then
                            exit;
                        MarkJobNonProcess();
                    end;
                }
                action(UnMarkJobNonProcess)
                {
                    ApplicationArea = All;
                    Caption = 'Unmark job non process', Comment = 'ESM="Desmarcar proy. no procesado"';
                    Image = RemoveLine;
                    Promoted = true;
                    //PromotedIsBig = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        if not Confirm('¿Desea desmarcar selección para proyecto no procesado?', false) then
                            exit;
                        UnMarkJobNonProcess();
                    end;
                }
                action(PostCV)
                {
                    ApplicationArea = All;
                    Caption = 'Post CV', Comment = 'ESM="Registrar CV"';
                    Image = Post;
                    Promoted = true;
                    //PromotedIsBig = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin

                    end;
                }
            }
        }
    }

    var
        myInt: Integer;

    local procedure SalesCostToProcess()
    begin
        Rec.CalcFields("ST Percentage Costed");
        if (not Rec."ST Sale Cost to process") and (Rec."ST Percentage Costed" <> 100) then begin
            Rec.Validate("ST Sale Cost to process", true);
            Rec.Modify();
            Message('Se procesará');
        end else
            if (Rec."ST Sale Cost to process") then begin
                Rec.Validate("ST Sale Cost to process", false);
                Rec.Modify();
                Message('No se procesará');
            end;
    end;

    local procedure MarkJobNonProcess()
    var
        JobLedgerEntry: Record "Job Ledger Entry";
        JobLedgerEntry2: Record "Job Ledger Entry";
        ProcessedJobLineCount: Integer;
    begin
        ProcessedJobLineCount := 0;
        JobLedgerEntry.CopyFilters(Rec);
        if JobLedgerEntry.FindFirst() then
            repeat
                if (not JobLedgerEntry."ST Sale Cost to process") and (not JobLedgerEntry."ST Sale Cost processed") and (JobLedgerEntry."Entry Type" <> JobLedgerEntry."Entry Type"::Sale) then begin
                    JobLedgerEntry2.Get(JobLedgerEntry."Entry No.");
                    JobLedgerEntry2."ST Sale Cost to process" := true;
                    JobLedgerEntry2.Modify();
                    ProcessedJobLineCount += 1;
                end;
            until JobLedgerEntry.Next() = 0;
        Message('Se ha marcado %1 lineas.', ProcessedJobLineCount);
    end;

    local procedure UnMarkJobNonProcess()
    var
        JobLedgerEntry: Record "Job Ledger Entry";
        JobLedgerEntry2: Record "Job Ledger Entry";
        ProcessedJobLineCount: Integer;
    begin
        ProcessedJobLineCount := 0;
        JobLedgerEntry.CopyFilters(Rec);
        if JobLedgerEntry.FindFirst() then
            repeat
                if (JobLedgerEntry."ST Sale Cost to process") and (not JobLedgerEntry."ST Sale Cost processed") and (JobLedgerEntry."Entry Type" <> JobLedgerEntry."Entry Type"::Sale) then begin
                    JobLedgerEntry2.Get(JobLedgerEntry."Entry No.");
                    JobLedgerEntry2."ST Sale Cost to process" := false;
                    JobLedgerEntry2.Modify();
                    ProcessedJobLineCount += 1;
                end;
            until JobLedgerEntry.Next() = 0;
        Message('Se ha desmarcado %1 lineas.', ProcessedJobLineCount);
    end;
}