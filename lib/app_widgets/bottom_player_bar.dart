import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPlayerBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final String? thumbnailUrl;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  
  const AudioPlayerBar({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isPlaying,
    required this.onPlayPause,
    this.thumbnailUrl,
    this.gradientStartColor,
    this.gradientEndColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 68,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientStartColor ?? const Color.fromRGBO(37, 37, 37, 0.55),
              gradientEndColor ?? const Color.fromRGBO(156, 156, 156, 1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTrackInfo(),
              _buildPlayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackInfo() {
    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.red,
            image: thumbnailUrl != null
                ? DecorationImage(
                    image: NetworkImage(thumbnailUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: const Color.fromRGBO(235, 235, 245, 0.3),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayButton() {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPlayPause,
        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}