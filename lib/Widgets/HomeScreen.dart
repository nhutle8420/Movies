import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Api/Api.dart';
import 'package:movie_app/Api/KeyApiURL.dart';
import 'package:movie_app/Color.dart';
import 'package:movie_app/Models/movie.dart';
import 'package:movie_app/Widgets/detail_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  int _currentIndex = 1;
 late Future<List<Movie>> trendingMovies;
 late Future<List<Movie>> listMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Apii().gettrending();
    listMovies = Apii().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 1, vsync: this);
    return Scaffold(
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
                future: trendingMovies,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else if(snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return ElevatedButton(
                        onPressed: () async {
                          await Apii().gettrending();
                          // Refresh the UI after data is saved
                        },
                        child: Text('Fetch and Save Movies'),
                      );
                    }else{
                      List<Movie> movies = snapshot.data!;

                      return  CarouselSlider.builder(
                        itemCount: movies.length,
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
                                    movie: movies[itemIndex],
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
                                          '${KeyApi.imagePath}${movies[itemIndex].poster_path}'
                                      ),
                                      fit:BoxFit.fill),
                                )
                            ),

                          );
                        },
                      );
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

                Container(
                  height: 700,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: _tabController,
                    children:  [
                      FutureBuilder(
                          future: listMovies,
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return CircularProgressIndicator();
                            }else if(snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return ElevatedButton(
                                onPressed: () async {
                                  await Apii().fetchMovies();
                                  // Refresh the UI after data is saved
                                },
                                child: Text('Fetch and Save Movies'),
                              );
                            }else {
                              List<Movie> movies = snapshot.data!;
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 20, bottom: 20),
                                      child: Text('List Movies',style: TextStyle(color: Mycolor.redd),),),
                                    Container(
                                        height: 250,
                                        child:ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics: const BouncingScrollPhysics(),
                                            itemCount: movies.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
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
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                              '${KeyApi.imagePath}${movies[index].poster_path}',
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
                                                          child: Text('${movies[index].release_date}',style:TextStyle (
                                                              color: Mycolor.green
                                                          ),),
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
                                                                    Text('${movies[index].vote_average}'),
                                                                  ],
                                                                ),
                                                              ),
                                                            )

                                                        )
                                                      ],
                                                    ),
                                                  ));
                                            }
                                        )
                                    ),
                                  ]);

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
