import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/Api/KeyApiURL.dart';
import 'package:movie_app/Widgets/detail_slider.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return  CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            height: MediaQuery.of(context).size.height),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    movie: snapshot.data[itemIndex],
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(
                   Colors.black.withOpacity(0.3),
                  BlendMode.darken),
                  image: NetworkImage(
                      '${KeyApi.imagePath}${snapshot
                          .data[itemIndex].poster_path}'
                  ),
                    fit:BoxFit.fill),
                )
              ),

            );
        },
      );
  }
}