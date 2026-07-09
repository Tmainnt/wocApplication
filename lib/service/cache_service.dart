import "package:cache_storage/cache_storage.dart";
import "package:woc/model/user.dart";
import "package:woc/provider/user_provider.dart";

class CacheService {
    final _cacheStorage  = CacheStorage.open();
    
    dynamic getUserData(){
        return _cacheStorage.match(key: "user_data");
    }

    void saveUserData(User userData){

        _cacheStorage.save(key: "user_data", value: userData);
    }

    void setUserProvider() {
        UserProvider userProvider = UserProvider();
        final userData = getUserData();
        if (userData != null) {
            userProvider.setUser(userData);
        }
    }

    void storeToCache(User userData){
      _cacheStorage.save(key: "user_data", value: userData);
    }
}