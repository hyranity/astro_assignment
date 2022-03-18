import 'dart:math';

import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/components/api/cocktail_api.dart';
import 'package:astro_assignment/components/api/meal_api.dart';
import 'package:astro_assignment/components/ui/circular_loader.dart';
import 'package:astro_assignment/components/ui/ingredients_panel.dart';
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
  int activeTab = 0;
  late BaseApi api;

  var randomChats = Random().nextInt(100).toString();

  Color get getRedColor => Color(0xffDB5E56);

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
    api = BaseApi.getApi(arguments["title"]);
  }

  void fetchDetails() async {
    var id = arguments["id"];
    var data = await api.getDetail(id);
    setState(() {
      // If data is a list, get the first item, otherwise just use the data
      details = data is List ? data.first : data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecipeBase(
        child: details == null
            ? const CircularLoader(fullscreen: true)
            : detailsScreen());
  }

  Widget detailsScreen() {
    return Stack(
      children: [
        // Image section
        Stack(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                details!.strFoodThumb ?? "https://picsum.photos/200/300",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: getRedColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.play_arrow,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),

        whiteForeground()
      ],
    );
  }

  Container whiteForeground() {
    return Container(
      margin: EdgeInsets.only(top: 280),
      padding: EdgeInsets.only(
        top: 10,
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buttonsRow(),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            height: 1,
            color: Colors.grey[300],
          ),
          tabRow(),
          SizedBox(height: 20),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: tabResult()),
        ],
      ),
    );
  }

  Container tabRow() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          buttonTab("Ingredients", 0),
          buttonTab("Steps", 1),
          buttonTab("Nutrition", 2),
        ],
      ),
    );
  }

  Widget tabResult() {
    if (activeTab == 0) {
      return IngredientsPanel(details: details!);
    } else if (activeTab == 1) {
      return stepsTab();
    } else {
      return nutritionTab();
    }
  }

  Widget stepsTab() {
    // Get steps from details, show in container
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: details!.strInstructions!.split(".").length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.fiber_manual_record,
                          size: 10,
                          color: Colors.grey,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          details!.strInstructions!.split(".")[index].trim(),
                          style: GoogleFonts.dosis(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget nutritionTab() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Coming soon",
            style: GoogleFonts.dosis(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonTab(String data, int currentIndex) {
    bool isActive = activeTab == currentIndex;

    return Expanded(
      child: GestureDetector(
        // Update activeTab ontap
        onTap: () {
          setState(() {
            activeTab = currentIndex;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive ? getRedColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
            // Add box shadow if active
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: getRedColor.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Text(
            data,
            style: GoogleFonts.dosis(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
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
        Text(randomChats,
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
