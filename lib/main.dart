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
    return MaterialApp(home: HomeScreen());
  }

// void _handleOAuthCallback(OAuthResponse response) {
//   if (response.isSuccess) {
//     // Authentication successful, handle the token
//     print('Access Token: ${response.accessToken}');
//     // Add your logic for further actions after successful authentication
//   } else {
//     // Authentication failed, handle error
//     print('Error: ${response.error}');
//     // Add your error handling logic
//   }
// }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child:const Text("Oauth"),
          onPressed: () {


        _authenticate();
        //     authenticateWeb();

          },
        ),
      ),
    );
  }
}

Future<void> _authenticate() async {
  final clientId = '8f4562b21a';
  final redirectUri =
      'https://flutterwebauth.vercel.app/'; // Should match the setup in Zoho Developer Console
  final authUrl =
      "https://demo.extensionerp.com/api/method/frappe.integrations.oauth2.authorize?client_id=$clientId&response_type=code&grant_type=Authorization Code&redirect_uri=$redirectUri";

  try {
    final result = await FlutterWebAuth2.authenticate(
      url: authUrl, callbackUrlScheme: 'z',
    );
    log("Result${result}");
    print(result);
  } catch (e) {
    log(e.toString());
    print('Error: $e');
  }
}


Future authenticateWeb()async{
  final oauth = OAuth(
      clientId: '8f4562b21a',
      clientSecret: '8d1af1363a',
      tokenUrl:
          'https://demo.extensionerp.com/api/method/frappe.integrations.oauth2.authorize?client_id=8f4562b21a&response_type=code&grant_type=Authorization%20Code&redirect_uri=https://demo.extensionerp.com/login');

  oauth
      .requestToken(PasswordGrant(username: 'Administrator', password: 'admin1234'))
      .then((token) {
    log('AccessToken: ${token.accessToken}');
    log('RefreshToken: ${token.refreshToken}');
    log('Expiration: ${token.expiration}');
  });

}