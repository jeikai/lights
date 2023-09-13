import 'package:flutter/foundation.dart';

class HandlerWithPriority<T extends Event> {
  final void Function(T event) handler;
  final Priorities priority;

  HandlerWithPriority(this.handler, this.priority);
}

abstract class Event {
  Event();

  bool isCancelable() {
    return this is Cancelable;
  }
}

mixin Cancelable {
  bool _isCancel = false;
  void cancel() {
    _isCancel = true;
  }

  bool isCancel() => _isCancel;
}

abstract class EventCallable<T extends Event> {
  List<HandlerWithPriority<T>> _handlers = [];
  T? event;

  EventCallable();

  void setEvent(T event) {
    this.event = event;
  }

  @nonVirtual
  Future<void> callEvent(T event) async {
    setEvent(event);
    preCall();
    for (HandlerWithPriority<T> handler in _handlers) {
      handler.handler(this.event!);
      if (event.isCancelable()) {
        if ((event as Cancelable).isCancel()) {
          break;
        }
      }
    }
    postCall();
    return;
  }

  void preCall() {}

  void postCall() {}

  @nonVirtual
  void addHandler(void Function(T event) callback, Priorities priority) {
    final handlerWithPriority = HandlerWithPriority<T>(callback, priority);
    _handlers.add(handlerWithPriority);
    _bubbleUp(_handlers.length - 1);
  }

  @nonVirtual
  void removeHandler(void Function(T event) handler) {
    final index = _handlers.indexWhere(
        (handlerWithPriority) => handlerWithPriority.handler == handler);
    if (index >= 0) {
      _handlers[index] = _handlers.last;
      _handlers.removeLast();
      _bubbleDown(index);
    }
  }

  @nonVirtual
  void _bubbleUp(int index) {
    if (index <= 0) return;

    final parentIndex = (index - 1) ~/ 2;
    if (_handlers[parentIndex].priority.pri > _handlers[index].priority.pri) {
      _swapHandlers(parentIndex, index);
      _bubbleUp(parentIndex);
    }
  }

  @nonVirtual
  void _bubbleDown(int index) {
    final leftChildIndex = 2 * index + 1;
    final rightChildIndex = 2 * index + 2;
    int smallestIndex = index;

    if (leftChildIndex < _handlers.length &&
        _handlers[leftChildIndex].priority.pri <
            _handlers[smallestIndex].priority.pri) {
      smallestIndex = leftChildIndex;
    }

    if (rightChildIndex < _handlers.length &&
        _handlers[rightChildIndex].priority.pri <
            _handlers[smallestIndex].priority.pri) {
      smallestIndex = rightChildIndex;
    }

    if (smallestIndex != index) {
      _swapHandlers(index, smallestIndex);
      _bubbleDown(smallestIndex);
    }
  }

  @nonVirtual
  void _swapHandlers(int i, int j) {
    final temp = _handlers[i];
    _handlers[i] = _handlers[j];
    _handlers[j] = temp;
  }

  List<HandlerWithPriority<T>> get handlers => _handlers;
}

enum Priorities {
  low(pri: 6),
  belowNormal(pri: 5),
  normal(pri: 4),
  aboveNormal(pri: 3),
  high(pri: 2),
  realTime(pri: 1),
  critical(pri: 0);

  const Priorities({required this.pri});

  final int pri;
}
