import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simpson_characters/Providers/characters_provider.dart';
import 'package:simpson_characters/Utils/size_config.dart';
import 'package:simpson_characters/View/details_screen.dart';

import '../Models/character_model.dart';

class HomeScreen extends StatefulWidget {
  final String from;
  const HomeScreen({super.key, required this.from});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final charactersProvider = Provider.of<CharacterProvider>(context);

    return OrientationBuilder(
      builder: (context, orientation) {
        SizeConfig().init(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.from} Characters'),
          ),
          body: CharacterListView(
            characters: charactersProvider.characters,
          ),
        );
      },
    );
  }
}

class CharacterListView extends StatelessWidget {
  final List<Character> characters;
  const CharacterListView({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return characters.isEmpty
        ? const Center(
            child: Text('we got error while fetching the characters'),
          )
        : LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 600) {
                // For big screen layouts
                return ListView.builder(
                  padding: EdgeInsets.all(getProportionateScreenWidth(21)),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];

                    return ExpansionTile(
                      iconColor: Colors.transparent,
                      title: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(5)),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(12),
                          horizontal: getProportionateScreenWidth(21),
                        ),
                        child: Text(
                          character.name,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(21),
                          ),
                        ),
                      ),
                      children: [
                        Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(21)),
                          child: Column(
                            children: [
                              Text(
                                'Description:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenWidth(14),
                                ),
                              ),
                              buildVerticalSpace(21),
                              Text(
                                character.description,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                ),
                              ),
                              buildVerticalSpace(21),
                              SizedBox(
                                // width: double.infinity,
                                height: getProportionateScreenWidth(400),
                                child: CachedNetworkImage(
                                  imageUrl: character.image,
                                  fit: BoxFit.fill,
                                  placeholder: (context, val) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            getProportionateScreenWidth(400),
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                  errorWidget: (context, string, object) {
                                    return Image.asset(
                                      'assets/no_image.png',
                                      // width: double.infinity,
                                      height: getProportionateScreenWidth(400),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // For mobile layouts
                return ListView.builder(
                  padding: EdgeInsets.all(getProportionateScreenWidth(21)),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => CharacterDetails(
                              character: character,
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(5),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          bottom: getProportionateScreenWidth(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(12),
                          horizontal: getProportionateScreenWidth(21),
                        ),
                        child: Text(
                          character.name,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(21),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
  }
}
