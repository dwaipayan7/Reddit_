
import 'package:fpdart/fpdart.dart';
import 'package:redit/core/provider/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid<T> = FutureEither<void>;