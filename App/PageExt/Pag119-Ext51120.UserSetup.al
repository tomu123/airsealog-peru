pageextension 51120 "PS User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            // control with underlying datasource
            field("View Schedule"; "View Schedule")
            {
                ApplicationArea = All;
            }
        }
    }
}