class User {
  User({
      this.id, 
      this.userImage, 
      this.userName, 
      this.userPass, 
      this.userPhone, 
      this.userAddress,});

  User.fromJson(dynamic json) {
    id = json['id'];
    userImage = json['userImage'];
    userName = json['userName'];
    userPass = json['userPass'];
    userPhone = json['userPhone'];
    userAddress = json['userAddress'];
  }
  num? id;
  String? userImage;
  String? userName;
  String? userPass;
  String? userPhone;
  String? userAddress;
User copyWith({  num? id,
  String? userImage,
  String? userName,
  String? userPass,
  String? userPhone,
  String? userAddress,
}) => User(  id: id ?? this.id,
  userImage: userImage ?? this.userImage,
  userName: userName ?? this.userName,
  userPass: userPass ?? this.userPass,
  userPhone: userPhone ?? this.userPhone,
  userAddress: userAddress ?? this.userAddress,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userImage'] = userImage;
    map['userName'] = userName;
    map['userPass'] = userPass;
    map['userPhone'] = userPhone;
    map['userAddress'] = userAddress;
    return map;
  }

}