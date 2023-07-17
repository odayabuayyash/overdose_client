import 'package:overdose/core/bases/base_response.dart';

class OrderFromApi {
  int? id;
  String? order_status;
  String? created_at;
  OrderFromApi(this.id, this.order_status, this.created_at);
  OrderFromApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order_status = json['order_status'];
    created_at = json['created_at'];
  }
}

class OrdersDataResponse extends BaseResponse {
  List<OrderFromApi>? orderResponse;
  OrdersDataResponse.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    json['data'] != null
        ? orderResponse = (json['data'] as List)
            .map((e) => OrderFromApi.fromJson(e))
            .cast<OrderFromApi>()
            .toList()
        : null;
  }
}
