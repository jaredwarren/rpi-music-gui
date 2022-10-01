import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

Widget loadPlayer(BuildContext ctx) {
  return BottomAppBar(
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      // textBaseline: TextBaseline.alphabetic,
      children: [
        SizedBox(
          width: 42.0,
          height: 42.0,
          // child: Image.asset('assets/title.png', fit: BoxFit.cover),
          child: Image.asset('favicon.png', fit: BoxFit.cover),
        ),
        const Spacer(),
        // TODO: add better flex layout?
        SizedBox(
          width: 302.0,
          // height: 42.0,
          child: ProgressBar(
            progress: const Duration(milliseconds: 1000),
            buffered: const Duration(milliseconds: 2000),
            total: const Duration(milliseconds: 5000),
            progressBarColor: Colors.red,
            baseBarColor: Colors.white.withOpacity(0.24),
            bufferedBarColor: Colors.white.withOpacity(0.24),
            thumbColor: Colors.white,
            barHeight: 3.0,
            thumbRadius: 5.0,
            onSeek: (duration) {
              // _player.seek(duration);
              print('User selected a new time: $duration');
            },
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {},
        ),
      ],
    ),
  );
}
