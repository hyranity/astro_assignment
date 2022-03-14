import 'dart:math';

import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/components/api/cocktail_api.dart';
import 'package:astro_assignment/components/api/meal_api.dart';
import 'package:astro_assignment/components/ui/circular_loader.dart';
import 'package:astro_assignment/components/ui/recipe_base.dart';
import 'package:astro_assignment/models/base.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map<dynamic, dynamic> arguments = {};

  BaseFoodDetails? details;
  late BaseApi api;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      loadArguments();
      loadApi();
      fetchDetails();
    });
  }

  void loadArguments() {
    arguments = ((ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map);
  }

  void loadApi() {
    var type = arguments["title"];

    if (type == "Food") {
      api = MealApi();
    } else {
      api = CocktailApi();
    }
  }

  void fetchDetails() async {
    var id = arguments["id"];
    var data = await api.getDetail(id);
    setState(() {
      details = data[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecipeBase(
        child: details == null ? CircularLoader() : detailsScreen());
  }

  Column detailsScreen() {
    return Column(
      children: [
        // Image
        Container(
          height: 300,
          width: double.infinity,
          child: Image.network(
            details!.strFoodThumb ?? "",
            fit: BoxFit.cover,
          ),
        ),
        buttonsRow(),
        const DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: TabBar(
            labelColor: Colors.red,
            tabs: [
              Tab(text: "Ingredients"),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
      ],
    );
  }

  Row buttonsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chat),
          onPressed: () {},
        ),
        Text(Random().nextInt(100).toString(),
            style:
                GoogleFonts.dosis(fontSize: 18, fontWeight: FontWeight.w600)),
        Flexible(child: Container()),
        IconButton(
          icon: Icon(Icons.star_outline_rounded, size: 35),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.bookmark_outline_rounded, size: 30),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.share_outlined, size: 30),
          onPressed: () {},
        ),
      ],
    );
  }
}
