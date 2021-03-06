codeunit 51005 "Cnslt. Ruc Management"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', true, true)]
    local procedure BeforeTest(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    var
        RegistrationSpecified: Label 'The VAT Registration No. must have %1 characters.';
    begin
        case Vendor."VAT Registration Type" of
            '1':
                begin
                    if StrLen(Vendor."VAT Registration No.") <> 8 then
                        Message(RegistrationSpecified, '8');
                end;
            '6':
                begin
                    if StrLen(Vendor."VAT Registration No.") <> 11 then
                        Message(RegistrationSpecified, '11');
                end;
        end;
    end;

    procedure VendorConsultRuc(var pVendor: Record Vendor)
    var
    begin
        Clear(CnsltRucParameter);
        SetPeruvianLocalization();
        case SLSetup."Create Option Vendor" of
            SLSetup."Create Option Vendor"::"Vendor Nos":
                begin
                    Ruc := pVendor."VAT Registration No.";
                    CnsltRucParameter.SetParameters(Ruc, ConfTempHdr.Code, 23);
                    if CnsltRucParameter.RunModal() in [Action::LookupOK, Action::OK, Action::Yes] then begin
                        CnsltRucParameter.GetParameter(Ruc, ConfTempHdr);
                        SetVendor();
                    end else
                        exit;
                end;
            SLSetup."Create Option Vendor"::"VAT Registration No.":
                begin
                    Ruc := pVendor."No.";
                    CnsltRucParameter.SetParameters(Ruc, ConfTempHdr.Code, 23);
                    if CnsltRucParameter.RunModal() in [Action::LookupOK, Action::OK, Action::Yes] then begin
                        CnsltRucParameter.GetParameter(Ruc, ConfTempHdr);
                        SetVendor();
                    end else
                        exit;
                end;
        end;
    end;

    procedure CustomerConsultRuc(var pCustomer: Record Customer)
    var
    begin
        Clear(CnsltRucParameter);
        SetPeruvianLocalization();
        case SLSetup."Create Option Customer" of
            SLSetup."Create Option Customer"::"Customer Nos":
                begin
                    Ruc := pCustomer."VAT Registration No.";
                    CnsltRucParameter.SetParameters(Ruc, ConfTempHdr.Code, 18);
                    if CnsltRucParameter.RunModal() in [Action::LookupOK, Action::OK, Action::Yes] then begin
                        CnsltRucParameter.GetParameter(Ruc, ConfTempHdr);
                        SetCustomer();
                    end else
                        exit;
                end;
            SLSetup."Create Option Customer"::"VAT Registration No.":
                begin
                    Ruc := pCustomer."No.";
                    CnsltRucParameter.SetParameters(Ruc, ConfTempHdr.Code, 18);
                    if CnsltRucParameter.RunModal() in [Action::LookupOK, Action::OK, Action::Yes] then begin
                        CnsltRucParameter.GetParameter(Ruc, ConfTempHdr);
                        SetCustomer();
                    end else
                        exit;
                end;
        end;
    end;

    local procedure SetVendor()
    begin
        SetPeruvianLocalization();
        ConsumeService();
        if IsExistsVendor() then
            UpdateVendor()
        else
            CreateVendor();
    end;

    local procedure SetCustomer()
    begin
        SetPeruvianLocalization();
        ConsumeService();
        if IsExistsCustomer() then
            UpdateCustomer()
        else
            CreateCustomer();
    end;

    local procedure CreateVendor()
    begin
        Vendor.Init();
        case SLSetup."Create Option Vendor" of
            SLSetup."Create Option Vendor"::"Vendor Nos":
                Vendor."VAT Registration No." := TextField[1];
            SLSetup."Create Option Vendor"::"VAT Registration No.":
                begin
                    Vendor."No." := TextField[1];
                    Vendor."VAT Registration No." := TextField[1];
                end;
        end;
        if StrLen(TextField[2]) > 100 then begin
            Vendor.Name := CopyStr(TextField[2], 1, 100);
            Vendor."Name 2" := CopyStr(TextField[2], 101, 100);
        end else
            Vendor.Name := TextField[2];
        Vendor."SUNAT Status" := TextField[3];
        Vendor."SUNAT Condition" := TextField[4];
        Vendor.Ubigeo := TextField[5];
        if StrLen(TextField[6]) > 100 then begin
            Vendor.Address := CopyStr(TextField[6], 1, 100);
            Vendor."Address 2" := CopyStr(TextField[6], 101, 100);
        end else
            Vendor.Address := TextField[6];
        Vendor."VAT Registration Type" := '6';
        Vendor."Status approved" := ExcludeApprovalVendor;
        Vendor.Insert(true);
        RecordRef_.GetTable(Vendor);
        ConfTemplMgt.UpdateRecord(ConfTempHdr, RecordRef_);
        ShowVendor(true);
    end;

    local procedure UpdateVendor()
    begin
        Vendor.Reset();
        case SLSetup."Create Option Vendor" of
            SLSetup."Create Option Vendor"::"Vendor Nos":
                Vendor.SetRange("VAT Registration No.", TextField[1]);
            SLSetup."Create Option Vendor"::"VAT Registration No.":
                Vendor.SetRange("No.", TextField[1]);
        end;
        Vendor.FindSet();
        if StrLen(TextField[2]) > 100 then begin
            Vendor.Name := CopyStr(TextField[2], 1, 100);
            Vendor."Name 2" := CopyStr(TextField[2], 101, 100);
        end else
            Vendor.Name := TextField[2];
        Vendor."SUNAT Status" := TextField[3];
        Vendor."SUNAT Condition" := TextField[4];
        Vendor.Ubigeo := TextField[5];
        if StrLen(TextField[6]) > 100 then begin
            Vendor.Address := CopyStr(TextField[6], 1, 100);
            Vendor."Address 2" := CopyStr(TextField[6], 101, 100);
        end else
            Vendor.Address := TextField[6];
        Vendor."VAT Registration Type" := '6';
        Vendor.Modify();
        ShowVendor(false);
    end;

    local procedure ShowVendor(IsCreate: Boolean)
    begin
        case SLSetup."Create Option Vendor" of
            SLSetup."Create Option Vendor"::"Vendor Nos":
                begin
                    if Vendor."VAT Registration No." = SourceRuc then begin
                        if IsCreate then
                            Message(VendorCreateMsg, Vendor."VAT Registration No.", Vendor.Name)
                        else
                            Message(VendorUpdateMsg, Vendor."VAT Registration No.", Vendor.Name);
                    end else begin
                        if IsCreate then
                            SetNotification(Vendor."VAT Registration No.", 'No', StrSubstNo(VendorCreateMsg, Vendor."VAT Registration No.", Vendor.Name))
                        else
                            SetNotification(Vendor."VAT Registration No.", 'No', StrSubstNo(VendorUpdateMsg, Vendor."VAT Registration No.", Vendor.Name));
                    end;
                end;
            SLSetup."Create Option Vendor"::"VAT Registration No.":
                begin
                    if Vendor."No." = SourceRuc then begin
                        if IsCreate then
                            Message(VendorCreateMsg, Vendor."No.", Vendor.Name)
                        else
                            Message(VendorUpdateMsg, Vendor."No.", Vendor.Name);
                    end else begin
                        if IsCreate then
                            SetNotification(Vendor."No.", 'No', StrSubstNo(VendorCreateMsg, Vendor."No.", Vendor.Name))
                        else
                            SetNotification(Vendor."No.", 'No', StrSubstNo(VendorUpdateMsg, Vendor."No.", Vendor.Name));
                    end;
                end;
        end;
    end;

    local procedure CreateCustomer()
    begin
        Customer.Init();
        case SLSetup."Create Option Customer" of
            SLSetup."Create Option Customer"::"Customer Nos":
                Customer."VAT Registration No." := TextField[1];
            SLSetup."Create Option Customer"::"VAT Registration No.":
                begin
                    Customer."No." := TextField[1];
                    Customer."VAT Registration No." := TextField[1];
                end;
        end;
        if StrLen(TextField[2]) > 100 then begin
            Customer.Name := CopyStr(TextField[2], 1, 100);
            Customer."Name 2" := CopyStr(TextField[2], 101, 100);
        end else
            Customer.Name := TextField[2];
        Customer."SUNAT Status" := TextField[3];
        Customer."SUNAT Condition" := TextField[4];
        Customer.Ubigeo := TextField[5];
        if StrLen(TextField[6]) > 100 then begin
            Customer.Address := CopyStr(TextField[6], 1, 100);
            Customer."Address 2" := CopyStr(TextField[6], 101, 100);
        end else
            Customer.Address := TextField[6];
        Customer."VAT Registration Type" := '6';
        Customer.Insert(true);
        RecordRef_.GetTable(Customer);
        ConfTemplMgt.UpdateRecord(ConfTempHdr, RecordRef_);
        ShowCustomer(true);
    end;

    local procedure UpdateCustomer()
    begin
        Customer.Reset();
        case SLSetup."Create Option Customer" of
            SLSetup."Create Option Customer"::"Customer Nos":
                Customer.SetRange("VAT Registration No.", TextField[1]);
            SLSetup."Create Option Customer"::"VAT Registration No.":
                Customer.SetRange("No.", TextField[1]);
        end;
        Customer.FindSet();
        if StrLen(TextField[2]) > 100 then begin
            Customer.Name := CopyStr(TextField[2], 1, 100);
            Customer."Name 2" := CopyStr(TextField[2], 101, 100);
        end else
            Customer.Name := TextField[2];
        Customer."SUNAT Status" := TextField[3];
        Customer."SUNAT Condition" := TextField[4];
        Customer.Ubigeo := TextField[5];
        if StrLen(TextField[6]) > 100 then begin
            Customer.Address := CopyStr(TextField[6], 1, 100);
            Customer."Address 2" := CopyStr(TextField[6], 101, 100);
        end else
            Customer.Address := TextField[6];
        Customer."VAT Registration Type" := '6';
        Customer.Modify();
        ShowCustomer(false);
    end;

    local procedure ShowCustomer(IsCreate: Boolean)
    begin
        case SLSetup."Create Option Customer" of
            SLSetup."Create Option Customer"::"Customer Nos":
                begin
                    if Customer."VAT Registration No." = SourceRuc then begin
                        if IsCreate then
                            Message(CustomerCreateMsg, Customer."VAT Registration No.", Customer.Name)
                        else
                            Message(CustomerUpdateMsg, Customer."VAT Registration No.", Customer.Name);
                    end else begin
                        if IsCreate then
                            SetNotification(Customer."VAT Registration No.", 'Yes', StrSubstNo(CustomerCreateMsg, Customer."VAT Registration No.", Customer.Name))
                        else
                            SetNotification(Customer."VAT Registration No.", 'Yes', StrSubstNo(CustomerUpdateMsg, Customer."VAT Registration No.", Customer.Name));
                    end;
                end;
            SLSetup."Create Option Customer"::"VAT Registration No.":
                begin
                    if Customer."No." = SourceRuc then begin
                        if IsCreate then
                            Message(CustomerCreateMsg, Customer."No.", Customer.Name)
                        else
                            Message(CustomerUpdateMsg, Customer."No.", Customer.Name);
                    end else begin
                        if IsCreate then
                            SetNotification(Customer."No.", 'Yes', StrSubstNo(CustomerCreateMsg, Customer."No.", Customer.Name))
                        else
                            SetNotification(Customer."No.", 'Yes', StrSubstNo(CustomerUpdateMsg, Customer."No.", Customer.Name));
                    end;
                end;
        end;
    end;

    procedure SetNotification(pRuc: Code[20]; pIsCustomer: Text; pMessage: Text)
    var
        Notification: Notification;
    begin
        Notification.Message(pMessage);
        Notification.Scope := NotificationScope::LocalScope;
        Notification.SetData('pRuc', pRuc);
        Notification.SetData('pIsCustomer', pIsCustomer);
        Notification.AddAction(SeeHere, Codeunit::"Cnslt. Ruc Management", 'OpenRecordCard');
        Notification.Send();
    end;

    procedure OpenRecordCard(Notification: Notification)
    var
        CustCard: Page "Customer Card";
        VendCard: Page "Vendor Card";
        Cust: Record Customer;
        Vend: Record Vendor;
        pRuc: Code[20];
        pIsCustomer: Text;
    begin
        pRuc := Notification.GetData('pRuc');
        pIsCustomer := Notification.GetData('pIsCustomer');
        if pIsCustomer in ['Yes'] then begin
            Case SLSetup."Create Option Customer" of
                SLSetup."Create Option Customer"::"Customer Nos":
                    begin
                        Cust.Reset();
                        Cust.SetRange("VAT Registration No.", pRuc);
                        Cust.FindFirst();
                    end;
                SLSetup."Create Option Customer"::"VAT Registration No.":
                    Cust.Get(pRuc);
            end;
            Clear(CustCard);
            CustCard.SetTableView(Cust);
            CustCard.Run();
        end else begin
            Case SLSetup."Create Option Vendor" of
                SLSetup."Create Option Vendor"::"Vendor Nos":
                    begin
                        Vend.Reset();
                        Vend.SetRange("VAT Registration No.", pRuc);
                        Vend.FindFirst();
                    end;
                SLSetup."Create Option Vendor"::"VAT Registration No.":
                    Vend.Get(pRuc);
            end;
            Clear(VendCard);
            VendCard.SetTableView(Vend);
            VendCard.Run();
        end;
    end;

    procedure SetRuc(pRuc: Text)
    begin
        Ruc := pRuc;
    end;

    local procedure CreateXmlFile()
    begin
        Clear(XmlFile);
        XmlFile := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:uln="urn:microsoft-dynamics-schemas/codeunit/ULNSOAPServices">';
        XmlFile += '<soapenv:Header/>';
        XmlFile += '   <soapenv:Body>';
        XmlFile += '      <uln:ConsultaRuc>';
        XmlFile += '         <uln:rUC>' + Format(Ruc) + '</uln:rUC>';
        XmlFile += '         <uln:responseRuc>?</uln:responseRuc>';
        XmlFile += '      </uln:ConsultaRuc>';
        XmlFile += '   </soapenv:Body>';
        XmlFile += '</soapenv:Envelope>';
    end;

    local procedure ConsumeService()
    var
        HttpContent: HttpContent;
        HttpHeadersContent: HttpHeaders;
        HttpClient: HttpClient;
        HttpRequestMessagex: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        Lenght: Integer;
        ResponseText: Text;
    begin
        SetInitParametersServices();
        CreateXmlFile();
        HttpContent.WriteFrom(XmlFile);
        HttpContent.GetHeaders(HttpHeadersContent);
        HttpHeadersContent.Remove('Content-Type');
        HttpHeadersContent.Add('Content-Type', 'text/xml;charset=utf-8');
        HttpHeadersContent.Add('SOAPAction', SOAPAction);
        HttpClient.SetBaseAddress(Url);
        HttpClient.DefaultRequestHeaders.Add('Authorization', StrSubstNo('Basic %1', Base64String));
        HttpClient.Post(Url, HttpContent, HttpResponse);
        if HttpResponse.IsSuccessStatusCode then begin
            HttpContent.Clear();
            HttpContent := HttpResponse.Content();
            HttpContent.ReadAs(ResponseText);
            ResponseText := GetXmlTagValue(ResponseText, 'responseRuc');
            CreateFields(ResponseText);
        end else
            Error(format(HttpResponse.HttpStatusCode));
    end;

    local procedure SetInitParametersServices()
    var
        Base64Convert: Codeunit "Base64 Convert";
        AuthorizationString: Text;
    begin
        Url := 'http://13.92.233.220:7047/BC130-TAXPAYER/WS/CONSULTA%20RUC/Codeunit/ULNSOAPServices';
        SoapAction := 'ConsultaRuc';
        AuthorizationString := strsubstNo('%1:%2', 'ULN', 'a123456A');
        Base64String := Base64Convert.ToBase64(AuthorizationString);
    end;

    local procedure SetPositionText(var TextResponse: Text): Text
    var
        AuxText: Text;
    //Page256: Page 256;
    begin
        if StrPos(TextResponse, '|') > 0 then begin
            AuxText := CopyStr(TextResponse, 1, StrPos(TextResponse, '|') - 1);
            TextResponse := CopyStr(TextResponse, StrPos(TextResponse, '|') + 1, StrLen(TextResponse));
        end else
            AuxText := TextResponse;
        exit(AuxText);
    end;

    local procedure GetXmlTagValue(Response: Text; pTag: Text): Text
    var
        StartTag: Text;
        EndTag: Text;
    begin
        StartTag := '<' + pTag + '>';
        EndTag := '</' + pTag + '>';
        Response := CopyStr(Response, STRPOS(Response, StartTag) + StrLen(StartTag), StrLen(Response));
        Response := CopyStr(Response, 1, STRPOS(Response, EndTag) - 1);
        exit(Response);
    end;

    local procedure CreateFields(ResponseText: Text)
    begin
        Clear(TextField);
        if StrPos(ResponseText, '|') > 0 then begin
            TextField[1] := SetPositionText(ResponseText);//RUC
            TextField[2] := SetPositionText(ResponseText);//Nombre Rz Social
            TextField[3] := SetPositionText(ResponseText);//Estado
            TextField[4] := SetPositionText(ResponseText);//Condicion
            TextField[5] := SetPositionText(ResponseText);//Ubigeo
            TextField[6] := SetPositionText(ResponseText);//Address
        end else
            Error(ResponseText);
    end;

    local procedure IsExistsVendor(): Boolean
    begin
        case SLSetup."Create Option Vendor" of
            SLSetup."Create Option Vendor"::"Vendor Nos":
                begin
                    Vendor.Reset();
                    Vendor.SetRange("VAT Registration No.", TextField[1]);
                    exit(Vendor.FindFirst());
                end;
            SLSetup."Create Option Vendor"::"VAT Registration No.":
                exit(Vendor.Get(TextField[1]));
        end;
    end;

    local procedure IsExistsCustomer(): Boolean
    begin
        case SLSetup."Create Option Customer" of
            SLSetup."Create Option Customer"::"Customer Nos":
                begin
                    Customer.Reset();
                    Customer.SetRange("VAT Registration No.", TextField[1]);
                    exit(Customer.FindFirst());
                end;
            SLSetup."Create Option Customer"::"VAT Registration No.":
                exit(Customer.Get(TextField[1]));
        end;
    end;

    local procedure SetPeruvianLocalization()
    begin
        SLSetup.Reset();
        SLSetup.FindFirst();
        SLSetup.TestField("Customer MN Template Code");
        SLSetup.TestField("Customer ME Template Code");
        SLSetup.TestField("Vendor MN Template Code");
        SLSetup.TestField("Vendor ME Template Code");
    end;

    procedure SetExcludeApprovalVendor()
    begin
        ExcludeApprovalVendor := true;
    end;

    var
        SLSetup: Record "Setup Localization";
        Vendor: Record Vendor;
        Customer: Record Customer;
        ConfTempHdr: Record "Config. Template Header";
        ConfigTemplates: Page "Config Templates";
        CnsltRucParameter: Page "Consult RUC Parameter";
        RecordRef_: RecordRef;
        ConfTemplMgt: Codeunit "Config. Template Management";
        Ruc: Code[20];
        SourceRuc: Code[20];
        XmlFile: Text;
        TextField: array[10] of Text;
        Url: Text;
        Base64String: Text;
        SOAPAction: Text;
        ExcludeApprovalVendor: Boolean;
        VendorCreateMsg: Label 'Create vendor %1 - %2 successful.', Comment = 'ESM="Proveedor creado %1 - %2 correctamente."';
        VendorUpdateMsg: Label 'Update vendor %1 - %2 successful.', Comment = 'ESM="Proveedor modificado %1 - %2 correctamente."';
        CustomerCreateMsg: Label 'Create customer %1 - %2 successful.', Comment = 'ESM="Cliente creado %1 - %2 correctamente."';
        CustomerUpdateMsg: Label 'Update customer %1 - %2 successful.', Comment = 'ESM="Cliente modificado %1 - %2 correctamente."';
        SeeHere: Label 'See Here', Comment = 'ESM="Ver aqu??"';
}