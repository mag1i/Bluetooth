import 'package:dntst/profile.dart';
import 'package:dntst/repository.dart';
import 'package:dntst/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin.dart';
import 'main.dart';

class login extends StatefulWidget {
 // login({Key? key, }) : super(key: key);
final Repository dbConnection;

  const login({required this.dbConnection});

  @override
  _loginState createState() => _loginState();
}
class _loginState extends State<login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late Admin? loggedInAdmin;
  String _errorMessage = '';
  Repository rep=Repository();

  void logout() {
    setState(() {
      loggedInAdmin = null; // Set loggedInAdmin to null to go back to the login screen
    });
  }
  List<Admin?> admnslst = [];
 getAlladmns() async {
   var users = await rep.readData("admin");

   users.forEach((user) {
     setState(() {
       var userModel = Admin();
       userModel.id = user['id'];
       userModel.name = user['name'];
       userModel.email = user['email'];
       userModel.phone = user['phone'];
       userModel.password = user['password'];
       admnslst.add(userModel);
     });
   });}
  bool _validateemail= false;
  bool _validatepw= false;
  bool _validatepwtrue= false;
   @override
   void initState() {
     getAlladmns();
     super.initState();
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(

       body: Center(
       child: SizedBox(
         width: 400,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(
               'Login',
               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
             ),
             SizedBox(height: 20),


             TextField(
               controller: _emailController,
               decoration: InputDecoration(
                 labelText: 'Email',
                 errorText: _validateemail? "Se email n'existe pas dans ce programme":null,
               ),
             ),
             SizedBox(height: 10),
             TextField(
               controller: _password,
               obscureText: true,
               decoration: InputDecoration(
                 labelText: 'Password',
                 errorText: _validatepwtrue? "Mot de pass erronee":null,
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
                 // Login with admin credentials
                 var admn = admnslst.where((m) {
                   return m!.email == _emailController.text;
                 });

       setState(() {


         admn==null || admn.isEmpty    ? _validateemail= true
             : _validateemail = false;
         _password.text.isEmpty    ? _validatepw = true
             : _validatepw = false;
         if(_validateemail==false)
         admn.isNotEmpty ? admn.first!.password != _password.text ? _validatepwtrue = true : _validatepwtrue = false : _validatepwtrue = true;       });

       if (_validatepwtrue == false &&
           _validateemail == false
       ) {
        // final loggedInAdmin = await rep.login(_emailController.text, _password.text);
       await rep.login(_emailController.text, _password.text);


         if (admn!.first != null && admn.first!.password == _password.text) {
           final prefs = await SharedPreferences.getInstance();
           await prefs.setString('email', _emailController.text);
           Navigator.push(
               context, MaterialPageRoute(builder: (context) =>
               ProfilePage(admin: admn!.first!,
                 onLogout: logout,)));
           print('Admin logged in successfully.');
           // Navigate to sign up screen
         }

         else {
           print(_emailController.text);
         };
       }  },

               child: Text('Log in'),
             ),
             SizedBox(height: 10),
             TextButton(
               onPressed: () async {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => signup()));
               },
               // Navigator.push( context, MaterialPageRoute( builder: (context) => addpts()));
               child: Text('Create an account'),
             ),
           ],
         ),
       ),
     ),);
   }}
