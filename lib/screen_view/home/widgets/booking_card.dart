import 'package:flightbookingapp/model/flight_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flightbookingapp/constants/app_routers.dart';
import 'package:flightbookingapp/providers/flight_result_provider.dart';
import 'package:get/get.dart';
import '../../../../constants/color_const.dart';
import '../../../../constants/utility_const.dart';
import '../../../../providers/home_provider.dart';
import '../../../../model/from.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({super.key});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      await provider.fetchFromAirports(context);
      await provider.fetchToAirports(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Utility.globalContainer(
            widthVal: 90,
            primaryColor: const Color.fromARGB(255, 222, 231, 246),
            secondaryColor: AppColors.bgThemeColorSecondary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            padding: EdgeInsets.all(Utility.getScreenWidth(value: 5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Column(
                      children: [
                        _buildAirportDropdown(
                          'From',
                          'Select boarding point',
                          provider.selectedFrom,
                          provider.fromAirports,
                          (val) => provider.setSelectedFrom(val),
                        ),
                        const Divider(),
                        _buildAirportDropdown(
                          'To',
                          'Select departure point',
                          provider.selectedTo,
                          provider.toAirports,
                          (val) => provider.setSelectedTo(val),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      child: GestureDetector(
                        onTap: () => provider.swapAirports(),
                        child: Utility.globalContainer(
                          heightVal: 5.5,
                          widthVal: 5.5,
                          isHeight: true,
                          color: AppColors.txtColorWhite,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          child: const Icon(
                            Icons.swap_vert,
                            color: AppColors.activecolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePicker(
                        'Departure',
                        DateFormat('EEE, d MMM').format(provider.selectedDate),
                        Icons.calendar_today,
                        () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: provider.selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColors.activecolor,
                                    onPrimary: Colors.white,
                                    onSurface: AppColors.activecolor,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.activecolor,
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null) provider.setSelectedDate(date);
                        },
                      ),
                    ),
                    Utility.horizontalspace(2),
                    Expanded(
                      child: _buildPassengerDropdown(
                        'Travellers',
                        provider.passengerCount,
                        (val) => provider.setPassengerCount(val!),
                      ),
                    ),
                  ],
                ),
                Utility.verticalspace(2),
                Utility.globalTextButton(
                  heightVal: 6,
                  widthVal: 100,
                  titleColor: AppColors.txtColorWhite,
                  buttonTitle: 'Search flights',
                  onPressed: () {
                    if (provider.selectedFrom != null &&
                        provider.selectedTo != null) {
                      final payload = {
                        "from": provider.selectedFrom!.airportCode,
                        "to": provider.selectedTo!.airportCode,
                        "passengers": provider.passengerCount,
                        "sort_by": "price_asc",
                        "filters": {
                          "airline": "",
                          "price_min": 0,
                          "price_max": 10000,
                          "stops": 0,
                          "aircraft_type": "",
                        },
                      };
                      Provider.of<FlightResultProvider>(
                        context,
                        listen: false,
                      ).searchFlights(payload, context);

                      provider.addSavedTrip(
                        Flight(
                          logo: 'citilink_logo.png',
                          airline: 'Citilink',
                          departureTime: '10:00',
                          arrivalTime: '12:00',
                          departureCode:
                              provider.selectedFrom!.airportCode ?? '',
                          arrivalCode: provider.selectedTo!.airportCode ?? '',
                          departureCity: provider.selectedFrom!.city ?? '',
                          arrivalCity: provider.selectedTo!.city ?? '',
                          duration: '2h 00m',
                          date: DateFormat(
                            'MMM dd, yyyy',
                          ).format(provider.selectedDate),
                          passengers: provider.passengerCount,
                        ),
                      );

                      Get.toNamed(AppRoutes.flightResult);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select both from and to airports',
                          ),
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(15),
                  primaryColor: AppColors.activecolor,
                  secondaryColor: AppColors.activecolor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAirportSearchBottomSheet(
    String hintText,
    List<Airport> airports,
    Function(Airport?) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setState) {
            final filteredAirports = airports
                .where(
                  (a) =>
                      (a.city ?? '').toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ) ||
                      (a.airportCode ?? '').toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ),
                )
                .toList();

            return Container(
              height: Utility.getScreenHeight(value: 80),
              padding: EdgeInsets.all(Utility.getScreenWidth(value: 5)),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Utility.verticalspace(2),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search city or airport...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.greyColor,
                      ),
                      filled: true,
                      fillColor: AppColors.lightbgColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchQuery = val;
                      });
                    },
                  ),
                  Utility.verticalspace(2),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredAirports.length,
                      itemBuilder: (context, index) {
                        final airport = filteredAirports[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.flight_takeoff,
                            color: AppColors.activecolor,
                          ),
                          title: Utility.globalText(
                            text: airport.city ?? 'N/A',
                            fontSize: 1.8,
                            fontWeight: FontWeight.w600,
                            color: AppColors.txtColorBlack,
                          ),
                          subtitle: Utility.globalText(
                            text: airport.airportCode ?? 'N/A',
                            fontSize: 1.4,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor,
                          ),
                          onTap: () {
                            onChanged(airport);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAirportDropdown(
    String label,
    String hintText,
    Airport? selected,
    List<Airport> airports,
    Function(Airport?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: label,
          fontSize: 1.5,
          fontWeight: FontWeight.w400,
          color: AppColors.txtColorBlack54,
        ),
        GestureDetector(
          onTap: () =>
              _showAirportSearchBottomSheet(hintText, airports, onChanged),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: Utility.getScreenHeight(value: 1),
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Utility.globalText(
                  text: selected != null
                      ? '${selected.city ?? ''} (${selected.airportCode ?? ''})'
                      : hintText,
                  fontSize: 1.6,
                  fontWeight: selected != null
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: selected != null
                      ? AppColors.txtColorBlack
                      : AppColors.greyColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(
    String label,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utility.globalText(
            text: label,
            fontSize: 1.5,
            fontWeight: FontWeight.w400,
            color: AppColors.greyColor,
          ),
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.greyColor),
              Utility.horizontalspace(2),
              Utility.globalText(
                text: value,
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

  Widget _buildPassengerDropdown(
    String label,
    int selected,
    Function(int?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility.globalText(
          text: label,
          fontSize: 1.5,
          fontWeight: FontWeight.w400,
          color: AppColors.greyColor,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: selected,
            isExpanded: true,
            isDense: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: AppColors.greyColor,
            ),
            items: [1, 2, 3, 4, 5].map((count) {
              return DropdownMenuItem<int>(
                value: count,
                child: Utility.globalText(
                  text: '$count people',
                  fontSize: 1.6,
                  fontWeight: FontWeight.w600,
                  color: AppColors.txtColorBlack,
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
