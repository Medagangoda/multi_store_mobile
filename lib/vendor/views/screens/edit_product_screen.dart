import 'package:flutter/material.dart';
import 'package:multi_store_mobile/vendor/views/screens/edit_products_tabs/published_tab.dart';
import 'package:multi_store_mobile/vendor/views/screens/edit_products_tabs/unpublished_tab.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.yellow.shade800,
            title: Text(
              'Manage Product',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 7,
              ),
            ),
            bottom: TabBar(tabs: [
              Tab(
                child: Text('Published'),
              ),
              Tab(
                child: Text('Unpublished'),
              ),
            ]),
          ),
          body: TabBarView(children: [
            PublishedTab(),
            UnpublishedTab(),
          ]),
        ));
  }
}
