import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:simpson_characters/Control/global.dart';

import '../Models/character_model.dart';

class CharacterProvider with ChangeNotifier {
  List<Character> _characters = [];

  bool _isFetched = false;

  List<Character> get characters => _characters;

  bool get isFetched => _isFetched;

  String baseUrl = 'https://duckduckgo.com';

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(Global.apiUrl),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final relatedTopics = data['RelatedTopics'];

      for (final characterData in relatedTopics) {
        final text = characterData['Text'];
        final parts = text.split(' - ');
        final name = parts[0];
        final description = parts.length > 1 ? parts[1] : '';
        String firstUrl = characterData['FirstURL'];
        String url = characterData['Icon']['URL'];

        String icon = baseUrl + url;

        _characters.add(Character(
          firstUrl: firstUrl,
          name: name,
          description: description,
          image: icon,
        ));
      }
      _isFetched = true;
    }
  }
}
