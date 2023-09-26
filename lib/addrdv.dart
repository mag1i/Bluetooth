import 'dart:ffi';
import 'dart:typed_data';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dntst/rdv%20display.dart';
import 'package:dntst/rdv.dart';
import 'package:dntst/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/widgets.dart';

import 'Patient.dart';
import 'admin.dart';
import 'dntsts.dart';


class addrdv extends StatefulWidget {
  final Patient pt;
  final Admin admin;
  final Function() onLogout;
  const addrdv({Key? key, required this.pt, required this.admin, required this.onLogout,}) : super(key: key);

  @override
  State<addrdv> createState() => _addrdvState();
}

class _addrdvState extends State<addrdv> {

  final _formKey = GlobalKey<FormState>();
  late List<Dentists> _dentists=  <Dentists>[];
  late Dentists _selectedDentist=Dentists();

  @override
  void initState() {
    super.initState();
    _loadDentists();
  }

  Future<void> _loadDentists() async {
    final repository = Repository();
    final dentists = await repository.getDentists();
    setState(() {
      _dentists = dentists;
      _selectedDentist = dentists[0]; // Set the default selected dentist
    });
  }



  var control= TextEditingController();
  List<TextField> textFields = [];
//  List<Container> cnt = [];

  String allTextFieldsText = '';
  List<String?> selectedValues = ['11','', '12','13','14','kk' ];
  var _casController = TextEditingController();
  var _trtController = TextEditingController();
  var _noteController = TextEditingController();
  var _payController = TextEditingController();
  late int min= 13;
  late int hr= 10;
  List<DropdownMenuItem<String>> get dropdownteeth{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("11"),value: "11"),
      DropdownMenuItem(child: Text("12"),value: "12"),
      DropdownMenuItem(child: Text("13"),value: "13"),
      DropdownMenuItem(child: Text("14"),value: "14"),
      DropdownMenuItem(child: Text("15"),value: "15"),
      DropdownMenuItem(child: Text("16"),value: "16"),
      DropdownMenuItem(child: Text("17"),value: "17"),
      DropdownMenuItem(child: Text("18"),value: "18"),
      DropdownMenuItem(child: Text("19"),value: "19"),
      DropdownMenuItem(child: Text("20"),value: "20"),
      DropdownMenuItem(child: Text(""),value: ""),
      DropdownMenuItem(child: Text("21"),value: "21"),
      DropdownMenuItem(child: Text("22"),value: "22"),
      DropdownMenuItem(child: Text("23"),value: "23"),
      DropdownMenuItem(child: Text("24"),value: "24"),
      DropdownMenuItem(child: Text("25"),value: "25"),
      DropdownMenuItem(child: Text("26"),value: "26"),
      DropdownMenuItem(child: Text("27"),value: "27"),
      DropdownMenuItem(child: Text("28"),value: "28"),
      DropdownMenuItem(child: Text("29"),value: "29"),
      DropdownMenuItem(child: Text("30"),value: "30"),
      DropdownMenuItem(child: Text("31"),value: "31"),
      DropdownMenuItem(child: Text("32"),value: "32"),
      DropdownMenuItem(child: Text("33"),value: "33"),
      DropdownMenuItem(child: Text("34"),value: "34"),
      DropdownMenuItem(child: Text("35"),value: "35"),
      DropdownMenuItem(child: Text("36"),value: "36"),
      DropdownMenuItem(child: Text("37"),value: "37"),
      DropdownMenuItem(child: Text("38"),value: "38"),
      DropdownMenuItem(child: Text("39"),value: "39"),
      DropdownMenuItem(child: Text("40"),value: "40"),
      DropdownMenuItem(child: Text("41"),value: "41"),
      DropdownMenuItem(child: Text("42"),value: "42"),
      DropdownMenuItem(child: Text("43"),value: "43"),
      DropdownMenuItem(child: Text("44"),value: "44"),
      DropdownMenuItem(child: Text("45"),value: "45"),
      DropdownMenuItem(child: Text("46"),value: "46"),
      DropdownMenuItem(child: Text("47"),value: "47"),
      DropdownMenuItem(child: Text("48"),value: "48"),



    ];
    return menuItems;
  }
  late String selectedtooth = "11";
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
      min=_time.minute;
      hr=_time.hour;
    }
  }
late String st="";
  bool _validateName= false;
  bool _validaterobe = false;
  bool _validatepay = false;

  late String date =DateTime.now().toString();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: "Enregistre",
        child: Container(
          color: Color(0xFF90CAF9), // Set the color for the item
          child: Text("Enregistre"),
        ),
      ),
      DropdownMenuItem(
        value: "Absent",
        child: Container(
          color: Color(0xFFEF9A9A), // Set the color for the item
          child: Text("Absent"),
        ),
      ),
      DropdownMenuItem(
        value: "Pas Paye",
        child: Container(
          color: Color(0xFFFFE082), // Set the color for the item
          child: Text("Pas Paye"),
        ),
      ),
      DropdownMenuItem(
        value: "Paye",
        child: Container(
          color: Color(0xFFC5E1A5), // Set the color for the item
          child: Text("Paye"),
        ),
      ),
    ];
    return menuItems;
  }
  final ImagePicker imgpicker = ImagePicker();

  String imagepath = "";
  late String img1=" ";
  late String img2=" ";
  openImage1() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        Uint8List imageBytes = await file.readAsBytes();
        String base64String = base64.encode(imageBytes);

        img1=base64String;
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
  openImage2() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        Uint8List imageBytes = await file.readAsBytes();
        String base64String = base64.encode(imageBytes);

        img2=base64String;
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
  /*List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Enregisre"),value: "Enregisre"),
      DropdownMenuItem(child: Text("absent"),value: "absent"),
      DropdownMenuItem(child: Text("pas paye"),value: "pas paye"),
      DropdownMenuItem(child: Text("paye"),value: "paye"),

    ];
    return menuItems;
  }
  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }*/

  late String selectedValue = "Enregistre";


  @override
  Widget build(BuildContext context) {
    int _selectedIndex=0;
    return  Scaffold(
      appBar: AppBar(title: Text('Ajouter un Patient')),


      body:Container(
        //height:780,
        //  width: 415,*/
        // color: Color(0xFFEEEEEE),

        //   decoration: BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/f.jpg")) ),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: SingleChildScrollView(child:
      /*  Row(    mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[*/
    Container(
    //  height:780,

    color: Color(0xFFEEEEEE),

    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.

      child: Container(
    padding: EdgeInsets.fromLTRB(40, 60, 40, 10),
    child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  // child: Ink.image(image: AssetImage("images/f.png"), height:80, width:80, fit: BoxFit.cover))),

                  Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      width: 500,
                      child:


                  DateTimePicker(
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    cursorColor: Colors.deepPurpleAccent,
                    dateLabelText: 'La Date',
                    onChanged: (val) =>date=DateTime.parse(val as String).toString(),
                    validator: (val) {
                      print(val);
                      date=DateTime.parse(val as String) as String;
                      return null;
                    },
                    //onSaved: (val) => print(val),
                    onSaved: (val) =>   date=DateTime.parse(val as String) as String,
                  ) ),

                  SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            width: 500,

                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        _selectTime();
                        st= _time.toString();

                      },

                      decoration: InputDecoration(
                        hintText: st==""? 'Select Time':  _time.toString(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),

                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                      decoration: BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/tth.jpg")) ) ,
                      width: 500,
                      height:150,
                      child:  InkWell(

                        splashColor:Color(0xFFEEEEEE),
                        onTap:(){
                        },
                      )),
                  SizedBox(height:20,),

                  Row(children: [ Text("teeth:"),
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                      width: 100,
                      child:
                      DropdownButton(
                          value: selectedtooth,

                          onChanged: (String? newValue){
                            setState(() {
                              selectedtooth = newValue!;
                            });
                          },
                          items: dropdownteeth
                      ),
                    ),

                  ]),
                  TextField(
                      controller: _casController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Modifier Cas',
                        labelText: 'Cas',
                        errorText:
                        _validateName ? 'Cas ne peut pas etre vide' : null,

                      )),

                  const SizedBox(
                    height: 20.0,
                  ),
                Container(
                    width:50,
                    child:    ElevatedButton(
                      onPressed: ()
                      /*{
                        setState(() {
                        TextEditingController controller = TextEditingController();
                        TextField textField = TextField(controller: controller,
                        decoration: InputDecoration(
                            hintText: 'Cas',
                            border: OutlineInputBorder(),),);
                     /*   Container cc= Container(child:          Row(children: [ Text("teeth:"),
                          Container(
                            padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                            width: 100,
                            child:
                            DropdownButton(
                                value: selectedtooth,

                                onChanged: (String? newValue){
                                  setState(() {

                                    selectedtooth = newValue!;
                                  });
                                },
                                items: dropdownteeth
                            ),
                          ),

                        ]),);*/
                        textFields.add(textField);
                     //   cnt.add(cc);

                        // Update the allTextFieldsText whenever a new TextField is added
                        updateAllTextFieldsText();
                        });
                        },*/
                      {
                        {
                          setState(() {
                            TextEditingController controller = TextEditingController();
                            TextField textField = TextField(
                              controller: controller,

                              decoration: InputDecoration(
                                hintText: 'Cas',
                                border: OutlineInputBorder(),
                              ),
                            );
                            textFields.add(textField);

                            // Add an empty string as the initial selected value for the new dropdown
                            selectedValues.add('');

                            // Update the allTextFieldsText whenever a new TextField is added
                          });
                        }},
                      child: Text('+'),
                    ),),

                  SizedBox(height: 20),


                  /*    Column(
                  children: textFields.map((textField) => Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(children: [Row(children: [ Text("teeth:"),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                        width: 100,
                        child:
                        DropdownButton(
                            value: selectedtooth,

                            onChanged: (String? newValue){
                              setState(() {
                                selectedtooth = newValue!;
                              });
                            },
                            items: dropdownteeth
                        ),
                      ),

                    ]),textField, SizedBox(height:20),   ],),
                  )).toList(),
                ),*/
                  Column(
                    children: textFields.asMap().entries.map((entry) {
                      int index = entry.key;
                      TextField textField = entry.value;

                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("teeth:"),
                                Container(
                                  padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                                  width: 100,
                                  child: DropdownButton<String>(
                                      value: selectedValues[index], // Use the selected value for this dropdown
                                      onChanged: (String? newValue) {

                                        setState(() {
                                          selectedValues[index] = newValue!; // Update the selected value
                                        });
                                      },
                                      items: dropdownteeth
                                    /*.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toString() ,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),*/
                                  ),
                                ),
                              ],
                            ),
                            textField,
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                    }).toList(),
                  ),


                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: 500,
                      child:
                      TextField(


                        decoration: InputDecoration(

                            hintText: 'Enter le Traitement',
                            labelText: 'Traitement',
                            //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,  color:Color(0xFF6D4C41))),
                            labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                        keyboardType: TextInputType.multiline,
                        controller: _trtController,
                        onChanged: (value) {
                          // widget.nt.title = value;
                          //  rep.updatNote( widget.nt.id,   widget.nt.content);

                        },
                        //maxLines: 1,
                      )), SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: 500,
                      child:
                      TextField(


                        decoration: InputDecoration(

                            hintText: 'Entrer des notes',
                            labelText: 'Notes',
                            //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,  color:Color(0xFF6D4C41))),
                            labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                        keyboardType: TextInputType.multiline,
                        controller: _noteController,
                        onChanged: (value) {
                          // widget.nt.title = value;
                          //  rep.updatNote( widget.nt.id,   widget.nt.content);

                        },
                        maxLines: 1,
                      )), SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: 500,
                      child:
                      TextField(


                        decoration: InputDecoration(

                            hintText: 'Entrer le payment',
                            errorText: _validatepay?
                                'Entrer un chiffre':null,
                            labelText: 'Monto total',
                            //   errorText:      _validateBirth ? 'Birth Value Can\'t Be Empty' : null,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,  color:Color(0xFF6D4C41))),
                            labelStyle: TextStyle( fontSize: 20, color: Colors.black54)),
                        keyboardType: TextInputType.multiline,
                        controller: _payController,
                        onChanged: (value) {

                        },
                        maxLines: 1,
                      )), SizedBox(height: 10,),
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
                  ), SizedBox(height: 10,),


                  //      SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 20, 10, 10),
                    width: 500,
                    child:    DropdownButtonFormField<Dentists>(
                    value: _selectedDentist,
                    items: _dentists.map<DropdownMenuItem<Dentists>>((Dentists dentist) {
                      return DropdownMenuItem<Dentists>(
                        value: dentist,
                        child: Text(dentist.name as String),
                      );
                    }).toList(),
                    onChanged: (Dentists? selectedDentist) {
                      setState(() {
                        _selectedDentist = selectedDentist!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Dentist',
                    ),
                    )), SizedBox(height: 10,), SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () async {
                      openImage1();
                    },

                    child: Text('Ajouter un scanner pour ce rendesz vous'),


                  ), SizedBox(height: 10,), SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () async {
                      openImage2();
                    },

                    child: Text('Ajouter un aitre scanner '),


                  ), SizedBox(height: 10,), SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.fromLTRB(40, 20, 10, 10),
                      width: 500,
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
                              _casController.text.isEmpty    ? _validateName = true
                                  : _validateName = false;
                            //  _trtController.text.isEmpty    ? _validaterobe = true   : _validaterobe = false;
                              double.tryParse(_payController.text)==null? _validatepay=true: _validatepay=false;
                            });
                            if (_validateName == false &&
                                _validaterobe == false && _validatepay==false
                            ) {
                              var rd = new Rdv();
                              //Get collection count:

                              //  pt.id= 9;
                              var dnt = _dentists.where((m) {
                                return m!.email == _selectedDentist;
                              });
                              String ttl="";
                              for (int i=0;i<textFields.length; i++){
                                ttl= ttl+selectedValues[i]!+": "+textFields[i].controller!.text+("\n\n");
                              }
                              print("\n"+selectedtooth+": "+_casController.text+("\n\n")+ttl);
                              rd.cas = "\n"+selectedtooth+": "+_casController.text+("\n\n")+ttl;
                              rd.note = _noteController.text;
                              rd.trt = _trtController.text;
                              rd.date = date.substring(0,10);
                              rd.statu = selectedValue;
                              rd.pt= widget.pt.id;
                              rd.time=_time.toString();
                              rd.dr=_selectedDentist.id;
                              rd.pay=double.parse(_payController.text);
                              rd.sc1=img1;
                              rd.sc2=img2;


                              Repository  rep= new Repository();
                              await rep.insertData("appointments", rd.rdvMap());

                              Navigator.push( context, MaterialPageRoute( builder: (context) => listRDV(pt: widget.pt, admin: widget.admin, onLogout: widget.onLogout,)));
                            }
                          },
                          //}},
                          child: const Text('Valider', style: TextStyle( color:Colors.white),))),
               // ],              ),
           /*   Container(
                height:650,
                width: 700,
                // color: Color(0xFFEEEEEE),

                decoration: BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/f.jpg")) ),
                child: Ink.image(image: AssetImage("images/f.jpg"), height:650, width:700, fit: BoxFit.cover),
              )*/
                ])),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
              )));
  }
}
