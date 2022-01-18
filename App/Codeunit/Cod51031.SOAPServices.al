codeunit 51031 "SP SOAP Services"
{
    trigger OnRun()
    begin

    end;

    procedure GetDocumentsVendor(VendorNo: Code[20]; var XMLResult: XMLport "PS Vendor Documents");
    begin
        Clear(XMLResult);
        if VendorNo <> '' then
            XMLResult.SetVendor(VendorNo);
        XMLResult.Export;
    end;

    procedure GetVendorList(VendorNo: Code[20]; var XMLResult: XMLport "PS Vendor List");
    var
        lcVendorLedgerEntryTemp: Record "Vendor Ledger Entry" temporary;
    begin
        Clear(XMLResult);
        if VendorNo <> '' then
            XMLResult.SetVendor(VendorNo);
        XMLResult.Export;
    end;

    procedure SetContract(XMLMessage: XmlPort "Post Contract")
    begin
        XMLMessage.Import();
    end;
}