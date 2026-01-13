import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../services/firebase_service.dart';

class KickButton extends StatefulWidget {
  final VideoModel video;
  final String userId;

  const KickButton({
    super.key,
    required this.video,
    required this.userId,
  });

  @override
  State<KickButton> createState() => _KickButtonState();
}

class _KickButtonState extends State<KickButton> with SingleTickerProviderStateMixin {
  final FirebaseService _firebaseService = FirebaseService();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isKicked = false;

  @override
  void initState() {
    super.initState();
    _isKicked = widget.video.kickedBy.contains(widget.userId);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> _handleKick() async {
    setState(() {
      _isKicked = !_isKicked;
    });

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    await _firebaseService.kickVideo(widget.video.id, widget.userId);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: GestureDetector(
            onTap: _handleKick,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isKicked ? Colors.orange : Colors.white.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.sports_martial_arts,
                size: 32,
                color: _isKicked ? Colors.white : Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${widget.video.kicks}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(0, 1),
                blurRadius: 3,
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'KICK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(0, 1),
                blurRadius: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
