import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/appwrite_config.dart';
import 'core/auth_service.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Appwrite
  AppwriteConfig().init();
  
  runApp(const MarketTrackApp());
}

class MarketTrackApp extends StatelessWidget {
  const MarketTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'MarketTrack',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.dark(
            primary: Color(0xFF2E5BFF),
            secondary: Color(0xFF00C2A8),
            tertiary: Color(0xFFFF8A00),
            background: Color(0xFF0B1020),
            surface: Color(0xFF121A33),
            onBackground: Color(0xFFE5E7EB),
            onSurface: Color(0xFFE5E7EB),
          ),
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Color(0xFF0B1020),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF121A33),
            elevation: 0,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF121A33),
            selectedItemColor: Color(0xFF2E5BFF),
            unselectedItemColor: Color(0xFF7A8189),
          ),
          cardTheme: CardTheme(
            color: Color(0xFF121A33),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
