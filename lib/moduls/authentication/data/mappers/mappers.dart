import 'package:overdose/app/constants.dart';
import 'package:overdose/moduls/authentication/data/responses/login_response.dart';
import 'package:overdose/moduls/authentication/domain/models/models.dart';
import 'package:overdose/app/extentions.dart';

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
      this?.id.orZero() ?? 0,
      this?.firstName.orEmpty() ?? Constants.empty,
      this?.lastName.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.phone.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on SignupResponse? {
  Login toDomain() {
    return Login(this?.userResponse.toDomain());
  }
}
