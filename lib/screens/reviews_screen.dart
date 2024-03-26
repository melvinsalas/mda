import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/bloc/reviews_bloc.dart';
import 'package:mda/widgets/review_list.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded),
            onPressed: () {
              context.read<ReviewBloc>().add(ReviewCleanEvent());
              context.read<ReviewBloc>().add(ReviewLoadEvent());
            },
          ),
        ],
      ),
      body: const ReviewList(),
    );
  }
}
