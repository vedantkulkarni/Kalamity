import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';

import 'display.dart';

var dispkkkl;
var location = [], city = [];
var measurement;
var selectedLocation = location[0];
var tmpName;

Map<int, List> paramap = {};
Map<int, List> valMap = {};
Map<int, List> lastupdateMap = {};
Map<int, List> avgPeriodMap = {};

var parameter = [];
var value = [];
var avgPeriodValue = [];
var lastUpdate = [];

const aikey = 'edac6c29d689a6cbe1698537097795c7';
const airQualityUrl = 'https://u50g7n0cbj.execute-api.us-east-1.a'
    'mazonaws.com/v1/latest?limit=100&page=1&offset=0&sort=desc&'
    'radius=1000&order_by=lastUpdated&dumpRaw=false#';

class AirQuaApi extends StatefulWidget {
  const AirQuaApi({Key? key}) : super(key: key);

  @override
  _AirQuaApiState createState() => _AirQuaApiState();
}

class _AirQuaApiState extends State<AirQuaApi> {
  List<DropdownMenuItem<String>> getDropDownList() {
    List<DropdownMenuItem<String>> dropdownItiems = [];
    for (int i = 0; i < location.length; i++) {
      String current = location[i];
      var neItiem = DropdownMenuItem(
        child: Text(current),
        value: current,
      );
      dropdownItiems.add(neItiem);
    }
    return dropdownItiems;
  }

  Future AirQuaFetch() async {
    var d = Uri.parse(airQualityUrl);
    http.Response response = await http.get(d);
    if (response.statusCode == 200) {
      print('start');
      var data = response.body;
      dispkkkl = convert.jsonDecode(data)['results'];
      location.clear();
      city.clear();
      avgPeriodValue.clear();
      parameter.clear();
      value.clear();
      lastUpdate.clear();
      for (int i = 0; i < dispkkkl.length; i++) {
        parameter.clear();
        value.clear();
        avgPeriodValue.clear();
        lastUpdate.clear();
        location.add(dispkkkl[i]['location']);
        city.add(dispkkkl[i]['city']);
        measurement = dispkkkl[i]['measurements'];
        // print(measurement.length);
        for (int j = 0; j < measurement.length; j++) {
          parameter.add(dispkkkl[i]['measurements'][j]['parameter']);
          value.add(dispkkkl[i]['measurements'][j]['value']);
          avgPeriodValue
              .add(dispkkkl[i]['measurements'][j]['averagingPeriod']['value']);
          lastUpdate.add(dispkkkl[i]['measurements'][j]['lastUpdated']);
        }
        paramap[i] = parameter;
        valMap[i] = value;
        lastupdateMap[i] = lastUpdate;
        avgPeriodMap[i] = avgPeriodValue;
      }
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: AirQuaFetch(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Container(
                height: height,
                width: width,
                color: Color(0xFFF3E5F5),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: height * 0.2,
                        width: width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(29, 60, 181, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Center(
                          child: Text(
                            'Air Quality Checker',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: height * 0.4,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              // color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 24,
                                  spreadRadius: 16,
                                  color: Color(0XFF4527A0).withOpacity(0.2),
                                )
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaY: 16,
                                sigmaX: 16,
                              ),
                              child: Container(
                                height: height * 0.0,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Colors.white.withOpacity(0.2),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, right: 10, left: 10, bottom: 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'Select Location',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: DropdownButton<String>(
                                          style: TextStyle(
                                            fontSize: 20,
                                            overflow: TextOverflow.fade,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          value: location[0],
                                          items: getDropDownList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedLocation =
                                                  value.toString();
                                              tmpName = selectedLocation;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return FinalDisplay();
                                            }));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 50),
                                            height: 100,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xFF01579B),
                                            ),
                                            child: Center(
                                                child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: height * 0.1,
                        width: width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(29, 60, 181, 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                        child: Center(
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
/*
* Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height*0.35,
                    width: width*0.9,
                    decoration: BoxDecoration(
                      color: Color(0xFFB3E5FC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Text('Select Location',style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            flex: 3,
                            child: Container(
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: DropdownButton<String>(
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    value: location[0],
                                    items: getDropDownList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLocation = value.toString();
                                        tmpName=selectedLocation;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return FinalDisplay();
                                }));
                              },
                              child: Container(
                                height: 70,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF01579B),
                                ),
                                child: Center(child: const Text('Submit',style: TextStyle(fontSize: 20,color: Colors.white),)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
* */
