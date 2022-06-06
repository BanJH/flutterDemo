
class TimeUtils {
  static String? getWeekday(int day) {
    switch (day) {
      case 1:
        return "一";
        break;
      case 2:
        return "二";
        break;
      case 3:
        return "三";
        break;
      case 4:
        return "四";
        break;
      case 5:
        return "五";
        break;
      case 6:
        return "六";
        break;
      case 7:
        return "日";
        break;

    }
  }

  static String getDateTime(DateTime dateTime) {
    return "${dateTime.year}年${dateTime.month}月${dateTime.day}日${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  static String getDate(DateTime dateTime) {
    return "${dateTime.year}年${dateTime.month}月";
  }
}