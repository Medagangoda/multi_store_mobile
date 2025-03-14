import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_mobile/vendor/views/screens/earing_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/edit_product_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/upload_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/vendor_logout_screen.dart';
import 'package:multi_store_mobile/vendor/views/screens/vendor_order_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    EaringScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: ((value) {
            setState(() {
              _pageIndex = value;
            });
          }),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.yellow.shade800,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar),
              label: 'EARING',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: 'UPLOAD',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'EDIT',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'ORDER',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'LOGOUT',
            ),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
