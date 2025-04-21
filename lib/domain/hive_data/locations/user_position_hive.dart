import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';


part 'user_position_hive.g.dart';

@HiveType(typeId: 10)
class UserPositionHive extends HiveObject{

  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  double accuracy;

  @HiveField(3)
  int floor;

  UserPositionHive({
    this.latitude=0,
    this.longitude=0,
    this.accuracy=0,
    this.floor=0,
  });

  factory UserPositionHive.fromResponse(Position request){
    return UserPositionHive(
        latitude: request.latitude,
        longitude: request.longitude,
        floor: request.floor==null?0:request.floor!,
    );
  }
}