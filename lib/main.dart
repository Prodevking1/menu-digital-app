import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pos_app/routes.dart';
import 'package:pos_app/services/firebase_options.dart';
import 'package:pos_app/presentation/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://kyzaqsrkznpwbjarooyl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt5emFxc3Jrem5wd2JqYXJvb3lsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM2NDU2OTYsImV4cCI6MTk5OTIyMTY5Nn0.JW4B3Ig6Ms5Hyb8xcTMv7Sy_viu70f9F1CIR8PrBZX8',
  );

  runApp(const AppEntry());
}

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(),
      home: const HomePage() /* AddProductsToCategoryPage() */,
      debugShowCheckedModeBanner: false,
      initialBinding: BaseBinding(),
    );
  }
}

final supabase = Supabase.instance.client;
