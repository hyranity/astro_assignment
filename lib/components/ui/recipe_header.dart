import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeHeader extends StatefulWidget implements PreferredSizeWidget {
  const RecipeHeader({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<RecipeHeader> createState() => _RecipeHeaderState();
}

class _RecipeHeaderState extends State<RecipeHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title ?? ""),
      actions: <Widget>[
        widget.title == null
            ? const SizedBox.shrink()
            : IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              )
      ],
      titleTextStyle: GoogleFonts.dosis(
          fontSize: 24,
          color: const Color.fromARGB(255, 90, 90, 90),
          fontWeight: FontWeight.w600),
      elevation: 0,
      backgroundColor: widget.title == null ? Colors.transparent : Colors.white,
      foregroundColor: Colors.black,
    );
  }
}
