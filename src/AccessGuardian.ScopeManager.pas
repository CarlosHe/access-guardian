unit AccessGuardian.ScopeManager;

interface

uses
  AccessGuardian.Contract.Scope.Manager,
  AccessGuardian.Enum.Scope,
  AccessGuardian.Enum.Scope.SetOf;

type

  TScopeManager = class(TInterfacedObject, IScopeManager<TScopes>)
  strict private
    { strict private declarations }
    constructor Create;
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function ScopeFromString(const AScopeString: string): TScopes;
    function ScopeFromStringCollection(const AScopeStringCollection: TArray<string>): TScopes;
    function ScopeToString(const AScope: TScopes): string;
    function ScopeToStringCollection(const AScope: TScopes): TArray<string>;
    function HasAllScope(const ALeftScope: TScopes; ARightScope: TScopes): Boolean; overload;
    function HasAnyScope(const ALeftScope: TScopes; ARightScope: TScopes): Boolean; overload;
    procedure ValidateAllScope(const ALeftScope: TScopes; ARightScope: TScopes);
    procedure ValidateAnyScope(const ALeftScope: TScopes; ARightScope: TScopes);
    function ScopeToOffset(const AScope: TScopes): UInt64;
    function OffsetToScope(const AOffset: UInt64): TScopes;
    class function New: IScopeManager<TScopes>;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo,
  AccessGuardian.Error.MissingRequiredScope,
  AccessGuardian.Error.SomeRequiredMissingScope;

{ TScopeManager<T> }

constructor TScopeManager.Create;
begin

end;

function TScopeManager.HasAllScope(const ALeftScope: TScopes; ARightScope: TScopes): Boolean;
var
  LScope: TScope;
begin
  Result := True;
  for LScope in ALeftScope do
  begin
    if not(LScope in ARightScope) then
      Exit(False);
  end;
end;

function TScopeManager.HasAnyScope(const ALeftScope: TScopes; ARightScope: TScopes): Boolean;
var
  LScope: TScope;
begin
  Result := False;
  for LScope in ALeftScope do
  begin
    if LScope in ARightScope then
      Exit(True);
  end;
end;

class function TScopeManager.New: IScopeManager<TScopes>;
begin
  Result := Self.Create;
end;

function TScopeManager.OffsetToScope(const AOffset: UInt64): TScopes;
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

function TScopeManager.ScopeFromString(const AScopeString: string): TScopes;
begin
  Result := TScopes(OffsetToScope(StringToSet(PTypeInfo(TypeInfo(TScopes)), AScopeString)));
end;

function TScopeManager.ScopeFromStringCollection(const AScopeStringCollection: TArray<string>): TScopes;
begin
  Result := ScopeFromString(string.Join(',', AScopeStringCollection));
end;

function TScopeManager.ScopeToOffset(const AScope: TScopes): UInt64;
var
  LScope: TScope;
begin
  Result := 0;
  for LScope := Low(TScope) to High(TScope) do
  begin
    if LScope in AScope then
      Result := Result or (UInt64(1) shl Ord(LScope));
  end;
end;

function TScopeManager.ScopeToString(const AScope: TScopes): string;
begin
  Result := SetToString(PTypeInfo(TypeInfo(TScopes)), @AScope, False);
end;

function TScopeManager.ScopeToStringCollection(const AScope: TScopes): TArray<string>;
begin
  Result := ScopeToString(AScope).Split([',']);
end;

procedure TScopeManager.ValidateAllScope(const ALeftScope: TScopes; ARightScope: TScopes);
begin
  if not HasAllScope(ALeftScope, ARightScope) then
    raise EMissingRequiredScope.Create(ScopeToString(ALeftScope - ARightScope));
end;

procedure TScopeManager.ValidateAnyScope(const ALeftScope: TScopes; ARightScope: TScopes);
begin
  if not HasAnyScope(ALeftScope, ARightScope) then
    raise ESomeRequiredMissingScope.Create(ScopeToString(ALeftScope));
end;

end.
