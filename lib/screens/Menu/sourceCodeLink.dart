

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChromeLinkWidget extends StatelessWidget {
  final Uri url ;

  ChromeLinkWidget({required this.url});

  _launchURL() async {
    if (await canLaunchUrl(url)) {
      (!await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
            headers: <String, String>{'my_header_key': 'my_header_value'}),
      ));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white24,
      title: Text('Open github link,'),
      content: Container(
        alignment: Alignment.topLeft,
        child: TextButton(onPressed: (){
          _launchURL();
        },
            child: Text("Open link")),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
