import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EQModel extends StatelessWidget {
  const EQModel({Key? key, required this.index, required this.eqData})
      : super(key: key);

  final int index;
  final eqData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String s =
        "${DateTime.fromMillisecondsSinceEpoch(eqData['features'][index]['properties']['time'])}";
    int idx = s.indexOf(" ");
    List parts = [s.substring(0, idx).trim(), s.substring(idx + 1).trim()];

    Future<void> _launchedInBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(url,
            forceSafariVC: false,
            forceWebView: false,
            headers: <String, String>{'header_key': 'header_value'});
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      height: 150,
      width: size.width * .9,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            right: 10,
            child: Container(
              width: size.width * .9,
              height: 120,
              child: Stack(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print("Pressed");
                                _launchedInBrowser(eqData['features'][index]
                                    ['properties']['detail']);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: Color.fromRGBO(29, 60, 181, 1),
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            width: size.width * .45,
                                            child: Text(
                                              eqData['features'][index]
                                                  ['properties']['place'],
                                              maxLines: 2,
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          'Date : ',
                                          style: TextStyle(
                                              color: Color.fromRGBO(29, 60, 181, 1),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${parts[0]}',
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          'Time : ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(29, 60, 181, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${parts[1]}',
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          'Tsunami Probability: ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(29, 60, 181, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${eqData['features'][index]['properties']['tsunami']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          'Latitude: ',
                                          style: TextStyle(
                                              color: Color.fromRGBO(29, 60, 181, 1),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${eqData['features'][index]['geometry']['coordinates'][0]}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          'Longitude: ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(29, 60, 181, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${eqData['features'][index]['geometry']['coordinates'][1]}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 20,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 2,
            child: Container(
              height: 150,
              padding: const EdgeInsets.only(left: 2),
              margin: EdgeInsets.only(left: 0, right: 10),
              child: Image.asset(
                'images/eq_photo.png',
                height: 80,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 80,
            child: Container(
              height: 100,
              width: 100,
              child: Column(
                children: [
                  Text(
                    'MAG',
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        '${eqData['features'][index]['properties']['mag']}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
