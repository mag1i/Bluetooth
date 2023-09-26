
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:dntst/Patient.dart';
import 'package:dntst/addrdv.dart';
import 'package:dntst/profile.dart';
import 'package:dntst/rdv.dart';
import 'package:dntst/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin.dart';
import 'dntsts.dart';
import 'edit rdv.dart';
import 'ordonance.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
class listRDV extends StatefulWidget {
  final Patient pt;
  final Admin admin;
  final Function() onLogout;
  listRDV({Key? key, required this.pt, required this.admin, required this.onLogout, }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<listRDV> {


  late String isadmn="";
  adminlog() async {
    final prefs = await SharedPreferences.getInstance();
    isadmn=  prefs.getString('isadmin')!;
    return isadmn;
  }
  void _saveOrdonnance(String prescription) {
    // Implement your logic to save the prescription details here
    // You can use the prescription text and the associated appointment or patient information
  }
  void _downloadOrdonnanceAsPdf(Rdv rdv, dr, Patient p) async {
    final ByteData assetImageByteData = await rootBundle.load('images/Bluetooth.png');

    final File imageFile = File('images/Bluetooth.png'); // Replace with the actual path to your image file
    final File phone = File('images/phn.png'); // Replace with the actual path to your image file
    final File lc = File('images/lc.png'); // Replace with the actual path to your image file
    final File bt = File('images/bt.png'); // Replace with the actual path to your image file

    if (rdv != null) {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
        //  build: (context) => pw.Text(rdv.trt ?? ''),
          build: (context) => pw.Container(child:
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
            pw.Row(children: [
              pw.Container(

                width: 50,
                height: 50,


              child:      pw.Image(pw.MemoryImage(imageFile.readAsBytesSync())),

              ),
            pw.SizedBox(width: 20),

              pw.Text('cabinet dentaire', style: pw.TextStyle( fontSize: 30, fontWeight: pw.FontWeight.bold ,  color: PdfColor.fromInt(0xFF81D4FA),  )),
            ]),
              pw.SizedBox(height: 20,),
              pw.Row(children: [
                pw.Container(

                  width: 20,
                  height: 20,


                  child:      pw.Image(pw.MemoryImage(phone.readAsBytesSync())),

                ),
              pw.SizedBox(width: 10),
              // pw.Icon(pw.IconThemeData.),
                pw.Text('0794784365'),
                pw.SizedBox(width: 200),
                pw.Text(dr),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  children: [
                    pw.Container(

                      width: 20,
                      height: 20,


                      child:      pw.Image(pw.MemoryImage(lc.readAsBytesSync())),

                    ),
                    pw.SizedBox(width: 10),
                    // pw.Icon(pw.IconThemeData.),
                    pw.Text('210 tsreet terhgft'),
              ]),
              pw.Container(

                width: 500,
                height: 60,


                child:      pw.Image(pw.MemoryImage(bt.readAsBytesSync())),

              ),
              pw.SizedBox(height: 20),
              pw.Text('Nom et Prenom:        '+ p.name.toString()),
              pw.Text('\nAge:        '+ p.birth.toString()),
              pw.Text('\n Sexe:        '+ p.gender.toString()),
              pw.Text('\nCas:        '+ rdv.cas.toString()),
              pw.Text('\n\n\n\n\nTraitement:        '+ rdv.trt.toString()),
              pw.SizedBox(height: 320),
              pw.Row(children: [
              pw.Text(('\n Date: '+ rdv.date.toString().substring(0, 10)),   style: pw.TextStyle(
                fontSize: 18,
                decoration: pw.TextDecoration.underline, // Underline the text
              ), ),
                pw.SizedBox(width:220),
                pw.Text('\n Signature:        ',   style: pw.TextStyle(
                  fontSize: 18,
                  decoration: pw.TextDecoration.underline, // Underline the text
                ), ),
              ])
            ]),

          ),
        ),
      );

      final bytes = await pdf.save();
      await Printing.sharePdf(bytes: bytes, filename: 'ordonnance.pdf');
    }
  }

  void _printOrdonnance(Rdv rdv) async {if (rdv != null) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Text(rdv.trt ?? ''),
      ),
    );}}

  late List<Rdv> rdvsList = <Rdv>[];
  final rep = Repository();
  late Patient ct= Patient();
  getRdvs() async {
    var users = await rep.readDataById("appointments", widget.pt.id);
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
  List<Patient> patientsList = [];
  Future<List<Patient>> getPatients() async {
    var users = await rep.readData("patients");
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
    });
    return patientsList;
  }

  late int sure=0;
late int clr=0;
  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  @override
  void initState() {
    adminlog();
    getRdvs();
    getDntsts();
    getPatients();
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {  Navigator.push(context,  MaterialPageRoute(  builder: (context) => addrdv(pt: widget.pt, admin: widget.admin, onLogout: widget.onLogout,))); },

      ),
      appBar:

      PreferredSize(
          preferredSize: Size.fromHeight(180.0), // here the desired height
          child:AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage(admin: widget.admin, onLogout: widget.onLogout,)),
                  );
                },
              ),
              elevation: 0,
              title:  Text(("List des Rendez vou de patieny"+ (widget.pt.email as String)), style: TextStyle( color: Colors.white),),
              backgroundColor: Color(0xFFEEEEEE),
              flexibleSpace: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),

                child:
                Container(decoration: BoxDecoration(image: DecorationImage( image: AssetImage('images/a.png'), fit: BoxFit.fill),),
                ),
              ))),


      body:
      Container(
          color: Color(0xFFEEEEEE),

          child:

          ListView.builder(
              padding:  EdgeInsets.fromLTRB(10, 10, 10, 10),
              itemCount: rdvsList.length,
              itemBuilder: (context, index)    {
                var dntst = dentistsList.where((m) {
                  return m!.id == rdvsList[index].dr;
                });
                var ptnt = patientsList.where((m) {
                  return m!.id == rdvsList[index].pt;
                });
                if(rdvsList[index].statu=="Enregistre"){

                  clr=0xFF90CAF9;
                }else if(rdvsList[index].statu=="Absent")
                {
                  clr=0xFFEF9A9A;
                }
                else if(rdvsList[index].statu=="Pas Paye")
                {
                  clr=0xFFFFE082;
                }
                else if(rdvsList[index].statu=="Paye")
                {
                  clr=0xFFC5E1A5;
                }
                return Container(

                    height:rdvsList[index].sc1!=" " || rdvsList[index].sc2!=" "?  660: 220,
                    //  width: 160,
                    child: Card(
                         color: Color(clr)  ,
                      shape: RoundedRectangleBorder( //<-- SEE HERE
                        side: BorderSide(
                          color: Colors.blue,
                          width: 1,

                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),            //  color:  Color(fknclr),
                      child: ListTile(

                        onTap: () {

                         Navigator.push(context,  MaterialPageRoute(  builder: (context) => EditRdv(pt: rdvsList[index], isadmin: isadmn, admin: widget.admin, onLogout: widget.onLogout, )));
                          },


                        /* leading:          Container(
                    decoration: catsList[index].image==" "? BoxDecoration(image:DecorationImage( image:AssetImage("images/ct.png"), fit: BoxFit.fill) ):BoxDecoration(image:DecorationImage(image: MemoryImage(base64.decode(catsList[index].image as String)), fit: BoxFit.fill,) ) ,

                    width: 70,
                    height: 150,
              ),*/
                        title: Column( children: [Row( children: [
                          SizedBox(width: 10,), Text("\nDate: "+(rdvsList[index]!.date! ?? '')+"\n Heur: "+(rdvsList[index]!.time!.substring(10, 15) ?? '')+"\n Traitement: "+(rdvsList[index]!.trt ?? '')+"\n Statu: "+
                      (rdvsList[index]!.statu as String)+"\n Payment: "+(rdvsList[index]!.pay.toString() ?? '00.00' )+"\n Note: "+(rdvsList[index]!.note ?? '')+"\n Dr: "+(dntst.first.name.toString() ?? ''), style: TextStyle( fontWeight: FontWeight.bold,),),
                        ]),
                          SizedBox(height: 20,),
                            Row(children: [
                              rdvsList[index].sc1!=" " ? Column(children: [
                          Container(
                              decoration: rdvsList[index].sc1==" " ? null:BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image: MemoryImage(base64.decode(rdvsList[index].sc1 as String)),) ) ,
                              width: 500,
                              height: 400,
                              child:  InkWell(

                                  splashColor:Color(0xFFEEEEEE),
                                  onTap:(){
                                  //  openImage();
                                  },
                                 )),
                           Text("Scanner 1"),]): Container(),
                           SizedBox(width: 50,),

                              rdvsList[index].sc2!=" " ? Column(children: [
                            Container(
                                decoration: rdvsList[index].sc2==" " ? null:BoxDecoration(image:DecorationImage(fit: BoxFit.fill, image: MemoryImage(base64.decode(rdvsList[index].sc2 as String)),) ) ,
                                width: 500,
                                height: 400,
                                child:  InkWell(

                                    splashColor:Color(0xFFEEEEEE),
                                    onTap:(){
                                      //  openImage();
                                    },
                                    )),
                                      Text("scanner 2"),],): Container(),])
                        ]),// subtitle: Text((catsList[index].name ?? '')+"\n "+ (catsList[index].robe as String)),

                        trailing:
                        /*IconButton(
                          onPressed: () {
                            // Implement the logic to download the ordonnance as a PDF
                            Navigator.push( context, MaterialPageRoute( builder: (context) => EditRdv(pt: rdvsList[index],) ));
                         //   _downloadOrdonnanceAsPdf(rdvsList[index]);
                          },
                          icon: Icon(Icons.edit, color: Colors.green,),
                        ),*/
                     isadmn=='yes'?    Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Implement the logic to download the ordonnance as a PDF
                              Navigator.push( context, MaterialPageRoute( builder: (context) => EditRdv(pt: rdvsList[index], isadmin: isadmn,admin: widget.admin, onLogout: widget.onLogout,) ));
                              //   _downloadOrdonnanceAsPdf(rdvsList[index]);
                            },
                            icon: Icon(Icons.edit, color: Colors.green,),
                          ),
                          IconButton(
                            onPressed: () {
                              print(rdvsList[index].sc1);
                              // Implement the logic to download the ordonnance as a PDF
                              _downloadOrdonnanceAsPdf(rdvsList[index], "Dr: "+dntst.first.name.toString(), ptnt.first);
                            },
                            icon: Icon(Icons.download),
                          ),
                          IconButton(
                            onPressed: () {
                              // Implement the logic to print the ordonnance
                              setState(() {
                                _deleteFormDialog( rdvsList[index]!.id);
                                print(rdvsList[index]!.id);
                                // getAllCats();
                                getRdvs();

                              });
                             // _printOrdonnance(rdvsList[index]);
                            },
                            icon: Icon(Icons.delete, color: Colors.red,),
                          ),
                        ],
                      ):null,

                    /*    IconButton(

                          onPressed: () {
                            Navigator.push( context, MaterialPageRoute( builder: (context) => EditRdv( pt: rdvsList[index])));
                            /*   Navigator.push( context, MaterialPageRoute( builder: (context) => Editcat( ct: catsList[index]!,
                            ))).then((data) {
                              if (data != null) {
                                //   catsList();
                                _showSuccessSnackBar(
                                    'Chat modifee');
                              }
                              //    getAllCats();
                              getCats();
                            });*/
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.teal,
                          ),
                        ),*/
                      ),
                    ));
              })),


    );
  }
}