import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/models/search.dart';
import 'package:mda/repositories/restaurant_repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInit()) {
    on<FetchRestaurants>(_onFetchRestaurants);
    on<FetchRestaurant>(_onFetchRestaurant);
    on<ResetRestaurantEvent>(_onResetRestaurant);
  }

  void _onResetRestaurant(_, Emitter<RestaurantState> emit) {
    emit(RestaurantInit());
  }

  Future<void> _onFetchRestaurant(
    FetchRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());

    var restaurant =
        await RestaurantRepository.getRandomRestaurant(event.categories);

    await Future.delayed(const Duration(seconds: 5), () {
      emit(RestaurantLoaded([restaurant]));
    });
  }

  void _onFetchRestaurants(event, emit) async {
    emit(RestaurantLoading());

    var restaurants = await RestaurantRepository.getRandomRestaurants(
      event.categories,
      maxCount: 10,
    );

    /// Wait for 5 to create a loading effect
    await Future.delayed(const Duration(seconds: 5), () {
      emit(RestaurantLoaded(restaurants.toList()));
    });
  }
}

abstract class RestaurantEvent {}

class LoadRestaurantEvent extends RestaurantEvent {}

class ResetRestaurantEvent extends RestaurantEvent {}

class FetchRestaurant extends RestaurantEvent {
  final List<Category> categories;

  FetchRestaurant({required this.categories});
}

class FetchRestaurants extends RestaurantEvent {
  final List<Category> categories;

  FetchRestaurants({required this.categories});
}

@immutable
abstract class RestaurantState {}

class RestaurantInit extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Business> restaurants;

  RestaurantLoaded(this.restaurants);
}

class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError(this.message);
}
