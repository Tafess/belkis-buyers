import 'package:belkis/models/category_model.dart';
import 'package:belkis/screens/main_screen.dart';
import 'package:belkis/widgets/home_product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutterfire_ui/firestore.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Products for you',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeProductList(
                            category: _selectedCategory,
                          ),
                        ),
                      );
                    },
                    child: Text('View all...', style: TextStyle(fontSize: 12)),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                      child: FirestoreListView<CategoryModel>(
                          scrollDirection: Axis.horizontal,
                          query: categoryCollection,
                          itemBuilder: (context, snapshot) {
                            CategoryModel category = snapshot.data();
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ActionChip(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor:
                                    _selectedCategory == category.categoryName
                                        ? Colors.blue.shade700
                                        : Colors.white,
                                label: Text(
                                  category.categoryName!,
                                  style: TextStyle(
                                      color: _selectedCategory ==
                                              category.categoryName
                                          ? Colors.white
                                          : Colors.blue,
                                      fontSize: 14),
                                ),
                                onPressed: () {
                                  print(category.categoryName);
                                  setState(() {
                                    _selectedCategory = category.categoryName;
                                  });
                                },
                              ),
                            );
                          })),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const MainScreen(
                              index: 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(IconlyLight.arrowDown2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          HomeProductList(
            category: _selectedCategory,
          ),
        ],
      ),
    );
  }
}
