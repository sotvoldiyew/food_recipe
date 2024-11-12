import 'dart:async';

class Debouncing {
  Debouncing(this.duration);

  final Duration duration;
  Timer? _timer;

  void call(void Function() fn) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
      _timer = null;
    }

    _timer = Timer(duration, fn);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}

class Throttling {
  Throttling(this.duration);

  final Duration duration;
  Timer? _timer;

  void call(void Function() fn) {
    _timer ??= Timer(duration, () {
      _timer?.cancel();
      _timer = null;

      fn();
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}