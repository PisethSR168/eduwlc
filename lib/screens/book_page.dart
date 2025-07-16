import 'package:flutter/material.dart';
import 'package:eduwlc/models/book.dart';
import 'package:eduwlc/models/paginated_response.dart';
import 'package:eduwlc/services/book_service.dart';
import 'package:intl/intl.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late Future<PaginatedResponse<Book>> _booksFuture;
  final BookService _bookService = BookService();
  int _currentPage = 1;
  int _lastPage = 1;
  List<Book> _books = [];
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks({int page = 1}) async {
    setState(() {
      _isLoadingMore = true;
    });
    try {
      final response = await _bookService.fetchBooks(page: page);
      setState(() {
        _books.addAll(response.data);
        _currentPage = response.meta.currentPage;
        _lastPage = response.meta.lastPage;
        _isLoadingMore = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body:
          _books.isEmpty && _isLoadingMore
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _books.clear();
                    _currentPage = 1;
                  });
                  await _fetchBooks(page: 1);
                },
                child: ListView.builder(
                  itemCount: _books.length + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _books.length) {
                      if (_currentPage < _lastPage && !_isLoadingMore) {
                        _fetchBooks(page: _currentPage + 1);
                        return const Center(child: CircularProgressIndicator());
                      } else if (_isLoadingMore) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const SizedBox.shrink();
                      }
                    }

                    final book = _books[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Author: ${book.author}'),
                            Text('Category: ${book.category.name}'),
                            Text('ISBN: ${book.isbn}'),
                            Text('Publication Year: ${book.publicationYear}'),
                            Text('Publisher: ${book.publisher}'),
                            Text('Quantity: ${book.quantity}'),
                            Text('Description: ${book.description}'),
                            Text(
                              'Created At: ${DateFormat('yyyy-MM-dd HH:mm').format(book.createdAt)}',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
