import 'package:astro_assignment/components/ui/item_list.dart';
import 'package:astro_assignment/components/ui/recipe_base.dart';
import 'package:astro_assignment/components/ui/search_bar.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return RecipeBase(
      title: "Menu",
      child: Column(
        children: [
          SearchBar(),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Stack(
              children: [
                menuBackground(),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: ItemList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned menuBackground() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xffB62810),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          width: 100,
        ),
      ),
    );
  }
}
