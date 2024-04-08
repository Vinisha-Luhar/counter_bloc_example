import 'package:counter_bloc_example/counter_bloc.dart';
import 'package:counter_bloc_example/counter_event.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc State Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  final _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: const Text("Bloc State Management",textAlign: TextAlign.center,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 25,
          color: Colors.white
        ),),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("You have pushed the button this many times",style: TextStyle(
              color: Colors.indigo,
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
              textAlign: TextAlign.center,
            ),
            StreamBuilder(
              stream: _bloc.counter,
              initialData: 0,
              builder: (context, snapshot) {
                return Text("${snapshot.data}",textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.indigo
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
              onPressed: (){
                _bloc.counterEventSink.add(IncrementEvent());
              },
            child: Icon(Icons.add),
            backgroundColor: Colors.indigo,
          ),
          FloatingActionButton(
            onPressed: (){
              _bloc.counterEventSink.add(DecrementEvent());
            },
            child: Icon(Icons.remove),
            backgroundColor: Colors.indigo,
          )
        ],
      ),
    );
  }
}

