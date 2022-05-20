class FavoritesManager {
  FavoritesManager._privateConstructor();

  ///The shared instance of the FavoriteManager
  static final FavoritesManager _shared =
      FavoritesManager._privateConstructor();

  ///Gets the shared instance of the FavoriteManager
  static FavoritesManager get getShared => _shared;

  ///Contains all the id of the favorite races
  List<String> favoriteRaces = [];

  void addToFavorites(String id) {
    favoriteRaces.add('$id,');
  }

  void removeFromFavorites(String id) {
    favoriteRaces.remove('$id,');
  }

  String getArrayOfFavoriteRaces() {
    String favorites = '';

    for (String raceId in favoriteRaces) {
      favorites += raceId;
    }

    return favorites;
  }

  ///Returns if a given string is favorite
  bool isFavorite(String id) {
    for (String race in favoriteRaces) {
      if (race == (id += ',')) {
        return true;
      }
    }

    return false;
  }
}
