unit AccessGuardian.Contract.Validator.Permission;

interface

type

  IPermissionValidator<TSetOfEnum { :set of enum } > = interface
    ['{B7746B5B-B5CA-4C96-96B8-1B269A560C6A}']
    function HasAllPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum): Boolean; overload;
    function HasAnyPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum): Boolean; overload;
    procedure ValidateAllPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum);
    procedure ValidateAnyPermission(const ALeftPermission: TSetOfEnum; ARightPermission: TSetOfEnum);
  end;

implementation

end.
