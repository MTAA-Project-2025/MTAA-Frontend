import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:mtaa_frontend/domain/entities/images/my_image_table.dart';
import 'package:mtaa_frontend/domain/entities/locations/simple_location_point_table.dart';
import 'package:mtaa_frontend/domain/entities/posts/location_posts_table.dart';
import 'package:mtaa_frontend/domain/entities/posts/posts_table.dart';
import 'package:mtaa_frontend/domain/entities/posts/scheduled_post_table.dart';
import 'package:mtaa_frontend/domain/entities/users/user_table.dart';
import 'package:path_provider/path_provider.dart';

part 'my_db_context.g.dart';

@DriftDatabase(tables: [MyImages, Users, Posts, SimpleLocationPoints, LocationPosts, SchedulePosts])
class MyDbContext extends _$MyDbContext {
  @override
  int get schemaVersion => 1;

  MyDbContext([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'drift_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
