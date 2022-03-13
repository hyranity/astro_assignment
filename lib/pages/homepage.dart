// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:astro_assignment/components/api/meal_api.dart';
import 'package:astro_assignment/components/ui/recipe_base.dart';
import 'package:astro_assignment/components/ui/search_bar.dart';
import 'package:astro_assignment/models/common.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List of locations available
  List<String> locations = [
    "Current Location",
    "Home",
    "Work",
  ];

  int selectedLocationIndex = 0;

  List<Category> mealCategories = [];

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    mealCategories = (await MealApi().getCategories<Category>());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RecipeBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: deliveringLocation(),
          ),
          SearchBar(),
          Container(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: categoryRow(),
          ),
          selectCategoryPrompt(),
        ],
      ),
      title: "Good morning Akila!",
    );
  }

  Row selectCategoryPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Select a category",
              textAlign: TextAlign.center,
              style: GoogleFonts.dosis(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ListView categoryRow() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: ((context, index) {
        Category category = mealCategories[index];

        return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 4),
                      blurRadius: 15,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(category.strCategoryThumb),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  category.strCategory,
                  style: GoogleFonts.dosis(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      separatorBuilder: ((context, index) => SizedBox(width: 5)),
      itemCount: mealCategories.length,
    );
  }

  Column deliveringLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Delivering to",
            style: TextStyle(
              color: Colors.grey,
            )),
        DropdownButton<int>(
          value: selectedLocationIndex,
          underline: Container(),
          icon: Transform.rotate(
              angle: 90 * math.pi / 180,
              child: Icon(
                Icons.chevron_right,
                color: Color(0xffA73E37),
              )),
          items: generateDropdownMenuItems(),
          isDense: true,
          onChanged: (value) {
            // Change the dropdown
            setState(() {
              selectedLocationIndex = value!;
            });
          },
        )
      ],
    );
  }

  // Generate list of DropdownMenuItems based on location list
  List<DropdownMenuItem<int>> generateDropdownMenuItems() {
    List<DropdownMenuItem<int>> items = [];
    for (String location in locations) {
      items.add(DropdownMenuItem(
        child: Text(location,
            style: GoogleFonts.dosis(
              fontWeight: FontWeight.w900,
              color: Colors.grey,
            )),
        value: locations.indexOf(location),
      ));
    }
    return items;
  }
}
