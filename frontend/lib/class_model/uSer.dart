class Profile {
  String? name;
  String? birthday;
  String? address;
  String? avatar;
  String? email;

  Profile({this.name, this.birthday, this.address, this.avatar, this.email});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthday = json['birthday'];
    address = json['address'];
    avatar = json['avatar'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    return data;
  }
}
