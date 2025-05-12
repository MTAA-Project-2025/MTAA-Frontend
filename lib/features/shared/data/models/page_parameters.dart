class PageParameters {
  int pageNumber;
  int pageSize;
  int offset;

  PageParameters({
    this.pageNumber=0,
    this.pageSize=10,
    this.offset=0
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'offset': offset,
    };
  }
}
