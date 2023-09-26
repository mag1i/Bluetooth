/*    First and last name
    Date of birth
    Gender
    Phone number
    Email address
    Physical address
    Medical history (including allergies, medications, and previous procedures)
    Insurance information (if applicable)*/
import 'dart:ffi';

class Patient {
  int? id;
  String? phone;
  String? gender;
  String? name;
  String? email;
  String? address;
  String? birth;
//  int? isadopt;
  String? insurance;

  catMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id?? null;
    mapping['phone'] = phone?? "+213";
    mapping['name'] = name!;
    mapping['email'] = email!;
    mapping['gender'] = gender ?? "Male";
    mapping['address'] = address!;
    mapping['birth'] = birth!;
    mapping['insurance'] = insurance!;
   // mapping['isadopt'] = isadopt!;

    return mapping;
  }

}