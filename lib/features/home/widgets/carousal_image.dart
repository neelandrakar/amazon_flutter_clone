import 'package:amazon_clone/constants/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarousalImage extends StatelessWidget {
  const CarousalImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariable.carouselImages.map((i) {
        return Builder(
            builder: (BuildContext context) => Image.network(
                  i,
                  fit: BoxFit.cover,
                  height: 200,
                ));
      }).toList(),
      options: CarouselOptions(viewportFraction: 1,
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enableInfiniteScroll: true,),
    );
  }
}
