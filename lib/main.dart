import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overdose/app/dependency_injection.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  Firebase.initializeApp();
  runApp(MyApp());
}
