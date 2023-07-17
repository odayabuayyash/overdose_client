import 'package:dartz/dartz.dart';
import 'package:overdose/core/local_data/my_sqflite.dart';
import 'package:sqflite/sqflite.dart';

abstract class RemoteLocalDataSource {
  @override
  Future<Database?> getMydb();
  Future<int> onInsertUser(
      {required int id,
      required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String token});
  Future<List<Map>?> onReedDbUser();
  Future<int> onUpdateUser(
      {required int id,
      required String firstName,
      required String lastName,
      required String email,
      required String phone});
  Future<int> onDeleteDbUser({required int id});
  Future<int> onInsertCards(
      {required String title,
      required double subPrice,
      required double totalPrice,
      required int count,
      required String varies,
      required int item_id,
      required int discount});
  Future<List<Map>?> onReedDbCards();
  Future<int> onUpdateCards(
      {required double totalPrice, required String varies, required int id});
  Future<int> onDeleteDbCards({required int id});
  Future<int> onDeleteDbAllCards();
}

class RemoteLocalDataSourceImpl implements RemoteLocalDataSource {
  final MySqlite _mySqlite = MySqliteImpl();
  @override
  Future<Database?> getMydb() async {
    return await _mySqlite.db;
  }

  @override
  Future<int> onDeleteDbCards({required int id}) async {
    int response = await _mySqlite.onDeleteDbCards(id);
    return response;
  }

  @override
  Future<int> onDeleteDbUser({required int id}) async {
    int response = await _mySqlite.onDeleteDbUser(id);
    return response;
  }

  @override
  Future<int> onInsertCards(
      {required String title,
      required double subPrice,
      required double totalPrice,
      required int count,
      required String varies,
      required int item_id,
      required int discount}) async {
    int response = await _mySqlite.onInsertCards(
        title, subPrice, totalPrice, count, varies, item_id, discount);
    return response;
  }

  @override
  Future<int> onInsertUser(
      {required int id,
      required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String token}) async {
    int response = await _mySqlite.onInsertUser(
        id, firstName, lastName, email, phone, token);
    return response;
  }

  @override
  Future<List<Map>?> onReedDbCards() async {
    List<Map>? response = await _mySqlite.onReedDbCards();
    return response;
  }

  @override
  Future<List<Map>?> onReedDbUser() async {
    List<Map>? response = await _mySqlite.onReedDbUser();
    return response;
  }

  @override
  Future<int> onUpdateCards(
      {required double totalPrice,
      required String varies,
      required int id}) async {
    int response = await _mySqlite.onUpdateCards(totalPrice, varies, id);
    return response;
  }

  @override
  Future<int> onUpdateUser(
      {required int id,
      required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    int response =
        await _mySqlite.onUpdateUser(id, firstName, lastName, email, phone);
    return response;
  }

  @override
  Future<int> onDeleteDbAllCards() async {
    int response = await _mySqlite.onDeleteDbAllCards();
    return response;
  }
}
