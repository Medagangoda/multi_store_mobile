import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Store image in firebase

  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('storeimage').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  //Store image in firebase storage ends here

  //STORE IMAGE

  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  //TO PICK STORE IMAGE

  Future<String> registerVendor(
    String bussinessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRegistered,
    String taxNumber,
    Uint8List? image,
  ) async {
    String res = 'some error occured';

    try {
      if (bussinessName.isNotEmpty &&
          email.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          countryValue.isNotEmpty &&
          stateValue.isNotEmpty &&
          cityValue.isNotEmpty &&
          taxRegistered.isNotEmpty &&
          taxNumber.isNotEmpty &&
          image != null) {
        //save data cloud firestore

        String storeimage = await _uploadVendorImageToStorage(image);

        await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
          'bussinessName': bussinessName,
          'email': email,
          'phoneNumber': phoneNumber,
          "countryValue": countryValue,
          "stateValue": stateValue,
          "cityValue": cityValue,
          "taxRegistered": taxRegistered,
          "taxNumber": taxNumber,
          "storeImage": storeimage,
          'approved': false,
          'vendorId':_auth.currentUser!.uid,

        });
      } else {
        res = 'please fields must not be empty';
      }
      ;
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
