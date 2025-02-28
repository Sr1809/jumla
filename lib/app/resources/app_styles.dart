import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles(_);

  static regular({required fontSize, required fontColor, bool? isUnderLine}) {
    return TextStyle(
      color: fontColor,
      fontFamily: "Roboto",
      fontSize: fontSize,
      decoration:
          isUnderLine == true ? TextDecoration.underline : TextDecoration.none,
        decorationColor:AppColors.blueColor
    );
  }
  static light({required fontSize, required fontColor, bool? isUnderLine}) {
    return TextStyle(
      color: fontColor,
      fontFamily: "Roboto-Light",
      fontSize: fontSize,
      decoration:
      isUnderLine == true ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static bold({required fontSize, required fontColor, bool? isUnderLine,}) {


    return TextStyle(
        color: fontColor, fontFamily: "Roboto-Bold", fontSize: fontSize,
      decoration:
      isUnderLine == true ? TextDecoration.underline : TextDecoration.none,

    );
  }



  static medium({required fontSize, required fontColor, bool? isUnderLine,}) {
    return TextStyle(
      color: fontColor,
      fontFamily: "Roboto-Medium",
      fontSize: fontSize,
      decoration:
          isUnderLine == true ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static semiBold(
      {required fontSize, required fontColor, FontStyle? fontStyle, isUnderLine,isItalic}) {
    return TextStyle(
        color: fontColor,
        fontFamily: "Roboto-SemiBold",
        fontSize: fontSize,
        decorationColor: fontColor,
        fontStyle: isItalic != null?FontStyle.italic:FontStyle.normal,
        decoration:
        isUnderLine == true ? TextDecoration.underline : TextDecoration.none,
    );
  }
}
