import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_bloc_example/counter_event.dart';

class CounterBloc
{
  int _counter = 0;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc()
  {
    _counterEventController.stream.listen((event) => _mapEventToState(event));
  }

  void _mapEventToState(CounterEvent event)
  {
    if(event is IncrementEvent)
      {
        _counter++;
      }
    else
      {
        _counter--;
      }
    _inCounter.add(_counter);
  }

  void dispose()
  {
    _counterStateController.close();
    _counterEventController.close();
  }

}