import 'package:belkis/firebase_service.dart';

class MainCategoryModel {
  MainCategoryModel({this.category, this.mainCategory});
  MainCategoryModel.fromJson(Map<String, Object?> json)
      : this(
            category: json['category']! as String,
            mainCategory: json['mainCategory']! as String);

  final String? category;
  final String? mainCategory;
  Map<String, Object?> toJson() {
    return {
      'category': category,
      'mainCategory': mainCategory,
    };
  }
}

FirebaseService _service = FirebaseService();
mainCategoryCollection(selectedCat) {
  return _service.mainCategories
      .where('approved', isEqualTo: true)
      .where('category', isEqualTo: selectedCat)
      .withConverter<MainCategoryModel>(
        fromFirestore: (snapshot, _) =>
            MainCategoryModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
}
