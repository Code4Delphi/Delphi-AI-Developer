{******************************************************************************}
{ Unit Note:                                                                   }
{    This file is partly derived from CnPack For Delphi/C++Builder             }
{                                                                              }
{ Original author:                                                             }
{                       CnPack For Delphi/C++Builder                           }
{                     中国人自己的开放源码第三方开发包                         }
{                   (C)Copyright 2001-2023 CnPack 开发组                       }
{                      网站地址：http://www.cnpack.org                          }
{                       电子邮件：master@cnpack.org                             }
{******************************************************************************}

unit DelphiAIDev.Utils.CnWizard;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Variants,
  Winapi.Windows,
  ToolsAPI;

function QuerySvcs(const Instance: IUnknown; const Intf: TGUID; out Inst): Boolean;
function CnOtaGetEditBuffer: IOTAEditBuffer;
function CnOtaGetTopMostEditView: IOTAEditView;
function CnOtaEditPosToLinePos(EditPos: TOTAEditPos; EditView: IOTAEditView = nil): Integer;
function OTAEditPos(Col: SmallInt; Line: Longint): TOTAEditPos;
function CnOtaGetCurrLineText(var Text: string; var LineNo: Integer; var CharIndex: Integer; View: IOTAEditView = nil): Boolean;
function GetCurrentLineOrBlock(const AEditView: IOTAEditView): string;

implementation

uses
  DelphiAiDev.Utils,
  DelphiAiDev.Utils.OTA;

function QuerySvcs(const Instance: IUnknown; const Intf: TGUID; out Inst): Boolean;
begin
  Result := (Instance <> nil) and Supports(Instance, Intf, Inst);
end;

function CnOtaGetEditBuffer: IOTAEditBuffer;
var
  iEditorServices: IOTAEditorServices;
begin
  QuerySvcs(BorlandIDEServices, IOTAEditorServices, iEditorServices);
  if iEditorServices <> nil then
  begin
    Result := iEditorServices.GetTopBuffer;
    Exit;
  end;
  Result := nil;
end;

function CnOtaGetTopMostEditView: IOTAEditView;
var
  iEditBuffer: IOTAEditBuffer;
begin
  iEditBuffer := CnOtaGetEditBuffer;
  if iEditBuffer <> nil then
  begin
    Result := iEditBuffer.GetTopView;
    Exit;
  end;
  Result := nil;
end;

function CnOtaEditPosToLinePos(EditPos: TOTAEditPos; EditView: IOTAEditView = nil): Integer;
var
  CharPos: TOTACharPos;
begin
  if EditView = nil then
    EditView := CnOtaGetTopMostEditView;
  if Assigned(EditView) then
  begin
    EditView.ConvertPos(True, EditPos, CharPos);
    Result := EditView.CharPosToPos(CharPos);
  end
  else
    Result := 0;
end;

function OTAEditPos(Col: SmallInt; Line: Longint): TOTAEditPos;
begin
  Result.Col := Col;
  Result.Line := Line;
end;

function ConvertEditorTextToTextW(const Text: AnsiString): string;
begin
  Result := UTF8ToUnicodeString(Text);
end;

function CnOtaGetCurrLineText(var Text: string; var LineNo: Integer; var CharIndex: Integer; View: IOTAEditView = nil): Boolean;
var
  L1, L2: Integer;
  Reader: IOTAEditReader;
  EditBuffer: IOTAEditBuffer;
  EditPos: TOTAEditPos;
  CharPos: TOTACharPos;
  OutStr: AnsiString;
begin
  Result := False;

  if not Assigned(View)then
    View := CnOtaGetTopMostEditView;
  if not Assigned(View) then
    Exit ;

  EditPos := View.CursorPos;
  View.ConvertPos(True, EditPos, CharPos);
  LineNo := CharPos.Line;
  CharIndex := CharPos.CharIndex;

  EditBuffer := View.Buffer;
  L1 := CnOtaEditPosToLinePos(OTAEditPos(1, LineNo), EditBuffer.TopView);
  if (LineNo >= View.Buffer.GetLinesInBuffer) then
    L2 := CnOtaEditPosToLinePos(OTAEditPos(High(SmallInt), LineNo + 1), EditBuffer.TopView)
  else
    L2 := CnOtaEditPosToLinePos(OTAEditPos(1, LineNo + 1), EditBuffer.TopView) - 2;
  SetLength(OutStr, L2 - L1);
  Reader := EditBuffer.CreateReader;
  try
    Reader.GetText(L1, PAnsiChar(OutStr), L2 - L1);
  finally
    Reader := nil;
  end;
  {$IFDEF UNICODE}
  Text := TrimRight(ConvertEditorTextToTextW(OutStr));
  {$ELSE}
  Text := TrimRight(string(ConvertEditorTextToText(OutStr)));
  {$ENDIF}
  Result := True;
end;

function GetCurrentLineOrBlock(const AEditView: IOTAEditView): string;
var
  LLineText: string;
  LLineNo: Integer;
  LCharIndex: Integer;
begin
  Result := '';
//  if IsEditControl(Screen.ActiveControl) and Assigned(AEditView) then
//    if not (IsEditControl(Screen.ActiveControl))then
//      Exit;

  if not(Assigned(AEditView)) then
    Exit;

  if AEditView.Block.IsValid then
    Result := TUtilsOTA.GetBlockTextSelect
  else
  begin
    CnOtaGetCurrLineText(LLineText, LLineNo, LCharIndex);
    Result := LLineText;
  end;
end;

end.
