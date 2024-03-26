import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/bloc/reviews_bloc.dart';
import 'package:mda/models/review.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  Widget _buildReviewList(List<Review> reviews) {
    return SingleChildScrollView(
      child: Column(
        children: reviews
            .map(
              (review) => ListTile(
                title: Text(review.restaurantName),
                subtitle: Text('Score: ${review.score}'),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildReviewEmpty() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cleaning_services_rounded, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No reviews found'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoaded) {
          final reviews = (state).reviews;
          if (reviews.isEmpty) return _buildReviewEmpty();
          return _buildReviewList(reviews);
        }

        if (state is ReviewError) return Text(state.message);
        if (state is ReviewInit) return _buildReviewEmpty();
        return const CircularProgressIndicator();
      },
    );
  }
}
