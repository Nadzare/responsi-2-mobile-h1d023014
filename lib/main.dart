import 'package:flutter/material.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/user_info.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/login_page.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/buku_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kafahmart - Inventaris Buku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.amber[700],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[700],
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amber[700],
          foregroundColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    String? token = await UserInfo().getToken();
    
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BukuPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.amber[700]!,
              Colors.amber[500]!,
              Colors.yellow[600]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.book_rounded,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Kafahmart',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sistem Inventaris Buku',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 50),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
