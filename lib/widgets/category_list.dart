import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/bloc/category_bloc.dart';
import 'package:mda/models/search.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  Widget _buildCategoryList(List<Category> categories) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title:
                Text('${categories[index].title} (${categories[index].count})'),
            value: categories[index].isSelected,
            onChanged: (bool? value) {
              context
                  .read<CategoryBloc>()
                  .add(SelectCategoryEvent(categories[index], value ?? false));
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoaded) {
          final categories = (state).categories;

          if (categories.isEmpty) return const Text('No categories found');

          return Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Categories'),
              ),
              _buildCategoryList(categories)
            ],
          );
        }

        if (state is CategoryError) return Text(state.message);
        if (state is CategoryInit) return const Text('Please enter a location');
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading categories...'),
            ],
          ),
        );
      },
    );
  }
}
