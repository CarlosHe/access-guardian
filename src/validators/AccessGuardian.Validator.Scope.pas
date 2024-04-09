unit AccessGuardian.Validator.Scope;

interface

uses
  AccessGuardian.Contract.Validator.Scope,
  AccessGuardian.Enum.Scope.SetOf;

type

  TScopeValidator = class(TInterfacedObject, IScopeValidator<TScopes>)
  strict private
    { strict private declarations }
    constructor Create;
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function HasAllScope(const ALeftScope: TScopes; ARightScope: TScopes): Boolean; overload;
    function HasAnyScope(const ALeftScope: TScopes; ARightScope: TScopes): Boolean; overload;
    procedure ValidateAllScope(const ALeftScope: TScopes; ARightScope: TScopes);
    procedure ValidateAnyScope(const ALeftScope: TScopes; ARightScope: TScopes);
    class function New: IScopeValidator<TScopes>;
  end;

implementation

uses
  System.SysUtils,
  AccessGuardian.Helper.Enum.Scope,
  AccessGuardian.Helper.Enum.Scope.SetOf,
  AccessGuardian.Error.MissingRequiredScope,
  AccessGuardian.Error.SomeRequiredMissingScope,
  AccessGuardian.Enum.Scope;

{ TScopeValidator<T> }

constructor TScopeValidator.Create;
begin

end;

function TScopeValidator.HasAllScope(const ALeftScope: TScopes; ARightScope: TScopes): Boolean;
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

function TScopeValidator.HasAnyScope(const ALeftScope: TScopes; ARightScope: TScopes): Boolean;
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

class function TScopeValidator.New: IScopeValidator<TScopes>;
begin
  Result := Self.Create;
end;

procedure TScopeValidator.ValidateAllScope(const ALeftScope: TScopes; ARightScope: TScopes);
begin
  if not HasAllScope(ALeftScope, ARightScope) then
    raise EMissingRequiredScope.Create(TScopes(ALeftScope - ARightScope).ToString);
end;

procedure TScopeValidator.ValidateAnyScope(const ALeftScope: TScopes; ARightScope: TScopes);
begin
  if not HasAnyScope(ALeftScope, ARightScope) then
    raise ESomeRequiredMissingScope.Create(ALeftScope.ToString);
end;

end.
