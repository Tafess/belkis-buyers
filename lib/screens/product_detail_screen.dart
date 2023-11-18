import 'package:belkis/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel? product;
  final String? productId;
  const ProductDetailScreen({this.product, this.productId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product!.productName!),
      ),
      body: Center(
        child: Text('product details '),
      ),
    );
  }
}
