import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/bloc/restaurant_bloc.dart';
import 'package:mda/models/search.dart';
import 'package:mda/widgets/restaurant_detail.dart';

class MisteryRestaurant extends StatelessWidget {
  final List<Category> categories;

  const MisteryRestaurant({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (BuildContext context, RestaurantState state) {
        if (state is RestaurantLoaded) {
          return RestaurantDetail(restaurant: state.restaurants.first);
        }

        if (state is RestaurantError) return Text(state.message);
        if (state is RestaurantInit) {
          BlocProvider.of<RestaurantBloc>(context).add(
            FetchRestaurant(categories: categories),
          );
          return const Text('Loading restaurant...');
        }
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Searching the best experience for you...'),
            ],
          ),
        );
      },
    );
  }
}
