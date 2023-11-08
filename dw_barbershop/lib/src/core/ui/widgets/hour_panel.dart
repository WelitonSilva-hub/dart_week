import 'package:dw_barbershop/src/core/ui/contants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  final ValueChanged<int> onHourPressed;
  final List<int>? enabledHours;
  final int startTime;
  final int endTime;

  const HoursPanel({
    super.key,
    required this.onHourPressed,
    required this.startTime,
    required this.endTime,
    this.enabledHours,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os horários de atendimento',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = startTime; i <= endTime; i++)
              TimeButton(
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                enabledHours: enabledHours,
                onPressed: onHourPressed,
              )
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  final ValueChanged<int> onPressed;
  final List<int>? enabledHours;
  final String label;
  final int value;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
    this.enabledHours,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorConstants.grey;
    Color buttonColor = selected ? ColorConstants.brown : Colors.white;
    final buttonBorderColor =
        selected ? ColorConstants.brown : ColorConstants.grey;

    final TimeButton(:enabledHours, :onPressed, :value, :label) = widget;
    final disableTime = enabledHours != null && !enabledHours.contains(value);

    if (disableTime) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime
          ? null
          : () {
              onPressed(widget.value);
              setState(() {
                selected = !selected;
              });
            },
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: buttonBorderColor),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
