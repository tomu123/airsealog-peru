codeunit 51100 "Analitycs & Aut Calculation"
{
    trigger OnRun()
    begin

    end;

    procedure UpdateDimensionsbyaCode(VAR pGenJnlLine: Record "Gen. Journal Line"; pNumDim: Integer)
    var
        lclTempDimensionSetEntry: Record "Dimension Set Entry";
        lclDimensionSetEntry: Record "Dimension Set Entry";
        lclDimensionMng: Codeunit "DimensionManagement";
        lclGLSetup: Record "General Ledger Setup";
        lclGlobalDim: array[8] of Code[20];
        lclInt: Integer;
        lclGlobalDimCode: array[8] of Code[20];
        lclLastGLEntry: Record "G/L Entry";
    begin
        //BEGIN ULN::CCL 005 ++
        lclGLSetup.GET;
        lclGLSetup.TESTFIELD("Income G/L Account");
        lclGLSetup.TESTFIELD("Expenses G/L Account");
        lclGlobalDim[1] := lclGLSetup."Dflt.Shortcut Dimension 1 Code";
        lclGlobalDim[2] := lclGLSetup."Dflt.Shortcut Dimension 2 Code";
        lclGlobalDim[3] := lclGLSetup."Dflt.Shortcut Dimension 3 Code";
        lclGlobalDim[4] := lclGLSetup."Dflt.Shortcut Dimension 4 Code";
        lclGlobalDim[5] := lclGLSetup."Dflt.Shortcut Dimension 5 Code";
        lclGlobalDim[6] := lclGLSetup."Dflt.Shortcut Dimension 6 Code";
        lclGlobalDim[7] := lclGLSetup."Dflt.Shortcut Dimension 7 Code";
        lclGlobalDim[8] := lclGLSetup."Dflt.Shortcut Dimension 8 Code";
        lclGlobalDimCode[1] := lclGLSetup."Shortcut Dimension 1 Code";
        lclGlobalDimCode[2] := lclGLSetup."Shortcut Dimension 2 Code";
        lclGlobalDimCode[3] := lclGLSetup."Shortcut Dimension 3 Code";
        lclGlobalDimCode[4] := lclGLSetup."Shortcut Dimension 4 Code";
        lclGlobalDimCode[5] := lclGLSetup."Shortcut Dimension 5 Code";
        lclGlobalDimCode[6] := lclGLSetup."Shortcut Dimension 6 Code";
        lclGlobalDimCode[7] := lclGLSetup."Shortcut Dimension 7 Code";
        lclGlobalDimCode[8] := lclGLSetup."Shortcut Dimension 8 Code";
        lclTempDimensionSetEntry.DELETEALL;
        CLEAR(lclTempDimensionSetEntry);
        lclDimensionSetEntry.RESET;
        lclDimensionSetEntry.SETRANGE("Dimension Set ID", pGenJnlLine."Dimension Set ID");
        lclDimensionSetEntry.SETRANGE("Dimension Code", lclGlobalDimCode[pNumDim]);
        IF lclDimensionSetEntry.FINDSET THEN lclDimensionSetEntry.DELETE;
        lclDimensionSetEntry.RESET;
        lclDimensionSetEntry.SETRANGE("Dimension Set ID", pGenJnlLine."Dimension Set ID");
        IF lclDimensionSetEntry.FINDSET THEN
            REPEAT
                lclTempDimensionSetEntry.INIT;
                lclTempDimensionSetEntry.TRANSFERFIELDS(lclDimensionSetEntry);
                lclTempDimensionSetEntry."Dimension Set ID" := 0;
                lclTempDimensionSetEntry.INSERT;
            UNTIL lclDimensionSetEntry.NEXT = 0;
        IF (lclGlobalDimCode[pNumDim] <> '') AND (lclGlobalDim[pNumDim] <> '') THEN BEGIN
            lclTempDimensionSetEntry.INIT;
            lclTempDimensionSetEntry.VALIDATE("Dimension Code", lclGlobalDimCode[pNumDim]);
            lclTempDimensionSetEntry.VALIDATE("Dimension Value Code", lclGlobalDim[pNumDim]);
            lclTempDimensionSetEntry."Dimension Set ID" := 0;
            lclTempDimensionSetEntry.INSERT;
        END;
        pGenJnlLine."Dimension Set ID" := lclDimensionMng.GetDimensionSetID(lclTempDimensionSetEntry);
        IF pNumDim = 1 THEN
            pGenJnlLine.VALIDATE("Shortcut Dimension 1 Code", lclGlobalDim[pNumDim])
        ELSE
            pGenJnlLine.ValidateShortcutDimCode(pNumDim, lclGlobalDim[pNumDim]);
        //END ULN::CCL 005 ++
    end;

    var
        myInt: Integer;
}