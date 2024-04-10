unit AccessGuardian.Validator.Permission;

interface

uses
  System.Rtti,
  AccessGuardian.Contract.Validator.Permission;

type

  TPermissionValidator<TSetOfEnum { :set of enum } > = class(TInterfacedObject, IPermissionValidator<TSetOfEnum>)
  strict private
    { strict private declarations }
    constructor Create;
  type
    TSetOfByte = set of Byte;
  private
    { private declarations }
  protected
    { protected declarations }
    function NormalizeSetString(const AString: string): string;
    function SetOfEnumToStringArray(const ASetOfEnum: TSetOfEnum): TArray<string>;
    function GetSetOfByteFromSetOf(const ASetOfEnum: TSetOfEnum): TSetOfByte;
    function GetBufferFromSetOf(const ASetOfEnum: TSetOfEnum): TSetOfByte;
  public
    { public declarations }
    function HasAllPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum): Boolean; overload;
    function HasAnyPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum): Boolean; overload;
    procedure ValidateAllPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum);
    procedure ValidateAnyPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum);
    class function New: IPermissionValidator<TSetOfEnum>;
  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  System.TypInfo,
  AccessGuardian.Error.MissingRequiredPermission,
  AccessGuardian.Error.SomeRequiredMissingPermission;

{ TPermissionValidator<T> }

constructor TPermissionValidator<TSetOfEnum>.Create;
begin

end;

function TPermissionValidator<TSetOfEnum>.GetBufferFromSetOf(const ASetOfEnum: TSetOfEnum): TSetOfByte;
begin
  TValue.From<TSetOfEnum>(ASetOfEnum).ExtractRawData(@Result);
end;

function TPermissionValidator<TSetOfEnum>.GetSetOfByteFromSetOf(const ASetOfEnum: TSetOfEnum): TSetOfByte;
var
  LBuffer: TSetOfByte;
  LEnumType: PTypeInfo;
  LEnumData: PTypeData;
  I: Integer;
begin
  Result := [];
  LBuffer := GetBufferFromSetOf(ASetOfEnum);
  LEnumType := TTypeInfo(TypeInfo(TSetOfEnum)^).TypeData.CompType^;
  LEnumData := LEnumType.TypeData;
  for I := LEnumData.MinValue to LEnumData.MaxValue do
    if (I in LBuffer) then
      Include(Result, I);
end;

function TPermissionValidator<TSetOfEnum>.HasAllPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum): Boolean;
var
  LLeftPermissionStringArray: TArray<string>;
  LRightPermissionStringArray: TArray<string>;
  I: Integer;
begin
  Result := True;
  LLeftPermissionStringArray := SetOfEnumToStringArray(ALeftPermission);
  LRightPermissionStringArray := SetOfEnumToStringArray(ARightPermission);
  for I := Low(LLeftPermissionStringArray) to High(LLeftPermissionStringArray) do
  begin
    if IndexStr(LLeftPermissionStringArray[I], LRightPermissionStringArray) > -1 then
      Exit(False);
  end;
end;

function TPermissionValidator<TSetOfEnum>.HasAnyPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum): Boolean;
var
  LLeftPermissionStringArray: TArray<string>;
  LRightPermissionStringArray: TArray<string>;
  I: Integer;
begin
  Result := False;
  LLeftPermissionStringArray := SetOfEnumToStringArray(ALeftPermission);
  LRightPermissionStringArray := SetOfEnumToStringArray(ARightPermission);
  for I := Low(LLeftPermissionStringArray) to High(LLeftPermissionStringArray) do
  begin
    if IndexStr(LLeftPermissionStringArray[I], LRightPermissionStringArray) > -1 then
      Exit(True);
  end;
end;

class function TPermissionValidator<TSetOfEnum>.New: IPermissionValidator<TSetOfEnum>;
begin
  Result := Self.Create;
end;

function TPermissionValidator<TSetOfEnum>.NormalizeSetString(const AString: string): string;
begin
  Result := AString;
  if Result.StartsWith('[') then
    Result := Result.Remove(0, 1);
  if Result.EndsWith(']') then
    Result := Result.Remove(Pred(Length(Result)), 1);
end;

procedure TPermissionValidator<TSetOfEnum>.ValidateAllPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum);
begin
  if not HasAllPermission(ALeftPermission, ARightPermission) then
    raise EMissingRequiredPermission.Create;
end;

procedure TPermissionValidator<TSetOfEnum>.ValidateAnyPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum);
var
  LEnumString: string;
begin
  if not HasAnyPermission(ALeftPermission, ARightPermission) then
    raise ESomeRequiredMissingPermission.Create;
end;

function TPermissionValidator<TSetOfEnum>.SetOfEnumToStringArray(const ASetOfEnum: TSetOfEnum): TArray<string>;
begin
  Result := NormalizeSetString(TValue.From<TSetOfEnum>(ASetOfEnum).ToString).Split([',']);
end;

end.
