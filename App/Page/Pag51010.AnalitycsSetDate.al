page 51010 "Analitycs Set Date"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Set Date';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        StartDate := CalcDate('<-CM>', Today());
        EndDate := CalcDate('<CM>', Today());
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (StartDate = 0D) or (EndDate = 0D) then
            Error(ErrorEnterDate);
    end;

    procedure SetFilterDate(var pStartDate: Date; var pEndDate: Date)
    begin
        pStartDate := StartDate;
        pEndDate := EndDate;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        ErrorEnterDate: Label 'Enter start date and end date to continue.', Comment = 'ESM="Ingrese fecha de inicio y fecha fin para continuar."';
}