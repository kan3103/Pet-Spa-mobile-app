class orderServiceDetail {
  int? id;
  int? status;
  String? pet;
  String? service;
  String? image;
  String? description;

  orderServiceDetail(
      {this.id,
      this.status,
      this.pet,
      this.service,
      this.image,
      this.description});

  orderServiceDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    pet = json['pet'];
    service = json['service'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['pet'] = this.pet;
    data['service'] = this.service;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}