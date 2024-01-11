
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/Api/KeyApiURL.dart';

import 'detail_slider.dart';

class MoviesSilder extends StatelessWidget {
  const MoviesSilder({
    super.key,
    required this.snapshot,

  });

  final AsyncSnapshot snapshot;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        //chưa lấy được độ dài snapshort
       /* options: CarouselOptions(4
          height: 250,
          viewportFraction: 0.6,
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,

          enlargeCenterPage: true,
        ),*/
        itemBuilder: (context,itemIndex){
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
            child: Column(
              children: [
                  SizedBox(
                    child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${KeyApi.imagePath}${snapshot.data[itemIndex].poster_path}'
                    ),
                    height: 150,
                    width: 100,
                  ),
                const SizedBox(height: 10),
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

