import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flightbookingapp/providers/flight_result_provider.dart';
import 'widgets/ticket_painters.dart';
import '../../../constants/app_routers.dart';
import '../../../constants/color_const.dart';
import '../../../constants/utility_const.dart';
import '../../../model/flight_result_model.dart';
import '../../../providers/flight_detail_provider.dart';

class FlightResultScreen extends StatelessWidget {
  const FlightResultScreen({super.key});

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
          child: Column(
            children: [
              _buildHeader(context),
              _buildFilterList(context),
              Expanded(child: _buildFlightList(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterBottomSheet(context),
        backgroundColor: Colors.blue.withValues(alpha: 0.4),
        elevation: 0,
        child: const Icon(Icons.tune, color: Colors.blue),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Utility.getScreenWidth(value: 5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Utility.globalText(
            text: 'Flight result',
            fontSize: 2.2,
            fontWeight: FontWeight.bold,
            color: AppColors.txtColorBlack,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterList(BuildContext context) {
    final filters = [
      {'label': 'Lowest to Highest', 'key': 'price_asc'},
      {'label': 'Preferred airlines', 'key': 'preferred'},
      {'label': 'Departure', 'key': 'departure_asc'},
    ];

    return SizedBox(
      height: Utility.getScreenHeight(value: 5.5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: Utility.getScreenWidth(value: 5),
        ),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Consumer<FlightResultProvider>(
            builder: (context, provider, child) {
              final isSelected =
                  provider.selectedFilter == filters[index]['key'];
              return GestureDetector(
                onTap: () => provider.setFilter(filters[index]['key']!),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.bgThemeColorPrimary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.bgThemeColorPrimary
                          : Colors.grey.shade300,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Utility.globalText(
                    text: filters[index]['label']!,
                    fontSize: 1.6,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.txtColorBlack,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFlightList(BuildContext context) {
    return Consumer<FlightResultProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.flights.isEmpty) {
          return const Center(child: Text('No flights found'));
        }
        return RefreshIndicator(
          onRefresh: () async {
            if (provider.currentSearchPayload.isNotEmpty) {
               await provider.searchFlights(provider.currentSearchPayload, context, isRefresh: true);
            }
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(Utility.getScreenWidth(value: 5)),
            itemCount: provider.flights.length,
            itemBuilder: (context, index) {
              final flight = provider.flights[index];
              return _buildFlightCard(flight, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildFlightCard(FlightData flight, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: PhysicalShape(
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
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          flight.airlineLogo ?? '',
                          height: 20,
                          width: 20,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.flight, color: Colors.green),
                        ),
                      ),
                      Utility.globalText(
                        text: flight.airlineName ?? '',
                        fontSize: 2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.txtColorBlack,
                      ),
                    ],
                  ),
                  Utility.verticalspace(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildTimeCity(
                        flight.departure?.time ?? '',
                        flight.departure?.airportCode ?? '',
                        flight.departure?.city ?? '',
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
                              text: flight.duration ?? '',
                              fontSize: 1.4,
                              fontWeight: FontWeight.w500,
                              color: AppColors.txtColorBlack,
                            ),
                          ],
                        ),
                      ),
                      _buildTimeCity(
                        flight.arrival?.time ?? '',
                        flight.arrival?.airportCode ?? '',
                        flight.arrival?.city ?? '',
                      ),
                    ],
                  ),
                  Utility.verticalspace(2),
                ],
              ),
            ),
            SizedBox(
              height: 18,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Utility.globalText(
                        text: '\$${flight.price?.amount ?? 0}',
                        fontSize: 2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bgThemeColorPrimary,
                      ),
                      Utility.globalText(
                        text: '/person',
                        fontSize: 1.4,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ],
                  ),
                  Utility.globalTextButton(
                    heightVal: 5,
                    widthVal: 35,
                    titleColor: Colors.white,
                    buttonTitle: 'View detail',
                    onPressed: () {
                      Provider.of<FlightDetailProvider>(
                        context,
                        listen: false,
                      ).fetchFlightDetail(flight.id!, context);
                      Get.toNamed(AppRoutes.flightDetail);
                    },
                    borderRadius: BorderRadius.circular(25),
                    primaryColor: Colors.black,
                    secondaryColor: Colors.black,
                  ),
                ],
              ),
            ),
            verticalSpace(1),
          ],
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

  void _showFilterBottomSheet(BuildContext context) {
    final provider = Provider.of<FlightResultProvider>(context, listen: false);
    provider.fetchFiltersData(context);

    String selectedAirline =
        provider.currentSearchPayload['filters']?['airline'] ?? '';
    String selectedAircraft =
        provider.currentSearchPayload['filters']?['aircraft_type'] ?? '';
    String selectedPriceSort =
        provider.currentSearchPayload['sort_by'] ?? 'price_asc';
    int selectedStops = provider.currentSearchPayload['filters']?['stops'] ?? 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Consumer<FlightResultProvider>(
              builder: (context, filterProvider, child) {
                return Container(
                  height: Utility.getScreenHeight(value: 80),
                  padding: EdgeInsets.all(Utility.getScreenWidth(value: 5)),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: filterProvider.isLoadingFilters
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 40,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Utility.verticalspace(3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utility.globalText(
                                  text: 'Advanced Filters',
                                  fontSize: 2.2,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.txtColorBlack,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            Utility.verticalspace(2),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Utility.globalText(
                                      text: 'Sort By Price',
                                      fontSize: 1.6,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.txtColorBlack,
                                    ),
                                    Utility.verticalspace(1),
                                    Row(
                                      children: [
                                        ChoiceChip(
                                          label: Utility.globalText(
                                            text: 'Ascending',
                                            fontSize: 1.5,
                                            color: AppColors.txtColorBlack,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          selected:
                                              selectedPriceSort == 'price_asc',
                                          onSelected: (val) {
                                            setState(
                                              () => selectedPriceSort =
                                                  'price_asc',
                                            );
                                          },
                                        ),
                                        horizontalSpace(4),
                                        ChoiceChip(
                                          label: Utility.globalText(
                                            text: 'Descending',
                                            fontSize: 1.5,
                                            color: AppColors.txtColorBlack,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          selected:
                                              selectedPriceSort == 'price_desc',
                                          onSelected: (val) {
                                            setState(
                                              () => selectedPriceSort =
                                                  'price_desc',
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Utility.verticalspace(3),
                                    Utility.globalText(
                                      text: 'Airline',
                                      fontSize: 1.6,
                                      color: AppColors.txtColorBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Utility.verticalspace(1),
                                    DropdownButtonFormField<String>(
                                      value: selectedAirline.isEmpty
                                          ? null
                                          : selectedAirline,
                                      hint: Utility.globalText(
                                        text: 'Any Airline',
                                        fontSize: 1.5,
                                        color: AppColors.txtColorBlack,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      isExpanded: true,
                                      items: [
                                        DropdownMenuItem(
                                          value: '',
                                          child: Utility.globalText(
                                            text: 'Any Airline',
                                            fontSize: 1.5,
                                            color: AppColors.txtColorBlack,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        ...filterProvider.availableAirlines.map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Utility.globalText(
                                              text: e,
                                              fontSize: 1.6,
                                              color: AppColors.txtColorBlack,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: (val) {
                                        setState(
                                          () => selectedAirline = val ?? '',
                                        );
                                      },
                                    ),
                                    Utility.verticalspace(3),
                                    Utility.globalText(
                                      color: AppColors.txtColorBlack,
                                      text: 'Aircraft Type',
                                      fontSize: 1.6,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Utility.verticalspace(1),
                                    DropdownButtonFormField<String>(
                                      value: selectedAircraft.isEmpty
                                          ? null
                                          : selectedAircraft,
                                      hint: Utility.globalText(
                                        text: 'Any Aircraft Type',
                                        fontSize: 1.5,
                                        color: AppColors.txtColorBlack,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      isExpanded: true,
                                      items: [
                                        DropdownMenuItem(
                                          value: '',
                                          child: Utility.globalText(
                                            text: 'Any Aircraft Type',
                                            fontSize: 1.5,
                                            color: AppColors.txtColorBlack,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        ...filterProvider.availableAircrafts
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Utility.globalText(
                                                  text: e,
                                                  fontSize: 1.6,
                                                  color:
                                                      AppColors.txtColorBlack,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                      ],
                                      onChanged: (val) {
                                        setState(
                                          () => selectedAircraft = val ?? '',
                                        );
                                      },
                                    ),
                                    Utility.verticalspace(3),
                                    Utility.globalText(
                                      text: 'Stops',
                                      fontSize: 1.6,
                                      color: AppColors.txtColorBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Utility.verticalspace(1),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (selectedStops > 0)
                                              setState(() => selectedStops--);
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),
                                        Utility.globalText(
                                          text: selectedStops == 0
                                              ? 'Any Stops'
                                              : selectedStops.toString(),
                                          fontSize: 1.6,
                                          color: AppColors.txtColorBlack,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (selectedStops < 3)
                                              setState(() => selectedStops++);
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Utility.verticalspace(2),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      provider.applyAdvancedFilters(
                                        'price_asc',
                                        '',
                                        '',
                                        0,
                                        context,
                                      );
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text('Reset'),
                                  ),
                                ),
                                horizontalSpace(4),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      provider.applyAdvancedFilters(
                                        selectedPriceSort,
                                        selectedAirline,
                                        selectedAircraft,
                                        selectedStops,
                                        context,
                                      );
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      backgroundColor: AppColors.activecolor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Apply Filter',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                );
              },
            );
          },
        );
      },
    );
  }
}
