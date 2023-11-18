import 'package:belkis/models/category_model.dart';
import 'package:belkis/widgets/category/main_category_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutterfire_ui/firestore.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const String id = 'category-screen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _title = 'Categories';

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? _title : selectedCategory!,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Brand-Bold',
              fontSize: 20,
              fontStyle: FontStyle.italic),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(IconlyLight.buy),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.white,
            child: FirestoreListView<CategoryModel>(
                scrollDirection: Axis.horizontal,
                query: categoryCollection,
                itemBuilder: (context, snapshot) {
                  CategoryModel category = snapshot.data();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _title = category.categoryName!;
                        selectedCategory = category.categoryName;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 1, 0, 2),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4,
                          ),
                          //border: Border.all(color: selectedCategory == category.categoryName?selecter  Colors.green:Colors.white),
                          color: selectedCategory == category.categoryName
                              ? Colors.grey.withOpacity(0.1)
                              : Colors.white,
                        ),
                        width: 100,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipOval(
                                    child: CachedNetworkImage(
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  imageUrl: category.image!,
                                )),
                                Text(
                                  category.categoryName!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Bold',
                                      letterSpacing: 1,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          MainCategoryWidget(
            selectedCat: selectedCategory,
          ),
        ],
      ),
    );
  }
}
