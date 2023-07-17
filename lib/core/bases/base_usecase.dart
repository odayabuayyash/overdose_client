import 'package:dartz/dartz.dart';
import 'package:overdose/core/network/faileur.dart';

abstract class BaseUseCase<Inputs, Outputs> {
  Future<Either<Faileur, Outputs>> excute(Inputs inputs);
}
