import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:studentoglasi_mobile/models/Slike/slike.dart';
import 'package:studentoglasi_mobile/utils/util.dart';

class ImageGallery extends StatefulWidget {
  final List<Slike> images;

  const ImageGallery({Key? key, required this.images}) : super(key: key);

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    FilePathManager.constructUrl(widget.images[index].naziv!),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.images.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}