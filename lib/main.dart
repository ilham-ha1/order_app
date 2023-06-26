import 'package:flutter/material.dart';
import 'package:order_app/screen/order_page.dart';
import 'package:provider/provider.dart';
import 'package:order_app/provider/order_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => OrderProvider(),
        child:  MaterialApp(
          title: 'Order Application',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const OrderPage(title: 'Order App'),
        ),
    );
  }
}


