import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPlayerScreen extends StatefulWidget {
  final List<Map<String, String>> playlist;
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
  bool isPlaying = false;
  bool isShuffled = false;
  bool isRepeated = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _initializePlayer();
  }

  void _initializePlayer() async {
    await _audioPlayer.setUrl(widget.playlist[currentIndex]["audioUrl"]!);
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _handleSongCompletion();
      }
    });
  }

  void _handleSongCompletion() {
    if (isRepeated) {
      _audioPlayer.seek(Duration.zero);
      _audioPlayer.play();
    } else {
      _playNextSong();
    }
  }

  void _togglePlayPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _playNextSong() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.playlist.length;
    });
    _initializePlayer();
    _audioPlayer.play();
    setState(() {
      isPlaying = true;
    });
  }

  void _playPreviousSong() {
    setState(() {
      currentIndex =
          currentIndex == 0 ? widget.playlist.length - 1 : currentIndex - 1;
    });
    _initializePlayer();
    _audioPlayer.play();
    setState(() {
      isPlaying = true;
    });
  }

  void _toggleShuffle() {
    setState(() {
      isShuffled = !isShuffled;
    });
  }

  void _toggleRepeat() {
    setState(() {
      isRepeated = !isRepeated;
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          currentSong["title"]!,
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
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Album Image
            Container(
              width: screenWidth * 0.6,
              height: screenWidth * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(currentSong["imageUrl"]!),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Song Title & Artist
            Text(
              currentSong["title"]!,
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              currentSong["artist"]!,
              style: GoogleFonts.inter(
                fontSize: screenWidth * 0.04,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),

            // Progress Bar
            StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                return ProgressBar(
                  progress: snapshot.data ?? Duration.zero,
                  total: _audioPlayer.duration ?? Duration.zero,
                  baseBarColor: Colors.grey[700]!,
                  progressBarColor: Colors.white,
                  thumbColor: Colors.red,
                  timeLabelTextStyle: const TextStyle(color: Colors.white),
                  onSeek: (duration) => _audioPlayer.seek(duration),
                );
              },
            ),
            const SizedBox(height: 20),

            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shuffle,
                    color: isShuffled ? Colors.red : Colors.white,
                    size: screenWidth * 0.08,
                  ),
                  onPressed: _toggleShuffle,
                ),
                IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: screenWidth * 0.1,
                  ),
                  onPressed: _playPreviousSong,
                ),
                IconButton(
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: Colors.red,
                    size: screenWidth * 0.14,
                  ),
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: screenWidth * 0.1,
                  ),
                  onPressed: _playNextSong,
                ),
                IconButton(
                  icon: Icon(
                    Icons.repeat,
                    color: isRepeated ? Colors.red : Colors.white,
                    size: screenWidth * 0.08,
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
