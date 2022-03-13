// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:astro_assignment/models/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemList extends StatefulWidget {
  const ItemList({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // Menu items list
  List<MenuItemModel> menuItems = [
    MenuItemModel(
      title: "Food",
      imageURL: "https://picsum.photos/id/488/200/300",
    ),
    MenuItemModel(
      title: "Beverages",
      imageURL: "https://picsum.photos/id/431/200/300",
    )
  ];

  @override
  void initState() {
    super.initState();
    randomizeMenuLengths();
  }

  void randomizeMenuLengths() {
    // Calculate random number from 1-200, then add to totalItems of each menu item
    for (var i = 0; i < menuItems.length; i++) {
      menuItems[i].totalItems = Random().nextInt(200) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            '/homepage',
            arguments: {"title": menuItems[index].title},
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    padding: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                      top: 15,
                      bottom: 15,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(50, 0, 0, 0),
                            blurRadius: 8,
                            offset: Offset(0, 5),
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuItems[index].title,
                          style: GoogleFonts.dosis(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${menuItems[index].totalItems} items",
                          style: GoogleFonts.dosis(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(150, 158, 158, 158),
                          ),
                        ),
                      ],
                    )),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(150, 0, 0, 0),
                            blurRadius: 5,
                            offset: Offset(2, 5),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(menuItems[index].imageURL),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(right: 18),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(40, 0, 0, 0),
                              blurRadius: 5,
                              offset: Offset(2, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      child: Icon(
                        Icons.chevron_right,
                        size: 27,
                        color: Color(0xffA73E37),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      itemCount: menuItems.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 20);
      },
    );
  }
}
