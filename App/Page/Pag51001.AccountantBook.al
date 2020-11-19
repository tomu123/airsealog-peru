page 51001 "Accountant Book"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Accountant Book', Comment = 'ESM="Libros contables"';
    UsageCategory = Lists;
    SourceTable = "Accountant Book";

    layout
    {
        area(Content)
        {
            repeater(ListRepeater)
            {
                IndentationColumn = IdentationColumAB;
                IndentationControls = "Book Code";
                FreezeColumn = "Book Name";
                ShowAsTree = true;

                field("Book Code"; Rec."Book Code")
                {
                    ApplicationArea = All;
                }
                field("Book Name"; Rec."Book Name")
                {
                    ApplicationArea = All;
                }
                field("Format DateTime"; Rec."Format DateTime")
                {
                    ApplicationArea = All;
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;
                }
            }
            group(EBooksFiles)
            {
                Caption = 'Ebooks Files', Comment = 'ESM="Libro Electrónicos"';
                part(LinesFiles; "ST Control File List")
                {
                    ApplicationArea = All;
                    SubPageLink = "File ID" = field("EBook Code");
                    SubPageView = WHERE("Entry Type" = FILTER(<> "Recaudación"));
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

            action(PrintBooks)
            {
                ApplicationArea = All;
                Caption = 'Books', Comment = 'ESM="Libros Físicos"';
                Promoted = true;
                PromotedIsBig = true;
                Image = PrintReport;

                trigger OnAction()
                begin
                    if not Rec.IsEmpty then
                        if Rec."Report ID" <> 0 then
                            Report.RunModal(Rec."Report ID", true, true)
                        else
                            Message(MsgNotPrintFormat);
                end;
            }
            action(EBooks)
            {
                ApplicationArea = All;
                Caption = 'E-Books', Comment = 'ESM="Libros Electrónicos"';
                Promoted = true;
                PromotedIsBig = true;
                Image = ElectronicDoc;

                trigger OnAction()
                var
                    AccBookMgt: Codeunit "Accountant Book Management";
                    Page6520: page 6520;
                begin
                    case Rec."EBook Code" of
                        '501', '503', '601':
                            AccBookMgt.GenJournalBooks(Rec."EBook Code", true);
                        '801', '802':
                            AccBookMgt.PurchaserRecord(Rec."EBook Code", true);
                    end;
                end;
            }
            action(CreateLines)
            {
                ApplicationArea = All;
                Caption = 'Create Lines', Comment = 'ESM="Crear lineas"';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    Page43: Page 43;
                    AccountantBookMgt: Codeunit "Accountant Book Management";
                begin
                    AccountantBookMgt.InitializeConfigurationAccountantBook();
                end;
            }
        }
    }

    var
        IdentationColumAB: Integer;
        MsgNotPrintFormat: Label 'The book does not have a printed representation.', Comment = 'ESM="El libro no tiene una reporte asociado"';

    trigger OnAfterGetRecord()
    begin
        IdentationColumAB := Rec.Level;
    end;
}