import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_mobile/views/buyers/productDetail/product_detail_screen.dart';

class HomeProductWidget extends StatelessWidget {
  final String categoryName;

  const HomeProductWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('product')
        .where('category', isEqualTo: categoryName)
        .where('approved', isEqualTo: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading......");
        }

        return Container(
          height: 270,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProductDetailScreen(
                        productData: productData,
                      );
                    }));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 170,
                          width: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                productData['imageUrl'][0],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productData['productName'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\Rs.${productData['productPrice'].toString()}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                color: Colors.yellow.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, _) => SizedBox(
                    width: 15,
                  ),
              itemCount: snapshot.data!.docs.length),
        );
      },
    );
  }
}
