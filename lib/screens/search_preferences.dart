import 'package:flutter/material.dart' hide SearchBar;
import 'package:mda/widgets/category_list.dart';
import 'package:mda/widgets/search_bar.dart';
import 'package:mda/widgets/selection_buttons.dart';

class SearchPreferences extends StatelessWidget {
  const SearchPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant')),
      body: Column(
        children: <Widget>[
          SearchBar(),
          const Expanded(child: CategoryList()),
          const SelectionButtons(),
        ],
      ),
    );
  }
}
