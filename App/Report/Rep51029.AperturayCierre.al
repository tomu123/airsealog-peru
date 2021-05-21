report 51029 "ULN Chart of Accounts"
{
    // Identify  Nro.    yyyy.mm.dd    Version   Description
    // -----------------------------------------------------------------------------------------------------
    // ULN::RHF 001      2019.05.14    v.001     "Add new Fields"
    DefaultLayout = RDLC;
    RDLCLayout = './App/Report/RDLC/ULN Chart of Accounts.rdlc';

    ApplicationArea = Basic, Suite;
    Caption = 'Asiento de Cierre y Apertura';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type";
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(Chart_of_AccountsCaption; Chart_of_AccountsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Income_Balance_Caption; G_L_Account___Income_Balance_CaptionLbl)
            {
            }
            column(G_L_Account___Account_Type_Caption; G_L_Account___Account_Type_CaptionLbl)
            {
            }
            column(G_L_Account__TotalingCaption; G_L_Account__TotalingCaptionLbl)
            {
            }
            column(G_L_Account___Gen__Posting_Type_Caption; G_L_Account___Gen__Posting_Type_CaptionLbl)
            {
            }
            column(G_L_Account___Gen__Bus__Posting_Group_Caption; G_L_Account___Gen__Bus__Posting_Group_CaptionLbl)
            {
            }
            column(G_L_Account___Gen__Prod__Posting_Group_Caption; G_L_Account___Gen__Prod__Posting_Group_CaptionLbl)
            {
            }
            column(G_L_Account___Direct_Posting_Caption; G_L_Account___Direct_Posting_CaptionLbl)
            {
            }
            column(G_L_Account___Consol__Translation_Method_Caption; G_L_Account___Consol__Translation_Method_CaptionLbl)
            {
            }
            dataitem(BlankLineCounter; "Integer")
            {
                DataItemTableView = SORTING(Number);

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, "G/L Account"."No. of Blank Lines");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Income_Balance_; "G/L Account"."Income/Balance")
                {
                }
                column(G_L_Account___Account_Type_; "G/L Account"."Account Type")
                {
                }
                column(G_L_Account__Totaling; "G/L Account".Totaling)
                {
                }
                column(G_L_Account___Gen__Posting_Type_; "G/L Account"."Gen. Posting Type")
                {
                }
                column(G_L_Account___Gen__Bus__Posting_Group_; "G/L Account"."Gen. Bus. Posting Group")
                {
                }
                column(G_L_Account___Gen__Prod__Posting_Group_; "G/L Account"."Gen. Prod. Posting Group")
                {
                }
                column(G_L_Account___Direct_Posting_; "G/L Account"."Direct Posting")
                {
                }
                column(G_L_Account___Consol__Translation_Method_; "G/L Account"."Consol. Translation Method")
                {
                }
                column(G_L_Account___No__of_Blank_Lines_; "G/L Account"."No. of Blank Lines")
                {
                }
                column(PageGroupNo; PageGroupNo)
                {
                }
                column(DirectPostingTxt; DirectPostingTxt)
                {
                }
                column(CheckAccType; CheckAccType)
                {
                }
                column(AccountType; AccountType)
                {
                }
                column(ConsTransMethod; ConsTransMethod)
                {
                }
                column(IncomeBalance; IncomeBalance)
                {
                }
                column(GenPostingType; GenPostingType)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                PageGroupNo := NextPageGroupNo;
                if "New Page" then
                    NextPageGroupNo := PageGroupNo + 1;

                DirectPostingTxt := Format("Direct Posting");
                AccountType := Format("Account Type");
                ConsTransMethod := Format("Consol. Translation Method");
                CheckAccType := "Account Type" = "Account Type"::Posting;
                IncomeBalance := Format("Income/Balance");
                GenPostingType := Format("Gen. Posting Type");

                if (pAperture = true) and ("Account Type" = "Account Type"::Posting) then begin
                    gDialog.Update();
                    gNum := gNum + 10000;

                    gRecGenJLine.Init;
                    gRecGenJLine."Journal Template Name" := 'GENERAL';
                    gRecGenJLine."Journal Template Name" := 'GENERAL';
                    if pTipo = pTipo::Cierre then
                        gRecGenJLine."Journal Batch Name" := 'CIERRE'
                    else
                        gRecGenJLine."Journal Batch Name" := 'APERTURA';
                    gRecGenJLine."Line No." := gNum;
                    gRecGenJLine."Account Type" := gRecGenJLine."Account Type"::"G/L Account";
                    gRecGenJLine.Validate("Account No.", "No.");

                    if pTipo = pTipo::Apertura then
                        gRecGenJLine.Description := 'APERTURA-' + "No."
                    else
                        gRecGenJLine.Description := 'CIERRE---' + "No.";

                    gRecGenJLine."System-Created Entry" := true;

                    CalcFields("Debit Amount", "Credit Amount", "Balance at Date");

                    if pTipo = pTipo::Cierre then
                        gRecGenJLine."Posting Date" := ClosingDate(pFechaRegistro)
                    else
                        gRecGenJLine."Posting Date" := pFechaRegistro;

                    gRecGenJLine."Document No." := pDoc;
                    if pTipo = pTipo::Cierre then begin
                        if "Balance at Date" > 0 then
                            gRecGenJLine.Validate("Credit Amount", Abs("Balance at Date"))
                        else
                            gRecGenJLine.Validate("Debit Amount", Abs("Balance at Date"));
                    end else begin
                        if "Balance at Date" < 0 then
                            gRecGenJLine.Validate("Credit Amount", Abs("Balance at Date"))
                        else
                            gRecGenJLine.Validate("Debit Amount", Abs("Balance at Date"));
                    end;

                    if pTipo = pTipo::Apertura then
                        gRecGenJLine."Source Code" := 'APERTURA'
                    else
                        gRecGenJLine."Source Code" := 'CIERRE';

                    if gRecGenJLine.Amount <> 0 then
                        gRecGenJLine.Insert;
                end;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                NextPageGroupNo := 1;


                gDialog.Open(Text02);
                if not Confirm(Text01) then
                    exit;

                gRecGenJLine.Reset;
                gRecGenJLine.SetFilter("Journal Template Name", 'GENERAL');
                if pTipo = pTipo::Cierre then
                    gRecGenJLine.SetFilter("Journal Batch Name", 'CIERRE')
                else
                    gRecGenJLine.SetFilter("Journal Batch Name", 'APERTURA');
                if gRecGenJLine.FindLast then
                    gNum := gRecGenJLine."Line No." + 10000;

                gDialog.Open(Text02);


                "G/L Account".SetRange("G/L Account"."Income/Balance", "G/L Account"."Income/Balance"::"Balance Sheet");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Aperture; pAperture)
                {
                    ApplicationArea = All;
                    Caption = 'Crear asiento de apertura';
                }
                field(Tipo; pTipo)
                {
                    ApplicationArea = All;
                }
                field("N° de documento"; pDoc)
                {
                    ApplicationArea = All;
                }
                field("Fecha registro"; pFechaRegistro)
                {
                    ApplicationArea = All;
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

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GetFilters;
    end;

    var
        GLFilter: Text;
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        DirectPostingTxt: Text[30];
        CheckAccType: Boolean;
        AccountType: Text[30];
        ConsTransMethod: Text[30];
        IncomeBalance: Text[30];
        GenPostingType: Text[30];
        Chart_of_AccountsCaptionLbl: Label 'Chart of Accounts';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        G_L_Account___Income_Balance_CaptionLbl: Label 'Income/Balance';
        G_L_Account___Account_Type_CaptionLbl: Label 'Account Type';
        G_L_Account__TotalingCaptionLbl: Label 'Totaling';
        G_L_Account___Gen__Posting_Type_CaptionLbl: Label 'Gen. Posting Type';
        G_L_Account___Gen__Bus__Posting_Group_CaptionLbl: Label 'Gen. Bus. Posting Group';
        G_L_Account___Gen__Prod__Posting_Group_CaptionLbl: Label 'Gen. Prod. Posting Group';
        G_L_Account___Direct_Posting_CaptionLbl: Label 'Direct Posting';
        G_L_Account___Consol__Translation_Method_CaptionLbl: Label 'Consol. Translation Method';
        "--------Union Label-------": Label '--Union Label-----------------------------------------------------------';
        Text01: Label 'Create opening seats.';
        "----------Union Label---------------------------------------------": Integer;
        gDialog: Dialog;
        gRecGenJLine: Record "Gen. Journal Line";
        Text02: Label 'Location Peru, Apertura Process...';
        gNum: Integer;
        pAperture: Boolean;
        pTipo: Option Apertura,Cierre;
        pFechaRegistro: Date;
        pDoc: Code[20];
}

