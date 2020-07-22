import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class artical_view extends StatefulWidget {

  final String BlogUrl;
  
  artical_view({@required this.BlogUrl});

  @override
  _artical_viewState createState() => _artical_viewState();
}

class _artical_viewState extends State<artical_view> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    appBar: AppBar(

      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Srilankan "),
          Text("News ToDay" ,style: TextStyle(
              color:Colors.blue
          ),)
        ],
      ),
      centerTitle: true,
      elevation: 0.0,
    ),

    body:
    Container(
      child: WebView(
        initialUrl: widget.BlogUrl,
        onWebViewCreated: ((WebViewController webViewController){
          _completer.complete(webViewController);
        }),
      ),
    ),
  );
  }
}
