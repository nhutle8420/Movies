import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Color.dart';
import 'package:movie_app/Widgets/trending_slider.dart';
import 'package:movie_app/Widgets/movies_slider.dart';
import 'package:movie_app/Widgets/search_silder.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Trending(),
    Movies_slider(),
  ];

  final PageStorageBucket page = PageStorageBucket();
  Widget currentScreen = Trending();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: page,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              minWidth: 40,
              onPressed: (){
                setState(() {
                  currentScreen = Trending();
                  currentTab = 0;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(
                      Icons.width_full,
                      color: currentTab == 0 ? Mycolor.white : Mycolor.blu,
                    ),
                  Text('Treding',
                    style: TextStyle(
                        color: currentTab == 0 ? Mycolor.white : Mycolor.blu)
                  )
                ],
              ),
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: (){
                setState(() {
                  currentScreen = Movies_slider();
                  currentTab = 1;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.width_full,
                    color: currentTab == 1 ? Mycolor.white : Mycolor.blu,
                  ),
                  Text('Movie',
                      style: TextStyle(
                          color: currentTab == 1 ? Mycolor.white : Mycolor.blu)
                  )
                ],
              ),
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: (){
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline_sharp,
                    color: currentTab == 2 ? Mycolor.white : Mycolor.blu,
                  ),
                  Text('Accout',
                      style: TextStyle(
                          color: currentTab == 2 ? Mycolor.white : Mycolor.blu)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
