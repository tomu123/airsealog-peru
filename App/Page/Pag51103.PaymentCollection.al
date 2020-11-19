page 51103 "Payment Collection"
{
    ApplicationArea = All;
    Editable = true;
    PageType = List;
    AutoSplitKey = true;
    Caption = 'Cobros - Recaudación', Comment = 'ESM="Cobros - Recaudación"';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    SourceTable = "ST Control File";
    SourceTableView = WHERE("Entry Type" = FILTER("Recaudación"));
    RefreshOnActivate = true;
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(BankAccountNo; BankAccountNo)
                {
                    Caption = 'Cuenta recaudadora banco no.';
                    ApplicationArea = All;
                    Importance = Standard;
                    Visible = true;
                    TableRelation = "Bank Account" where("Process Bank" = filter(<> ''));
                    trigger OnValidate()
                    begin
                        GetBankProcessAndCurrencyCode(BankAccountNo);
                        TipoArchivo := TipoArchivo::" ";
                        TipoRegistro := '';
                        TRecordCode := '';
                    end;
                }
                field(TipoArchivo; TipoArchivo)
                {
                    Caption = 'Tipo de Archivo';
                    ApplicationArea = All;
                    Importance = Standard;
                    Visible = true;
                    Editable = EnabledList;
                    OptionCaption = ',Archivo de Reemplazo,Archivo de Actualización',
                                    Comment = '"ESM= ,Archivo de Reemplazo,Archivo de Actualización"';
                    trigger OnValidate()
                    var
                    begin
                        case TipoArchivo of
                            TipoArchivo::"Archivo de Actualización":
                                TFileCode := 'A';
                            TipoArchivo::"Archivo de Reemplazo":
                                TFileCode := 'R';
                        end;
                        TipoRegistro := '';
                        TRecordCode := '';
                    end;
                }
                field(TipoRegistro; TipoRegistro)
                {
                    Caption = 'Tipo Registro';
                    ApplicationArea = All;
                    Importance = Standard;
                    Visible = true;

                    trigger OnValidate()
                    var
                    begin
                        if EnabledList then
                            if TipoArchivo = TipoArchivo::" " then
                                Error('Seleccione primero, Tipo de Archivo para continuar.');
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        MasterData: Record "Master Data";
                    begin
                        if EnabledList then
                            if TipoArchivo = TipoArchivo::" " then
                                Error('Seleccione primero, Tipo de Archivo para continuar.');

                        TipoRegistro := MgmtCollection.MasterDataLookup(CollectionBank);
                        if TipoRegistro <> '' then
                            Text := TipoRegistro;

                        MasterData.SetRange("Type Table", CollectionBank);
                        MasterData.SetRange(Description, Text);
                        if MasterData.FindFirst() then
                            TRecordCode := MasterData.Code;

                        if CollectionBank = 'BCP' THEN begin
                            if TRecordCode = '0' then
                                TRecordCode := ' ';

                            if MgmtCollection.ValidateRecordType(TFileCode, TRecordCode) then begin
                                TipoRegistro := '';
                                TRecordCode := '';
                                Text := '';
                            end;
                        end;
                        exit(true)
                    end;
                }
                group(Filter)
                {
                    Caption = 'Filtros';

                    field(ApplyFilter; ApplyFilter)
                    {
                        Caption = 'Aplicar Filtros';
                        ApplicationArea = All;
                        Importance = Standard;
                        Visible = true;
                    }
                    field(DateFrom; DateFrom)
                    {
                        Caption = 'Desde';
                        ApplicationArea = All;
                        Importance = Standard;
                        Visible = true;
                        Editable = ApplyFilter;
                    }

                    field(DateTo; DateTo)
                    {
                        Caption = 'Hasta';
                        ApplicationArea = All;
                        Importance = Standard;
                        Visible = true;
                        Editable = ApplyFilter;
                    }
                    field(SerieDoc; SerieDoc)
                    {
                        Caption = 'Serie Doc.';
                        ApplicationArea = All;
                        Importance = Standard;
                        Visible = true;
                        Editable = ApplyFilter;
                    }
                }

            }
            repeater(GroupName)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
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
            action(GenerateFile)
            {
                ApplicationArea = All;
                Caption = 'Generar (txt)';
                Image = ExportFile;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    if BankAccountNo = '' then
                        Error('Seleccione Banco recaudo no. para continuar!');
                    if format(TipoArchivo) = '' then
                        Error('Seleccione Tipo archivo para continuar!');
                    if TRecordCode = '' then
                        Error('Seleccione Tipo registro para continuar!');

                    if ApplyFilter then begin
                        if (DateFrom = 0D) Or (DateTo = 0D) then
                            Error('Indique rango de fechas!');
                        if SerieDoc = '' then
                            Error('Indique serie documento!');
                    end;
                    MgmtCollection.FindFillCollection(CollectionBank,
                                                    BankAccountNo,
                                                    CurrencyCode,
                                                    TFileCode,
                                                    TRecordCode,
                                                    DateFrom,
                                                    DateTo,
                                                    SerieDoc);
                    CurrPage.Update();
                end;
            }
            action(MultiSelect)
            {
                ApplicationArea = All;
                Caption = 'Seleccón multiple';
                Image = ExportFile;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    pageCustLECollection: Page "CustLedgerEntry Collection";
                begin
                    if BankAccountNo = '' then
                        Error('Seleccione Banco recaudo no. para continuar');
                    if EnabledList then
                        if format(TipoArchivo) = '' then
                            Error('Seleccione Tipo archivo para continuar');
                    if TRecordCode = '' then
                        Error('Seleccione Tipo registro para continuar');

                    pageCustLECollection.SetEnabledList(EnabledList);
                    pageCustLECollection.SetColletionBank(CollectionBank, BankAccountNo, CurrencyCode, TFileCode, TRecordCode);
                    pageCustLECollection.RunModal();

                end;
            }
            action(DownloadFile)
            {
                ApplicationArea = All;
                Caption = 'Download File';
                Image = ExportFile;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.DownLoadFile(Rec);
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
                        Rec.Delete();
                end;
            }
        }
    }
    var
        BankAccountOption: Option " ",BCP,BBVA,SCOTIA,INTERBANK;
        CollectionBank: Text;
        BankAccountNo: Code[10];
        CurrencyCode: Code[10];
        TipoArchivo: option " ","Archivo de Reemplazo","Archivo de Actualización";
        TipoRegistro: Text;
        TRecordCode: Text;
        TFileCode: text;
        MgmtCollection: Codeunit "Mgmt Collection";
        RecCollectionPaymentBuffer: Record "Collection Payment Buffer" temporary;
        EnabledList: Boolean;
        DateFrom: Date;
        DateTo: Date;
        SerieDoc: text;
        ApplyFilter: Boolean;

    local procedure GetBankProcessAndCurrencyCode(pBankAccountNo: code[20])
    var
        BankAccount: Record "Bank Account";
    begin
        if BankAccount.get(pBankAccountNo) then begin
            CollectionBank := Format(BankAccount."Process Bank");
            case CollectionBank of
                'BBVA':
                    EnabledList := false;
                else
                    EnabledList := true;
            end;
            CurrencyCOde := BankAccount."Currency Code";
        end;
    end;
}