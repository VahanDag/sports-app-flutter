import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sports_app/core/enums.dart';
import 'package:sports_app/models/fixture_matches.dart';
import 'package:sports_app/models/standings.dart';

mixin FootballService {
  static const String url = "https://api.football-data.org/v4";
  static const String apiKey = 'YOUR_API_KEY_HERE'; // Enter your API key
  static const Map<String, String> headers = {"X-Auth-Token": apiKey};
  static Future<List<Standing>> standings(LeagueCode leagueCode) async {
    final response = await http.get(Uri.parse("$url/competitions/${leagueCode.name}/standings"), headers: headers);

    if (response.statusCode == 200) {
      final List<Standing> model = [];
      final convertToMap = json.decode(response.body);
      for (var team in convertToMap['standings'][0]['table']) {
        model.add(Standing.fromMap(team));
      }
      return model;
    } else {
      return [];
    }
  }

  static Future<List<MatchModel>> matchFixture(LeagueCode leagueCode) async {
    final response =
        await http.get(Uri.parse('$url/competitions/${leagueCode.name}/matches?status=SCHEDULED'), headers: headers);
    final convertedMatches = json.decode(response.body);
    if (response.statusCode == 200) {
      final List<MatchModel> model = [];
      for (var match in convertedMatches['matches']) {
        model.add(MatchModel.fromMap(match));
      }
      return model;
    } else {
      return [];
    }
  }
}
