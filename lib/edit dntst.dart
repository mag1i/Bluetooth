import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dntst/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dentists list.dart';
import 'dntsts.dart';

class Editdnt extends StatefulWidget {
  final Dentists pt;
  final String isadmn;
  const Editdnt({Key? key,required this.pt, required this.isadmn}) : super(key: key);

  @override
  State<Editdnt> createState() => _EditdntState();
}


class _EditdntState extends State<Editdnt> {
  //List<Cat>? cat;

  var _nameController = TextEditingController();
  var _specializationController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _adressController = TextEditingController();
  var _desc = TextEditingController();
  late String selectedValue = widget.pt!.Availability as String;
  bool _validateName= false;

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Oui"),value: "Oui"),
      DropdownMenuItem(child: Text("Non"),value: "Non"),

    ];
    return menuItems;
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

  @override
  void initState() {

    setState(() {
      _nameController.text = widget.pt!.name?? "";
      _specializationController.text =  widget.pt!.specialization?? "";
      _emailController.text = widget.pt!.email?? "";
      _desc.text =  widget.pt!.desc?? "";
      _phoneController.text =  widget.pt!.phone?? "";
      _adressController.text =  widget.pt!.adress?? "";
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



                    Container(
                    decoration: widget.pt.image==" "? BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/ct.png")) ):BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image: MemoryImage(base64.decode(widget.pt.image as String)),) ) ,
                    width: 100,
                    height: 100,
                    child:  InkWell(

                        splashColor:Color(0xFFEEEEEE),
                        onTap:(){
                          openImage();
                        },
                        child: Text("+", style: TextStyle(fontSize: 20),))),
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
                    controller: _specializationController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter la speciality',
                      labelText: 'Date la speciality',

                    )),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                    controller: _adressController,
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
                    controller: _desc,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter description',
                      labelText: 'description',

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
               widget.isadmn=='yes'? Row(
                  children: [
                    const SizedBox(
                      width: 80.0,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(fontSize: 15)),
                        onPressed: () {
                          _nameController.text = "";
                          _specializationController.text = "";
                          _emailController.text ="";
                          _desc.text =   "";
                          _phoneController.text =   "";
                          _adressController.text = "";
                          img="";

                        },
                        child: const Text('Effacer tout')),
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
                            var pt =  Dentists();
                            pt.id=widget.pt.id;
                            pt.adress= _adressController.text;
                            pt.name = _nameController.text;
                            pt.phone = _phoneController.text;
                            pt.email = _emailController.text;
                            pt.specialization = _specializationController.text;
                            pt.image =img;
                            pt.Availability=selectedValue;
                            Repository rep= new Repository();
                            await rep.updateData("dentists", pt.DentistsMap());
                            Navigator.push( context, MaterialPageRoute( builder: (context) => DentistsScreen()));
                          }
                        },
                        child: const Text('Modifie')),
                  ],
                ): Container(),

              ],
            ))),
      ),
      ),
    );
  }
}