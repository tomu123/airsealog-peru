page 51002 "ST Control File List"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "ST Control File";
    //SourceTableView = WHERE("Document Type" = FILTER(Invoice));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                ShowCaption = false;
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }

                field("File Name"; "File Name")
                {
                    ApplicationArea = All;
                }

                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }

                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }

                field("Exists File"; "File Blob".HasValue())
                {
                    ApplicationArea = All;
                }

                field("Create User ID"; "Create User ID")
                {
                    ApplicationArea = All;
                }

                field("Create DateTime File"; "Create DateTime File")
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
                Caption = 'Download File';
                Image = ExportFile;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    DownLoadFile(Rec);
                end;
            }
            action(DeleteFile)
            {
                ApplicationArea = All;
                Caption = 'Delete File';
                Image = DeleteRow;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    if not Rec.IsEmpty then
                        Delete();
                end;
            }
        }
    }
}