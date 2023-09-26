
import 'dart:typed_data';
import 'package:dntst/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dentists list.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/widgets.dart';

import 'dntsts.dart';

class adddntst extends StatefulWidget {
  const adddntst({Key? key,}) : super(key: key);

  @override
  State<adddntst> createState() => _adddntstState();
}

class _adddntstState extends State<adddntst> {
  var control= TextEditingController();


  var _nameController = TextEditingController();
  var _specializationController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _adressController = TextEditingController();
  var _desc = TextEditingController();

  bool _validateName= false;
  bool _validaterobe = false;


  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Oui"),value: "Oui"),
      DropdownMenuItem(child: Text("Non"),value: "Non"),

    ];
    return menuItems;
  }
  late String selectedValue = "Oui";
  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }


  final ImagePicker imgpicker = ImagePicker();

  String imagepath = "";
  late String img=" ";
  openImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        Uint8List imageBytes = await file.readAsBytes();
        String base64String = base64.encode(imageBytes);

        img=base64String;
        Uint8List decodedbytes = base64.decode(base64String);

        setState(() {
          // Update your state variables if needed
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("Error while picking file: $e");
    }
  }
/*
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
        //convert bytes to base64 string
        //   print(base64string+"nnnnnnnnnnnnnnnnnnnnnnnnnn");
        /* Output:
              /9j/4Q0nRXhpZgAATU0AKgAAAAgAFAIgAAQAAAABAAAAAAEAAAQAAAABAAAJ3
              wIhAAQAAAABAAAAAAEBAAQAAAABAAAJ5gIiAAQAAAABAAAAAAIjAAQAAAABAAA
              AAAIkAAQAAAABAAAAAAIlAAIAAAAgAAAA/gEoAA ... long string output
              */
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
  Widget build(BuildContext context) {
    int _selectedIndex=0;
    return  Scaffold(
      appBar: AppBar(title: Text("Ajouter un dentiste",)),


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
                  Container(
                      decoration: img==" "? BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/ct.png")) ):BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image: MemoryImage(base64.decode(img)),) ) ,

                      width: 200,
                      height: 180,
                      child:  InkWell(

                          splashColor: Color(0xFFFFD600),
                          onTap:(){
                            openImage();
                          },
                          child: Text("+", style: TextStyle(fontSize: 20),))),
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
                            _validaterobe ? 'Numero de telephone ne peut pas être vide' : null,
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
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: 500,

                      child:
                      TextField(


                        decoration: InputDecoration(

                            hintText: 'Enter date la specialite',
                            labelText: 'specialite',
                            //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,  color:Color(0xFF6D4C41))),
                            labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                        keyboardType: TextInputType.multiline,

                        /* decoration: InputDecoration(
            hintText: widget.nt.content,

          ),*/

                        controller: _specializationController,
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

                            hintText: 'Entrer l\'adresse',
                            labelText: 'Adresse',
                            //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,  color:Color(0xFF6D4C41))),
                            labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                        keyboardType: TextInputType.multiline,
                        controller: _adressController,
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

                            hintText: 'Entrer une petite description ou note',
                            labelText: 'Description',
                            //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,  color:Color(0xFF6D4C41))),
                            labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                        keyboardType: TextInputType.multiline,
                        controller: _desc,
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
                              var dnt = new Dentists();
                              //Get collection count:

                              //  pt.id= 9;
                              dnt.name = _nameController.text;
                              dnt.email = _emailController.text;
                              dnt.phone = _phoneController.text;
                              dnt.adress =  _adressController.text;
                              dnt.specialization = _specializationController.text;
                              dnt.desc = _desc.text;
                              dnt.Availability= selectedValue;
                              dnt.image= img;



                              Repository rep= new Repository();
                              var result = await rep.insertData("dentists", dnt.DentistsMap());

                              Navigator.push( context, MaterialPageRoute( builder: (context) => DentistsScreen()));
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
