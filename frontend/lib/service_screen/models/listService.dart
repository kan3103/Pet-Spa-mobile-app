class listService {
  String? name;
  List<Orders>? orders;
  int? type;

  listService({this.name, this.orders, this.type});

  listService.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Orders {
  int? id;
  int? status;
  String? pet;
  String? service;

  Orders({this.id, this.status, this.pet, this.service});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    pet = json['pet'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['pet'] = this.pet;
    data['service'] = this.service;
    return data;
  }
}