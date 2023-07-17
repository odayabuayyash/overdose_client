import 'package:dartz/dartz.dart';
import 'package:overdose/core/bases/base_response.dart';

class BannersResponse {
  String? images;
  BannersResponse(this.images);
  BannersResponse.fromJson(String json) {
    images = json;
  }
}

class CategoryResponse {
  String? images;
  String? title;
  int? id;
  CategoryResponse(this.images, this.title, this.id);
  CategoryResponse.fromJson(Map<String, dynamic> json) {
    images = json['image'] as String?;
    title = json['name'] as String?;
    id = json['id'] as int?;
  }
}

class ProdectResponse {
  String? name;
  String? description;
  String? image;
  int? price;
  String? type;
  int? id;
  String? category;
  int? discount;
  List<Variation>? options;

  ProdectResponse.fromJson(Map<String, dynamic> json) {
    print("start");
    print(json);
    name = json['name'] as String?;
    discount = json['discount'] as int?;
    description = json['description'] as String?;
    image = json['image'] as String?;
    price = json['price'] as int?;
    category = json["category_ids"][0]['id'] as String?;
    type = json['product_type'] as String?;
    id = json['id'] as int?;
    json['add_ons'] != null
        ? options = (json['add_ons'] as List)
            .map((e) => Variation(e['id'], e['name'], e['price']))
            .toList()
            .cast<Variation>()
        : null;
    print("finished");
  }
}

class HomeResponse extends BaseResponse {
  List<BannersResponse>? bannersResponse;
  List<ProdectResponse>? prodectResponse;
  List<CategoryResponse>? categoryResponse;
  HomeResponse.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    json['baners'] != null
        ? bannersResponse = (json['baners'])
            .map((e) => BannersResponse.fromJson(e.toString()))
            .cast<BannersResponse>()
            .toList()
        : null;
    json['products']['products'] != null
        ? {
            prodectResponse = (json['products']['products'])
                .map((e) => ProdectResponse.fromJson(e))
                .cast<ProdectResponse>()
                .toList()
          }
        : null;
    json['categories'] != null
        ? categoryResponse = (json['categories'])
            .map((e) => CategoryResponse.fromJson(e))
            .cast<CategoryResponse>()
            .toList()
        : null;
  }
}

class SearchResponse extends BaseResponse {
  List<ProdectResponse>? productResponse;
  SearchResponse.fromJson(Map<String, dynamic> json) {
    json['products'] != null
        ? productResponse = (json['products'])
            .map((e) => ProdectResponse.fromJson(e))
            .cast<ProdectResponse>()
            .toList()
        : null;
  }
}

class Variation {
  int id;
  String name;
  int price;
  Variation(this.id, this.name, this.price);
}

class OrderResponse extends BaseResponse {
  OrderResponse.fromJson(Map<String, dynamic> json) {
    message = json['status'];
  }
}

class UpdateProfileResponse extends BaseResponse {
  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['status'];
  }
}
