import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Color.dart';
import 'package:movie_app/KeyApiURL.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 10,
        options: CarouselOptions(
          height: 250,
          autoPlay: true,
          viewportFraction: 0.6,
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          enlargeCenterPage: true,
        ),
        itemBuilder: (context,itemIndex,pageViewIndex){
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              child: Image.network(
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                '${KeyApi.imagePath}${snapshot.data[itemIndex].poster_path}'
              ),
              height: 300,
              width: 200,
            ),
          );
        },

      ),
    );

  }
}