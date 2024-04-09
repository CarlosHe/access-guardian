unit AccessGuardian.Error.MissingRequiredScope;

interface

uses
  System.SysUtils;

type

  EMissingRequiredScope = class(Exception)
  public
    constructor Create(const AScopes: string);
  end;

implementation

uses
  AccessGuardian.Resource.Strings;

{ EMissingRequiredScope }

constructor EMissingRequiredScope.Create(const AScopes: string);
begin
  inherited Create(Format(SMissingRequiredScope, [AScopes]));
end;

end.
