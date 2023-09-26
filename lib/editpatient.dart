import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dntst/Patient.dart';
import 'package:dntst/profile.dart';
import 'package:dntst/repository.dart';
import 'package:flutter/material.dart';

import 'admin.dart';

class Editpt extends StatefulWidget {
  final Patient pt;
  final Admin admin;
  final Function() onLogout;

  const Editpt({Key? key,required this.pt, required this.admin, required this.onLogout}) : super(key: key);

  @override
  State<Editpt> createState() => _EditpatState();
}


class _EditpatState extends State<Editpt> {
  //List<Cat>? cat;
  var _nameController = TextEditingController();
  var _birthController = TextEditingController();
  var _emailController = TextEditingController();
  var _insController = TextEditingController();
  var _phoneController = TextEditingController();
  var _addressController = TextEditingController();
  late String selectedValue = widget.pt.gender as String;
  bool _validateName= false;
  bool _validaterobe = false;
  bool _validaterace = false;
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Male"),value: "Male"),
      DropdownMenuItem(child: Text("Female"),value: "Female"),

    ];
    return menuItems;
  }

/*  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  late String img=" ";
  openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if(pickedFile != null){
        imagepath = pickedFile.path;
        print(imagepath);
        //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg

        File imagefile = File(imagepath); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes);

        img=base64string;
        Uint8List decodedbytes = base64.decode(base64string);

        //decode base64 stirng to bytes

        setState(() {

        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }*/

  @override
  void initState() {
    setState(() {
      _nameController.text = widget.pt.name?? "";
      _birthController.text =  widget.pt.birth?? "";
      _emailController.text = widget.pt.email?? "";
      _insController.text =  widget.pt.insurance?? "";
      _phoneController.text =  widget.pt.phone?? "";
      _addressController.text =  widget.pt.address?? "";
      //img= widget.ct.image as String;

      // _userlblController=widget.op.date?? DateTime.now().toString().substring(0,10);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar( title: Text('Modifer les information de patient '+(widget.pt.name as String))),

      body:   SingleChildScrollView(child:Container(
        //  height:780,

        color: Color(0xFFEEEEEE),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.


        child:Center( child: Container(
            padding: EdgeInsets.fromLTRB(40, 60, 40, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



            /*    Container(
                    decoration: img==" "? BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/ct.png")) ):BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image: MemoryImage(base64.decode(img)),) ) ,
                    width: 80,
                    height: 80,
                    child:  InkWell(

                        splashColor:Color(0xFFEEEEEE),
                        onTap:(){
                          openImage();
                        },
                        child: Text("+", style: TextStyle(fontSize: 20),))),*/
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Nom',
                      labelText: 'Nom',
                      errorText:
                      _validateName ? 'Nom ne peut pas etre vide' : null,
                    )),
                const SizedBox(
                  height: 20.0,
                ),

                TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter le numero de telephone',
                      labelText: 'Telephone',

                    )),
                const SizedBox(
                  height: 20.0,
                ),

                TextField(
                    controller: _birthController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter date de naissance',
                      labelText: 'Date de naissance',

                    )),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter address',
                      labelText: 'address',

                    )),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter email',
                      labelText: 'email',

                    )),

                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                    controller: _insController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter assurance',
                      labelText: 'assurance',

                    )),
                const SizedBox(
                  height: 20.0,
                ),


                const SizedBox(
                  height: 20.0,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                    width: 290,
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

                const SizedBox(
                  height: 20.0,
                ),



                const SizedBox(
                  height: 20.0,
                ),//Checkbox
                Row(
                  children: [
                    const SizedBox(
                      width: 80.0,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(fontSize: 15)),
                        onPressed: () {
                          _nameController.text = '';
                          _emailController.text = '';
                          _insController.text = '';
                          _birthController.text = '';
                          _addressController.text = '';
                          _phoneController.text = '';

                        },
                        child: const Text('Efaccer tout')),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.teal,
                            textStyle: const TextStyle(fontSize: 15)),
                        onPressed: () async {
                          setState(() {

                            _nameController.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;

                          });
                          if (_validateName == false
                             ) {
                            // print("Good Data Can Save");
                            var pt = new Patient();
                            pt.id=widget.pt.id;
                            pt.address= _addressController.text;
                            pt.name = _nameController.text;
                            pt.phone = _phoneController.text;
                            pt.email = _emailController.text;
                            pt.birth = _birthController.text;
                           // pt.image =img;
                            pt.gender=selectedValue;
                            pt.insurance = _insController.text;
                            Repository rep= new Repository();
                              await rep.updateData("patients", pt.catMap());
                            Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout, )));
                          }
                        },
                        child: const Text('Modifie')),
                  ],
                ),

              ],
            ))),
      ),
      ),
    );
  }
}