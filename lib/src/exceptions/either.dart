class Either<L, R> {
  final L? left;
  final R? right;

  Either._({this.left, this.right});

  factory Either.left(L left) => Either._(left: left);

  factory Either.right(R right) => Either._(right: right);

  bool get isLeft => left != null;
  bool get isRight => right != null;

  void fold(void Function(L l) onLeft, void Function(R r) onRight) {
    if (isLeft) {
      onLeft(left as L);
    } else {
      onRight(right as R);
    }
  }

// For Change Data Type (e.g: int,double to String)

  Either<L, U> map<U>(U Function(R r) tranform) {
    if (isRight) {
      return Either.right(tranform(right as R));
    } else {
      return Either.left(left as L);
    }
  }
}
