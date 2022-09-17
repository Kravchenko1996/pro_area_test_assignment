import 'package:cat_trivia/api_clients.dart';
import 'package:flutter/material.dart';

import '../../configs.dart';
import '../../service/fact/fact_rest_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Fact? fact;

  @override
  void initState() {
    super.initState();
    setNextFact();
  }

  void setNextFact() async {
    fact = await $factClient.getFact();
    // var response = await $imageClient.getImage();
    // print(response);
    setState(() {});
  }

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
      body: SafeArea(
        child: Container(
          color: const Color(0xffCECECE),
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
                  text: fact != null ? fact!.fact : '',
                  shadow: shadow,
                  setNextFact: setNextFact,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.height,
    required this.padding,
    required this.shadow,
  }) : super(key: key);

  final double height;
  final double padding;
  final BoxShadow shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Padding(
            padding: EdgeInsets.all(100),
            child: CircularProgressIndicator(strokeWidth: 8),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [shadow],
              borderRadius: BorderRadius.circular(200),
            ),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(ImageUrls.randomCat),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomCard extends StatelessWidget {
  const BottomCard({
    Key? key,
    required this.height,
    required this.shadow,
    required this.text,
    required this.setNextFact,
  }) : super(key: key);

  final double height;
  final BoxShadow shadow;
  final String text;
  final VoidCallback setNextFact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [shadow],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text.isNotEmpty
                ? FactText(text: text)
                : const CircularProgressIndicator(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setNextFact(),
              child: Text('Next'.toUpperCase()),
            )
          ],
        ),
      ),
    );
  }
}

class FactText extends StatelessWidget {
  const FactText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
