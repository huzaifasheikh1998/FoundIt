import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Content extends StatelessWidget {
  bool? googleFonts;
  String data;
  double size;
  Color? color;
  int? maxLines;
  FontWeight? weight;
  TextAlign? alignment;

  Content(
      {required this.data,
      required this.size,
      this.googleFonts,
      this.color,
      this.maxLines,
      this.weight,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: alignment,
      maxLines: maxLines ?? 100,
      style: googleFonts == null
          ? TextStyle(
              fontSize: size,
              color: color,
              fontWeight: weight,
              overflow: TextOverflow.ellipsis)
          : GoogleFonts.josefinSans(
              fontSize: size,
              color: color,
              fontWeight: weight,
            ),
    );
  }
}
