import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/bloc/category_bloc.dart';
import 'package:mda/widgets/mistery_restaurant.dart';

class MisteryScreen extends StatelessWidget {
  const MisteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mistery Search')),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
            final categories =
                state.categories.where((e) => e.isSelected).toList();
            return MisteryRestaurant(categories: categories);
          } else {
            Navigator.of(context).pop();
            return const Text('No categories found');
          }
        },
      ),
    );
  }
}
