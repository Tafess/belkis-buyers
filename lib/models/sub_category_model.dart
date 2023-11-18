import 'package:belkis/firebase_service.dart';

class SubCategoryModel {
  SubCategoryModel({this.mainCategory, this.subCategory, this.image});
  SubCategoryModel.fromJson(Map<String, Object?> json)
      : this(
            mainCategory: json['mainCategory']! as String,
            subCategory: json['subCategory']! as String,
            image: json['image']! as String);

  final String? mainCategory;
  final String? subCategory;
  final String? image;
  Map<String, Object?> toJson() {
    return {
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'image': image,
    };
  }
}

FirebaseService _service = FirebaseService();
subCategoryCollection({selectedSubCat}) {
  return _service.subCategories
      .where('active', isEqualTo: true)
      .where('mainCategory', isEqualTo: selectedSubCat)
      .withConverter<SubCategoryModel>(
        fromFirestore: (snapshot, _) =>
            SubCategoryModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
}
