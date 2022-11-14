import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_photo/firebase_options.dart';

import 'app/app.dart';
import 'app/di/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();
  runApp(MyApp());
}
