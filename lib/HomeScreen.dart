import 'package:flutter/material.dart';
import 'package:movie_app/Api/Api.dart';
import 'package:movie_app/Color.dart';
import 'package:movie_app/Models/movie.dart';
import 'package:movie_app/Widgets/movies_silder.dart';
import 'package:movie_app/Widgets/search.dart';
import 'package:movie_app/Widgets/trending_silder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

 late Future<List<Movie>> trendingMovies;
 late Future<List<Movie>> listMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Apii().gettrending();
    listMovies = Apii().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 1, vsync: this);
    return Scaffold(
        appBar: AppBar(
              backgroundColor: Mycolor.blu,
              elevation: 0,
              title: Text('MOVIE APP'),
              centerTitle: true,
            ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 60,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height*0.5,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                future: trendingMovies, builder: (context, snapshot){
                    if(snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }else if (snapshot.hasData){

                      return  TrendingSlider(snapshot: snapshot,);
                    }else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Trending' + '💖',
                  style: TextStyle(
                    color: Colors.red
                ),
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
              searchfunc(),
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: _tabController,
                    children:  [
                      FutureBuilder(future: listMovies,
                          builder: (context, snapshot){
                            if(snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            }else if (snapshot.hasData){

                              return  MoviesSilder(snapshot: snapshot,);
                            }else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          })


                    ],
                  ),
                )
              ]
            ) ,
          ),
        ],
      ),
    );


  }
}
