import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaproject/bloc/pizza_bloc.dart';
import 'package:pizzaproject/model/pizza_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.teal,
          ),
          debugShowCheckedModeBanner: false,
          home: PizzaPage(),
        ));
  }
}

class PizzaPage extends StatefulWidget {
  const PizzaPage({Key? key}) : super(key: key);

  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<PizzaPage> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bloc Example"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PizzaLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.pizzas.length}',
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height / 1.5,
                    width: deviceSize.width,
                    child: Stack(
                      children: [
                        for (int index = 0;
                            index < state.pizzas.length;
                            index++)
                          Positioned(
                              left: Random().nextInt(250).toDouble(),
                              right: Random().nextInt(400).toDouble(),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: state.pizzas[index].image,
                              ))
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text("something went wrong");
            }
          },
        ),
        floatingActionButton: Column(
          
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.add),
                onPressed: () {
                  context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[1]));
                }),
            SizedBox(
              height: deviceSize.height * 0.02,
            ),
            FloatingActionButton(
              backgroundColor: Colors.redAccent,
                child: Icon(Icons.remove),
                onPressed: () {
                  context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[1]));
                })
          ],
        ),
      ),
    );
  }
}
