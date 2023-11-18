import 'package:belkis/models/main_category_model.dart';
import 'package:belkis/widgets/category/sub_category_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class MainCategoryWidget extends StatefulWidget {
  final String? selectedCat;
  const MainCategoryWidget({this.selectedCat, super.key});

  @override
  State<MainCategoryWidget> createState() => _MainCategoryWidgetState();
}

class _MainCategoryWidgetState extends State<MainCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreListView<MainCategoryModel>(
          scrollDirection: Axis.vertical,
          query: mainCategoryCollection(widget.selectedCat),
          itemBuilder: (context, snapshot) {
            MainCategoryModel mainCategory = snapshot.data();
            return ExpansionTile(
              title: Text(mainCategory.mainCategory!),
              children: [
                SubCategoryWidget(
                  selectedSubCat: mainCategory.mainCategory,
                )
              ],
            );
          }),
    );
  }
}
