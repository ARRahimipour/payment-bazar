import 'package:flutter/material.dart';
import 'package:flutter_poolakey/flutter_poolakey.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PurchasePage(),
    );
  }
}

class PurchasePage extends StatefulWidget {
  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final String rsaKey = "<YOUR_RSA_KEY>"; // کلید RSA از پنل کافه‌بازار
  IAPConnection? _connection;

  @override
  void initState() {
    super.initState();
    _initializeConnection();
  }

  /// اتصال به کافه‌بازار
  Future<void> _initializeConnection() async {
    try {
      _connection = await FlutterPoolakey.connect(rsaKey: rsaKey);
      if (_connection != null) {
        print("اتصال موفق به کافه‌بازار!");
      }
    } catch (e) {
      print("خطا در اتصال به کافه‌بازار: $e");
    }
  }

  /// خرید محصول
  Future<void> _purchaseProduct() async {
    if (_connection == null) {
      print("ابتدا به کافه‌بازار متصل شوید.");
      return;
    }

    try {
      final result = await _connection!.purchase(
        sku: "your_product_id", // شناسه محصول تعریف‌شده در پنل
      );
      print("خرید موفق بود: ${result.purchaseToken}");
      // اینجا می‌توانید محصول را به کاربر بدهید
    } catch (e) {
      print("خطا در خرید محصول: $e");
    }
  }

  @override
  void dispose() {
    _connection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("خرید محصول"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _purchaseProduct,
          child: Text("خرید محصول"),
        ),
      ),
    );
  }
}
