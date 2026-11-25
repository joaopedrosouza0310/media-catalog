enum FailureKind { network, conflict, validation, notFound, unexpected }

final class AppFailure {
  const AppFailure(this.kind, {this.code});

  final FailureKind kind;
  final String? code;
}
