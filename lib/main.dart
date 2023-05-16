import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://kyzaqsrkznpwbjarooyl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt5emFxc3Jrem5wd2JqYXJvb3lsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM2NDU2OTYsImV4cCI6MTk5OTIyMTY5Nn0.JW4B3Ig6Ms5Hyb8xcTMv7Sy_viu70f9F1CIR8PrBZX8',
  );

  runApp(AppEntry());
}

class AppEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

final supabase = Supabase.instance.client;
