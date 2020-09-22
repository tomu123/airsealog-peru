pageextension 51170 "ST Purchase Order" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here

        moveafter(Status; "Shortcut Dimension 2 Code")
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Suite;
            Importance = Additional;
            Visible = true;
        }
        moveafter(Status; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Suite;
            Importance = Additional;
            Visible = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
            {
                ApplicationArea = Suite;
                Importance = Additional;
                Visible = true;
            }
        }

        addafter(Prepayment)
        {
            group(Detractions)
            {
                Caption = 'Detractions', Comment = 'ESM="Detracciones"';
                field("Purch. Detraction"; "Purch. Detraction")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                group(TypeOfService)
                {
                    Caption = 'Type Of Service', Comment = 'ESM="Tipo de servicio"';
                    grid(Mygrid)
                    {
                        field("Type of Service"; "Type of Service")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnValidate()
                            var
                                myInt: Integer;
                            begin
                                CurrPage.Update();
                            end;
                        }
                    }
                }
                group(TypeOfOperation)
                {
                    Caption = 'Type Of Operation', Comment = 'ESM="Tipo de operación"';
                    grid(Mygrid2)
                    {
                        field("Type of Operation"; "Type of Operation")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            trigger OnValidate()
                            var
                                myInt: Integer;
                            begin
                                CurrPage.Update();
                            end;
                        }
                    }
                }
                field("Purch. % Detraction"; "Purch. % Detraction")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Purch. Amount Detraction"; "Purch. Amount Detraction")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Purch Amount Detraction (DL)"; "Purch Amount Detraction (DL)")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Purch. Detraction Operation"; "Purch. Detraction Operation")
                {
                    ApplicationArea = All;
                }
                field("Purch Date Detraction"; "Purch Date Detraction")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
            }
        }
        //Legal Document Begin
        addlast(General)
        {
            group(Localization)
            {
                Caption = 'Peruvian Localization', Comment = 'ESM="Localización peruana"';
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
                    Caption = 'Legal Property Type', Comment = 'ESM="Tipo de bien"';
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
        //Legal Document Begin

        //Ubigeo Begin **********************************************************************************************************
        // Add changes to page layout here
        //PosCode = Departamento
        //City = Provincia
        //County = County

        //******************************* BEGIN Buy-from ***********************************
        addafter("Buy-from Address 2")
        {
            field(BuyFromCountryRegionCode; "Buy-from Country/Region Code")
            {
                ApplicationArea = All;
                Editable = false;
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field(BuyFromPostCode; "Buy-from Post Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(BuyFromCity2; "Buy-from City")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(BuyFromCounty; "Buy-from County")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(BuyFromUbigeoDescription; UbigeoMgt.ShowUbigeoDescription("Buy-from Country/Region Code", "Buy-from Post Code", "Buy-from City", "Buy-from County"))
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Buy-from Post Code")
        {
            Visible = false;
        }
        modify("Buy-from City")
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }
        //******************************* END Buy-from *************************************

        //******************************* BEGIN Ship-to ***********************************
        addafter("Ship-to Address 2")
        {
            field(ShipToCountryRegionCode; "Ship-to Country/Region Code")
            {
                ApplicationArea = All;
                Editable = false;
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field(ShipToPostCode; "Ship-to Post Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(ShipToCity2; "Ship-to City")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(ShipToCounty; "Ship-to County")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(ShipToUbigeoDescription; UbigeoMgt.ShowUbigeoDescription("Ship-to Country/Region Code", "Ship-to Post Code", "Ship-to City", "Ship-to County"))
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Ship-to Post Code")
        {
            Visible = false;
        }
        modify("Ship-to City")
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }
        //******************************* END Ship-to *************************************

        //******************************* BEGIN Pay-to *************************************
        addafter("Pay-to Address 2")
        {
            field(PayToCountryRegionCode; "Pay-to Country/Region Code")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field(PayToPostCode; "Pay-to Post Code")
            {
                ApplicationArea = All;
            }
            field(PayToCity2; "Pay-to City")
            {
                ApplicationArea = All;
            }
            field(PayToCounty; "Pay-to County")
            {
                ApplicationArea = All;
            }
            field(PayToUbigeoDescription; UbigeoMgt.ShowUbigeoDescription("Pay-to Country/Region Code", "Pay-to Post Code", "Pay-to City", "Pay-to County"))
            {
                ApplicationArea = All;
            }
        }
        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Pay-to Post Code")
        {
            Visible = false;
        }
        modify("Pay-to City")
        {
            Visible = false;
        }
        modify("Pay-to County")
        {
            Visible = false;
        }
        //******************************* END Pay-to *************************************
        //Ubigeo End **********************************************************************************************************

        //Import
        addlast("Foreign Trade")
        {
            // control with underlying datasource
            field("Importation No."; "Importation No.")
            {
                ApplicationArea = All;

            }
            field(Nationalization; Nationalization)
            {
                ApplicationArea = All;
            }
        }
        modify("Area")
        {
            Caption = 'Port / ', Comment = 'ESM="Puerto"';
            //TableRelation = "Legal Document"."Legal No." WHERE("Option Type" = filter("SUNAT Table"), "Type Code" = filter('11'));
        }
        modify("Entry Point")
        {
            Caption = 'INCOTERM', Comment = 'ESM="INCOTERM"';
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        UbigeoMgt: Codeunit "Ubigeo Management";

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
}