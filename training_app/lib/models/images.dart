class Images {
  int? id;
  late String name;
  late String images;

  Images(this.name, this.images);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': images,
    };
  }

  Images.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    images = map['image'];
  }
}
