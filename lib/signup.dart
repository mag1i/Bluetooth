import 'package:dntst/profile.dart';
import 'package:dntst/repository.dart';
import 'package:flutter/material.dart';
import 'admin.dart';
import 'login.dart';
import 'main.dart';

class signup extends StatefulWidget {
  signup({Key? key, }) : super(key: key);

  @override
  _signupState createState() => _signupState();
}
class _signupState extends State<signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordconf = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  Admin? loggedInAdmin;
  String _errorMessage = '';
  Repository rep=Repository();
  @override
  void initState() {
    super.initState();}
  void logout() {
    setState(() {
      loggedInAdmin = null; // Set loggedInAdmin to null to go back to the login screen
    });
  }
  bool _validateemail= false;
  bool _validatepw= false;
  bool _validatepwcnf= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bluetooth')),
      body: Center(
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Signup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phone,
              decoration: InputDecoration(
                labelText: 'Numero Tel',
              ),
            ),
            SizedBox(height: 10),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _validateemail? "Ne peut pas etre vide":null,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _validatepw? "Ne peut pas etre vide":null,
              ),
            ),
            TextField(
              controller: _passwordconf,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Conformer Password',
                errorText: _validatepwcnf? "Mot de pass differents": null,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
      setState(() {
        _emailController.text.isEmpty    ? _validateemail = true
            : _validateemail = false;
        _password.text.isEmpty    ? _validatepw = true
            : _validatepw = false;
        _password.text!= _passwordconf.text    ? _validatepwcnf = true
            : _validatepwcnf = false;
      });
      if (_validateemail == false &&
          _validatepw == false && _validatepwcnf== false
      ) {
        final newAdmin = Admin(
          name: _name.text,
          phone: _phone.text,
          email: _emailController.text,
          password: _password.text,
        );
        await rep.signUpAdmin(newAdmin);
        print('Admin signed up successfully.');


      // Login with admin credentials
      final loggedInAdmin = await rep.login(newAdmin.email.toString(), newAdmin.password.toString());

      if (loggedInAdmin != null) {
        Navigator.push( context, MaterialPageRoute( builder: (context) =>
            ProfilePage( admin: newAdmin ,onLogout: logout,)));
        print('Admin logged in successfully.');
        // Navigate to sign up screen
      }};},

              child: Text('Sign in'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () async {               Navigator.push( context, MaterialPageRoute( builder: (context) => login(dbConnection: rep)));
              },

              child: Text('Log in'),
            ),
          ],
        ),
      ),
    ),);}
}