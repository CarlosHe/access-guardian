unit AccessGuardian.ScopeValidator;

interface

uses
  AccessGuardian.Enum.Scope,
  AccessGuardian.Enum.Scope.SetOf,
  AccessGuardian.Error.MissingRequiredScope,
  AccessGuardian.Error.SomeRequiredMissingScope,
  AccessGuardian.Validator.Scope;

type

  TScope = AccessGuardian.Enum.Scope.TScope;
  TScopes = AccessGuardian.Enum.Scope.SetOf.TScopes;
  EMissingRequiredScope = AccessGuardian.Error.MissingRequiredScope.EMissingRequiredScope;
  ESomeRequiredMissingScope = AccessGuardian.Error.SomeRequiredMissingScope.ESomeRequiredMissingScope;
  TScopeValidator = AccessGuardian.Validator.Scope.TScopeValidator;

implementation


end.
