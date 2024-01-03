import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthWebView extends StatefulWidget {
  @override
  _AuthWebViewState createState() => _AuthWebViewState();
}

class _AuthWebViewState extends State<AuthWebView> {

  final String authorizationUrl = 'https://demo.extensionerp.com/api/method/frappe.integrations.oauth2.authorize?client_id=8f4562b21a&response_type=code&grant_type=Authorization Code&redirect_uri=https://flutterwebauth.vercel.app/';
  final String redirectUri = 'https://flutterwebauth.vercel.app/';

  Future<void> _launchUrl() async {
    if (await canLaunch(authorizationUrl)) {
      await launch(authorizationUrl, forceSafariVC: false);
    } else {
      throw 'Could not launch $authorizationUrl';
    }
  }

  Future<void> handleRedirect(String redirectedUrl) async {
    if (redirectedUrl.startsWith(redirectUri)) {
      // Extract authorization code from the redirected URL
      Uri responseUri = Uri.parse(redirectedUrl);
      String? code = responseUri.queryParameters['code'];

      // Make a token request to exchange the code for an access token
      final tokenResponse = await http.post(
        Uri.parse('https://demo.extensionerp.com/api/method/frappe.integrations.oauth2.get_token'),
        body: {
          'code': code,
          'grant_type': 'authorization_code',
          'client_id': '8f4562b21a',
          'client_secret': '8d1af1363a',
          'redirect_uri': redirectUri,
        },
      );

      if (tokenResponse.statusCode == 200) {
        // Handle the response from the token endpoint
        final Map<String, dynamic> responseData = jsonDecode(tokenResponse.body);
        final String accessToken = responseData['access_token'];

        // Store the access token securely
        const storage = FlutterSecureStorage();
        await storage.write(key: 'access_token', value: accessToken);

        // Navigate to the main app screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Handle token request error
        print('Token request failed: ${tokenResponse.reasonPhrase}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OAuth Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchUrl,
          child: Text('Login with OAuth'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
