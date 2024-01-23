import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Api/Api.dart';
import 'package:movie_app/Api/KeyApiURL.dart';
import 'package:movie_app/Color.dart';
import 'package:movie_app/Database/DatabaseHelper.dart';
import 'package:movie_app/Models/movie.dart';

import 'package:movie_app/Widgets/detail_slider.dart';
import 'package:movie_app/Widgets/search_silder.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => HomeScreenState();
}


class HomeScreenState extends State<Trending> with TickerProviderStateMixin{
  int _currentIndex = 1;
 late Future<List<Movie>> trendingMovies;
 late Future<List<Movie>> listMovies;
  @override
  void initState() {
    super.initState();

   // trendingMovies = DatabaseHelper.internal().getTreding_movie();
    trendingMovies = Apii().insertrending();
  }

  @override
  Widget build(BuildContext context) {
    Apii().insertrending();
    Apii().inserDatabMovies();
    return Scaffold(
            appBar: AppBar(
              title: Container(
                child:  Center (
                    child: Text('I-Movie',style: TextStyle(color: Mycolor.green),),
                ),
              ),
              backgroundColor: Mycolor.ratingColor,
            ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 75,
              color: Mycolor.blu.withOpacity(0.5),
              child: Searchfunc(),
            ),
            SizedBox(height: 10),

            Container(
              height: 474,
              width: MediaQuery.of(context).size.width,
              child: CustomScrollView(
                slivers: [
                  FutureBuilder(
                      future: trendingMovies,
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return SliverToBoxAdapter(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                              return SliverToBoxAdapter(
                              child: Text('Error: ${snapshot.error}'),
                              );
                              }else {
                          List<Movie> movies = snapshot.data!;

                          return SliverGrid(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 1,
                            ),
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return  GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          movie: movies[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child:  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500${movies[index].poster_path}'),
                                            fit: BoxFit.fill)),
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber, size: 30,
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                      '${movies[index].vote_average.toStringAsFixed(1)}',style: TextStyle(color: Mycolor.yew,fontSize: 20),)
                                                ],
                                              ),
                                      
                                          ),
                                      
                                        ],
                                      ),
                                    ),
                                  ),
                                );;
                              },
                              childCount: snapshot.data!.length,
                            ),
                          );
                        }

                      })
                ],
              ) ,
            ),

          ],
        ),
      ),
    );

                    // FutureBuilder<List<Movie>>(
                    //     future: trendingMovies,
                    //     builder: (context, snapshot){
                    //       if(snapshot.connectionState == ConnectionState.waiting){
                    //         return CircularProgressIndicator();
                    //       }else if(snapshot.hasError) {
                    //         return Text('Error: ${snapshot.error}');
                    //       }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    //         return ElevatedButton(
                    //           onPressed: () async {
                    //             await DatabaseHelper.internal().getMovies();
                    //             // Refresh the UI after data is saved
                    //           },
                    //           child: Text('Fetch and Save Movies'),
                    //         );
                    //       }else {
                    //         List<Movie> movies = snapshot.data!;
                    //         return SliverGrid(
                    //              delegate: SliverChildBuilderDelegate(
                    //              (BuildContext context, int index) {
                    //           return ListTrending( movie: movies[index],);
                    //         },
                    //           ),
                    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 2,
                    //           mainAxisSpacing: 8.0,
                    //           crossAxisSpacing: 8.0,
                    //           childAspectRatio: 1.0,
                    //         ),
                    //         );
                    //
                    //       }
                    //     })













  }
}


