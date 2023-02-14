import 'package:flutter/material.dart';
import '../../../theme/theme_data.dart';
import './section_area.dart';
import './section_type.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [
            bgLight,
            bgDark,
          ],
          radius: 1,
          center: Alignment.topCenter,
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: const SectionArea(),
            ),
          ),
        ));
  }
}

class ScreenHolder extends StatefulWidget {
  const ScreenHolder({super.key});

  @override
  State<ScreenHolder> createState() => _ScreenHolderState();
}

class _ScreenHolderState extends State<ScreenHolder> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
