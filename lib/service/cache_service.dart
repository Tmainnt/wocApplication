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
        final userDataList = [
            userData.token,
            userData.email,
            userData.name,
            userData.gender,
            userData.dob.toIso8601String(),
            userData.phone,
            userData.role,
            userData.profileImage,
            userData.status,
            userData.createTimestamp.toIso8601String(),
            userData.updateTimestamp.toIso8601String(),
        ];
        _cacheStorage.save(key: "user_data", value: userDataList);
    }
}