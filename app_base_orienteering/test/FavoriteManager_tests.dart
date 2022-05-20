import 'package:flutter_test/flutter_test.dart';
import '../lib/Managers/FavoritesManager.dart';

void main() {
  FavoritesManager favoritesManager = FavoritesManager.getShared;

  testWidgets('The favorite maanger adds a string',
      (WidgetTester tester) async {
    favoritesManager.addToFavorites('id1');
    favoritesManager.addToFavorites('id2');
    favoritesManager.addToFavorites('id3');

    expect(['id1,', 'id2,', 'id3,'], favoritesManager.favoriteRaces);
  });

  testWidgets('The favorite manager removes a string',
      (WidgetTester tester) async {
    favoritesManager.removeFromFavorites('id1');

    expect(['id2,', 'id3,'], favoritesManager.favoriteRaces);
  });

  testWidgets('The array is turned into a string', (WidgetTester tester) async {
    String favoritesToString = favoritesManager.getArrayOfFavoriteRaces();
    expect('id2,id3,', favoritesToString);
  });

  testWidgets('The id is contained in favorites', (WidgetTester tester) async {
    expect(true, favoritesManager.isFavorite('id2'));
  });
}
