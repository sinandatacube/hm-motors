import 'package:hm__motors/model/vehicle_details_model.dart';

class WishListModel {
  List<VehicleDetailsModel> cars;

  WishListModel({
    required this.cars,
  });

  factory WishListModel.fromJson(List<dynamic> json) => WishListModel(
        cars: List<VehicleDetailsModel>.from(
            json.map((e) => VehicleDetailsModel.fromJson(e))),
      );
}
