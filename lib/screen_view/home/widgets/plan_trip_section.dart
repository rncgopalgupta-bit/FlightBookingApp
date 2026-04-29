import 'package:flutter/material.dart';
import '../../../../constants/color_const.dart';
import '../../../../constants/utility_const.dart';

class PlanTripSection extends StatelessWidget {
  const PlanTripSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Utility.globalContainer(
      //  heightVal: 16,
      widthVal: 100,
      padding: EdgeInsets.symmetric(
        horizontal: Utility.getScreenWidth(value: 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utility.verticalspace(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Utility.globalText(
                text: 'Plan your trip',
                fontSize: 3.2,
                fontWeight: FontWeight.bold,
                color: AppColors.txtColorWhite,
              ),
              CircleAvatar(
                radius: Utility.getScreenHeight(value: 3),
                backgroundImage: const AssetImage(
                  'assets/images/profile_image.png',
                ),
              ),
            ],
          ),
          Utility.verticalspace(2),
        ],
      ),
    );
  }
}
