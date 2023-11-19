import 'package:belkis/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductBottomSheet extends StatelessWidget {
  final ProductModel? product;
  const ProductBottomSheet({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Specifications',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product!.sku != null)
                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SKU',
                        style: TextStyle(
                            color: Colors.grey.shade900, fontSize: 20),
                      ),
                      Text(product!.sku!),
                    ],
                  )),
                Text(product!.productName!)
              ],
            ),
          )
        ],
      ),
    );
  }
}
