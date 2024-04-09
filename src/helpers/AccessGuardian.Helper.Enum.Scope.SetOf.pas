unit AccessGuardian.Helper.Enum.Scope.SetOf;

interface

uses
  AccessGuardian.Enum.Scope.SetOf;

type

  TScopesEnumHelper = record helper for TScopes
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function FromString(const AScopes: string): TScopes; static;
    class function FromArray(const AScopeCollection: TArray<string>): TScopes; static;
    class function FromOffset(const AOffset: UInt64): TScopes; static;
    function ToString: string;
    function ToArray: TArray<string>;
    function ToOffset: UInt64;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo,
  AccessGuardian.Enum.Scope;

{ TScopesEnumHelper }

class function TScopesEnumHelper.FromArray(const AScopeCollection: TArray<string>): TScopes;
begin
  Result := TScopes.FromString(string.Join(',', AScopeCollection));
end;

class function TScopesEnumHelper.FromOffset(const AOffset: UInt64): TScopes;
var
  LScope: TScope;
begin
  Result := [];
  for LScope := Low(TScope) to High(TScope) do
  begin
    if (AOffset and (UInt64(1) shl Ord(LScope))) <> 0 then
      Include(Result, LScope);
  end;
end;

class function TScopesEnumHelper.FromString(const AScopes: string): TScopes;
begin
  Result := TScopes.FromOffset(StringToSet(PTypeInfo(TypeInfo(TScopes)), AScopes));
end;

function TScopesEnumHelper.ToArray: TArray<string>;
begin
  Result := Self.ToString.Split([',']);
end;

function TScopesEnumHelper.ToOffset: UInt64;
var
  LScope: TScope;
begin
  Result := 0;
  for LScope := Low(TScope) to High(TScope) do
  begin
    if LScope in Self then
      Result := Result or (UInt64(1) shl Ord(LScope));
  end;
end;

function TScopesEnumHelper.ToString: string;
begin
  Result := SetToString(PTypeInfo(TypeInfo(TScopes)), @Self, False);
end;

end.
