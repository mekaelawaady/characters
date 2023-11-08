import 'package:flutter/cupertino.dart';
import 'package:simpson_characters/Control/global.dart';

import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.apiUrl =
      'http://api.duckduckgo.com/?q=the+wire+characters&format=json';
  runApp(
    const MyApp(
      from: 'The Wire',
    ),
  );
}
