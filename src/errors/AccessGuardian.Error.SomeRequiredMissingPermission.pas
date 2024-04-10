unit AccessGuardian.Error.SomeRequiredMissingPermission;

interface

uses
  System.SysUtils;

type

  ESomeRequiredMissingPermission = class(Exception)
  public
    constructor Create;
  end;

implementation

uses
  AccessGuardian.Resource.Strings;

{ EMissingRequiredPermission }

constructor ESomeRequiredMissingPermission.Create;
begin
  inherited Create(SSomeRequiredMissingPermission);
end;

end.
