

import 'dart:convert';

import 'package:dntst/repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adddntst.dart';
import 'dntsts.dart';
import 'edit dntst.dart';

class DentistsScreen extends StatefulWidget {
  DentistsScreen({Key? key, }) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<DentistsScreen> {
  late List<Dentists> dentistsList = <Dentists>[];
  final rep = Repository();
  late Dentists ct= Dentists();
  late int ss=0;
  late String isadmn="";
  adminlog() async {
    final prefs = await SharedPreferences.getInstance();
    isadmn=  prefs.getString('isadmin')!;
    return isadmn;
  }
  getDntsts() async {
    //var users = await FirebaseFirestore.instance.collection('cats').document().get();
    var users = await rep.readData("dentists");
    dentistsList = <Dentists>[];
    users.forEach((user) {
      setState(() {
        var userModel = Dentists();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.email = user['email'];
        userModel.adress = user['adress'];
        userModel.specialization = user['specialization'];
        userModel.desc = user['desc'];
        userModel.Availability = user['Availability'];
        userModel.phone = user['phone'];
        userModel.image = user['image'];
        dentistsList.add(userModel);
      });
    });

  }

  @override
  void initState() {
    adminlog();
    getDntsts();
    // print(catsList.first.name.toString());
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    _deleteFormDialog(catId) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {

            final _categoryController = TextEditingController();
            return AlertDialog(
              title: const Text(
                'Sure? ',
                style: TextStyle(color:Color(0xFF6D4C41), fontSize: 20),            ),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white, // foreground
                        backgroundColor: Colors.red),
                    onPressed: ()  async{

                      var result= rep.deleteDataById("dentists", catId);
                      if (result != null) {
                        Navigator.pop(context);
                        getDntsts();
                        _showSuccessSnackBar('Dentist supprime'); }

                    },
                    child: const Text('Suporimer')),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white, // foreground
                        backgroundColor: Colors.teal),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'))
              ],
            );
          });
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {  Navigator.push(context,  MaterialPageRoute(  builder: (context) => adddntst())); },

      ),
      appBar: AppBar(

        title: Text('Dentists'),
      ),
      body: ListView.builder(
        itemCount: dentistsList.length,
        itemBuilder: (context, index) {
          Dentists dentist = dentistsList[index];
          return ListTile(
           title: Column( children: [  Container(

           decoration:  dentistsList[index].image==" "? BoxDecoration(image:DecorationImage( image:AssetImage("images/ct.png"), fit: BoxFit.cover) ):BoxDecoration(image:DecorationImage(image: MemoryImage(base64.decode( dentistsList[index].image as String),  ), fit: BoxFit.cover, ), ) ,

          width: 110,
          height: 110,




          ),  SizedBox(width: 10,),Text(dentist.name ?? '', style: TextStyle(fontWeight: FontWeight.bold),),]),
            onTap: ()  {
            Navigator.push( context, MaterialPageRoute( builder: (context) => Editdnt(pt:dentist, isadmn: isadmn ,)));
           //   print(dentist.name);
              },
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Specialization: ${dentist.specialization ?? ''}'),
                Text('Email: ${dentist.email ?? ''}'),
                Text('Phone: ${dentist.phone ?? ''}'),
                Text('Address: ${dentist.adress ?? ''}'),
                Text('Availability: ${dentist.Availability ?? ''}'),
                Text('Description: ${dentist.desc ?? ''}'),
              ],
            ),
            trailing: isadmn=="yes"? IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteFormDialog(dentist.id);
              },
            ):null,

        );
        },
      ),
    );
  }
}