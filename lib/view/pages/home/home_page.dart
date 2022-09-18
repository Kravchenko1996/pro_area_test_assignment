import 'package:cat_trivia/repository/fact/fact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/fact/fact_cubit.dart';
import '../facts_page.dart';
import 'bottom_card.dart';
import 'image_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String>? image;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    const double padding = 16.0;
    BoxShadow shadow = BoxShadow(
      color: Colors.black.withOpacity(.3),
      offset: const Offset(0, 0),
      blurRadius: 20,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => toFactsPage(context),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: Icon(
          Icons.history,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: BlocProvider(
        create: (_) => FactCubit($factRepo),
        child: Container(
          color: Colors.blueGrey,
          child: SafeArea(
            child: Stack(
              children: [
                ImageCard(
                  height: screenHeight / 2 - padding,
                  padding: padding * 2,
                  shadow: shadow,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomCard(
                    height: screenHeight / 2 - padding * 2,
                    shadow: shadow,
                    setNextFact: () => setState(() {}),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toFactsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FactsPage(),
      ),
    );
  }
}
