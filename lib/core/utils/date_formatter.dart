import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  // Parse the input string to a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Define the desired format
DateFormat dateFormat = DateFormat('dd MMMM yyyy');

  // Format the DateTime object to a string
  String formattedDate = dateFormat.format(dateTime);

  return formattedDate;
}
