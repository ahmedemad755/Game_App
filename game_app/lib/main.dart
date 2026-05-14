import 'package:flutter/material.dart';
import 'package:game_app/core/di/dependency_injection.dart';
import 'package:game_app/core/routing/routes.dart';

const Color appBackgroundColor = Color(0xFF121212);
const Color appSurfaceColor = Color(0xFF1E1E1E);
const Color appAccentColor = Color(0xFFE53935);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: appBackgroundColor,
        colorScheme: const ColorScheme.dark(
          primary: appAccentColor,
          secondary: appAccentColor,
          surface: appSurfaceColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: appBackgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: appSurfaceColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: appAccentColor,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: Routes.homeScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
