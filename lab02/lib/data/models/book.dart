import 'package:equatable/equatable.dart';
import 'package:lab02/data/mockup/mockup.dart';
import 'package:lab02/data/models/person.dart';

class Book extends Equatable {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.yearPublished,
  });

  final int id;
  final String title;
  final Author author;
  final String yearPublished;

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'Tytuł: $title, Data wydania: $yearPublished \n Autor: ${author.name} \n $getFinalRatingWithReviewCountString()';
  }

  // Klasa Książka powinna mieć metodę wyświetlającą liczbę ocen i ich średnią ocenę.
  String getFinalRatingWithReviewCountString() {
    double finalRating = 0;
    final sortedReviews = Mockup.reviews
        .where(
          (element) => element.book.id == id,
        )
        .toList();

    if (sortedReviews.isNotEmpty) {
      for (final review in sortedReviews) {
        finalRating += review.mark;
      }

      finalRating = finalRating / sortedReviews.length;

      return 'Liczba ocen i średnia ocenia tej książki \n Liczba ocen ${sortedReviews.length} \n Średnia ocenia $finalRating';
    }

    return 'Brak ocen tej książki';
  }
}
