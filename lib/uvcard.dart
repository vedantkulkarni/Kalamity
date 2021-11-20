import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pict_vit/uvcard.dart';
import 'package:provider/provider.dart';
import 'providers/uv_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UVProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue,
            textTheme: GoogleFonts.latoTextTheme()

            // textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)
            ),
        home: const UVCard(),
      ),
    );
  }
}

class UVCard extends StatefulWidget {
  const UVCard({Key? key}) : super(key: key);

  @override
  State<UVCard> createState() => _UVCardState();
}

class _UVCardState extends State<UVCard> {
  late Future UVData;
  bool inited = false;
  String uvLevel = "Low";
  Color uvColor = Colors.white;

  Future<void> getUVData(BuildContext ctx) async {
    UVData =
        Provider.of<UVProvider>(context, listen: false).get_uv_index(17, 73);
    inited = true;
  }

  @override
  void didChangeDependencies() {
    if (inited == false) {
      getUVData(context);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final uv_provider = Provider.of<UVProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
          future: UVData,
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    " Hi ,",
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black87),
                                  ),
                                  Text("Vedant",
                                      style: GoogleFonts.lato(
                                          fontSize: 41,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Container(
                                child: Image.asset(
                                  uv_provider.sunImage(uv_provider.uvLevel(
                                      uv_provider.uvindex)["UV Level"]),
                                  width: 75,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          // padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            // border: Border.all(color: Colors.black),
                          ),
                          width: double.infinity,
                          height: 352,
                          child: (uv_provider.error == true)
                              ? Center(
                                  child: Text(
                                    "An error occured !",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )
                              : Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(29, 60, 181, 1),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "UV Radiation : ",
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${uv_provider.uvindex}",
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Ozone",
                                                      style: const TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${uv_provider.ozonelevel} DU",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Safe Exposure Duration",
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 27,
                                              color: Color.fromRGBO(
                                                  29, 60, 181, 1)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (ctx, index) {
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            "${uv_provider.stDuration(uv_provider.skintype[index].toString())} min.",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            decoration: BoxDecoration(
                                                                color: uv_provider
                                                                    .skintTypeColor(
                                                                        uv_provider.skintype[
                                                                            index]),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                uv_provider.stFullForm(
                                                                    uv_provider
                                                                        .skintype[
                                                                            index]
                                                                        .toString()),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  itemCount: 6,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Color.fromRGBO(29, 60, 181, 1),
                                          thickness: 2.0,
                                          height: 10,
                                          endIndent: 10,
                                          indent: 10,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Maximum UV level of the day ",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 30,
                                                  width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      uv_provider.maxUVLevel,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color.fromRGBO(
                                                        29, 60, 181, 1),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        const Divider(
                                          color: Color.fromRGBO(29, 60, 181, 1),
                                          thickness: 2.0,
                                          height: 10,
                                          endIndent: 10,
                                          indent: 10,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "UV Level : ",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        29, 60, 181, 1),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 45,
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    "${uv_provider.uvLevel(uv_provider.uvindex)["UV Level"]}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: uv_provider.uvLevel(
                                                      uv_provider
                                                          .uvindex)["UV Color"],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}

class SkinTypeTile extends StatelessWidget {
  late String skinType;
  late String typeDescription;
  late Color typeColor;
  SkinTypeTile(this.skinType, this.typeDescription, this.typeColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          skinType,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(typeDescription),
        trailing: Container(
          height: 35,
          width: 75,
          decoration: BoxDecoration(
              color: typeColor, borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
