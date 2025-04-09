import 'package:mtaa_frontend/domain/hive_data/add-posts/add_location_hive.dart';

class AddLocationRequest {

  AddLocationRequest();

  Map<String, dynamic> toJson() {
    return {
    };
  }

  factory AddLocationRequest.fromHive(AddLocationHive hive){
    return AddLocationRequest(
    );
  }
}
