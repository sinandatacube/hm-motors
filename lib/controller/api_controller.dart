import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hm__motors/model/homepage_model.dart';
import 'package:hm__motors/model/wishlist_model.dart';
import 'package:hm__motors/url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ApiController {
  Future homepageCall() async {
    try {
      var response = await http.get(Uri.parse(baseUrl + homepageUrl));
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        log(result.toString());
        MainHomePageModel result2 = MainHomePageModel.fromJson(result);
        WishListModel mostSearch =
            WishListModel.fromJson(result["most_search"]);
        // print(mostSearch);
        // log(result2.toString());
        // log(result2.offerwall.toString());

        var result3 = {
          "data": result2,
          "budget": result["budget"],
          "mostSearch": mostSearch
        };
        return result3;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  Future enterNumber(String number) async {
    try {
      Map params = {"cus_phone": number};

      var response =
          await http.post(Uri.parse(baseUrl + loginUrl), body: params);
      if (response.statusCode == 200) {
        log(response.body.toString());
        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future register(String number, String name) async {
    try {
      Map params = {"cus_phone": number, "cus_name": name};

      var response = await http.post(Uri.parse(baseUrl + registrationUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/register_customers"),
          body: params);
      if (response.statusCode == 200) {
        log(response.body.toString());

        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future brandWiseCars(
    String brandId,
  ) async {
    try {
      Map params = {
        "brandId": brandId,
      };

      var response = await http.post(Uri.parse(baseUrl + brandWiseCarsUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/register_customers"),
          body: params);
      if (response.statusCode == 200) {
        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        log(response.body.toString());

        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future sentInterest(String id, String number) async {
    try {
      Map params = {
        "adId": id,
        "mobileNumber": number,
      };

      var response = await http.post(Uri.parse(baseUrl + sentInterestUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/register_customers"),
          body: params);
      if (response.statusCode == 200) {
        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future fetchvehicleDetails(
    String purchaseId,
  ) async {
    try {
      Map params = {
        "pId": purchaseId,
      };

      var response = await http.post(Uri.parse(baseUrl + vehicleDetailsUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/register_customers"),
          body: params);

      if (response.statusCode == 200) {
        log(response.body.toString());

        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future fetchWishlist(
    List<String> purchaseIds,
  ) async {
    try {
      Map params = {
        "pId": purchaseIds.toString(),
      };
      log(params.toString(), name: "wish_params");
      var response = await http.post(Uri.parse(baseUrl + wishlistUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/CarsBy_Array_of_Pid"),
          body: params);
      // print(response.body);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        return result;

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        log(response.body.toString());

        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future fetchUserDetails(
    String mobile,
  ) async {
    try {
      Map params = {
        "mobileNumber": mobile,
      };
      var response = await http.post(Uri.parse(baseUrl + userDetailsUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/CarsBy_Array_of_Pid"
          // ),
          body: params);
      // print(response.body);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        // List images=[];
        // for(int i=0;i<result["fullImages"].length;i++){
        //   images.add(result[i]["fullImages"]);
        // }
        // // List images=result["fullImages"];
        // var result2={"data"

        // }
        return result;

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        // log(response.body.toString());

        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future search(
    String keyword,
  ) async {
    try {
      Map params = {"keyword": keyword.trim()};

      var response =
          await http.post(Uri.parse(baseUrl + searchUrl), body: params);
      if (response.statusCode == 200) {
        log(response.body.toString());
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteUser(
    String mobileNumber,
  ) async {
    try {
      Map params = {"mobileNumber": mobileNumber};
      log(mobileNumber);
      var response =
          await http.post(Uri.parse(baseUrl + deleteUserUrl), body: params);
      if (response.statusCode == 200) {
        log(response.body.toString());
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future submitSellCar(
      String registrationNumber,
      String brand,
      String model,
      String year,
      String owners,
      String kms,
      String insurance,
      String tyre,
      String vehicleCondition,
      List images,
      String mobile,
      String varient,
      String expectedPrice) async {
    try {
      Map params = {
        "Reg_number": registrationNumber,
        "brand": brand,
        "model": model,
        "regYear": year,
        "owner": owners,
        "kms": kms,
        "insurance": insurance,
        "tyre": tyre,
        "condition": vehicleCondition,
        "Images": jsonEncode(images),
        "mobile": mobile,
        "variant": varient,
        "car_price": expectedPrice
      };
      log(expectedPrice);
      var response =
          await http.post(Uri.parse(baseUrl + sellCarUrl), body: params);
      if (response.statusCode == 200) {
        log(response.body.toString());
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getUserAds(
    String mobileNumber,
  ) async {
    try {
      Map params = {"mobileNumber": mobileNumber};
      log(mobileNumber);
      var response =
          await http.post(Uri.parse(baseUrl + userAdsUrl), body: params);
      if (response.statusCode == 200) {
        log(response.body.toString());
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteUserAds(String imageName, String adId) async {
    try {
      Map params = {"image_name": imageName, "ad_id": adId};
      log(imageName);
      log(adId);
      var response =
          await http.post(Uri.parse(baseUrl + deleteUserAdsUrl), body: params);
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future saveFCMTokentoServer(String number) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();

      if (number.isNotEmpty && number != '0') {
        String savedFCM = sharedPreferences.getString('fcm_token') ?? '';
        if (savedFCM.isEmpty) {
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          String fcmToken = await messaging.getToken() ?? '';
          if (fcmToken.isNotEmpty) {
            Map params = {'mobileNumber': number, 'token_number': fcmToken};
            // print(fcmToken);
            var response = await http.post(Uri.parse(baseUrl + saveFcmTokenUrl),
                body: params);
            if (response.statusCode == 200) {
              var result = await jsonDecode(response.body);
              log("result.toString()");
              log(result.toString());
              log(fcmToken);
              if (result == "Inserted") {
                // print("local");
                saveFCMToken(fcmToken);
              }
              // print('fcm res server ' + result.toString());
            }
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

//fcm locally
  void saveFCMToken(var fcmToken) async {
    debugPrint('FCM Saved');
    var sharedPreferences = await SharedPreferences.getInstance();
    String savedFCM = sharedPreferences.getString('fcm_token') ?? '';
    if (savedFCM.isEmpty) {
      sharedPreferences.setString('fcm_token', fcmToken);
    }
  }
}
