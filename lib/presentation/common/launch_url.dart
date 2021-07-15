import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(String url) async => await canLaunch(url)
    ? await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      )
    : throw Exception('Could not launch $url');
