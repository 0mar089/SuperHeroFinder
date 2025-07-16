import 'package:get/get.dart';
import 'package:superheroes/services/api_service.dart';

class HeroesController extends GetxController {
  var isloading = false.obs;
  var hero = {}.obs;
  var error = ''.obs;
  var heroes = <Map<String, dynamic>>[].obs;

  Future<void> fetchHeroById(int id) async {
    isloading.value = true;
    try {
      var response = await ApiService.getHeroById(id);
      hero.value = {
        'id': response['id'],
        'name': response['name'],
        'powerstats': response['powerstats'],
        'biography': response['biography'],
        'appearance': response['appearance'],
        'work': response['work'],
        'connections': response['connections'],
        'image': response['image']['url'],
      };
    } catch (e) {
      error.value = 'Error fetching hero: $e';
    } finally {
      isloading.value = false;
    }
  }

  Future<void> fetchHeroesByName(String name) async {
    isloading.value = true;
    error.value = '';
    try {
      var response = await ApiService.getHeroesByName(name);
      if (response != null) {
        heroes.value = List<Map<String, dynamic>>.from(
          response.map(
            (hero) => {
              'id': int.tryParse(hero['id'].toString()) ?? 0,
              'name': hero['name'],
              'powerstats': hero['powerstats'],
              'biography': hero['biography'],
              'appearance': hero['appearance'],
              'work': hero['work'],
              'connections': hero['connections'],
              'image': hero['image']['url'],
            },
          ),
        );
        print("Heroes found: ${heroes.length}");
      } else {
        heroes.clear();
        error.value = 'No heroes found';
      }
    } catch (e) {
      heroes.clear();
      error.value = 'Error fetching heroes: $e';
    } finally {
      isloading.value = false;
    }
  }
}
