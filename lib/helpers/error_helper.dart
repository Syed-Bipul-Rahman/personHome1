import 'package:logger/logger.dart';

class ErrorHelper {
  static final Logger _logger = Logger();

  static String getErrorDetails(dynamic error, StackTrace stackTrace) {
    String stackTraceString = stackTrace.toString();
    List<String> stackTraceLines = stackTraceString.split('\n');
    String relevantLine = stackTraceLines[0];
    RegExp regExp =
    RegExp(r'^#\d+\s+([\w<>]+).*\.(.*)\(.*\)\s+\[.*:(\d+):\d+\]$');
    Match? match = regExp.firstMatch(relevantLine);

    if (match != null) {
      String className = match.group(1)!;
      String methodName = match.group(2)!;
      String lineNumber = match.group(3)!;

      String errorMessage = '$error (Class: $className, Method: $methodName, Line: $lineNumber)';
      _logger.e(errorMessage); // Log the error
      return errorMessage;
    } else {
      String errorMessage = '$error (Unable to parse stack trace)';
      _logger.e(errorMessage); // Log the error
      return errorMessage;
    }
  }
}