class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  // Membuat factory constructor untuk memparsing JSON menjadi objek Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name_category'],
    );
  }
}
