import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dntst/profile.dart';
import 'package:dntst/rdv.dart';
import 'package:dntst/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'admin.dart';
import 'dntsts.dart';

class EditRdv extends StatefulWidget {
  final String isadmin;
  final Rdv pt;
  final Admin admin;
  final Function() onLogout;
  const EditRdv({Key? key,required this.pt, required this.isadmin, required this.admin, required this.onLogout}) : super(key: key);

  @override
  State<EditRdv> createState() => _EditRdvState();
}


class _EditRdvState extends State<EditRdv> {
  //List<Cat>? cat;
  var _casController = TextEditingController();
  var _trtController = TextEditingController();
  var _noteController = TextEditingController();
  var _payController = TextEditingController();
  late String selectedValue = widget.pt.statu as String;
  bool _validateName= false;
  bool validatepay= false;
  late List<Dentists> _dentists=  <Dentists>[];
  late Dentists _selectedDentist=Dentists();
  Future<void> _loadDentists() async {
    final repository = Repository();
    final dentists = await repository.getDentists();
    setState(() {
      _dentists = dentists;
      _selectedDentist = dentists[0]; // Set the default selected dentist
    });
  }
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
  late String date =DateTime.now().toString();

  late int min= 13;
  late int hr= 10;
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
  List<TextField> textFields = [];
//  List<Container> cnt = [];

  String allTextFieldsText = '';
  List<String?> selectedValues = ['11','', '12','13','14','kk' ];

  void updateAllTextFieldsText() {
    // Concatenate the text from all the TextFields
    allTextFieldsText =_casController.text+ textFields.map((textField) => textField.controller!.text).join('\n');
   /* for (int i=0;i<textFields.length; i++){
      _casController.text=_casController.text+textFields.map((textField) => textField.controller!.text).join('\n');
    }*/

  }
  late String img1=widget.pt.sc1 as String;
  late String img2=widget.pt.sc2 as String;
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

        setState(() {
          img1=base64String;
          Uint8List decodedbytes = base64.decode(base64String);
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



        setState(() {
          img2=base64String;
          Uint8List decodedbytes = base64.decode(base64String);
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
      _casController.text = widget.pt.cas?? "";
      _trtController.text =  widget.pt.trt?? "";
      _noteController.text = widget.pt.note?? "";
      _payController.text = widget.pt.pay.toString()?? "";
      _loadDentists();

      //img= widget.ct.image as String;

      // _userlblController=widget.op.date?? DateTime.now().toString().substring(0,10);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar( title: Text('Modifer les information de dendez vous ')),

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
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: 500,
                    child:


                    DateTimePicker(
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      cursorColor: Colors.deepPurpleAccent,
                      dateLabelText: widget.pt.date.toString().substring(0, 10),
                      onChanged: (val) =>date=DateTime.parse(val as String) as String,
                      validator: (val) {
                        print(val);
                        date=DateTime.parse(val as String) as String;
                        return null;
                      },
                      //onSaved: (val) => print(val),
                      onSaved: (val) =>   date=DateTime.parse(val as String) as String,
                    ) ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: 500,

                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      _selectTime();
                    },
                    decoration: InputDecoration(
                      hintText: widget.pt!.time!.substring(10, 15) ?? '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),

                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),SizedBox(height:20,),
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
                    maxLines: 9,
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
                widget.isadmin=="yes"? Container(
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
                      updateAllTextFieldsText();
                      });
                      }},
                    child: Text('+'),
                  ),):Container(),

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
                TextField(
                    controller: _trtController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Modifier le traitement',
                      labelText: 'Traitement',

                    )),
                const SizedBox(
                  height: 20.0,
                ),

                TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Modifier la notice',
                      labelText: 'Note',

                    )),
                const SizedBox(
                  height: 20.0,
                ),

                TextField(
                    controller: _payController,
                    decoration: InputDecoration(
                      errorText: validatepay? 'Entrer un chiffre':null,
                      border: const OutlineInputBorder(),
                      hintText: 'Modifier le payment',
                      labelText: 'payment',

                    )),
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
                    )),
                SizedBox(height: 20,),

                Row(children: [
                Container(
                    width: 100,
                    height: 100,
                    child:  InkWell(

                        splashColor:Color(0xFFEEEEEE),
                        onTap:(){
                          openImage1();
                          widget.pt.sc1= img1;


                        },
                        child: Text("+", style: TextStyle(fontSize: 20),)),
                  decoration: widget.pt.sc1==" "? BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/sc1.jpg")) ):BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image: MemoryImage(base64.decode(img1 as String)),) ) ,
                ),
                SizedBox(width: 30,),
                Container(
                    decoration: widget.pt.sc2==" "? BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image:AssetImage("images/sc2.jpg")) ):BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image: MemoryImage(base64.decode(img2 as String)),) ) ,
                    width: 100,
                    height: 100,
                    child:  InkWell(

                        splashColor:Color(0xFFEEEEEE),
                        onTap:(){
                          openImage2();
                          widget.pt.sc2= img2;
                          setState(() {
                            widget.pt.sc2= img2;
                          });
                        },
                        child: Text("+", style: TextStyle(fontSize: 20),))),],),
                const SizedBox(
                  height: 20.0,
                ),//Checkbox

               widget.isadmin=="yes"? Row(
                  children: [
                    const SizedBox(
                      width: 80.0,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(fontSize: 15)),
                        onPressed: () {
                          _casController.text = '';
                          _trtController.text = '';
                          _noteController.text = '';


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

                            _casController.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;
                            double.tryParse(_payController.text)==null? validatepay= true: validatepay=false;

                          });
                          if (_validateName == false && validatepay== false
                          ) {
                            // print("Good Data Can Save");



                            String ttl="";
                            for (int i=0;i<textFields.length; i++){
                              ttl= ttl+selectedValues[i]!+": "+textFields[i].controller!.text+("\n\n");
                            }
                            print("\n"+selectedtooth+": "+_casController.text+("\n\n")+ttl);
                            Rdv rd = Rdv();
                            rd.id=widget.pt.id;
                            rd.cas = "\n"+selectedtooth+": "+_casController.text+("\n\n")+ttl;
                            rd.note = _noteController.text ?? " ";
                            rd.trt = _trtController.text?? " ";
                            rd.date = date.toString()?? DateTime.now().toString().substring(0,10);
                            rd.statu = selectedValue;
                            rd.pt= widget.pt.pt;
                            rd.time=_time.toString();
                            rd.dr=_selectedDentist.id;
                            rd.pay=double.parse(_payController.text);
                            rd.sc1= img1;
                            rd.sc2= img2;
                          Repository rep=  Repository();
                            await rep.updateData("appointments", rd.rdvMap());
                            Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout, )));



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