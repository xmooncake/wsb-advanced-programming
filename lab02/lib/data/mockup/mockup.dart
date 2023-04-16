// ignore_for_file: avoid_classes_with_only_static_members

import 'package:lab02/data/models/book.dart';
import 'package:lab02/data/models/operation.dart';
import 'package:lab02/data/models/person.dart';
import 'package:lab02/data/models/review.dart';

class Mockup {
  static List<Reader> readers = [
    const Reader(id: 0, name: 'Reader1'),
    Reader(
      id: 1,
      name: 'Reader2',
      operations: [
        Operation(
          book: books.first,
          borrowedAt: DateTime(2023),
          returnedAt: DateTime(2023, 2),
        ),
        Operation(
          book: books.first,
          borrowedAt: DateTime(2023, 2),
        ),
      ],
    ),
  ];

  static List<Author> authors = [
    const Author(id: 0, name: 'Author1'),
    const Author(id: 1, name: 'Author2'),
  ];

  static List<Book> books = [
    Book(
      id: 0,
      title: 'Book1',
      author: authors.first,
      yearPublished: '2012',
    ),
    Book(
      id: 1,
      title: 'Book2',
      author: authors.last,
      yearPublished: '2014',
    ),
  ];

  static List<Review> reviews = [
    Review(
      id: 0,
      mark: 5,
      book: books.first,
      reader: readers.first,
      review: 'review',
    ),
    Review(
      id: 1,
      mark: 3,
      book: books.first,
      reader: readers.first,
      review: 'review',
    ),
    Review(
      id: 2,
      mark: 1,
      book: books.first,
      reader: readers.first,
      review: 'review',
    ),
    Review(
      id: 3,
      mark: 1,
      book: books.first,
      reader: readers.first,
      review: 'review',
    ),
  ];
}
