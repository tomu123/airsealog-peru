pageextension 51028 "Cnslt. Ruc Customer Card" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
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
                    CnsltRucMgt.CustomerConsultRuc(Rec);
                end;
            }
        }
    }

    var
        UbigeoMgt: Codeunit "Ubigeo Management";
}