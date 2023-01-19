import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class VehicleDetailsController {
  getWishlistItems() async {
    var sp = await SharedPreferences.getInstance();
    List<String> wish = sp.getStringList("fav") ?? [];
    log(wish.toString(), name: "wish shared_pref");
    return wish;
  }

  addToWishlist(String id, List<String> wish) async {
    var sp = await SharedPreferences.getInstance();
    List<String> fav = wish;
    if (fav.contains(id)) {
      fav.remove(id);
    } else {
      fav.add(id);
    }
    await sp.setStringList("fav", fav);
    // bool res =
    // print(res);
    // print(sp.getStringList("fav"));
    return fav;
  }
}
