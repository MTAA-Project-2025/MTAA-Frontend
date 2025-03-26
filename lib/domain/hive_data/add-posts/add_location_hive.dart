import 'package:hive/hive.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';


part 'add_location_hive.g.dart';

@HiveType(typeId: 6)
class AddLocationHive extends HiveObject{
  AddLocationHive();

  factory AddLocationHive.fromRequest(AddLocationRequest request){
    return AddLocationHive(

    );
  }
}
