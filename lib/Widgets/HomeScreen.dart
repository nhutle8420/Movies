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
  State<HomeScreen> createState() => HomeScreenState();
}


class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  int _currentIndex = 1;
 late Future<List<Movie>> trendingMovies;
 late Future<List<Movie>> listMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Apii().getTrending();
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
            expandedHeight: MediaQuery.of(context).size.height*0.7,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background:
              FutureBuilder(
                  future: trendingMovies,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10 , bottom: 10),
                              child: Text('Movies',style: TextStyle(color: Mycolor.white),),),
                            Column(
                              children: [
                                Container(
                                    height: 500,
                                    child:ListView.builder(
                                        itemCount: movies.length,
                                        scrollDirection: Axis.vertical,
                                        physics: BouncingScrollPhysics(),
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
                                              margin: EdgeInsets.only(top: 4, bottom: 4),
                                              height: 200,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(20, 20, 20, 1),
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(10)),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                'https://image.tmdb.org/t/p/w500${movies[index].poster_path}'),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: Container(
                                                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                        width: 180 ,
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                                '${movies[index].title}'),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 50),
                                                                      Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Container(
                                                                            padding:
                                                                            EdgeInsets.all(5),
                                                                            height: 30,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.amber.withOpacity(0.2),
                                                                                borderRadius: BorderRadius.all(Radius.circular(6))),
                                                                            child: Center(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.star,
                                                                                    color: Colors.amber, size: 20,
                                                                                  ),
                                                                                  SizedBox(width: 5,),
                                                                                  Text(
                                                                                      '${movies[index].vote_average.toStringAsFixed(1)}/10')
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10,),
                                                                          Container(
                                                                            padding:
                                                                            EdgeInsets.all(5),
                                                                            height: 30,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.amber.withOpacity(0.2),
                                                                                borderRadius: BorderRadius.all(Radius.circular(8))),

                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.people_outline_sharp,
                                                                                  color: Colors.amber, size: 20,
                                                                                ),
                                                                                SizedBox(width: 5,),
                                                                                Text(
                                                                                    '${movies[index].popularity.toStringAsFixed(0)}')
                                                                              ],
                                                                            ),

                                                                          ),
                                                                        ],
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),

                                                              ]
                                                          )
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    )
                                ),
                              ],
                            ),
                          ]);

                    }
                  })
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Trending' + '💖',
                  style: TextStyle(
                    color: Colors.red
                ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 1000,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10 , bottom: 10),
                                      child: Text('Movies',style: TextStyle(color: Mycolor.white),),),
                                    Column(
                                      children: [
                                        Container(
                                            height: 500,
                                            child:ListView.builder(
                                                itemCount: movies.length,
                                                scrollDirection: Axis.vertical,
                                                physics: BouncingScrollPhysics(),
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
                                                      margin: EdgeInsets.only(top: 4, bottom: 4),
                                                      height: 200,
                                                      width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                          color: Color.fromRGBO(20, 20, 20, 1),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width * 0.4,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.all(Radius.circular(10)),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        'https://image.tmdb.org/t/p/w500${movies[index].poster_path}'),
                                                                    fit: BoxFit.fill)),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Padding(
                                                              padding:
                                                              const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        Container(
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 180 ,
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                          '${movies[index].title}'),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              SizedBox(height: 50),
                                                                              Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Container(
                                                                                    padding:
                                                                                    EdgeInsets.all(5),
                                                                                    height: 30,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.amber.withOpacity(0.2),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(6))),
                                                                                    child: Center(
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.star,
                                                                                            color: Colors.amber, size: 20,
                                                                                          ),
                                                                                          SizedBox(width: 5,),
                                                                                          Text(
                                                                                              '${movies[index].vote_average.toStringAsFixed(1)}/10')
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(width: 10,),
                                                                                  Container(
                                                                                    padding:
                                                                                    EdgeInsets.all(5),
                                                                                    height: 30,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.amber.withOpacity(0.2),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(8))),

                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.people_outline_sharp,
                                                                                          color: Colors.amber, size: 20,
                                                                                        ),
                                                                                        SizedBox(width: 5,),
                                                                                        Text(
                                                                                            '${movies[index].popularity.toStringAsFixed(0)}')
                                                                                      ],
                                                                                    ),

                                                                                  ),
                                                                                ],
                                                                              ),

                                                                            ],
                                                                          ),
                                                                        ),

                                                                      ]
                                                                  )
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                            )
                                        ),
                                      ],
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
