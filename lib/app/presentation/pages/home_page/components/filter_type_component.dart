import 'package:flutter/material.dart';

import '../../../enums/enums_export.dart';

class FilterTypeSelector extends StatefulWidget {
  final Function(FilterType) onChanged;

  const FilterTypeSelector({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _FilterTypeSelectorState createState() => _FilterTypeSelectorState();
}

class _FilterTypeSelectorState extends State<FilterTypeSelector> {
  FilterType? _selectedFilter;

  Widget _buildRadio(FilterType value, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<FilterType>(
          value: value,
          activeColor: Colors.green,
          groupValue: _selectedFilter,
          onChanged: (FilterType? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedFilter = newValue;
              });
              widget.onChanged(newValue);
            }
          },
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRadio(FilterType.followers, 'Seguidores'),
              _buildRadio(FilterType.repos, 'Repositórios'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRadio(FilterType.language, 'Linguagem'),
              _buildRadio(FilterType.location, 'Localização'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRadio(FilterType.none, 'Nenhum'),
            ],
          ),
        ],
      ),
    );
  }
}
