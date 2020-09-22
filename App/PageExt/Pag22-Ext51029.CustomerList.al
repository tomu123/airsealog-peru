pageextension 51029 "Cnslt. Ruc Customer List" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here

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
        myInt: Integer;
}