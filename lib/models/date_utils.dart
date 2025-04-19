// models/date_utils.dart

// Helper function to get the short weekday name
String getWeekday(int weekday) {
  switch (weekday) {
    case 1:
      return "MON";
    case 2:
      return "TUES";
    case 3:
      return "WED";
    case 4:
      return "THU";
    case 5:
      return "FRI";
    case 6:
      return "SAT";
    case 7:
      return "SUN";
    default:
      return "";
  }
}

// Helper function to get the short month name
String getMonth(int month) {
  switch (month) {
    case 1:
      return "JAN";
    case 2:
      return "FEB";
    case 3:
      return "MAR";
    case 4:
      return "APR";
    case 5:
      return "MAY";
    case 6:
      return "JUN";
    case 7:
      return "JUL";
    case 8:
      return "AUG";
    case 9:
      return "SEP";
    case 10:
      return "OCT";
    case 11:
      return "NOV";
    case 12:
      return "DEC";
    default:
      return "";
  }
}

// Function to format the date as "TUES 11 JUL"
String getFormattedDate() {
  final now = DateTime.now();
  final weekday = getWeekday(now.weekday); // Get the short weekday name (e.g., "TUES")
  final day = now.day; // Get the day of the month (e.g., 11)
  final month = getMonth(now.month); // Get the short month name (e.g., "JUL")

  return "$weekday $day $month"; // Format: "TUES 11 JUL"
}