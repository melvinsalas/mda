import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:mda/bloc/restaurant_bloc.dart';
import 'package:mda/models/search.dart';
import 'package:mda/widgets/restaurant_detail.dart';

class RouletteRestaurant extends StatefulWidget {
  final List<Category> categories;

  const RouletteRestaurant({super.key, required this.categories});

  @override
  State<RouletteRestaurant> createState() => _RouletteRestaurantState();
}

class _RouletteRestaurantState extends State<RouletteRestaurant> {
  bool showResult = false;
  int randomIndex = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    StreamController<int> controller = StreamController<int>();

    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (BuildContext context, RestaurantState state) {
        if (state is RestaurantLoaded) {
          int randomValue = randomIndex % state.restaurants.length;
          controller.add(randomValue);
          if (showResult) {
            return RestaurantDetail(restaurant: state.restaurants[randomValue]);
          }

          var fourtuneItems = state.restaurants
              .map((e) => FortuneItem(child: Text(e.name)))
              .toList();
          return Padding(
            padding: const EdgeInsets.all(64),
            child: FortuneWheel(
              selected: controller.stream,
              items: fourtuneItems,
              onAnimationEnd: () {
                setState(() {
                  showResult = true;
                });
              },
            ),
          );
        }

        if (state is RestaurantError) return Text(state.message);
        if (state is RestaurantInit) {
          BlocProvider.of<RestaurantBloc>(context).add(
            FetchRestaurants(categories: widget.categories),
          );
          return const Text('Loading restaurant...');
        }
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Wait for the best experience...'),
            ],
          ),
        );
      },
    );
  }
}
