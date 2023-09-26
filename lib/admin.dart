class Admin {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? password;

  Admin({this.id, this.name, this.phone, this.email, this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }
  Admin.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    password = map['password'];
  }
}