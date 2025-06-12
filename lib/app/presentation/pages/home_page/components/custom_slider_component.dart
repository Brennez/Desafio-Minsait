import 'package:flutter/material.dart';

class CustomSliderComponent extends StatefulWidget {
  final String title;
  final int initialValue;
  final Function(int) onChanged;

  const CustomSliderComponent({
    Key? key,
    required this.title,
    this.initialValue = 0,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSliderComponentState createState() => _CustomSliderComponentState();
}

class _CustomSliderComponentState extends State<CustomSliderComponent> {
  double _sliderValue = 0;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                _sliderValue.round().toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Slider(
          min: 0,
          max: 100,
          divisions: 100,
          value: _sliderValue,
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
            widget.onChanged(value.round());
          },
        ),
      ],
    );
  }
}
