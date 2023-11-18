import 'package:belkis/widgets/banner_highlights.dart';
import 'package:belkis/widgets/banner_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../widgets/category/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Belkis Marketplace',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(IconlyLight.buy))],
      ),
      body: ListView(
        children: [
          SearchWidget(),
          SizedBox(
            height: 20,
          ),
          BannerWidget(),
          //   BannerHighlights(),
          Divider(
            height: 3,
            color: Colors.green,
          ),
          CategoryWidget(),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(8, 12, 0, 2),
                  hintText: 'Search products',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(CupertinoIcons.search)),
            ),
          ),
        ),
        Container(
          height: 10,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Row(
            //         children: [
            //           Icon(
            //             IconlyLight.infoSquare,
            //             size: 16,
            //             color: Colors.black,
            //           ),
            //           Text('100% Genuine',
            //               style: TextStyle(color: Colors.black, fontSize: 16)),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(
            //             IconlyLight.infoSquare,
            //             size: 16,
            //             color: Colors.black,
            //           ),
            //           Text('7-14 days return',
            //               style: TextStyle(color: Colors.black, fontSize: 16)),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(
            //             IconlyLight.infoSquare,
            //             size: 16,
            //             color: Colors.black,
            //           ),
            //           Text('Trusted brands',
            //               style: TextStyle(color: Colors.black, fontSize: 16)),
            //         ],
            //       ),
            //     ],
            //   ),
            //
          ),
        ),
      ],
    );
  }
}
