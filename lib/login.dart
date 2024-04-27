import 'package:flutter/material.dart';
import 'package:location_based_reminder/app_colors.dart';

import 'auth_service.dart'; // Import the AuthService class
import 'taskpage.dart'; // Import the task page

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                backgroundColor:AppColor.secondaryColor2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                // Call the signInWithEmailAndPassword method from AuthService
                await _authService.signInWithEmailAndPassword(email, password);

                // Navigate to the task page after successful login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskPage()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
