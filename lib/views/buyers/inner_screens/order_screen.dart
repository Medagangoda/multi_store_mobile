import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:intl/intl.dart';

class CustomerOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormate.format(date);
    return outPutDate;
  }


  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        elevation: 0,
        title: Text(
          'MY ORDERS',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 5),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.yellow.shade800,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14,
                          child: document['accepted'] == true
                              ? Icon(Icons.delivery_dining)
                              : Icon(Icons.access_time),
                        ),
                        title: document['accepted'] == true
                            ? Text(
                                'Accepted',
                                style: TextStyle(color: Colors.blue),
                              )
                            : Text(
                                'Not Accepted',
                                style: TextStyle(color: Colors.red),
                              ),
                        trailing: Text(
                          'Amount' +
                              ' ' +
                              document['productPrice'].toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 17, color: Colors.yellow.shade700),
                        ),
                        subtitle: Text(
                          formatedDate(
                            document['orderDate'].toDate(),
                          ),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          'Order Details',
                          style: TextStyle(color: Colors.yellow.shade800),
                        ),
                        subtitle: Text('View Order Details'),
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Image.network(document['productImage'][0]),
                            ),
                            title: Text(document['productName']),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      ('Quantity'),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(document['quantity'].toString())
                                  ],
                                ),
                                document['accepted'] == true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Schedule Delivery Date'),
                                          Text(formatedDate(
                                              document['scheduleData']
                                                  .toDate()))
                                        ],
                                      )
                                    : Text(''),
                                ListTile(
                                  title: Text(
                                    'Buyer Details',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(document['fullName']),
                                      Text(document['email']),
                                      Text(document['address']),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  );
            }).toList(),
          );
        },
      ),
    );
  }
}
