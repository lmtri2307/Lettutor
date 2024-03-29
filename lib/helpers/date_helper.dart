class DateHelper {
  const DateHelper();

  bool isSameDate(DateTime a, DateTime b) {
    return a.day == b.day && a.month == b.month && a.year == b.year;
  }

  List<T> sortByDate<T>(List<T> itemList, DateTime Function(T item) getDate,
      {bool ascending = true}) {
    final copy = [...itemList];
    if(ascending){
      copy.sort((a, b) => getDate(a).compareTo(getDate(b)));
    } else {
      copy.sort((a, b) => -getDate(a).compareTo(getDate(b)));
    }
    return copy;
  }

  List<List<T>> groupByDate<T>(List<T> itemList, DateTime Function(T) getDate) {
    List<List<T>> result = [];
    List<T> currentGroup = [];

    for (var i = 0; i < itemList.length; i++) {
      if (currentGroup.isEmpty ||
          isSameDate(getDate(itemList[i]), getDate(currentGroup[0]))) {
        currentGroup.add(itemList[i]);
      } else {
        result.add(currentGroup);
        currentGroup = [itemList[i]];
      }
    }
    if (currentGroup.isNotEmpty) {
      result.add(currentGroup);
    }

    return result;
  }

  DateTime parseDateString(String dateString) {
    List<String> parts = dateString.split('-');

    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    return DateTime(year, month, day);
  }
}
