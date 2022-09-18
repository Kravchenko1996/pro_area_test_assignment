import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/fact/fact_cubit.dart';
import '../../../utils/convert_date.dart';
import 'fact_text.dart';

class BottomCard extends StatefulWidget {
  const BottomCard({
    Key? key,
    required this.height,
    required this.shadow,
    required this.setNextFact,
  }) : super(key: key);

  final double height;
  final BoxShadow shadow;
  final VoidCallback setNextFact;

  @override
  State<BottomCard> createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  double _height = 0;

  @override
  void initState() {
    super.initState();
    _height = widget.height;
    context.read<FactCubit>().getFact();
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(100, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      primary: Theme.of(context).colorScheme.primary,
    );
    return GestureDetector(
      onVerticalDragEnd: (_) {
        if (_height == widget.height) {
          setState(() {
            _height = MediaQuery.of(context).size.height;
          });
        } else {
          setState(() => _height = widget.height);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [widget.shadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.remove,
              color: Colors.grey,
              size: 48,
            ),
            Expanded(
              child: BlocBuilder<FactCubit, FactState>(
                builder: (context, state) {
                  if (state is FactLoaded) {
                    return Column(
                      children: [
                        FactText(text: state.fact.fact),
                        Text(getLocaleDate(state.fact.createdAt!)),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 16),
              child: ElevatedButton(
                onPressed: () {
                  context.read<FactCubit>().getFact();
                  widget.setNextFact();
                },
                style: buttonStyle,
                child: Text(
                  'Another Fact'.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
