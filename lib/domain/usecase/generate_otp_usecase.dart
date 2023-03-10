import 'package:dartz/dartz.dart';

import 'package:taxi_for_you/data/network/failure.dart';
import 'package:taxi_for_you/data/network/requests.dart';

import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GenerateOtpUseCase
    implements BaseUseCase<GenerateOtpUseCaseInput, FirebaseCodeSent> {
  final Repository _repository;

  GenerateOtpUseCase(this._repository);

  @override
  Future<Either<Failure, FirebaseCodeSent>> execute(
      GenerateOtpUseCaseInput input) {
    return _repository
        .generateFirebaseOtp(GenerateFirebaseOTPRequest(input.phoneNumber));
  }
}

class GenerateOtpUseCaseInput {
  String phoneNumber;

  GenerateOtpUseCaseInput(this.phoneNumber);
}
