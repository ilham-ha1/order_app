import 'package:flutter/cupertino.dart';
import 'package:order_app/model/menus.dart';
import 'package:order_app/model/vouchers.dart';
import 'package:order_app/service/order_service.dart';

class OrderItem {
  final Data item;
  int count = 0;
  String note = 'Catatan';

  OrderItem(this.item);
}

class OrderProvider extends ChangeNotifier{
  List<OrderItem> orderItems = [];

  int get totalItems {
    int total = 0;
    for (var item in orderItems) {
      total += item.count;
    }
    return total;
  }

  void increaseCount(Data item) {
    final orderItem = orderItems.firstWhere(
          (element) => element.item == item,
      orElse: () {
        final newItem = OrderItem(item);
        orderItems.add(newItem);
        return newItem;
      },
    );
    orderItem.count++;
    notifyListeners();
  }

  void decreaseCount(Data item) {
    final orderItemIndex = orderItems.indexWhere((element) => element.item == item);
    if (orderItemIndex != -1) {
      final orderItem = orderItems[orderItemIndex];
      if (orderItem.count > 0) {
        orderItem.count--;
        notifyListeners();
      }
    }
  }

  final _service = OrderApi();

  bool isLoading = false;

  List<Data> _menu = [];
  List<Data> get menu => _menu;

  List<DataVoucher> _voucher = [];
  List<DataVoucher> get voucher => _voucher;

  int price =0;
  void increasePrice(int priceAdd){
    price+=priceAdd;
    notifyListeners();
  }

  void decreasePrice(int priceDecrease){
    price-=priceDecrease;
    notifyListeners();
  }

  Future<void> getMenu() async{
    isLoading = true;
    notifyListeners();

    final response = await _service.getMenu();
    _menu = response;

    isLoading = false;
    notifyListeners();
  }

  Future<void> getVoucher(String type) async{
    isLoading = true;
    notifyListeners();

    final response = await _service.getVoucher(type);
    _voucher = response;

    isLoading = false;
    notifyListeners();
  }

  Future<void> doOrder(int? voucher_id, int nominal_diskon, int nominal_pesanan, List<Map<String, dynamic>> items) async{
    isLoading = true;
    notifyListeners();

    _service.doOrder(
      voucher_id,
      nominal_diskon,
      nominal_pesanan,
      items
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> cancelOrder(String id) async{
    isLoading = true;
    notifyListeners();

    _service.cancelOrder(id);

    isLoading = false;
    notifyListeners();
  }

}