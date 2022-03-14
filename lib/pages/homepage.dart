// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/components/api/cocktail_api.dart';
import 'package:astro_assignment/components/api/meal_api.dart';
import 'package:astro_assignment/components/ui/circular_loader.dart';
import 'package:astro_assignment/components/ui/recipe_base.dart';
import 'package:astro_assignment/components/ui/search_bar.dart';
import 'package:astro_assignment/models/base.dart';
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
  List<BaseFoodItem> popularItems = [];

  bool isLoadingCategories = false;
  bool isLoadingPopular = false;

  late BaseApi api;

  @override
  void initState() {
    super.initState();

    // Wait till flutter widgets done
    Future.delayed(Duration.zero, () {
      loadApi();
      fetchCategory();
    });
  }

  void loadApi() {
    var type = ((ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map)["title"];

    if (type == "Food") {
      api = MealApi();
    } else {
      api = CocktailApi();
    }
  }

  void fetchCategory() async {
    setState(() {
      isLoadingCategories = true;
    });

    mealCategories = (await api.getCategories());
    setState(() {
      isLoadingCategories = false;
    });
  }

  void fetchPopular(String category) async {
    setState(() {
      isLoadingPopular = true;
    });
    popularItems = (await api.getByCategory(category));
    setState(() {
      isLoadingPopular = false;
    });
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
          // Add loader
          isLoadingCategories
              ? Container(
                  height: 200,
                  child: CircularLoader(),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: categoryRow(),
                ),
          popularItems.isEmpty && !isLoadingPopular
              ? selectCategoryPrompt()
              : popularFood(),
        ],
      ),
      title: "Good morning Akila!",
    );
  }

  Container popularFood() {
    return isLoadingPopular
        ? Container(
            height: 200,
            child: Center(
              child: CircularLoader(),
            ),
          )
        : Container(
            // ListView.seperated of each popularItem
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    'Popular Food',
                    style: GoogleFonts.dosis(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: popularItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: <String, dynamic>{
                          "title": "Food",
                          "id": popularItems[index].id,
                        },
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                popularItems[index].strThumb ??
                                    "https://picsum.photos/200/300",
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Name of food
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    popularItems[index].strFood ?? "",
                                    style: GoogleFonts.dosis(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Color(0xffA73E37),
                                        size: 20,
                                      ),
                                      Text(
                                        generateRating(),
                                        style: GoogleFonts.dosis(
                                          fontSize: 15,
                                          color: Color(0xffA73E37),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "(${generateRatingCount()})",
                                        style: GoogleFonts.dosis(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20);
                  },
                ),
              ],
            ),
          );
  }

  // Generate random number for rating, allow 1 decimal place
  generateRating() => (math.Random().nextDouble() * 5).toStringAsFixed(1);

  // Generating random number rating count (eg. 120 ratings)
  generateRatingCount() =>
      (math.Random().nextInt(1000) + 1).toString() + " ratings";

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

        return GestureDetector(
          onTap: () => fetchPopular(category.strCategory),
          child: Container(
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
                      image: NetworkImage(category.strCategoryThumb == ""
                          ? "https://picsum.photos/200/300"
                          : category.strCategoryThumb),
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
