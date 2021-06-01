report 51402 "Customer Detailed Aging Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './App/Report/RDLC/ReportRemainingCustomer.rdl';
    AdditionalSearchTerms = 'customer balance,payment due';
    ApplicationArea = Basic, Suite;
    Caption = 'Cliente - Cuentas por cobrar';
    EnableHyperlinks = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Header; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(STRSUBSTNO_Text000_FORMAT_EndDate_; StrSubstNo(Text000Lbl, Format(EndDate)))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(Customer_TABLECAPTION_CustFilter; Customer.TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(Customer_Detailed_AgingCaption; Customer_Detailed_AgingCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cust_Ledger_Entry_Posting_Date_Caption; Cust_Ledger_Entry_Posting_Date_CaptionLbl)
            {
            }
            column(Cust_Ledger_Entry_Document_No_Caption; "Cust. Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Cust_Ledger_Entry_DescriptionCaption; "Cust. Ledger Entry".FieldCaption(Description))
            {
            }
            column(Cust_Ledger_Entry_Due_Date_Caption; Cust_Ledger_Entry_Due_Date_CaptionLbl)
            {
            }
            column(OverDueMonthsCaption; OverDueMonthsCaptionLbl)
            {
            }
            column(Cust_Ledger_Entry_Remaining_Amount_Caption; "Cust. Ledger Entry".FieldCaption("Remaining Amount"))
            {
            }
            column(Cust_Ledger_Entry_Currency_Code_Caption; "Cust. Ledger Entry".FieldCaption("Currency Code"))
            {
            }
            column(Cust_Ledger_Entry_Remaining_Amt_LCY_Caption; "Cust. Ledger Entry".FieldCaption("Remaining Amt. (LCY)"))
            {
            }
            column(Customer_Phone_No_Caption; Customer.FieldCaption("Phone No."))
            {
            }
            dataitem(Customer; Customer)
            {
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Customer Posting Group", "Currency Filter", "Payment Terms Code";
                column(Customer_No_; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }
                column(Customer_Phone_No_; "Phone No.")
                {
                }
                column(CustomerContact; Contact)
                {
                }
                column(EMail; "E-Mail")
                {
                }
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD("No."), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Currency Code" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter");
                    DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");
                    column(Cust_Ledger_Entry_Posting_Date_; Format("Posting Date"))
                    {
                    }
                    column(Cust_Ledger_Entry_Document_No_; "Document No.")
                    {
                    }
                    column(Cust_Ledger_Entry_Description; Description)
                    {
                    }
                    column(Cust_Ledger_Entry_Due_Date_; Format("Due Date"))
                    {
                    }
                    column(OverDueMonths; OverDueMonths)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Cust_Ledger_Entry_Remaining_Amount_; "Remaining Amount")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Cust_Ledger_Entry_Currency_Code_; "Currency Code")
                    {
                    }
                    column(Cust_Ledger_Entry_Remaining_Amt_LCY_; "Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if "Due Date" = 0D then
                            OverDueMonths := 0
                        else
                            OverDueMonths := CalcFullMonthsBetweenDates("Due Date", EndDate);
                        if ("Remaining Amount" = 0) and OnlyOpen then
                            CurrReport.Skip();
                        TempCurrencyTotalBuffer.UpdateTotal(
                          "Currency Code", "Remaining Amount", "Remaining Amt. (LCY)", Counter);
                    end;

                    trigger OnPreDataItem()
                    begin
                        if OnlyOpen then begin
                            SetRange(Open, true);
                        end;
                        Counter := 0;
                        SetRange("Date Filter", 0D, EndDate);
                        SetAutoCalcFields("Remaining Amount", "Remaining Amt. (LCY)");
                    end;
                }
                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(TempCurrencyTotalBuffer_Total_Amount_; TempCurrencyTotalBuffer."Total Amount")
                    {
                        AutoFormatExpression = TempCurrencyTotalBuffer."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TempCurrencyTotalBuffer_Currency_Code_; TempCurrencyTotalBuffer."Currency Code")
                    {
                    }
                    column(TempCurrencyTotalBuffer_Total_Amount_LCY_; TempCurrencyTotalBuffer."Total Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then
                            OK := TempCurrencyTotalBuffer.Find('-')
                        else
                            OK := TempCurrencyTotalBuffer.Next <> 0;
                        if not OK then
                            CurrReport.Break();
                        TempCurrencyTotalBuffer2.UpdateTotal(
                          TempCurrencyTotalBuffer."Currency Code",
                          TempCurrencyTotalBuffer."Total Amount",
                          TempCurrencyTotalBuffer."Total Amount (LCY)", Counter1);
                    end;

                    trigger OnPostDataItem()
                    begin
                        TempCurrencyTotalBuffer.DeleteAll();
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if not CustomersWithLedgerEntriesList.Contains("No.") then
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin
                    if OnlyOpen then
                        NumCustLedgEntriesperCust.SetFilter(OpenValue, 'TRUE');

                    if NumCustLedgEntriesperCust.Open then
                        while NumCustLedgEntriesperCust.Read do
                            if not CustomersWithLedgerEntriesList.Contains(NumCustLedgEntriesperCust.Customer_No) then
                                CustomersWithLedgerEntriesList.Add(NumCustLedgEntriesperCust.Customer_No);
                end;
            }
            dataitem(Integer2; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(TempCurrencyTotalBuffer2_Currency_Code_; TempCurrencyTotalBuffer2."Currency Code")
                {
                }
                column(TempCurrencyTotalBuffer2_Total_Amount_; TempCurrencyTotalBuffer2."Total Amount")
                {
                    AutoFormatExpression = TempCurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(TempCurrencyTotalBuffer2_Total_Amount_LCY_; TempCurrencyTotalBuffer2."Total Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        OK := TempCurrencyTotalBuffer2.Find('-')
                    else
                        OK := TempCurrencyTotalBuffer2.Next <> 0;
                    if not OK then
                        CurrReport.Break();
                end;

                trigger OnPostDataItem()
                begin
                    TempCurrencyTotalBuffer2.DeleteAll();
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Ending Date"; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fecha Final';
                        ToolTip = 'Especifica la fecha final del periodo al que corresponde el informe, (por ejemplo, 31/12/17).';
                    }
                    field(ShowOpenEntriesOnly; OnlyOpen)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mostrar solo pendientes';
                        ToolTip = 'Especifica que sólo desea mostrar movimientos abiertos relacionados con la lista de saldos vencidos de los clientes.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if EndDate = 0D then
                EndDate := WorkDate;
        end;
    }

    labels
    {
        CustomerContactCaption = 'Contacto';
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
    end;

    var
        Text000Lbl: Label 'Hasta el %1';
        TempCurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        TempCurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        NumCustLedgEntriesperCust: Query "Num CustLedgEntries per Cust";
        CustomersWithLedgerEntriesList: List of [Code[20]];
        EndDate: Date;
        CustFilter: Text;
        OverDueMonths: Integer;
        OK: Boolean;
        Counter: Integer;
        Counter1: Integer;
        OnlyOpen: Boolean;
        Customer_Detailed_AgingCaptionLbl: Label 'Clientes - Cuentas por Cobrar';
        CurrReport_PAGENOCaptionLbl: Label 'Pag.';
        Cust_Ledger_Entry_Posting_Date_CaptionLbl: Label 'Fecha Registro';
        Cust_Ledger_Entry_Due_Date_CaptionLbl: Label 'Fecha Vencimiento';
        OverDueMonthsCaptionLbl: Label 'Meses Vencidos';
        TotalCaptionLbl: Label 'Total';

    procedure InitializeRequest(SetEndDate: Date; SetOnlyOpen: Boolean)
    begin
        EndDate := SetEndDate;
        OnlyOpen := SetOnlyOpen;
    end;

    local procedure CalcFullMonthsBetweenDates(FromDate: Date; ToDate: Date): Integer
    var
        FullMonths: Integer;
        LeftOverDays: Integer;
    begin
        FullMonths := (Date2DMY(ToDate, 3) - Date2DMY(FromDate, 3)) * 12 + Date2DMY(ToDate, 2) - Date2DMY(FromDate, 2) - 1;

        if Date2DMY(ToDate, 1) = Date2DMY(CalcDate('<CM>', ToDate), 1) then
            FullMonths += 1
        else
            LeftOverDays := Date2DMY(ToDate, 1);

        if Date2DMY(FromDate, 1) - LeftOverDays <= 1 then
            FullMonths += 1;

        if FullMonths <= 0 then
            FullMonths := 0;

        exit(FullMonths);
    end;
}