import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/models/Praksa/praksa.dart';
import 'package:studentoglasi_mobile/providers/prakse_provider.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/screens/internship_form_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/widgets/star_rating.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:provider/provider.dart';

class InternshipDetailsScreen extends StatefulWidget {
  final Oglas internship;
  final double averageRating;

  const InternshipDetailsScreen({
    Key? key,
    required this.internship,
    required this.averageRating,
  }) : super(key: key);

  @override
  _InternshipDetailsScreenState createState() =>
      _InternshipDetailsScreenState();
}

class _InternshipDetailsScreenState extends State<InternshipDetailsScreen> {
  late double _averageRating;
  late OcjeneProvider _ocjeneProvider;
  late PraksaProvider _prakseProvider;
  Praksa? praksa;

  @override
  void initState() {
    super.initState();
    _prakseProvider = context.read<PraksaProvider>();
    _averageRating = widget.averageRating;
    _ocjeneProvider = Provider.of<OcjeneProvider>(context, listen: false);
    _fetchPraksa();
  }

  void _fetchPraksa() async {
    try {
      var statusData = await _prakseProvider.getById(widget.internship.id!);
      setState(() {
        praksa = statusData;
      });
    } catch (error) {
      print("Error fetching praksa: $error");
    }
  }

  Future<void> _fetchAverageRatings() async {
    try {
      double newAverageRating = await _ocjeneProvider.getAverageOcjena(
        widget.internship.id!,
        ItemType.internship.toShortString(),
      );
      setState(() {
        _averageRating = newAverageRating;
      });
    } catch (error) {
      print("Error fetching average ratings: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.internship.naslov ?? 'Detalji prakse'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Added this
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.internship.slika != null
                  ? Image.network(
                      FilePathManager.constructUrl(widget.internship.slika!),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  :  Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Nema dostupne slike',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.comment, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsScreen(
                            postId: widget.internship.id!,
                            postType: ItemType.internship,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 8),
                  LikeButton(
                    itemId: widget.internship.id!,
                    itemType: ItemType.internship,
                  ),
                  Spacer(),
                  SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(
                          _averageRating > 0
                              ? _averageRating.toStringAsFixed(1)
                              : "N/A",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('${widget.internship.naslov ?? 'Nema naslova'}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('${widget.internship.opis ?? 'Nema opisa'}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Rok prijave:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  '${widget.internship.rokPrijave != null ? DateFormat('dd MM yyyy').format(widget.internship.rokPrijave) : 'Nema dostupnog datuma'}'),
              SizedBox(height: 8),
              Text('Pocetak prakse:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  '${praksa?.pocetakPrakse != null ? DateFormat('dd MM yyyy').format(praksa!.pocetakPrakse!) : 'Nema dostupnog datuma'}'),
              SizedBox(height: 8),
              Text('Kraj prakse:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  '${praksa?.krajPrakse != null ? DateFormat('dd MM yyyy').format(praksa!.krajPrakse!) : 'Nema dostupnog datuma'}'),
              SizedBox(height: 8),
              Text('Organizacija:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  '${praksa?.organizacija?.naziv ?? 'Nema dostupnog naziva organizacije'}'),
              SizedBox(height: 8),
              Row(
                children: [
                  Text('Placena:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  praksa?.placena == true
                      ? Icon(Icons.check_circle, color: Colors.green, size: 24)
                      : Icon(Icons.cancel, color: Colors.red, size: 24),
                ],
              ),
              SizedBox(height: 8),
              Text('Benefiti:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${praksa?.benefiti ?? 'Nema benefita'}'),
              SizedBox(height: 8),
              Text('Kvalifikacije:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${praksa?.kvalifikacije ?? 'Nema kvalifikacija'}'),
              SizedBox(height: 16), 
              Row(
                children: [
                  Expanded(
                    child: StarRatingWidget(
                      postId: widget.internship.id!,
                      postType: ItemType.internship,
                      onRatingChanged: _fetchAverageRatings,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrijavaPraksaFormScreen(
                              internship: widget.internship,
                            ),
                          ),
                        );
                      },
                      child: Text('Prijavi se'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
