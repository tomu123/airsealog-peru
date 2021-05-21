report 51028 "Checking Balance"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Checking Balance', Comment = 'ESM="Balance de comprobación"';

    DefaultLayout = RDLC;
    RDLCLayout = './App/Report/RDLC/CheckingBalance.rdl';

    dataset
    {
        dataitem(GLAccount; "G/L Account")
        {
            RequestFilterFields = "No.", "Account Type";
            column(DecimalValues1; DecimalValues[1])
            {
            }
            column(DecimalValues2; DecimalValues[2])
            {
            }
            column(DecimalValues3; DecimalValues[3])
            {
            }
            column(DecimalValues4; DecimalValues[4])
            {
            }
            column(DecimalValues5; DecimalValues[5])
            {
            }
            column(DecimalValues6; DecimalValues[6])
            {
            }
            column(DecimalValues7; DecimalValues[7])
            {
            }
            column(DecimalValues8; DecimalValues[8])
            {
            }
            column(DecimalValues9; DecimalValues[9])
            {
            }
            column(DecimalValues10; DecimalValues[10])
            {
            }
            column(DecimalValues11; DecimalValues[11])
            {
            }
            column(DecimalValues12; DecimalValues[12])
            {
            }
            column(No_GLAccount; GLAccount."No.")
            {
            }
            column(Name_GLAccount; GLAccount.Name)
            {
            }
            column(RazonSocial; CompanyInf.Name)
            {
            }
            column(RUC; CompanyInf."VAT Registration No.")
            {
            }
            column(PERIODO; gPeriodo)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if CopyStr(GLAccount."No.", 1, 2) = 'MS' then
                    CurrReport.Skip();

                CLEAR(DecimalValues);
                gdinicial := 0;
                gdfinal := 0;

                SetRange(GLAccount."Date Filter", StartDate, endDate);

                //GLAccount.CalcFields("Debit Amount Apertura.","Credit Amount Apertura.");
                //gdinicial := GLAccount."Debit Amount Apertura.";
                //gdfinal := GLAccount."Credit Amount Apertura.";

                SetRange("Date Filter", DMY2Date(1, 1, Date2DMY(StartDate, 3)), CalcDate('<-1D>', StartDate));

                CalcFields("Debit Amount", "Credit Amount");
                gimporte := ("Debit Amount" - "Credit Amount") + (gdinicial - gdfinal);
                if gimporte > 0 then
                    DecimalValues[1] := gimporte
                else
                    DecimalValues[2] := Abs(gimporte);

                SetRange("Date Filter", StartDate, endDate);
                CalcFields("Debit Amount", "Credit Amount");//, "Debit Amount Apertura.", "Credit Amount Apertura.");
                DecimalValues[3] := "Debit Amount" - 0;//"Debit Amount Apertura.";

                DecimalValues[4] := "Credit Amount" - 0;//"Credit Amount Apertura.";

                SetRange("Date Filter", DMY2Date(1, 1, Date2DMY(StartDate, 3)), endDate);
                CalcFields("Debit Amount", "Credit Amount");
                gimporte := ("Debit Amount" - "Credit Amount");

                if gimporte > 0 then
                    DecimalValues[5] := gimporte
                else
                    DecimalValues[6] := Abs(gimporte);

                if "Income/Balance" = "Income/Balance"::"Balance Sheet" then begin
                    if gimporte > 0 then
                        DecimalValues[7] := gimporte
                    else
                        DecimalValues[8] := Abs(gimporte);
                end;


                if CopyStr("No.", 1, 2) IN ['67', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '88', '90', '91', '92', '93', '94', '95', '97'] then begin//se agrego la cuenta '88'
                    if gimporte > 0 then
                        DecimalValues[9] := gimporte
                    else
                        DecimalValues[10] := Abs(gimporte);
                end;

                if CopyStr("No.", 1, 2) IN ['60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '88'] then begin////se agrego la cuenta '88'
                    if gimporte > 0 then
                        DecimalValues[11] := gimporte
                    else
                        DecimalValues[12] := Abs(gimporte);
                end;

                if (DecimalValues[1] = 0) AND (DecimalValues[2] = 0) AND (DecimalValues[3] = 0) AND (DecimalValues[4] = 0) AND (DecimalValues[5] = 0) AND
                   (DecimalValues[6] = 0) AND (DecimalValues[7] = 0) AND (DecimalValues[8] = 0) AND (DecimalValues[9] = 0) AND (DecimalValues[10] = 0) AND
                   (DecimalValues[11] = 0) AND (DecimalValues[12] = 0) then begin
                    CurrReport.Skip();
                end;
            end;

            trigger OnPreDataItem();
            begin
                CompanyInf.Get();
                gPeriodo := Date2DMY(endDate, 3);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date', Comment = 'ESM="Fecha Inicio"';
                }
                field(endDate; endDate)
                {
                    ApplicationArea = All;
                    Caption = 'end Date', Comment = 'ESM="Fecha Fin"';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DecimalValues: array[12] of Decimal;
        StartDate: Date;
        endDate: Date;
        gimporte: Decimal;
        gdinicial: Decimal;
        gdfinal: Decimal;
        CompanyInf: Record "Company Information";
        gPeriodo: Integer;
}