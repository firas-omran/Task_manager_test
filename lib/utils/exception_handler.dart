import 'dart:io';

String handleException(dynamic exception) {
  if (exception is FormatException) {
    return 'Invalid data format. Please check your input.';
  } else if (exception is PathAccessException) {
    return 'Unable to load storage';
  } else {
    return "There's an error. Please make sure you are connected to the network or try again later";
  }
}
