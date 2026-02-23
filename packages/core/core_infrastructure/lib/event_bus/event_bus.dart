import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

/// Event bus for cross-module communication.
///
/// Allows modules to communicate without direct dependencies.
/// Events are broadcast to all subscribers of that event type.
///
/// ## Usage
///
/// Publishing events:
/// ```dart
/// eventBus.publish(InspectionLoggedEvent(inspectionId: id, hiveId: hiveId));
/// ```
///
/// Subscribing to events:
/// ```dart
/// eventBus.on<InspectionLoggedEvent>().listen((event) {
///   // Handle the event
/// });
/// ```
///
/// ## Lifecycle
///
/// Subscribers should cancel their subscriptions when done to prevent
/// memory leaks:
/// ```dart
/// final subscription = eventBus.on<MyEvent>().listen(handler);
/// // Later...
/// subscription.cancel();
/// ```
@singleton
class EventBus {
  /// Returns the singleton instance of EventBus.
  factory EventBus() => _instance;

  EventBus._();

  static final EventBus _instance = EventBus._();

  /// The singleton instance of EventBus.
  static EventBus get instance => _instance;

  final StreamController<DomainEvent> _controller =
      StreamController<DomainEvent>.broadcast();

  bool _isDisposed = false;

  /// Whether the event bus has been disposed.
  bool get isDisposed => _isDisposed;

  /// Subscribe to events of type [T].
  ///
  /// Returns a Stream that emits events of the specified type.
  /// Subscribers should cancel their subscription when done.
  ///
  /// Example:
  /// ```dart
  /// eventBus.on<InspectionLoggedEvent>().listen((event) {
  ///   print('Inspection ${event.inspectionId} logged');
  /// });
  /// ```
  Stream<T> on<T extends DomainEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  /// Publish an event to all subscribers.
  ///
  /// Throws [StateError] if the event bus has been disposed.
  ///
  /// Example:
  /// ```dart
  /// eventBus.publish(InspectionLoggedEvent(
  ///   inspectionId: '123',
  ///   hiveId: '456',
  /// ));
  /// ```
  void publish(DomainEvent event) {
    if (_isDisposed) {
      throw StateError('Cannot publish events after EventBus is disposed');
    }
    _controller.add(event);
  }

  /// Dispose of the event bus.
  ///
  /// After disposal, no new events can be published.
  /// All existing subscriptions will complete.
  void dispose() {
    _isDisposed = true;
    _controller.close();
  }
}
