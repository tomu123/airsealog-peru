page 51005 "Detraction Services/Operation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 51004;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Type Servicies/Operation"; "Type Services/Operation")
                {
                    ApplicationArea = All;

                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                    //FieldPropertyName = FieldPropertyValue;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    //FieldPropertyName = FieldPropertyValue;
                }
                field("Detraction Percentage"; "Detraction Percentage")
                {
                    ApplicationArea = All;
                    //FieldPropertyName = FieldPropertyValue;
                }
                field("Detraction Amount"; "Detraction Amount")
                {
                    ApplicationArea = All;
                    //FieldPropertyName = FieldPropertyValue;
                }
            }
        }
    }
}