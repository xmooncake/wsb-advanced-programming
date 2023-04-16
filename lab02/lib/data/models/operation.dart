// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lab02/data/models/book.dart';

class Operation {
  Book book;
  DateTime borrowedAt;
  DateTime? returnedAt;

  Operation({
    required this.book,
    required this.borrowedAt,
    this.returnedAt,
  });

  @override
  String toString() =>
      'Wypożyczenie (Tytuł książki: ${book.title}, Wypożyczono: $borrowedAt, Zwrócono: ${returnedAt ?? 'Nie zwróconol'})';

  Operation copyWith({
    DateTime? returnedAt,
  }) {
    return Operation(
      book: book,
      borrowedAt: borrowedAt,
      returnedAt: returnedAt ?? this.returnedAt,
    );
  }
}
