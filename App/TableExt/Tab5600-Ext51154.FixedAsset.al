tableextension 51154 "LD Fixed Asset" extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here 51005..51015
        field(51005; "LD Fixed Asset Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Fixed Asset Type', Comment = 'ESM="Tipo de AF SUNAT"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('18'));
            ValidateTableRelation = false;
        }
        field(51006; "LD Fixed Asset Status"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Fixes Asset Status', Comment = 'ESM="Estado SUNAT"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('19'));
            ValidateTableRelation = false;
        }
        field(51007; "LD Depreciation Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Depreciation Method', Comment = 'ESM="Médoto depreciación SUNAT"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('20'));
            ValidateTableRelation = false;
        }
        field(51008; "LD Brand"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Brand', Comment = 'ESM="Marca"';
            TableRelation = Manufacturer;
        }
        field(51009; "LD Model"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Model', Comment = 'Modelo';
        }
        field(51010; "LD Intangible Status"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Intangible Status', Comment = 'ESM="Estado Intangible"';
            trigger OnValidate()
            begin
                if not "LD Intangible Status" then
                    "LD Intagible Type" := '';
            end;
        }
        field(51011; "LD Intagible Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Intangible Type', Comment = 'ESM="Estado Intagible SUNAT"';
            TableRelation = "Legal Document"."Legal No." where("Option Type" = const("SUNAT Table"), "Type Code" = const('07'));
            ValidateTableRelation = false;
        }
        field(51012; "LD Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job No.', Comment = 'ESM="N° Proyecto"';
            TableRelation = Job;
        }
        field(51013; "LD Job Task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job Task No.', Comment = 'ESM="N° Tarea Proyecto"';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("LD Job No."));
        }
        modify("FA Class Code")
        {
            trigger OnAfterValidate()
            var
                FAClass: Record "FA Class";
            begin
                if "FA Class Code" = '' then
                    Validate("LD Intangible Status", false);
                FAClass.Get("FA Class Code");
                Validate("LD Intangible Status", FAClass."LD Intangible Status");
            end;
        }
        modify("FA Subclass Code")
        {
            trigger OnAfterValidate()
            var
                FASubClass: Record "FA Subclass";
                FADepreciationBook: Record "FA Depreciation Book";
            begin
                if "FA Subclass Code" = '' then
                    exit;
                FASubClass.Get("FA Subclass Code");
                FASubClass.TestField("Default FA Posting Group");
                FADepreciationBook.SetAutoCalcFields("Book Value");
                FADepreciationBook.SetRange("FA No.", "No.");
                FADepreciationBook.SetFilter("Book Value", '%1', 0);
                FADepreciationBook.ModifyAll("FA Posting Group", FASubClass."Default FA Posting Group");
            end;
        }
    }

}