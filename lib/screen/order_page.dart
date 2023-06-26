import 'package:flutter/material.dart';
import 'package:order_app/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../widget/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.title});

  final String title;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.getMenu();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (provider.menu.isEmpty) {
              return const Center(
                child: Text('No menu items available.'),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.menu.length,
                      itemBuilder: (context, index) {
                        return OrderCard(orderItem: provider.menu[index]);
                      },
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Pesanan (${orderProvider.totalItems.toString()} Menu):",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),

                          ),
                          Text(
                            'Rp ${NumberFormat('#,##0', 'id_ID').format(orderProvider.price)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.airplane_ticket),
                          Text(
                            "Voucher",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),

                          ),
                          Text(
                            ">",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );


            }
          }
        },

      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, -5), // Offset to move the shadow upwards
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          child: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.shopping_basket),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        return Text(
                          'Rp ${NumberFormat('#,##0', 'id_ID').format(orderProvider.price)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text("Pesan Sekarang"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
