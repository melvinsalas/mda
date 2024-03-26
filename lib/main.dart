import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/bloc/category_bloc.dart';
import 'package:mda/bloc/restaurant_bloc.dart';
import 'package:mda/bloc/reviews_bloc.dart';
import 'package:mda/screens/reviews_screen.dart';
import 'package:mda/screens/search_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(create: (_) => CategoryBloc()),
        BlocProvider<RestaurantBloc>(create: (_) => RestaurantBloc()),
        BlocProvider<ReviewBloc>(
          create: (_) => ReviewBloc()..add(ReviewLoadEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'MDA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getScreen() {
    if (_selectedIndex == 1) return const ReviewScreen();
    return const SearchPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Reviews',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
