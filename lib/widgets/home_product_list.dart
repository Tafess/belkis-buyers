import 'package:belkis/models/product_model.dart';
import 'package:belkis/screens/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class HomeProductList extends StatelessWidget {
  final String? category;
  HomeProductList({this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<ProductModel>(
      query: productQuery(category: category),
      builder: (context, snapshot, _) {
        // ...

        return GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.1),
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              snapshot.fetchMore();
            }
            var productIndex = snapshot.docs[index];
            ProductModel product = productIndex.data();
            String productId = productIndex.id;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300),
                width: 100,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProductDetailScreen(
                              product: product,
                              productId: productId,
                            ),
                          ),
                        );
                      },
                      child: Container(
                          height: 70,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrls![0],
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(height: 10),
                    Text(
                      product.productName!,
                      textAlign: TextAlign.center,
                    ),
                    Text('Price : ${product.price}'),
                    Text('Discount : ${product.dicount}'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
