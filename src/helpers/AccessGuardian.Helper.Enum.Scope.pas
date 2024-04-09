unit AccessGuardian.Helper.Enum.Scope;

interface

uses
  AccessGuardian.Enum.Scope;

type

  TScopeEnumHelper = record helper for TScope
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function FromString(const AScope: string): TScope; static;
    function ToString: string;
  end;

implementation

uses
  System.TypInfo;

{ TScopeEnumHelper }

class function TScopeEnumHelper.FromString(const AScope: string): TScope;
begin
  Result := TScope(GetEnumValue(TypeInfo(TScope), AScope));
end;

function TScopeEnumHelper.ToString: string;
begin
  Result := GetEnumName(TypeInfo(TScope), Ord(Self));
end;

end.
