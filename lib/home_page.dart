import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pict_vit/air_quality/aq_list.dart';
import 'package:pict_vit/app_drawer.dart';
import 'package:pict_vit/constants.dart';
import 'package:pict_vit/model/grid_container.dart';
import 'package:pict_vit/model/loading_widget.dart';
import 'package:pict_vit/providers/networking.dart';
import 'package:pict_vit/uvcard.dart';
import 'package:pict_vit/webView_blog.dart';
import 'package:provider/provider.dart';
import 'earthquake_screen.dart';
import 'providers/uv_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollViewController = new ScrollController();
  bool _showAppbar = true;
  bool show_loader = false;
  bool isScrollingDown = false;
  late String? uid;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2021-01-01&endtime=2021-01-02');
    var eqData = await networkHelper.getData();
    show_loader = false;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EarthQuakeScreen(
        eqData: eqData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UVProvider>(create: (ctx) => UVProvider())
        ],
        child: Scaffold(
            drawer: AppDrawer(),
            body: Builder(
              builder: (context) => Container(
                color: Colors.white,
                width: deviceWidth,
                height: deviceHeight,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 100),
                        Expanded(
                          // height: 500,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            controller: _scrollViewController,
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: deviceHeight * 0.05,
                                // ),
                                Container(
                                    width: deviceWidth,
                                    height: 500,
                                    child: UVCard()),
                                SizedBox(height: 35),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Explore Recent Calamities',
                                          style: GoogleFonts.lato(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 35),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    children: [
                                      DCAE(
                                        name: 'EarthQuake',
                                        onTap: () {
                                          show_loader = true;
                                          setState(() {});
                                          getData();
                                        },
                                        img: 'assets/images/earth.jpg',
                                      ),
                                      DCAE(
                                        name: 'Air Quality',
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return AirQuaApi();
                                          }));
                                        },
                                        img:
                                            'assets/images/air_quality_image.jpg',
                                      ),
                                      DCAE(
                                          name: 'Cyclone',
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return PopUpCylcon(); //---------
                                                });
                                          },
                                          img: 'assets/images/flood.jpg'),
                                      DCAE(
                                          name: 'Drought',
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return PopUpDrought(); //---------
                                                });
                                          },
                                          img: 'assets/images/flood.jpg'),
                                      DCAE(
                                          name: 'LandSlides',
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return PopUpLand(); //---------
                                                });
                                          },
                                          img: 'assets/images/flood.jpg'),
                                      DCAE(
                                          name: 'Flood',
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return PopUp(); //---------
                                                });
                                          },
                                          img: 'assets/images/flood.jpg'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      //this is app bar
                      height: 80,
                      width: deviceWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Color.fromRGBO(29, 60, 181, 1),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 16),
                                  InkWell(
                                    onTap: () {
                                      Scaffold.of(context).openDrawer();
                                      print("Pressed");
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(deviceWidth * 0.025),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 10),
                                            blurRadius: 7,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.notes,
                                        size: deviceWidth * 0.05,
                                        color: Color.fromRGBO(29, 60, 181, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: deviceWidth * .2),
                              InkWell(
                                onTap: () {
                                  show_loader = false;
                                  setState(() {});
                                },
                                child: Text(
                                  "Disaster Tech4Bit",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    wordSpacing: 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: show_loader
                          ? Container(
                              height: 60, width: 60, child: LoadingWidget())
                          : Container(),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class PopUp extends StatelessWidget {
  const PopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: Expanded(
        child: SingleChildScrollView(
          child: Container(
            height: 250,
            width: 80,
            child: Column(
              children: [
                TextUrl(
                  name: 'OverView',
                  url: 'https://en.wikipedia.org/wiki/Flood',
                  auther: 'Flood',
                ),
                TextUrl(
                    auther: 'Flood',
                    url: 'https://en.wikipedia.org/wiki/List_of_floods',
                    name: 'Impact'),
                TextUrl(
                    auther: 'Flood',
                    url: 'https://www.who.int/health-topics/floods#tab=tab_3',
                    name: 'Who Response'),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            //color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class PopUpCylcon extends StatelessWidget {
  const PopUpCylcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: Expanded(
        child: SingleChildScrollView(
          child: Container(
            height: 250,
            width: 80,
            child: Column(
              children: [
                TextUrl(
                  name: 'OverView',
                  url: 'https://en.wikipedia.org/wiki/Cyclone',
                  auther: 'Cyclone',
                ),
                TextUrl(
                    auther: 'Cyclone',
                    url:
                        'https://en.wikipedia.org/wiki/Tropical_cyclones_and_climate_change',
                    name: 'Types'),
                TextUrl(
                    auther: 'Cyclone',
                    url:
                        'https://www.who.int/health-topics/tropical-cyclones#tab=tab_3',
                    name: 'WHO Impact'),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            //color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class PopUpDrought extends StatelessWidget {
  const PopUpDrought({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: Expanded(
        child: SingleChildScrollView(
          child: Container(
            height: 250,
            width: 80,
            child: Column(
              children: [
                TextUrl(
                  name: 'OverView',
                  url: 'https://en.wikipedia.org/wiki/Drought',
                  auther: 'Drought',
                ),
                TextUrl(
                    auther: 'Drought',
                    url: 'https://en.wikipedia.org/wiki/Drought_in_Turkey',
                    name: 'Types'),
                TextUrl(
                    auther: 'Drought',
                    url: 'https://www.who.int/health-topics/drought#tab=tab_3',
                    name: 'WHO Response'),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            //color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class PopUpLand extends StatelessWidget {
  const PopUpLand({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: Expanded(
        child: SingleChildScrollView(
          child: Container(
            height: 250,
            width: 80,
            child: Column(
              children: [
                TextUrl(
                  name: 'Overview',
                  url: 'https://en.wikipedia.org/wiki/Landslide',
                  auther: 'LandSlides',
                ),
                TextUrl(
                    auther: 'LandSlides',
                    url: 'https://en.wikipedia.org/wiki/List_of_landslides',
                    name: 'Types'),
                TextUrl(
                    auther: 'LandSlides',
                    url:
                        'https://www.who.int/health-topics/landslides#tab=tab_3',
                    name: 'WHO Response'),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            //color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class TextUrl extends StatelessWidget {
  late String name;
  late String url;
  late String auther;

  TextUrl({required this.auther, required this.url, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebViewBlog(
                blog_url: '$url', title: '$name', auther: '$auther');
          }));
        },
        child: Container(
          height: 60,
          width: 145,
          child: Center(
            child: Text(
              '$name',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class DCAE extends StatelessWidget {
  late String name;
  late VoidCallback onTap;
  late String img;

  DCAE({required this.name, required this.onTap, required this.img});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Transform(
            transform: Matrix4.identity()..translate(40.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  // alignment: Alignment.centerRight,
                  height: 100,
                  width: 220,
                  child: Center(
                    child: Transform(
                      transform: Matrix4.identity()..translate(30.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '$name',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 6,
                        blurRadius: 15,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Color(0xFF303F9F),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 150,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform(
                    transform: Matrix4.identity()..translate(-50.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        //alignment: Alignment.centerLeft,
                        width: 130,
                        height: 140,
                        image: AssetImage('$img'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
