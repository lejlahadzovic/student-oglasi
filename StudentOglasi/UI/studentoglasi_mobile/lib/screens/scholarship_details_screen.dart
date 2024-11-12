import 'package:flutter/material.dart';
import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/screens/scholarship_form_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import 'package:studentoglasi_mobile/widgets/star_rating.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:studentoglasi_mobile/models/Stipendija/stipendija.dart';
import 'package:provider/provider.dart';
import '../providers/stipendije_provider.dart';

class ScholarshipDetailsScreen extends StatefulWidget {
  final Oglas scholarship;
  final double averageRating;

  const ScholarshipDetailsScreen(
      {Key? key, required this.scholarship, required this.averageRating})
      : super(key: key);

  @override
  _ScholarshipDetailsScreenState createState() => _ScholarshipDetailsScreenState();
}

class _ScholarshipDetailsScreenState extends State<ScholarshipDetailsScreen> {
  late double _averageRating;
  late OcjeneProvider _ocjeneProvider;
  late StipendijeProvider _stipendijaProvider;
  Stipendije? stipendija;

  @override
  void initState() {
    super.initState();
    _averageRating = widget.averageRating;
    _ocjeneProvider = Provider.of<OcjeneProvider>(context, listen: false);
    _stipendijaProvider = Provider.of<StipendijeProvider>(context, listen: false);
    _fetchStipendija();
  }

  Future<void> _fetchStipendija() async {
    try {
      var stipendData = await _stipendijaProvider.getById(widget.scholarship.id!);
      setState(() {
        stipendija = stipendData;
      });
    } catch (error) {
      print("Error fetching stipendija: $error");
    }
  }

  Future<void> _fetchAverageRatings() async {
    try {
      double newAverageRating = await _ocjeneProvider.getAverageOcjena(
        widget.scholarship.id!,
        ItemType.scholarship.toShortString(),
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
        title: Text(widget.scholarship.naslov ?? 'Detalji stipendija'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.scholarship.slika != null
                  ? Image.network(
                      FilePathManager.constructUrl(widget.scholarship.slika!),
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
                            postId: widget.scholarship.id!,
                            postType: ItemType.scholarship,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 8),
                  LikeButton(
                    itemId: widget.scholarship.id!,
                    itemType: ItemType.scholarship,
                  ),
                  Spacer(),
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
              Text(
                widget.scholarship.naslov ?? 'Nema naziva',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                widget.scholarship.opis ?? 'Nema opisa',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              if (stipendija != null) ...[
                Text('Uslovi:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${stipendija!.uslovi ?? 'N/A'}'),
                SizedBox(height: 8),
                Text('Iznos:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${stipendija!.iznos != null ? stipendija!.iznos.toString() : 'N/A'}'),
                SizedBox(height: 8),
                Text('Kriterij:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${stipendija!.kriterij ?? 'N/A'}'),
                SizedBox(height: 8),
                Text('Potrebna dokumentacija:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${stipendija!.potrebnaDokumentacija ?? 'N/A'}'),
                SizedBox(height: 8),
                Text('Izvor:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${stipendija!.izvor ?? 'N/A'}'),
                SizedBox(height: 8),
                Text('Nivo obrazovanja:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${stipendija!.nivoObrazovanja ?? 'N/A'}'),
                SizedBox(height: 8),
                Text('Broj stipendista:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${stipendija!.brojStipendisata != null ? stipendija!.brojStipendisata.toString() : 'N/A'}'),
                SizedBox(height: 8),
                Text('Stipenditor:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${stipendija!.stipenditor?.naziv ?? 'N/A'}'),
              ],
              SizedBox(height: 16), // Add space before the rating
              Row(
                children: [
                  Expanded(
                    child: StarRatingWidget(
                      postId: widget.scholarship.id!,
                      postType: ItemType.scholarship,
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
                            builder: (context) => PrijavaStipendijaFormScreen(
                              scholarship: widget.scholarship,
                            ),
                          ),
                        );
                      },
                      child: Text('Prijavi se'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}