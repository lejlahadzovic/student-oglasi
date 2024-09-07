import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/widgets/image_gallery.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/widgets/star_rating.dart';

class AccommodationUnitCard extends StatefulWidget {
  final SmjestajnaJedinica jedinica;

  const AccommodationUnitCard({Key? key, required this.jedinica})
      : super(key: key);

  @override
  _AccommodationUnitCardState createState() => _AccommodationUnitCardState();
}

class _AccommodationUnitCardState extends State<AccommodationUnitCard> {
  late Future<double> _averageRating;

  @override
  void initState() {
    super.initState();
    _averageRating = _fetchAverageRating();
  }

  Future<double> _fetchAverageRating() async {
    return await Provider.of<OcjeneProvider>(context, listen: false)
        .getAverageOcjena(
            widget.jedinica.id!, ItemType.accommodationUnit.toShortString());
  }

  void _updateRating() {
    setState(() {
      _averageRating = _fetchAverageRating();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.jedinica.naziv ?? 'Naziv nije dostupan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              widget.jedinica.slikes != null &&
                      widget.jedinica.slikes!.isNotEmpty
                  ? ImageGallery(images: widget.jedinica.slikes!)
                  : Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${widget.jedinica.cijena?.toStringAsFixed(2) ?? 'N/A'} BAM',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.comment, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsScreen(
                            postId: widget.jedinica.id!,
                            postType: ItemType.accommodationUnit,
                          ),
                        ),
                      );
                    },
                  ),
                  LikeButton(
                    itemId: widget.jedinica.id!,
                    itemType: ItemType.accommodationUnit,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  StarRatingWidget(
                    postId: widget.jedinica.id!,
                    postType: ItemType.accommodationUnit,
                    onRatingChanged: () async {
                      _updateRating();
                    },
                    iconSize: 25,
                  ),
                  Spacer(),
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 4),
                  FutureBuilder<double>(
                    future: _averageRating,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                         return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("N/A");
                      } else {
                        return Text(
                          snapshot.data != null && snapshot.data! > 0
                              ? snapshot.data!.toStringAsFixed(1)
                              : "N/A",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.people),
                  SizedBox(width: 4),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Kapacitet: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${widget.jedinica.kapacitet ?? 'N/A'} osobe',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                widget.jedinica.opis ?? 'Nema sadržaja',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Kuhinja: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.jedinica.kuhinja == true ? Icons.check : Icons.close,
                    color: widget.jedinica.kuhinja == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'TV: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.jedinica.tv == true ? Icons.check : Icons.close,
                    color:
                        widget.jedinica.tv == true ? Colors.green : Colors.red,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Klima uređaj: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.jedinica.klimaUredjaj == true
                        ? Icons.check
                        : Icons.close,
                    color: widget.jedinica.klimaUredjaj == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Terasa: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    widget.jedinica.terasa == true ? Icons.check : Icons.close,
                    color: widget.jedinica.terasa == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Dodatne usluge: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: widget.jedinica.dodatneUsluge ??
                          'Nema dodatnih usluga',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
