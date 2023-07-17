import 'package:flutter/foundation.dart';

import '../../data/responses/home_responses.dart';

class Baner {
  String image;
  Baner(this.image);
}

class Caty {
  String images;
  String title;
  int id;
  Caty(this.images, this.title, this.id);
}

class Product {
  String name;
  String description;
  String image;
  int price;
  String type;
  int id;
  int discount;
  String category;
  List<Variation> options;
  Product(
      {required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.type,
      required this.options,
      required this.id,
      required this.discount,
      required this.category});
}

class HomeData {
  List<Baner>? baners;
  List<Product>? products;
  List<Caty>? category;
  HomeData(this.baners, this.products, this.category);
}

class SearchData {
  List<Product>? products;
  SearchData(this.products);
}
