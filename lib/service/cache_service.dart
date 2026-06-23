import "package:cache_storage/cache_storage.dart";
import "package:woc/model/user.dart";

class CacheService {
    final _cacheStorage  = CacheStorage.open();
    
    List<String> getUserData(){
        final userData = _cacheStorage.match(key: "user_data");
        if (userData.isNotEmpty) {
            return userData;
        }
        return [];
    }

    void saveUserData(User userData){

        _cacheStorage.save(key: "user_data", value: userData);
    }
}