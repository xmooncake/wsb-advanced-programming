import 'dart:developer';

import 'package:lab02/data/mockup/mockup.dart';

void main() {
  log(Mockup.books.first.getFinalRatingWithReviewCountString());

  log(Mockup.readers.last.toString());
  log(Mockup.readers.first.getUserReviews().length.toString());
}
