// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:flightbookingapp/constants/color_const.dart';
import 'package:flightbookingapp/main.dart';
import 'package:flightbookingapp/network_services/network_const.dart';
import 'package:flutter/material.dart';

class Utility {
  static String imgPath = 'assets/images/';

  static getScreenHeight({double? value}) {
    if (value != null) {
      final mySize =
          (MediaQuery.of(
                NavigationService.navigatorKey.currentContext!,
              ).size.height *
              value) /
          100;
      return mySize;
    } else {
      return MediaQuery.of(
        NavigationService.navigatorKey.currentContext!,
      ).size.height;
    }
  }

  static getScreenWidth({double? value}) {
    if (value != null) {
      final mySize =
          (MediaQuery.of(
                NavigationService.navigatorKey.currentContext!,
              ).size.width *
              value) /
          100;
      return mySize;
    } else {
      return MediaQuery.of(
        NavigationService.navigatorKey.currentContext!,
      ).size.width;
    }
  }

  static Widget globalText({
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    int? maxLines,
    TextAlign? align,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: getScreenHeight(value: fontSize),
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: align,
      maxLines: maxLines,
    );
  }

  static TextStyle globalTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextDecoration? textDecoration,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: getScreenHeight(value: fontSize),
      fontWeight: fontWeight,
      color: color,
      decoration: textDecoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }

  static Widget globalTextButton({
    required double heightVal,
    required double widthVal,
    required Color titleColor,
    required String buttonTitle,
    required void Function()? onPressed,
    BorderRadius? borderRadius,
    Border? border,
    TextDecoration? textDecoration,
    Color? decorationColor,
    Color? primaryColor,
    Color? secondaryColor,
    double? decorationThickness,
  }) {
    return Container(
      height: Utility.getScreenHeight(value: heightVal),
      width: Utility.getScreenWidth(value: widthVal),
      decoration: BoxDecoration(
        color: decorationColor,
        border: border,
        borderRadius: borderRadius,
        boxShadow: kElevationToShadow[2],
        gradient: primaryColor != null
            ? LinearGradient(
                colors: [primaryColor, secondaryColor!],
                begin: const FractionalOffset(0.0, 0.2),
                end: const FractionalOffset(0.0, 1.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: globalText(
          text: buttonTitle,
          fontSize: 1.6,
          fontWeight: FontWeight.w600,
          color: titleColor,
        ),
      ),
    );
  }

  static Widget globalIconButton({
    required double heightVal,
    required double widthVal,
    required Widget icon,
    Color? iconColor,
    required void Function()? onPressed,
    double? iconSize,
    BorderRadius? borderRadius,
    Border? border,
    Color? decorationColor,
    Color? primaryColor,
    Color? secondaryColor,
    List<BoxShadow>? boxShadow,
    Key? key,
    double? decorationThickness,
  }) {
    return Container(
      height: Utility.getScreenHeight(value: heightVal),
      width: Utility.getScreenHeight(value: widthVal),
      decoration: BoxDecoration(
        color: decorationColor,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: primaryColor != null
            ? LinearGradient(
                colors: [primaryColor, secondaryColor!],
                begin: const FractionalOffset(0.0, 0.2),
                end: const FractionalOffset(0.0, 1.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            : null,
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          color: iconColor,
          iconSize: iconSize,
          padding: const EdgeInsets.all(0),
          key: key,
        ),
      ),
    );
  }

  static Widget globalImage_Asset({
    required double heightVal,
    required double widthVal,
    required String imgName,
    bool? isWidth,
    Color? color,
    BoxFit? fit,
  }) {
    return Image.asset(
      imgPath + imgName,
      height: getScreenHeight(value: heightVal),
      width: isWidth == null
          ? getScreenHeight(value: widthVal)
          : getScreenWidth(value: widthVal),
      color: color,
      fit: fit,
    );
  }

  static Widget globalSizedBox({
    double? heightVal,
    double? widthVal,
    Widget? child,
  }) {
    return SizedBox(
      height: heightVal != null ? getScreenHeight(value: heightVal) : null,
      width: widthVal != null ? getScreenWidth(value: widthVal) : null,
      child: child,
    );
  }

  static Widget verticalspace(double space) {
    return SizedBox(height: getScreenHeight(value: space));
  }

  static Widget horizontalspace(double space) {
    return SizedBox(height: getScreenWidth(value: space));
  }

  static Widget globalContainer({
    double? heightVal,
    double? widthVal,
    bool? isHeight,
    Color? color,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Color? primaryColor,
    Color? secondaryColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Widget? child,
  }) {
    return Container(
      height: heightVal != null ? getScreenHeight(value: heightVal) : null,
      width: widthVal != null
          ? isHeight == null
                ? getScreenWidth(value: widthVal)
                : getScreenHeight(value: widthVal)
          : null,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: primaryColor != null
            ? LinearGradient(
                colors: [primaryColor, secondaryColor!],
                begin: const FractionalOffset(0.0, 0.2),
                end: const FractionalOffset(0.0, 1.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            : null,
      ),
      child: child,
    );
  }

  static Widget containerTextFormField({
    double? heightVal,
    required double widthVal,
    bool? isHeight,
    Color? color,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Color? primaryColor,
    Color? secondaryColor,
    EdgeInsetsGeometry? margin,
    String? labelHintText,
    Widget? prefixIcon,
    double? contentPaddingVal,
    TextEditingController? controller,
    FocusNode? focusnode,
    onTapOutside,
  }) {
    return Container(
      height: heightVal != null ? getScreenHeight(value: heightVal) : null,
      width: isHeight == null
          ? getScreenWidth(value: widthVal)
          : getScreenHeight(value: widthVal),
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: primaryColor != null
            ? LinearGradient(
                colors: [primaryColor, secondaryColor!],
                begin: const FractionalOffset(0.0, 0.2),
                end: const FractionalOffset(0.0, 1.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            : null,
      ),
      child: TextFormField(
        controller: controller,
        focusNode: FocusNode(),
        onTapOutside: (event) {
          print('onTapOutside');
          FocusManager.instance.primaryFocus?.unfocus();
        },
        style: Utility.globalTextStyle(
          fontSize: 2,
          fontWeight: FontWeight.w600,
          color: AppColors.txtColorBlack,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: labelHintText,
          hintStyle: Utility.globalTextStyle(
            fontSize: 1.7,
            fontWeight: FontWeight.w600,
            color: AppColors.txtColorBlack,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(
            Utility.getScreenHeight(value: contentPaddingVal),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter institute id';
          }
          return null;
        },
      ),
    );
  }

  static Widget globalImage_Network({
    double? heightVal,
    double? widthVal,
    required String imgUrl,
    bool? isWidth,
    Color? color,
    BoxFit? fit,
  }) {
    return Image.network(
      '${NetworkConsts.baseUrl}$imgUrl',
      height: getScreenHeight(value: heightVal),
      width: isWidth == null
          ? getScreenHeight(value: widthVal)
          : getScreenWidth(value: widthVal),
      color: color,
      fit: fit,
    );
  }

  static Widget globalImage_File({
    double? heightVal,
    double? widthVal,
    required File file,
    bool? isWidth,
    Color? color,
    BoxFit? fit,
  }) {
    return Image.file(
      file,
      height: getScreenHeight(value: heightVal),
      width: isWidth == null
          ? getScreenHeight(value: widthVal)
          : getScreenWidth(value: widthVal),
      color: color,
      fit: fit,
    );
  }
}

Widget verticalSpace(double height) {
  return SizedBox(
    height:
        (MediaQuery.of(
              NavigationService.navigatorKey.currentContext!,
            ).size.height *
            height) /
        100,
  );
}

Widget horizontalSpace(double width) {
  return SizedBox(
    width:
        (MediaQuery.of(
              NavigationService.navigatorKey.currentContext!,
            ).size.width *
            width) /
        100,
  );
}
