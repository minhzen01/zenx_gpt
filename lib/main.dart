import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenx_chatbot/bloc/ai_image/ai_image_bloc.dart';
import 'package:zenx_chatbot/bloc/chatbot/chatbot_bloc.dart';
import 'package:zenx_chatbot/bloc/translate/translate_bloc.dart';
import 'package:zenx_chatbot/constants/app_constants.dart';
import 'package:zenx_chatbot/hive_db/hive_db.dart';
import 'package:zenx_chatbot/widgets/no_glow_scroll.dart';
import 'constants/app_colors.dart';
import 'routes/route_name.dart';
import 'routes/router.dart';
import 'utils/app_utils/app_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDB.initialize();
  await AppUtils.systemUIModeFullScreen();
  AppUtils.systemUIOverlayTrans();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ChatBotBloc()),
        BlocProvider(create: (BuildContext context) => AiImageBloc()),
        BlocProvider(create: (BuildContext context) => TranslateBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConst.appName,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0.5,
            shadowColor: AppColors.lightBg,
            backgroundColor: AppColors.bgApp,
            iconTheme: IconThemeData(color: AppColors.lightBg),
            titleTextStyle: TextStyle(
              color: AppColors.lightBg,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        darkTheme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          brightness: Brightness.dark,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          ),
        ),
        themeMode: ThemeMode.light,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: NoGlowScroll(),
            child: child!,
          );
        },
        initialRoute: RouteName.splashScreen,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
