import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superheroes/screens/superhero_search_screen.dart';
import 'package:superheroes/services/api_service.dart';
import 'package:superheroes/data/hero_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.init();
  Get.put(HeroesController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SuperheroSearchScreen(),
    );
  }
}
