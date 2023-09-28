import 'package:flutter/material.dart';
import 'package:fluttertest/login/loginUser.dart';
import 'config/appStorage.dart';
import 'util/util.dart';
import 'asset/assetCountingPage.dart';
import 'login/loginUtil.dart';

void main() {
  runApp(const MyApp(key: Key('main')));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const LoginPage(key: Key('loginPage')),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await login(_usernameController.text, _passwordController.text);
      LoginUser? loginUser;
      loginUser=await retrieveLoginUser() ;
      if (loginUser != null) {
       showMessage(loginUser.username);
      }

      navToCounterPage();
    } on Exception catch (e) {
      showMessage(getMessageFromException(e));
    }
  }

  void navToCounterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AssetCountingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('固資盤點作業'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: '帳號',
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                // Set focus on the password field when the user enters their username
                FocusScope.of(context).nextFocus();
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '密碼',
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                _login();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('登入'),
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }
}
