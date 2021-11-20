
import 'package:flutter/material.dart';
import 'package:pict_vit/Verification%20Screens/login_page.dart';
import 'package:pict_vit/Verification%20Screens/registration_page.dart';
import 'package:pict_vit/constants.dart';

class MainRegistration extends StatefulWidget {
  const MainRegistration({Key? key}) : super(key: key);

  @override
  _MainRegistrationState createState() => _MainRegistrationState();
}

class _MainRegistrationState extends State<MainRegistration> {

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  width: 414,
                  height: deviceHeight * 0.3,
                  decoration: const BoxDecoration(),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/app_logo.jpg',
                      scale: 1.6,
                    ),
                  ),
                ),
                Container(
                  width: 414,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TabBar(
                    isScrollable: false,
                    labelColor: black,
                    indicatorColor: black,
                    tabs: const [
                      Tab(
                        child: Text(
                          'Login',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Lato',
                              fontSize: 18,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Regsiter',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Lato',
                              fontSize: 18,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(children: [
                    LoginPage(),
                    RegistrationPage(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
