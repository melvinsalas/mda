import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/models/review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInit()) {
    on<ReviewLoadEvent>(_onLoadReviews);
    on<AddReview>(_addReview);
    on<ReviewCleanEvent>(_onCleanReviews);
  }

  void _onCleanReviews(_, emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('reviews');
      emit(ReviewInit());
    } catch (e) {
      emit(ReviewError('Failed to clean reviews: $e'));
    }
  }

  void _addReview(event, emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> existingReviews = prefs.getStringList('reviews') ?? [];
      bool replaced = false;
      for (int i = 0; i < existingReviews.length; i++) {
        String reviewString = existingReviews[i];
        List<String> reviewParts = reviewString.split(',');
        if (reviewParts.length >= 3 &&
            reviewParts[0] == event.review.restaurantAlias) {
          existingReviews[i] = event.review.toString();
          replaced = true;
          break;
        }
      }
      if (!replaced) existingReviews.add(event.review.toString());
      await prefs.setStringList('reviews', existingReviews);
    } catch (e) {
      emit(ReviewError('Failed to add review: $e'));
    }
  }

  void _onLoadReviews(_, emit) async {
    try {
      emit(ReviewLoading());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> reviewStrings = prefs.getStringList('reviews') ?? [];

      List<Review> reviews = reviewStrings.map((reviewString) {
        List<String> parts = reviewString.split(',');
        if (parts.length >= 3) {
          return Review(
            restaurantAlias: parts[0],
            restaurantName: parts[1],
            score: double.tryParse(parts[2]) ?? 0,
          );
        } else {
          return Review.empty();
        }
      }).toList();

      emit(ReviewLoaded(reviews));
    } catch (e) {
      emit(ReviewError('Failed to load reviews: $e'));
    }
  }
}

abstract class ReviewEvent {}

class ReviewLoadEvent extends ReviewEvent {}

class ReviewCleanEvent extends ReviewEvent {}

class AddReview extends ReviewEvent {
  final Review review;

  AddReview(this.review);
}

@immutable
abstract class ReviewState {}

class ReviewInit extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  ReviewLoaded(this.reviews);
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);
}
