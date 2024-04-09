unit AccessGuardian.Contract.Validator.Scope;

interface

type

  IScopeValidator<TSetOfEnum { :set of enum } > = interface
    ['{B7746B5B-B5CA-4C96-96B8-1B269A560C6A}']
    function HasAllScope(const ALeftScope: TSetOfEnum; ARightScope: TSetOfEnum): Boolean; overload;
    function HasAnyScope(const ALeftScope: TSetOfEnum; ARightScope: TSetOfEnum): Boolean; overload;
    procedure ValidateAllScope(const ALeftScope: TSetOfEnum; ARightScope: TSetOfEnum);
    procedure ValidateAnyScope(const ALeftScope: TSetOfEnum; ARightScope: TSetOfEnum);
  end;

implementation

end.
