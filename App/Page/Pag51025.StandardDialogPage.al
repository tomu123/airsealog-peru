page 51025 "Standard Dialog Page"
{
    // version AGR2

    Caption = 'Standard Dialog Page';
    PageType = StandardDialog;
    ShowFilter = false;
    SourceTable = "Tenant Media";

    layout
    {
        area(content)
        {
            group(General)
            {



            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        IF gAttachFiles = 'No se adjuntó archivo.' THEN
            gStyleAttachFiles := 'Attention'
        ELSE
            gStyleAttachFiles := 'StandardAccent';
    end;

    trigger OnOpenPage();
    begin
        gAttachFiles := 'No se adjuntó archivo.';
        //Rec."Primary Key" := -1;
        gCreateTextVendor := 'Click aqui para crear proveedor.';
        gInvoiceDeliveryDate := TODAY;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        lcRecRecordLink: Record "Record Link";
    begin
        IF gViewSustenanceBox THEN BEGIN
            IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
                IF gVoucherBankCode = '' THEN
                    ERROR('Debe ingresar un Cód. Voucher');
                IF gBankCode = '' THEN
                    ERROR('Debe seleccionar un Cód. Banco.');
                IF gPaymentDate = 0D THEN
                    ERROR('Debe seleccionar una fecha de pago.');
                lcRecRecordLink.RESET;
                lcRecRecordLink.SETRANGE("Record ID", Rec.RECORDID);
                IF lcRecRecordLink.ISEMPTY THEN
                    ERROR('Debe adjuntar un archivo como sustento de deposito.');
            END;
        END;
    end;

    var
        gVoucherBankCode: Code[20];
        gBankCode: Code[20];
        gCurrencyCode: Code[10];
        gDocumentNo: Code[20];
        gPaymentMethodCode: Code[20];
        gRecipientBankAccountNo: Code[20];
        gRecipientBankAccNoPaymentSchedule: Code[20];
        gPurchaseNo: Code[20];
        gSUNATDocument: Code[10];
        gVendorNo: Code[20];
        gVendorInvoiceNo: Code[20];
        gCurrentEmployeeNo: Code[20];
        gNewEmployeeNo: Code[20];
        gAmount: Decimal;
        gAmount2: Decimal;
        gPaymentDate: Date;
        gProvisionDate: Date;
        gReversalProvisionDate: Date;
        gClosingDate: Date;
        gSummaryDate: Date;
        gStartDate: Date;
        gEndDate: Date;
        gInvoiceDeliveryDate: Date;
        gCutOffDate: Date;
        gViewSustenanceBox: Boolean;
        gViewRejectedType: Boolean;
        gViewBankModify: Boolean;
        gViewProvision: Boolean;
        gViewReversalProvision: Boolean;
        gViewClosingDate: Boolean;
        gViewAGR2: Boolean;
        gViewBankPaymentSchedule: Boolean;
        gViewSumaryDate: Boolean;
        gViewPurchase: Boolean;
        gViewReport1: Boolean;
        gViewReport2: Boolean;
        gViewReverseMotive: Boolean;
        gElectronicInvoice: Boolean;
        gViewSalesInvoices: Boolean;
        gViewInvoiceDeliveryDate: Boolean;
        gViewCutOffDate: Boolean;
        gViewRejectedObservation: Boolean;
        gViewResponsibleEmployee: Boolean;
        gDescriptionRejected: Text;
        gDescriptionAGR2: Text;
        gRecEmployeeLedgerEntry: Record "Employee Ledger Entry";
        gRecPaymentSchedule: Record "Payment Schedule";
        gAttachFiles: Text;
        gStyleAttachFiles: Text;
        gCreateTextVendor: Text;
        gReversalProvisionDescription: Text[50];
        gReverseMotive: Text;
        gRejectedObservation: Text[100];
        gSalesInvoices: Code[20];
        gCustomerCode: Code[20];


    procedure fnActivateRequest(pType: Integer);
    begin
        gViewSustenanceBox := pType = 1;
        gViewRejectedType := pType = 2;
        gViewBankModify := pType = 3;
        gViewProvision := pType = 4;
        gViewReversalProvision := pType = 5;
        gViewClosingDate := pType = 6;
        gViewAGR2 := pType = 7;
        gViewBankPaymentSchedule := pType = 8;
        gViewSumaryDate := pType = 9;
        gViewReverseMotive := pType = 10;
        gViewPurchase := pType = 11;
        gViewReport1 := pType = 12;
        gViewReport2 := pType = 13;
        gViewSalesInvoices := pType = 14;
        gViewInvoiceDeliveryDate := pType = 15;
        gViewCutOffDate := pType = 16;
        gViewRejectedObservation := pType = 17;
        gViewResponsibleEmployee := pType = 18;
    end;

    procedure fnGetParametersOne(var pVoucherBankCode: Code[20]; var pBankCode: Code[20]; var pCurrencyCode: Code[10]; var pAmount: Decimal; var pPaymentDate: Date);
    begin
        pVoucherBankCode := gVoucherBankCode;
        pBankCode := gBankCode;
        pCurrencyCode := gCurrencyCode;
        pAmount := gAmount;
        pPaymentDate := gPaymentDate;
    end;

    procedure fnGetParametersTwo(var pDescriptionRejected: Text);
    begin
        pDescriptionRejected := gDescriptionRejected;
    end;

    procedure fnSetAmount(var pAmount: Decimal);
    begin
        gAmount := pAmount;
    end;

    procedure fnSetEmployeeEntryNo(pEmployeeLedgerEntryNo: Integer);
    var
        lcRecEmployeeLedgerEntry: Record "Employee Ledger Entry";
    begin
        gRecEmployeeLedgerEntry.GET(pEmployeeLedgerEntryNo);
        gDocumentNo := gRecEmployeeLedgerEntry."Document No.";
        gPaymentMethodCode := gRecEmployeeLedgerEntry."Payment Method Code";
        //gRecipientBankAccountNo := gRecEmployeeLedgerEntry."Recipient Bank Account";
    end;

    procedure fnSetAGR2Control(pAmount: Decimal; pDescription: Text);
    begin
        gAmount2 := pAmount;
        gDescriptionAGR2 := pDescription;
    end;

    procedure fnGetParametersTree(var pPaymentMethodCode: Code[20]; var pRecipientsBankAccountNo: Code[20]);
    begin
        pPaymentMethodCode := gPaymentMethodCode;
        pRecipientsBankAccountNo := gRecipientBankAccountNo;
    end;

    procedure fnGetParameterFour(var pProvisionDate: Date);
    begin
        pProvisionDate := gProvisionDate;
    end;

    procedure fnGetParameterFive(var pReversalProvisionDate: Date);
    begin
        pReversalProvisionDate := gReversalProvisionDate;
    end;

    procedure fnGetParameterFive2(var pReversalProvisionDescription: Text[50]);
    begin
        pReversalProvisionDescription := gReversalProvisionDescription;
    end;

    procedure fnSetParameterFive(pReversalProvisionDescription: Text[50]);
    begin
        gReversalProvisionDescription := 'Rev-' + COPYSTR(pReversalProvisionDescription, 1, 46);
    end;

    procedure fnGetParameterSix(var pClosingDate: Date);
    begin
        pClosingDate := gClosingDate;
    end;

    procedure fnGetParameterSeven(var pAmount: Decimal);
    begin
        pAmount := gAmount2;
    end;

    procedure fnGetParameterEight(var pPaymentMethodCode: Code[20]; var pPreferredBankAccountNo: Code[20]);
    begin
        pPaymentMethodCode := gPaymentMethodCode;
        pPreferredBankAccountNo := gRecipientBankAccNoPaymentSchedule;
    end;

    procedure fnGetParameter9(var pSummaryDate: Date);
    begin
        pSummaryDate := gSummaryDate;
    end;

    procedure fnSetPaymentSchedule(pPaymentScheduleLineNo: Integer);
    var
        lcRecPaymentSchedule: Record "Payment Schedule";
    begin
        gRecPaymentSchedule.GET(pPaymentScheduleLineNo);
        gDocumentNo := gRecPaymentSchedule."Document No.";
        gPaymentMethodCode := gRecPaymentSchedule."Payment Method Code";
        gRecipientBankAccNoPaymentSchedule := gRecPaymentSchedule."Preferred Bank Account Code";
    end;

    procedure fnGetParameterOne2(var pRecordID: RecordID);
    begin
        pRecordID := Rec.RECORDID;
    end;

    procedure fnGetParameter10(var pReverseMotive: Text);
    begin
        pReverseMotive := gReverseMotive;
    end;

    procedure fnSetPurchaseNo(pPurchaseNo: Code[20]);
    var
        lcRecPurchaseHeader: Record "Purchase Header";
    begin
        lcRecPurchaseHeader.RESET;
        lcRecPurchaseHeader.SETRANGE("No.", pPurchaseNo);
        IF lcRecPurchaseHeader.FIND('-') THEN BEGIN
            gPurchaseNo := pPurchaseNo;
            gVendorNo := lcRecPurchaseHeader."Buy-from Vendor No.";
            gVendorInvoiceNo := lcRecPurchaseHeader."Vendor Invoice No.";
            //gSUNATDocument := lcRecPurchaseHeader."Legal Document";
            // gElectronicInvoice := lcRecPurchaseHeader."Documento Electronico";
        END;
    end;

    procedure fnGetParameter11(var pVendorNo: Code[20]; var pSUNATDocument: Code[10]; var pElectronicInvoice: Boolean; var pVendorInvoiceNo: Code[20]);
    begin
        pVendorNo := gVendorNo;
        pSUNATDocument := gSUNATDocument;
        pElectronicInvoice := gElectronicInvoice;
        pVendorInvoiceNo := gVendorInvoiceNo;
    end;

    procedure fnSetAGRLedgetEntry(pAGREntryNo: Integer);
    var

    begin
        /*     lcRecAGRLedgerEntry.GET(pAGREntryNo);
            fnSetEmployeeEntryNo(lcRecAGRLedgerEntry."Employee Entry No."); */
    end;

    procedure fnGetParameter12(var pStartDate: Date; var pEndDate: Date);
    begin
        pStartDate := gStartDate;
        pEndDate := gEndDate;
    end;

    procedure fnGetParameter14(var pSaleInvoice: Code[20]);
    begin
        pSaleInvoice := gSalesInvoices;
    end;

    procedure fnSetParameterCustomer(pCustomer: Code[20]);
    begin
        gCustomerCode := pCustomer;
    end;

    procedure fnGetParameter15(var pInvoiceDeliveryDate: Date);
    begin
        pInvoiceDeliveryDate := gInvoiceDeliveryDate;
    end;

    procedure fnGetParameter16(var pCutOffDate: DateTime);
    var
        lcTime: Time;
    begin
        pCutOffDate := CREATEDATETIME(gCutOffDate, lcTime);
    end;

    procedure fnGetParameter17(var pRejectedObservation: Text[100]);
    begin
        pRejectedObservation := gRejectedObservation;
    end;

    procedure fnSetParameter18(pCurrentEmployeeNo: Code[20]);
    begin
        gCurrentEmployeeNo := pCurrentEmployeeNo;
    end;

    procedure fnGetParameter18(var pNewEmployeeNo: Code[20]);
    begin
        IF gNewEmployeeNo = '' THEN
            ERROR('Debe de seleccionar un nuevo responsable de proyecto.');

        pNewEmployeeNo := gNewEmployeeNo;
    end;


}

