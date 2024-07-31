import 'package:flutter/material.dart';
import 'package:studentoglasi_mobile/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_mobile/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/screens/components/image_gallery.dart';
import 'package:studentoglasi_mobile/screens/components/like_button.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';

class AccommodationDetailsScreen extends StatelessWidget {
  final Smjestaj smjestaj;

  const AccommodationDetailsScreen({Key? key, required this.smjestaj})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(smjestaj.naziv ?? 'Detalji smještaja'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              smjestaj.slikes != null && smjestaj.slikes!.isNotEmpty
                  ? ImageGallery(images: smjestaj.slikes!)
                  : SizedBox(
                      width: double.infinity,
                      height: 200,
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
                      smjestaj.naziv ?? 'Naziv nije dostupan',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                  icon: Icon(Icons.comment, color: Colors.purple[900]),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                          postId: smjestaj.id!,
                          postType: ItemType.accommodation,
                        ),
                      ),
                    );
                  },
                ),
                  LikeButton(
                    itemId: smjestaj.id!,
                    itemType: ItemType.accommodation,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                smjestaj.grad?.naziv ?? 'Lokacija nije dostupna',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                smjestaj.opis ?? 'Nema sadržaja',
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
                    smjestaj.wiFi == true ? Icons.check : Icons.close,
                    color: smjestaj.wiFi == true ? Colors.green : Colors.red,
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
                    smjestaj.parking == true ? Icons.check : Icons.close,
                    color: smjestaj.parking == true ? Colors.green : Colors.red,
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
                    smjestaj.fitnessCentar == true ? Icons.check : Icons.close,
                    color: smjestaj.fitnessCentar == true
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
                    smjestaj.restoran == true ? Icons.check : Icons.close,
                    color:
                        smjestaj.restoran == true ? Colors.green : Colors.red,
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
                    smjestaj.uslugePrijevoza == true
                        ? Icons.check
                        : Icons.close,
                    color: smjestaj.uslugePrijevoza == true
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
                      text: smjestaj.dodatneUsluge ?? 'Nema dodatnih usluga',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Smještajne jedinice',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              smjestaj.smjestajnaJedinicas != null &&
                      smjestaj.smjestajnaJedinicas!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: smjestaj.smjestajnaJedinicas!.length,
                      itemBuilder: (context, index) {
                        final jedinica = smjestaj.smjestajnaJedinicas![index];
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

class AccommodationUnitCard extends StatelessWidget {
  final SmjestajnaJedinica jedinica;

  const AccommodationUnitCard({Key? key, required this.jedinica})
      : super(key: key);

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
                jedinica.naziv ?? 'Naziv nije dostupan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              jedinica.slikes != null && jedinica.slikes!.isNotEmpty
                  ? ImageGallery(images: jedinica.slikes!)
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
                      '${jedinica.cijena?.toStringAsFixed(2) ?? 'N/A'} BAM',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                  icon: Icon(Icons.comment, color: Colors.purple[900]),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                          postId: jedinica.id!,
                          postType: ItemType.accommodationUnit,
                        ),
                      ),
                    );
                  },
                ),
                  LikeButton(
                    itemId: jedinica.id!,
                    itemType: ItemType.accommodationUnit,
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
                          text: '${jedinica.kapacitet ?? 'N/A'} osobe',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                jedinica.opis ?? 'Nema sadržaja',
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
                    jedinica.kuhinja == true ? Icons.check : Icons.close,
                    color: jedinica.kuhinja == true ? Colors.green : Colors.red,
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
                    jedinica.tv == true ? Icons.check : Icons.close,
                    color: jedinica.tv == true ? Colors.green : Colors.red,
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
                    jedinica.klimaUredjaj == true ? Icons.check : Icons.close,
                    color: jedinica.klimaUredjaj == true
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
                    jedinica.terasa == true ? Icons.check : Icons.close,
                    color: jedinica.terasa == true ? Colors.green : Colors.red,
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
                      text: jedinica.dodatneUsluge ?? 'Nema dodatnih usluga',
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
