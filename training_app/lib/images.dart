class Images {
  int? id;
  late String name;
  late String image;

  Images(this.name, this.image);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  Images.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
  }
}
