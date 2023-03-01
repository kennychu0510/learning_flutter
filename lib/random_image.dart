import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class RandomImage extends StatefulWidget {
  const RandomImage({super.key});

  @override
  State<RandomImage> createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImage> {
  bool isLoading = false;
  String seed = 'picsum';

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        // height: 300,
        child: isLoading
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                ),
                height: 200,
                width: double.infinity,
              )
            : FadeInImage.assetNetwork(
                placeholder: cupertinoActivityIndicator,
                placeholderScale: 2,
                image: 'https://picsum.photos/seed/${seed}/500/300'),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                seed = getRandom().toString();
              });
            },
            child: Text('New Photo')),
      )
    ]);
  }
}

int getRandom() {
  return Random().nextInt(1000);
}
