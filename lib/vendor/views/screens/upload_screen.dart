import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store_mobile/provider/product_provider.dart';
import 'package:multi_store_mobile/vendor/views/screens/main_vendor_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_tap_screens/attributes_tab_screens.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_tap_screens/general_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_tap_screens/images_tab_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_tap_screens/shipping_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
              onPressed: () async {
                EasyLoading.show(status: 'Please Wait...');
                if (_formkey.currentState!.validate()) {
                  final productId = Uuid().v4();
                  await _firestore.collection('product').doc(productId).set({
                    'productId': productId,
                    'productName': _productProvider.productData['productName'],
                    'productPrice':
                        _productProvider.productData['productPrice'],
                    'quantity': _productProvider.productData['quantity'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'imageUrl': _productProvider.productData['imageUrlList'],
                    'scheduleDate':
                        _productProvider.productData['scheduleDate'],
                    'chargeShipping':
                        _productProvider.productData['chargeShipping'],
                    'shippingCharge':
                        _productProvider.productData['shippingCharge'],
                    'brandName': _productProvider.productData['brandName'],
                    'sizeList': _productProvider.productData['sizeList'],
                    'vendorId' :FirebaseAuth.instance.currentUser!.uid,
                  }) .whenComplete(() {
                    EasyLoading.dismiss();
                    _productProvider.clearData();
                    _formkey.currentState!.reset();

                    Navigator.push(context, 
                    
                    MaterialPageRoute(builder: (context) {
                      return MainVendorScreen();
                    }));
                  }) ;
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
