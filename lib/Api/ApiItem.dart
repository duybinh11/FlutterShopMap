import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/Model/CartModel.dart';
import 'package:login/Model/Item.dart';
import 'package:login/Model/Order.dart';
import 'package:login/Model/ShopModel.dart';
import 'package:login/Model/VnpayModel.dart';

class ApiItem {
  Future<List<Item>> getAllItem(int currentPage) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/home?page=$currentPage');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      List<dynamic> listMap = map['data'];
      int totalPage = map['last_page'] as int;
      if (totalPage < currentPage) {
        return [];
      }
      List<Item> lists = listMap.map((e) => Item.fromMap(e)).toList();
      return lists;
    }
    return [];
  }

  Future<dynamic> getItem(int id) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/itemdetail/id_item/$id');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      Item item = Item.fromMap(map['data']);
      return item;
    }

    return false;
  }

  Future<bool> addCart(int idUser, int idItem, int count) async {
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/itemdetail/id_user/$idUser/id_item/$idItem/count/$count');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return false;
  }

  Future<int> getCountCart(int id) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/home/id_user/$id');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return 0;
  }

  Future<List<CartModel>> getCartAll(int id) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/cart/getAllCart/id_user/$id');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      List<dynamic> listMap = map['data'];
      List<CartModel> lists = listMap.map((e) => CartModel.fromMap(e)).toList();
      return lists;
    }
    return [];
  }

  Future<bool> deleteCart(int id) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/cart/delete/id_cart/$id');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return false;
  }

  Future<dynamic> buyItem(
      int idUser, int idItem, int count, String? pay) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/order/buyItem');
    http.Response response = await http.post(uri, body: {
      'idUser': idUser.toString(),
      'idItem': idItem.toString(),
      'count': count.toString(),
      'pay': pay
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      bool status = map['status'] as bool;
      if (status) {
        return map['id_bill'];
      }
    }
    return false;
  }

  Future<int> getCountOrder(int id) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/home/getCountOder/id/$id');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as int;
    }
    return 0;
  }

  Future<List<OrderModel>> getAllOrder(int id) async {
    Uri uri =
        Uri.parse('http://10.0.2.2:8000/api/order/getAllOrder/id_user/$id');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      List<dynamic> listData = map['data'];
      List<OrderModel> listOrder =
          listData.map((e) => OrderModel.fromMap(e)).toList();
      return listOrder;
    }
    return [];
  }

  Future<String> geturl(int cost) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/vnpay');
    http.Response response =
        await http.post(uri, body: {'cost': cost.toString()});

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map['data'];
    }
    return 'dd';
  }

  Future<int> createOrderGetId(int idUser, int idItem, int sl) async {
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/vnpay/buyItem/idUser/$idUser/idItem/$idItem/sl/$sl');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      int idOrder = jsonDecode(response.body);
      return idOrder;
    }
    return 0;
  }

  Future<void> createVnpay(
      int idBill, int? cost, String? bankCode, bool status) async {
    String url =
        'http://10.0.2.2:8000/api/vnpay/createBillAndUpdateBill/id_bill/$idBill/cost/$cost/bank_code/$bankCode/status/$status';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    print(response.statusCode);
  }

  Future<dynamic> getVnpay(int idBill) async {
    Uri uri =
        Uri.parse('http://10.0.2.2:8000/api/vnpay/getvnpay/id_bill/$idBill');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> map = jsonDecode(response.body);
      bool b = map['status'] as bool;
      if (b) {
        return VnpayModel.fromMap(map['data']);
      } else {}
    }
    return false;
  }

  Future<dynamic> getShop(int idItem) async {
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/itemdetail/get_shop/id_item/$idItem');

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map['data']);
      return Shop.fromMap(map['data']);
    }
    return false;
  }
}
