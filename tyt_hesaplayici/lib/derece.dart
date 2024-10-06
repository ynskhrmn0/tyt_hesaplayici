import 'package:flutter/material.dart';

class DerececHesap extends StatefulWidget {
  const DerececHesap({super.key});

  @override
  State<DerececHesap> createState() => _DerececHesapState();
}

class _DerececHesapState extends State<DerececHesap> {
  final TextEditingController _degreeController1 = TextEditingController();
  final TextEditingController _minuteController1 = TextEditingController();
  final TextEditingController _secondController1 = TextEditingController();
  final TextEditingController _degreeController2 = TextEditingController();
  final TextEditingController _minuteController2 = TextEditingController();
  final TextEditingController _secondController2 = TextEditingController();

  String _result = '';
  bool _isAddition = true; // Toplama varsayılan olarak seçili

  void _calculate() {
    final int? degree1 = int.tryParse(_degreeController1.text);
    final int? minute1 = int.tryParse(_minuteController1.text);
    final int? second1 = int.tryParse(_secondController1.text);
    final int? degree2 = int.tryParse(_degreeController2.text);
    final int? minute2 = int.tryParse(_minuteController2.text);
    final int? second2 = int.tryParse(_secondController2.text);

    if ([degree1, minute1, second1, degree2, minute2, second2]
        .any((value) => value == null)) {
      setState(() {
        _result = 'Lütfen tüm alanları geçerli sayılarla doldurun.';
      });
      return;
    }

    // Hesaplama yap
    if (_isAddition) {
      _result =
          _addDMS(degree1!, minute1!, second1!, degree2!, minute2!, second2!);
    } else {
      _result = _subtractDMS(
          degree1!, minute1!, second1!, degree2!, minute2!, second2!);
    }
  }

  String _addDMS(int degree1, int minute1, int second1, int degree2,
      int minute2, int second2) {
    int totalSeconds = (degree1 * 3600 + minute1 * 60 + second1) +
        (degree2 * 3600 + minute2 * 60 + second2);
    return _convertSecondsToDMS(totalSeconds);
  }

  String _subtractDMS(int degree1, int minute1, int second1, int degree2,
      int minute2, int second2) {
    int totalSeconds = (degree1 * 3600 + minute1 * 60 + second1) -
        (degree2 * 3600 + minute2 * 60 + second2);
    return _convertSecondsToDMS(totalSeconds);
  }

  String _convertSecondsToDMS(int totalSeconds) {
    if (totalSeconds < 0) totalSeconds = 0; // Negatif değerleri sıfıra eşitle
    int degrees = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '$degrees ° $minutes\' $seconds\"';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Açısını hesaplamak istediğiniz dereceleri girin:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildTextField(_degreeController1, 'Derece')),
              Expanded(child: _buildTextField(_minuteController1, 'Dakika')),
              Expanded(child: _buildTextField(_secondController1, 'Saniye')),
            ],
          ),
        ),
        SizedBox(height: 16),
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          isSelected: [_isAddition, !_isAddition],
          onPressed: (int index) {
            setState(() {
              _isAddition = index == 0;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Toplama'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Çıkarma'),
            ),
          ],
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildTextField(_degreeController2, 'Derece')),
              Expanded(child: _buildTextField(_minuteController2, 'Dakika')),
              Expanded(child: _buildTextField(_secondController2, 'Saniye')),
            ],
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _calculate();
            });
          },
          child: Text('Hesapla'),
        ),
        SizedBox(height: 16),
        if (_result.isNotEmpty)
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _result,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
      ),
      keyboardType: TextInputType.number,
    );
  }
}
