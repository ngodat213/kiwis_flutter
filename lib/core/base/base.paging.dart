import 'package:kiwis_flutter/core/constants/app_export.dart';

class BasePaging<T> {
  List<T> listItems = [];
  int pageNumber = AppValues.defaultPageNumber;
  bool isLoadingPage = false;
  bool endOfList = false;

  initRefresh() {
    listItems = [];
    pageNumber = AppValues.defaultPageNumber;
    isLoadingPage = false;
    endOfList = false;
  }

  bool canLoadNextPage() {
    return !isLoadingPage && !endOfList;
  }

  appendPage(List<T> items) {
    listItems.addAll(items);
    pageNumber++;
  }

  appendLastPage(List<T> items) {
    listItems.addAll(items);
    endOfList = true;
  }
}
