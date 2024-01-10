import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/Color.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    viewportFraction: 0.6,
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (context,itemIndex,pageViewIndex){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.all(7.0),
                        color: Colours.ratingColor,
                        height: 250,
                        width: 170,
                      ),
                    );
                  },

              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Movies',
              style: GoogleFonts.aBeeZee(fontSize: 25),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.all(7.0),
                      color: Colours.ratingColor,
                      height: 200,
                      width: 100,
                    ),
                  );
                },
                  ),
            )
          ],


        ),
      ),
    );
  }
}