
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  String title;
  final Function()? onPress;
  final Color color;
  final Color textColor;
  ButtonWidget({Key? key,required this.title,required this.onPress,required this.color,required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(1),
          foregroundColor: MaterialStateProperty.all<Color>(color),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        onPressed: onPress,
        child: Center(
          child: Text(title, style: GoogleFonts.firaSans(textStyle: TextStyle(color: textColor, fontSize: 14,letterSpacing: 1.25,fontWeight: FontWeight.w500))),
        ),
      ),
    );
  }
}