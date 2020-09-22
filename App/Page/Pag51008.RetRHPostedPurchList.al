page 51008 "Ret. RH Posted Purch. Invoices"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Posted Purchase Invoices', Comment = 'ESM="Histórico Recibo por honorario"';
    CardPageID = "Posted Purchase Invoice";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Correct,Invoice,Print,Print/Send,Navigate';
    QueryCategory = 'Posted Purchase Invoices';
    RefreshOnActivate = true;
    SourceTable = "Purch. Inv. Header";
    SourceTableView = SORTING("Posting Date")
                      ORDER(Descending) where("Legal Document" = const('02'));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor No.', Comment = 'ESM="N° Proveedor"';
                }
                field("Order Address Code"; "Order Address Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor', Comment = 'ESM="Proveedor"';
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Suite;
                }
                field("Retention RH Gross amount"; "Retention RH Gross amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Retention RH Fourth Amount"; "Retention RH Fourth Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnDrillDown()
                    begin
                        DoDrillDown;
                    end;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnDrillDown()
                    begin
                        DoDrillDown;
                    end;
                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; "Buy-from Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Pay-to Vendor No."; "Pay-to Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Pay-to Name"; "Pay-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Pay-to Post Code"; "Pay-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; "Pay-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Pay-to Contact"; "Pay-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                }
                field("No. Printed"; "No. Printed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cancelled; Cancelled)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = NOT Cancelled;
                    Style = Unfavorable;
                    StyleExpr = Cancelled;

                    trigger OnDrillDown()
                    begin
                        ShowCorrectiveCreditMemo;
                    end;
                }
                field(Corrective; Corrective)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = NOT Corrective;
                    Style = Unfavorable;
                    StyleExpr = Corrective;

                    trigger OnDrillDown()
                    begin
                        ShowCancelledCreditMemo;
                    end;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = NOT IsOfficeAddin;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice', Comment = 'ESM="Factura"';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics', Comment = 'ESM="Estadistica"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Purchase Invoice Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments', Comment = 'ESM="Comentarios"';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions', Comment = 'ESM="Dimensiones"';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ShortCutKey = 'Alt+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action(IncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Document', Comment = 'ESM="Documentos de entrada"';
                    Image = Document;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard("No.", "Posting Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print', Comment = 'ESMP="Imprimir"';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                Visible = NOT IsOfficeAddin;

                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    CurrPage.SetSelectionFilter(PurchInvHeader);
                    PurchInvHeader.PrintRecords(true);
                end;
            }
            action(Navigate)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Navigate', Comment = 'ESM="Navegar"';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category5;
                Scope = Repeater;
                Visible = NOT IsOfficeAddin;

                trigger OnAction()
                begin
                    Navigate;
                end;
            }
            group(RelatedInformationNavigation)
            {
                Caption = 'Navigation', Comment = 'ESM="Navegación"';
                Image = Invoice;
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor', Comment = 'ESM="Proveedor"';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                }
            }
            group(Correct)
            {
                Caption = 'Correct', Comment = 'ESM="Corregir"';
                action(CorrectInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Correct', Comment = 'ESM="Corregir"';
                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Scope = Repeater;
                    Visible = not Cancelled;

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Correct PstdPurchInv (Yes/No)", Rec);
                    end;
                }
                action(CancelInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel', Comment = 'ESM="Cancelar"';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Scope = Repeater;
                    Visible = not Cancelled;

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Cancel PstdPurchInv (Yes/No)", Rec);
                    end;
                }
                action(CreateCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Corrective Credit Memo', Comment = 'ESM="Crear nota de crédito corrección "';
                    Image = CreateCreditMemo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Scope = Repeater;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        CorrectPostedPurchInvoice: Codeunit "Correct Posted Purch. Invoice";
                    begin
                        if CorrectPostedPurchInvoice.CreateCreditMemoCopyDocument(Rec, PurchaseHeader) then
                            PAGE.Run(PAGE::"Purchase Credit Memo", PurchaseHeader);
                    end;
                }
                action(ShowCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Canceled/Corrective Credit Memo', Comment = 'ESM="Mostrar nota de crédito cancelada/corregida"';
                    Image = CreditMemo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Scope = Repeater;
                    Visible = Cancelled OR Corrective;

                    trigger OnAction()
                    begin
                        ShowCanceledOrCorrCrMemo;
                    end;
                }
            }
            action("Update Document")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Document', Comment = 'ESM="Actualizar documento"';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    PostedPurchInvoiceUpdate: Page "Posted Purch. Invoice - Update";
                begin
                    PostedPurchInvoiceUpdate.LookupMode := true;
                    //PostedPurchInvoiceUpdate.SetRec(Rec);
                    //PostedPurchInvoiceUpdate.RunModal;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
        HasFilters: Boolean;
    begin
        HasFilters := GetFilters <> '';
        SetSecurityFilterOnRespCenter;
        if HasFilters then
            if FindFirst then;
        IsOfficeAddin := OfficeMgt.IsAvailable;
    end;

    local procedure DoDrillDown()
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        PurchInvHeader.Copy(Rec);
        PurchInvHeader.SetRange("No.");
        PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader);
    end;

    var
        IsOfficeAddin: Boolean;
}