import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_mobile/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Cart Screen',style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            color: Colors.white
          ),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: _cartProvider.getCartItem.length,
          itemBuilder: (context, index) {
            final cartData = _cartProvider.getCartItem.values.toList()[index];
            return Card(
              child: SizedBox(
                height: 170,
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(cartData.imageUrl[0]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartData.productName,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5),
                          ),
                          Text(
                            '\Rs.' + '' + cartData.price.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                                color: Colors.yellow.shade800),
                          ),

                          OutlinedButton(
                            onPressed: null,
                            child: Text(
                            cartData.productSize,
                          ),
                          ),

                          Container(
                            height: 34,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade800,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: cartData.quantity ==1 ? null : () {
                                    _cartProvider.decreaMent(cartData);
                                  },
                                  icon: Icon(
                                    CupertinoIcons.minus,
                                    color: Colors.white,
                                  ),
                                  ),
                                  Text(
                                    cartData.quantity.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: cartData.productQuantity == cartData.quantity? null:() {
                                      _cartProvider.increament(cartData);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.white,
                                    )
                                    )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Your Shopping Cart is Empty',
      //         style: TextStyle(
      //           fontSize: 22,
      //           fontWeight: FontWeight.bold,
      //           letterSpacing: 5,
      //         ),
      //       ),
      //       SizedBox(height: 20,),

      //       Container(
      //         height: 40,
      //         width: MediaQuery.of(context).size.width - 40,
      //         decoration: BoxDecoration(
      //           color: Colors.yellow.shade800,
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: Center(
      //           child: Text(
      //             'Continue Shopping',
      //             style: TextStyle(fontSize: 19, color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
