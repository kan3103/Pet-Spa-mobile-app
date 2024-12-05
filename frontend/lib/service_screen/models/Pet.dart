class Pet {
  String? name;
  String? dob;
  String? description;
  String? image;
  bool? vaccinated;
  int? petType;

  Pet(
      {this.name,
      this.dob,
      this.description,
      this.image,
      this.vaccinated,
      this.petType});

  Pet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dob = json['dob'];
    description = json['description'];
    image = json['image'];
    vaccinated = json['vaccinated'];
    petType = json['pet_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['description'] = this.description;
    data['image'] = this.image;
    data['vaccinated'] = this.vaccinated;
    data['pet_type'] = this.petType;
    return data;
  }
}