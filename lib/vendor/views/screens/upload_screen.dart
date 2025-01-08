import 'package:flutter/material.dart';
import 'package:multi_store_mobile/provider/product_provider.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_tap_screens/attributes_tab_screens.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_tap_screens/general_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_tap_screens/images_tab_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_tap_screens/shipping_screen.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formkey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade800,
            bottom: TabBar(tabs: [
              Tab(
                child: Text('Genaral'),
              ),
              Tab(
                child: Text('Shipping'),
              ),
              Tab(
                child: Text('Attributes'),
              ),
              Tab(
                child: Text('Image'),
              ),
            ]),
          ),
          body: TabBarView(children: [
            GeneralScreen(),
            ShippingScreen(),
            AttributesTabScreens(),
            ImagesTabScreen()
          ]),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.yellow.shade800, // Text color
                shape: RoundedRectangleBorder(
                  // Optional: for rounded corners
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  print(_productProvider.productData['productName']);
                  print(_productProvider.productData['productPrice']);
                  print(_productProvider.productData['quantity']);
                  print(_productProvider.productData['category']);
                  print(_productProvider.productData['description']);
                  print(_productProvider.productData['imageUrlList']);
                }
              },
              child: Text('SAVE'),
            ),
          ),
        ),
      ),
    );
  }
}

class _formkey {}
