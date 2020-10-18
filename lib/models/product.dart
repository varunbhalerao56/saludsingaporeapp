import 'package:cloud_firestore/cloud_firestore.dart';

class Choice {
  int amount;
  List<String> choice;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  Choice({
    this.amount,
    this.choice,
  });

  factory Choice.fromMap(Map<String, dynamic> map) {
    return new Choice(
      amount: map['amount'] as int,
      choice: map['choice'] as List<String>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'amount': this.amount,
      'choice': this.choice,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

class Products {
  String productName;
  String productImg;
  String documentId;
  String productDescription;
  String productCategory;
  int productStock;
  int qty;
  double productPrice;
  List<String> bundleItems;

  Choice choice1;
  Choice choice2;
  Choice choice3;
  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  Products({
     this.productName,
     this.productImg,
     this.documentId,
     this.productDescription,
     this.productCategory,
     this.productStock,
     this.qty,
     this.productPrice,
     this.bundleItems,
     this.choice1,
     this.choice2,
     this.choice3,
  });

  Products copyWith({
    String productName,
    String productImg,
    String documentId,
    String productDescription,
    String productCategory,
    int productStock,
    int qty,
    double productPrice,
    List<String> bundleItems,
    Choice choice1,
    Choice choice2,
    Choice choice3,
  }) {
    return new Products(
      productName: productName ?? this.productName,
      productImg: productImg ?? this.productImg,
      documentId: documentId ?? this.documentId,
      productDescription: productDescription ?? this.productDescription,
      productCategory: productCategory ?? this.productCategory,
      productStock: productStock ?? this.productStock,
      qty: qty ?? this.qty,
      productPrice: productPrice ?? this.productPrice,
      bundleItems: bundleItems ?? this.bundleItems,
      choice1: choice1 ?? this.choice1,
      choice2: choice2 ?? this.choice2,
      choice3: choice3 ?? this.choice3,
    );
  }

  @override
  String toString() {
    return 'Products{productName: $productName, productImg: $productImg, documentId: $documentId, productDescription: $productDescription, productCategory: $productCategory, productStock: $productStock, qty: $qty, productPrice: $productPrice, bundleItems: $bundleItems, choice1: $choice1, choice2: $choice2, choice3: $choice3}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Products &&
          runtimeType == other.runtimeType &&
          productName == other.productName &&
          productImg == other.productImg &&
          documentId == other.documentId &&
          productDescription == other.productDescription &&
          productCategory == other.productCategory &&
          productStock == other.productStock &&
          qty == other.qty &&
          productPrice == other.productPrice &&
          bundleItems == other.bundleItems &&
          choice1 == other.choice1 &&
          choice2 == other.choice2 &&
          choice3 == other.choice3);

  @override
  int get hashCode =>
      productName.hashCode ^
      productImg.hashCode ^
      documentId.hashCode ^
      productDescription.hashCode ^
      productCategory.hashCode ^
      productStock.hashCode ^
      qty.hashCode ^
      productPrice.hashCode ^
      bundleItems.hashCode ^
      choice1.hashCode ^
      choice2.hashCode ^
      choice3.hashCode;

  factory Products.fromMap(Map<String, dynamic> map) {
    return new Products(
      productName: map['productName'] as String,
      productImg: map['productImg'] as String,
      documentId: map['documentId'] as String,
      productDescription: map['productDescription'] as String,
      productCategory: map['productCategory'] as String,
      productStock: map['productStock'] as int,
      qty: map['qty'] as int,
      productPrice: map['productPrice'] as double,
      bundleItems: map['bundleItems'] as List<String>,
      choice1: map['choice1'] as Choice,
      choice2: map['choice2'] as Choice,
      choice3: map['choice3'] as Choice,
    );
  }



  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'productName': this.productName,
      'productImg': this.productImg,
      'documentId': this.documentId,
      'productDescription': this.productDescription,
      'productCategory': this.productCategory,
      'productStock': this.productStock,
      'qty': this.qty,
      'productPrice': this.productPrice,
      'bundleItems': this.bundleItems,
      'choice1': this.choice1,
      'choice2': this.choice2,
      'choice3': this.choice3,
    } as Map<String, dynamic>;
  }


  factory Products.fromDocument(DocumentSnapshot document) {
    return new Products(
      productName: document.data()['productName'] as String,
      productImg: document.data()['productImg'] as String,
      documentId: document.id,
      productDescription: document.data()['productDescription'] as String,
      productCategory: document.data()['productCategory'] as String,
      productStock: document.data()['productStock'] as int,
      qty: document.data()['qty'] as int,
      productPrice: document.data()['productPrice'] as double,
      bundleItems: document.data()['bundleItems'] as List<String>,
      choice1: document.data()['choice1'] as Choice,
      choice2: document.data()['choice2'] as Choice,
      choice3: document.data()['choice3'] as Choice,
    );
  }


  //</editor-fold>


}



