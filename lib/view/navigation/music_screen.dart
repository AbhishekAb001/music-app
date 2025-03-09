import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music/controller/contorller.dart';

class MusicPlayerScreen extends StatefulWidget {
  final List<Map<dynamic, dynamic>> playlist;
  final int initialIndex;

  const MusicPlayerScreen({
    super.key,
    required this.playlist,
    required this.initialIndex,
  });

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Contorller controller = Get.find();
  int currentIndex = 0;
  String? lastPlayedSongId;
  bool isShuffling = false;
  bool isRepeating = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayer();
      controller.togglePlaying(true);
      controller.setSong(widget.playlist[currentIndex]);
    });
  }

  void _initializePlayer() async {
    String currentSongId = widget.playlist[currentIndex]["fileUrl"]!;

    if (lastPlayedSongId == currentSongId && controller.isPlaying.value) {
      return;
    }

    try {
      await _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(widget.playlist[currentIndex]["fileUrl"]!),
          tag: MediaItem(
            id: currentIndex.toString(),
            album: "My Playlist",
            title: widget.playlist[currentIndex]["songName"] ?? "Unknown Title",
            artist: widget.playlist[currentIndex]["artist"] ?? "Unknown Artist",
            artUri: Uri.parse(widget.playlist[currentIndex]["url"]!),
          ),
        ),
      );
      _audioPlayer.play();

      setState(() {
        // 👈 Ensure UI updates with the new song
        lastPlayedSongId = currentSongId;
        controller.setSong(widget.playlist[currentIndex]);
      });

      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _handleSongCompletion();
        }
      });
    } catch (e) {
      log("Error initializing player: $e");
    }
  }

  void _handleSongCompletion() {
    if (isRepeating) {
      _audioPlayer.seek(Duration.zero);
      _audioPlayer.play();
    } else {
      _playNextSong();
    }
  }

  void _togglePlayPause() {
    if (controller.isPlaying.value) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    controller.togglePlaying(!controller.isPlaying.value);
  }

  void _playNextSong() {
    setState(() {
      // 👈 Ensure UI refresh
      if (isShuffling) {
        currentIndex = (currentIndex + 1) % widget.playlist.length;
      } else {
        currentIndex = (currentIndex + 1) % widget.playlist.length;
      }
    });
    _initializePlayer();
  }

  void _playPreviousSong() {
    setState(() {
      // 👈 Ensure UI refresh
      currentIndex =
          currentIndex == 0 ? widget.playlist.length - 1 : currentIndex - 1;
    });
    _initializePlayer();
  }

  void _toggleShuffle() {
    setState(() {
      isShuffling = !isShuffling;
      _audioPlayer.setShuffleModeEnabled(isShuffling);
    });
  }

  void _toggleRepeat() {
    setState(() {
      isRepeating = !isRepeating;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentSong = widget.playlist[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        title: Text(
          currentSong["songName"] ?? "Unknown Title",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(currentSong["url"]!),
            ),
            const SizedBox(height: 20),
            Text(
              currentSong["songName"] ?? "Unknown Title",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              currentSong["artist"] ?? "Unknown Artist",
              style: GoogleFonts.inter(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final duration = _audioPlayer.duration ?? Duration.zero;
                return ProgressBar(
                  progress: snapshot.data ?? Duration.zero,
                  total:
                      duration.inSeconds == 0 ? Duration(seconds: 1) : duration,
                  baseBarColor: Colors.grey[700]!,
                  progressBarColor: Colors.white,
                  thumbColor: Colors.red,
                  timeLabelTextStyle: const TextStyle(color: Colors.white),
                  onSeek: (duration) => _audioPlayer.seek(duration),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    isShuffling ? Icons.shuffle_on : Icons.shuffle,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleShuffle,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: _playPreviousSong,
                ),
                Obx(
                  () => IconButton(
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.red,
                      size: 60,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: _playNextSong,
                ),
                IconButton(
                  icon: Icon(
                    isRepeating ? Icons.repeat_on : Icons.repeat,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleRepeat,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
