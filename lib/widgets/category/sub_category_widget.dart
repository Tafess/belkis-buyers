import 'package:belkis/models/sub_category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class SubCategoryWidget extends StatelessWidget {
  final String? selectedSubCat;
  const SubCategoryWidget({super.key, this.selectedSubCat});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<SubCategoryModel>(
      query: subCategoryCollection(selectedSubCat: selectedSubCat),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }

        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: snapshot.docs.length == 0 ? 1 / .1 : 1 / 1.1),
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            // // if we reached the end of the currently obtained items, we try to
            // // obtain more items
            // if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
            //   // Tell FirestoreQueryBuilder to try to obtain more items.
            //   // It is safe to call this function from within the build method.
            //   snapshot.fetchMore();
            // }

            SubCategoryModel subCategory = snapshot.docs[index].data();
            return InkWell(
              onTap: () {
                //go to products screen
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade900)),
                    width: 60,
                    height: 60,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CachedNetworkImage(
                        imageUrl: subCategory.image!,
                        placeholder: (context, _) {
                          return Container(
                            height: 40,
                            width: 40,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                  Text(subCategory.subCategory!),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
