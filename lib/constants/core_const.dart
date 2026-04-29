import 'package:flightbookingapp/constants/color_const.dart';
import 'package:flightbookingapp/constants/utility_const.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Core {
  static String placeholderUrl =
      'https://rasatva.apponedemo.top/omens/public/not-found.jpg';
  static OverlayEntry? _overlayEntry;

  static void showLoader(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          AbsorbPointer(
            absorbing: true,
            child: Container(color: Colors.transparent),
          ),
          Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.activecolor,
              size: Utility.getScreenHeight(value: 4),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideLoader() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  static showSnackBarToast(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Utility.globalText(
          text: message,
          fontSize: 1.5,
          fontWeight: FontWeight.w600,
          color: AppColors.txtColorWhite,
          align: TextAlign.start,
        ),
        backgroundColor: AppColors.activecolor,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
