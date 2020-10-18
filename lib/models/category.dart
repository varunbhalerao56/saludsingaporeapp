import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  String categoryName;
  String categoryDescription;
  String categoryImage;
  bool isSelected;
  String categoryDocumentId;


  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  Categories({
     this.categoryName,
     this.categoryDescription,
     this.categoryImage,
     this.isSelected,
     this.categoryDocumentId,
  });

  Categories copyWith({
    String categoryName,
    String categoryDescription,
    String categoryImage,
    bool isSelected,
    String categoryDocumentId,
  }) {
    return new Categories(
      categoryName: categoryName ?? this.categoryName,
      categoryDescription: categoryDescription ?? this.categoryDescription,
      categoryImage: categoryImage ?? this.categoryImage,
      isSelected: isSelected ?? this.isSelected,
      categoryDocumentId: categoryDocumentId ?? this.categoryDocumentId,
    );
  }

  @override
  String toString() {
    return 'Categories{categoryName: $categoryName, categoryDescription: $categoryDescription, categoryImage: $categoryImage, isSelected: $isSelected, categoryDocumentId: $categoryDocumentId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categories &&
          runtimeType == other.runtimeType &&
          categoryName == other.categoryName &&
          categoryDescription == other.categoryDescription &&
          categoryImage == other.categoryImage &&
          isSelected == other.isSelected &&
          categoryDocumentId == other.categoryDocumentId);

  @override
  int get hashCode =>
      categoryName.hashCode ^
      categoryDescription.hashCode ^
      categoryImage.hashCode ^
      isSelected.hashCode ^
      categoryDocumentId.hashCode;

  factory Categories.fromMap(Map<String, dynamic> map) {
    return new Categories(
      categoryName: map['categoryName'] as String,
      categoryDescription: map['categoryDescription'] as String,
      categoryImage: map['categoryImage'] as String,
      isSelected: map['isSelected'] as bool,
      categoryDocumentId: map['categoryDocumentId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'categoryName': this.categoryName,
      'categoryDescription': this.categoryDescription,
      'categoryImage': this.categoryImage,
      'isSelected': this.isSelected,
      'categoryDocumentId': this.categoryDocumentId,
    } as Map<String, dynamic>;
  }


  factory Categories.fromDocument(DocumentSnapshot document) {
    return new Categories(
      categoryName: document.data()['categoryName'] as String,
      categoryDescription: document.data()['categoryDescription'] as String,
      categoryDocumentId: document.id,
      categoryImage: document.data()['categoryImage'] as String,


    );
  }
  //</editor-fold>


}