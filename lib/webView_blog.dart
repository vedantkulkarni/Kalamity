import 'package:flutter/material.dart';
import 'webView_blog.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewBlog extends StatelessWidget {
  late String blog_url;
  late String title;
  late String auther;
  WebViewBlog({required this.blog_url,required this.title,required this.auther});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF9C27B0),
          title: Text(
            'Tech4Bit',
            style: TextStyle(
              color: Color(0xFFC5CAE9),
            ),
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF9C27B0),
        items: [
          BottomNavigationBarItem(
            icon: Text('Section : -',style: TextStyle(
              fontSize: 20,
              color: Color(0xFFC5CAE9),
            ),)
            ,title: Text('',style: TextStyle(
            fontSize: 18,
            color: Color(0xFF9FA8DA),
          ),),),

          BottomNavigationBarItem(
            icon: Text('$auther',style: TextStyle(
              fontSize: 20,
              color: Color(0xFFC5CAE9),
            ),)
            ,title: Text('',style: TextStyle(
            fontSize: 18,
            color: Color(0xFF9FA8DA),
          ),),),
        ],
      ),
      body: WebView(
        initialUrl: '$blog_url',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
