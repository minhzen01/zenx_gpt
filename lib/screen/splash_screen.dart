import 'package:flutter/material.dart';
import 'package:zenx_chatbot/constants/image_path.dart';
import 'package:zenx_chatbot/routes/route_name.dart';
import 'package:zenx_chatbot/utils/app_utils/app_utils.dart';
import 'package:zenx_chatbot/widgets/loading/loading_custom.dart';
import '../constants/app_colors.dart';
import '../hive_db/hive_db.dart';
import '../routes/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      AppRouter.goReplacement(
        context,
        HiveDB.showBoarding ? RouteName.boardingScreen : RouteName.homeScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    /// initializing device size.
    AppUtils.mq = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: SizedBox(
        width: AppUtils.mq.width,
        child: Column(
          children: [
            const Spacer(flex: 3),
            Card(
              color: AppColors.lightBg,
              elevation: 0,
              child: Image.asset(
                ImagePath.appLogo,
                width: AppUtils.mq.width * .45,
              ),
            ),
            const Spacer(flex: 2),
            const LoadingCustom(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
