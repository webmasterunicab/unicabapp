import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uniconecta/config/theme/app_theme.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/screens/video_inicio/video_inicio_screen.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Invisible status bar on android
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],

      child: Sizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            navigatorObservers: [routeObserver],
            title: 'UNICONECTA',
            debugShowCheckedModeBanner: false,
            theme: AppTheme().theme(),
            home: SplashScreen() //VideoInicioScreen(),
          );
        }
      ),
    );
  }
}

