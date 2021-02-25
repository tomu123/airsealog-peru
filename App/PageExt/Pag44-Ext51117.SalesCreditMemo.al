pageextension 51117 "Legal Doc. Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            group(Localization)
            {
                Caption = 'Peruvian Localization', Comment = 'Localización peruana';
                field("Legal Document"; "Legal Document")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Legal Status"; "Legal Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Registration Type"; "VAT Registration Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                group(LegalPropertyType)
                {
                    Caption = 'Legal Property Type', Comment = 'ESM="Tipo de Bien SUNAT"';
                    grid(LegalPropertyTypeGrid)
                    {
                        GridLayout = Columns;
                        group(GridGroupLPT1)
                        {
                            ShowCaption = false;
                            field("Legal Property Type"; "Legal Property Type")
                            {
                                ApplicationArea = All;
                                ShowCaption = false;
                                trigger OnValidate()
                                begin
                                    CurrPage.Update();
                                end;
                            }
                        }
                        group(GridGroupLPT2)
                        {
                            ShowCaption = false;
                            field("Legal Property Type Name"; ShowLegalPropertyName())
                            {
                                ApplicationArea = All;
                                ShowCaption = false;
                                Editable = false;
                            }
                        }
                    }
                }
            }
        }

        addafter("Foreign Trade")
        {

            group(Aplicacion)
            {
                Visible = true;
                Caption = 'Application';

                field("Applies-to Doc. Type2"; "Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No.2"; "Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Manual Document Ref."; "Manual Document Ref.")
                {
                    ApplicationArea = All;
                }
                field("Electronic Doc. Ref"; "Electronic Doc. Ref")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No. Ref."; "Applies-to Doc. No. Ref.")
                {
                    ApplicationArea = All;
                }
                field("Legal Document Ref."; "Legal Document Ref.")
                {
                    ApplicationArea = All;
                    Editable = "Manual Document Ref.";
                }
                field("Applies-to Number Ref."; "Applies-to Number Ref.")
                {
                    ApplicationArea = All;
                    Editable = "Manual Document Ref.";
                }

                field("Applies-to Serie Ref."; "Applies-to Serie Ref.")
                {
                    ApplicationArea = All;
                    Editable = "Manual Document Ref.";
                }
                field("Applies-to Document Date Ref."; "Applies-to Document Date Ref.")
                {
                    ApplicationArea = All;
                    Editable = "Manual Document Ref.";
                }

            }
            group(Detraction)
            {
                Caption = 'Detraction';
                field("Sales Detraction"; "Sales Detraction")
                {
                    ApplicationArea = All;
                }
                field("Operation Type Detrac"; "Operation Type Detrac")
                {
                    ApplicationArea = All;
                    Editable = "Sales Detraction";
                }
                field("Service Type Detrac"; "Service Type Detrac")
                {
                    ApplicationArea = All;
                    Editable = "Sales Detraction";
                }
                field("Payment Method Code Detrac"; "Payment Method Code Detrac")
                {
                    ApplicationArea = All;
                    Editable = "Sales Detraction";
                }
                field("Sales % Detraction"; "Sales % Detraction")
                {
                    ApplicationArea = All;
                    Editable = "Sales Detraction";
                }
                field("Sales Amt Detraction"; "Sales Amt Detraction")
                {
                    ApplicationArea = All;
                    Editable = "Sales Detraction";
                }
                field("Sales Amt Detraction (LCY)"; "Sales Amt Detraction (LCY)")
                {
                    ApplicationArea = All;
                    Editable = "Sales Detraction";
                }
            }
        }
        //Ubigeo Begin ********************************************************************************************************
        // Add changes to page layout here
        //PosCode = Departamento
        //City = Provincia
        //County = County

        //******************************* BEGIN Sell-to ***********************************
        addafter("Sell-to Address 2")
        {
            field(BuyFromCountryRegionCode; "Sell-to Country/Region Code")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field(BuyFromPostCode; "Sell-to Post Code")
            {
                ApplicationArea = All;
            }
            field(BuyFromCity2; "Sell-to City")
            {
                ApplicationArea = All;
            }
            field(BuyFromCounty; "Sell-to County")
            {
                ApplicationArea = All;
            }
            field(BuyFromUbigeoDescription; UbigeoMgt.ShowUbigeoDescription("Sell-to Country/Region Code", "Sell-to Post Code", "Sell-to City", "Sell-to County"))
            {
                ApplicationArea = All;
            }
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Sell-to Post Code")
        {
            Visible = false;
        }
        modify("Sell-to City")
        {
            Visible = false;
        }
        modify("Sell-to County")
        {
            Visible = false;
        }
        //******************************* END Sell-to *************************************

        //******************************* BEGIN Bill-to *************************************
        addafter("Bill-to Address 2")
        {
            field(PayToCountryRegionCode; "Bill-to Country/Region Code")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field(PayToPostCode; "Bill-to Post Code")
            {
                ApplicationArea = All;
            }
            field(PayToCity2; "Bill-to City")
            {
                ApplicationArea = All;
            }
            field(PayToCounty; "Bill-to County")
            {
                ApplicationArea = All;
            }
            field(PayToUbigeoDescription; UbigeoMgt.ShowUbigeoDescription("Bill-to Country/Region Code", "Bill-to Post Code", "Bill-to City", "Bill-to County"))
            {
                ApplicationArea = All;
            }
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Bill-to Post Code")
        {
            Visible = false;
        }
        modify("Bill-to City")
        {
            Visible = false;
        }
        modify("Bill-to County")
        {
            Visible = false;
        }
        //******************************* END Bill-to *************************************
        //Ubigeo End **********************************************************************************************************
    }

    actions
    {
        // Add changes to page actions here
    }
    procedure ShowLegalPropertyName(): Text[250]
    var
        MyLegalDocument: Record "Legal Document";
    begin
        MyLegalDocument.Reset();
        MyLegalDocument.SetRange("Option Type", MyLegalDocument."Option Type"::"SUNAT Table");
        MyLegalDocument.SetRange("Type Code", '30');
        MyLegalDocument.SetRange("Legal No.", "Legal Property Type");
        if MyLegalDocument.Find('-') then
            exit(MyLegalDocument.Description);
        exit('');
    end;

    var
        UbigeoMgt: Codeunit "Ubigeo Management";
}