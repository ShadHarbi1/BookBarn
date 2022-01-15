class User {
  String id;
  String name;
  String email;
  String createdAt;
  User({this.id, this.name, this.createdAt, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
