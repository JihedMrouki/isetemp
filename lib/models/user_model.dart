class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  UserModel({this.uid, this.email, this.firstName, this.secondName});

  //take data from seerver

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }
// sending data to fire
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firsName': firstName,
      'secondName': secondName,
    };
  }
}
