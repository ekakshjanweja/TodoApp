import 'package:fpdart/fpdart.dart';
import 'package:todo/common/utils/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

typedef FutureVoid = FutureEither<void>;
