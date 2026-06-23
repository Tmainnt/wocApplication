import "package:cache_storage/cache_storage.dart";

class CacheService {
    final _cacheStorage  = CacheStorage.open();
    
    void saveUserData(List<String> userData){
        _cacheStorage.save(key: "user_data", value: userData);
    }

    List<String> getUserData(){
        final userData = _cacheStorage.match(key: "user_data");
        if (userData.isNotEmpty) {
            return userData;
        }
        return [];
    }
}