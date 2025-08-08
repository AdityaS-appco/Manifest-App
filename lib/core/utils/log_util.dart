import 'dart:developer' as developer;
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LogUtil {
  static late Logger _logger;
  static bool _initialized = false;
  static bool _fileLoggingEnabled = false;
  static File? _logFile;

  /// Initialize the logger
  static Future<void> init({
    Level minLogLevel = Level.verbose,
    bool printEnabled = true,
    bool fileLoggingEnabled = false,
  }) async {
    // Create custom printer with time and caller info
    final PrettyPrinter prettyPrinter = PrettyPrinter(
      methodCount: 0, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
    );

    _fileLoggingEnabled = fileLoggingEnabled;

    if (fileLoggingEnabled) {
      await _initLogFile();
    }

    final List<LogOutput> outputs = [
      if (printEnabled) ConsoleOutput(),
      if (fileLoggingEnabled && _logFile != null) FileOutput(_logFile!),
    ];

    // Configure the logger
    _logger = Logger(
      filter: ProductionFilter(), // Use custom filter if needed
      printer: prettyPrinter,
      output: MultiOutput(outputs),
      level: minLogLevel,
    );

    _initialized = true;
  }

  /// Initialize log file
  static Future<void> _initLogFile() async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String logDirPath = '${appDocDir.path}/logs';
      final Directory logDir = Directory(logDirPath);

      if (!await logDir.exists()) {
        await logDir.create(recursive: true);
      }

      final String today = DateTime.now().toIso8601String().split('T')[0];
      final String logFilePath = '$logDirPath/app_log_$today.log';
      _logFile = File(logFilePath);

      // Create file if it doesn't exist
      if (!await _logFile!.exists()) {
        await _logFile!.create();
        await _logFile!.writeAsString('--- Log Start ${DateTime.now()} ---\n');
      }
    } catch (e) {
      print('Error initializing log file: $e');
      _fileLoggingEnabled = false;
    }
  }

  /// Log a message with specified level
  static void log(
    String message, {
    Level level = Level.info,
    bool printEnabled = true,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _ensureInitialized();

    final String callerInfo = _getCallerInfo();
    final String formattedMessage = '[$callerInfo] $message';

    switch (level) {
      case Level.verbose:
        _logger.v(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.debug:
        _logger.d(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.info:
        _logger.i(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.warning:
        _logger.w(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.error:
        _logger.e(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.wtf:
        _logger.wtf(formattedMessage, error: error, stackTrace: stackTrace);
        break;
      default:
        _logger.i(formattedMessage, error: error, stackTrace: stackTrace);
    }

    // Also use developer.log for better integration with DevTools
    developer.log(
      formattedMessage,
      time: DateTime.now(),
      name: level.toString().split('.').last.toUpperCase(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Ensure the logger is initialized
  static void _ensureInitialized() {
    if (!_initialized) {
      // Default initialization if not explicitly initialized
      init();
    }
  }

  /// Get caller information (class and method)
  static String _getCallerInfo() {
    try {
      final List<String> stackTraceLines =
          StackTrace.current.toString().split('\n');

      // Skip first frames which are from the logger itself
      String? callerLine;
      for (int i = 0; i < stackTraceLines.length; i++) {
        if (!stackTraceLines[i].contains('LogUtil.') &&
            !stackTraceLines[i].contains('_getCallerInfo')) {
          callerLine = stackTraceLines[i];
          break;
        }
      }

      if (callerLine == null) return 'Unknown';

      // Parse the caller line to extract class and method
      final RegExp regex = RegExp(
          r'(?:package:[\w\/\._-]+\/)?(?:[\w\/\._-]+\/)?([\w<>\._-]+)\.(?:[\w<>\._-]+)');
      final Match? match = regex.firstMatch(callerLine);

      return match?.group(1) ?? 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }

  // Convenience methods for different log levels

  /// Log a verbose message
  static void v(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: Level.verbose, error: error, stackTrace: stackTrace);
  }

  /// Log a debug message
  static void d(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: Level.debug, error: error, stackTrace: stackTrace);
  }

  /// Log an info message
  static void i(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: Level.info, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message
  static void w(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: Level.warning, error: error, stackTrace: stackTrace);
  }

  /// Log an error message
  static void e(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: Level.error, error: error, stackTrace: stackTrace);
  }

  /// Log a "what a terrible failure" message
  static void wtf(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: Level.wtf, error: error, stackTrace: stackTrace);
  }

  /// Clear the log file
  static Future<void> clearLogFile() async {
    if (_logFile != null && await _logFile!.exists()) {
      await _logFile!.writeAsString('--- Log Cleared ${DateTime.now()} ---\n');
    }
  }

  /// Get the current log file content
  static Future<String> getLogFileContent() async {
    if (_logFile != null && await _logFile!.exists()) {
      return await _logFile!.readAsString();
    }
    return '';
  }
}

/// Custom log output class for file output
class FileOutput extends LogOutput {
  final File file;

  FileOutput(this.file);

  @override
  void output(OutputEvent event) async {
    final stringList = event.lines.map((line) => '$line\n').toList();
    await file.writeAsString(stringList.join(), mode: FileMode.append);
  }
}
