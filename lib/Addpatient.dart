import 'dart:typed_data';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dntst/profile.dart';
import 'package:dntst/repository.dart';

import 'package:flutter/material.dart';
import 'Patient.dart';
import 'admin.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';


class addpts extends StatefulWidget {
  final Admin admin;
  final Function() onLogout;
  const addpts({Key? key, required this.admin, required this.onLogout,}) : super(key: key);

  @override
  State<addpts> createState() => _addptsState();
}

class _addptsState extends State<addpts> {
  var control= TextEditingController();

  var _nameController = TextEditingController();
  var _birthController = TextEditingController();
  var _emailController = TextEditingController();
  var _addressController = TextEditingController();
  var _phoneController = TextEditingController();
  var _insController = TextEditingController();

  bool _validateName= false;
  bool _validaterobe = false;


  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Male"),value: "Male"),
      DropdownMenuItem(child: Text("Female"),value: "Female"),

    ];
    return menuItems;
  }
  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  late String selectedValue = "Male";
  late String date =DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    int _selectedIndex=0;
    return  Scaffold(
      appBar:  AppBar( title: Text('Ajouter un patient')),


      body:Container(
          //height:780,
      //  width: 415,*/
       // color: Color(0xFFEEEEEE),

     //   decoration: BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/f.jpg")) ),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: SingleChildScrollView(child:
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          SizedBox(width: 10,),
    Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),

            // child: Ink.image(image: AssetImage("images/f.png"), height:80, width:80, fit: BoxFit.cover))),
            SizedBox(height: 10,),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                width: 500,
                child:

                TextField(


                  decoration: InputDecoration(

                      hintText: 'Enter le nom et prenom',
                      labelText: 'Nom et Prenom',
                      errorText:
                      _validateName ? 'La valeur du nom ne peut pas être vide' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,  color:Color(0xFF6D4C41))),
                      labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                  keyboardType: TextInputType.multiline,

                  /* decoration: InputDecoration(
            hintText: widget.nt.content,

          ),*/

                  controller: _nameController,
                  onChanged: (value) {
                    // widget.nt.title = value;
                    //  rep.updatNote( widget.nt.id,   widget.nt.content);

                  },
                  maxLines: 1,
                )),
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 500,
                child:
                TextField(


                  decoration: InputDecoration(

                      hintText: 'Entrer le numéro de téléphone',
                      labelText: 'Téléphone',
                      errorText:
                      _validaterobe ? 'le numéro de téléphone ne peut pas être vide' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,  color:Color(0xFF6D4C41))),
                      labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                  keyboardType: TextInputType.multiline,

                  /* decoration: InputDecoration(
            hintText: widget.nt.content,

          ),*/

                  controller: _phoneController,
                  onChanged: (value) {
                    // widget.nt.title = value;
                    //  rep.updatNote( widget.nt.id,   widget.nt.content);

                  },
                  maxLines: 1,
                )),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                width: 500,
                child:


                DateTimePicker(
                  initialValue: '',
                  firstDate: DateTime(1800),
                  lastDate: DateTime(2100),
                  cursorColor: Colors.deepPurpleAccent,
                  dateLabelText: 'Date de naissance',
                  onChanged: (val) =>date=DateTime.parse(val as String).toString(),
                  validator: (val) {
                    print(val);
                    date=DateTime.parse(val as String) as String;
                    return null;
                  },
                  //onSaved: (val) => print(val),
                  onSaved: (val) =>   date=DateTime.parse(val as String) as String,
                ) ),

            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 500,
                child:
                TextField(


                  decoration: InputDecoration(

                      hintText: 'Entrer l\'adresse',
                      labelText: 'Adresse',
                      //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,  color:Color(0xFF6D4C41))),
                      labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                  keyboardType: TextInputType.multiline,
                  controller: _addressController,
                  onChanged: (value) {
                  },
                  maxLines: 1,
                )),
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 500,
                child:
                TextField(


                  decoration: InputDecoration(

                      hintText: 'Enterl\'email',
                      labelText: 'Email',
                      //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,  color:Color(0xFF6D4C41))),
                      labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                  keyboardType: TextInputType.multiline,
                  controller: _emailController,
                  onChanged: (value) {
                    // widget.nt.title = value;
                    //  rep.updatNote( widget.nt.id,   widget.nt.content);

                  },
                  maxLines: 1,
                )),
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 500,
                child:
                TextField(


                  decoration: InputDecoration(

                      hintText: 'Entrer les informations d\'assurance',
                      labelText: 'Assurance',
                      //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,  color:Color(0xFF6D4C41))),
                      labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                  keyboardType: TextInputType.multiline,
                  controller: _insController,
                  onChanged: (value) {
                    // widget.nt.title = value;
                    //  rep.updatNote( widget.nt.id,   widget.nt.content);

                  },
                  maxLines: 1,
                )),
            Container(
                padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                width: 500,
                child:
                DropdownButton(
                    value: selectedValue,

                    onChanged: (String? newValue){
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems

                )
            ),

            //      SizedBox(height: 30,),

            Container(
                padding: EdgeInsets.fromLTRB(40, 20, 10, 10),
                width: 290,
                child:
                TextButton(
                    style: ElevatedButton.styleFrom(
                      // primary: pickerColor,
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 15,  color:Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.only(
                            left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),

                    onPressed: ()  async {
                      setState(() {
                        _nameController.text.isEmpty    ? _validateName = true
                            : _validateName = false;
                        _phoneController.text.isEmpty    ? _validaterobe = true
                            : _validaterobe = false;
                      });
                      if (_validateName == false &&
                          _validaterobe == false
                      ) {
                        var pt = new Patient();
                        //Get collection count:

                      //  pt.id= 9;
                        pt.name = _nameController.text;
                        pt.address = _addressController.text;
                        pt.phone = _phoneController.text;
                        pt.email =  _emailController.text;
                        pt.birth = date.substring(0,10);
                        pt.gender = selectedValue;
                        pt.insurance = _insController.text;


                        Repository rep= new Repository();

                       await rep.insertData("patients", pt.catMap());

                        Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout, )));
                    }
  },
                    //}},
                    child: const Text('Valider', style: TextStyle( color:Colors.white),))),
          ],
        ),
            Container(
              height:650,
              width: 700,
                // color: Color(0xFFEEEEEE),

              decoration: BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/f.jpg")) ),
              child: Ink.image(image: AssetImage("images/f.jpg"), height:650, width:700, fit: BoxFit.cover),
            )])),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
