import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = "User";

    void inputData() {
      final User? user = auth.currentUser;
      uid = user!.email;
    }

    @override
    void initState() {
      super.initState();
      inputData();
    }

    return Drawer(
      child: Container(
        color: Color.fromRGBO(29, 60, 181, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Center(
              child: Column(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.amber[50],
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // GetUserName(uid, 18),
                      Text(
                        uid!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 1,
              width: 150,
              color: black,
            ),
            SizedBox(height: 20),
            Text(
              'City',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
