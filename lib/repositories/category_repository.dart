import 'package:mda/models/search.dart';
import 'package:mda/utils/api_utils.dart';

class CategoryRepository {
  static Future<List<Category>> getCategories() async {
    final search = searchFromJson(await ApiUtils.getData());

    final categoriesList = search.businesses.map((e) => e.categories).toList();

    final categories = categoriesList.expand((element) => element).toList();

    final Map<String, int> categoryCountMap = {};
    for (var category in categories) {
      categoryCountMap[category.alias] =
          (categoryCountMap[category.alias] ?? 0) + 1;
    }

    final sortedCategories = categoryCountMap.entries
        .map((entry) => Category(
              alias: entry.key,
              title: categories
                  .firstWhere((category) => category.alias == entry.key)
                  .title,
              isSelected: false,
              count: entry.value,
            ))
        .toList()
      ..sort((a, b) => b.count.compareTo(a.count));

    return sortedCategories;
  }
}
