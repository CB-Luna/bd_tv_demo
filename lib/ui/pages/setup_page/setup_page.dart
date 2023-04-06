import 'package:flutter/material.dart';
import 'package:tv_demo/ui/pages/setup_page/section_url.dart';
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
        decoration: const BoxDecoration(
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
              child: const ScreenHolder(),
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
  String _currentSection = "url";
  Map<String, dynamic> _selectedArea = {};
  String _titulo = "Bienvenido";

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  void _changeSection(bool? back) {
    setState(() {
      if (back == true) {
        _currentSection = _currentSection == "type"
            ? "area"
            : _currentSection == "area"
                ? "url"
                : "area";
      } else {
        _currentSection = _currentSection == "url"
            ? "area"
            : _currentSection == "area"
                ? "type"
                : "area";
      }
      print(_currentSection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _currentSection == "url"
        ? SectionUrl(
            stateChanger: _changeSection,
          )
        : _currentSection == "area"
            ? SectionArea(
                stateChanger: _changeSection,
                onSelect: (area) {
                  setState(() {
                    _selectedArea = area;
                  });
                })
            : SectionType(
                stateChanger: _changeSection,
                Area: _selectedArea["nombre"],
                IdTv: _selectedArea["id"],
              );
  }
}
