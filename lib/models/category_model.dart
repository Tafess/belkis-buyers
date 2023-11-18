import 'package:belkis/firebase_service.dart';

class CategoryModel {
  CategoryModel({this.categoryName, this.image});
  CategoryModel.fromJson(Map<String, Object?> json)
      : this(
            categoryName: json['categoryName']! as String,
            image: json['image']! as String);

  final String? categoryName;
  final String? image;
  Map<String, Object?> toJson() {
    return {
      'categoryName': categoryName,
      'image': image,
    };
  }
}

FirebaseService _service = FirebaseService();
final categoryCollection = _service.categories
    .where('active', isEqualTo: true)
    .withConverter<CategoryModel>(
      fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
      toFirestore: (movie, _) => movie.toJson(),
    );
