
import 'dart:convert';
import 'dart:math';

import 'package:dntst/Patient.dart';
import 'package:dntst/addrdv.dart';
import 'package:dntst/paylist.dart';
import 'package:dntst/rdv.dart';
import 'package:dntst/repository.dart';
import 'package:flutter/material.dart';
import 'dntsts.dart';
import 'edit rdv.dart';
import 'main.dart';
import 'ordonance.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
class listpayment extends StatefulWidget {

  listpayment({Key? key, }) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<listpayment> {


  void _saveOrdonnance(String prescription) {
    // Implement your logic to save the prescription details here
    // You can use the prescription text and the associated appointment or patient information
  }
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


late bool jour=false;
  late bool moi=false;
  late bool year=false;
  late bool semain=false;
  late String thismonth= DateTime.now().month<10? DateTime.now().year.toString()+'-0'+DateTime.now().month.toString(): DateTime.now().year.toString()+'-'+DateTime.now().month.toString();
  late String today= DateTime.now().month<10? DateTime.now().year.toString()+'-0'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString(): DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString();
  late List<Rdv> rdvsList = <Rdv>[];
  late List<Rdv> initialist = <Rdv>[];
  final rep = Repository();
  late Patient ct= Patient();
  late double totalPayment = 0;

  late String text="par moin";
  getRdvs() async {
    var users = await rep.readDataBystat("appointments", "Paye");
    rdvsList = <Rdv>[];
    users.forEach((user) {
      setState(() {
        var userModel = Rdv();
        userModel.id = user['id'];
        userModel.date = user['date'];
        userModel.time = user['time'];
        userModel.cas = user['cas'];
        userModel.statu = user['statu'];
        userModel.trt = user['treatment'];
        userModel.note = user['note'];
        userModel.sc1 = user['scanner1'];
        userModel.sc2 = user['scanner2'];
        userModel.dr = user['iddr'];
        userModel.pt = user['idpt'];
        userModel.pay = user['payment'];
        rdvsList.add(userModel);
        totalPayment += double.parse(user['payment'].toString());
        initialist=rdvsList;
        print(user['payment']);
      });
    });

  }
  late List<Dentists> dentistsList = <Dentists>[];
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
  void _filterByDoctor(Dentists dentist) {
    setState(() {
      totalPayment = 0;
      rdvsList = rdvsList.where((rdv) => rdv.dr == dentist.id).toList();
      rdvsList.forEach((f) {
        totalPayment += double.parse(f.pay.toString());
      });
    });
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
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
  @override
  void initState() {
    _loadDentists();
    getRdvs();
    getDntsts();
    print('Total Payment: $totalPayment');
    super.initState();}


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

                      var result= rep.deleteDataById("appointments", catId);
                      if (result != null) {
                        Navigator.pop(context);
                        getRdvs();
                        _showSuccessSnackBar('RDV supprime'); }

                    },
                    child: const Text('Delete')),
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

      appBar:

      PreferredSize(
          preferredSize: Size.fromHeight(180.0), // here the desired height
          child:AppBar(
              elevation: 0,
              title:  Text(("Payment"), style: TextStyle( color: Colors.white),),
              backgroundColor: Color(0xFFEEEEEE),
              flexibleSpace: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),

                child:
                Container(decoration: BoxDecoration(image: DecorationImage( image: AssetImage('images/c.png'), fit: BoxFit.fill),),
                ),
              ))),


      body:
      Column(
        children: [
          SizedBox(height: 20,),
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Row(
         // mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Container(

            child:
            DropdownButton(
                value: selectedday,
                onChanged: (String? newValue){
                  setState(() {
                    selectedday = newValue!;

                  });
                },
                items: dropdowndays

            )
        ),
          Container(
           //   width: 40,
              child:
              DropdownButton(
                  value: selectedmonth,

                  onChanged: (String? newValue){
                    print(selectedmonth);
                    setState(() {
                      selectedmonth = newValue!;
                    });
                  },
                  items: dropdownmonth

              )
          ),
          Container(
             // width: 40,
              child:
              DropdownButton(
                  value: selectedyear,

                  onChanged: (String? newValue){
                    setState(() {
                      selectedyear = newValue!;
                    });
                  },
                  items: dropdownyear

              )
          ),],),
          ElevatedButton(
            onPressed: () {
              getRdvs();
              setState(() {
                totalPayment=0;
                rdvsList=initialist;
                jour=false;
                moi=false;
                year=false;
                semain=true;
                print(DateTime.now().day);
                rdvsList.forEach((f) {
                  setState(() {
                    totalPayment += double.parse(f.pay.toString());
                    text="tous le temps";
                  });
                });
              });
            },
            child: Text('Tous'),
          ),
          ElevatedButton(
            onPressed: () {

              setState(() {
                totalPayment=0;
                rdvsList=initialist;
                jour=true;
                moi=false;
                year=false;
                semain=false;
                print(today);
                rdvsList= rdvsList.where((element){ return element!.date == selectedyear+"-"+selectedmonth+"-"+selectedday; }).toList();

                  rdvsList.forEach((f) {
                    setState(() {
                      totalPayment += double.parse(f.pay.toString());
                    });
                  });
                text="par jour";
              }); },
            child: Text('Jour'),
          ),

          ElevatedButton(
            onPressed: () {

              setState(() {
                totalPayment=0;
                rdvsList=initialist;
                jour=false;
                moi=true;
                year=false;
                semain=false;
              rdvsList= rdvsList.where((element){ return element!.date!.substring(0,7) == selectedyear+"-"+selectedmonth; }).toList();

                rdvsList.forEach((f) {
                    totalPayment += double.parse(f.pay.toString());
                    text="par moin";
                });
              });
            },
            child: Text('moi'),
          ),
          ElevatedButton(
            onPressed: () {

              setState(() {
                totalPayment=0;
                rdvsList=initialist;
                jour=false;
                moi=false;
                year=true;
                semain=false;
                text="par annee";
                rdvsList= rdvsList.where((element){ return element!.date!.substring(0,4) == selectedyear;}).toList();
               // Navigator.push( context, MaterialPageRoute( builder: (context) => ListPayment( )));

                rdvsList.forEach((f) {
                  setState(() {
                    totalPayment += double.parse(f.pay.toString());
                  });
                });
              });
            },
            child: Text('annee'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 20, 10, 10),
            width: 500,
            child: DropdownButtonFormField<Dentists>(
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
                  _filterByDoctor(selectedDentist);
                });
              },
              decoration: InputDecoration(
                labelText: 'Dentist',
              ),
            ),
          ),

        ],
      ),
      SizedBox(height: 20,),
      Text("Payment totale "+text+": "+totalPayment.toString(), style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 20),),
      Expanded(
          child: ListView.builder(
              padding:  EdgeInsets.fromLTRB(10, 10, 10, 10),
              itemCount:rdvsList.length,

              itemBuilder: (context, index)    {

      var dntst = dentistsList.where((m) {
        return m!.id == rdvsList[index].dr;
      });
                return Container(

                    height: 160,
                    //  width: 160,
                    child: Card(
                      shape: RoundedRectangleBorder( //<-- SEE HERE
                        side: BorderSide(
                          color: Colors.blue,
                          width: 1,

                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),            //  color:  Color(fknclr),
                      child: ListTile(

                        onTap: () {

                        },
                        onLongPress: (){

                   setState(() {
                            _deleteFormDialog( rdvsList[index]!.id);
                            print(rdvsList[index]!.id);
                            // getAllCats();
                            getRdvs();

                          });
                        },

                        /* leading:          Container(
                    decoration: catsList[index].image==" "? BoxDecoration(image:DecorationImage( image:AssetImage("images/ct.png"), fit: BoxFit.fill) ):BoxDecoration(image:DecorationImage(image: MemoryImage(base64.decode(catsList[index].image as String)), fit: BoxFit.fill,) ) ,

                    width: 70,
                    height: 150,
              ),*/
                        title: Column( children: [Row( children: [
                          SizedBox(width: 10,),rdvsList[index]!.pay!= null && dntst.isNotEmpty? Text("\n Payment: "+ (rdvsList[index]!.pay.toString())+"\nDate: "+(rdvsList[index]!.date!.substring(0, 10) ?? '')+"\n Heur: "+(rdvsList[index]!.time!.substring(10, 15) ?? '')
                              +"\n Dr: "+(dntst!.first!.name ?? '')
                             , style: TextStyle( fontWeight: FontWeight.bold,),): Container(),
                        ]),
                          SizedBox(height: 20,),

                        ])
                      ),
                    ));
              }))]),


    );
  }
}