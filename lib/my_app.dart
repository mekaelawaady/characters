import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simpson_characters/View/splash_screen.dart';

import 'Providers/characters_provider.dart';
import 'Utils/size_config.dart';

class MyApp extends StatelessWidget {
  final String from;
  const MyApp({Key? key, required this.from}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CharacterProvider>(
          create: (context) => CharacterProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          from: from,
        ),
      ),
    );
  }
}
