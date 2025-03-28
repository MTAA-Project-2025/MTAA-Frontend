import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';

class GlobalSearch {
  String filterStr;
  PageParameters pageParameters;

  GlobalSearch({
    required this.filterStr,
    required this.pageParameters,
  });

  Map<String, dynamic> toJson() {
    return {
      'filterStr': filterStr,
      'pageParameters': pageParameters.toJson(),
    };
  }
}
