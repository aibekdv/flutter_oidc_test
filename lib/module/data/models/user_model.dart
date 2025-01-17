class UserInfo {
  String? name;
  String? givenName;
  String? familyName;
  String? email;
  bool? emailVerified;
  String? website;
  String? sub;

  UserInfo({
    this.name,
    this.givenName,
    this.familyName,
    this.email,
    this.emailVerified,
    this.website,
    this.sub,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json["name"],
        givenName: json["given_name"],
        familyName: json["family_name"],
        email: json["email"],
        emailVerified: json["email_verified"],
        website: json["website"],
        sub: json["sub"],
      );
}
