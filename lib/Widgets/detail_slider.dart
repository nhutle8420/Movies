import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Api/KeyApiURL.dart';
import 'package:movie_app/Color.dart';
import 'package:movie_app/Models/movie.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.movie
  });
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            //leading: const BackButton(),
            backgroundColor: Mycolor.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(

              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${KeyApi.imagePath}${movie.poster_path}',
                 // filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
            ),

          ),

            SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10                                                                                              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    movie.title,
                    style: GoogleFonts.roboto(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                    // textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'Rating: ',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${movie.vote_average.toStringAsFixed(1)}',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ],
                          ),

                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'Day: ',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                movie.release_date,
                                style: GoogleFonts.roboto(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                      ],
                    ),
                  ),
                  Text(
                    ' Review ${movie.title} ',
                    style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.overview,
                    style: GoogleFonts.roboto(
                      fontSize: 15,

                    ),
                    // textAlign: TextAlign.justify,
                  ),
                  Text("  "),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Text(
                          ': ${movie.vote_count.toStringAsFixed(0)} ',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      children: [
                      Icon(
                          Icons.people_outline_sharp,
                          color: Colors.blueAccent, size: 30,
                        ),
                    SizedBox(width: 5,),
                        Text(
                          ': ${movie.popularity.toStringAsFixed(0)}',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                  )
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
  }

