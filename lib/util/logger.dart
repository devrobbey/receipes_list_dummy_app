import 'dart:developer' as Log;

class Logger {
  const Logger(this._name);

  final String _name;

  void log(String msg, {error, stackTrace}) {
    Log.log('$msg ${error != null ? ': $error' : ''}',
        error: error,
        stackTrace: stackTrace,
        name: '${DateTime.now()} $_name');
  }
}
