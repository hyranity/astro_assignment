// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:astro_assignment/components/api/meal_api.dart';
import 'package:astro_assignment/components/ui/recipe_base.dart';
import 'package:astro_assignment/components/ui/search_bar.dart';
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

  @override
  void initState() {
    super.initState();

    print(MealApi().getCategories());
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
          ],
        ),
        title: "Good morning Akila!");
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
