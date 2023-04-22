// ignore_for_file: unnecessary_new

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AroundcarPage extends StatefulWidget {
  const AroundcarPage({super.key});

  @override
  State<AroundcarPage> createState() => _AroundcarPageState();
}

class _AroundcarPageState extends State<AroundcarPage> {
  static const String flutterUrl = 'https://flutter.io/';
  static const String githubUrl = 'http://www.codesnippettalk.com';

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
  late TapGestureRecognizer _flutterTapRecognizer;
  late TapGestureRecognizer _githubTapRecognizer;
  @override
  void initState() {
    super.initState();
    _flutterTapRecognizer = new TapGestureRecognizer()..onTap = () => _openUrl(flutterUrl);
    _githubTapRecognizer = new TapGestureRecognizer()..onTap = () => _openUrl(githubUrl);
  }

  @override
  void dispose() {
    _flutterTapRecognizer.dispose();
    _githubTapRecognizer.dispose();
    super.dispose();
  }

  void _openUrl(String url) async {
    // Close the about dialog.
    Navigator.pop(context);

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new TextButton(
        child: const Text('Show Pop-up'),

        /*   color: Theme.of(context).accentColor,
        elevation: 4.0,
        splashColor: Colors.amberAccent,
        textColor: const Color(0xFFFFFFFF), */
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildAboutDialog(context),
          );
          // Perform some action
        },
      ),
    );
  }

  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('About Pop up'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(),
          _buildLogoAttribution(),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              primary: const Color(0xffE52628),
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }

  Widget _buildAboutText() {
    return new RichText(
      text: new TextSpan(
        text:
            'Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n',
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[
          const TextSpan(text: 'The app was developed with '),
          new TextSpan(
            text: 'Flutter',
            recognizer: _flutterTapRecognizer,
            style: linkStyle,
          ),
          const TextSpan(
            text: ' and it\'s open source; check out the source '
                'code yourself from ',
          ),
          new TextSpan(
            text: 'www.codesnippettalk.com',
            recognizer: _githubTapRecognizer,
            style: linkStyle,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }

  Widget _buildLogoAttribution() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: new Image.asset(
              "assets/flutter.png",
              width: 32.0,
            ),
          ),
          const Expanded(
            child: const Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: const Text(
                'Popup window is like a dialog box that gains complete focus when it appears on screen.',
                style: const TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
