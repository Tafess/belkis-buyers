import 'package:belkis/firebase_service.dart';
import 'package:belkis/widgets/banner_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BannerHighlights extends StatefulWidget {
  const BannerHighlights({super.key});

  @override
  State<BannerHighlights> createState() => _BannerHighlightsState();
}

class _BannerHighlightsState extends State<BannerHighlights> {
  int scrollerPosition = 0;

  final FirebaseService _service = FirebaseService();
  List _brandAds = [];

  @override
  void initState() {
    super.initState();
    getBrandAds();
  }

  getBrandAds() {
    return _service.BrandAds.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _brandAds.add(doc);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Brand Highlights')),
          ),
          Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              itemCount: _brandAds.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 100,
                                color: Colors.blue,
                                child: YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId: _brandAds[index]['youtube'],
                                    flags: YoutubePlayerFlags(
                                      autoPlay: false,
                                      mute: true,
                                      loop: false,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                      height: 45,
                                      color: Colors.green,
                                      child: CachedNetworkImage(
                                        imageUrl: _brandAds[index]['image1'],
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            GFShimmer(
                                          child: Container(
                                            child: Container(
                                              height: 50,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                      height: 45,
                                      color: Colors.green,
                                      child: CachedNetworkImage(
                                        imageUrl: _brandAds[index]['image2'],
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            GFShimmer(
                                          child: Container(
                                            child: Container(
                                              height: 50,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 170,
                            color: Colors.orange,
                            child: CachedNetworkImage(
                              imageUrl: _brandAds[index]['image3'],
                              fit: BoxFit.fill,
                              placeholder: (context, url) => GFShimmer(
                                child: Container(
                                  child: Container(
                                    height: 50,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              onPageChanged: (value) {
                setState(() {
                  scrollerPosition = value;
                });
              },
            ),
          ),
          _brandAds.isEmpty
              ? Container()
              : DotsIndicatorWidget(
                  scrollerPosition: scrollerPosition,
                  itemList: _brandAds,
                ),
        ],
      ),
    );
  }
}
 