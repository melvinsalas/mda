import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/bloc/category_bloc.dart';
import 'package:mda/bloc/restaurant_bloc.dart';
import 'package:mda/screens/mistery_screen.dart';
import 'package:mda/screens/roultette_screen.dart';

class SelectionButtons extends StatelessWidget {
  const SelectionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        var restaurantCount = 0;

        if (state is CategoryLoaded) {
          for (var category in state.categories) {
            if (category.isSelected) {
              restaurantCount += category.count;
            }
          }
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SelectionButtonStyle(
              symbol: "✨",
              text: "Mystery Search",
              onPressed: restaurantCount > 1
                  ? () {
                      context
                          .read<RestaurantBloc>()
                          .add(ResetRestaurantEvent());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MisteryScreen(),
                        ),
                      );
                    }
                  : null,
            ),
            SelectionButtonStyle(
              symbol: "🎊",
              text: 'Culinary Roulette',
              onPressed: restaurantCount > 1
                  ? () {
                      context
                          .read<RestaurantBloc>()
                          .add(ResetRestaurantEvent());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RouletteScreen(),
                        ),
                      );
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class SelectionButtonStyle extends StatelessWidget {
  const SelectionButtonStyle({
    super.key,
    this.onPressed,
    required this.text,
    required this.symbol,
  });

  final void Function()? onPressed;
  final String text;
  final String symbol;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 150,
            height: 100,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Positioned(
          child: Text(
            symbol,
            style: const TextStyle(fontSize: 48),
          ),
        ),
      ],
    );
  }
}
