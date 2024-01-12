
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/Api/KeyApiURL.dart';
import 'package:movie_app/Color.dart';

import 'detail_slider.dart';

class MoviesSilder extends StatelessWidget {
  const MoviesSilder({
    super.key,
    required this.snapshot,

  });

  final AsyncSnapshot snapshot;


  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 20, bottom: 20),
              child: Text('List Movies',style: TextStyle(color: Mycolor.redd),),),
          Container(
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, itemIndex) {
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    '${KeyApi.imagePath}${snapshot
                                        .data[itemIndex].poster_path}',
                                  ),
                                  fit: BoxFit.cover
                              )

                          ),
                          margin: EdgeInsets.only(left: 15),
                          width: 170,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                            children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5 ,left: 6,),
                                  child: Text('${snapshot.data[itemIndex].release_date}'),
                                ),
                              Padding (
                                padding: const EdgeInsets.only(top: 2 ,right: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Mycolor.scaffoldBgColor.withOpacity(0.5)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                         top: 2,
                                        bottom: 2,
                                        left: 5,
                                        right: 5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Mycolor.yew,
                                        ),
                                        Text('${snapshot.data[itemIndex].vote_average}'),
                                      ],
                                    ),
                                  ),
                                )

                              )
                            ],
                          ),
                        ));
                  })),
        ]);
  }
}


