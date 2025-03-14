// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_store_mobile/views/buyers/auth/login_screen.dart';
// import 'package:multi_store_mobile/views/buyers/inner_screens/edit_profile.dart';
// import 'package:multi_store_mobile/views/buyers/inner_screens/order_screen.dart';

// class AccountScreen extends StatelessWidget {
//   const AccountScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser; // Get the current user
//     CollectionReference users = FirebaseFirestore.instance.collection('buyers');

//     return FutureBuilder<DocumentSnapshot>(
//       future: user != null ? users.doc(user.uid).get() : Future.value(null),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (user == null) {
//           return Scaffold(
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("User not logged in. Please log in."),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(context, 
//                         MaterialPageRoute(builder: (context) => LoginScreen()));
//                     },
//                     child: Text("Go to Login"),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(child: Text("Something went wrong")),
//           );
//         }

//         if (!snapshot.hasData || !snapshot.data!.exists) {
//           return Scaffold(
//             body: Center(child: Text("No data found")),
//           );
//         }

//         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

//         return Scaffold(
//           appBar: AppBar(
//             elevation: 2,
//             backgroundColor: Colors.yellow.shade800,
//             title: Text(
//               'PROFILE',
//               style: TextStyle(letterSpacing: 4),
//             ),
//             centerTitle: true,
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Icon(Icons.star),
//               )
//             ],
//           ),
//           body: Column(
//             children: [
//               SizedBox(height: 25),
//               Center(
//                 child: CircleAvatar(
//                   radius: 64,
//                   backgroundColor: Colors.yellow.shade800,
//                   backgroundImage: data['profileImage'] != null
//                       ? NetworkImage(data['profileImage'])
//                       : AssetImage('assets/default_avatar.png') as ImageProvider,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   data['fullName'] ?? 'Unknown',
//                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   data['email'] ?? 'No Email',
//                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, 
//                   MaterialPageRoute(builder: (context) {
//                     return EditProfileScreen(userData: data);
//                   }));
//                 },
//                 child: Container(
//                   height: 40,
//                   width: MediaQuery.of(context).size.width - 200,
//                   decoration: BoxDecoration(
//                     color: Colors.yellow.shade800,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Edit Profile',
//                       style: TextStyle(
//                         color: Colors.white,
//                         letterSpacing: 4,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Divider(
//                   thickness: 2,
//                   color: Colors.grey,
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text('Settings'),
//               ),
//               ListTile(
//                 leading: Icon(Icons.phone),
//                 title: Text('Phone'),
//               ),
//               ListTile(
//                 leading: Icon(Icons.shop),
//                 title: Text('Cart'),
//               ),

//               ListTile(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return CustomerOrderScreen();
//                   }));
//                 },
//                 leading: Icon(CupertinoIcons.shopping_cart),
//                 title: Text("Order"),
//               ),
              
//               ListTile(
//                 onTap: () async {
//                   await FirebaseAuth.instance.signOut();
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) {
//                     return LoginScreen();
//                   }));
//                 },
//                 leading: Icon(Icons.logout),
//                 title: Text("Log Out"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


// //----------------------------------------------------------------------------------------------------------
// //---- ****uda thiyen CODE ek prashnayak unoth pahala athi parana code ek repalace karann *************-----------------
// //---------------------------------------------------------------------------------------------------------


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_mobile/views/buyers/auth/login_screen.dart';
import 'package:multi_store_mobile/views/buyers/inner_screens/edit_profile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance; // ✅ Initialize FirebaseAuth instance

    if (_auth.currentUser == null) {
      // ✅ If user is not logged in, show login screen
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.yellow.shade800,
          title: Text(
            'PROFILE',
            style: TextStyle(letterSpacing: 4),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please log in to access your profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade800,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(_auth.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(child: Text("Document does not exist"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // ✅ Get user data from Firestore
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.yellow.shade800,
            title: Text(
              'PROFILE',
              style: TextStyle(letterSpacing: 4),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SizedBox(height: 25),
              Center(
                child: CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.yellow.shade800,
                  backgroundImage: NetworkImage(data['profileImage'] ?? ""),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data['fullName'] ?? "No Name",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data['email'] ?? "No Email",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(userData: data)));
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 200,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade800,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Divider(thickness: 2, color: Colors.grey),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone'),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('Cart'),
              ),
              ListTile(
                onTap: () async {
                  await _auth.signOut().whenComplete(() {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                },
                leading: Icon(Icons.logout),
                title: Text("LogOut"),
              ),
            ],
          ),
        );
      },
    );
  }
}


// ---------------------------------------------------------------------------------------------------------

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AccountScreen extends StatefulWidget {
//   @override
//   _AccountScreenState createState() => _AccountScreenState();
// }

// class _AccountScreenState extends State<AccountScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     userId = _auth.currentUser?.uid; // Get current user ID
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("My Account")),
//       body: userId == ""
//           ? Center(child: Text("User not logged in"))
//           : StreamBuilder<DocumentSnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('buyers') // Collection Name
//                   .doc(userId) // Document ID
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator()); // Loading indicator
//                 }

//                 var userData = snapshot.data!;
//                 if (!userData.exists) {
//                   return Center(child: Text("No data found"));
//                 }

//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: NetworkImage(userData['profileImage'] ?? ""),
//                     ),
//                     SizedBox(height: 10),
//                     Text("Name: ${userData['fullName']}", style: TextStyle(fontSize: 18)),
//                     Text("Email: ${userData['email']}", style: TextStyle(fontSize: 16)),
//                     Text("Phone: ${userData['phoneNumber']}", style: TextStyle(fontSize: 16)),
//                   ],
//                 );
//               },
//             ),
//     );
//   }
// }
