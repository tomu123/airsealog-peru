page 51014 "SUNAT Vendor Register List"
{
    Caption = 'SUNAT Vendor Register List';
    PageType = List;
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Vendor;
    SourceTableView = where("VAT Registration Type" = const('6'));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }

                field("VAT Registration No."; "VAT Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Retention Agent"; "Retention Agent")
                {
                    ApplicationArea = All;
                }
                field("Retention Agent Start Date"; "Retention Agent Start Date")
                {
                    ApplicationArea = All;
                }
                field("Retention Agent End Date"; "Retention Agent End Date")
                {
                    ApplicationArea = All;
                }
                field("Retention Agent Resolution"; "Retention Agent Resolution")
                {
                    ApplicationArea = All;
                }
                field("Perception Agent"; "Perception Agent")
                {
                    ApplicationArea = All;
                }
                field("Perception Agent Start Date"; "Perception Agent Start Date")
                {
                    ApplicationArea = All;
                }
                field("Perception Agent End Date"; "Perception Agent End Date")
                {
                    ApplicationArea = All;
                }
                field("Perception Agent Resolution"; "Perception Agent Resolution")
                {
                    ApplicationArea = All;
                }
                field("Good Contributor"; "Good Contributor")
                {
                    ApplicationArea = All;
                }
                field("Good Contributor Start Date"; "Good Contributor Start Date")
                {
                    ApplicationArea = All;
                }
                field("Good Contributor End Date"; "Good Contributor End Date")
                {
                    ApplicationArea = All;
                }
                field("Good Contributor Resolution"; "Good Contributor Resolution")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Upload Retention Agent")
            {
                ApplicationArea = All;
                Caption = 'Upload Retention Agent';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CalculateDiscount;
                RunObject = xmlport "Import Rgtr. Retention Agent";
            }
            action("Upload Perception Agent")
            {
                ApplicationArea = All;
                Caption = 'Upload Perception Agent';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CalculateDepreciation;
                RunObject = xmlport "Import Rgtr. Perception Agent";
            }
            action("Upload Good Contributor")
            {
                ApplicationArea = All;
                Caption = 'Upload Good Contributor';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UserCertificate;
                RunObject = xmlport "Import Rgtr. Good Contributor ";
            }
        }
    }
}