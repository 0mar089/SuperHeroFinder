import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superheroes/screens/superhero_detail_screen.dart';

class HeroCard extends StatelessWidget {
  final String heroName;
  final String heroImage;
  final String bio;
  final Map<String, dynamic> powerstats;
  final Map<String, dynamic> appearance;

  const HeroCard({
    super.key,
    required this.heroName,
    required this.heroImage,
    required this.bio,
    this.powerstats = const {},
    this.appearance = const {},
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          children: [
            Text(heroName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Image.network(heroImage, height: 150, width: 150, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(bio, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.to(() => HeroDetailScreen(
          heroName: heroName,
          heroImage: heroImage,
          bio: bio,
          powerstats: powerstats,
          appearance: appearance,
        ));
      },
    );
  }
}
