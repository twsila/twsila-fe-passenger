import 'package:dartz/dartz.dart';

import 'package:taxi_for_you/data/network/failure.dart';
import 'package:taxi_for_you/data/network/requests.dart';

import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class VerifyOtpUseCase
    implements BaseUseCase<VerifyOtpUseCaseInput, FirebaseCodeSent> {
  final Repository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, FirebaseCodeSent>> execute(VerifyOtpUseCaseInput input) {
    return _repository.verifyFirebaseOtp(VerifyFirebaseOTPRequest(input.verificationId, input.code));
  }

}

class VerifyOtpUseCaseInput {
  String verificationId;
  String code;

  VerifyOtpUseCaseInput(this.verificationId,this.code);
}
