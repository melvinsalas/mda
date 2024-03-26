import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUtils {
  static Future<String> getData() async {
    await dotenv.load(fileName: ".env");

    /// get location from shared preferences
    final cityName = await SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('location') ?? 'Dublin';
    });
    final url =
        'https://api.yelp.com/v3/businesses/search?location=$cityName&sort_by=best_match&limit=50';
    final token = dotenv.env['API_TOKEN'];

    /// Fetch data from the API
    final jsonString = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    ).then((response) {
      return response.body;
    });

    return jsonString;
  }
}
