import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_mobile/provider/cart_provider.dart';
import 'package:multi_store_mobile/utils/show_snackBar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  int _imageIndex = 0;
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: PhotoView(
                      imageProvider:
                          NetworkImage(widget.productData['imageUrl'][0])),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.productData['imageUrl'].length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _imageIndex = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.yellow.shade800)),
                                  height: 60,
                                  width: 60,
                                  child: Image.network(
                                      widget.productData['imageUrl'][index]),
                                ),
                              ),
                            );
                          }),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                '\Rs.' + widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade800),
              ),
            ),
            Text(
              widget.productData['productName'],
              style: TextStyle(
                  fontSize: 22, letterSpacing: 5, fontWeight: FontWeight.bold),
            ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Description',
                    style: TextStyle(color: Colors.yellow.shade900),
                  ),
                  Text('View More',
                      style: TextStyle(color: Colors.yellow.shade900)),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['description'],
                    style: TextStyle(
                        fontSize: 17, color: Colors.grey, letterSpacing: 3),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'This Product Will be Shipping ON ',
                    style: TextStyle(
                        color: Colors.yellow.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    formatedDate(
                      widget.productData['scheduleDate'].toDate(),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Text(
                'Availbale Size',
                style: TextStyle(color: Colors.blue),
              ),
              children: [
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['sizeList'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          color: _selectedSize ==
                                  widget.productData['sizeList'][index]
                              ? Colors.yellow.shade100
                              : null,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedSize =
                                    widget.productData['sizeList'][index];
                              });
                              print(_selectedSize);
                            },
                            child: Text(
                              widget.productData['sizeList'][index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.getCartItem
                  .containsKey(widget.productData['productId'])
              ? null
              : () {
                  if (_selectedSize == null) {
                    return showSnack(context, 'Please select a Size');
                  } else {
                    _cartProvider.addProductToCart(
                        widget.productData['productName'],
                        widget.productData['productId'],
                        widget.productData['imageUrl'],
                        1,
                        widget.productData['quantity'],
                        widget.productData['productPrice'],
                        widget.productData['vendorId'],
                        _selectedSize!,
                        widget.productData['scheduleDate']);

                        return showSnack(context, 'YOU ADDED ${widget.productData['productName']} TO YOUR CART');
                  }
                },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: _cartProvider.getCartItem
                        .containsKey(widget.productData['productId'])
                    ? Colors.grey
                    : Colors.yellow.shade800,
                borderRadius: BorderRadius.circular(
                  10,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _cartProvider.getCartItem
                          .containsKey(widget.productData['productId'])
                      ? Text(
                          'IN CART',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2),
                        )
                      : Text(
                          'ADD TO CART',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
