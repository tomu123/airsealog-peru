enum 51001 "ST Source Code Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Payment Schedule")
    {
        Caption = 'Payment Schedule', Comment = 'ESM="Cronograma pagos"';
    }
    value(2; "PrePayment Control")
    {
        Caption = 'PrePayment Control', Comment = 'ESM="Control anticipo"';
    }
    value(3; "Payment EAP")
    {
        Caption = 'Payment EAP', Comment = 'ESM="Pago AGR"';
    }
    value(4; "Applied-to EAP")
    {
        Caption = 'Applied-to EAP', Comment = 'ESM="Applicación AGR"';
    }
    value(5; "Bounce EAP")
    {
        Caption = 'Bounce EAP', Comment = 'ESM="Rebote AGR"';
    }
}