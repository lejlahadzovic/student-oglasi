import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_mobile/models/Praksa/praksa.dart';
import 'package:studentoglasi_mobile/models/PrijavaStipendija/prijave_stipendija.dart';
import 'package:studentoglasi_mobile/models/PrijavePraksa/prijave_praksa.dart';
import 'package:studentoglasi_mobile/models/Rezervacije/rezervacije.dart';
import 'package:studentoglasi_mobile/models/StatusOglas/statusoglasi.dart';
import 'package:studentoglasi_mobile/models/StatusPrijave/statusprijave.dart';
import 'package:studentoglasi_mobile/models/Student/student.dart';
import 'package:studentoglasi_mobile/providers/prakse_provider.dart';
import 'package:studentoglasi_mobile/providers/prijavepraksa_provider.dart';
import 'package:studentoglasi_mobile/providers/prijavestipendija_provider.dart';
import 'package:studentoglasi_mobile/providers/rezervacije_provider.dart';
import 'package:studentoglasi_mobile/providers/statusprijave_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/screens/accommodation_details_screen.dart';
import '../models/search_result.dart';
import '../widgets/menu.dart';

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  late PrijavePraksaProvider _prijavePrakseProvider;
  late PrijaveStipendijaProvider _prijaveStipendijaProvider;
  late RezervacijeProvider _rezeracijeProvider;
  late StatusPrijaveProvider _statusProvider;
  late StudentiProvider _studentProvider;
  late PraksaProvider _prakseProvider;
  Organizacije? selectedOrganizacije;
  StatusOglasi? selectedStatusOglasi;
  Student? _currentStudent;
  bool _isLoading = true;
  bool _hasError = false;
  List<PrijavePraksa>? prijavePrakseResult;
  List<PrijaveStipendija>? prijaveStipendijaResult;
  List<Rezervacije>? rezeracijeResult;
  SearchResult<StatusPrijave>? statusResult;
  SearchResult<Praksa>? prakseResult;

  @override
  void initState() {
    super.initState();
    _prijavePrakseProvider = context.read<PrijavePraksaProvider>();
    _prijaveStipendijaProvider = context.read<PrijaveStipendijaProvider>();
    _studentProvider = context.read<StudentiProvider>();
    _rezeracijeProvider = context.read<RezervacijeProvider>();
    _statusProvider = context.read<StatusPrijaveProvider>();
    _prakseProvider = context.read<PraksaProvider>();
    _fetchData();
    _fetchPrakse();
    _fetchStatusPrijave();
    _fetchScholarshipData();
    _fetchReservationsData();
  }

  void _fetchStatusPrijave() async {
    var statusData = await _statusProvider.get();
    setState(() {
      statusResult = statusData;
    });
  }

  void _fetchPrakse() async {
    var prakseData = await _prakseProvider.get();
    setState(() {
      prakseResult = prakseData;
    });
  }

  Future<void> _fetchData() async {
    _currentStudent = await _studentProvider.getCurrentStudent();
    try {
      var data = await _prijavePrakseProvider
          .getPrijavePraksaByStudentId(_currentStudent!.id!);
      setState(() {
        prijavePrakseResult = data
            .where((prijava) => prijava.status?.naziv != 'Otkazana')
            .toList();
        _isLoading = false;
      });
      print("Internship data fetched");
    } catch (e) {
      print("Failed to load internship data: $e");
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchScholarshipData() async {
    _currentStudent = await _studentProvider.getCurrentStudent();
    try {
      var data = await _prijaveStipendijaProvider
          .getPrijaveStipendijaByStudentId(_currentStudent!.id!);
      setState(() {
        prijaveStipendijaResult = data
            .where((prijava) => prijava.status?.naziv != 'Otkazana')
            .toList();
        _isLoading = false;
      });
      print("Scholarship data fetched");
    } catch (e) {
      print("Failed to load scholarship data: $e");
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchReservationsData() async {
    _currentStudent = await _studentProvider.getCurrentStudent();
    try {
      var data = await _rezeracijeProvider
          .getRezervacijeByStudentId(_currentStudent!.id!);
      setState(() {
        rezeracijeResult = data
            .where((rezervacija) => rezervacija.status?.naziv != 'Otkazana')
            .toList();
        _isLoading = false;
      });
      print("Reservation data fetched");
    } catch (e) {
      print("Failed to load reservation data: $e");
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moje prijave'),
      ),
      drawer: DrawerMenu(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? const Center(
                  child: Text('Failed to load data. Please try again later.'))
              : prijavePrakseResult == null &&
                      prijaveStipendijaResult == null &&
                      rezeracijeResult == null
                  ? const Center(child: Text('No data available.'))
                  : ListView.builder(
                      itemCount: (prijavePrakseResult?.length ?? 0) +
                          (prijaveStipendijaResult?.length ?? 0) +
                          (rezeracijeResult?.length ?? 0),
                      itemBuilder: (context, index) {
                        if (index < (prijavePrakseResult?.length ?? 0)) {
                          // Internship applications
                          final prijava = prijavePrakseResult![index];
                          return _buildPraksaCard(prijava);
                        } else if (index <
                            (prijavePrakseResult?.length ?? 0) +
                                (prijaveStipendijaResult?.length ?? 0)) {
                          // Scholarship applications
                          final scholarshipIndex =
                              index - (prijavePrakseResult?.length ?? 0);
                          final prijava =
                              prijaveStipendijaResult![scholarshipIndex];
                          return _buildScholarshipCard(prijava);
                        } else {
                          // Reservations
                          final reservationIndex = index -
                              (prijavePrakseResult?.length ?? 0) -
                              (prijaveStipendijaResult?.length ?? 0);
                          final rezervacija =
                              rezeracijeResult![reservationIndex];
                          return _buildReservationCard(rezervacija);
                        }
                      },
                    ),
    );
  }

  Widget _buildPraksaCard(PrijavePraksa prijava) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Naziv oglasa za praksu: ${prijava.praksa?.idNavigation?.naslov ?? 'No title'}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool? confirm = await _showConfirmationDialog(context);
                  if (confirm == true) {
                    try {
                      bool isCancelled = await _prijavePrakseProvider.cancel(
                        prijava.studentId,
                        entityId: prijava.praksaId,
                      );

                      if (isCancelled) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Prijava uspješno otkazana.')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Prijava nije otkazana.')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  }
                  },
                  child: Text('Otkaži'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda'),
          content: Text('Jeste li sigurni da želite otkazati?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context)
                  .pop(false), // Close dialog and do nothing
              child: Text('Ne'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context)
                  .pop(true), // Close dialog and confirm cancellation
              child: Text('Da'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildScholarshipCard(PrijaveStipendija prijava) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Naziv oglasa za stipendiju: ${prijava.stipendija?.idNavigation?.naslov ?? 'No title'}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool? confirm = await _showConfirmationDialog(context);
                  if (confirm == true) {
                    try {
                      bool isCancelled =
                          await _prijaveStipendijaProvider.cancel(
                        prijava.studentId,
                        entityId: prijava.stipendijaId,
                      );
                      if (isCancelled) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Prijava uspješno otkazana.')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Prijava nije otkazana.')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  }
                  },
                  child: Text('Otkaži'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationCard(Rezervacije rezervacija) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Naziv rezervacije: ${rezervacija.smjestaj?.naziv ?? 'No title'}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool? confirm = await _showConfirmationDialog(context);
                  if (confirm == true) {
                    try {
                      bool isCancelled = await _rezeracijeProvider.cancel(
                        rezervacija.studentId,
                        entityId: rezervacija.smjestajnaJedinicaId,
                      );

                      if (isCancelled) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Rezervacija uspješno otkazana.')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Rezervacija nije otkazana.')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                    }
                  },
                  child: Text('Otkaži'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
