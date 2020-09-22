report 51004 "General Ledger Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    Caption = 'General Ledger Report', Comment = 'ESM="Diario Mayor"';
    RDLCLayout = './App/Report/RDLC/GeneralLedgerRecord.rdl';

    dataset
    {
        dataitem(GenJnlBookBuffer; "Gen. Journal Book Buffer")
        {
            UseTemporary = true;
            column(Period; Period)
            {
                IncludeCaption = true;
            }
            column(Transaction_CUO; "Transaction CUO")
            {
                IncludeCaption = true;
            }
            column(Correlative_cuo; "Correlative cuo")
            {
                IncludeCaption = true;
            }
            column(Operation_Date; "Operation Date")
            {
                IncludeCaption = true;
            }
            column(Gloss_and_description; "Gloss and description")
            {
                IncludeCaption = true;
            }
            column(Book_Code_Ref; "Book Code Ref")
            {
                IncludeCaption = true;
            }
            column(Document_No_; "Document No.")
            {
                IncludeCaption = true;
            }
            column(G_L_Account_No_; "G/L Account No.")
            {
                IncludeCaption = true;
            }
            column(G_L_Account_Name; "G/L Account Name")
            {
                IncludeCaption = true;
            }
            column(Debit_Amount; "Debit Amount")
            {
                IncludeCaption = true;
            }
            column(Credit_Amount; "Credit Amount")
            {
                IncludeCaption = true;
            }
            column(PeriodDescription; PeriodDescription)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(CompanyVATRegNo; CompInf."VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(CompanyVATRegName; CompInf.Name)
            {
                IncludeCaption = true;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Information';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                    }
                    field(PeriodDescription; PeriodDescription)
                    {
                        ApplicationArea = All;
                    }
                    field(AutomaticEBook; AutomaticEBook)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if (StartDate = 0D) or (EndDate = 0D) then
            Error(ShowErrorEmptyDate);
        AccBookMgt.SetDate(StartDate, EndDate);
        AccBookMgt.GenJournalBooks('601', AutomaticEBook);
        AccBookMgt.GetGenJnlBookBuffer(GenJnlBookBuffer);
        CompInf.Get();
    end;

    var
        StartDate: Date;
        EndDate: Date;
        PeriodDescription: text[100];
        TitlePurchaseRecors: Text[100];
        LegalDocumentDescription: Text[100];
        AutomaticEBook: Boolean;
        CompInf: Record "Company Information";
        AccBookMgt: Codeunit "Accountant Book Management";
        ShowErrorEmptyDate: Label 'Enter Start Date and End Date to continue.', Comment = 'ESM="Ingrese fecha de inicio y fin para continuar."';
}