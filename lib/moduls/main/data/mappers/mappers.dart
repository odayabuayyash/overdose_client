import 'package:overdose/app/constants.dart';
import 'package:overdose/moduls/main/data/responses/home_responses.dart';
import 'package:overdose/moduls/main/data/responses/notification_response.dart';
import 'package:overdose/moduls/main/domain/models/home_models.dart';
import 'package:overdose/app/extentions.dart';
import 'package:overdose/moduls/main/domain/models/notification_model.dart';
import 'package:overdose/moduls/main/domain/models/order_model.dart';

import '../responses/order_response.dart';

extension BannersResponseMapper on BannersResponse? {
  Baner toDomain() {
    return Baner(this?.images.orEmpty() ?? Constants.empty);
  }
}

extension CategoryResponseMapper on CategoryResponse? {
  Caty toDomain() {
    return Caty(this?.images.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty, this?.id.orZero() ?? 0);
  }
}

extension ProdectResponseMapper on ProdectResponse? {
  Product toDomain() {
    return Product(
        name: this?.name.orEmpty() ?? Constants.empty,
        description: this?.description.orEmpty() ?? Constants.empty,
        image: this?.image.orEmpty() ?? Constants.empty,
        price: this?.price.orZero() ?? 0,
        type: this?.type.orEmpty() ?? Constants.empty,
        id: this?.id.orZero() ?? 0,
        discount: this?.discount.orZero() ?? 0,
        options: this?.options ?? [],
        category: this?.category.orEmpty() ?? Constants.empty);
  }
}

extension HomeDataResponse on HomeResponse? {
  HomeData toDomain() {
    List<Baner>? banners = this
        ?.bannersResponse
        ?.map((banner) => banner.toDomain())
        .cast<Baner>()
        .toList();

    List<Product>? prudects = this
        ?.prodectResponse
        ?.map((product) => product.toDomain())
        .cast<Product>()
        .toList();
    List<Caty>? categorys = this
        ?.categoryResponse
        ?.map((category) => category.toDomain())
        .cast<Caty>()
        .toList();
    return HomeData(banners, prudects, categorys);
  }
}

extension SearchRespose on SearchResponse? {
  SearchData toDomain() {
    List<Product>? prudects = this
        ?.productResponse
        ?.map((product) => product.toDomain())
        .cast<Product>()
        .toList();
    return SearchData(prudects);
  }
}

extension NotifiResponse on NotiResponse? {
  Notifi toDomain() {
    return Notifi(
        this?.id.orZero() ?? 0,
        this?.title.orEmpty() ?? Constants.empty,
        this?.description.orEmpty() ?? Constants.empty,
        this?.created_at.orEmpty() ?? Constants.empty);
  }
}

extension NotificationsResponseExtension on NotificationsResponse? {
  Notifications toDomain() {
    List<Notifi>? notification = this
        ?.notificationsResponse
        ?.map((product) => product.toDomain())
        .cast<Notifi>()
        .toList();

    return Notifications(notification);
  }
}

extension OrdersExtension on OrderFromApi? {
  Order toDomain() {
    return Order(
        id: this?.id.orZero() ?? 0,
        statusOrder: this?.order_status.orEmpty() ?? Constants.empty,
        dateTime: this?.created_at ?? Constants.empty);
  }
}

extension OrdersDataExtension on OrdersDataResponse? {
  OrdersData toDomain() {
    List<Order>? orders = this
        ?.orderResponse
        ?.map((order) => order.toDomain())
        .cast<Order>()
        .toList();
    return OrdersData(orders);
  }
}
