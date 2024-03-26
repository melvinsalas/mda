import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mda/bloc/reviews_bloc.dart';
import 'package:mda/models/review.dart';
import 'package:mda/models/search.dart';

class RestaurantDetail extends StatelessWidget {
  final Business restaurant;

  const RestaurantDetail({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: restaurant.imageUrl,
            placeholder: (context, url) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
            imageBuilder: (context, imageProvider) => AspectRatio(
              aspectRatio: 3 / 1,
              child: Image(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              restaurant.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              restaurant.phone,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star),
                Text(
                  restaurant.rating.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Rate this restaurant'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                            'How many stars do you give to this restaurant?'),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) {
                            final review = Review(
                              restaurantName: restaurant.name,
                              restaurantAlias: restaurant.alias,
                              score: rating,
                            );
                            context.read<ReviewBloc>().add(AddReview(review));
                            context.read<ReviewBloc>().add(ReviewLoadEvent());
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: const Text('Rate this restaurant'),
          ),
        ],
      ),
    );
  }
}
