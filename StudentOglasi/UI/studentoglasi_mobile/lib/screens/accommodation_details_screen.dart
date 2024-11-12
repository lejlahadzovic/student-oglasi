import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:studentoglasi_mobile/screens/components/accommodation_unit_card.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/widgets/image_gallery.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/widgets/star_rating.dart';

class AccommodationDetailsScreen extends StatefulWidget {
  final Smjestaj smjestaj;
  final double averageRating;

  const AccommodationDetailsScreen({
    Key? key,
    required this.smjestaj,
    required this.averageRating,
  }) : super(key: key);

  @override
  _AccommodationDetailsScreenState createState() =>
      _AccommodationDetailsScreenState();
}

class _AccommodationDetailsScreenState
    extends State<AccommodationDetailsScreen> {
  late double _averageRating;
  late OcjeneProvider _ocjeneProvider;

  @override
  void initState() {
    super.initState();
    _averageRating = widget.averageRating;
    _ocjeneProvider = Provider.of<OcjeneProvider>(context, listen: false);
  }

  Future<void> _fetchAverageRatings() async {
    try {
      double newAverageRating = await _ocjeneProvider.getAverageOcjena(
        widget.smjestaj.id!,
        ItemType.accommodation.toShortString(),
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
        title: Text(widget.smjestaj.naziv ?? 'Detalji smještaja'),
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
              widget.smjestaj.slikes != null &&
                      widget.smjestaj.slikes!.isNotEmpty
                  ? ImageGallery(images: widget.smjestaj.slikes!)
                  : Container(
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
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.smjestaj.naziv ?? 'Naziv nije dostupan',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.comment, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsScreen(
                            postId: widget.smjestaj.id!,
                            postType: ItemType.accommodation,
                          ),
                        ),
                      );
                    },
                  ),
                  LikeButton(
                    itemId: widget.smjestaj.id!,
                    itemType: ItemType.accommodation,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: StarRatingWidget(
                      postId: widget.smjestaj.id!,
                      postType: ItemType.accommodation,
                      onRatingChanged: _fetchAverageRatings,
                      iconSize: 25,
                    ),
                  ),
                  Row(
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
                ],
              ),
              SizedBox(height: 8),
              Text(
                widget.smjestaj.grad?.naziv ?? 'Lokacija nije dostupna',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                widget.smjestaj.opis ?? 'Nema sadržaja',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'WiFi: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.smjestaj.wiFi == true ? Icons.check : Icons.close,
                    color: widget.smjestaj.wiFi == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Parking: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.smjestaj.parking == true ? Icons.check : Icons.close,
                    color: widget.smjestaj.parking == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Fitness centar: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.smjestaj.fitnessCentar == true
                        ? Icons.check
                        : Icons.close,
                    color: widget.smjestaj.fitnessCentar == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Restoran: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.smjestaj.restoran == true
                        ? Icons.check
                        : Icons.close,
                    color: widget.smjestaj.restoran == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Usluge prijevoza: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.smjestaj.uslugePrijevoza == true
                        ? Icons.check
                        : Icons.close,
                    color: widget.smjestaj.uslugePrijevoza == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Dodatne usluge: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: widget.smjestaj.dodatneUsluge ??
                          'Nema dodatnih usluga',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Smještajne jedinice',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              widget.smjestaj.smjestajnaJedinicas != null &&
                      widget.smjestaj.smjestajnaJedinicas!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.smjestaj.smjestajnaJedinicas!.length,
                      itemBuilder: (context, index) {
                        final jedinica =
                            widget.smjestaj.smjestajnaJedinicas![index];
                        return AccommodationUnitCard(jedinica: jedinica);
                      },
                    )
                  : Center(
                      child: Text('Nema dostupnih smještajnih jedinica.'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
