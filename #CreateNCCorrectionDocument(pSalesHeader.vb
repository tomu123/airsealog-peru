#CreateNCCorrectionDocument(pSalesHeader : Record "Sales Cr.Memo Header";pIsCreditMemo : Boolean;pPrint : Boolean;pCorrection : Boolean)
//010
pSalesHeader.TESTFIELD("SUNAT Status",pSalesHeader."SUNAT Status"::Normal);
"#CheckOpenItemLedgerEntryinDocuments"(114,pSalesHeader."No.",pSalesHeader."Posting Date");
CLEAR(gCadenaTexto);
gNumtoApply := 0;
lclVendorLedgerEntry.RESET;
lclVendorLedgerEntry.SETRANGE("Document Type",lclVendorLedgerEntry."Document Type"::"Credit Memo");
lclVendorLedgerEntry.SETRANGE(lclVendorLedgerEntry."Customer No.",pSalesHeader."Sell-to Customer No.");
lclVendorLedgerEntry.SETRANGE(lclVendorLedgerEntry."Posting Date",pSalesHeader."Posting Date");
lclVendorLedgerEntry.SETRANGE(lclVendorLedgerEntry."Document No.",pSalesHeader."No.");
lclVendorLedgerEntry.SETAUTOCALCFIELDS("Remaining Amount");
IF lclVendorLedgerEntry.FINDSET THEN BEGIN
  DetailedCustLedgEntry.RESET;
  DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.","Entry Type");
  DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.",lclVendorLedgerEntry."Entry No.");
  DetailedCustLedgEntry.SETRANGE("Entry Type",DetailedCustLedgEntry."Entry Type"::Application);
  DetailedCustLedgEntry.SETRANGE(Unapplied,FALSE);
  IF DetailedCustLedgEntry.FINDSET THEN REPEAT
     gNumtoApply +=1;
  UNTIL DetailedCustLedgEntry.NEXT = 0;
  IF gNumtoApply <> 0 THEN BEGIN
    ERROR('Hay %1 documentos por desliquidar',gNumtoApply);
  END;
END;

IF pCorrection THEN BEGIN
 IF NOT CONFIRM(lclText002) THEN EXIT;
END ELSE BEGIN
 IF NOT CONFIRM(lclText001) THEN EXIT;
END;
CLEAR(lclCuNoSeriesMng);
lclNextDocNo := '';
lclPercentage := 0;
lclSalesSetup.GET;
lclSalesSetup.TESTFIELD("Invoice Nos.");
lclSalesHeader.INIT;
lclSalesHeader.TRANSFERFIELDS(pSalesHeader,FALSE);
lclSalesHeader."Document Type" := lclSalesHeader."Document Type"::Invoice;
lclNextDocNo :=lclCuNoSeriesMng.GetNextNo(lclSalesSetup."Invoice Nos.",WORKDATE,TRUE);
lclSalesHeader."No." := lclNextDocNo;
lclSalesHeader.Status := lclSalesHeader.Status::Open;
lclSalesHeader."Electronic Billing" := FALSE;
lclSalesHeader."SUNAT Document" := '01';
lclSalesHeader."Posting No. Series" := fnGetNoSeriesInterna(lclSalesHeader."SUNAT Document",lclDocumentType::Venta);
lclSalesHeader.VALIDATE("Applies-to Doc. Type",lclSalesHeader."Applies-to Doc. Type"::Invoice);
lclSalesHeader.VALIDATE("Applies-to Doc. No.",lclSalesHeader."No.");
//lclSalesHeader."SUNAT Document" := '00';
lclSalesHeader.INSERT(TRUE);

IF NOT pCorrection THEN BEGIN
  pSalesHeader.VALIDATE("SUNAT Status",pSalesHeader."SUNAT Status"::Anulado); //ULN:TK  29.10.2021 20:33
END ELSE BEGIN
 pSalesHeader.VALIDATE("SUNAT Status",pSalesHeader."SUNAT Status"::Extornado); //ULN:TK  29.10.2021 20:33
END;
pSalesHeader.MODIFY;
lclSalesline4.RESET;
lclSalesline4.SETRANGE("Document No.",pSalesHeader."No.");
lclSalesline4.SETFILTER(Type,'<>%1',lclSalesline4.Type::" ");
IF lclSalesline4.FINDSET THEN REPEAT
  lclSalesline2.INIT;
  lclSalesline2."Document Type" := lclSalesline2."Document Type"::Invoice;
  lclSalesline2."Document No." := lclNextDocNo;
  //INICIO EALB::21-09-2020
  lcLineNo += 10000;
  lclSalesline2."Line No." := lcLineNo;
  //FINEALB::21-09-2020
  lclSalesline2.Type := lclSalesline4.Type;
  lclSalesline2.VALIDATE("No.",lclSalesline4."No.");
  lclSalesline2.VALIDATE(Quantity,lclSalesline4.Quantity);
  lclSalesline2.VALIDATE("Unit Price",lclSalesline4."Unit Price");
  lclSalesline2.VALIDATE("Gen. Prod. Posting Group",lclSalesline4."Gen. Prod. Posting Group");
  IF lclSalesline4.Type = lclSalesline4.Type::Item THEN BEGIN
    lclSalesline2.VALIDATE("Location Code",lclSalesline4."Location Code");
    lclSalesline2.VALIDATE("Bin Code",lclSalesline4."Bin Code");
    lclValueEntry.RESET;
    lclValueEntry.SETRANGE("Document No.",lclSalesline4."Document No.");
    lclValueEntry.SETRANGE("Document Line No.",lclSalesline4."Line No.");
    lclValueEntry.SETRANGE("Item No.",lclSalesline4."No.");
    IF lclValueEntry.FINDSET THEN REPEAT
      lclItemLedgerEntry.RESET;
      lclItemLedgerEntry.SETRANGE("Entry No.",lclValueEntry."Item Ledger Entry No.");
      IF lclItemLedgerEntry.FINDSET THEN BEGIN
          lclCuCreateReservEntry.CreateReservEntryFor(37,2,lclSalesHeader."No.",'',0,0,ABS(lclItemLedgerEntry.Quantity),ABS(lclItemLedgerEntry.Quantity),ABS(lclItemLedgerEntry.Quantity),'',lclItemLedgerEntry."Lot No.");
          lclCuCreateReservEntry.CreateEntry(lclItemLedgerEntry."Item No.",'',lclItemLedgerEntry."Location Code",'',WORKDATE,WORKDATE,0,3);
      END;
    UNTIL lclValueEntry.NEXT = 0;
  END;
  lclSalesline2.INSERT;
UNTIL lclSalesline4.NEXT = 0;
lclSalesHeader.Status := lclSalesHeader.Status::Released;

lclSalesHeader.MODIFY;
lclSalesHeader."Responsibility Center" := pSalesHeader."Responsibility Center";
lclSalesHeader.VALIDATE("SUNAT Document",'01');
lclSalesHeader.VALIDATE(lclSalesHeader."Applies-to Doc. Type",lclSalesHeader."Applies-to Doc. Type"::"Credit Memo");
lclSalesHeader.VALIDATE("Applies-to Doc. No.",pSalesHeader."No.");
lclSalesHeader."Applies-to SUNAT Document" := pSalesHeader."SUNAT Document";
lclSalesHeader."Posting Description":='Nota de Credito a Factura :'+lclSalesHeader."No.";

lclSalesHeader.VALIDATE("SUNAT Status",lclSalesHeader."SUNAT Status"::Anulado); // ULN:LAMC 21.10.2021 19:31

lclSalesHeader."SUNAT Document" := '00';

lclSalesHeader.MODIFY;
IF NOT pPrint THEN
 CODEUNIT.RUN(CODEUNIT::"Sales-Post",lclSalesHeader)
ELSE
 CODEUNIT.RUN(CODEUNIT::"Sales-Post + Print",lclSalesHeader);
IF pCorrection THEN "#RenameSalesRecords"(pSalesHeader."No.",pSalesHeader."Posting Date",pSalesHeader."SUNAT Document");
//010
