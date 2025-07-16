import 'package:eduwlc/models/book_category.dart';

class Book {
  final int id;
  final String title;
  final int categoryId;
  final BookCategory category;
  final String author;
  final String isbn;
  final int publicationYear;
  final String publisher;
  final int quantity;
  final String description;
  final String? coverImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Book({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.category,
    required this.author,
    required this.isbn,
    required this.publicationYear,
    required this.publisher,
    required this.quantity,
    required this.description,
    this.coverImage,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      categoryId: json['category_id'],
      category: BookCategory.fromJson(json['category']),
      author: json['author'],
      isbn: json['isbn'],
      publicationYear: json['publication_year'],
      publisher: json['publisher'],
      quantity: json['quantity'],
      description: json['description'],
      coverImage: json['cover_image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt:
          json['deleted_at'] != null
              ? DateTime.parse(json['deleted_at'])
              : null,
    );
  }
}
