page 51002 "ST Control File List"
{
    AutoSplitKey = true;
    Caption = 'Lines', Comment = 'ESM="Lineas"';
    Editable = false;
    DelayedInsert = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "ST Control File";
    //SourceTableView = WHERE("Document Type" = FILTER(Invoice));
    SourceTableView = WHERE("Entry Type" = FILTER(<> "Recaudación"));


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }

                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }

                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }

                field("Exists File"; Rec."File Blob".HasValue())
                {
                    ApplicationArea = All;
                }

                field("Create User ID"; Rec."Create User ID")
                {
                    ApplicationArea = All;
                }

                field("Create DateTime File"; Rec."Create DateTime File")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DownloadFile)
            {
                ApplicationArea = All;
                Caption = 'Download File', Comment = 'ESM="Descargar archivo"';
                Image = ExportFile;
                Promoted = true;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction();
                begin
                    Rec.DownLoadFile(Rec);
                end;
            }
            action(DeleteFile)
            {
                ApplicationArea = All;
                Caption = 'Delete File', Comment = 'ESM="Eliminar archivo"';
                Image = DeleteRow;
                Promoted = true;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction();
                begin
                    if not Rec.IsEmpty then
                        Rec.Delete();
                end;
            }
        }
    }
}