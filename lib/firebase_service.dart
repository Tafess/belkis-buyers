import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference Banners =
      FirebaseFirestore.instance.collection('banners');
  CollectionReference BrandAds =
      FirebaseFirestore.instance.collection('brandAds');

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  CollectionReference mainCategories =
      FirebaseFirestore.instance.collection('mainCategories');
  CollectionReference subCategories =
      FirebaseFirestore.instance.collection('subCategories');
}
