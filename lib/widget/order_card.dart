import 'package:flutter/material.dart';
import 'package:order_app/model/menus.dart';
import 'package:order_app/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final Data orderItem;

  const OrderCard({required this.orderItem});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  int itemCount = 0;
  String note = 'Catatan';

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final itemCount = orderProvider.orderItems
        .firstWhere((item) => item.item == widget.orderItem, orElse: () {
      final newItem = OrderItem(widget.orderItem);
      orderProvider.orderItems.add(newItem);
      return newItem;
    }).count;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Rounded border radius
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300], // Grey background color
              ),
              width: 80,
              height: 80,
              child: Image.network(widget.orderItem.gambar),
            ),
          ),
          title: Text(widget.orderItem.nama),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( 'Rp ${NumberFormat('#,##0', 'id_ID').format(widget.orderItem.harga)}'),
              SizedBox(height: 8.0),
              InkWell(
                onTap: () {
                  _openNoteDialog();
                },
                child: Row(
                  children: [
                    Icon(Icons.edit_note),
                    SizedBox(width: 4.0),
                    Text(
                      '$note',
                      style: const TextStyle(
                        fontSize: 10
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (itemCount > 0) {
                    orderProvider.decreaseCount(widget.orderItem);
                    orderProvider.decreasePrice(widget.orderItem.harga);
                  }
                },
              ),
              Text(itemCount.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  orderProvider.increaseCount(widget.orderItem);
                  orderProvider.increasePrice(widget.orderItem.harga);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openNoteDialog() {
    String value = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambahkan Catatan'),
          content: TextField(
            onChanged: (text) {
              value = text;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  note = value;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}



