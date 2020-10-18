import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class Orders {
  final String orderId;
  final String itemsOrdered;
  final String orderDate;
  final String address;
  final String status;
  final String expectedDelivery;
  final String userId;
  final bool helpRequest;
  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Orders({
     this.orderId,
     this.itemsOrdered,
     this.orderDate,
     this.address,
     this.status,
     this.expectedDelivery,
     this.userId,
     this.helpRequest,
  });

  Orders copyWith({
    String orderId,
    String itemsOrdered,
    String orderDate,
    String address,
    String status,
    String expectedDelivery,
    String userId,
    bool helpRequest,
  }) {
    if ((orderId == null || identical(orderId, this.orderId)) &&
        (itemsOrdered == null || identical(itemsOrdered, this.itemsOrdered)) &&
        (orderDate == null || identical(orderDate, this.orderDate)) &&
        (address == null || identical(address, this.address)) &&
        (status == null || identical(status, this.status)) &&
        (expectedDelivery == null ||
            identical(expectedDelivery, this.expectedDelivery)) &&
        (userId == null || identical(userId, this.userId)) &&
        (helpRequest == null || identical(helpRequest, this.helpRequest))) {
      return this;
    }

    return new Orders(
      orderId: orderId ?? this.orderId,
      itemsOrdered: itemsOrdered ?? this.itemsOrdered,
      orderDate: orderDate ?? this.orderDate,
      address: address ?? this.address,
      status: status ?? this.status,
      expectedDelivery: expectedDelivery ?? this.expectedDelivery,
      userId: userId ?? this.userId,
      helpRequest: helpRequest ?? this.helpRequest,
    );
  }

  @override
  String toString() {
    return 'Orders{orderId: $orderId, itemsOrdered: $itemsOrdered, orderDate: $orderDate, address: $address, status: $status, expectedDelivery: $expectedDelivery, userId: $userId, helpRequest: $helpRequest}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Orders &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          itemsOrdered == other.itemsOrdered &&
          orderDate == other.orderDate &&
          address == other.address &&
          status == other.status &&
          expectedDelivery == other.expectedDelivery &&
          userId == other.userId &&
          helpRequest == other.helpRequest);

  @override
  int get hashCode =>
      orderId.hashCode ^
      itemsOrdered.hashCode ^
      orderDate.hashCode ^
      address.hashCode ^
      status.hashCode ^
      expectedDelivery.hashCode ^
      userId.hashCode ^
      helpRequest.hashCode;

  factory Orders.fromMap(Map<String, dynamic> map) {
    return new Orders(
      orderId: map['orderId'] as String,
      itemsOrdered: map['itemsOrdered'] as String,
      orderDate: map['orderDate'] as String,
      address: map['address'] as String,
      status: map['status'] as String,
      expectedDelivery: map['expectedDelivery'] as String,
      userId: map['userId'] as String,
      helpRequest: map['helpRequest'] as bool,
    );
  }

  factory Orders.fromDocument(DocumentSnapshot document) {
    return new Orders(
      orderId: document.documentID,
      itemsOrdered: document['itemsOrdered'] as String,
      orderDate: document['orderDate'] as String,
      address: document['address'] as String,
      status: document['status'] as String,
      expectedDelivery: document['expectedDelivery'] as String,
      userId: document['userId'] as String,
      helpRequest: document['helpRequest'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'orderId': this.orderId,
      'itemsOrdered': this.itemsOrdered,
      'orderDate': this.orderDate,
      'address': this.address,
      'status': this.status,
      'expectedDelivery': this.expectedDelivery,
      'userId': this.userId,
      'helpRequest': this.helpRequest,
    } as Map<String, dynamic>;
  }

  //</editor-fold>


}