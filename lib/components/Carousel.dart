import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

class Carousel extends StatefulWidget{
  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Widget> carouselImages = [];

  @override
  void initState() {
    super.initState();

    carouselImages.addAll([
      Image.network("https://source.unsplash.com/random/900x700/?fashion"),
      Image.network("https://source.unsplash.com/random/900x700/?girl"),
      Image.network("https://source.unsplash.com/random/900x700/?women"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: carouselImages.isNotEmpty
          ? AnotherCarousel(
        images: carouselImages,
        dotSize: 6,
        indicatorBgPadding: 10,
        dotIncreasedColor: Colors.lightBlue,
        autoplay: true,
        autoplayDuration: Duration(seconds: 8),
      )
          : Center(child: Text("No Images")),
    );
  }
}