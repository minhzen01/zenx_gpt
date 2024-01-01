import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import 'package:zenx_chatbot/constants/app_constants.dart';
import 'package:zenx_chatbot/hive_db/hive_db.dart';
import 'package:zenx_chatbot/models/home_type.dart';
import 'package:zenx_chatbot/screen/feature/chatbot_feature.dart';
import 'package:zenx_chatbot/screen/feature/image_feature.dart';
import 'package:zenx_chatbot/utils/app_utils/app_utils.dart';
import 'package:zenx_chatbot/widgets/home_card.dart';

import 'feature/translator_feature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AppUtils.enabledSystemUIMode();
    HiveDB.showBoarding = false;
  }

  void _goToScreen(HomeType homeType, BuildContext context) {
    if (homeType == HomeType.aiChatBot) {
      Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) => const ChatBotFeature()));
    } else if (homeType == HomeType.aiImage) {
      Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) => const ImageFeature()));
    } else if (homeType == HomeType.aiTranslate) {
      Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) => const TranslatorFeature()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      appBar: AppBar(
        title: const Text(AppConst.appBarChatBot),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 6),
        children: HomeType.values
            .map(
              (e) => HomeCard(
                onTap: () {
                  _goToScreen(e, context);
                },
                homeType: e,
              ),
            )
            .toList(),
      ),
    );
  }
}
