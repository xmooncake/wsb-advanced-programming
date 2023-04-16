// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:lab02/data/models/book.dart';
import 'package:lab02/data/models/person.dart';

class Review extends Equatable {
  const Review({
    required this.id,
    required this.mark,
    required this.book,
    required this.reader,
    required this.review,
  });

  final int id;
  final int mark;
  final Book book;
  final Reader reader;
  final String review;

  @override
  String toString() {
    return 'Review(id: $id, mark: $mark, book: $book, reader: $reader, review: $review)';
  }

  @override
  List<Object?> get props => [id];
}
