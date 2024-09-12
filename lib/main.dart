import 'package:counter_custom_bloc/backend_service/counter_data_layer/counter_repository.dart';
import 'package:counter_custom_bloc/ui/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CounterRepository>(
          create: (_) => CounterRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Counter Custom Bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        home: MyHomePage.create(
          title: 'Counter Custom-Bloc',
        ),
      ),
    );
  }
}
