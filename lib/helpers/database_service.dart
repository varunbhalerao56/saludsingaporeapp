import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:saludsingapore/models/category.dart';
import 'package:saludsingapore/models/orders.dart';
import 'package:saludsingapore/models/product.dart';
import 'package:saludsingapore/models/user.dart';



Stream<List<Products>> products() {
  return ProductCollection().collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Products.fromDocument(doc)).toList();
  });
}

Stream<List<Categories>> categories() {
  return CategoriesCollection().collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Categories.fromDocument(doc)).toList();
  });
}

Stream<List<Orders>> order() {
  return OrderCollection().collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Orders.fromDocument(doc)).toList();
  });

}

Future<int> countDocumentsCategories() async {
  QuerySnapshot _myDoc = await Firestore.instance.collection('categories').getDocuments();
  List<DocumentSnapshot> _myDocCount = _myDoc.documents;
  return _myDocCount.length; // Count of Documents in Collection


}Stream<List<Products>> userProductsCollection(
    CollectionReference productCollection) {
  return productCollection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Products.fromDocument(doc)).toList();
  });
}

CollectionReference cartCollection(String userID) {
  return FirebaseFirestore.instance.collection('user/$userID/cart');
}

Stream<AppUser> userData(String uid) {
  return FirebaseFirestore.instance.doc('user/$uid').snapshots().map((doc) {
    return AppUser.fromDocument(doc);
  });
}

class ProductCollection  {
  CollectionReference collection  =   FirebaseFirestore.instance.collection('products');
}


class OrderCollection  {
  CollectionReference collection  =   FirebaseFirestore.instance.collection('order');
}


class CategoriesCollection  {
  CollectionReference collection  =   FirebaseFirestore.instance.collection('categories');
}
