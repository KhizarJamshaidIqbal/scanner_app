import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'share/custom bottom navigation bar/custom_bottom_navigation_bar.dart';



List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

    //TODO: load camera
  cameras = await availableCameras();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scanners',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CustomBottomNavigationbar(),
    );
  }
}

