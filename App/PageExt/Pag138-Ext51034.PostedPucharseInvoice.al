pageextension 51034 "Detrac Posted Pucharse Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipping and Payment")
        {
            group(Detractions)
            {
                Caption = 'Detractions';
                field("Purch. Detraction"; "Purch. Detraction")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group(TypeOfService)
                {
                    Caption = 'Type Of Service';
                    grid(Mygrid)
                    {
                        GridLayout = Columns;
                        field("Type of Service"; "Type of Service")
                        {
                            Editable = false;
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("Detrac. Service. Name"; CalcDetraction.GetTypeOfSO("Type of Service", false))
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                            //FieldPropertyName = FieldPropertyValue;
                        }
                    }
                }
                group(TypeOfOperation)
                {
                    Caption = 'Type Of Operation';
                    grid(Mygrid2)
                    {
                        GridLayout = Columns;
                        field("Type of Operation"; "Type of Operation")
                        {
                            Editable = false;
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("Detrac.Oper. Name"; CalcDetraction.GetTypeOfSO("Type of Operation", true))
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                            //FieldPropertyName = FieldPropertyValue;
                        }

                    }
                }
                field("Purch. % Detraction"; "Purch. % Detraction")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purch. Amount Detraction"; "Purch. Amount Detraction")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purch Amount Detraction LCY"; "Purch Amount Detraction LCY")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purch. Detraction Operation"; "Purch. Detraction Operation")
                {
                    ApplicationArea = All;
                    Editable = "Purch. Detraction";
                }
                field("Purch Date Detraction"; "Purch Date Detraction")
                {
                    ApplicationArea = All;
                    Editable = "Purch. Detraction";
                }
            }
        }
        addlast(General)
        {
            group("IncomeType")
            {
                Caption = 'Income Type', Comment = 'ESM="Tipo Renta"';
                grid(IncomeTypeGrid)
                {
                    GridLayout = Columns;
                    group("GridGroupND1")
                    {
                        //GridLayout = Rows;
                        ShowCaption = false;
                        field("Income Type"; "Income Type")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                    }
                    group("GridGroupND2")
                    {
                        ShowCaption = false;
                        field(gTextIncomeType; gTextIncomeType)
                        {
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }

            group("ServiceProvidedMode")
            {
                Caption = 'Service Provided Mode', Comment = 'ESM="Modalidad Servicio Prestado"';
                grid(ServiceProvidedModeGrid)
                {
                    GridLayout = Columns;
                    group("GridGroupND3")
                    {
                        ShowCaption = false;
                        field("Service Provided Mode"; "Service Provided Mode")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                    }
                    group("GridGroupND4")
                    {
                        ShowCaption = false;
                        field(gTextServiceProvidedMode; gTextServiceProvidedMode)
                        {
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }

            group("ExemptionsfromOperations")
            {
                Caption = 'Exemptions from Operations', Comment = 'ESM="Exoneraciones de Operaciones"';
                grid(ExemptionsfromOperationsGrid)
                {
                    GridLayout = Columns;
                    group("GridGroupND5")
                    {
                        ShowCaption = false;
                        field("Exemptions from Operations"; "Exemptions from Operations")
                        {
                            ApplicationArea = All;
                        }
                    }
                    group("GridGroupND6")
                    {
                        ShowCaption = false;
                        field(gTextExemptionsfromOperations; gTextExemptionsfromOperations)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
        addafter("Posting Date")
        {
            field("Accountant receipt date"; "Accountant receipt date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        CalcDetraction: Codeunit "DetrAction Calculation";
        gTextIncomeType: Text;
        gTextExemptionsfromOperations: Text;
        gTextServiceProvidedMode: Text;
}