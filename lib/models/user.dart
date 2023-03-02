class User {
  User({
    this.userId,
    this.userName,
    this.userPass,
    this.userPhone,
    this.userAddress,
  });

  User.fromJson(dynamic json) {
    userId = json['id'];
    userName = json['userName'];
    userPass = json['userPass'];
    userPhone = json['userPhone'];
    userAddress = json['userAddress'];
  }

  num? userId;
  String? userName;
  String? userPass;
  String? userPhone;
  String? userAddress;

  User copyWith({
    num? id,
    String? userName,
    String? userPass,
    String? userPhone,
    String? userAddress,
  }) =>
      User(
        userId: id ?? this.userId,
        userName: userName ?? this.userName,
        userPass: userPass ?? this.userPass,
        userPhone: userPhone ?? this.userPhone,
        userAddress: userAddress ?? this.userAddress,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = userId;
    map['userName'] = userName;
    map['userPass'] = userPass;
    map['userPhone'] = userPhone;
    map['userAddress'] = userAddress;
    return map;
  }

}
