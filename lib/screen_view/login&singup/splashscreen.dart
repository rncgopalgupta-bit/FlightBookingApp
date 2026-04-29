import 'package:flightbookingapp/constants/app_routers.dart';
import 'package:flightbookingapp/constants/color_const.dart';
import 'package:flightbookingapp/constants/utility_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
    _animController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      _navigate();
    });
  }

  Future<void> _navigate() async {
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4285F4), Color(0xFFE3F2FD)],
            begin: FractionalOffset(0.0, 0.2),
            end: FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/flyingplane.gif',
                    height: Utility.getScreenHeight(value: 30),
                    fit: BoxFit.contain,
                  ),
                  verticalSpace(2.5),
                  Utility.globalText(
                    text: 'AeroFly',
                    fontSize: 4.0,
                    fontWeight: FontWeight.w800,
                    color: AppColors.txtColorWhite,
                  ),
                  verticalSpace(0.8),
                  Utility.globalText(
                    text: 'Your journey, elevated.',
                    fontSize: 1.8,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                  verticalSpace(6),
                  SizedBox(
                    width: Utility.getScreenHeight(value: 3),
                    height: Utility.getScreenHeight(value: 3),
                    child: const CircularProgressIndicator(
                      color: Colors.white54,
                      strokeWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
