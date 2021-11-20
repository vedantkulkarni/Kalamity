import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pict_vit/model/earthquake_model.dart';
import 'package:pict_vit/providers/networking.dart';

class EarthQuakeScreen extends StatefulWidget {
  const EarthQuakeScreen({Key? key, required this.eqData}) : super(key: key);

  final eqData;

  @override
  _EarthQuakeScreenState createState() => _EarthQuakeScreenState();
}

class _EarthQuakeScreenState extends State<EarthQuakeScreen> {
  double mag = 0.0;

  @override
  void initState() {
    printTerm(widget.eqData);
    super.initState();
  }

  void printTerm(dynamic eqData) {
    if (eqData == null) {
      print('null Data');
      return;
    }
    // mag = eqData['features'][0]['properties']['mag'];
    // place = eqData['features'][0]['properties']['place'];
    // tsunamiProbab = eqData['features'][0]['properties']['tsunami'];
    // var dateTime = DateTime.fromMillisecondsSinceEpoch(
    //     eqData['features'][0]['properties']['time']);
    // print(dateTime);
    // print(mag);
    // print(medData);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 80,
                child: widget.eqData != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
                                    return EQModel(
                                        index: index, eqData: widget.eqData);
                                  }),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('images/fof.json', height: 180),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sorry',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Circular',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Related Item not Found',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Circular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                //this is app bar
                height: 80,
                width: size.width,
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
                                padding: EdgeInsets.all(size.width * 0.025),
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
                                  size: size.width * 0.05,
                                  color: Color.fromRGBO(29, 60, 181, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * .2),
                        Text(
                          "EarthQuakes",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            wordSpacing: 2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
