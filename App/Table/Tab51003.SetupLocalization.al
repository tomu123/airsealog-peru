table 51003 "Setup Localization"
{
    DataClassification = ToBeClassified;
    Caption = 'Setup Localization', Comment = 'ESM="Conf. localizado"';

    fields
    {
        // Add fields 51000..51010
        field(51000; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary key', Comment = 'ESM="Clave primaria"';
        }
        field(51001; "Adj. Exch. Rate Localization"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Adjust Exh. Rates Localization', Comment = 'ESM="Ajuste TC"';
            trigger OnValidate()
            begin
                if "Adj. Exch. Rate Localization" then
                    gFieldsExchRateEditable := true
                else
                    gFieldsExchRateEditable := false;

                if not "Adj. Exch. Rate Localization" then begin
                    "Adj. Exch. Rate Doc. Pstg Gr" := "Adj. Exch. Rate Localization";
                    "Adj. Exch. Rate Ref. Document" := "Adj. Exch. Rate Localization";
                end;
            end;
        }
        field(51002; "Adj. Exch. Rate Doc. Pstg Gr"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Adj. Exch. Rate Doc. Pstg Gr';
        }
        field(51003; "Adj. Exch. Rate Ref. Document"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Adj. Exch. Rate Ref. Document';
        }
        field(51004; "ST GL Account Realized Loss"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'GL. Account Realized Loss', Comment = 'ESM="N° Cuenta por pérdida"';
            TableRelation = "G/L Account";
            trigger OnValidate()
            begin
                ValidateRealizeGainLossAccount();
            end;
        }
        field(51005; "ST GL Account Realized Gain"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'GL. Account Realized Gain', Comment = 'ESM="N° Cuenta por ganancia"';
            TableRelation = "G/L Account";
            trigger OnValidate()
            begin
                ValidateRealizeGainLossAccount();
            end;
        }
        field(51006; "ST Adj. Exch. Dflt. Dim. Bank"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Adj. Exch. Dflt Dim. to Bank', Comment = 'ESM="Ajuste TC dimensión defecto"';
            Editable = false;
        }
        field(51007; "ST Coactiva No. Serie"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Coactiva No. Serie', Comment = 'ESM="N° Serie Coactiva"';
            TableRelation = "No. Series";
        }
        field(51008; "Account Advanced USD"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cuenta Anticipo Dolares', Comment = 'ESM="Cuenta Anticipo Dolares"';
            TableRelation = "G/L Account";
        }

        field(51009; "Account Advanced PEN"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cuenta Anticipo Soles', Comment = 'ESM="Cuenta Anticipo Soles"';
            TableRelation = "G/L Account";
        }
        field(51010; "Dimension Advanced"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Dimension Anticipo', Comment = 'ESM="Dimension Anticipo"';
            TableRelation = Dimension;
        }
        field(51115; "Analityc Global Dimension"; Code[20])
        {
            Caption = 'Analityc Global Dimension', Comment = 'ESM="Dimensión Analítica"';
            DataClassification = ToBeClassified;
            TableRelation = Dimension.Code;
        }

        //Detrac Begin
        field(51101; "Detraction Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Detraction posting group', Comment = 'ESM="Gr. Contable detracción"';
            TableRelation = "Vendor Posting Group".Code;
        }
        field(51102; "Detraction Vendor"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Detraction vendor', Comment = 'ESM="Proveedor detracción"';
            TableRelation = Vendor;
        }
        field(51103; "Lot Number Detraction"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Lot number detraction', Comment = 'ESM="N° Lote detracción"';
        }
        field(51104; "Correlative SUNAT"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Correlative SUNAT', Comment = 'ESM="Correlativo SUNAT"';
        }
        field(51105; "SUNAT Generation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'SUNAT Generation date', Comment = 'ESM="Fecha generación SUNAT"';
        }
        field(51106; "Detraction Route Export"; Text[130])
        {
            DataClassification = ToBeClassified;
            Caption = 'Detraction route export', Comment = 'ESM="Ruta de exportación detrac."';
        }
        //Detrac End

        //Consulta Ruc Begin
        field(51107; "Create Option Vendor"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Create option vendor', Comment = 'ESM="Opción creación de proveedor"';
            OptionMembers = "Vendor Nos","VAT Registration No.";
            OptionCaption = 'Vendor Nos,VAT Registration No.', Comment = 'ESM="N° Serie proveedor,N° RUC"';
        }
        field(51108; "Vendor MN Template Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vend. MN Templ. Code.', Comment = 'ESM="Cód. Plantilla Proveedor MN"';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(23));
        }
        field(51109; "Vendor ME Template Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vend. ME Templ. Code.', Comment = 'ESM="Cód. Plantilla Proveedor ME"';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(23));
        }
        field(51110; "Create Option Customer"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Create option customer', Comment = 'ESM="Opción creación de cliente"';
            OptionMembers = "Customer Nos","VAT Registration No.";
            OptionCaption = 'Vendor Nos,VAT Registration No.', Comment = 'ESM="N° Serie cliente,N° RUC"';
        }
        field(51111; "Customer MN Template Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cust. MN Templ. Code.', Comment = 'ESM="Cód. Plantilla cliente MN"';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(18));
        }
        field(51112; "Customer ME Template Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cust. ME Templ. Code.', Comment = 'ESM="Cód. Plantilla cliente ME"';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(18));
        }
        field(51113; "Vendor Ext Template Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vend. Ext. Templ. Code.', Comment = 'ESM="Cód. Plantilla Proveedor"';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(23));
        }
        field(51114; "Customer Ext Template Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cust. Ext. Templ. Code.', Comment = 'ESM="Cód. Plantilla Cliente"';
            TableRelation = "Config. Template Header".Code where("Table ID" = const(18));
        }
        //Consulta Ruc End

        //Retentions begin
        field(51120; "Retention Agent Option"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention Agent Option', Comment = 'ESM="Opción Agente retención"';
            OptionMembers = "Disable","Only Physical","Only Electronic","Physical and Electronics";
            OptionCaption = 'Disable,Only Physical,Only Electronic,Physical and Electronic', Comment = 'ESM="Deshabilitado,Solo retenciones físicas, Solo retenciones electrónicas,Retenciones físicas y electrónicas"';
        }
        field(51121; "Regime Retention Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Regime Retention Code', Comment = 'ESM="Cód. regimen de retención"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("Catalogue SUNAT"), "Type Code" = const('23'));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                LegalDocument: Record "Legal Document";
            begin
                LegalDocument.Reset();
                LegalDocument.SetRange("Option Type", LegalDocument."Option Type"::"Catalogue SUNAT");
                LegalDocument.SetRange("Type Code", '23');
                LegalDocument.SetRange("Legal No.", "Regime Retention Code");
                if LegalDocument.FindFirst() then
                    "Retention Percentage %" := LegalDocument."Amount %"
                else
                    "Retention Percentage %" := 0;
            end;
        }
        field(51122; "Retention Percentage %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention Percentage %', Comment = 'ESM="% retención"';
        }
        field(51123; "Retention Limit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention Limit Amount', Comment = 'ESM="Importe limite retención"';
        }
        field(51124; "Retention G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention G/L Account No.', Comment = 'ESM="N° cuente Retención"';
            TableRelation = "G/L Account"."No.";
        }
        field(51125; "Max. Line. Retention Report"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max. Line. Retention Report', Comment = 'ESM="Max. lineas impresión ret."';
        }
        field(51126; "Retention Physical Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention Physical Nos', Comment = 'ESM="N° Serie Física"';
            TableRelation = "No. Series";
        }
        field(51027; "Retention Electronic Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Retention Electronic Nos', Comment = 'ESM="N° Serie Electrónica"';
            TableRelation = "No. Series";
        }
        field(51028; "Retention Resolution Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Resolution Number', Comment = 'ESM="Número resolución"';
        }
        //Retentions End

        //Retention RH Begin
        field(51130; "Retention RH Nos"; Code[20])
        {
            Caption = 'Retention RH Nos', Comment = 'ESM="N° Serie Retención RH"';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(51131; "Retention RH Posted Nos"; Code[20])
        {
            Caption = 'Retention RH Posted Nos', Comment = 'ESM="N° Serie Reg. Retención RH"';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(51132; "Retention RH GLAcc. No."; Code[20])
        {
            Caption = 'Retention RH G/L Account No.', Comment = 'ESM="N° Cuenta Retención RH"';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51033; "Ret. RH VAT Prod Pstg. Gr. Ex."; Code[20])
        {
            Caption = 'VAT Prod. Pstg. Group Ex.', Comment = 'ESM="Gr. IVA Prod. Reg. Exonerado RH"';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(51034; "Retention RH %"; Decimal)
        {
            Caption = 'Retention RH %', Comment = 'ESM="% Retención RH"';
            DataClassification = ToBeClassified;
        }
        field(51035; "Retention RH Limit Amount"; Decimal)
        {
            Caption = 'Retention RH Limint Amount', Comment = 'ESM="Importe minimo retención RH"';
            DataClassification = ToBeClassified;
        }
        field(51036; "Retention RH Validate Pre-Post"; Option)
        {
            Caption = 'Retention RH Validate Pre-Post', Comment = 'ESM="Valida Pre-Registro Ret. RH"';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Show Alert","Show Error";
            OptionCaption = ' ,Show Alert,Show Error', Comment = 'ESM=" ,Mostrar alerta,Mostrar error"';
        }
        //Retention RH End

        //Free title begin
        field(51050; "FT Free Title"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Free Title', Comment = 'ESM="Título gratuito"';
        }
        field(51051; "FT Gen. Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Gen. Bus. Posting Group', Comment = 'ESM="Grupo registro negocio"';
            TableRelation = "Gen. Business Posting Group";
        }

        field(51052; "FT VAT Prod. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Prod. Posting Group', Comment = 'ESM="Grupo Reg. IVA prod."';
            TableRelation = "VAT Product Posting Group";
        }
        field(51053; "FT VAT Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Bus. Posting Group', Comment = 'ESM="Grupo Reg. IVA negocio"';
            TableRelation = "VAT Business Posting Group";
        }
        //Free title end

        //Import Begin
        field(51044; "Importation No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No. Series', Comment = 'ESM="N° Serie importación"';
            TableRelation = "No. Series";
        }
        field(51037; "Importation Vendor No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor No.', Comment = 'ESM="N° Proveedor Importación"';
            TableRelation = Vendor;
        }
        field(51038; "DUA Vendor No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'DUA Vendor No.', Comment = 'ESM="N° Proveedor DUA"';
            TableRelation = Vendor;
        }
        field(51039; "Freight Vendor No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Freight Vendor No.', Comment = 'ESM="N° Proveedor flete"';
            TableRelation = Vendor;
        }
        field(51040; "Other Vendor No. 1"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Vendor No. 1', Comment = 'ESM="N° Proveedor Otro 1"';
            TableRelation = Vendor;
        }
        field(51041; "Other Vendor No. 2"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Vendor No. 2', Comment = 'ESM="N° Proveedor Otro 2"';
            TableRelation = Vendor;
        }
        field(51042; "Handling Vendor No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Handling Vendor No.', Comment = 'ESM="N° Proveedor Despacho"';
            TableRelation = Vendor;
        }
        field(51043; "Insurance Vendor No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Insurance Vendor No.', Comment = 'ESM="N° Proveedor Seguro"';
            TableRelation = Vendor;
        }
        //Import End

        //Internal Consumption Begin
        field(51165; "Cust. Acc. Group Int. Cons."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cust. Acc. Group Int. Cons.', Comment = 'ESM="Gr. Reg Cliente Cons. Int."';
            TableRelation = "Customer Posting Group";
        }
        field(51166; "Gn. Bus. Pst. Group Int. Cons."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Gen. Bus. Post. Group Int. Cons.', Comment = 'ESM="Gr. Reg. Negocio Cons. Int."';
            TableRelation = "Gen. Business Posting Group";
        }
        field(51167; "Customer Int. Cons."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Int. Cons.', Comment = 'ESM="N° Cliente Cons. Int."';
            TableRelation = Customer;
        }
        field(51168; "Serial No. Int. Cons."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serial No. Int. Cons.', Comment = 'ESM="N° Serie Cons. Int."';
            TableRelation = "No. Series";
        }
        field(51169; "Serial No. Pstd. Int. Cons."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serial No. Pstd. Int. Cons.', Comment = 'ESM="N° Serie Reg. Cons. Int."';
            TableRelation = "No. Series";
        }
        field(51170; "Shipment Serial No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Shipment Serial No.', Comment = 'ESM="N° Serie Remisión"';
            TableRelation = "No. Series";
        }

        field(51173; "For Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stop Category', Comment = 'ESM="Categoría de parada"';
            // TableRelation = "Master Data Customizado".Code WHERE("Type Table" = FILTER("Stop Category"));
        }
        //Internal Consumption End

        //Accountant book
        field(51140; "AB Field reference purch. book"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Field reference purch. book', Comment = 'ESM="Campo ref. libro compra"';
            OptionMembers = "Buy-Vendor","Pay-Vendor";
            OptionCaption = 'Buy-Vendor,Pay-Vendor', Comment = 'ESM="Compra a proveedor,Pago a proveedor"';
        }
        field(51141; "AB Field reference Sales. book"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Field reference Sales. book', Comment = 'ESM="Campo ref. libro venta"';
            OptionMembers = "Sell-Customer","Bill-Customer";
            OptionCaption = 'Sell-Customer,Bill-Customer', Comment = 'ESM="venta a cliente,Factura a cliente"';
        }
        field(51190; "Telecredit New Version"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Telecredit New Version', Comment = 'ESM="Nueva Versión"';
        }
        field(51191; "Realized Losses Acc."; Code[20])
        {
            Caption = 'realized Losses Acc.', Comment = 'ESM="Cta. redondeo neg."';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin

            end;
        }
        field(51192; "Realized Gains Acc."; Code[20])
        {
            Caption = 'realized Gains Acc.', Comment = 'ESM="Cta. redondeo pos."';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin

            end;
        }
        field(51193; "Delete Document"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51194; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.', Comment = 'ESM="N° Documento"';
        }
        field(51195; "New Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Document No.', Comment = 'ESM="N° Documento Nuevo"';
        }
        field(51196; "Option action Document"; Option)
        {
            Caption = 'Option action Document', Comment = 'ESM="Tipo de acción para documento"';
            OptionMembers = " ","Delete Document","Rename Sales Invoice","Rename Credit Memo","Rename Purch. Credit Memo Ext. Doc. ";
            OptionCaption = ' ,Eliminar Documento,Renombrar Factura de Venta,Renombrar Nota de Crédito de Venta,Renombrar Nota de Crédito Documento Externo';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        MasterData: record "Master Data";
        gFieldsExchRateEditable: Boolean;

    local procedure ValidateRealizeGainLossAccount()
    var
        NextEntryNo: Integer;
        Codeunit483: Codeunit 483;
    begin
        MasterData.Reset();
        MasterData.SetRange("Type Table", 'ADJ-TC');
        MasterData.SetRange(Code, '');
        MasterData.DeleteAll();

        MasterData.Reset();
        MasterData.SetCurrentKey("Entry No.");
        MasterData.SetAscending("Entry No.", true);
        if MasterData.FindLast() then
            NextEntryNo := MasterData."Entry No." + 1
        else
            NextEntryNo := 1;

        if "ST GL Account Realized Loss" <> '' then begin
            MasterData.Reset();
            MasterData.SetRange("Type Table", 'ADJ-TC');
            MasterData.SetRange(Code, "ST GL Account Realized Loss");
            if MasterData.IsEmpty then begin
                MasterData.Init();
                MasterData."Entry No." := NextEntryNo;
                MasterData."Type Table" := 'ADJ-TC';
                MasterData.Code := "ST GL Account Realized Loss";
                MasterData.Description := 'Ajuste tipo de cambio para pérdida.';
                MasterData.Insert();
            end;
        end;

        if "ST GL Account Realized Gain" <> '' then begin
            MasterData.Reset();
            MasterData.SetRange("Type Table", 'ADJ-TC');
            MasterData.SetRange(Code, "ST GL Account Realized Gain");
            if MasterData.IsEmpty then begin
                MasterData.Init();
                MasterData."Entry No." := NextEntryNo;
                MasterData."Type Table" := 'ADJ-TC';
                MasterData.Code := "ST GL Account Realized Gain";
                MasterData.Description := 'Ajuste tipo de cambio para ganancia.';
                MasterData.Insert();
            end;
        end;
    end;
}