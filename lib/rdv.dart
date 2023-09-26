/*    First and last name
    Date of birth
    Gender
    Phone number
    Email address
    Physical address
    Medical history (including allergies, medications, and previous procedures)
    Insurance information (if applicable)*/
import 'dart:ffi';

class Rdv {
  int? id;
  String? date;
  String? time;
  String? cas;
  String? statu;
  String? trt;
  String? note;
  int? dr;
  int? pt;
  double? pay;
  String? sc1;
  String? sc2;

  rdvMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id?? null;
    mapping['date'] = date?? " ";
    mapping['time'] = time!;
    mapping['cas'] = cas?? " ";
    mapping['statu'] = statu ?? "Male";
    mapping['treatment'] = trt;
    mapping['note'] = note;
    mapping['iddr'] = dr;
    mapping['idpt'] = pt;
    mapping['scanner1'] = sc1;
    mapping['scanner2'] = sc2;
    mapping['payment'] = pay;

    return mapping;
  }

}