import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/bloc/category_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBar extends StatelessWidget {
  SearchBar({super.key});

  /// Textfield controller
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Location...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              await SharedPreferences.getInstance().then((prefs) {
                prefs.setString('location', _controller.text);
              });
              // ignore: use_build_context_synchronously
              context.read<CategoryBloc>().add(LoadCategoriesEvent());
            },
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.search, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
