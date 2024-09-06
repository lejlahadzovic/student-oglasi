import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Rezervacije/rezervacije.dart';
import 'package:studentoglasi_mobile/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:studentoglasi_mobile/providers/rezervacije_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';

class ReservationScreen extends StatefulWidget {
  final SmjestajnaJedinica jedinica;

  const ReservationScreen({Key? key, required this.jedinica}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  int _numberOfGuests = 1;
  double _totalPrice = 0.0;
  TextEditingController _notesController = TextEditingController();

  void _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: _endDate ?? DateTime(2100),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        _calculateTotalPrice();
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate != null
          ? _startDate!.add(Duration(days: 1))
          : DateTime.now(),
      firstDate: _startDate != null
          ? _startDate!.add(Duration(days: 1))
          : DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        _calculateTotalPrice();
      });
    }
  }

  void _calculateTotalPrice() {
    if (_startDate != null && _endDate != null) {
      int numberOfDays = _endDate!.difference(_startDate!).inDays;
      _totalPrice = numberOfDays * (widget.jedinica.cijena ?? 0);
    }
  }

  void _confirmReservation() async {
    if (_startDate != null && _endDate != null && _numberOfGuests > 0) {
      var studentiProvider =
          Provider.of<StudentiProvider>(context, listen: false);
      var studentId = studentiProvider.currentStudent?.id;

      if (studentId == null) {
        var student = await studentiProvider.getCurrentStudent();
        studentId = student.id;
      }

      // final rezervacija = RezervacijeInsert(
      //   studentId,
      //   widget.jedinica.id,
      //   _startDate,
      //   _endDate,
      //   _numberOfGuests,
      //   _notesController.text,
      //   _totalPrice,
      // );

      Map<String, dynamic> rezervacija = {
        "studentId": studentId,  
        "smjestajnaJedinicaId": widget.jedinica.id,
        "datumPrijave": _startDate!.toIso8601String(),
        "datumOdjave": _endDate!.toIso8601String(),
        "brojOsoba": _numberOfGuests,
        "napomena": _notesController.text.isNotEmpty ? _notesController.text : null,
        "cijena": _totalPrice
      };

      try {
        var rezervacijeProvider =
            Provider.of<RezervacijeProvider>(context, listen: false);
        await rezervacijeProvider.insertJsonData(rezervacija);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rezervacija uspješna!')),
        );
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Greška pri rezervaciji: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Molimo unesite sve podatke za rezervaciju.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervišite smještaj'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.jedinica.naziv}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Datum prijave: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => _selectStartDate(context),
                    child: Text(_startDate == null
                        ? 'Izaberite datum'
                        : _startDate!.toLocal().toString().split(' ')[0]),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Datum odjave: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => _selectEndDate(context),
                    child: Text(_endDate == null
                        ? 'Izaberite datum'
                        : _endDate!.toLocal().toString().split(' ')[0]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Broj gostiju: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Slider(
                      value: _numberOfGuests.toDouble(),
                      min: 1,
                      max: (widget.jedinica.kapacitet ?? 1).toDouble(),
                      divisions: (widget.jedinica.kapacitet ?? 1),
                      label: _numberOfGuests.toString(),
                      onChanged: (double value) {
                        setState(() {
                          _numberOfGuests = value.toInt();
                        });
                      },
                    ),
                  ),
                  Text('$_numberOfGuests'),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Napomena (opcionalno):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Unesite napomenu',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              if (_startDate != null && _endDate != null)
                Row(
                  children: [
                    Text(
                      'Ukupna cijena: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${_totalPrice.toStringAsFixed(2)} BAM',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _confirmReservation,
                  child: Text('Potvrdi rezervaciju'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
