import 'package:overdose/core/bases/base_response.dart';

class NotiResponse {
  int? id;
  String? title;
  String? description;
  String? created_at;
  NotiResponse(this.id, this.title, this.description, this.created_at);
  NotiResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    description = json['description'] as String?;
    created_at = json['created_at'] as String?;
  }
}

class NotificationsResponse extends BaseResponse {
  List<NotiResponse>? notificationsResponse;
  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    json['notification'] != null
        ? notificationsResponse = (json['notification'])
            .map((e) => NotiResponse.fromJson(e))
            .cast<NotiResponse>()
            .toList()
        : null;
  }
}
