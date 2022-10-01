import 'package:flutter/material.dart';

Widget loadSongGrid(BuildContext ctx, List songs) {
  return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: songs.length,
      itemBuilder: (BuildContext ctx, index) {
        return InkWell(
          // When the user taps the button, show a snackbar.
          onTap: () {
            ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
              content: Text('Card Tap'),
            ));
          },
          child: Card(
            elevation: 12,
            child: GridTile(
              child: Image.network(
                "http://localhost:8000/" + songs[index]["thumb"],
                width: 100.0,
                height: 100.0,
              ),
              footer: GridTileBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Text(
                      songs[index]["title"],
                      style: TextStyle(color: Colors.black.withOpacity(0.8)),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.play_arrow_outlined),
                  color: Colors.black,
                  onPressed: () {
                    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                      content: Text('Play Tap'),
                    ));
                  },
                ),
              ),
            ),
          ),
        );
      });
}
