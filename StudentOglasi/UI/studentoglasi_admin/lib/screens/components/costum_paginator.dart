import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

class CustomPaginator extends StatelessWidget {
  final int numberPages;
  final int initialPage;
  final ValueChanged<int> onPageChange;
  final NumberPaginatorController pageController;
  final Function fetchData; // Function to fetch data

  CustomPaginator({
    required this.numberPages,
    required this.initialPage,
    required this.onPageChange,
    required this.pageController,
    required this.fetchData,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(150, 10, 150, 50),
      child: NumberPaginator(
        numberPages: numberPages,
        initialPage: initialPage,
        onPageChange: onPageChange,
        showPrevButton: true,
        showNextButton: false,
        nextButtonContent: Icon(Icons.arrow_right_alt),
        prevButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 0.0), 
          child: TextButton(
            onPressed: pageController.currentPage > 0
                ? () => pageController.prev()
                : null,
            child: const Row(
              children: [
                Icon(Icons.chevron_left),
                Text("Prethodna"),
              ],
            ),
          ),
        ),
        controller: pageController,
        config: NumberPaginatorUIConfig(
          buttonSelectedBackgroundColor: Colors.blue,
          buttonUnselectedBackgroundColor: Colors.white,
          buttonSelectedForegroundColor: Colors.white,
          buttonUnselectedForegroundColor: Colors.black,
          contentPadding: EdgeInsets.symmetric(horizontal: 200),
        ),
      ),
    );
  }
}
