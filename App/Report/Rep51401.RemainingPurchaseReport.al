report 51401 "Remaining Purchase Report"
{
    UsageCategory = Administration;
    Caption = 'Proveedores - Cuentas por Pagar', Comment = 'ESP="Proveedores - Cuentas por Pagar"';
    //CaptionML = ESP= 'Proveedores - Cuentas por Pagar';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './App/Report/RDLC/ReportRemainingVendor.rdl';

    dataset
    {
        dataitem(Header; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(Formatted_Today; Format(Today))
            {

            }
            column(STRSUBSTNO_Text000_FORMAT_EndDate_; StrSubstNo(Text000Lbl, Format(DateFilter)))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(Vendor_TABLECAPTION_CustFilter; Vendor.TableCaption + ': ' + VendorFilter)
            {
            }
            column(VendorFilter; VendorFilter)
            {
            }
            column(Vendor_Detailed_AgingCaption; Vendor_Detailed_AgingCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry_Posting_Date_Caption; Cust_Ledger_Entry_Posting_Date_CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry_Document_Date_Caption; Cust_Ledger_Entry_Document_Date_CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry_Document_No_Caption; "Vendor Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Vendor_Ledger_Entry_External_Document_No_Caption; "Vendor Ledger Entry".FieldCaption("External Document No."))
            {
            }
            column(Vendor_Ledger_Entry_DescriptionCaption; "Vendor Ledger Entry".FieldCaption(Description))
            {
            }
            column(Vendor_Ledger_Entry_Due_Date_Caption; Cust_Ledger_Entry_Due_Date_CaptionLbl)
            {
            }
            column(OverDueMonthsCaption; OverDueMonthsCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry_Remaining_Amount_Caption; "Vendor Ledger Entry".FieldCaption("Remaining Amount"))
            {
            }
            column(Vendor_Ledger_Entry_Currency_Code_Caption; "Vendor Ledger Entry".FieldCaption("Currency Code"))
            {
            }
            column(Vendor_Ledger_Entry_Remaining_Amt_LCY_Caption; "Vendor Ledger Entry".FieldCaption("Remaining Amt. (LCY)"))
            {
            }
            dataitem(Vendor; Vendor)
            {
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Vendor Posting Group", "Currency Filter", "Payment Terms Code";
                column(Vendor_No_; "No.")
                {

                }
                column(Vendor_Name; Name)
                {
                }
                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Vendor No." = field("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 2 Filter"),
                    "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Currency Code" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter");
                    DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code");
                    column(Vendor_Ledger_Entry_Posting_Date_; Format("Posting Date"))
                    {

                    }
                    column(Vendor_Ledger_Entry_Document_Date_; Format("Document Date"))
                    {

                    }
                    column(Vendor_Ledger_Entry_Document_No_; "Document No.")
                    {

                    }
                    column(Vendor_Ledger_Entry_External_Document_No_; "External Document No.")
                    {

                    }
                    column(Vendor_Ledger_Entry_Description; Vendor_Ledger_Entry_Description)
                    {

                    }
                    column(Vendor_Ledger_Entry_Due_Date; Vendor_Ledger_Entry_Due_Date)
                    {

                    }
                    column(OverDueMonths; OverDueMonths)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Vendor_Ledger_Entry_Remaining_Amount; "Remaining Amount")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Vendor_Ledger_Entry_Currency_Code; "Currency Code")
                    {

                    }
                    column(Vendor_Ledger_Entry_Remaining_Amt___LCY_; "Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                    begin
                        SetFilter("Date Filter", '%1..%2', 0D, DateFilter);
                        SetFilter("Remaining Amount", '<>0');
                        SetAutoCalcFields("Remaining Amount", "Remaining Amt. (LCY)");
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        if ("Currency Code" = '') and ("Vendor Posting Group" = 'DETRAC') then begin
                            OverDueMonths := CalcFullRemainingAmount("Document No.", "Document Date", "Remaining Amount");
                            Vendor_Ledger_Entry_Due_Date := fnGetDueDate("Document No.");
                        end else begin
                            OverDueMonths := "Remaining Amount";
                            Vendor_Ledger_Entry_Description := Description;
                            Vendor_Ledger_Entry_Due_Date := "Due Date";
                        end;
                        TempCurrencyTotalBuffer.UpdateTotal(
                          "Currency Code", "Remaining Amount", "Remaining Amt. (LCY)", Counter);
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
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Opciones';
                    field(DateFilter; DateFilter)
                    {
                        Caption = 'Filtrar Fecha';
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Especifica el final del período cubierto por el informe (por ejemplo, 31/12/17).';
                    }
                }
            }
        }

        actions
        {

        }
        trigger OnOpenPage()
        begin
            if DateFilter = 0D then
                DateFilter := WorkDate;
        end;
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        VendorFilter := FormatDocument.GetRecordFiltersWithCaptions(Vendor);
        if (DateFilter = 0D) then
            Error(ShowErrorEmptyDate);
    end;

    var
        DateFilter: Date;
        Text000Lbl: Label 'Hasta el %1', Comment = '%1 is the as of date';
        ShowErrorEmptyDate: Label 'Enter Date to continue.', Comment = 'ESM="Ingrese fecha para continuar."';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        Cust_Ledger_Entry_Posting_Date_CaptionLbl: Label 'Fecha Registro';
        Cust_Ledger_Entry_Document_Date_CaptionLbl: Label 'Fecha Documento';
        Cust_Ledger_Entry_Due_Date_CaptionLbl: Label 'Fecha Vencimiento';
        Vendor_Detailed_AgingCaptionLbl: Label 'Proveedores - Cuentas por Pagar';
        VendorFilter: Text;
        OverDueMonths: Decimal;
        Vendor_Ledger_Entry_Due_Date: Date;
        Vendor_Ledger_Entry_Description: Text[100];
        OverDueMonthsCaptionLbl: Label 'Importe';
        TempCurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        TempCurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        Counter: Integer;
        Counter1: Integer;
        OK: Boolean;
        TotalCaptionLbl: Label 'Total';

    local procedure CalcFullRemainingAmount(DocumNo: Code[20]; DocumDate: Date; RemainAmount: Decimal): Decimal
    var
        CurrExchRate: Record "Currency Exchange Rate";
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange("Document No.", DocumNo);
        if VendLedgEntry.FindFirst() then begin
            CurrExchRate.Reset();
            CurrExchRate.SetRange("Starting Date", DocumDate);
            CurrExchRate.SetRange("Currency Code", VendLedgEntry."Currency Code");
            if CurrExchRate.FindFirst() then
                exit(RemainAmount / CurrExchRate."Relational Exch. Rate Amount");
            exit(RemainAmount);
        end;
    end;

    local procedure fnGetDueDate(var NoDoc: Code[20]): Date
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document No.", NoDoc);
        VendLedgEntry.SetFilter("Document Type", '%1', VendLedgEntry."Document Type"::Invoice);
        if VendLedgEntry.FindLast() then begin
            Vendor_Ledger_Entry_Description := VendLedgEntry.Description;
            exit(VendLedgEntry."Due Date");
            //end else begin
            //    VendLedgEntry.Reset();
            //    VendLedgEntry.SetRange("Document No.", NoDoc);
            //    if VendLedgEntry.FindFirst() then begin
            //        exit("Vendor Ledger Entry"."Due Date");
            //    end;
        end;
    end;
}
