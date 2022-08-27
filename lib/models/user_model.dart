class UserModel {
  final String first_name;
  final String last_name;
  final String email;
  final String uid;
  final String profile_picture;
  final String phone;
  String organization;

  UserModel(
      {required this.first_name,
      required this.last_name,
      required this.email,
      required this.uid,
      required this.profile_picture,
      required this.phone,
      this.organization = "1"});

//App - Firebase(Map)
  Map<String, dynamic> toJson() => {
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "uid": uid,
        "profile_picture": profile_picture,
        "phone": phone,
        "organization": organization
      };

  //Firebase(Map) - App(User)
  // static UserModel fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return UserModel(
  //       first_name: snapshot['first_name'],
  //       last_name: snapshot['last_name'],
  //       email: snapshot['email'],
  //       uid: snapshot['uid'],
  //       profile_picture: snapshot['profilePic'],
  //       phone: snapshot['phone']);
  // }
}
