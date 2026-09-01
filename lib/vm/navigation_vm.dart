import 'package:snd/event_processor/event.dart';
import 'package:snd/event_processor/event_processor.dart';

class NavigationVM extends EventProcessor<NavState> {
  NavigationVM(super._latestState, {super.proxies});

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case ("goto"):
        String routeId = event.params["route_id"];
        // Map<String, dynamic> routeParams = event.params["route_params"];
        update(NavState(routeId, {}));
        return true;
    }
    return false;
  }
}

class NavState {
  final String id;
  final Map<String, dynamic> params;

  NavState(this.id, this.params);

  NavState copyWith({String? id, Map<String, dynamic>? params}) {
    return NavState(id ?? this.id, params ?? this.params);
  }
}
