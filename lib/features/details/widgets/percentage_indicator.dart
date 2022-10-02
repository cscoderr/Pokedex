import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentageIndicator extends StatelessWidget {
  const PercentageIndicator({
    super.key,
    required this.percentage,
    required this.title,
    required this.textStyle,
    required this.progressColor,
  });

  final int percentage;
  final String title;
  final TextTheme textStyle;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textStyle.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // const Spacer(),
          Expanded(
            flex: 5,
            child: LinearPercentIndicator(
              lineHeight: 25.0,
              percent: _getPercentage(percentage),
              animation: true,
              center: Text(
                '$percentage %',
                style: textStyle.titleSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              barRadius: const Radius.circular(20),
              backgroundColor: Colors.grey.withOpacity(0.8),
              progressColor: progressColor,
            ),
          ),
        ],
      ),
    );
  }

  double _getPercentage(int value) {
    return (value / 100) > 1.0 ? 1.0 : (value / 100);
  }
}
