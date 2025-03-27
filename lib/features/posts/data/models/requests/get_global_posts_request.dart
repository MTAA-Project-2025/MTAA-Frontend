import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';

class GetGLobalPostsRequest {
  final String filterStr;
  final PageParameters pageParameters;

  GetGLobalPostsRequest({
    required this.filterStr,
    required this.pageParameters
  });

  Map<String, dynamic> toJson() {
    return {
      'filterStr': filterStr,
      'pageParameters': pageParameters.toJson(),
    };
  }
}
