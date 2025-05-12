//Taken from https://medium.com/@m1nori/flutter-pagination-without-any-packages-8c24095555b3, but modified
import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';

class PaginationScrollController {
  late ScrollController scrollController;
  bool isLoading = false;
  bool stopLoading = false;
  PageParameters pageParameters = PageParameters(pageNumber: 0, pageSize: 10);
  double boundaryOffset = 0.5;
  late Function loadAction;

  void init({Function? initAction, required Function loadAction, PageParameters? pageParameters}) {
    if (pageParameters != null) {
      this.pageParameters = pageParameters;
    }
    else {
      this.pageParameters.pageNumber=0;
    }
    boundaryOffset=0.5;
    isLoading = false;
    stopLoading = false;
    if (initAction != null) {
      initAction();
    }
    this.loadAction = loadAction;
    scrollController = ScrollController()..addListener(scrollListener);
  }

  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() async {
    if (stopLoading) {
      return;
    }
    if (scrollController.offset >= scrollController.position.maxScrollExtent * boundaryOffset && !isLoading) {
      isLoading = true;
      await loadAction();
      isLoading = false;
      boundaryOffset = 1 - 1 / (pageParameters.pageNumber * 2);
    }
  }
}
