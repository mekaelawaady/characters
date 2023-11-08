import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simpson_characters/Models/character_model.dart';
import 'package:simpson_characters/Utils/size_config.dart';

class CharacterDetails extends StatefulWidget {
  final Character character;
  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(21),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenWidth(400),
              child: CachedNetworkImage(
                imageUrl: widget.character.image,
                fit: BoxFit.fill,
                placeholder: (context, val) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: getProportionateScreenWidth(400),
                      color: Colors.white,
                    ),
                  );
                },
                errorWidget: (context, string, object) {
                  return Image.asset(
                    'assets/no_image.png',
                    width: double.infinity,
                    height: getProportionateScreenWidth(400),
                  );
                },
              ),
            ),
            buildVerticalSpace(12),
            Text(
              widget.character.description,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: getProportionateScreenWidth(16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
