import 'package:event_bus/event_bus.dart';
import 'object_util.dart';

class EventBusUtil {
  static EventBus? _instance;

  static EventBus getInstance() {
    if (ObjectUtil.isEmpty(_instance)) _instance = EventBus();
    return _instance!;
  }
}
