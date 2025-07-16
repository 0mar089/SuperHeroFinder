import 'package:flutter/material.dart';

class HeroDetailScreen extends StatefulWidget {
  final String heroName;
  final String heroImage;
  final String bio;
  final Map<String, dynamic> powerstats;
  final Map<String, dynamic> appearance;

  const HeroDetailScreen({
    super.key,
    required this.heroName,
    required this.heroImage,
    required this.bio,
    this.powerstats = const {},
    this.appearance = const {},
  });

  @override
  State<HeroDetailScreen> createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.heroName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.heroImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.heroName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.bio, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(
              'Powerstats:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.powerstats.entries.map(
              (entry) => Text('${entry.key}: ${entry.value}'),
            ),
            const SizedBox(height: 16),
            Text(
              'Appearance:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.appearance.entries.map(
              (entry) => Text('${entry.key}: ${entry.value}'),
            ),
          ],
        ),
      ),
    );
  }
}
