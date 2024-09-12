import 'package:counter_custom_bloc/backend_service/counter_data_layer/counter_data_model.dart';
import 'package:counter_custom_bloc/bloc/counter_bloc.dart';
import 'package:counter_custom_bloc/bloc/counter_bloc_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    required this.blocObj,
    super.key,
  });
  final CounterBloc blocObj;
  final String title;

  // CREATE METHOD.
  static Widget create({required String title}) {
    return Provider<CounterBloc>(
      create: (context) => CounterBloc(),
      dispose: (context, blocObject) => blocObject.dispose(),
      child: Consumer(
        // Consumer widget is used to create object of the class
        builder: (context, CounterBloc blocObject, _) {
          return MyHomePage(
            blocObj: blocObject,
            title: title,
          );
        },
      ),
    );
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter(oldVal) {
    widget.blocObj.updateWith(
      count: oldVal + 1,
    );
  }

  initObjs() async {
    CounterDataModel val = await widget.blocObj.getVal(context);
    widget.blocObj.updateWith(count: val.count, isLoading: false);
  }

  submitVal({required int count}) async {
    widget.blocObj.updateWith(isLoading: true);
    await widget.blocObj.saveVal(
      context,
      count: count,
    );
    var snackBar = const SnackBar(
      content: Text('Value Saved'),
      duration: Duration(seconds: 1),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    widget.blocObj.updateWith(isLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CounterBlocModel>(
      stream: widget.blocObj.streamBlocModel,
      builder: (context, AsyncSnapshot<CounterBlocModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          initObjs();
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        CounterBlocModel blocModel = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            centerTitle: true,
            title: Text(widget.title),
          ),
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '${snapshot.data!.count}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        submitVal(
                          count: blocModel.count!,
                        );
                      },
                      label: const Text('Submit Val'),
                      icon: const Icon(Icons.save_alt),
                    ),
                  ],
                ),
              ),
              if (blocModel.isLoading == true)
                const Opacity(
                  opacity: 0.5,
                  child: ModalBarrier(
                    dismissible: false,
                    color: Colors.black,
                  ),
                ),
              if (blocModel.isLoading == true)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _incrementCounter(snapshot.data!.count);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
