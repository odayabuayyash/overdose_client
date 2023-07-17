import 'package:overdose/core/network/error_handler.dart';

import '../../moduls/main/data/responses/home_responses.dart';

abstract class LocalDataCaching {
  Future<HomeResponse> getHomeData();
  Future<void> saveDataHome(HomeResponse homeResponse);
}

class LocalDataCachingImpl implements LocalDataCaching {
  String home_cache_key = 'HOMECACHEKEY';
  Map<String, CachedData> cacheMap = Map();
  int cacheTimeValidation = 600 * 1000;

  @override
  Future<HomeResponse> getHomeData() async {
    CachedData? cachedItem = cacheMap[home_cache_key];
    if (cachedItem != null && cachedItem.isVlid(cacheTimeValidation)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHED_ERROR);
    }
  }

  @override
  Future<void> saveDataHome(HomeResponse homeResponse) async {
    cacheMap[home_cache_key] = CachedData(homeResponse);
  }
}

class CachedData {
  HomeResponse data;
  int cachedTime = DateTime.now().millisecondsSinceEpoch;
  CachedData(this.data);
}

extension CachedDataExtension on CachedData {
  bool isVlid(int timeInMilisec) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    bool valid = currentTime - cachedTime < timeInMilisec;
    return valid;
  }
}
