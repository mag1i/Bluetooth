import 'package:flutter/material.dart';

import 'Patient.dart';
class PatientDetailsScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailsScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Center(
        child:Container( child: Row(children: [
          SizedBox(width: 40,),
          Column(children: [
            SizedBox(height: 50,),
          Text('Patient ID: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
          Text('Name : ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),SizedBox(height: 20,),
          Text('Email : ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),SizedBox(height: 20,),
          Text('Birth : ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),SizedBox(height: 20,),
          Text('Gender : ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),SizedBox(height: 20,),
          Text('Address : ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),SizedBox(height: 20,),
          Text('Phone : ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],),SizedBox(width:30,),
      Column(children: [
        SizedBox(height: 50,),
        Text('${patient.id}', style: TextStyle(fontSize: 16,) ),SizedBox(height: 20,),
        Text('${patient.name}', style: TextStyle(fontSize: 16,) ),SizedBox(height: 20,),
        Text('${patient.email}', style: TextStyle(fontSize: 16,) ),SizedBox(height: 20,),
        Text('${patient.insurance}', style: TextStyle(fontSize: 16,) ),SizedBox(height: 20,),
        Text('${patient.birth}', style: TextStyle(fontSize: 16,) ),SizedBox(height: 20,),
        Text('${patient.gender}', style: TextStyle(fontSize: 16,) ),SizedBox(height: 20,),
        Text('${patient.address}' , style: TextStyle(fontSize: 16,)),SizedBox(height: 20,),
        Text('${patient.phone}', style: TextStyle(fontSize: 16,) ),


      ],),
  ]
      ),
    )));
  }
}
