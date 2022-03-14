import 'package:astro_assignment/components/ui/recipe_header.dart';
import 'package:flutter/material.dart';

class RecipeBase extends StatefulWidget {
  const RecipeBase({
    Key? key,
    required this.child,
    this.title,
  }) : super(key: key);

  final Widget child;
  final String? title;

  @override
  State<RecipeBase> createState() => _RecipeBaseState();
}

class _RecipeBaseState extends State<RecipeBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: widget.title == null,
      appBar: RecipeHeader(title: widget.title),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: widget.child),
    );
  }
}
