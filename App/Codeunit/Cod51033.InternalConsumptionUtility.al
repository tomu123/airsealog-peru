codeunit 51033 "Internal Consumption Utility"
{

    procedure SetLastSerieNoUsedToBe(VAR SalesHeader: Record "Sales Header"): Code[20]
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        re: Record "Sales Header";
    begin
        //003
        IF SalesHeader."Posting No. Series" <> '' THEN
            EXIT(NoSeriesManagement.GetNextNo(SalesHeader."Posting No. Series", WORKDATE, FALSE))
        //003

    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterInsertEvent', '', false, false)]
    procedure OnAfterInsertEventPaymentTerms(var rec: Record "Sales Header"; RunTrigger: Boolean)

    var
        lcSetupLocalization: Record "Setup Localization";
    begin
        //ULN::RM.01  BEGIN
        lcSetupLocalization.GET;
        IF rec."Internal Consumption" THEN BEGIN
            lcSetupLocalization.TESTFIELD("Customer Int. Cons.");
            rec.VALIDATE("Sell-to Customer No.", lcSetupLocalization."Customer Int. Cons.");
            rec."Gen. Bus. Posting Group" := lcSetupLocalization."Gn. Bus. Pst. Group Int. Cons.";
            rec."Posting No. Series" := lcSetupLocalization."Serial No. Pstd. Int. Cons.";
        END;
        //ULN::RM.01  END
    end;
}