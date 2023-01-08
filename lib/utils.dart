enum DojahType { custom, verification, identification, liveness }
// ignore: constant_identifier_names
enum ReviewType { Automatic, Manual }

class UserData {
  String? firstName;
  String? lastName;
  String? dob;
  String? residenceCountry;

  UserData({
    this.firstName,
    this.lastName,
    this.dob,
    this.residenceCountry,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['dob'] = dob;
    data['residence_country'] = residenceCountry;
    return data;
  }
}
