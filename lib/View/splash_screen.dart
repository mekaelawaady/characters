import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simpson_characters/Providers/characters_provider.dart';
import 'package:simpson_characters/Utils/size_config.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  final String from;
  const SplashScreen({super.key, required this.from});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    fetchCharacters();
    super.initState();
  }

  Future<void> fetchCharacters() async {
    try {
      await Provider.of<CharacterProvider>(context, listen: false).fetchData();
      Get.offAll(() => HomeScreen(
            from: widget.from,
          ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.from} Characters',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(34),
                fontWeight: FontWeight.w800,
              ),
            ),
            buildVerticalSpace(21),
            Text(
              'Please wait while data is fetched.....',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
