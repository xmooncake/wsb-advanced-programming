// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'package:lab02/data/mockup/mockup.dart';
import 'package:lab02/data/models/book.dart';
import 'package:lab02/data/models/operation.dart';
import 'package:lab02/data/models/review.dart';

abstract class _Person extends Equatable {
  final int id;
  final String name;

  const _Person({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'Dane użytkownika: (id: $id, name: $name)';

  @override
  bool get stringify => true;
}

class Author extends _Person {
  const Author({
    required super.id,
    required super.name,
    this.books = const [],
  });

  final List<Book> books;

  // Klasa Autor powinna mieć metodę wyświetlającą wszystkie książki (posortowane) autora oraz ich liczbę ocen oraz średnią.
  void printBooks() {
    if (books.isNotEmpty) {
      books.sort(
        (a, b) => a.title.compareTo(b.title),
      );

      log('Książki tego autora:');

      for (final book in books) {
        book.toString();
      }
    }
  }

  // Klasa Autor powinna ponadto mieć możliwość dodawania nowych książek, które są autorstwa tego samego autora.
  void addBook(
    String title,
  ) {
    books.add(
      Book(
        id: Mockup.books.length,
        title: title,
        author: this,
        yearPublished: DateTime.now().year.toString(),
      ),
    );
  }

  @override
  List<Object?> get props => [id];
}

class Reader extends _Person {
  const Reader({
    required super.id,
    required super.name,
    this.operations = const [],
  });

  final List<Operation> operations;

  @override
  String toString() =>
      'Dane użytkownika: \n id: $id, name: $name \n Liczba wypożyczonych książek: ${operations.length} \n Liczba książek powyżej 2tyg: ${_overdueBooksCount()} ';

  List<Operation> get operationHistory => operations;

  List<Operation> get unreturnedBooks {
    final unreturnedBooks = operations
        .where(
          (Operation element) => element.returnedAt == null,
        )
        .toList();

    return unreturnedBooks;
  }

  int _overdueBooksCount() {
    int counter = 0;

    final dateTimeNow = DateTime.now();
    final unreturnedBooks = this.unreturnedBooks;

    for (final book in unreturnedBooks) {
      final difference = dateTimeNow.difference(book.borrowedAt);
      if (difference.inDays >= 12) {
        counter++;
      }
    }

    return counter;
  }

  // Klasa Czytelnik ponadto powinna mieć możliwość wystawienia recenzji i oceny książki (klasa Recenzja).
  void reviewBook(int bookID, int mark, String review) {
    Mockup.reviews.add(
      Review(
        id: Mockup.reviews.length,
        mark: mark,
        book: Mockup.books.firstWhere((element) => element.id == id),
        reader: this,
        review: review,
      ),
    );
  }

  List<Review> getUserReviews() {
    return Mockup.reviews.where((element) => element.reader == this).toList();
  }

  @override
  List<Object?> get props => [id];
}
