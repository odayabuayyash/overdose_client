import '../../../../core/bases/base_response.dart';

class UserResponse {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  UserResponse(this.id, this.firstName, this.lastName, this.email, this.phone);
  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    firstName = json['f_name'] as String?;
    lastName = json['l_name'] as String?;
    email = json['phone'] as String?;
    phone = json['email'] as String?;
  }
}

class SignupResponse extends BaseResponse {
  UserResponse? userResponse;
  SignupResponse(this.userResponse);
  SignupResponse.fromJson(Map<String, dynamic> json) {
    print("start response");
    json['data'] == null
        ? null
        : userResponse = UserResponse.fromJson(json['data']);
    message = json["status"] as String?;
    print("finish response");
  }
}

class ForgotPasswordResponse extends BaseResponse {
  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    message = json['status'];
  }
}
