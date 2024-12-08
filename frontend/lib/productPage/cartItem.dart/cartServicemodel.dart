class Cartservicemodel {
  int? id;
  String? pet;
  String? service;
  int? price;
  String? image;

  Cartservicemodel({this.id, this.pet, this.service, this.price, this.image});

  Cartservicemodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pet = json['pet'];
    service = json['service'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pet'] = this.pet;
    data['service'] = this.service;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}