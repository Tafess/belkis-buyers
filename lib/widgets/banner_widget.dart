import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:belkis/firebase_service.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  FirebaseService _service = FirebaseService();
  int scrollerPosition = 0;

  List _bannerImages = [];

  void initState() {
    super.initState();
    getBanners();
  }

  getBanners() {
    return _service.Banners.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImages.add(doc['image']);
        });
      });
    }).catchError((error) {
      print("Error fetching banners: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    itemCount: _bannerImages.length,
                    itemBuilder: (BuildContext context, index) {
                      return CachedNetworkImage(
                          imageUrl: _bannerImages[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => GFShimmer(
                                showShimmerEffect: true,
                                mainColor: Colors.green,
                                secondaryColor: Colors.blue,
                                child: Container(
                                  height: 140,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.red,
                                ),
                              ));
                    },
                    onPageChanged: (value) {
                      setState(() {
                        scrollerPosition = value;
                      });
                    },
                  ))),
        ),
        _bannerImages.isEmpty?Container():
        Positioned(
          bottom: 10.0,
          child: DotsIndicatorWidget(
            scrollerPosition: scrollerPosition,
            itemList: _bannerImages,
          ),
        ),
      ],
    );
  }
}

class DotsIndicatorWidget extends StatelessWidget {
  const DotsIndicatorWidget({
    super.key,
    required this.scrollerPosition,
    required this.itemList,
  });

  final int scrollerPosition;
  final List itemList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: DotsIndicator(
            position: scrollerPosition,
            dotsCount: itemList.length,
            decorator: DotsDecorator(
                spacing: EdgeInsets.all(2),
                size: Size.square(5),
                activeSize: Size(12, 5),
                activeColor: Colors.blue.shade900,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
          ),
        ),
      ],
    );
  }
}
