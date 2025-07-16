import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superheroes/components/hero_card.dart';
import 'package:superheroes/data/hero_controller.dart';

import 'package:superheroes/services/api_service.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

// https://superheroapi.com/api/266cfc86b573bb180542dc01e052ef0d

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  final HeroesController heroController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Superhero Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search for a superhero',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  heroController.fetchHeroesByName(text);
                } else {
                  heroController.heroes.clear();
                  Text('Please enter a name to search');
                }
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (heroController.isloading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (heroController.error.isNotEmpty) {
                return Center(child: Text(heroController.error.value));
              } else if (heroController.heroes.isEmpty) {
                return const Center(child: Text('No heroes found'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: heroController.heroes.length,
                    itemBuilder: (context, index) {
                      final hero = heroController.heroes[index];
                      return HeroCard(
                        heroName: hero['name'],
                        heroImage: hero['image'],
                        bio:
                            hero['biography']['full-name'] ??
                            'No biography available',
                        powerstats: hero['powerstats'] ?? {},
                        appearance: hero['appearance'] ?? {},
                      );
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
