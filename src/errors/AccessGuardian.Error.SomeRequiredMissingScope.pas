unit AccessGuardian.Error.SomeRequiredMissingScope;

interface

uses
  System.SysUtils;

type

  ESomeRequiredMissingScope = class(Exception)
  public
    constructor Create(const AScopes: string);
  end;

implementation

uses
  AccessGuardian.Resource.Strings;

{ EMissingRequiredScope }

constructor ESomeRequiredMissingScope.Create(const AScopes: string);
begin
  inherited Create(Format(SSomeRequiredMissingScope, [AScopes]));
end;

end.
