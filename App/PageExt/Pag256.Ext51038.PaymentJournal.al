pageextension 51038 "Setup Payment Journal" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Applies-to ID")
        {
            field("Applies-to Entry No."; "Applies-to Entry No.")
            {
                ApplicationArea = All;
                Caption = 'Applied-to Entry No.';
            }
        }
        addafter(Description)
        {
            field("Posting Group"; "Posting Group")
            {
                ApplicationArea = All;
                Editable = true;
                Caption = 'Posting Group', Comment = 'ESM="Grupo contable"';

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
        addafter(CurrentJnlBatchName)
        {
            field(IsManual; IsManual)
            {
                Caption = 'Manual Retention';
                ApplicationArea = All;
                Visible = ShowRetention;
            }
        }

        addafter("Bal. Account No.")
        {
            field("Applied Retention"; "Applied Retention")
            {
                ApplicationArea = All;
                Visible = ShowRetention;
            }
            field("Retention Amount"; "Retention Amount")
            {
                ApplicationArea = All;
                Visible = ShowRetention;
                Editable = false;
            }
            field("Retention Amount LCY"; "Retention Amount LCY")
            {
                ApplicationArea = All;
                Visible = ShowRetention;
                Editable = false;
            }
        }

        modify(GetAppliesToDocDueDate)
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
        }
        modify(TotalExportedAmount)
        {
            Visible = false;
        }
        modify("Has Payment Export Error")
        {
            Visible = false;
        }
    }
    actions
    {
        addafter("&Payments")
        {
            group("Telecrédito Proveedores & Haberes")
            {
                Image = PaymentDays;
                Visible = true;
                Enabled = True;
                Caption = 'Telecredit Vendor & ', Comment = 'ESM="Telecrédito Prov. & Haberes"';

                action(ExportAccountsPayableRegister)
                {
                    ApplicationArea = All;
                    Caption = 'Registro COACTIVA';
                    Image = SuggestCustomerPayments;
                    Visible = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction();
                    var
                    begin
                        CLEAR(MassiveBankPayments);
                        MassiveBankPayments.fnGenerateRegisterAccountsPayable(Rec);

                    end;
                }


                action(ExportBCPBankPayroll)
                {
                    ApplicationArea = All;
                    Caption = 'BCP Haberes';
                    Visible = ViewPaymentsBCP;
                    Image = SuggestCustomerPayments;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction();
                    var

                    begin
                        CLEAR(MassiveBankPayments);
                        MassiveBankPayments.fnGenerateSalaryTelecreditEmployee(Rec);

                    end;
                }
                action(ExportBCPBank)
                {
                    ApplicationArea = All;
                    Caption = 'BCP Proveedores';
                    Visible = ViewPaymentsBCP;
                    Image = ElectronicPayment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        CLEAR(MassiveBankPayments);
                        MassiveBankPayments.fnGenerateVendorTelecreditBCP(Rec, FALSE, FALSE);
                    end;
                }
                action(ExportBBVABankPayroll)
                {
                    ApplicationArea = All;
                    Caption = 'BBVA Haberes';
                    Visible = ViewPaymentsBBVA;
                    Image = SuggestCustomerPayments;
                    Promoted = true;
                    PromotedIsBig = true;

                    PromotedCategory = Process;
                    trigger OnAction();

                    begin
                        CLEAR(MassiveBankPayments);
                        MassiveBankPayments.fnGenerateSalaryTelecreditEmployee(Rec);

                    end;
                }

                action(ExportBBVABank)
                {
                    ApplicationArea = All;
                    Caption = 'BBVA Proveedores';
                    Visible = ViewPaymentsBBVA;
                    Image = ElectronicPayment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction();

                    begin
                        CLEAR(MassiveBankPayments);
                        MassiveBankPayments.fnGenerateVendorTelecreditBBVA(Rec);


                    end;
                }
                action(ExportINTKBankPayroll)
                {
                    ApplicationArea = All;
                    Caption = 'INTERBANK Haberes';
                    // CaptionML = 'ENU=ExportBCPBank;ESP=Telecrédito BCP Proveedores;ESM=BCP Haberes';
                    Visible = ViewPaymentsIBK;
                    Image = SuggestCustomerPayments;
                    Promoted = true;
                    PromotedIsBig = true;

                    PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        CLEAR(MassiveBankPayments);
                        MassiveBankPayments.fnGenerateSalaryTelecreditEmployee(Rec);

                    end;
                }


                action(ExportINTKBank)
                {
                    ApplicationArea = All;
                    Caption = 'INTERBANK Proveedores';
                    // CaptionML = 'ENU=ExportBCPBank;ESP=Telecrédito BCP Proveedores;ESM=BCP Haberes';
                    Visible = ViewPaymentsIBK;
                    Image = ElectronicPayment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        CLEAR(MassiveBankPayments);
                        IF Rec.ISEMPTY THEN
                            EXIT;
                        MassiveBankPayments.fnGenerateVendorTelecreditITBK(Rec);

                    end;
                }

                action(ExportSCOTIABankPayroll)
                {
                    ApplicationArea = All;
                    Caption = 'SCOTIABANK Haberes';
                    Visible = ViewPaymentsSBP;
                    Image = SuggestCustomerPayments;
                    Promoted = true;
                    PromotedIsBig = true;

                    PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        CLEAR(MassiveBankPayments);
                        MassiveBankPayments.fnGenerateSalaryTelecreditEmployee(Rec);

                    end;
                }

                action(ExportSCOTIABank)
                {
                    ApplicationArea = All;
                    Caption = 'SCOTIABANK Proveedores';
                    Visible = ViewPaymentsSBP;
                    Image = SuggestCustomerPayments;
                    Promoted = true;
                    PromotedIsBig = true;

                    PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        CLEAR(MassiveBankPayments);
                        IF Rec.ISEMPTY THEN
                            EXIT;
                        MassiveBankPayments.fnGenerateVendorTelecreditScotiabank(Rec);

                    end;
                }

                action(ExportCITIBankPayroll)
                {
                    ApplicationArea = All;
                    Caption = 'CITIBANK Haberes';
                    Visible = ViewPaymentsCITI;
                    Image = SuggestCustomerPayments;
                    Promoted = true;
                    PromotedIsBig = true;

                    PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        CLEAR(MassiveBankPayments);
                        MassiveBankPayments.fnGenerateSalaryTelecreditEmployee(Rec);


                    end;
                }

                action(ExportCITIBank)
                {
                    ApplicationArea = All;
                    Caption = 'CITIBANK Proveedores';
                    Visible = ViewPaymentsCITI;
                    Image = ElectronicPayment;
                    Promoted = true;
                    PromotedIsBig = true;

                    PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        CLEAR(MassiveBankPayments);
                        IF Rec.ISEMPTY THEN
                            EXIT;
                        MassiveBankPayments.fnGeneratePaymentTelecredit(Rec);

                    end;
                }
            }
        }
        addlast("Electronic Payments")
        {
            action(GenDetractPlainText)
            {
                Caption = 'Generate Detraction Plain Text', Comment = 'ESM="Generar arch. plano detracción"';
                ApplicationArea = All;
                Image = ExportToBank;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Clear(DetracCalculation);
                    DetracCalculation.GenerateDetrActionFile(Rec);
                end;
            }
            action(ImportDetractionFile)
            {
                ApplicationArea = All;
                Caption = 'Import detraction file', Comment = 'ESM="Importar arch. detracción"';
                Image = ImportExcel;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = report "Detrac. Load Detraction File";
            }
        }
        addafter("F&unctions")
        {
            group(Retention)
            {
                Caption = 'Retention';
                Image = CalculateVAT;
                action(CalculateRetention)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Retention';
                    Image = CalculateBalanceAccount;
                    trigger OnAction()
                    begin
                        RetentionMgt.CalculateRetention(Rec, IsManual);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetViewButtons;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetViewButtons;
    end;

    trigger OnOpenPage()
    begin
        SetViewButtons;
        if SetupLoc.Get() then
            ShowRetention := SetupLoc."Retention Agent Option" <> SetupLoc."Retention Agent Option"::Disable;
    end;

    var
        SLSetupMgt: Codeunit "Setup Localization";
        DetracCalculation: Codeunit "DetrAction Calculation";
        MassiveBankPayments: Codeunit "Massive Banks Payments";
        ViewPaymentsBCP: Boolean;
        ViewPaymentsBBVA: Boolean;
        ViewPaymentsIBK: Boolean;
        ViewPaymentsSBP: Boolean;
        ViewPaymentsCITI: Boolean;
        IsManual: Boolean;
        ShowRetention: Boolean;
        RetentionMgt: Codeunit "Retention Management";
        SetupLoc: Record "Setup Localization";//Dimensions


    local procedure SetViewButtons()
    var
        GenJnlBatch2: Record "Gen. Journal Batch";
        BankAccNoFICO: Text;
    begin
        GenJnlBatch2.Reset();
        GenJnlBatch2.SetRange("Journal Template Name", "Journal Template Name");
        GenJnlBatch2.SetRange(Name, "Journal Batch Name");
        if GenJnlBatch2.IsEmpty then
            exit;
        GenJnlBatch2.Find('-');
        BankAccNoFICO := GenJnlBatch2."Bank Account No. FICO";

        if BankAccNoFICO = '' then
            exit;

        ViewPaymentsBBVA := CopyStr(BankAccNoFICO, 1, 6) = 'BBVA-R';
        ViewPaymentsBCP := CopyStr(BankAccNoFICO, 1, 5) = 'BCP-L';
        ViewPaymentsIBK := CopyStr(BankAccNoFICO, 1, 5) = 'IBK-R';
        ViewPaymentsSBP := CopyStr(BankAccNoFICO, 1, 5) = 'SBP-R';
    end;
}