class BookCategory {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  BookCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory BookCategory.fromJson(Map<String, dynamic> json) {
    return BookCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt:
          json['deleted_at'] != null
              ? DateTime.parse(json['deleted_at'])
              : null,
    );
  }
}
