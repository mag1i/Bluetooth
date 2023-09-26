import 'dart:io';
import 'dart:typed_data';
import 'package:dntst/main.dart';
import 'package:dntst/payment.dart';
import 'package:dntst/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'admin.dart';

import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';

import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';

import 'dentists list.dart';
class OrdonnanceDialog extends StatefulWidget {
  final Admin admin;
  final Function() onLogout;
  const OrdonnanceDialog({Key? key, required this.admin, required this.onLogout}) : super(key: key);

  @override
  State<OrdonnanceDialog> createState() => _OrdonnanceDialogState();
}

class _OrdonnanceDialogState extends State<OrdonnanceDialog> {

   _downloadOrdonnanceAsPdf() async {
    final ByteData assetImageByteData = await rootBundle.load('images/Bluetooth.png');

    final File imageFile = File('images/Bluetooth.png'); // Replace with the actual path to your image file
    final File phone = File('images/phn.png'); // Replace with the actual path to your image file
    final File lc = File('images/lc.png'); // Replace with the actual path to your image file
    final File bt = File('images/bt.png'); // Replace with the actual path to your image file

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

                  pw.Text('Cabinet Dentaire', style: pw.TextStyle( fontSize: 30, fontWeight: pw.FontWeight.bold ,  color: PdfColor.fromInt(0xFF81D4FA),  )),
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
                  pw.Text('dr: DR. TORCHI IMANE'),
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
                pw.Text('Nom et Prenom:        '),
                pw.Text('\nAge:        '),
                pw.Text('\n Sexe:        '),
                pw.Text('\nAdv:        '),
                pw.Text('\n\n\n\n\nTraitement:        '),
                pw.SizedBox(height: 320),
                pw.Row(children: [
                  pw.Text(('\n Date: '),   style: pw.TextStyle(
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
      await Printing.sharePdf(bytes: bytes, filename: 'Ordonnance.pdf');
    }


Future<void> logout(BuildContext context) async {
  // Call the logout function and execute the callback

  widget.onLogout();
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', " ");
  Navigator.of(context).pop(); // Pop the profile page from the navigation stack
}
List<bool> _isHovered = List.generate(2, (index) => false); // Adjust the size based on the number of icons
Repository rep = Repository();
late var admn= " ";
var _codeController = TextEditingController();
late bool validate=false;
late var _isHomeIconHovered= false;
late bool _isSettingsIconHovered=false;
late bool _threeIconHovered=false;
late bool _foorIconHovered=false;
late bool _fiveconHovered=false;
void _onHomeIconHover(bool isHovered) {
  setState(() {
    // Update the hover state for the home icon
    _isHomeIconHovered = isHovered;
  });
}
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
@override
Widget build(BuildContext context) {


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
                      Navigator.push( context, MaterialPageRoute( builder: (context) => MyApp(rep: rep, loggedInAdmin: widget.admin)));
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
                      Navigator.push( context, MaterialPageRoute( builder: (context) => listpayment()));},
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

              SizedBox(height: 20,),
              MouseRegion(
                onHover: (_) => _fiveIconHover(true),
                onExit: (_) => _fiveIconHover(false),
                child: Transform.scale(
                  scale: _fiveconHovered ? 2 : 1.0,
                  child: IconButton(
                    icon: Icon(Icons.description),
                    onPressed: () {

             //        Navigator.push( context, MaterialPageRoute( builder: (context) => OrdonnanceDialog()));
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
              appBar: AppBar( title: Text('Ordonnance vierge',)),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(height:20),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          _downloadOrdonnanceAsPdf();
                        });
                    }, child: Text("Odonance virge"),),

                    SizedBox(height:20),

                  ],
                ),
              ),
            ))]));
}
}
