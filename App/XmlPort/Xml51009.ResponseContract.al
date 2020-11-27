xmlport 51009 MyXmlport
{
    DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/x51009';
    Direction = Both;
    Encoding = UTF8;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(ResponseContract)
        {
            /*textelement(ICRMB_Response; "Integration CRM Buffer 1")
            {
                MinOccurs = Zero;
                XmlName = 'Response';
                UseTemporary = true;
                fieldattribute(ICRMB_Response; ICRMB_Response."Responsable Propietario")
                {

                }

                trigger OnPreXmlItem()
                begin

                end;
            }*/
        }
    }

    var
        ValorOK: Text[10];
}