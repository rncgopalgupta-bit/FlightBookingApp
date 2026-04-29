import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/color_const.dart';
import '../../../constants/utility_const.dart';
import '../../../providers/flight_detail_provider.dart';
import 'widgets/ticket_painters.dart';

class PrintableBoardingPassScreen extends StatelessWidget {
  const PrintableBoardingPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Utility.globalText(
          text: 'Boarding Pass',
          fontSize: 2.2,
          fontWeight: FontWeight.w600,
          color: AppColors.txtColorBlack,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Layout ready for saving/printing'),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<FlightDetailProvider>(
          builder: (context, provider, child) {
            final detail = provider.flightDetail;
            if (detail == null || detail.data == null) {
              return const Center(child: Text('No details available'));
            }

            final details = detail.data!.flightDetails!;
            final passengers = detail.data!.passengers!;
            final booking = detail.data!.bookingInfo!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: PhysicalShape(
                  clipper: TicketClipper(bottomSectionHeight: 115.0),
                  color: Colors.white,
                  elevation: 4.0,
                  shadowColor: Colors.black.withValues(alpha: 0.3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. FLIGHT INFO HEADER
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withValues(
                                          alpha: 0.1,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        details.airlineLogo ?? '',
                                        height: 20,
                                        width: 20,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(
                                              Icons.flight,
                                              color: Colors.green,
                                            ),
                                      ),
                                    ),
                                    Utility.globalText(
                                      text: details.airlineName ?? '',
                                      fontSize: 2,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.txtColorBlack,
                                    ),
                                  ],
                                ),
                                Utility.globalText(
                                  text: details.flightId ?? '',
                                  fontSize: 1.8,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.greyColor,
                                ),
                              ],
                            ),
                            Utility.verticalspace(3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildTimeCity(
                                  details.departure?.time ?? '',
                                  details.departure?.airportCode ?? '',
                                  details.departure?.city ?? '',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CustomPaint(
                                            size: const Size(50, 25),
                                            painter: DottedArcPainter(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            child: Transform.rotate(
                                              angle: 0.785,
                                              child: const Icon(
                                                Icons.flight,
                                                color: AppColors
                                                    .bgThemeColorPrimary,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Utility.verticalspace(0.5),
                                      Utility.globalText(
                                        text: details.duration ?? '',
                                        fontSize: 1.4,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.txtColorBlack,
                                      ),
                                    ],
                                  ),
                                ),
                                _buildTimeCity(
                                  details.arrival?.time ?? '',
                                  details.arrival?.airportCode ?? '',
                                  details.arrival?.city ?? '',
                                ),
                              ],
                            ),
                            Utility.verticalspace(2),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),

                      // 2. TERMINAL, GATE, CLASS
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoItem('TERMINAL', details.terminal ?? '-'),
                            _buildInfoItem('GATE', details.gate ?? '-'),
                            _buildInfoItem('Class', details.flightClass ?? '-'),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),

                      // 3. PASSENGERS INFO
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                        child: Utility.globalText(
                          text: 'Passengers Info',
                          fontSize: 2.2,
                          fontWeight: FontWeight.w500,
                          color: AppColors.txtColorBlack,
                        ),
                      ),
                      ...passengers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final p = entry.value;
                        return Column(
                          children: [
                            _buildPassengerRow(p),
                            if (index < passengers.length - 1)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Divider(
                                  color: Colors.grey.withValues(alpha: 0.3),
                                ),
                              ),
                          ],
                        );
                      }).toList(),

                      // 4. CUTOUT DASHED LINE
                      SizedBox(
                        height: 30,
                        child: Center(
                          child: CustomPaint(
                            size: const Size(double.infinity, 1),
                            painter: DashedLinePainter(),
                          ),
                        ),
                      ),

                      // 5. BARCODE
                      Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: SvgPicture.string(
                          booking.barcode ?? '',
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeCity(String time, String code, String city) {
    String formattedTime = time.length >= 5 ? time.substring(0, 5) : time;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: formattedTime,
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

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: label,
          fontSize: 1.4,
          fontWeight: FontWeight.w400,
          color: AppColors.greyColor,
        ),
        Utility.globalText(
          text: value,
          fontSize: 1.8,
          fontWeight: FontWeight.bold,
          color: AppColors.txtColorBlack,
        ),
      ],
    );
  }

  Widget _buildPassengerRow(dynamic p) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Utility.getScreenWidth(value: 5),
        vertical: 10,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(p.profilePicture ?? ''),
          ),
          horizontalSpace(2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Utility.globalText(
                  text: 'PASSENGER ${p.passengerNumber}',
                  fontSize: 1.4,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor,
                ),
                Utility.globalText(
                  text: '${p.title} ${p.name}',
                  fontSize: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.txtColorBlack,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Utility.globalText(
                text: 'SEAT',
                fontSize: 1.4,
                fontWeight: FontWeight.w400,
                color: AppColors.greyColor,
              ),
              Utility.globalText(
                text: p.seat ?? '-',
                fontSize: 1.6,
                fontWeight: FontWeight.w600,
                color: AppColors.txtColorBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
