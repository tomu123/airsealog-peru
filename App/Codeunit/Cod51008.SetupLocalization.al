codeunit 51008 "Setup Localization"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo', '', true, true)]
    local procedure SetOnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        GenJournalLine."Posting Group" := CustLedgerEntry."Customer Posting Group";
        GenJournalLine."Source Currency Factor" := CustLedgerEntry."Source Currency Factor";
        GenJournalLine."External Document No." := CustLedgerEntry."External Document No.";
        GenJournalLine."Dimension Set ID" := CustLedgerEntry."Dimension Set ID";
        GenJournalLine."Shortcut Dimension 1 Code" := CustLedgerEntry."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := CustLedgerEntry."Global Dimension 2 Code";
        GenJournalLine."Applies-to Entry No." := CustLedgerEntry."Entry No.";
        GenJournalLine.Validate("Currency Code", CustLedgerEntry."Currency Code");
        if GenJournalLine."Posting Text" = '' then
            GenJournalLine."Posting Text" := CustLedgerEntry."Posting Text";
        GenJournalLine.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnLookUpAppliesToDocVendOnAfterUpdateDocumentTypeAndAppliesTo', '', true, true)]
    local procedure SetOnLookUpAppliesToDocVendOnAfterUpdateDocumentTypeAndAppliesTo(var GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        GenJournalLine."Posting Group" := VendorLedgerEntry."Vendor Posting Group";
        GenJournalLine."Source Currency Factor" := VendorLedgerEntry."Source Currency Factor";
        GenJournalLine."External Document No." := VendorLedgerEntry."External Document No.";
        GenJournalLine."Dimension Set ID" := VendorLedgerEntry."Dimension Set ID";
        GenJournalLine."Shortcut Dimension 1 Code" := VendorLedgerEntry."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := VendorLedgerEntry."Global Dimension 2 Code";
        GenJournalLine."Applies-to Entry No." := VendorLedgerEntry."Entry No.";
        GenJournalLine.Validate("Currency Code", VendorLedgerEntry."Currency Code");
        if GenJournalLine."Posting Text" = '' then
            GenJournalLine."Posting Text" := VendorLedgerEntry."Posting Text";
        GenJournalLine.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnLookUpAppliesToDocEmplOnAfterUpdateDocumentTypeAndAppliesTo', '', true, true)]
    local procedure SetOnLookUpAppliesToDocEmplOnAfterUpdateDocumentTypeAndAppliesTo(var GenJournalLine: Record "Gen. Journal Line"; EmployeeLedgerEntry: Record "Employee Ledger Entry")
    begin
        GenJournalLine."Posting Group" := EmployeeLedgerEntry."Employee Posting Group";
        GenJournalLine."Source Currency Factor" := EmployeeLedgerEntry."Source Currency Factor";
        GenJournalLine."External Document No." := EmployeeLedgerEntry."External Document No.";
        GenJournalLine."Dimension Set ID" := EmployeeLedgerEntry."Dimension Set ID";
        GenJournalLine."Shortcut Dimension 1 Code" := EmployeeLedgerEntry."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := EmployeeLedgerEntry."Global Dimension 2 Code";
        GenJournalLine."Applies-to Entry No." := EmployeeLedgerEntry."Entry No.";
        GenJournalLine.Validate("Currency Code", EmployeeLedgerEntry."Currency Code");
        if GenJournalLine."Posting Text" = '' then
            GenJournalLine."Posting Text" := EmployeeLedgerEntry."Posting Text";
        GenJournalLine.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnGetVendLedgerEntryOnAfterAssignVendorNo', '', false, false)]
    local procedure OnGetVendLedgerEntryOnAfterAssignVendorNo(var GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        if GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Vendor then
            exit;
        if GenJournalLine."Applies-to Entry No." <> 0 then
            VendorLedgerEntry.SetRange("Entry No.", GenJournalLine."Applies-to Entry No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnGetCustLedgerEntryOnAfterAssignCustomerNo', '', false, false)]
    local procedure OnGetCustLedgerEntryOnAfterAssignCustomerNo(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        if GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Customer then
            exit;
        if GenJournalLine."Applies-to Entry No." <> 0 then
            CustLedgerEntry.SetRange("Entry No.", GenJournalLine."Applies-to Entry No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPrepareTempCustLedgEntryOnAfterSetFilters', '', true, true)]
    local procedure SetOnPrepareTempCustLedgEntryOnAfterSetFilters(var OldCustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        if GenJournalLine."Applies-to Entry No." <> 0 then
            OldCustLedgerEntry.SetRange("Entry No.", GenJournalLine."Applies-to Entry No.");
    end;

    [EventSubscriber(ObjectType::CodeUnit, Codeunit::"Gen. Jnl.-Post Line", 'OnPrepareTempVendLedgEntryOnAfterSetFilters', '', true, true)]
    local procedure OnPrepareTempVendLedgEntryOnAfterSetFilters(var OldVendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        if GenJournalLine."Applies-to Entry No." <> 0 then
            OldVendorLedgerEntry.SetRange("Entry No.", GenJournalLine."Applies-to Entry No.");
    end;

    // [EventSubscriber(ObjectType::CodeUnit, Codeunit::"Gen. Jnl.-Post Line", 'OnPrepareTempEmplLedgEntryOnAfterSetFilters', '', true, true)]
    // local procedure OnPrepareTempEmplLedgEntryOnAfterSetFilters(var OldEmplLedgerEntry: Record "Employee Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    // begin
    //     if GenJournalLine."Applies-to Entry No." <> 0 then
    //         OldEmplLedgerEntry.SetRange("Entry No.", GenJournalLine."Applies-to Entry No.");
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure SetOnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean)
    var
        CurrExc: Record "Currency Exchange Rate";
        CurrExchangeEmpty: Label 'The exchange rate does not exist.', Comment = 'ESM="El tipo de cambio no existe."';
    begin
        CurrExc.Reset();
        CurrExc.SetRange("Starting Date", PurchaseHeader."Posting Date");
        CurrExc.SetRange("Currency Code", 'USD');
        if CurrExc.IsEmpty then
            Error(CurrExchangeEmpty);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure SetOnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    var
        CurrExc: Record "Currency Exchange Rate";
        CurrExchangeEmpty: Label 'The exchange rate does not exist.', Comment = 'ESM="El tipo de cambio no existe."';
    begin
        CurrExc.Reset();
        CurrExc.SetRange("Starting Date", SalesHeader."Posting Date");
        CurrExc.SetRange("Currency Code", 'USD');
        if CurrExc.IsEmpty then
            Error(CurrExchangeEmpty);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure SetOnAfterSubstituteReport(ReportId: Integer; RunMode: Option Normal,ParametersOnly,Execute,Print,SaveAs,RunModal; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    begin
        STSetup.Get();
        if not STSetup."Adj. Exch. Rate Localization" then
            exit;
        //if ReportId = 595 then
        //    NewReportId := 51013;
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', True, True)]
    procedure SetCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    var
        codeunit90: codeunit 12;
    begin
        GLEntry."Posting Text" := GenJournalLine."Posting Text";
        GLEntry."Applies-to Acc. Group Mixed" := GenJournalLine."Applies-to Acc. Group Mixed";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    procedure OnAfterCopyGenJnlLineFromPurchHeaderExtends(PurchaseHeader: Record "Purchase Header"; VAR GenJournalLine: Record "Gen. Journal Line");
    begin
        GenJournalLine."Posting Text" := PurchaseHeader."Posting Text";
        //GenJournalLine."Applies-to Acc. Group Mixed" := SetAccountantGroupMixed(PurchaseHeader);
    end;

    procedure SetAccountantGroupMixed(PurchaseHeader: Record "Purchase Header"): Boolean
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        if (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Invoice) or (PurchaseHeader."Applies-to Entry No." = 0) then
            exit(false);
        VendLedgEntry.Get(PurchaseHeader."Applies-to Entry No.");
        exit(PurchaseHeader."Vendor Posting Group" <> VendLedgEntry."Vendor Posting Group");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure SetOnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Posting Text" := SalesHeader."Posting Text";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    procedure OnAfterCopyVendLedgerEntryFromGenJnlLineExtends(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        VendorLedgerEntry."Posting Text" := GenJournalLine."Posting Text";
        //VendorLedgerEntry."Applies-to Acc. Group Mixed" := GenJournalLine."Applies-to Acc. Group Mixed";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    procedure OnAfterCopyCustLedgerEntryFromGenJnlLineExtends(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Posting Text" := GenJournalLine."Posting Text";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Employee Ledger Entry", 'OnAfterCopyEmployeeLedgerEntryFromGenJnlLine', '', true, true)]
    procedure SetOnAfterCopyEmployeeLedgerEntryFromGenJnlLine(var EmployeeLedgerEntry: Record "Employee Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        EmployeeLedgerEntry."Posting Text" := GenJournalLine."Posting Text";
        EmployeeLedgerEntry."Payment Bank Account No." := GenJournalLine."Payment Bank Account No.";
        EmployeeLedgerEntry."Payment is check" := GenJournalLine."Payment is check";
        EmployeeLedgerEntry."Currency Code" := GenJournalLine."Currency Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Employee Ledger Entry", 'OnAfterCopyEmplLedgerEntryFromCVLedgEntryBuffer', '', true, true)]
    local procedure SetOnAfterCopyEmplLedgerEntryFromCVLedgEntryBuffer(var EmployeeLedgerEntry: Record "Employee Ledger Entry"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        EmployeeLedgerEntry."Closed by Currency Code" := CVLedgerEntryBuffer."Closed by Currency Code";
        EmployeeLedgerEntry."Closed by Currency Amount" := CVLedgerEntryBuffer."Closed by Currency Amount";
        EmployeeLedgerEntry."Adjusted Currency Factor" := CVLedgerEntryBuffer."Adjusted Currency Factor";
        EmployeeLedgerEntry."Original Currency Factor" := CVLedgerEntryBuffer."Original Currency Factor";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnBeforeApplyStdCodesToSalesLines', '', false, false)]
    local procedure SetOnBeforeApplyStdCodesToSalesLines(var SalesLine: Record "Sales Line"; StdSalesLine: Record "Standard Sales Line")
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Standard Vendor Purchase Code", 'OnBeforeApplyStdCodesToPurchaseLines', '', false, false)]
    local procedure SetOnBeforeApplyStdCodesToPurchaseLines(var PurchLine: Record "Purchase Line"; StdPurchLine: Record "Standard Purchase Line")
    var
        StandVendPurchCode: Record "Standard Vendor Purchase Code";
        Codeunit12: Codeunit 12;
    begin
        PurchLine."Purchase Standard Code" := StdPurchLine."Standard Purchase Code";
        PurchLine.Description := StdPurchLine.Description;
        if StandVendPurchCode.Get(PurchLine."Buy-from Vendor No.", StdPurchLine."Standard Purchase Code") then
            if StandVendPurchCode.Description <> '' then
                PurchLine.Description := StandVendPurchCode.Description;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeConfirmUpdateCurrencyFactor', '', false, false)]
    local procedure OnBeforeConfirmUpdateCurrencyFactor(PurchaseHeader: Record "Purchase Header"; var HideValidationDialog: Boolean)
    begin
        HideValidationDialog := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeUpdatePurchLinesByFieldNo', '', false, false)]
    local procedure SetOnBeforeUpdatePurchLinesByFieldNo(var PurchaseHeader: Record "Purchase Header"; ChangedFieldNo: Integer; var AskQuestion: Boolean; var IsHandled: Boolean)
    begin
        if ChangedFieldNo = 33 then
            AskQuestion := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeUpdateCurrencyFactor', '', false, false)]
    local procedure SetOnBeforeUpdateCurrencyFactor(var PurchaseHeader: Record "Purchase Header"; var Updated: Boolean)
    var
        CurrExchRate: Record "Currency Exchange Rate";
        OldCurrencyFactor: Decimal;
        ConfirmManagement: Codeunit "Confirm Management";
        UpdateCurrencyExchangeRates: Codeunit "Update Currency Exchange Rates";
        CurrencyDate: Date;
        MissingExchangeRatesQst: Label 'There are no exchange rates for currency %1 and date %2. Do you want to add them now? Otherwise, the last change you made will be reverted.', Comment = '%1 - currency code, %2 - posting date';
    begin
        OldCurrencyFactor := PurchaseHeader."Currency Factor";
        if PurchaseHeader."Currency Code" <> '' then begin
            if PurchaseHeader."Document Date" <> 0D then
                CurrencyDate := PurchaseHeader."Document Date";
            if CurrencyDate = 0D then
                if PurchaseHeader."Posting Date" <> 0D then
                    CurrencyDate := PurchaseHeader."Posting Date";
            if CurrencyDate = 0D then
                CurrencyDate := WorkDate();

            if UpdateCurrencyExchangeRates.ExchangeRatesForCurrencyExist(CurrencyDate, PurchaseHeader."Currency Code") then begin
                PurchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, PurchaseHeader."Currency Code");
                if PurchaseHeader."Currency Code" <> '' then begin
                    PurchaseHeader.SetHideValidationDialog(true);
                    PurchaseHeader.RecreatePurchLines(PurchaseHeader.FieldCaption("Currency Code"));
                    PurchaseHeader.SetHideValidationDialog(false);
                end;
            end else begin
                if ConfirmManagement.GetResponseOrDefault(
                     StrSubstNo(MissingExchangeRatesQst, PurchaseHeader."Currency Code", CurrencyDate), true)
                then begin
                    UpdateCurrencyExchangeRates.OpenExchangeRatesPage(PurchaseHeader."Currency Code");
                    PurchaseHeader.UpdateCurrencyFactor();
                end else
                    Error('Tipo de cambio de existe.');
            end;
            if OldCurrencyFactor <> PurchaseHeader."Currency Factor" then
                Message('Se modificado el tipo de cambio a la fecha %1', CurrencyDate);
        end else begin
            PurchaseHeader."Currency Factor" := 0;
            PurchaseHeader.SetHideValidationDialog(true);
            PurchaseHeader.RecreatePurchLines(PurchaseHeader.FieldCaption("Currency Code"));
            PurchaseHeader.SetHideValidationDialog(false);
        end;
        Updated := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Find Record Management", 'OnBeforeFindLastEntryIgnoringSecurityFilter', '', true, true)]
    local procedure SetOnBeforeFindLastEntryIgnoringSecurityFilter(var RecRef: RecordRef; var Found: Boolean; var IsHandled: Boolean)
    var
        xSecurityFilter: SecurityFilter;
        TableID: Integer;
        GLEntryEntryNo: Record "G/L Entry";
        GLEntryTransactionNo: Record "G/L Entry";
        STGLEntryControl: Record "ST G/L Entry - Control";
        FieldReff: FieldRef;
    begin
        TableID := RecRef.Number;
        if TableID <> 17 then
            exit;
        GLEntryEntryNo.SetCurrentKey("Entry No.");
        if not GLEntryEntryNo.FindLast() then
            exit;


        GLEntryTransactionNo.SetCurrentKey("Transaction No.");
        GLEntryTransactionNo.FindLast();

        STGLEntryControl.Reset();
        STGLEntryControl.DeleteAll();

        STGLEntryControl.Init();
        STGLEntryControl."Entry No. 2" := 1;
        STGLEntryControl."Entry No." := GLEntryEntryNo."Entry No.";
        STGLEntryControl."Transaction No." := GLEntryTransactionNo."Transaction No.";
        STGLEntryControl.Insert();

        Clear(RecRef);
        RecRef.GetTable(STGLEntryControl);
        RecRef.Reset();
        with RecRef do begin
            xSecurityFilter := SecurityFiltering;
            SecurityFiltering(SecurityFiltering::Ignored);
            Found := FindLast();
            if SecurityFiltering <> xSecurityFilter then
                SecurityFiltering(xSecurityFilter)
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostDtldCVLedgEntryOnBeforeCreateGLEntryGainLoss', '', false, false)]
    local procedure SetOnPostDtldCVLedgEntryOnBeforeCreateGLEntryGainLoss(var GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var Unapply: Boolean; var AccNo: Code[20])
    var
        MasterData: Record "Master Data";
        SLSetup: Record "Setup Localization";
        DimSetEntry: Record "Dimension Set Entry";
        DimMgt: Codeunit DimensionManagement;
        GlobalDimensionNo: Integer;
    begin
        SLSetup.Get();
        if AccNo in [SLSetup."ST GL Account Realized Gain", SLSetup."ST GL Account Realized Loss"] then begin
            MasterData.Reset();
            MasterData.SetRange("Type Table", 'ADJ-TC-REF');
            MasterData.SetRange("Type Table ref", 'ADJ-TC');
            MasterData.SetRange("Code ref", AccNo);
            if MasterData.FindFirst() then
                repeat
                    GlobalDimensionNo := GetDimensionNo(MasterData."Dimension Code", MasterData."Dimension Value Code");
                    case GlobalDimensionNo of
                        1:
                            GenJournalLine."Shortcut Dimension 1 Code" := MasterData."Dimension Value Code";
                        2:
                            GenJournalLine."Shortcut Dimension 2 Code" := MasterData."Dimension Value Code";
                    end;
                    DimMgt.ValidateShortcutDimValues(GlobalDimensionNo, MasterData."Dimension Value Code", GenJournalLine."Dimension Set ID");
                until MasterData.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterSettingIsTransactionConsistent', '', false, false)]
    local procedure SetOnAfterSettingIsTransactionConsistent(GenJournalLine: Record "Gen. Journal Line"; var IsTransactionConsistent: Boolean)
    begin
        //if CompanyName = 'AJUSTE-TC' then begin
        //    IsTransactionConsistent := true;
        //end;
    end;

    //Correct for error Employee Ledger Entries
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostDtldCVLedgEntry', '', false, false)]
    local procedure SetOnBeforePostDtldCVLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var AccNo: Code[20]; Unapply: Boolean; var AdjAmount: array[4] of Decimal)
    var
        EmplPostingGroup: Record "Employee Posting Group";
    begin
        if (GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Employee) or (GenJournalLine."Posting Group" = '') then
            exit;

        with DetailedCVLedgEntryBuffer do
            case "Entry Type" of
                "Entry Type"::"Initial Entry", "Entry Type"::Application:
                    if EmplPostingGroup.Get(GenJournalLine."Posting Group") then
                        AccNo := EmplPostingGroup.GetPayablesAccount();
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterAppliesToDocNoOnLookup', '', true, true)]
    procedure OnAfterAppliesToDocNoOnLookup(var PurchaseHeader: Record "Purchase Header"; VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        PurchaseHeader."Applies-to Entry No." := VendorLedgerEntry."Entry No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure SetOnAfterInitGLEntry(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    var
        DimSetEntry: Record "Dimension Set Entry";
        GlobalDimensionNo: Integer;
    begin
        DimSetEntry.Reset();
        DimSetEntry.SetRange("Dimension Set ID", GenJournalLine."Dimension Set ID");
        if DimSetEntry.FindFirst() then
            repeat
                GlobalDimensionNo := GetDimensionNo(DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                case GlobalDimensionNo of
                    3:
                        GLEntry."Global Dimension 3 Code" := DimSetEntry."Dimension Value Code";
                    4:
                        GLEntry."Global Dimension 4 Code" := DimSetEntry."Dimension Value Code";
                    5:
                        GLEntry."Global Dimension 5 Code" := DimSetEntry."Dimension Value Code";
                    6:
                        GLEntry."Global Dimension 6 Code" := DimSetEntry."Dimension Value Code";
                    7:
                        GLEntry."Global Dimension 7 Code" := DimSetEntry."Dimension Value Code";
                    8:
                        GLEntry."Global Dimension 8 Code" := DimSetEntry."Dimension Value Code";
                end;
            until DimSetEntry.Next() = 0;
    end;

    procedure GetDimensionNo(DimensionCode: Code[20]; DimValueCode: Code[20]): Integer
    var
        DimValue: Record "Dimension Value";
    begin
        DimValue.Get(DimensionCode, DimValueCode);
        exit(DimValue."Global Dimension No.")
    end;
    //RPA++
    procedure "#GetDimensionsSetup"(ParIntI: Integer): Code[20]
    var
        lclI: Integer;
        lclDimGlobal: array[10] of Code[20];
    begin
        //BEGIN ULN::JLM 001 ++
        CLEAR(lclDimGlobal);

        fnMyGetGLSetup;
        FOR lclI := 1 TO 10 DO BEGIN
            lclDimGlobal[lclI] := GLSetupShortcutDimCode[lclI];
        END;

        EXIT(lclDimGlobal[ParIntI]);
        //END ULN::JLM 001 ++

    end;

    procedure fnMyGetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
        lclHasGotGLSetup: Boolean;
    begin
        IF NOT lclHasGotGLSetup THEN BEGIN
            GLSetup.GET;
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            lclHasGotGLSetup := TRUE;
        END;
    end;

    procedure fnMyGetDimensionSetID(VAR DimSetEntry2: Record "Dimension Set Entry"): Integer
    var
        lclrecDimSetEntry: Record "Dimension Set Entry";
    begin
        EXIT(lclrecDimSetEntry.GetDimensionSetID(DimSetEntry2));
    end;
    //RPA++
    procedure ViewRestrictBankAccountList(var BankAccNo: Code[20]; var CurrentCode: Code[10]; LookUpMode: Boolean)
    var
        RestricteBankAccList: Page "ST Restrict Bank Account List";
        BankAcc: Record "Bank Account";
    begin
        Clear(RestricteBankAccList);
        BankAcc.Reset();
        BankAcc.SetRange("Currency Code", CurrentCode);
        RestricteBankAccList.LookupMode(LookUpMode);
        RestricteBankAccList.Editable(false);
        RestricteBankAccList.SetTableView(BankAcc);
        RestricteBankAccList.SetRecord(BankAcc);
        if RestricteBankAccList.RunModal() in [Action::LookupOK, Action::OK, Action::Yes] then begin
            RestricteBankAccList.GetRecord(BankAcc);
            BankAccNo := BankAcc."No.";
            CurrentCode := BankAcc."Currency Code";
        end;
    end;

    procedure SetPasswordEncryp(Password: Text)
    var
        CodeText: Code[20];
        ResponseEncrypt: Text;
    begin
        CodeText := 'Renato';
        CreateEncryptionKey();
        ResponseEncrypt := Encrypt(CodeText);
        Message(ResponseEncrypt);
    end;

    procedure AlertAndViewWhitNotification(Message: Text; ShowText: Text; CodeunitID: Integer; FunctionName: Text; Parameter: array[4] of Text; ValueParameter: array[4] of Text)
    begin
        Notification.Message(Message);
        Notification.Scope := NotificationScope::LocalScope;

        if (Parameter[1] <> '') and (ValueParameter[1] <> '') then
            Notification.SetData(Parameter[1], ValueParameter[1]);

        if (Parameter[2] <> '') and (ValueParameter[2] <> '') then
            Notification.SetData(Parameter[2], ValueParameter[2]);

        if (Parameter[3] <> '') and (ValueParameter[3] <> '') then
            Notification.SetData(Parameter[3], ValueParameter[3]);

        if (Parameter[4] <> '') and (ValueParameter[4] <> '') then
            Notification.SetData(Parameter[4], ValueParameter[4]);
        if CodeunitID <> 0 then
            Notification.AddAction(ShowText, CodeunitID, FunctionName);
        Notification.Send();
    end;

    procedure MessageForNotification(Message: Text)
    begin
        Notification.Message(Message);
        Notification.Scope := NotificationScope::LocalScope;
        Notification.Send();
    end;

    procedure LookUpPostingGroup(var GenJnlLine: Record "Gen. Journal Line")
    var
        EmplPostingGroup: Record "Employee Posting Group";
        EmplPostingGroups: Page "Employee Posting Groups";
        VendPostingGroup: Record "Vendor Posting Group";
        VendPostingGroups: Page "Vendor Posting Groups";
        CustPostingGroup: Record "Customer Posting Group";
        CustPostingGroups: Page "Customer Posting Groups";
    begin
        case GenJnlLine."Account Type" of
            GenJnlLine."Account Type"::Employee:
                begin
                    Clear(EmplPostingGroups);
                    EmplPostingGroup.Reset();
                    EmplPostingGroups.LookupMode(true);
                    EmplPostingGroups.SetTableView(EmplPostingGroup);
                    EmplPostingGroups.SetRecord(EmplPostingGroup);
                    if EmplPostingGroups.RunModal() in [Action::LookupOK, Action::OK] then begin
                        EmplPostingGroups.GetRecord(EmplPostingGroup);
                        GenJnlLine."Posting Group" := EmplPostingGroup.Code;
                        GenJnlLine.Validate("Currency Code", EmplPostingGroup."Currency Code");
                        GenJnlLine.Modify();
                    end;
                end;
            GenJnlLine."Account Type"::Customer:
                begin
                    Clear(CustPostingGroups);
                    CustPostingGroup.Reset();
                    CustPostingGroups.LookupMode(true);
                    CustPostingGroups.SetTableView(CustPostingGroup);
                    CustPostingGroups.SetRecord(CustPostingGroup);
                    if CustPostingGroups.RunModal() in [Action::LookupOK, Action::OK] then begin
                        CustPostingGroups.GetRecord(CustPostingGroup);
                        GenJnlLine."Posting Group" := CustPostingGroup.Code;
                        GenJnlLine.Validate("Currency Code", CustPostingGroup."Currency Code");
                        GenJnlLine.Modify();
                    end;
                end;
            GenJnlLine."Account Type"::Vendor:
                begin
                    Clear(VendPostingGroups);
                    VendPostingGroup.Reset();
                    VendPostingGroups.LookupMode(true);
                    VendPostingGroups.SetTableView(VendPostingGroup);
                    VendPostingGroups.SetRecord(VendPostingGroup);
                    if VendPostingGroups.RunModal() in [Action::LookupOK, Action::OK] then begin
                        VendPostingGroups.GetRecord(VendPostingGroup);
                        GenJnlLine."Posting Group" := VendPostingGroup.Code;
                        GenJnlLine.Validate("Currency Code", VendPostingGroup."Currency Code");
                        GenJnlLine.Modify();
                    end;
                end;
        end;
    end;

    procedure ValidatePostingGroup(var GenJnlLine: Record "Gen. Journal Line")
    var
        EmplPostingGroup: Record "Employee Posting Group";
        VendPostingGroup: Record "Vendor Posting Group";
        CustPostingGroup: Record "Customer Posting Group";
    begin
        if GenJnlLine."Posting Group" = '' then
            exit;

        case GenJnlLine."Account Type" of
            GenJnlLine."Account Type"::Employee:
                begin
                    EmplPostingGroup.Get(GenJnlLine."Posting Group");
                    GenJnlLine."Posting Group" := EmplPostingGroup.Code;
                    GenJnlLine.Validate("Currency Code", EmplPostingGroup."Currency Code");
                    GenJnlLine.Modify();
                end;
            GenJnlLine."Account Type"::Customer:
                begin
                    CustPostingGroup.Get(GenJnlLine."Posting Group");
                    GenJnlLine."Posting Group" := CustPostingGroup.Code;
                    GenJnlLine.Validate("Currency Code", CustPostingGroup."Currency Code");
                    GenJnlLine.Modify();
                end;
            GenJnlLine."Account Type"::Vendor:
                begin
                    VendPostingGroup.Get(GenJnlLine."Posting Group");
                    GenJnlLine."Posting Group" := VendPostingGroup.Code;
                    GenJnlLine.Validate("Currency Code", VendPostingGroup."Currency Code");
                    GenJnlLine.Modify();
                end;
        end;
    end;



    var
        STSetup: Record "Setup Localization";
        GLSetupShortcutDimCode: array[10] of code[20];
        Notification: Notification;
}

