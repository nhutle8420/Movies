import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Api/Api.dart';
import 'package:movie_app/Models/movie.dart';
import 'package:movie_app/Widgets/movies_silder.dart';
import 'package:movie_app/Widgets/trending_silder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

 late  Future<List<Movie>> trendingMovies;
 late  Future<List<Movie>> listMovies;
  @override
  void initState() {
    super.initState();
    trendingMovies = Apii().gettrending();
    listMovies = Apii().getMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('MOVIE APP'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Top Trending Movie',
              style: GoogleFonts.aBeeZee(fontSize: 25),
            ),
            const SizedBox(height: 5),
            SizedBox(
              child: FutureBuilder(
                future: trendingMovies,
                  builder: (context, snapshot){
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
            const SizedBox(height: 10),
            Text(
              'Movies',
              style: GoogleFonts.aBeeZee(fontSize: 25),
            ),
            SizedBox(
              child: FutureBuilder(
                  future: listMovies,
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
                  }
              ),
            ),

          ],


        ),
      ),
    );
  }
}