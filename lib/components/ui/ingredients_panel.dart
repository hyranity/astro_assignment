import 'dart:convert';
import 'dart:math';

import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/models/base.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngredientsPanel extends StatefulWidget {
  const IngredientsPanel({
    Key? key,
    required this.details,
    required this.api,
  }) : super(key: key);

  final BaseFoodDetails details;
  final BaseApi api;

  @override
  State<IngredientsPanel> createState() => _IngredientsPanelState();
}

class _IngredientsPanelState extends State<IngredientsPanel> {
  int servingSize = 1;
  Color get getRedColor => Color(0xffDB5E56);

  @override
  void initState() {
    super.initState();

    // Prune strIngredientList by removing empty strings
    widget.details.strIngredientList = widget.details.strIngredientList
        .where((element) => element != '')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          children: [
            ingredientsHeader(),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              height: 1,
              color: Colors.grey[300],
            ),
            ingredientsListView(),
          ],
        ));
  }

  Widget ingredientsListView() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.details.strIngredientList.length,
      itemBuilder: (context, index) {
        String ingredient = widget.details.strIngredientList[index];
        return Container(
          // Row of image, then column of text
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Image.network(
                  widget.api.getIngredientImage(ingredient),
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    "https://picsum.photos/200/300",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      getIngredientCount(index),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
    );
  }

  String getIngredientCount(int index) {
    String measure = widget.details.strMeasureList[index];

    if (measure == null) {
      return "-";
    }

    // Convert fractions to decimal (eg. 1/2 oz, 1 /2 oz) and set to measure
    if (measure.contains("/")) {
      List<String> fraction = measure.split("/");
      String unit = fraction[1].split(" ")[1];
      double decimal =
          double.parse(fraction[0]) / double.parse(fraction[1].split(" ")[0]);

      // Recombine decimal and unit
      measure = "$decimal $unit";
    }
    // If measure contains a digit and letter
    if (measure.contains(RegExp(r'\d'))) {
      String unit;
      double number;
      List<String> measureSplit;

      // Separate the measure into the number and the unit
      // Note that some measures have a space, e.g. "1 cups", and some don't, e.g. "2tbsp"

      // If space, separated unit and number by space
      if (measure.contains(" ")) {
        measureSplit = measure.split(" ");
        unit = measureSplit[1];
        number = double.tryParse(measureSplit[0]) ?? 0;
      }
      // If contains both number and letter
      else if (RegExp(r'\d').hasMatch(measure) &&
          RegExp(r'[a-zA-Z]').hasMatch(measure)) {
        // Match regex with number and letter (eg. 1000ml > 1000 and ml)
        Match? match = RegExp(r'(\d+)([a-zA-Z]+)').firstMatch(measure);
        number = double.tryParse(match?.group(1) ?? '0') ?? 0;
        unit = match?.group(2) ?? '-';
      }
      // If contains only a number
      else if (RegExp(r'\d').hasMatch(measure)) {
        number = double.tryParse(measure) ?? 0;
        unit = '';
      } else {
        unit = "-";
        number = 0;
      }

      // Multiply by serving
      int serving = servingSize;
      dynamic count = number * serving;

      // If count is a whole number, set it as an integer
      if (count.round() == count) {
        count = count.round();
      }

      // Return
      return '$count $unit';
    } else {
      return measure;
    }
  }

  Row ingredientsHeader() {
    return Row(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Ingredients for",
          style: GoogleFonts.dosis(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          "$servingSize servings",
          style: GoogleFonts.dosis(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
      Spacer(),
      // Add and minus button
      Container(
        margin: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: getRedColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  size: 12,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Adds serving size
                  setState(() {
                    servingSize++;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '$servingSize',
                style: GoogleFonts.dosis(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: getRedColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.remove,
                  size: 12,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Decreases serving size, min 1
                  if (servingSize > 1) {
                    setState(() {
                      servingSize--;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
