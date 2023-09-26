import 'package:date_time_picker/date_time_picker.dart';
import 'package:dntst/payment.dart';
import 'package:dntst/rdv%20display.dart';
import 'package:dntst/rdv.dart';
import 'package:dntst/repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Addpatient.dart';
import 'Patient.dart';
import 'Patirnt details.dart';
import 'addrdv.dart';
import 'admin.dart';

import 'package:flutter/material.dart';
import 'dentists list.dart';
import 'editpatient.dart';
import 'login.dart';
import 'ordonance.dart';
import 'signup.dart';

class ProfilePage extends StatefulWidget {
  final Admin admin;
  final Function() onLogout;

  ProfilePage({Key? key, required this.admin, required this.onLogout, }) : super(key: key);


  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  Repository rep = Repository();
  Future<void> logout(BuildContext context) async {
    // Call the logout function and execute the callback

    widget.onLogout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', " ");
    Navigator.push( context, MaterialPageRoute( builder: (context) => login(dbConnection: rep, )));

    Navigator.of(context).pop(); // Pop the profile page from the navigation stack
  }
  List<bool> _isHovered = List.generate(2, (index) => false); // Adjust the size based on the number of icons

  var _codeController = TextEditingController();
  late bool validate=false;
  late var _isHomeIconHovered= false;
  late bool _isSettingsIconHovered=false;
  late bool _threeIconHovered=false;
  late bool _foorIconHovered=false;
  late bool _fiveconHovered=false;
  var _paymController=TextEditingController();

  void _onHomeIconHover(bool isHovered) {
    setState(() {
      _isHomeIconHovered = isHovered;
    });
  }

 /* List<TextEditingController> _controllers = List.generate(

        //(index) => TextEditingController(),
  );*/
  List<DropdownMenuItem<String>> get dropdownmonth{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("01"),value: "01"),
      DropdownMenuItem(child: Text("02"),value: "02"),
      DropdownMenuItem(child: Text("03"),value: "03"),
      DropdownMenuItem(child: Text("04"),value: "04"),
      DropdownMenuItem(child: Text("05"),value: "05"),
      DropdownMenuItem(child: Text("06"),value: "06"),
      DropdownMenuItem(child: Text("07"),value: "07"),
      DropdownMenuItem(child: Text("08"),value: "08"),
      DropdownMenuItem(child: Text("09"),value: "09"),
      DropdownMenuItem(child: Text("10"),value: "10"),
      DropdownMenuItem(child: Text("11"),value: "11"),
      DropdownMenuItem(child: Text("12"),value: "12"),
    ];
    return menuItems;
  }
  List<DropdownMenuItem<String>> get dropdownyear{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("2020"),value: "2020"),
      DropdownMenuItem(child: Text("2021"),value: "2021"),
      DropdownMenuItem(child: Text("2022"),value: "2022"),
      DropdownMenuItem(child: Text("2023"),value: "2023"),
      DropdownMenuItem(child: Text("2024"),value: "2024"),
      DropdownMenuItem(child: Text("2025"),value: "2025"),
      DropdownMenuItem(child: Text("2026"),value: "2026"),
      DropdownMenuItem(child: Text("2027"),value: "2027"),
      DropdownMenuItem(child: Text("2028"),value: "2028"),
      DropdownMenuItem(child: Text("2029"),value: "2029"),
      DropdownMenuItem(child: Text("2030"),value: "2030"),
      DropdownMenuItem(child: Text("2031"),value: "2031"),
      DropdownMenuItem(child: Text("2032"),value: "2032"),
    ];
    return menuItems;
  }
  late String selectedday = DateTime.now().day.toString();
  late String selectedmonth = DateTime.now().month<10?"0"+DateTime.now().month.toString():DateTime.now().month.toString();
  late String selectedyear= DateTime.now().year.toString();

  List<DropdownMenuItem<String>> get dropdowndays {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("01"),value: "01"),
      DropdownMenuItem(child: Text("02"),value: "02"),
      DropdownMenuItem(child: Text("03"),value: "03"),
      DropdownMenuItem(child: Text("04"),value: "04"),
      DropdownMenuItem(child: Text("05"),value: "05"),
      DropdownMenuItem(child: Text("06"),value: "06"),
      DropdownMenuItem(child: Text("07"),value: "07"),
      DropdownMenuItem(child: Text("08"),value: "08"),
      DropdownMenuItem(child: Text("09"),value: "09"),
      DropdownMenuItem(child: Text("10"),value: "10"),
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
    ];
    return menuItems;
  }

  late Patient ct= Patient();
  List<Map<String, dynamic>> _data = [];
  late Future<List<Patient>> _patientsFuture=  getPatients();
  List<TextEditingController> _controllers = [];

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  late List<Rdv> rdvsList = <Rdv>[];
  late String isadmn="";
adminlog() async {
  final prefs = await SharedPreferences.getInstance();
  isadmn=  prefs.getString('isadmin')!;
  return isadmn;
}
  @override
  void initState() {
    super.initState();
    adminlog();
   // getPatients();
    getrdv();
    _patientsFuture = getPatients();


  }
  getrdv() async {
    //var users = await FirebaseFirestore.instance.collection('cats').document().get();
    var users = await rep.readData("appointments");
    rdvsList = <Rdv>[];
    users.forEach((user) {
      setState(() {
        var userModel = Rdv();
        userModel.id = user['id'];
        userModel.date = user['date'];
        userModel.time = user['time'];
        userModel.cas = user['cas'];
        userModel.statu = user['statu'];
        userModel.pay = user['payment'];
        userModel.trt = user['treatment'];
        userModel.note = user['note'];
        userModel.dr = user['iddr'];
        userModel.pt = user['idpt'];
        rdvsList.add(userModel);
        print(userModel.date!+"see");
      });
    });

  }
  late List<Patient> patientsList = <Patient>[];
  Future<List<Patient>> getPatients() async {
    var users = await rep.readData("patients");
   // List<Patient> patientsList = [];
    users.forEach((user) {
      var userModel = Patient();
      userModel.id = user['id'] as int? ?? 0;
      userModel.name = user['name'] as String? ?? '';
      userModel.email = user['email'] as String? ?? '';
      userModel.insurance = user['insurance'] as String? ?? '';
      userModel.birth = user['birth'] as String? ?? '';
      userModel.gender = user['gender'] as String? ?? '';
      userModel.address = user['address'] as String? ?? '';
      userModel.phone = user['phone'] as String? ?? '';
      patientsList.add(userModel);
  //   isButtonPressed? patientsList.add(userModel).where((appointment) => appointment.pt == userModel.id).toList():patientsList.add(userModel);

     // patientsList=patientsList.where((appointment) => appointment.id == g?.pt).toList();
    });
    return patientsList;
  }

  Future<List<Patient>> getPatientsperdate() async {
    patientsList = [];
   var users = await rep.readDatapt(selectedyear+"-"+selectedmonth+"-"+selectedday);
  //var users = await rep.readData("patients");
    users.forEach((user) {
      var userModel = Patient();
      userModel.id = user['id'] as int? ?? 0;
      userModel.name = user['name'] as String? ?? '';
      userModel.email = user['email'] as String? ?? '';
      userModel.insurance = user['insurance'] as String? ?? '';
      userModel.birth = user['birth'] as String? ?? '';
      userModel.gender = user['gender'] as String? ?? '';
      userModel.address = user['address'] as String? ?? '';
      userModel.phone = user['phone'] as String? ?? '';
      patientsList.add(userModel);
      print(userModel.name);
      /*List<Rdv> appointments=<Rdv>[];
      rdvsList.isNotEmpty? appointments = rdvsList: appointments =  <Rdv>[];
      List<Rdv> patientAppointments = appointments
          .where((appointment) => appointment.pt == userModel.id)
          .toList();
      patientAppointments.last.date==selectedyear+"-"+selectedmonth+"-"+selectedday?
     patientsList.add(userModel): null;*/
    });
 //   _patientsFuture = getPatientsperdate();
    return patientsList;
  }
  Future<List<Patient>> getPatientsbetween() async {
    patientsList = [];
    print(date.substring(0,10)+enddate.substring(0,10)+"hhhggg");
    var users = await rep.readDatabetween( date.substring(0,10), enddate.substring(0,10));
    //var users = await rep.readData("patients");
    users.forEach((user) {
      var userModel = Patient();
      userModel.id = user['id'] as int? ?? 0;
      userModel.name = user['name'] as String? ?? '';
      userModel.email = user['email'] as String? ?? '';
      userModel.insurance = user['insurance'] as String? ?? '';
      userModel.birth = user['birth'] as String? ?? '';
      userModel.gender = user['gender'] as String? ?? '';
      userModel.address = user['address'] as String? ?? '';
      userModel.phone = user['phone'] as String? ?? '';
      patientsList.add(userModel);
      print(userModel.name);
      /*List<Rdv> appointments=<Rdv>[];
      rdvsList.isNotEmpty? appointments = rdvsList: appointments =  <Rdv>[];
      List<Rdv> patientAppointments = appointments
          .where((appointment) => appointment.pt == userModel.id)
          .toList();
      patientAppointments.last.date==selectedyear+"-"+selectedmonth+"-"+selectedday?
     patientsList.add(userModel): null;*/
    });
    //   _patientsFuture = getPatientsperdate();
    return patientsList;
  }
  Rdv? getLastAppointmentForPatient(Patient patient) {
    List<Rdv> appointments=<Rdv>[];
    rdvsList.isNotEmpty? appointments = rdvsList: appointments =  <Rdv>[];

    List<Rdv> patientAppointments = appointments
        .where((appointment) => appointment.pt == patient.id)
        .toList();

    // Sort appointments by date in descending order
    //patientAppointments.sort((a, b) => b.date!.compareTo(a.date as String));
    // patientAppointments.last;

    // Return the last appointment, if any
    return patientAppointments.isNotEmpty ? patientAppointments.last : null;
  }
  late int clr=1;
  colorconrtol(a, b){
    if(a as String=="Enregistre"){

      clr=0xFF90CAF9;
    }else if(a as String=="Absent")
    {
      clr=0xFFEF9A9A;
    }
    else if(a as String=="Pas Paye")
    {
      clr=0xFFFFE082;
    }
    else if(a as String=="Paye")
    {
      clr=0xFFC5E1A5;
    }
    else{print ("nooooooooooon");}
  }
  String searchText = '';
  void _threeIconHover(bool isHovered) {
    setState(() {
      // Update the hover state for the home icon
      _threeIconHovered = isHovered;
    });
  }
  void _fourIconHover(bool isHovered) {
    setState(() {
      // Update the hover state for the home icon
      _foorIconHovered = isHovered;
    });
  }
  void _fiveIconHover(bool isHovered) {
    setState(() {
      // Update the hover state for the home icon
      _fiveconHovered = isHovered;
    });
  }
  bool isButtonPressed = false;
  bool isRangePressed = false;
  late String date =DateTime.now().toString();
  late String enddate =DateTime.now().toString();
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
                  setState(() {
                    var result= rep.deletePatient(catId);
                    if (result != null) {
                      Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout, )));

                      _showSuccessSnackBar('Patient supprime'); }
                  });



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
  late String selectedValue ="Enregistre";
  @override
  Widget build(BuildContext context) {
    payform( Lst) {


      return showDialog(
          context: context,
          builder: (BuildContext context) {

            final _payController = TextEditingController();
            _payController.text= Lst.pay.toString();
            bool validate=false;
            return AlertDialog(
                title: const Text(
                  'Enter la nouvelle valeure de payment',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                actions: [ Container( child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _payController,
                        decoration: InputDecoration(

                          border: OutlineInputBorder(), labelText: Lst.pay.toString(),
                          //add error here
                     ),


                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // primary: pickerColor,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.only(
                              left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
                      onPressed: (() async {
                        setState(()   {rep.updatepaymnt(Lst.id, double.parse(_payController.text));
                        Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout, )));});

                        }
                     ),
                      child: const Text('Ok'),
                    ),
                  ],
                )),]);});}
    _addFormDialog() {


      return showDialog(
          context: context,
          builder: (BuildContext context) {

            final _categoryController = TextEditingController();
             bool validate=false;
            return AlertDialog(
                title: const Text(
                  'Enter le code d\'admine',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                actions: [ Container( child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _codeController,
                        decoration: InputDecoration(

                            border: OutlineInputBorder(), labelText: 'Code d\'admin',
                          errorText: validate ? 'Code erronee' : null,),


                      ),
                    ),
                    Container(child: validate? Text("Code eronnee"): null) ,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // primary: pickerColor,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.only(
                              left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
                      onPressed: (() async {
                        setState(()   { validate = _codeController.text != "1234"; });
                        print(validate.toString());
                        if (_codeController.text== "1234") {
                          isadmn="yes";
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('isadmin',"yes");
                          Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout, )));
                          _codeController.text="";
                       }else{
                        setState(() {
                          _codeController.text="";
                          validate=true;
                        });

                        }
                      }),
                      child: const Text('Ok'),
                    ),
                  ],
                )),]);});}

    void _onSettingsIconHover(bool isHovered) {
      setState(() {
        // Update the hover state for the settings icon
        _isSettingsIconHovered = isHovered;
      });
    }
    return Scaffold( body:Row(
        children: [
          // Vertical AppBar
          Container(
            width: 80,
            color: Colors.blue, // Customize as per your design
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  onHover: (_) => _onHomeIconHover(true),
                  onExit: (_) => _onHomeIconHover(false),
                  child: Transform.scale(
                    scale: _isHomeIconHovered ? 2 : 1.0,
                    child: IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout, )));
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                MouseRegion(
                  onHover: (_) => _onSettingsIconHover(true),
                  onExit: (_) => _onSettingsIconHover(false),
                  child: Transform.scale(
                    scale: _isSettingsIconHovered ? 2 : 1.0,
                    child: IconButton(
                      icon: Icon(Icons.attach_money),
                      onPressed: () {
                 Navigator.push( context, MaterialPageRoute( builder: (context) => listpayment()));
                     },
                        // Handle settings icon navigation

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                MouseRegion(
                  onHover: (_) => _threeIconHover(true),
                  onExit: (_) => _threeIconHover(false),
                  child: Transform.scale(
                    scale: _threeIconHovered ? 2 : 1.0,
                    child: IconButton(
                      icon: Icon(Icons.people),
                      onPressed: () {
                        Navigator.push(context,  MaterialPageRoute(  builder: (context) => DentistsScreen()));
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                MouseRegion(
                  onHover: (_) => _fiveIconHover(true),
                  onExit: (_) => _fiveIconHover(false),
                  child: Transform.scale(
                    scale: _fiveconHovered ? 2 : 1.0,
                    child: IconButton(
                      icon: Icon(Icons.description),
                      onPressed: () {

                        Navigator.push( context, MaterialPageRoute( builder: (context) => OrdonnanceDialog(admin: widget.admin, onLogout: widget.onLogout,)));
                        // Handle settings icon navigation
                      },
                    ),
                  ),
                ),
                // Add more MouseRegion and IconButton widgets for additional icons
              ],
            ),
          ),
    // Main content
    Expanded(
    child: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ],

          flexibleSpace:  Container(
    decoration: BoxDecoration(
    color: Colors.blue, // Set your desired app bar background color
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 4.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    "Bluetooth",
    style: TextStyle(
    color: Colors.white, // Set your desired title text color
    fontSize: 20.0, // Set your desired title font size
    fontWeight: FontWeight.bold, // Set your desired title font weight
    ),
    ),
    SizedBox(width: 20,),

    FutureBuilder<SharedPreferences>(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    SharedPreferences prefs = snapshot.data!;
    // Retrieve the value from SharedPreferences
    String? myValue = prefs.getString('email');


    // Use the retrieved value in your widget
    return Text("");
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else {
    return CircularProgressIndicator();
    }
    },
    ),


      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: !isButtonPressed,
            child: ElevatedButton(
              onPressed: () {
                //patientsList = [];

                setState(() {
                  isButtonPressed = true;
                  getPatientsperdate();
                });
              },
              child: Text('Choisir La date'),
            ),
          ),
          Visibility(
            visible: isButtonPressed,
            child:      Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Container(
                  //  padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                  //width: 40,
                    child:
                    DropdownButton(
                        value: selectedday,

                        onChanged: (String? newValue){
                          setState(() {
                            selectedday = newValue!;
                            getPatientsperdate();

                          });
                        },
                        items: dropdowndays

                    )
                ),
                Container(
                  //  padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                  //   width: 40,
                    child:
                    DropdownButton(
                        value: selectedmonth,

                        onChanged: (String? newValue){
                          print(selectedmonth);
                          setState(() {
                            selectedmonth = newValue!;
                            getPatientsperdate();
                          });
                        },
                        items: dropdownmonth

                    )
                ),
                Container(
                  // padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                  // width: 40,
                    child:
                    DropdownButton(
                        value: selectedyear,

                        onChanged: (String? newValue){
                          setState(() {
                            selectedyear = newValue!;
                            getPatientsperdate();
                          });
                        },
                        items: dropdownyear

                    )
                ),],),
          ),
        ],
      ),


    SizedBox(width: 40,),

      Visibility(
        visible: !isRangePressed,
        child: ElevatedButton(
          onPressed: () {
            //patientsList = [];

            setState(() {
              isRangePressed = true;
            //  getPatientsbetween();
            });
          },
          child: Text('Selectioner une range'),
        ),
      ),
      Visibility(
        visible: isRangePressed,
        child:      Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [ Container(child:
           Container(
                width: 200,
                child:
        DateTimePicker(
            initialValue: '',
           firstDate: DateTime(2000),
           lastDate: DateTime(2100),
           cursorColor: Colors.blue,
          dateLabelText: 'Start Date',
          onChanged: (val) {date=DateTime.parse(val as String).toString();
         setState(() {
          getPatientsbetween();
         });
            },
          validator: (val) {

            date=DateTime.parse(val as String) as String;
            //getPatientsbetween();

           // return null;
          },
          //onSaved: (val) => print(val),
          onSaved: (val) =>   date=DateTime.parse(val as String) as String,
        )) ),

          SizedBox(width: 40,),
            Container(child:
            Container(
              height: 50,
                width: 200,
                child:
                DateTimePicker(
                  initialValue: '',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  cursorColor: Colors.blue,
                  dateLabelText: 'End Date',
                 onChanged: (val) {
                    enddate=DateTime.parse(val as String).toString();
                  setState(() {
                      getPatientsbetween();
                    });
                    
                  },
                validator: (val) {

                    enddate=DateTime.parse(val as String) as String;
                   // getPatientsbetween();
                   // return null;
                  },
                  //onSaved: (val) => print(val),
                  onSaved: (val)  =>   date=DateTime.parse(val as String) as String,
                ))) ,


          ],),
      ),
    SizedBox(width: 20,),

    isadmn!="yes"? ElevatedButton(
    onPressed: () async {
      _addFormDialog();
    },

    child: Text('Enter comme admin'),


    ): ElevatedButton(
    onPressed: () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('isadmin',"no");
    setState(() {
      prefs.setString('isadmin',"no");
      isadmn="no";
      Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout, )));
    });

    },

    child: Text('quiter admin'),


    )
    ,
    SizedBox(width: 20,),
      widget.admin==null?ElevatedButton(
        onPressed: () async {Navigator.push( context, MaterialPageRoute( builder: (context) => login(dbConnection: rep)));

        },

        child: Text('Se connecter'),


      ):ElevatedButton(
        onPressed: () async {logout(context);

        },

        child: Text('Deconnection'),


      ) ,
    SizedBox(width: 200,),

    ],
    ),
    ),
    )),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {  Navigator.push(context,  MaterialPageRoute(  builder: (context) => addpts(admin: widget.admin,onLogout: widget.onLogout,))); },

        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Row(children: [
              SizedBox(width:30),
            Text('\nName: ${widget.admin.name}'),
            SizedBox(width:30),
            Text('\nEmail: ${widget.admin.email}'),],),
            SizedBox(height:20),

    FutureBuilder<List<Patient>>(
    future: _patientsFuture,
    builder: (context, snapshot) {

    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(
    child: CircularProgressIndicator(),
    );
    } else if (snapshot.hasError) {
    return Center(
    child: Text('Error occurred'),
    );
    } else if (snapshot.hasData) {
    //List<Patient> patientsList = snapshot.data!;

    return Container(
    height: MediaQuery.of(context).size.height-120,
    child: GestureDetector(
    child:SingleChildScrollView(
    scrollDirection: Axis.vertical, // Vertical scrolling
    child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columnSpacing: 30,
    columns: [
    DataColumn(label: Container( width: 50, child: Text('ID'))),
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Email')),
    DataColumn(label: Text('Insurance')),
    DataColumn(label: Text('Birth')),
    DataColumn(label: Text('Gender')),
    DataColumn(label: Text('Address')),
    DataColumn(label: Text('Phone')),
    DataColumn(label: Text('RDV')),
      DataColumn(label: Text('payment')),
      DataColumn(label: Text('Statue')),
    DataColumn(label: Text('Edit')),
    DataColumn(label: Text('Ajouter RDV')),
      isadmn=="yes"? DataColumn(label: Text('Delete')): DataColumn(label: Container()),

    ],

      rows: patientsList.where((patient) =>
          patient.name!.toLowerCase().contains(searchText.toLowerCase()))
          .map<DataRow>((Patient patient) {

        Rdv? lastAppointment = getLastAppointmentForPatient(patient);
        lastAppointment != null ? colorconrtol(lastAppointment.statu, clr) : null;
        lastAppointment != null
            ? selectedValue = lastAppointment!.statu as String
            : selectedValue = "Enregistre";



        return DataRow(

          cells: [
            DataCell(Text(patient.id.toString())),
            DataCell(Text(patient.name as String)),
            DataCell(Text(patient.email as String)),
            DataCell(Text(patient.insurance as String)),
            DataCell(Text(patient.birth as String)),
            DataCell(Text(patient.gender as String)),
            DataCell(Text(patient.address as String)),
            DataCell(Text(patient.phone as String)),
            DataCell(
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => listRDV(
                        pt: patient, admin: widget.admin, onLogout: widget.onLogout,
                      ),
                    ),
                  );
                },
                child: Text('Check Appointments'),
              ),
            ),
            lastAppointment != null?
            DataCell( TextButton(
              onPressed: (()  {

                setState(() {
                  isadmn=="yes"? payform(lastAppointment ): print('not admin');
                });

              }),
              child:  Text(lastAppointment!.pay!.toString()),
            )): DataCell(Text("no rdv")),
            DataCell(

              Container(
                padding: EdgeInsets.fromLTRB(40, 10, 10, 5),
                child: DropdownButton<String>(
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      print(selectedValue);
                      rep.updateOneData(
                          "appointments", "statu", selectedValue, lastAppointment!.id);
                      getrdv();
                    });
                  },
                  items: dropdownItems,
                ),
              ),
            ),


            DataCell(
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Editpt(pt: patient, admin: widget.admin,onLogout: widget.onLogout,),
                    ),
                  );
                  print(isadmn);
                  _patientsFuture = getPatients();
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
            ),


            DataCell(
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addrdv(pt: patient, admin: widget.admin, onLogout: widget.onLogout),
                    ),
                  );
                  _patientsFuture = getPatients();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
              ),
            ),
            DataCell(
              isadmn=="yes"?  IconButton(
                onPressed: () {
                  _deleteFormDialog(patient.id);

                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ): Container(),
            ),
          ],
          onSelectChanged: (bool? selected) {
            if (selected != null && selected) {
              // Handle navigation to Patient details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientDetailsScreen(patient: patient),
                ),
              );
            }
          },
          color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }
              lastAppointment != null
                  ? colorconrtol(lastAppointment.statu, clr)
                  : clr = 0;

              return Color(clr);
            },
          ),
        );
      }).toList().reversed.toList(),
    ),
    ))));
    } else {
    return Container();
    }
    },
    ),
    ]))))]));
  }
}
class _DataTableSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, " ");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Return null, as the results are handled in the AppBar onPressed callback
    return Container(child: Text("tt"),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Build suggestions based on the entered query (optional)
    // You can use the query value to provide search suggestions
    return ListView(
      // ...
    );
  }

              // Call logout when the button is pressed


}
