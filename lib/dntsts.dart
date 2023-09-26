

class Dentists {
  int? id;
  String? name;
  String? specialization;
  String? email;
  String? phone;
  String? adress;
  String? Availability;
  String? desc;
  String? image;
  DentistsMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id?? null;
    mapping['name'] = name?? " ";
    mapping['specialization'] = specialization?? " ";
    mapping['email'] = email!;
    mapping['phone'] = phone?? " ";
    mapping['adress'] = adress ?? "Male";
    mapping['Availability'] = Availability;
    mapping['desc'] = desc;
    mapping['image'] = image;


    return mapping;
  }

}