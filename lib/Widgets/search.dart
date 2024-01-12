import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Api/KeyApiURL.dart';
import 'dart:convert';

class searchfunc extends StatefulWidget {
  const searchfunc({super.key});

  @override
  State<searchfunc> createState() => _searchfuncState();
}

class _searchfuncState extends State<searchfunc> {
  List<Map<String, dynamic>> searchValue = [];
  bool a = false;
  var b;
  final TextEditingController search = TextEditingController();

  Future<void> searchlistfunction(val) async {
    var searchurl =
        'https://api.themoviedb.org/3/search/multi?api_key=${KeyApi.aipKey} &query=$val';
    var searchresponse = await http.get(Uri.parse(searchurl));
    if (searchresponse.statusCode == 200) {
      var tempdata = jsonDecode(searchresponse.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        //only add value if all are present
        if (searchjson[i]['id'] != null &&
            searchjson[i]['poster_path'] != null &&
            searchjson[i]['vote_average'] != null ){
          searchValue.add({
            'id': searchjson[i]['id'],
            'poster_path': searchjson[i]['poster_path'],
            'vote_average': searchjson[i]['vote_average'],
            'popularity': searchjson[i]['popularity'],
            'overview': searchjson[i]['overview'],
          });



          if (searchValue.length > 20) {
            searchValue.removeRange(20, searchValue.length);
          }
        } else {
          print('null value found');
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print("tapped");
        FocusManager.instance.primaryFocus?.unfocus();
        a = !a;
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
          child:  TextField(
            controller: search,
            onSubmitted: (value) {
              searchValue.clear();
              setState(() {
                b = value;
              });
            },
              onChanged: (value) {
                searchValue.clear();
                setState(() {
                  b = value;
                });
              },
            decoration: InputDecoration(
              suffix: IconButton(
                  onPressed: () {
                    // Fluttertoast.showToast(
                    //     webBgColor: "#000000",
                    //     webPosition: "center",
                    //     webShowClose: true,
                    //     msg: "Search Cleared",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 2,
                    //     backgroundColor: Color.fromRGBO(18, 18, 18, 1),
                    //     textColor: Colors.white,
                    //     fontSize: 16.0,);

                    setState(() {
                      search.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.amber.withOpacity(0.6),
                ),
            ),
          ),
          ),
          ),
          ],
        ),
      ),
    );
  }
}
