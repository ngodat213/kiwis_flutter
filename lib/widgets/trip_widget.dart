import 'package:flutter/material.dart';

/// A widget that displays information about a trip with two states: active and inactive.
///
/// This widget can be used to show trip options in the application,
/// with the ability to customize colors based on the active state,
/// as well as handle events when the user taps on the widget.
class TripWidget extends StatelessWidget {
  /// The name of the trip location.
  final String location;

  /// A short description of the trip.
  final String description;

  /// The price of the trip.
  final String price;

  /// The active state of the trip.
  /// `true` if the trip is currently selected, `false` otherwise.
  final bool isActive;

  /// Callback function called when the user taps on the widget.
  final VoidCallback? onTap;

  /// Creates a [TripWidget].
  ///
  /// All parameters are required except [isActive] and [onTap].
  /// [isActive] defaults to `false`.
  const TripWidget({
    Key? key,
    required this.location,
    required this.description,
    required this.price,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? Colors.green : Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '★ 25 reviews',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Text(
              price,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
