import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


CollectionReference customersCollection =
FirebaseFirestore.instance.collection('customers');


// Initialize Firebase instance
Future<void> initializeFlutterFire() async {
  await Firebase.initializeApp();

}

Future<void> addCustomer(String name, String email) {
  return customersCollection
      .add({
    'name': name,
    'email': email,
  })
      .then((value) => print('Customer added'))
      .catchError((error) => print('Failed to add customer: $error'));
}