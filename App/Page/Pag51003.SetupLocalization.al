page 51003 "Setup Localization"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Setup Localization', Comment = 'ESM="Configuración Localizado"';
    UsageCategory = Administration;
    SourceTable = "Setup Localization";
    Permissions = tabledata "Sales Cr.Memo Line" = rimd, tabledata "Sales Cr.Memo Header" = rimd, tabledata "Sales Invoice Header" = rimd, tabledata "Sales Invoice Line" = rimd,
                tabledata "Purch. Inv. Header" = rimd, tabledata "Purch. Inv. Line" = rimd, tabledata "Purch. Cr. Memo Hdr." = ridm, tabledata "Purch. Cr. Memo Line" = rimd, tabledata "Vendor Ledger Entry" = rimd,
                tabledata "Detailed Vendor Ledg. Entry" = rimd, tabledata "Bank Account Ledger Entry" = rimd, tabledata "G/L Entry" = rimd, tabledata "G/L Entry - VAT Entry Link" = ridm,
                tabledata "VAT Entry" = ridm;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Visible = true;

                field("ST GL Account Realized Gain"; Rec."ST GL Account Realized Gain")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        MasterData.Reset();
                        MasterData.FilterGroup(2);
                        MasterData.SetRange("Type Table", 'ADJ-TC-REF');
                        MasterData.SetRange("Type Table ref", 'ADJ-TC');
                        MasterData.SetRange("Code ref", Rec."ST GL Account Realized Gain");
                        MasterData.FilterGroup(0);
                        Clear(MDPage);
                        MDPage.SetDimensionDefault('ADJ-TC-REF', 'ADJ-TC', Rec."ST GL Account Realized Gain");
                        MDPage.SetTableView(MasterData);
                        MDPage.RunModal();
                    end;
                }
                field("ST GL Account Realized Loss"; Rec."ST GL Account Realized Loss")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        MasterData.Reset();
                        MasterData.FilterGroup(2);
                        MasterData.SetRange("Type Table", 'ADJ-TC-REF');
                        MasterData.SetRange("Type Table ref", 'ADJ-TC');
                        MasterData.SetRange("Code ref", Rec."ST GL Account Realized Loss");
                        MasterData.FilterGroup(0);
                        Clear(MDPage);
                        MDPage.SetDimensionDefault('ADJ-TC-REF', 'ADJ-TC', Rec."ST GL Account Realized Loss");
                        MDPage.SetTableView(MasterData);
                        MDPage.RunModal();
                    end;
                }
                field("ST Adj. Exch. Dflt. Dim. Bank"; Rec."ST Adj. Exch. Dflt. Dim. Bank")
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
                field("ST Coactiva No. Serie"; Rec."ST Coactiva No. Serie")
                {
                    ApplicationArea = All;
                }

                group(AdjustExchangeRateLoc)
                {
                    Caption = 'Adjust Exchange Rates';
                    field("Adj. Exch. Rate Localization"; Rec."Adj. Exch. Rate Localization")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Utiliza el desarrollo localizado en referencia al tipo de ajuste pasivo o activo de los grupos contables.';
                        trigger
                        OnValidate()
                        begin
                            if Rec."Adj. Exch. Rate Localization" then
                                gAdjExchRateLocEditable := true
                            else
                                gAdjExchRateLocEditable := false;
                        end;
                    }
                    field("Adj. Exch. Rate Doc. Pstg Gr"; Rec."Adj. Exch. Rate Doc. Pstg Gr")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Hace el ajuste con el grupo contable del documento, el estandar utiliza el grupo contable configurado en el ficha de maestros, cliente, proveedor, banco. Segun corresponda.';
                        Editable = gAdjExchRateLocEditable;
                    }
                    field("Adj. Exch. Rate Ref. Document"; Rec."Adj. Exch. Rate Ref. Document")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Hace el ajuste por tipo de cambio agrupando por documento, el estandar los agrupa por Cliente, Proveedor, Banco, etc.';
                        Editable = gAdjExchRateLocEditable;
                    }
                }
            }
            group(ConsultRuc)
            {
                Caption = 'Consult Ruc', Comment = 'ESM="Consulta RUC"';
                field("Create Option Vendor"; Rec."Create Option Vendor")
                {
                    ApplicationArea = All;
                }
                field("Vendor MN Template Code"; Rec."Vendor MN Template Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor ME Template Code"; Rec."Vendor ME Template Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Ext Template Code"; Rec."Vendor Ext Template Code")
                {
                    ApplicationArea = All;
                }
                field("Create Option Customer"; Rec."Create Option Customer")
                {
                    ApplicationArea = All;
                }
                field("Customer MN Template Code"; Rec."Customer MN Template Code")
                {
                    ApplicationArea = All;
                }
                field("Customer ME Template Code"; Rec."Customer ME Template Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Ext Template Code"; Rec."Customer Ext Template Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Retention)
            {
                Caption = 'Retention', Comment = 'ESM="Retención"';
                field("Retention Agent Option"; Rec."Retention Agent Option")
                {
                    ApplicationArea = All;
                }
                field("Regime Retention Code"; Rec."Regime Retention Code")
                {
                    ApplicationArea = All;
                }
                field("Retention Percentage %"; Rec."Retention Percentage %")
                {
                    ApplicationArea = All;
                }
                field("Retention Limit Amount"; Rec."Retention Limit Amount")
                {
                    ApplicationArea = All;
                }
                field("Retention G/L Account No."; Rec."Retention G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("Max. Line. Retention Report"; Rec."Max. Line. Retention Report")
                {
                    ApplicationArea = All;
                }
                field("Retention Physical Nos"; Rec."Retention Physical Nos")
                {
                    ApplicationArea = All;
                }
                field("Retention Electronic Nos"; Rec."Retention Electronic Nos")
                {
                    ApplicationArea = All;
                }
                field("Retention Resolution Number"; Rec."Retention Resolution Number")
                {
                    ApplicationArea = All;
                }
            }
            group(RHRetention)
            {
                Caption = 'RH Retntion', Comment = 'ESM="Retención recibo por honorario"';
                field("Retention RH Nos"; Rec."Retention RH Nos")
                {
                    ApplicationArea = All;
                    Caption = 'Serie Nos', Comment = 'ESM="N° Serie"';
                }
                field("Retention RH Posted Nos"; Rec."Retention RH Posted Nos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Serie Nos', Comment = 'ESM="N° Serie Registro"';
                }
                field("Retention RH GLAcc. No."; Rec."Retention RH GLAcc. No.")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Account No.', Comment = 'ESM="N° Cuenta"';
                }
                field("Ret. RH VAT Prod Pstg. Gr. Ex."; Rec."Ret. RH VAT Prod Pstg. Gr. Ex.")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Prod. Pstg. Group Ex.', Comment = 'ESM="Gr. reg. IVA Producto exonerado"';
                    ToolTip = 'VAT Product Posting Group Exonerated', Comment = 'ESM="Grupo registro IVA Producto exonerado"';
                }
                field("Retention RH %"; Rec."Retention RH %")
                {
                    ApplicationArea = All;
                    Caption = 'Retention %', Comment = 'ESM="% Retención"';
                }
                field("Retention RH Limit Amount"; Rec."Retention RH Limit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Limit Amount', Comment = 'ESM="Importe minimo"';
                }
                field("Retention RH Validate Pre-Post"; Rec."Retention RH Validate Pre-Post")
                {
                    ApplicationArea = All;
                    Caption = 'Validate Pre-Post', Comment = 'ESM="Valida pre-registro"';
                    ToolTip = 'Validate record in pre posting process.', Comment = 'ESM="Realiza la validación previa al registro del documento."';
                }
            }
            group(Detrac)
            {
                Caption = 'Detractions', Comment = 'ESM="Detracciones"';
                field("Detraction Posting Group"; Rec."Detraction Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Detraction Vendor"; Rec."Detraction Vendor")
                {
                    ApplicationArea = All;
                }
                field("Correlative SUNAT"; Rec."Correlative SUNAT")
                {
                    ApplicationArea = All;
                }
                field("Lot Number Detraction"; Rec."Lot Number Detraction")
                {
                    ApplicationArea = All;
                }
                field("SUNAT Generation Date"; Rec."SUNAT Generation Date")
                {
                    ApplicationArea = All;
                }
                field("Detraction Route Export"; Rec."Detraction Route Export")
                {
                    ApplicationArea = All;
                }
                field("realized Losses Acc."; Rec."Realized Losses Acc.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        MasterData.Reset();
                        MasterData.FilterGroup(2);
                        MasterData.SetRange("Type Table", 'ADJ-TC-REF');
                        MasterData.SetRange("Type Table ref", 'ADJ-TC');
                        MasterData.SetRange("Code ref", Rec."Realized Losses Acc.");
                        MasterData.FilterGroup(0);
                        Clear(MDPage);
                        MDPage.SetDimensionDefault('ADJ-TC-REF', 'ADJ-TC', Rec."Realized Losses Acc.");
                        MDPage.SetTableView(MasterData);
                        MDPage.RunModal();
                    end;
                }
                field("Unrealized Gains Acc."; Rec."Realized Gains Acc.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        MasterData.Reset();
                        MasterData.FilterGroup(2);
                        MasterData.SetRange("Type Table", 'ADJ-TC-REF');
                        MasterData.SetRange("Type Table ref", 'ADJ-TC');
                        MasterData.SetRange("Code ref", Rec."Realized Gains Acc.");
                        MasterData.FilterGroup(0);
                        Clear(MDPage);
                        MDPage.SetDimensionDefault('ADJ-TC-REF', 'ADJ-TC', Rec."Realized Gains Acc.");
                        MDPage.SetTableView(MasterData);
                        MDPage.RunModal();
                    end;
                }
            }
            group(FreeTitle)
            {
                Caption = 'Free tile', Comment = 'ESM="Título gratuito"';
                field("FT Free Title"; Rec."FT Free Title")
                {
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    begin
                        if Rec."FT Free Title" then
                            gFTFreeTitleEditable := true
                        else
                            gFTFreeTitleEditable := false;
                    end;
                }
                field("FT Gen. Bus. Posting Group"; Rec."FT Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = gFTFreeTitleEditable;
                }
                field("FT VAT Prod. Posting Group"; Rec."FT VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = gFTFreeTitleEditable;
                }
                field("FT VAT Bus. Posting Group"; Rec."FT VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = gFTFreeTitleEditable;
                }
            }
            group(Import)
            {
                Caption = 'Importation', Comment = 'ESM="Importación"';
                field("Importation No. Series"; Rec."Importation No. Series")
                {
                    ApplicationArea = All;
                }
                field("Importation Vendor No."; Rec."Importation Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("DUA Vendor No."; Rec."DUA Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Freight Vendor No."; Rec."Freight Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Other Vendor No. 1"; Rec."Other Vendor No. 1")
                {
                    ApplicationArea = All;
                }
                field("Other Vendor No. 2"; Rec."Other Vendor No. 2")
                {
                    ApplicationArea = All;
                }
                field("Handling Vendor No."; Rec."Handling Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Insurance Vendor No."; Rec."Insurance Vendor No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Internal Consumption")
            {
                Caption = 'Internal Consumption', Comment = 'ESM="Consumo Interno"';
                field("Cust. Acc. Group Int. Cons."; Rec."Cust. Acc. Group Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Gn. Bus. Pst. Group Int. Cons."; Rec."Gn. Bus. Pst. Group Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Customer Int. Cons."; Rec."Customer Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Serial No. Int. Cons."; Rec."Serial No. Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Serial No. Pstd. Int. Cons."; Rec."Serial No. Pstd. Int. Cons.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Serial No."; Rec."Shipment Serial No.")
                {
                    ApplicationArea = All;
                }


                field("For Code"; Rec."For Code")
                {
                    ApplicationArea = All;
                }
            }
            group(AccountantBookSetup)
            {
                Caption = 'Setup Accountant Book', Comment = 'ESM="Conf. Libros contables"';
                field("AB Field reference purch. book"; Rec."AB Field reference purch. book")
                {
                    ApplicationArea = All;
                }
            }
            group(Telecredit)
            {
                Caption = 'Analityc', Comment = 'ESM="Telecreditos"';
                field("Telecredit New Version"; Rec."Telecredit New Version")
                {
                    ApplicationArea = All;
                }
            }
            group(AnalitycGroup)
            {
                Caption = 'Analityc', Comment = 'ESM="Analítica"';
                field("Analityc Global Dimension"; Rec."Analityc Global Dimension")
                {
                    ApplicationArea = All;
                }
            }
            group(Advanced)
            {
                Caption = 'Advanced', Comment = 'ESM="Anticipo"';
                field("Account Advanced PEN"; "Account Advanced PEN")
                {
                    ApplicationArea = All;
                }
                field("Account Advanced USD"; "Account Advanced USD")
                {
                    ApplicationArea = All;
                }
                field("Dimension Advanced"; "Dimension Advanced")
                {
                    ApplicationArea = All;
                }

            }
            group(Funcionalidad)
            {
                Caption = 'Funcionalida ULN';
                field("Option action Document"; "Option action Document")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("New Document No."; "New Document No.")
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

            action(DeleteDocument)
            {
                Caption = 'Delete Document', Comment = 'ESM="Borrar Document"';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = Delete;
                Visible = true;

                trigger OnAction()
                begin
                    TestField("Option action Document", "Option action Document"::"Delete Document");
                    TestField("Document No.");
                    DeleteDocumentProcess();
                end;
            }
            action(CorrectSunat)
            {
                Caption = 'Correct Sunat Status', Comment = 'ESM="Corregir Estado Sunat"';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = RefreshVATExemption;
                trigger OnAction()
                var
                    LDCorrectPostedDocMgt: Codeunit "LD Correct Posted Documents";
                begin
                    if "Option action Document" = "Option action Document"::"Rename Sales Invoice" then begin
                        LDCorrectPostedDocMgt.CorrectLegalStatus("Document No.");
                    end;
                end;
            }
            action(CorrectReturnPurchaseInvoice)
            {
                Caption = 'Correct Return of Purchase Invoice', Comment = 'ESM="Corregir Extorno de Factura de Compra"';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = RefreshVATExemption;
                trigger OnAction()
                var
                    LDCorrectPostedDocMgt: Codeunit "LD Correct Posted Documents";
                begin
                    if "Option action Document" = "Option action Document"::"Rename Purchase Invoice" then begin
                        LDCorrectPostedDocMgt.CorrectReturnPurchaseInvoice("Document No.");
                    end;
                end;
            }
            action(RenameDocument)
            {
                Caption = 'Rename Document', Comment = 'ESM="Renombrar Documento"';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = RefreshVATExemption;
                //Visible = false;

                trigger OnAction()
                var
                    LDCorrectPostedDocMgt: Codeunit "LD Correct Posted Documents";
                begin
                    //TestField("Delete Document");
                    if not ("Option action Document" in ["Option action Document"::"Rename Sales Invoice", "Option action Document"::"Rename Credit Memo", "Option action Document"::"Rename Purch. Credit Memo Ext. Doc. "]) then
                        Error('Solo puede seleccionar las opciones %1 o %2');
                    TestField("Document No.");
                    TestField("New Document No.");
                    if "Option action Document" = "Option action Document"::"Rename Sales Invoice" then
                        LDCorrectPostedDocMgt.RenameSalesDocument(112, "Document No.", "New Document No.");
                    if "Option action Document" = "Option action Document"::"Rename Credit Memo" then
                        LDCorrectPostedDocMgt.RenameSalesDocument(114, "Document No.", "New Document No.");
                    if "Option action Document" = "Option action Document"::"Rename Purch. Credit Memo Ext. Doc. " then
                        LDCorrectPostedDocMgt.RenamePurchDocument(124, "Document No.");
                end;
            }
            action(Update)
            {
                Caption = 'Actualizar NC Serie Compra', Comment = 'ESM="Actualizar NC Serie Compra"';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    PurchCrMemoHdrL: Record "Purch. Cr. Memo Hdr.";
                    VATEntryL: Record "VAT Entry";
                    VendorLedgerEntryL: Record "Vendor Ledger Entry";
                    GLEntryL: Record "G/L Entry";
                    IntPosL: Integer;
                begin
                    //'ENCR0521-0002';
                    if "Document No." = '' then
                        Error('Ingresar No. Documento!');

                    if "New Document No." = '' then
                        Error('Ingresar el No. Serie para la NC Compra!');

                    PurchCrMemoHdrL.Reset();
                    PurchCrMemoHdrL.SetRange("No.", "Document No.");
                    if not PurchCrMemoHdrL.FindSet() then
                        Error('No existe la NC');

                    PurchCrMemoHdrL."Vendor Cr. Memo No." := "New Document No.";
                    PurchCrMemoHdrL.Modify();

                    VATEntryL.Reset();
                    VATEntryL.SetRange("Document No.", PurchCrMemoHdrL."No.");
                    if VATEntryL.FindSet() then begin
                        repeat
                            VATEntryL."External Document No." := "New Document No.";
                            VATEntryL.Modify();
                        until VATEntryL.Next() = 0;
                    end;

                    VendorLedgerEntryL.Reset();
                    VendorLedgerEntryL.SetRange("Document No.", PurchCrMemoHdrL."No.");
                    if VendorLedgerEntryL.FindSet() then begin
                        repeat
                            VendorLedgerEntryL."External Document No." := "New Document No.";
                            VendorLedgerEntryL.Modify();
                        until VendorLedgerEntryL.Next() = 0;
                    end;

                    GLEntryL.Reset();
                    GLEntryL.SetRange("Document No.", PurchCrMemoHdrL."No.");
                    if GLEntryL.FindSet() then begin
                        repeat
                            GLEntryL."External Document No." := "New Document No.";
                            GLEntryL.Modify()
                        until GLEntryL.Next() = 0;
                    end;
                end;
            }

            // action(Test0001)
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            //     trigger OnAction()
            //     var
            //         CodeText: Code[20];
            //         ResponseEncript: Text;
            //         Record36: record 352;
            //         Codeunit1: Codeunit 2;
            //     begin
            //         CodeText := 'Renato';
            //         if not EncryptionKeyExists() then
            //             CreateEncryptionKey();
            //         ResponseEncript := Encrypt(CodeText);
            //         Message(ResponseEncript);

            //         ResponseEncript := Decrypt('NojehoUcBaEggeqxWyyXxrig/0YJ1Ej1HXPtgdUKwx6vcAtBxsBxHubLHy4JWGSTf61jIwK4DHl0Hju+v22S3jQIYExf9dj3P3D5mI+rplzhF39XCnI4j9PK7Z7cG50TXxW2RSxA6/J6yObyVDQtFw8lFvlW3LyPDOmKksblq63FrOow51/1xQJUwAjfWbXP3oQmXOr1Qa/2FZsQT/qQrvlwxzpTisz8WZPhv0P9mDZJNTGSLeYsWrlVjG39U/fe3ss5MXuoVClR9sgxy0DRxXZtHEdh2qH3SzuK3yNJc+yqdWKUtG/GLsUREshdtfYApJSlIB6rZhl+C24C8VE5rQ==');
            //         Message(ResponseEncript);
            //     end;
            // }
            // action(ExportEncriptionKey)
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            //     trigger OnAction()
            //     var
            //         CodeText: Code[20];
            //         ResponseEncript: Text;
            //         Record36: record 352;
            //         Codeunit1: Codeunit 2;
            //     begin
            //         CodeText := 'Renato';
            //         if not EncryptionKeyExists() then
            //             CreateEncryptionKey();
            //         ResponseEncript := Encrypt(CodeText);
            //         Message(ResponseEncript);

            //         ResponseEncript := Decrypt('NojehoUcBaEggeqxWyyXxrig/0YJ1Ej1HXPtgdUKwx6vcAtBxsBxHubLHy4JWGSTf61jIwK4DHl0Hju+v22S3jQIYExf9dj3P3D5mI+rplzhF39XCnI4j9PK7Z7cG50TXxW2RSxA6/J6yObyVDQtFw8lFvlW3LyPDOmKksblq63FrOow51/1xQJUwAjfWbXP3oQmXOr1Qa/2FZsQT/qQrvlwxzpTisz8WZPhv0P9mDZJNTGSLeYsWrlVjG39U/fe3ss5MXuoVClR9sgxy0DRxXZtHEdh2qH3SzuK3yNJc+yqdWKUtG/GLsUREshdtfYApJSlIB6rZhl+C24C8VE5rQ==');
            //         Message(ResponseEncript);
            //     end;
            // }
        }
    }

    var
        MasterData: Record "Master Data";
        MDPage: Page "Master Data";
        Record81: Record 81;
        DimDescription: Label 'This setup %1 %2.', Comment = 'ESM="Se configuró %1 %2"';
        gAdjExchRateLocEditable: Boolean;
        gFTFreeTitleEditable: Boolean;

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
            Rec."ST Adj. Exch. Dflt. Dim. Bank" := StrSubstNo(DimDescription, QtyDim, 'dimensión')
        else
            Rec."ST Adj. Exch. Dflt. Dim. Bank" := StrSubstNo(DimDescription, QtyDim, 'dimensines');
    end;



    procedure DeleteDocumentProcess()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        VATEntry: Record "VAT Entry";
        BankAccLedgeEntry: Record "Bank Account Ledger Entry";
        GLEntry: Record "G/L Entry";
        GLEntryLink: Record "G/L Entry - VAT Entry Link";
    begin
        TestField("Document No.");

        // Codigo provisional de emergencia, borrar luego
        if "Document No." = 'RH0421-00001' then begin
            VendLedgEntry.Reset();
            VendLedgEntry.SetRange("Document No.", 'RH0421-00001');
            VendLedgEntry.DeleteAll();

            DtldVendLedgEntry.Reset();
            DtldVendLedgEntry.SetRange("Document No.", 'RH0421-00001');
            DtldVendLedgEntry.DeleteAll();

            BankAccLedgeEntry.Reset();
            BankAccLedgeEntry.SetRange("Document No.", 'RH0421-00001');
            BankAccLedgeEntry.DeleteAll();

            GLEntry.Reset();
            GLEntry.SetRange("Document No.", 'RH0421-00001');
            if GLEntry.FindFirst() then
                repeat
                    GLEntryLink.Reset();
                    GLEntryLink.SetRange("G/L Entry No.", GLEntry."Entry No.");
                    GLEntryLink.DeleteAll();
                    GLEntry.Delete();
                until GLEntry.Next() = 0;

            VATEntry.Reset();
            VATEntry.SetRange("Document No.", 'RH0421-00001');
            if VATEntry.FindFirst() then
                repeat
                    GLEntryLink.Reset();
                    GLEntryLink.SetRange("VAT Entry No.", VATEntry."Entry No.");
                    GLEntryLink.DeleteAll();
                    VATEntry.Delete();
                until VATEntry.Next() = 0;

            EXIT;
        end;

        GLEntry.Reset();
        GLEntry.SetRange("Document No.", "Document No.");
        if GLEntry.FindFirst() then
            ERROR('No puede eliminar un documento que tiene registros contables');

        if SalesInvHeader.Get("Document No.") then begin
            SalesInvLine.Reset();
            SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
            SalesInvLine.DeleteAll();

            //     CustLedgEntry.Reset();
            //     CustLedgEntry.SetRange("Document No.", SalesInvHeader."No.");
            //     CustLedgEntry.DeleteAll();

            //     DtldCustLedgEntry.Reset();
            //     DtldCustLedgEntry.SetRange("Document No.", SalesInvHeader."No.");
            //     DtldCustLedgEntry.DeleteAll();

            //     BankAccLedgeEntry.Reset();
            //     BankAccLedgeEntry.SetRange("Document No.", SalesInvHeader."No.");
            //     BankAccLedgeEntry.DeleteAll();

            //     GLEntry.Reset();
            //     GLEntry.SetRange("Document No.", SalesInvHeader."No.");
            //     if GLEntry.FindFirst() then
            //         repeat
            //             GLEntryLink.Reset();
            //             GLEntryLink.SetRange("G/L Entry No.", GLEntry."Entry No.");
            //             GLEntryLink.DeleteAll();
            //             GLEntry.Delete();
            //         until GLEntry.Next() = 0;

            //     VATEntry.Reset();
            //     VATEntry.SetRange("Document No.", SalesInvHeader."No.");
            //     if VATEntry.FindFirst() then
            //         repeat
            //             GLEntryLink.Reset();
            //             GLEntryLink.SetRange("VAT Entry No.", VATEntry."Entry No.");
            //             GLEntryLink.DeleteAll();
            //         until VATEntry.Next() = 0;
            //     SalesInvHeader.Delete();
        end else
            if SalesCrMemoHdr.Get("Document No.") then begin
                SalesCrMemoLine.Reset();
                SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHdr."No.");
                SalesCrMemoLine.DeleteAll();

                // CustLedgEntry.Reset();
                // CustLedgEntry.SetRange("Document No.", SalesCrMemoHdr."No.");
                // CustLedgEntry.DeleteAll();

                // DtldCustLedgEntry.Reset();
                // DtldCustLedgEntry.SetRange("Document No.", SalesCrMemoHdr."No.");
                // DtldCustLedgEntry.DeleteAll();

                // BankAccLedgeEntry.Reset();
                // BankAccLedgeEntry.SetRange("Document No.", SalesCrMemoHdr."No.");
                // BankAccLedgeEntry.DeleteAll();

                // GLEntry.Reset();
                // GLEntry.SetRange("Document No.", SalesCrMemoHdr."No.");
                // if GLEntry.FindFirst() then
                //     repeat
                //         GLEntryLink.Reset();
                //         GLEntryLink.SetRange("G/L Entry No.", GLEntry."Entry No.");
                //         GLEntryLink.DeleteAll();
                //         GLEntry.Delete();
                //     until GLEntry.Next() = 0;

                // VATEntry.Reset();
                // VATEntry.SetRange("Document No.", SalesCrMemoHdr."No.");
                // if VATEntry.FindFirst() then
                //     repeat
                //         GLEntryLink.Reset();
                //         GLEntryLink.SetRange("VAT Entry No.", VATEntry."Entry No.");
                //         GLEntryLink.DeleteAll();
                //     until VATEntry.Next() = 0;
                SalesCrMemoHdr.Delete();
            end else
                if PurchInvHeader.Get("Document No.") then begin
                    PurchInvLine.Reset();
                    PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
                    PurchInvLine.DeleteAll();

                    //         VendLedgEntry.Reset();
                    //         VendLedgEntry.SetRange("Document No.", PurchInvHeader."No.");
                    //         VendLedgEntry.DeleteAll();

                    //         DtldVendLedgEntry.Reset();
                    //         DtldVendLedgEntry.SetRange("Document No.", PurchInvHeader."No.");
                    //         DtldVendLedgEntry.DeleteAll();

                    //         BankAccLedgeEntry.Reset();
                    //         BankAccLedgeEntry.SetRange("Document No.", PurchInvHeader."No.");
                    //         BankAccLedgeEntry.DeleteAll();

                    //         GLEntry.Reset();
                    //         GLEntry.SetRange("Document No.", PurchInvHeader."No.");
                    //         if GLEntry.FindFirst() then
                    //             repeat
                    //                 GLEntryLink.Reset();
                    //                 GLEntryLink.SetRange("G/L Entry No.", GLEntry."Entry No.");
                    //                 GLEntryLink.DeleteAll();
                    //                 GLEntry.Delete();
                    //             until GLEntry.Next() = 0;

                    //         VATEntry.Reset();
                    //         VATEntry.SetRange("Document No.", PurchInvHeader."No.");
                    //         if VATEntry.FindFirst() then
                    //             repeat
                    //                 GLEntryLink.Reset();
                    //                 GLEntryLink.SetRange("VAT Entry No.", VATEntry."Entry No.");
                    //                 GLEntryLink.DeleteAll();
                    //             until VATEntry.Next() = 0;
                    PurchInvHeader.Delete();
                end else
                    if PurchCrMemoHdr.Get("Document No.") then begin
                        PurchCrMemoLine.Reset();
                        PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
                        PurchCrMemoLine.DeleteAll();

                        //             VendLedgEntry.Reset();
                        //             VendLedgEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
                        //             VendLedgEntry.DeleteAll();

                        //             DtldVendLedgEntry.Reset();
                        //             DtldVendLedgEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
                        //             DtldVendLedgEntry.DeleteAll();

                        //             BankAccLedgeEntry.Reset();
                        //             BankAccLedgeEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
                        //             BankAccLedgeEntry.DeleteAll();

                        //             GLEntry.Reset();
                        //             GLEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
                        //             if GLEntry.FindFirst() then
                        //                 repeat
                        //                     GLEntryLink.Reset();
                        //                     GLEntryLink.SetRange("G/L Entry No.", GLEntry."Entry No.");
                        //                     GLEntryLink.DeleteAll();
                        //                     GLEntry.Delete();
                        //                 until GLEntry.Next() = 0;

                        //             VATEntry.Reset();
                        //             VATEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
                        //             if VATEntry.FindFirst() then
                        //                 repeat
                        //                     GLEntryLink.Reset();
                        //                     GLEntryLink.SetRange("VAT Entry No.", VATEntry."Entry No.");
                        //                     GLEntryLink.DeleteAll();
                        //                 until VATEntry.Next() = 0;
                        PurchCrMemoHdr.Delete();
                    end;
    end;
}
