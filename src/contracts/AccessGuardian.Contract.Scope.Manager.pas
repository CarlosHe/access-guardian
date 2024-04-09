unit AccessGuardian.Contract.Scope.Manager;

interface

type

  IScopeManager<TSetOfEnum { :set of enum } > = interface
    ['{B7746B5B-B5CA-4C96-96B8-1B269A560C6A}']
    function ScopeFromString(const AScopeString: string): TSetOfEnum;
    function ScopeFromStringCollection(const AScopeStringCollection: TArray<string>): TSetOfEnum;
    function ScopeToString(const AScope: TSetOfEnum): string;
    function ScopeToStringCollection(const AScope: TSetOfEnum): TArray<string>;
    function HasAllScope(const ALeftScope: TSetOfEnum; ARightScope: TSetOfEnum): Boolean; overload;
    function HasAnyScope(const ALeftScope: TSetOfEnum; ARightScope: TSetOfEnum): Boolean; overload;
    procedure ValidateAllScope(const ALeftScope: TSetOfEnum; ARightScope: TSetOfEnum);
    procedure ValidateAnyScope(const ALeftScope: TSetOfEnum; ARightScope: TSetOfEnum);
    function ScopeToOffset(const AScope: TSetOfEnum): UInt64;
    function OffsetToScope(const AOffset: UInt64): TSetOfEnum;
  end;

implementation

end.
