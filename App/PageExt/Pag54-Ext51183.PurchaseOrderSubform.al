pageextension 51183 "PR Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here

        //Purchase Request
        addafter("Nonstock")
        {
            // control with underlying datasource
            field("Importation No."; "Importation No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(SelectMultiItems)
        {
            action(PRConsultBudget)
            {
                ApplicationArea = All;
                Caption = 'Consult Budget', Comment = 'ESM="Consultar presupuesto"';
                Image = LedgerBudget;
                Visible = true;
                trigger OnAction()
                var
                begin
                    ConsultBudget;
                end;
            }
        }
    }

    var
        DocType: Boolean;
        BudgetName: code[20];

    procedure ConsultBudget()
    var
        ConsultBudget: Page "PR ConsultBudget";
        DimSetEntry: Record "Dimension Set Entry";
        DimValue: Record "Dimension Value";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLineAll: Record "Purchase Line";
        PurchaseLineBuffer: Record "PR Purch. Line Buffer" temporary;
        EntryNo: Integer;
        DimCodePPTO: Code[20];
        DocNo: Code[20];
        StatusPO: Code[20];
    begin
        PurchaseLineBuffer.Reset();
        PurchaseLineBuffer.DeleteAll();

        PurchaseLineAll.Reset();
        PurchaseLineAll.SetRange("Document Type", PurchaseLineAll."Document Type"::Order);
        PurchaseLineAll.SetRange("Document No.", "Document No.");
        if PurchaseLineAll.FindSet() then begin
            repeat
                if PurchaseHeader.get(PurchaseHeader."Document Type"::Order, PurchaseLineAll."Document No.") then
                    StatusPO := Format(PurchaseHeader.Status);

                DimValue.SetRange("Dimension Code", 'PPTO');
                DimValue.SetRange("Dimension Value Type", DimValue."Dimension Value Type"::Standard);
                DimValue.SetRange(Blocked, false);
                if DimValue.FindSet() then
                    repeat
                        if DimSetEntry.Get(PurchaseLineAll."Dimension Set ID", DimValue."Dimension Code") then begin
                            EntryNo += 1;
                            DimCodePPTO := DimSetEntry."Dimension Value Code";
                            DocNo := PurchaseLineAll."Document No.";
                            PurchaseLineBuffer.Reset();
                            PurchaseLineBuffer.SetRange(DimPPTO, DimCodePPTO);
                            PurchaseLineBuffer.SetRange("Line No.", PurchaseLineAll."Line No.");
                            if PurchaseLineBuffer.IsEmpty then begin
                                PurchaseLineBuffer.Init();
                                PurchaseLineBuffer.TransferFields(PurchaseLineAll, true);
                                PurchaseLineBuffer.EntryNo := EntryNo;
                                PurchaseLineBuffer.DimPPTO := DimCodePPTO;
                                PurchaseLineBuffer."Dimension Name" := DimValue.Name;
                                PurchaseLineBuffer.Amount1 := SetAmountBudgedCode(DimCodePPTO);
                                PurchaseLineBuffer.Amount2 := SetAmountPurchaseOrders(DimCodePPTO, DocNo);
                                PurchaseLineBuffer.NamePPTO := BudgetName;
                                PurchaseLineBuffer."Net Budget Balance" := PurchaseLineBuffer.Amount1 - PurchaseLineBuffer.Amount2 - PurchaseLineBuffer.Amount;
                                PurchaseLineBuffer."Status within Budget" := PurchaseLineBuffer."Net Budget Balance" < 0;
                                PurchaseLineBuffer.Insert();
                            end;
                        end;
                    until DimValue.NEXT = 0;
            until PurchaseLineAll.NEXT = 0;
        end;

        ConsultBudget.SetRecord(PurchaseLineBuffer);
        ConsultBudget.LookupMode(true);
        ConsultBudget.SetRecordTemp(PurchaseLineBuffer);
        ConsultBudget.Run();

        PurchaseLineBuffer.Reset();
        PurchaseLineBuffer.DeleteAll();
        Clear(PurchaseLineBuffer);
    end;

    procedure ConsultBudget_old()
    var
        ConsultBudget: Page "PR ConsultBudget";
        DimSetEntry: Record "Dimension Set Entry";
        DimValue: Record "Dimension Value";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLineAll: Record "Purchase Line";
        PurchaseLineBuffer: Record "PR Purch. Line Buffer" temporary;
        EntryNo: Integer;
        DimCodePPTO: Code[20];
        DocNo: Code[20];
        StatusPO: Code[20];
    begin
        PurchaseLineBuffer.Reset();
        PurchaseLineBuffer.DeleteAll();
        PurchaseLineAll.Reset();
        PurchaseLineAll.SetRange("Document Type", PurchaseLineAll."Document Type"::Order);
        PurchaseLineAll.SetRange("Document No.", "Document No.");
        if PurchaseLineAll.FindSet() then begin
            repeat
                if PurchaseHeader.get(PurchaseHeader."Document Type"::Order, PurchaseLineAll."Document No.") then
                    StatusPO := Format(PurchaseHeader.Status);

                DimValue.SetRange("Dimension Code", 'PPTO');
                DimValue.SetRange("Dimension Value Type", DimValue."Dimension Value Type"::Standard);
                DimValue.SetRange(Blocked, false);
                if DimValue.FindSet() then begin
                    repeat
                        if DimSetEntry.Get(PurchaseLineAll."Dimension Set ID", DimValue."Dimension Code") then begin
                            EntryNo += 1;
                            DimCodePPTO := DimSetEntry."Dimension Value Code";
                            DocNo := PurchaseLineAll."Document No.";
                            PurchaseLineBuffer.Reset();
                            PurchaseLineBuffer.SetRange(DimPPTO, DimCodePPTO);
                            if not PurchaseLineBuffer.FindFirst() then begin
                                PurchaseLineBuffer.Init();
                                PurchaseLineBuffer.TransferFields(PurchaseLineAll, true);
                                PurchaseLineBuffer.EntryNo := EntryNo;
                                PurchaseLineBuffer.DimPPTO := DimCodePPTO;
                                PurchaseLineBuffer."Dimension Name" := DimValue.Name;
                                PurchaseLineBuffer.Amount1 := SetAmountBudgedCode(DimCodePPTO);
                                PurchaseLineBuffer.Amount2 := SetAmountPurchaseOrders(DimCodePPTO, DocNo);
                                PurchaseLineBuffer.NamePPTO := BudgetName;
                                PurchaseLineBuffer.Insert();
                            end;
                        end;
                    until DimValue.NEXT = 0;
                end;
            until PurchaseLineAll.NEXT = 0;
        end;

        ConsultBudget.SetRecord(PurchaseLineBuffer);
        ConsultBudget.LookupMode(true);
        ConsultBudget.SetRecordTemp(PurchaseLineBuffer);
        ConsultBudget.Run();

        PurchaseLineBuffer.Reset();
        PurchaseLineBuffer.DeleteAll();
        Clear(PurchaseLineBuffer);
    end;

    procedure SetAmountBudgedCode(Var DimPPTOs: Code[20]) AmountBudgetPO: Decimal
    var
        GLBudgetName: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        GLBudgetName.SetRange(Blocked, false);
        if GLBudgetName.FindFirst() then begin
            BudgetName := GLBudgetName.Name;
            GLBudgetEntry.SetRange("Budget Name", GLBudgetName.Name);
            GLBudgetEntry.SetRange("Budget Dimension 1 Code", DimPPTOs);
            GLBudgetEntry.CalcSums(Amount);
            AmountBudgetPO := GLBudgetEntry.Amount;
        end;
        exit(AmountBudgetPO);
    end;

    procedure SetAmountPurchaseOrders(Var DimPPTOs: Code[20]; var DocNo: Code[20]) AmountPurchaseOrder: Decimal
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLineAll: Record "Purchase Line";
        DimSetEntry: Record "Dimension Set Entry";
    begin
        AmountPurchaseOrder := 0;
        PurchaseLineAll.SetRange("Document Type", PurchaseLineAll."Document Type"::Order);
        if PurchaseLineAll.FindSet() then begin
            repeat
                // if PurchaseLineAll."Document No." <> DocNo then begin
                PurchaseHeader.SetRange("No.", PurchaseLineAll."Document No.");
                PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
                if PurchaseHeader.FindFirst() then begin
                    DimSetEntry.SetRange("Dimension Code", 'PPTO');
                    DimSetEntry.SetRange("Dimension Set ID", PurchaseLineAll."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Value Code", DimPPTOs);
                    if DimSetEntry.FindFirst() then begin
                        AmountPurchaseOrder += PurchaseLineAll.Amount
                    end;
                end;
            // end;
            until PurchaseLineAll.NEXT = 0;
            exit(AmountPurchaseOrder);
        end;
    end;
}