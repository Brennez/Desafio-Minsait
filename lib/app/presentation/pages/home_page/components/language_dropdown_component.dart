import 'package:flutter/material.dart';

class LanguageDropdownComponent extends StatefulWidget {
  final Function(String) onSelected;

  const LanguageDropdownComponent({Key? key, required this.onSelected})
      : super(key: key);

  @override
  _LanguageDropdownComponentState createState() =>
      _LanguageDropdownComponentState();
}

class _LanguageDropdownComponentState extends State<LanguageDropdownComponent> {
  final List<String> languages = [
    'Dart',
    'JavaScript',
    'Python',
    'Java',
    'C#',
    'C++',
    'Go',
    'Rust',
    'Swift',
    'TypeScript'
  ];

  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage,
          hint: Text("Selecione uma linguagem"),
          icon: Icon(Icons.arrow_drop_down_rounded),
          isExpanded: true,
          items: languages.map((lang) {
            return DropdownMenuItem(
              value: lang,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(lang, style: TextStyle(fontSize: 16)),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedLanguage = value;
            });
            if (value != null) widget.onSelected(value);
          },
        ),
      ),
    );
  }
}
