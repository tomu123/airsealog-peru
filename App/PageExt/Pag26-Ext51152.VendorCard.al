pageextension 51152 "ST Vendor Card" extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Preferred Bank Account Code")
        {
            field("Preferred Bank Account Code ME"; "Preferred Bank Account Code ME")
            {
                ApplicationArea = All;
            }
            field("Currenct Account BNAC"; "Currenct Account BNAC")
            {
                ApplicationArea = All;
            }
        }
        addafter("Vendor Posting Group")
        {
            field("Vendor Posting Group ME"; "Vendor Posting Group ME")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Registration No.")
        {
            field("SUNAT Status"; "SUNAT Status")
            {
                ApplicationArea = All;
            }
            field("SUNAT Condition"; "SUNAT Condition")
            {
                ApplicationArea = All;
            }
            field(Ubigeo; Ubigeo)
            {
                ApplicationArea = All;
            }
        }
        addbefore("VAT Registration No.")
        {
            field("VAT Registration Type"; "VAT Registration Type")
            {
                ApplicationArea = All;
            }
        }
        addlast(Invoicing)
        {
            field("Retention Agent"; "Retention Agent")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Perception Agent"; "Perception Agent")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Good Contributor"; "Good Contributor")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        //Ubigeo Begin
        addafter("Address 2")
        {
            field(CountryRegionCode; "Country/Region Code")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field(PostCode; "Post Code")
            {
                ApplicationArea = All;
            }
            field(City2; City)
            {
                ApplicationArea = All;
            }
        }
        addafter(County)
        {
            field(UbigeoDescription; UbigeoMgt.ShowUbigeoDescription("Country/Region Code", "Post Code", City, County))
            {
                ApplicationArea = All;
            }
        }
        //PosCode = Departamento
        //City = Provincia
        //County = County
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify("Post Code")
        {
            Visible = false;
        }
        modify(City)
        {
            Visible = false;
        }
        //Ubigeo End

        //Import
        addlast(Invoicing)
        {
            group("DoubleTaxationAgreements")
            {
                Caption = 'Double Taxation Aggrements', Comment = 'ESM="Convenios Doble Tributación"';
                grid(DoubleTaxationAgreementsGrid)
                {
                    GridLayout = Columns;
                    group("GridGroupDAT1")
                    {
                        ShowCaption = false;
                        field("Double Taxation Agreements"; "Double Taxation Agreements")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnValidate()
                            begin
                                gRecLegalDocument.Reset();
                                gRecLegalDocument.SetRange("Option Type", gRecLegalDocument."Option Type"::"SUNAT Table");
                                gRecLegalDocument.SetRange("Type Code", '25');
                                gRecLegalDocument.SetRange("Legal No.", "Double Taxation Agreements");
                                if gRecLegalDocument.FindSet() then
                                    gTextDoubleTaxationAgreements := gRecLegalDocument.Description;


                            end;
                        }
                    }
                    group("GridGroupDAT2")
                    {
                        ShowCaption = false;
                        field(gTextDoubleTaxationAgreements; gTextDoubleTaxationAgreements)
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(EconomicLinkagesType)
            {
                Caption = 'Economic Linkages Type', Comment = 'ESM="Tipo Vinculación Económica"';
                grid(EconomicLinkagesTypeGrid)
                {
                    GridLayout = Columns;
                    group(GridGroupELT1)
                    {
                        ShowCaption = false;
                        field("Economic Linkages Type"; "Economic Linkages Type")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnValidate()
                            begin
                                gRecLegalDocument.Reset();
                                gRecLegalDocument.SetRange("Option Type", gRecLegalDocument."Option Type"::"SUNAT Table");
                                gRecLegalDocument.SetRange("Type Code", '27');
                                gRecLegalDocument.SetRange("Legal No.", "Economic Linkages Type");
                                if gRecLegalDocument.FindSet() then
                                    gTextEconomicLinkagesType := gRecLegalDocument.Description;
                            end;
                        }
                    }
                    group(GridGroupELT2)
                    {
                        ShowCaption = false;
                        field(gTextEconomicLinkagesType; gTextEconomicLinkagesType)
                        {
                            ShowCaption = false;
                            ApplicationArea = All;
                            Editable = false;
                        }
                    }
                }
            }
        }

        //Purchase Request
        addafter("Purchaser Code")
        {
            field("PR Generic Purchase"; "PR Generic Purchase")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action(ConsultRuc)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Consult Ruc';
                Image = ElectronicNumber;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create Basic Line';

                trigger OnAction()
                var
                    CnsltRucMgt: Codeunit "Cnslt. Ruc Management";
                    Vendor: Record Vendor;
                begin
                    CnsltRucMgt.VendorConsultRuc(Rec);
                end;
            }
        }
    }
    var
        UbigeoMgt: Codeunit "Ubigeo Management";
        gTextDoubleTaxationAgreements: Text;
        gTextEconomicLinkagesType: Text;
        gRecLegalDocument: Record "Legal Document";
}