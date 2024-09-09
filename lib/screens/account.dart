import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoggedIn = false;
  String _email = '';

  // Simulate login
  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoggedIn = true;
        _email = _emailController.text;
      });
    }
  }

  // Logout function
  void _logout() {
    setState(() {
      _isLoggedIn = false;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoggedIn ? _buildLoggedInUI() : _buildLoginForm(),
      ),
    );
  }

  // Login form
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  // UI when logged in
  Widget _buildLoggedInUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.account_circle,
          size: 100,
          color: Colors.blue,
        ),
        SizedBox(height: 20),
        Text(
          'Welcome, $_email',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _logout,
          child: Text('Logout'),
        ),
      ],
    );
  }
}
