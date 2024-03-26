import 'dart:math';

import 'package:mda/models/search.dart';
import 'package:mda/utils/api_utils.dart';

class RestaurantRepository {
  static Future<List<Business>> getRestaurantsByCategory(
    List<Category> categories,
  ) async {
    final search = searchFromJson(await ApiUtils.getData());

    final businesses = search.businesses
        .where((business) => business.categories.any((category) =>
            categories.any((selectedCategory) =>
                selectedCategory.alias == category.alias)))
        .toList();

    return businesses;
  }

  static Future<Business> getRandomRestaurant(
    List<Category> categories,
  ) async {
    final restaurants = await getRestaurantsByCategory(categories);
    final randomIndex = Random().nextInt(restaurants.length);
    final randomRestaurant = restaurants[randomIndex];
    return randomRestaurant;
  }

  static Future<List<Business>> getRandomRestaurants(
    List<Category> categories, {
    required int maxCount,
  }) async {
    final random = Random();
    final randomRestaurants = <Business>[];

    final restaurants = await getRestaurantsByCategory(categories);

    if (maxCount > restaurants.length) return restaurants;

    // Create a copy of the original list to avoid modifying it directly
    final List<Business> remainingRestaurants = List.from(restaurants);

    for (var i = 0; i < maxCount; i++) {
      if (remainingRestaurants.isEmpty) break;

      final randomIndex = random.nextInt(remainingRestaurants.length);
      final randomRestaurant = remainingRestaurants[randomIndex];

      randomRestaurants.add(randomRestaurant);

      // Remove the selected restaurant from the remaining list to avoid repetition
      remainingRestaurants.remove(randomRestaurant);
    }
    return randomRestaurants;
  }
}
