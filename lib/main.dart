import 'dart:developer';

import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:oauth_dio/oauth_dio.dart';

// void main() {
//   final oauth = OAuth(
//       clientId: '8f4562b21a',
//       clientSecret: '8d1af1363a',
//       tokenUrl:
//           'https://your-frappe-instance.com/api/method/frappe.integrations.oauth2.get_token');
//
//   oauth
//       .requestToken(
//           PasswordGrant(username: 'Administrator', password: 'admin1234'))
//       .then((token) {
//     print('AccessToken: ${token.accessToken}');
//     print('RefreshToken: ${token.refreshToken}');
//     print('Expiration: ${token.expiration}');
//   });
// }

import 'package:flutter/material.dart';
import 'package:oauth_dio/oauth_dio.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }

}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uri? currentUri;
  @override
  void initState() {
    geturl();
    super.initState();
  }



  void geturl() {
    currentUri = Uri.base;
    String currentUrl = currentUri.toString();
    setState(() {});
    print('Current URL: $currentUrl');
  }
  String? token = "";

  Future<void> _authenticate() async {
    final clientId = '8f4562b21a';
    final redirectUri =
        'https://flutterwebauth.vercel.app/';
    final authUrl =
        "https://demo.extensionerp.com/api/method/frappe.integrations.oauth2.authorize?client_id=$clientId&response_type=code&grant_type=Authorization Code&redirect_uri=$redirectUri";

    try {
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl, callbackUrlScheme: 'myapp',
      );
      log("Result${result}");

      token = "Result${result}";
      // final token = Uri.parse(result);
      // log("Token${token}");
      print(result);
    } catch (e) {
      log(e.toString());
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Token $token"),
            TextButton(
              child: const Text("Oauth"),
              onPressed: () {
                _authenticate();
              },
            ),
          ],
        ),
      ),
    );
  }
}


Future authenticateWeb() async {
  final oauth = OAuth(
      clientId: '8f4562b21a',
      clientSecret: '8d1af1363a',
      tokenUrl:
      'https://demo.extensionerp.com/api/method/frappe.integrations.oauth2.authorize?client_id=8f4562b21a&response_type=code&grant_type=Authorization%20Code&redirect_uri=https://demo.extensionerp.com/login');

  oauth
      .requestToken(
      PasswordGrant(username: 'Administrator', password: 'admin1234'))
      .then((token) {
    log('AccessToken: ${token.accessToken}');
    log('RefreshToken: ${token.refreshToken}');
    log('Expiration: ${token.expiration}');
  });
}