page 51003 "Setup Localization"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Setup Localization', Comment = 'ESM="Configuración Localizado"';
    UsageCategory = Administration;
    SourceTable = "Setup Localization";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Visible = true;

                field("ST GL Account Realized Gain"; "ST GL Account Realized Gain")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        MasterData.Reset();
                        MasterData.FilterGroup(2);
                        MasterData.SetRange("Type Table", 'ADJ-TC-REF');
                        MasterData.SetRange("Type Table ref", 'ADJ-TC');
                        MasterData.SetRange("Code ref", "ST GL Account Realized Gain");
                        MasterData.FilterGroup(0);
                        Clear(MDPage);
                        MDPage.SetDimensionDefault('ADJ-TC-REF', 'ADJ-TC', "ST GL Account Realized Gain");
                        MDPage.SetTableView(MasterData);
                        MDPage.RunModal();
                    end;
                }
                field("ST GL Account Realized Loss"; "ST GL Account Realized Loss")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        MasterData.Reset();
                        MasterData.FilterGroup(2);
                        MasterData.SetRange("Type Table", 'ADJ-TC-REF');
                        MasterData.SetRange("Type Table ref", 'ADJ-TC');
                        MasterData.SetRange("Code ref", "ST GL Account Realized Loss");
                        MasterData.FilterGroup(0);
                        Clear(MDPage);
                        MDPage.SetDimensionDefault('ADJ-TC-REF', 'ADJ-TC', "ST GL Account Realized Loss");
                        MDPage.SetTableView(MasterData);
                        MDPage.RunModal();
                    end;
                }
                field("ST Adj. Exch. Dflt. Dim. Bank"; "ST Adj. Exch. Dflt. Dim. Bank")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        QtyDimDescription: Text;
                    begin
                        MasterData.Reset();
                        MasterData.FilterGroup(2);
                        MasterData.SetRange("Type Table", 'ADJ-TC-REF');
                        MasterData.SetRange("Type Table ref", 'ADJ-TC');
                        MasterData.SetRange("Code ref", 'BANK-ADJTC');
                        MasterData.FilterGroup(0);
                        Clear(MDPage);
                        MDPage.SetDimensionDefault('ADJ-TC-REF', 'ADJ-TC', 'BANK-ADJTC');
                        MDPage.SetTableView(MasterData);
                        MDPage.RunModal();
                        UpdateDescription();
                        CurrPage.Update(true);
                    end;
                }
                field("ST Coactiva No. Serie"; "ST Coactiva No. Serie")
                {
                    ApplicationArea = All;
                }

                group(AdjustExchangeRateLoc)
                {
                    Caption = 'Adjust Exchange Rates';
                    field("Adj. Exch. Rate Localization"; "Adj. Exch. Rate Localization")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Utiliza el desarrollo localizado en referencia al tipo de ajuste pasivo o activo de los grupos contables.';
                    }
                    field("Adj. Exch. Rate Doc. Pstg Gr"; "Adj. Exch. Rate Doc. Pstg Gr")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Hace el ajuste con el grupo contable del documento, el estandar utiliza el grupo contable configurado en el ficha de maestros, cliente, proveedor, banco. Segun corresponda.';
                        Editable = "Adj. Exch. Rate Localization";
                    }
                    field("Adj. Exch. Rate Ref. Document"; "Adj. Exch. Rate Ref. Document")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Hace el ajuste por tipo de cambio agrupando por documento, el estandar los agrupa por Cliente, Proveedor, Banco, etc.';
                        Editable = "Adj. Exch. Rate Localization";
                    }
                }
            }
            group(ConsultRuc)
            {
                Caption = 'Consult Ruc', Comment = 'ESM="Consulta RUC"';
                field("Create Option Vendor"; "Create Option Vendor")
                {
                    ApplicationArea = All;
                }
                field("Vendor MN Template Code"; "Vendor MN Template Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor ME Template Code"; "Vendor ME Template Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Ext Template Code"; "Vendor Ext Template Code")
                {
                    ApplicationArea = All;
                }
                field("Create Option Customer"; "Create Option Customer")
                {
                    ApplicationArea = All;
                }
                field("Customer MN Template Code"; "Customer MN Template Code")
                {
                    ApplicationArea = All;
                }
                field("Customer ME Template Code"; "Customer ME Template Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Ext Template Code"; "Customer Ext Template Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Retention)
            {
                Caption = 'Retention', Comment = 'ESM="Retención"';
                field("Retention Agent Option"; "Retention Agent Option")
                {
                    ApplicationArea = All;
                }
                field("Regime Retention Code"; "Regime Retention Code")
                {
                    ApplicationArea = All;
                }
                field("Retention Percentage %"; "Retention Percentage %")
                {
                    ApplicationArea = All;
                }
                field("Retention Limit Amount"; "Retention Limit Amount")
                {
                    ApplicationArea = All;
                }
                field("Retention G/L Account No."; "Retention G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("Max. Line. Retention Report"; "Max. Line. Retention Report")
                {
                    ApplicationArea = All;
                }
                field("Retention Physical Nos"; "Retention Physical Nos")
                {
                    ApplicationArea = All;
                }
                field("Retention Electronic Nos"; "Retention Electronic Nos")
                {
                    ApplicationArea = All;
                }
                field("Retention Resolution Number"; "Retention Resolution Number")
                {
                    ApplicationArea = All;
                }
            }
            group(RHRetention)
            {
                Caption = 'RH Retntion', Comment = 'ESM="Retención recibo por honorario"';
                field("Retention RH Nos"; "Retention RH Nos")
                {
                    ApplicationArea = All;
                    Caption = 'Serie Nos', Comment = 'ESM="N° Serie"';
                }
                field("Retention RH Posted Nos"; "Retention RH Posted Nos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Serie Nos', Comment = 'ESM="N° Serie Registro"';
                }
                field("Retention RH GLAcc. No."; "Retention RH GLAcc. No.")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Account No.', Comment = 'ESM="N° Cuenta"';
                }
                field("Ret. RH VAT Prod Pstg. Gr. Ex."; "Ret. RH VAT Prod Pstg. Gr. Ex.")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Prod. Pstg. Group Ex.', Comment = 'ESM="Gr. reg. IVA Producto exonerado"';
                    ToolTip = 'VAT Product Posting Group Exonerated', Comment = 'ESM="Grupo registro IVA Producto exonerado"';
                }
                field("Retention RH %"; "Retention RH %")
                {
                    ApplicationArea = All;
                    Caption = 'Retention %', Comment = 'ESM="% Retención"';
                }
                field("Retention RH Limit Amount"; "Retention RH Limit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Limit Amount', Comment = 'ESM="Importe minimo"';
                }
                field("Retention RH Validate Pre-Post"; "Retention RH Validate Pre-Post")
                {
                    ApplicationArea = All;
                    Caption = 'Validate Pre-Post', Comment = 'ESM="Valida pre-registro"';
                    ToolTip = 'Validate record in pre posting process.', Comment = 'ESM="Realiza la validación previa al registro del documento."';
                }
            }
            group(Detrac)
            {
                Caption = 'Detractions', Comment = 'ESM="Detracciones"';
                field("Detraction Posting Group"; "Detraction Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Detraction Vendor"; "Detraction Vendor")
                {
                    ApplicationArea = All;
                }
                field("Correlative SUNAT"; "Correlative SUNAT")
                {
                    ApplicationArea = All;
                }
                field("Lot Number Detraction"; "Lot Number Detraction")
                {
                    ApplicationArea = All;
                }
                field("SUNAT Generation Date"; "SUNAT Generation Date")
                {
                    ApplicationArea = All;
                }
                field("Detraction Route Export"; "Detraction Route Export")
                {
                    ApplicationArea = All;
                }
            }
            group(FreeTitle)
            {
                Caption = 'Free tile', Comment = 'ESM="Título gratuito"';
                field("FT Free Title"; "FT Free Title")
                {
                    ApplicationArea = All;
                }
                field("FT Gen. Bus. Posting Group"; "FT Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = "FT Free Title";
                }
                field("FT VAT Prod. Posting Group"; "FT VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = "FT Free Title";
                }
                field("FT VAT Bus. Posting Group"; "FT VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = "FT Free Title";
                }
            }
            group(Import)
            {
                Caption = 'Importation', Comment = 'ESM="Importación"';
                field("Importation No. Series"; "Importation No. Series")
                {
                    ApplicationArea = All;
                }
                field("Importation Vendor No."; "Importation Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("DUA Vendor No."; "DUA Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Freight Vendor No."; "Freight Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Other Vendor No. 1"; "Other Vendor No. 1")
                {
                    ApplicationArea = All;
                }
                field("Other Vendor No. 2"; "Other Vendor No. 2")
                {
                    ApplicationArea = All;
                }
                field("Handling Vendor No."; "Handling Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Insurance Vendor No."; "Insurance Vendor No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Internal Consumption")
            {
                Caption = 'Internal Consumption', Comment = 'ESM="Consumo Interno"';
                field("Cust. Acc. Group Int. Cons."; "Cust. Acc. Group Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Gn. Bus. Pst. Group Int. Cons."; "Gn. Bus. Pst. Group Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Customer Int. Cons."; "Customer Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Serial No. Int. Cons."; "Serial No. Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Serial No. Pstd. Int. Cons."; "Serial No. Pstd. Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Serial No."; "Shipment Serial No.")
                {
                    ApplicationArea = All;
                }


                field("For Code"; "For Code")
                {
                    ApplicationArea = All;
                }
            }
            group(AccountantBookSetup)
            {
                Caption = 'Setup Accountant Book', Comment = 'ESM="Conf. Libros contables"';
                field("AB Field reference purch. book"; "AB Field reference purch. book")
                {
                    ApplicationArea = All;
                }
            }
            group(AnalitycGroup)
            {
                Caption = 'Analityc', Comment = 'ESM="Analítica"';
                field("Analityc Global Dimension"; "Analityc Global Dimension")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MasterData)
            {
                ApplicationArea = All;
                Caption = 'Master Data', Comment = 'ESM="Maestro Datos"';
                Image = Setup;
                RunObject = page "Master Data";
            }

            action(Analityc)
            {
                Caption = 'Manual Analityc', Comment = 'ESM="Analítica Manual"';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = Process;

                trigger OnAction()
                var
                    AnalitycMgt: Codeunit "Analitycs Management";
                begin
                    AnalitycMgt.ReassignAnalitycsAccounts();
                end;
            }

            action(Test0001)
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    CodeText: Code[20];
                    ResponseEncript: Text;
                    Record36: record 352;
                    Codeunit1: Codeunit 2;
                begin
                    CodeText := 'Renato';
                    if not EncryptionKeyExists() then
                        CreateEncryptionKey();
                    ResponseEncript := Encrypt(CodeText);
                    Message(ResponseEncript);

                    ResponseEncript := Decrypt('NojehoUcBaEggeqxWyyXxrig/0YJ1Ej1HXPtgdUKwx6vcAtBxsBxHubLHy4JWGSTf61jIwK4DHl0Hju+v22S3jQIYExf9dj3P3D5mI+rplzhF39XCnI4j9PK7Z7cG50TXxW2RSxA6/J6yObyVDQtFw8lFvlW3LyPDOmKksblq63FrOow51/1xQJUwAjfWbXP3oQmXOr1Qa/2FZsQT/qQrvlwxzpTisz8WZPhv0P9mDZJNTGSLeYsWrlVjG39U/fe3ss5MXuoVClR9sgxy0DRxXZtHEdh2qH3SzuK3yNJc+yqdWKUtG/GLsUREshdtfYApJSlIB6rZhl+C24C8VE5rQ==');
                    Message(ResponseEncript);
                end;
            }
            action(ExportEncriptionKey)
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    CodeText: Code[20];
                    ResponseEncript: Text;
                    Record36: record 352;
                    Codeunit1: Codeunit 2;
                begin
                    CodeText := 'Renato';
                    if not EncryptionKeyExists() then
                        CreateEncryptionKey();
                    ResponseEncript := Encrypt(CodeText);
                    Message(ResponseEncript);

                    ResponseEncript := Decrypt('NojehoUcBaEggeqxWyyXxrig/0YJ1Ej1HXPtgdUKwx6vcAtBxsBxHubLHy4JWGSTf61jIwK4DHl0Hju+v22S3jQIYExf9dj3P3D5mI+rplzhF39XCnI4j9PK7Z7cG50TXxW2RSxA6/J6yObyVDQtFw8lFvlW3LyPDOmKksblq63FrOow51/1xQJUwAjfWbXP3oQmXOr1Qa/2FZsQT/qQrvlwxzpTisz8WZPhv0P9mDZJNTGSLeYsWrlVjG39U/fe3ss5MXuoVClR9sgxy0DRxXZtHEdh2qH3SzuK3yNJc+yqdWKUtG/GLsUREshdtfYApJSlIB6rZhl+C24C8VE5rQ==');
                    Message(ResponseEncript);
                end;
            }
        }
    }

    var
        MasterData: Record "Master Data";
        MDPage: Page "Master Data";
        Record81: Record 81;
        DimDescription: Label 'This setup %1 %2.', Comment = 'ESM="Se configuró %1 %2"';

    local procedure UpdateDescription()
    var
        QtyDim: Integer;
    begin
        //-------------------
        MasterData.Reset();
        MasterData.FilterGroup(2);
        MasterData.SetRange("Type Table", 'ADJ-TC-REF');
        MasterData.SetRange("Type Table ref", 'ADJ-TC');
        MasterData.SetRange("Code ref", 'BANK-ADJTC');
        QtyDim := MasterData.Count;
        if QtyDim = 1 then
            "ST Adj. Exch. Dflt. Dim. Bank" := StrSubstNo(DimDescription, QtyDim, 'dimensión')
        else
            "ST Adj. Exch. Dflt. Dim. Bank" := StrSubstNo(DimDescription, QtyDim, 'dimensines');
    end;
}