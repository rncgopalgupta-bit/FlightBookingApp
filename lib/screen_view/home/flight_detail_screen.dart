import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/color_const.dart';
import '../../../constants/utility_const.dart';
import '../../../providers/flight_detail_provider.dart';
import 'widgets/ticket_painters.dart';
import 'printable_boarding_pass_screen.dart';

class FlightDetailScreen extends StatelessWidget {
  const FlightDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightbgColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 199, 216, 243),
                AppColors.bgThemeColorSecondary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: Consumer<FlightDetailProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.flightDetail == null) {
                return const Center(child: Text('No details found'));
              }

              final details = provider.flightDetail!.data!.flightDetails!;
              final passengers = provider.flightDetail!.data!.passengers!;
              final booking = provider.flightDetail!.data!.bookingInfo!;

              return Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(Utility.getScreenWidth(value: 5)),
                      child: Column(
                        children: [
                          _buildTicketCard(details),
                          Utility.verticalspace(3),
                          _buildPassengersInfo(passengers, booking),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Utility.getScreenWidth(value: 5)),
      child: Row(
        children: [
          IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
            onPressed: () => Get.back(),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
            ),
          ),
          const Spacer(),
          Utility.globalText(
            text: 'Your flight details',
            fontSize: 2.2,
            fontWeight: FontWeight.bold,
            color: AppColors.txtColorBlack,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildTicketCard(dynamic details) {
    return PhysicalShape(
      clipper: TicketClipper(),
      color: AppColors.txtColorWhite,
      elevation: 2.0,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      child: Column(
        children: [
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
                            color: Colors.green.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            details.airlineLogo ?? '',
                            height: 20,
                            width: 20,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.flight, color: Colors.green),
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
                _buildInfoItem('TERMINAL', details.terminal ?? '-'),
                _buildInfoItem('GATE', details.gate ?? '-'),
                _buildInfoItem('Class', details.flightClass ?? '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengersInfo(List<dynamic> passengers, dynamic booking) {
    return PhysicalShape(
      clipper: TicketClipper(bottomSectionHeight: 115.0),
      color: AppColors.txtColorWhite,
      elevation: 2.0,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(color: Colors.grey.withValues(alpha: 0.3)),
                  ),
              ],
            );
          }).toList(),
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
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SvgPicture.string(
              booking.barcode ?? '',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
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
                fontSize: 1.8,
                fontWeight: FontWeight.bold,
                color: AppColors.txtColorBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: EdgeInsets.all(Utility.getScreenWidth(value: 5)),
      child: Utility.globalTextButton(
        heightVal: 7,
        widthVal: 100,
        titleColor: Colors.white,
        buttonTitle: 'Download & Save pass',
        onPressed: () {
          Get.to(() => const PrintableBoardingPassScreen());
        },
        borderRadius: BorderRadius.circular(25),
        primaryColor: Colors.black,
        secondaryColor: Colors.black,
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
}
