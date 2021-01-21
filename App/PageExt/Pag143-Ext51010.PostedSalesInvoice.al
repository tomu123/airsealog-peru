pageextension 51010 "Legal Doc. Pstd Sales Inv." extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter(Corrective)
        {
            field("Legal Document"; "Legal Document")
            {
                ApplicationArea = Basic, Suite;
            }

            field("Legal Status"; "Legal Status")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(Correct)
        {

            action(CorrectLegalDocAction)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Correct Ext.';
                ToolTip = 'Reverse this posted invoice and automatically create a new invoice with the same information that you can correct before posting. This posted invoice will automatically be canceled.';
                Image = Undo;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = "Repeater";
                trigger OnAction()
                var
                    NewDocumentNo: Code[20];
                begin
                    //NewDocumentNo := Rec."No.";
                    LDCorrectPstdDoc.SalesCorrectInvoice(Rec);
                    //Get(NewDocumentNo);
                    //SelectLatestVersion();
                end;
            }

            action(CancellLegalDocAction)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancell';
                ToolTip = 'Reverse this posted invoice and automatically create a new invoice with the same information that you can correct before posting. This posted invoice will automatically be canceled.';
                Image = Undo;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = "Repeater";
                trigger OnAction()
                begin
                    LDCorrectPstdDoc.SalesCancelInvoice(Rec);
                end;
            }
        }

        modify(CorrectInvoice)
        {
            Enabled = false;
            Visible = false;
        }

        modify(CancelInvoice)
        {
            Enabled = false;
            Visible = false;
        }
    }

    var
        LDCorrectPstdDoc: Codeunit "LD Correct Posted Documents";
}