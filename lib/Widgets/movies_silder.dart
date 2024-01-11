
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/KeyApiURL.dart';

class MoviesSilder extends StatelessWidget {
  const MoviesSilder({
    super.key,
    required this.snapshot,

  });

  final AsyncSnapshot snapshot;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 20, //chưa lấy được độ dài snapshort
        options: CarouselOptions(
          height: 250,
          viewportFraction: 0.6,
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,

          enlargeCenterPage: true,
        ),
        itemBuilder: (context,itemIndex,pageViewIndex){
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                  SizedBox(
                    child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${KeyApi.imagePath}${snapshot.data[itemIndex].poster_path}'
                    ),
                    height: 150,
                    width: 150,
                  ),
                SizedBox(
                  child: Text(
                      '${snapshot.data[itemIndex].title}'
                  ),
                )
              ],
            ),
          );
        },

      ),
    );

  }
}
/*

*/

