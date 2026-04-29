import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/color_const.dart';
import '../../../../constants/utility_const.dart';
import '../../../../providers/home_provider.dart';
import 'ticket_painters.dart';

class SavedTripsSection extends StatelessWidget {
  const SavedTripsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Utility.getScreenWidth(value: 5),
            vertical: Utility.getScreenHeight(value: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Utility.globalText(
                text: 'Saved trips',
                fontSize: 2.2,
                fontWeight: FontWeight.w600,
                color: AppColors.txtColorBlack,
              ),
              Utility.globalText(
                text: 'See more',
                fontSize: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.txtColorBlack,
              ),
            ],
          ),
        ),
        Utility.verticalspace(1),
        SizedBox(
          height: Utility.getScreenHeight(value: 26),
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: Utility.getScreenWidth(value: 5),
                ),
                itemCount: homeProvider.savedTrips.length,
                itemBuilder: (context, index) {
                  final flight = homeProvider.savedTrips[index];
                  return _buildTripCard(flight);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTripCard(dynamic flight) {
    return Container(
      width: Utility.getScreenWidth(value: 85),
      margin: const EdgeInsets.only(right: 15, bottom: 10),
      child: PhysicalShape(
        clipper: TicketClipper(),
        color: AppColors.txtColorWhite,
        elevation: 2.0,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Center(
                      child: Utility.globalText(
                        text: 'Citilink',
                        fontSize: 1.6,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildTimeCity(
                          flight.departureTime,
                          flight.departureCode,
                          flight.departureCity,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomPaint(
                                    size: const Size(50, 25),
                                    painter: DottedArcPainter(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Transform.rotate(
                                      angle: 0.785,
                                      child: const Icon(
                                        Icons.flight,
                                        color: AppColors.bgThemeColorPrimary,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Utility.verticalspace(0.5),
                              Utility.globalText(
                                text: flight.duration,
                                fontSize: 1.6,
                                fontWeight: FontWeight.w500,
                                color: AppColors.txtColorBlack,
                              ),
                            ],
                          ),
                        ),
                        _buildTimeCity(
                          flight.arrivalTime,
                          flight.arrivalCode,
                          flight.arrivalCity,
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Center(
                child: CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: DashedLinePainter(),
                ),
              ),
            ),
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDateInfo('DATE', flight.date),
                  _buildDateInfo(
                    'TRAVELLER',
                    '${flight.passengers} ${flight.passengers > 1 ? 'People' : 'Person'}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCity(String time, String code, String city) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: time,
          fontSize: 1.6,
          fontWeight: FontWeight.w600,
          color: AppColors.bgThemeColorPrimary,
        ),
        Utility.verticalspace(0.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Utility.globalText(
              text: code,
              fontSize: 2,
              fontWeight: FontWeight.w600,
              color: AppColors.txtColorBlack,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Utility.globalText(
          text: label,
          fontSize: 1.4,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
        ),
        Utility.verticalspace(0.2),
        Utility.globalText(
          text: value,
          fontSize: 1.6,
          fontWeight: FontWeight.w600,
          color: AppColors.txtColorBlack,
        ),
      ],
    );
  }
}
