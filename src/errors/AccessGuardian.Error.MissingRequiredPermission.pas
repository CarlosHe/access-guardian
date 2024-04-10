unit AccessGuardian.Error.MissingRequiredPermission;

interface

uses
  System.SysUtils;

type

  EMissingRequiredPermission = class(Exception)
  public
    constructor Create;
  end;

implementation

uses
  AccessGuardian.Resource.Strings;

{ EMissingRequiredPermission }

constructor EMissingRequiredPermission.Create;
begin
  inherited Create(SMissingRequiredPermission);
end;

end.
