import 'dart:math';

import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/components/ui/circular_loader.dart';
import 'package:astro_assignment/components/ui/ingredients_panel.dart';
import 'package:astro_assignment/components/ui/recipe_base.dart';
import 'package:astro_assignment/models/base.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  const Details({Key? key, this.apiType = "Food"}) : super(key: key);

  final String apiType;

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
      details = data[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecipeBase(
        child: details == null ? CircularLoader() : detailsScreen());
  }

  Widget detailsScreen() {
    return Stack(
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
            color: Colors.black.withOpacity(0.15),
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
      return IngredientsPanel(details: details!, api: api);
    } else if (activeTab == 1) {
      return stepsTab();
    } else {
      return nutritionTab();
    }
  }

  Widget stepsTab() {
    return Container();
  }

  Widget nutritionTab() {
    return Container();
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
