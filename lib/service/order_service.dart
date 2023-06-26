import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:order_app/model/menus.dart';
import 'package:order_app/model/order.dart';
import 'package:order_app/model/vouchers.dart';

class OrderApi{
  Future<List<Data>> getMenu() async{
    var uri = Uri.https('tes-mobile.landa.id', '/api/menus');
    final response = await http.get(uri);

    try{
      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        final orderResponse = Menus.fromJson(json);
        print("data ${orderResponse.datas}");
        return orderResponse.datas;

      }

    }catch(e){
      print(e);
    }
    return [];
  }

  Future<List<DataVoucher>> getVoucher(String type) async{
    var uri = Uri.https('tes-mobile.landa.id', '/api/vouchers',{
      "kode" : type
    });

    final response = await http.get(uri);

    try{
      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        final voucherResponse = Voucher.fromJson(json);
        return voucherResponse.datas;
      }
    }catch(e){
      print(e);
    }
    return [];
  }

  void doOrder(int? voucher_id, int nominal_diskon, int nominal_pesanan,  List<Map<String, dynamic>> items) async{
    var uri = Uri.https('tes-mobile.landa.id', '/api/order',{
      "voucher_id" : voucher_id,
      "nominal_diskon" : nominal_diskon,
      "nominal_pesanan" : nominal_pesanan,
      "items": items,
    });

    final response = await http.post(uri);

    try{
      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        final orderResponse = Order.fromJson(json);
        print("req success");
        print("response body: $orderResponse");
      }
    }catch(e){
      print("req failed with status: ${response.statusCode}");
    }
  }

  void cancelOrder(String id) async{
    var uri = Uri.https('tes-mobile.landa.id', '/api/order/cancel/$id');

    final response = await http.post(uri);

    try{
      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        final orderResponse = Order.fromJson(json);
        print("req success");
        print("response body: $orderResponse");
      }
    }catch(e){
      print("req failed with status: ${response.statusCode}");
    }
  }


}