import 'dart:ffi';

import 'package:belkis/firebase_service.dart';
import 'package:belkis/models/product_model.dart';
import 'package:belkis/widgets/product_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel? product;
  final String? productId;
  const ProductDetailScreen({this.product, this.productId, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  FirebaseService _services = FirebaseService();

  ScrollController? _scrollController;
  int? pageNumber = 0;
  bool _isScrollDown = false;
  bool _showAppBar = true;

  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController!.addListener(() {
      if (_scrollController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollDown) {
          setState(() {
            _isScrollDown = true;
            _showAppBar = false;
          });
        }
      }
      if (_scrollController!.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollDown) {
          setState(() {
            _isScrollDown = false;
            _showAppBar = true;
          });
        }
      }
    });

    super.initState();
  }

  Widget _sizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.grey.shade400,
      thickness: 1,
    );
  }

  Widget _headText(String? text) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: 18,
        color: Colors.grey.shade900,
      ),
    );
  }

  Widget _verticalDivider() {
    return VerticalDivider(
      color: Colors.grey.shade400,
      thickness: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.blue),
              backgroundColor: Colors.white,
              title: Text(widget.product!.productName!),
              actions: [
                CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      IconlyLight.buy,
                      color: Colors.white,
                    )),
                _sizedBox(width: 10),
                CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    )),
                _sizedBox(width: 10),
              ],
            )
          : null, //it only show if you scroll down
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController, //app bar controller hide and show
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  child: Stack(
                    children: [
                      Hero(
                        tag: widget.product!.imageUrls![0],
                        child: PageView(
                          onPageChanged: (value) {
                            setState(() {
                              pageNumber = value;
                            });
                          },
                          children: widget.product!.imageUrls!.map((e) {
                            return CachedNetworkImage(
                              imageUrl: e,
                              fit: BoxFit.cover,
                            );
                          }).toList(),
                        ),
                      ),
                      Positioned(
                        bottom: 3,
                        right: 3,
                        //right: MediaQuery.of(context).size.width / 2,
                        child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: Text(
                                '${pageNumber! + 1}/${widget.product!.imageUrls!.length}')),
                      )
                    ],
                  ),
                ),
                _sizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product!.dicount != null
                              ? 'Discount : ${_services.formatedNumber(widget.product!.dicount)}  ETB'
                              : 'Price : ${_services.formatedNumber(widget.product!.price)}  ETB',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                splashRadius: 20,
                                splashColor: Colors.red,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  size: 20,
                                )),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.share)),
                          ],
                        ),
                      ],
                    ),
                    if (widget.product!.dicount != null)
                      Row(
                        children: [
                          Text(
                            'Price : ${_services.formatedNumber(widget.product!.price)}  ETB',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: 20),
                          Text(
                              '${(((widget.product!.price! - widget.product!.dicount!) / (widget.product!.price!)) * 100).toStringAsFixed(0)} %  off')
                        ],
                      ),
                    _sizedBox(height: 10),
                    Text(widget.product!.productName!),
                    _sizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                        ),
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                        ),
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                        ),
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                        ),
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                        ),
                        _sizedBox(width: 6),
                        Text('(5)')
                      ],
                    ),
                    _sizedBox(height: 10),
                    _headText('Description'),
                    _sizedBox(height: 10),
                    Text(widget.product!.dicription!),
                    _divider(),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ProductBottomSheet(
                                product: widget.product,
                              );
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _headText('Specification'),
                          Icon(
                            IconlyLight.arrowRight2,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                    _divider(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(flex: 2, child: _headText('Delivery')),
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    //Google map
                                  },
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'address addresss adresss adreess ASDSD ADDEEE AAD',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        IconlyLight.location,
                                        color: Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                ),
                                _sizedBox(height: 6),
                                Text('Home Delivery 3-5 days'),
                                Text(
                                    'Delivery charge :  ${widget.product!.chargeShipping! ? '${widget.product!.shipingCharge} ETB' : 'Free'}')
                              ],
                            )),
                      ],
                    ),
                    _divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _headText('Rating & Reviews(10)'),
                        Text('View all...')
                      ],
                    ),
                    _sizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Firt review -11 Feb 2023',
                        ),
                        Row(
                          children: [
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyLight.star,
                              color: Colors.deepOrange,
                            ),
                          ],
                        ),
                      ],
                    ),
                    _sizedBox(height: 10),
                    Text('Good product, good quality\n On time delivery'),
                    _sizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Second review buyer -11 Feb 2023',
                        ),
                        Row(
                          children: [
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyLight.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyLight.star,
                              color: Colors.deepOrange,
                            ),
                          ],
                        ),
                      ],
                    ),
                    _sizedBox(height: 5),
                    Text('Good product, good quality\n On time delivery'),
                    _sizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Seller -11 Feb 2023',
                        ),
                        Row(
                          children: [
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyBold.star,
                              color: Colors.deepOrange,
                            ),
                            Icon(
                              IconlyLight.star,
                              color: Colors.deepOrange,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text('Good product, good quality\n On time delivery'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        decoration:
            BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: FittedBox(
            child: Row(
              children: [
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Icon(Icons.store_mall_directory_outlined),
                    Text('Store')
                  ],
                ),
                Container(
                  height: 60,
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: _verticalDivider()),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Icon(Icons.chat),
                    Text('Chat')
                  ],
                ),
                Container(
                  height: 60,
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: _verticalDivider()),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {},
                    child: Text('Buy Now')),
                SizedBox(width: 20),
                ElevatedButton(onPressed: () {}, child: Text('Add to cart')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
