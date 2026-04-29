import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_const.dart';
import '../../../constants/utility_const.dart';
import '../../../providers/home_provider.dart';
import 'widgets/plan_trip_section.dart';
import 'widgets/booking_card.dart';
import 'widgets/saved_trips_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightbgColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.bgThemeColorPrimary,
                AppColors.bgThemeColorSecondary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              return Column(
                children: [
                  const PlanTripSection(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Utility.verticalspace(2),
                          const BookingCard(),
                          Utility.verticalspace(2),
                          const SavedTripsSection(),
                          Utility.verticalspace(10),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          final screenWidth = MediaQuery.of(context).size.width;
          final tabWidth = screenWidth / 4;
          
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                height: 60,
                child: Stack(
                  children: [
                    // Animated Indicator
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      top: 0,
                      left: tabWidth * homeProvider.currentIndex,
                      child: Container(
                        height: 3,
                        width: tabWidth,
                        alignment: Alignment.center,
                        child: Container(
                          height: 3,
                          width: tabWidth * 0.7,
                          color: AppColors.bgThemeColorPrimary,
                        ),
                      ),
                    ),
                    // Icons
                    Row(
                      children: [
                        _buildNavItem(0, Icons.home_filled, Icons.home_outlined, homeProvider),
                        _buildNavItem(1, Icons.flight, Icons.flight, homeProvider, rotateAngle: 0.785),
                        _buildNavItem(2, Icons.map, Icons.map_outlined, homeProvider),
                        _buildNavItem(3, Icons.person, Icons.person_outline, homeProvider),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, HomeProvider provider, {double rotateAngle = 0}) {
    final isSelected = provider.currentIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => provider.setIndex(index),
        child: SizedBox(
          height: 60,
          child: Center(
            child: Transform.rotate(
              angle: rotateAngle,
              child: Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: isSelected ? AppColors.bgThemeColorPrimary : AppColors.greyColor,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
