import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/firebase_options.dart';
import 'package:flutter_firebase_auth/screens/email_password_auth_screen.dart';
import 'package:flutter_firebase_auth/screens/guest_auth_screen.dart';
import 'package:flutter_firebase_auth/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: _navigator,
      builder: (ctx, navigator) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (c) {
                return SafeArea(child: navigator!);
              },
            ),
            OverlayEntry(
              builder: (c) {
                return Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _navigator.currentState!.pushReplacementNamed(
                          "/auth/email-password",
                        );
                      },
                      child: const Text('Email + password'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _navigator.currentState!.pushReplacementNamed(
                          "/auth/guest",
                        );
                      },
                      child: const Text('As guest'),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
      routes: {
        "/auth/email-password": (ctx) => EmailPasswordAuthScreen(),
        "/auth/guest": (ctx) => GuestAuthScreen(),
        "/profile": (ctx) => ProfileScreen(),
      },
      initialRoute: "/auth/email-password",
    );
  }
}
