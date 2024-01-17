import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/Api/KeyApiURL.dart';

import 'dart:convert';

import 'package:movie_app/Widgets/description_Checkui.dart';
import 'package:movie_app/Widgets/detail_slider.dart';

class Searchfunc extends StatefulWidget {
  const Searchfunc({super.key});

  @override
  State<Searchfunc> createState() => _searchbarfunState();
}

class _searchbarfunState extends State<Searchfunc> {
  ////////////////////////////////search bar function/////////////////////////////////////////////
  List<Map<String, dynamic>> searchresult = [];

  Future<void> searchlistfunction(val) async {
    var searchUrl =
        'https://api.themoviedb.org/3/search/multi?api_key=${KeyApi.aipKey}&query=$val';
    var searchresponse = await http.get(Uri.parse(searchUrl));
    if (searchresponse.statusCode == 200) {
      var tempdata = jsonDecode(searchresponse.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
       // only add value if all are present
        if (searchjson[i]['id'] != null &&
            searchjson[i]['poster_path'] != null &&
            searchjson[i]['vote_average'] != null && searchjson[i]['title'] != null
             )
    {
          searchresult.add({
            'id': searchjson[i]['id'],
            'poster_path': searchjson[i]['poster_path'],
            'vote_average': searchjson[i]['vote_average'],
            'media_type': searchjson[i]['media_type'],
            'popularity': searchjson[i]['popularity'],
            'overview': searchjson[i]['overview'],
            'title' : searchjson[i]['title']
          });

          // searchresult = searchresult.toSet().toList();

          if (searchresult.length > 30) {

            searchresult.removeRange(20, searchresult.length);
          }
        } else {
          print('null value found');
        }
      }
    }
  }

  final TextEditingController searchtext = TextEditingController();
  bool showlist = false;
  var val1;
  ////////////////////////////////search bar function/////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        FocusManager.instance.primaryFocus?.unfocus();
        showlist = !showlist;
      },
      child: Padding(
          padding:
          const EdgeInsets.only(left: 10.0, top: 30, bottom: 20, right: 10),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  autofocus: false,
                  controller: searchtext,
                  onSubmitted: (value) {
                    searchresult.clear();
                    setState(() {
                      val1 = value;
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  onChanged: (value) {
                    searchresult.clear();

                    setState(() {
                      val1 = value;
                    });
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              webBgColor: "#000000",
                              webPosition: "center",
                              webShowClose: true,
                              msg: "Search Cleared",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Color.fromRGBO(18, 18, 18, 1),
                              textColor: Colors.white,
                              fontSize: 16.0);

                          setState(() {
                            searchtext.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Search',
                      hintStyle:
                      TextStyle(color: Colors.white.withOpacity(0.2)),
                      border: InputBorder.none),
                ),
              ),
              //
              //
              SizedBox(
                height: 5,
              ),

              //if textfield has focus and search result is not empty then display search result

              searchtext.text.length > 0
                  ? FutureBuilder(
                  future: searchlistfunction(val1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                          height: 379,
                          child: ListView.builder(
                              itemCount: searchresult.length,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DescriptionCheckui(
                                                    searchresult[index]
                                                    ['id'],
                                                    searchresult[index]
                                                    ['poster_path'],
                                                  )));
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
                                                      'https://image.tmdb.org/t/p/w500${searchresult[index]['poster_path']}'),
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
                                                              width: 160 ,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                      '${searchresult[index]['title']}'),
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
                                                                            '${searchresult[index]['vote_average'].toStringAsFixed(1)}/10')
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
                                                                          '${searchresult[index]['popularity'].toStringAsFixed(0)}')
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
                              }));
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ));
                    }
                  })
                  : Container(),
            ],
          )),
    );
  }
}