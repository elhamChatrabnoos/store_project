class Tag {
  Tag({
    this.id,
    this.name,
  });

  Tag.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Tag copyWith({
    int? id,
    String? name,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
