import 'package:dartz/dartz.dart';
import 'package:overdose/core/network/faileur.dart';
import 'package:overdose/core/network/requests.dart';

import '../../data/responses/login_response.dart';
import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<Either<Faileur, Login>> login(LoginRequest loginRequest);
  Future<Either<Faileur, Login>> signup(SignupRequest signupRequest);
  Future<Either<Faileur, Login>> check_email_phone(
      Check_email_phone_request checkRequest);
  Future<Either<Faileur, Login>> updateUser(
      UpdateUserRequest updateUserRequest);
  Future<Either<Faileur, String>> checkPhoneForgout(String phone);
  Future<Either<Faileur, String>> changePassword(
      ChangePasswordRequest changePasswordRequest);
}
