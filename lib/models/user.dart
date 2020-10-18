import 'package:scoped_model/scoped_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'product.dart';


class AppUser extends Model {
  final String displayName;
  final String email;
  final String address;
  final String id;
  final String seller;
  final String stripeId;
  final String dateOfBirth;
  final String phoneNumber;
  List<Products> cart = [];
  double totalCartValue = 0;
  int get total => cart.length;
  List<dynamic> likedProducts = [];
  List<dynamic> orders = [];


  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  AppUser({
     this.displayName,
     this.email,
     this.address,
     this.id,
     this.seller,
     this.stripeId,
     this.dateOfBirth,
     this.phoneNumber,
     this.likedProducts,
     this.orders,
  });

  AppUser copyWith({
    String displayName,
    String email,
    String address,
    String id,
    String seller,
    String stripeId,
    String dateOfBirth,
    String phoneNumber,
    List<dynamic> likedProducts,
    List<dynamic> orders,
  }) {
    return new AppUser(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      address: address ?? this.address,
      id: id ?? this.id,
      seller: seller ?? this.seller,
      stripeId: stripeId ?? this.stripeId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      likedProducts: likedProducts ?? this.likedProducts,
      orders: orders ?? this.orders,
    );
  }

  @override
  String toString() {
    return 'AppUser{displayName: $displayName, email: $email, address: $address, id: $id, seller: $seller, stripeId: $stripeId, dateOfBirth: $dateOfBirth, phoneNumber: $phoneNumber, likedProducts: $likedProducts, orders: $orders}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          runtimeType == other.runtimeType &&
          displayName == other.displayName &&
          email == other.email &&
          address == other.address &&
          id == other.id &&
          seller == other.seller &&
          stripeId == other.stripeId &&
          dateOfBirth == other.dateOfBirth &&
          phoneNumber == other.phoneNumber &&
          likedProducts == other.likedProducts &&
          orders == other.orders);

  @override
  int get hashCode =>
      displayName.hashCode ^
      email.hashCode ^
      address.hashCode ^
      id.hashCode ^
      seller.hashCode ^
      stripeId.hashCode ^
      dateOfBirth.hashCode ^
      phoneNumber.hashCode ^
      likedProducts.hashCode ^
      orders.hashCode;

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return new AppUser(
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      id: map['id'] as String,
      seller: map['seller'] as String,
      stripeId: map['stripeId'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      phoneNumber: map['phoneNumber'] as String,
      likedProducts: map['likedProducts'] as List<dynamic>,
      orders: map['orders'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'displayName': this.displayName,
      'email': this.email,
      'address': this.address,
      'id': this.id,
      'seller': this.seller,
      'stripeId': this.stripeId,
      'dateOfBirth': this.dateOfBirth,
      'phoneNumber': this.phoneNumber,
      'likedProducts': this.likedProducts,
      'orders': this.orders,
    } as Map<String, dynamic>;
  }

  //</editor-fold>








  factory AppUser.fromDocument(DocumentSnapshot document) {
    return new AppUser(
      displayName: document.data()['displayName'] as String,
      email: document.data()['email'] as String,
      address: document.data()['address'] as String,
      id: document.id,
      stripeId: document.data()['stripeId'] as String,
      seller: document.data()['seller'] as String,
      orders : document.data()['orders'] as List<dynamic>,
      dateOfBirth: document.data()['dateOfBirth'] as String,
      phoneNumber: document.data()['phoneNumber'] as String,
      likedProducts: document.data()['likedProducts'] as List<dynamic>,
    );
  }


  Future<String> ReadOrderData(String variable, int index) async {
    String temp = '';
   await Firestore.instance.collection("user").document(id).get().then(
      (docSnapshot) {
        return {
          temp =
              docSnapshot["orders"][index][variable].toString(),
          //print(temp)
        };
      },
    );
    //print(temp);
    return temp ;
  }

  void ReadNestedData() {
    Firestore.instance.collection("user").document(id).get().then(
        (docSnapshot) => {
              print("Orders: " +
                  docSnapshot["orders"][0]["itemsOrdered"].toString())
            });
  }

//  void AddObjectToArray(String oid, String address, String date, String status,
//      String itemsOrdered) {
//    Order order = Order(oid, itemsOrdered, date, address, status);
//    Firestore.instance.collection("user").document(id).updateData({
//      "orders": FieldValue.arrayUnion([order.toMap()])
//    });
//  }

  void addProduct(product) {
    int index = cart.indexWhere((i) => i.productName == product.productName);
    print(index);
    if (index != -1)
      updateProduct(product, product.qty + 1);
    else {
      cart.add(product);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.productName == product.productName);
    cart[index].qty = 1;
    cart.removeWhere((item) => item.productName == product.productName);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.productName == product.productName);
    cart[index].qty = qty;
    if (cart[index].qty == 0) removeProduct(product);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.qty = 1);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue +=
          double.parse((f.productPrice * f.qty).toStringAsFixed(2));
    });
  }

  Future<void> currentUserChatroomOrderStatus(
      String orderId, String status, String id) async {
    DocumentReference docRef =
        Firestore.instance.collection("user").document(id);

    DocumentSnapshot docSnapshot = await docRef.get();
    DocumentSnapshot docData = docSnapshot;

    List<Map<String, dynamic>> userOrder = (docData["orders"] as List<dynamic>)
        .map((order) => Map<String, dynamic>.from(order))
        .toList();

    for (int index = 0; index < userOrder.length; index++) {
      Map<String, dynamic> order = userOrder[index];
      if (order["orderId"] == orderId) {
        order["itemsOrdered"] = status;
      }
      break;
    }

    await docRef.updateData({"orders": userOrder});
  }

}
