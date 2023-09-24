import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    final String username = _usernameController.text.trim();
    final RegExp emailRegex =
        RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');

    if (!emailRegex.hasMatch(username)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('非正確的Email格式！'),
            content: Text('請輸入正確的Email.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ],
          );
        },
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('登入成功'),
          content: Text('您已成功登入系統.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _usernameController.clear();
                _passwordController.clear();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ],
        );
      },
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
                _submit();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('登入'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
