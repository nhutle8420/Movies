import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/KeyApiURL.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
      return Container(
        child: Column(
          children: [
            CarouselSlider.builder(
                itemCount: 10,
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
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  viewportFraction: 0.9,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  enlargeCenterPage: true,
                )
            ),
            CarouselSlider.builder(
                itemCount: 10,
                itemBuilder: (context,itemIndex,pageViewIndex){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      child:Text(
                          '${snapshot.data[itemIndex].title}'

                      ),

                    ),
                  );
                },
                options: CarouselOptions(
                  height: 20,
                  autoPlay: true,
                  viewportFraction: 0.6,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                  enlargeCenterPage: true,
                )
            ),

          ],
        ),
      );
    }
}

