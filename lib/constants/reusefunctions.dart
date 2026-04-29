import 'package:flightbookingapp/constants/color_const.dart';
import 'package:flightbookingapp/constants/utility_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class Reuse {
  static Widget globalNumberTextfild({
    required String title,
    required int maxlength,
    required int minlength,
    required TextEditingController controller,
    required IconData icon,
    required RxInt textLength,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: title,
          fontSize: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.txtColorBlack54,
        ),
        Utility.globalContainer(
          heightVal: 5,
          widthVal: 100,
          borderRadius: BorderRadius.circular(
            Utility.getScreenHeight(value: 1),
          ),
          border: Border.all(color: AppColors.greyColor),
          color: AppColors.whiteTextColor,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: maxlength,
            onChanged: (val) {
              textLength.value = val.length;
              onChanged(val);
            },
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: Utility.getScreenHeight(value: 0.7),
                horizontal: Utility.getScreenHeight(value: 1),
              ),
              suffixIcon: Icon(icon, color: AppColors.greyColor),
            ),
          ),
        ),
        verticalSpace(1),
        Align(
          alignment: Alignment.centerRight,
          child: Obx(
            () => Utility.globalText(
              text: "${textLength.value}/$maxlength",
              fontSize: 1.4,
              fontWeight: FontWeight.w400,
              color: AppColors.txtColorBlack54,
            ),
          ),
        ),
      ],
    );
  }

  static Widget globalPasswordTextfild({
    required String title,
    required TextEditingController controller,
    required IconData icon,
    required RxInt textLength,
    required RxBool isHidden,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: title,
          fontSize: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.txtColorBlack54,
        ),
        Utility.globalContainer(
          heightVal: 5,
          widthVal: 100,
          borderRadius: BorderRadius.circular(
            Utility.getScreenHeight(value: 1),
          ),
          border: Border.all(color: AppColors.greyColor),
          color: AppColors.whiteTextColor,
          child: Obx(
            () => TextField(
              controller: controller,
              obscureText: isHidden.value,
              onChanged: (val) {},
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Utility.getScreenHeight(value: 0.7),
                  horizontal: Utility.getScreenHeight(value: 1),
                ),
                suffixIcon: GestureDetector(
                  onTap: () => isHidden.value = !isHidden.value,
                  child: Icon(
                    isHidden.value ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.activecolor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget globalNameTextfild({
    required String title,
    required TextEditingController controller,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: title,
          fontSize: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.txtColorBlack54,
        ),
        Utility.globalContainer(
          heightVal: 5,
          widthVal: 100,
          borderRadius: BorderRadius.circular(
            Utility.getScreenHeight(value: 1),
          ),
          border: Border.all(color: AppColors.greyColor),
          color: AppColors.whiteTextColor,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.name,
            onChanged: (val) {},
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(Utility.getScreenHeight(value: 1)),
              suffixIcon: Icon(icon, color: AppColors.greyColor),
            ),
          ),
        ),
      ],
    );
  }

  static Widget txtfieldforoffers({
    required String title,
    required String hintText,
    required double width,
    required TextEditingController controller,
    required TextInputType keyboardType,
    bool? onlyNumbers,
    int? maxLength,
    bool? readonly,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: title,
          fontSize: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.activecolor,
        ),
        verticalSpace(0.5),
        Utility.globalContainer(
          heightVal: 5,
          widthVal: width,
          color: color ?? AppColors.whiteTextColor,
          borderRadius: BorderRadius.circular(
            Utility.getScreenHeight(value: 1),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: Utility.getScreenHeight(value: 1)),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                readOnly: readonly ?? false,

                inputFormatters: [
                  if (onlyNumbers == true)
                    FilteringTextInputFormatter.digitsOnly,
                  if (maxLength != null)
                    LengthLimitingTextInputFormatter(maxLength),
                ],

                textAlignVertical: TextAlignVertical.center,

                decoration: InputDecoration(
                  hintText: hintText,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),

                style: Utility.globalTextStyle(
                  fontSize: 1.4,
                  fontWeight: FontWeight.w400,
                  color: AppColors.txtColorBlack,
                ).copyWith(decoration: TextDecoration.none),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget txtfieldwithicons({
    required String title,
    required String hintText,
    required double width,
    required Color color,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required Widget widget1,
    required Widget widget2,
    bool? onlyNumbers,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: title,
          fontSize: 1.5,
          fontWeight: FontWeight.w600,
          color: AppColors.activecolor,
        ),
        verticalSpace(0.5),
        Utility.globalContainer(
          heightVal: 5,
          widthVal: width,
          color: color,
          borderRadius: BorderRadius.circular(
            Utility.getScreenHeight(value: 1),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: Utility.getScreenHeight(value: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    inputFormatters: [
                      if (onlyNumbers == true)
                        FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        bottom: Utility.getScreenHeight(value: 1),
                      ),
                    ),
                    style: Utility.globalTextStyle(
                      fontSize: 1.4,
                      fontWeight: FontWeight.w400,
                      color: AppColors.txtColorBlack,
                    ).copyWith(decoration: TextDecoration.none),
                  ),
                ),
                widget1,
                widget2,
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget globalbutton({
    required String title,
    required Function() ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Utility.globalContainer(
        heightVal: 5,
        widthVal: 100,
        borderRadius: BorderRadius.circular(Utility.getScreenHeight(value: 1)),
        color: AppColors.activecolor,
        child: Center(
          child: Utility.globalText(
            text: title,
            fontSize: 1.8,
            fontWeight: FontWeight.w500,
            color: AppColors.txtColorWhite,
          ),
        ),
      ),
    );
  }

  static AppBar globalAppbar({required title}) {
    return AppBar(
      backgroundColor: AppColors.lightbgColor,
      centerTitle: true,
      elevation: 4,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: AppColors.activecolor,
        ),
        onPressed: () => Get.back(),
      ),
      title: Utility.globalText(
        text: title,
        fontSize: 1.8,
        fontWeight: FontWeight.w500,
        color: AppColors.activecolor,
      ),
    );
  }

  static Widget customAppbarView({
    required title,
    required VoidCallback ontap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColors.activecolor,
          ),
        ),
        Expanded(
          child: Utility.globalText(
            text: title,
            fontSize: 1.8,
            fontWeight: FontWeight.w600,
            color: AppColors.activecolor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: Utility.getScreenHeight(value: 2)),
          child: GestureDetector(
            onTap: ontap,
            child: Utility.globalImage_Asset(
              heightVal: 3,
              widthVal: 3,
              imgName: 'Info Circle.png',
            ),
          ),
        ),
      ],
    );
  }

  static Widget customAppbar({required title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColors.activecolor,
          ),
        ),
        Utility.globalText(
          text: title,
          fontSize: 1.8,
          fontWeight: FontWeight.w500,
          color: AppColors.activecolor,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, size: 18, color: Colors.transparent),
        ),
      ],
    );
  }

  static Widget textfield({
    required String hintText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    bool? isBoxshadow,
  }) {
    return Utility.globalContainer(
      heightVal: 5,
      widthVal: 100,
      color: isBoxshadow == true
          ? AppColors.whiteTextColor
          : Colors.transparent,
      border: Border.all(
        color: isBoxshadow == true ? Colors.transparent : AppColors.activecolor,
      ),
      boxShadow: isBoxshadow == true ? kElevationToShadow[1] : null,
      borderRadius: BorderRadius.circular(Utility.getScreenHeight(value: 1)),
      child: Padding(
        padding: EdgeInsets.only(
          left: Utility.getScreenHeight(value: 1),
          bottom: Utility.getScreenHeight(value: 1.3),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            style: Utility.globalTextStyle(
              fontSize: 1.4,
              fontWeight: FontWeight.w400,
              color: AppColors.txtColorBlack,
            ).copyWith(decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void goToHomeTab() {
    selectedIndex.value = 0;
  }
}
