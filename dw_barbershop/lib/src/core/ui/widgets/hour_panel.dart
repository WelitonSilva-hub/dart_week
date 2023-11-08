import 'package:dw_barbershop/src/core/ui/contants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatefulWidget {
  final ValueChanged<int> onHourPressed;
  final List<int>? enabledHours;
  final bool singleSelection;
  final int startTime;
  final int endTime;

  const HoursPanel({
    super.key,
    required this.onHourPressed,
    required this.startTime,
    required this.endTime,
    this.enabledHours,
  }) : singleSelection = false;

  const HoursPanel.singleSelection({
    super.key,
    required this.onHourPressed,
    required this.startTime,
    required this.endTime,
    this.enabledHours,
  }) : singleSelection = true;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  int? lastSelection;

  @override
  Widget build(BuildContext context) {
    final HoursPanel(:singleSelection) = widget;

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
            for (int i = widget.startTime; i <= widget.endTime; i++)
              TimeButton(
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                timeSelected: lastSelection,
                singleSelection: singleSelection,
                enabledHours: widget.enabledHours,
                onPressed: (timeSelected) {
                  setState(() {
                    if (singleSelection) {
                      if (timeSelected == lastSelection) {
                        lastSelection = null;
                      } else {
                        lastSelection = timeSelected;
                      }
                    }
                  });
                  widget.onHourPressed(timeSelected);
                },
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
  final bool singleSelection;
  final int? timeSelected;
  final String label;
  final int value;

  const TimeButton({
    super.key,
    required this.onPressed,
    required this.singleSelection,
    required this.label,
    required this.value,
    this.enabledHours,
    this.timeSelected,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final TimeButton(
      :onPressed,
      :enabledHours,
      :singleSelection,
      :timeSelected,
      :value,
      :label,
    ) = widget;

    if (singleSelection) {
      if (timeSelected != null && timeSelected == value) {
        selected = true;
      } else {
        selected = false;
      }
    }

    final textColor = selected ? Colors.white : ColorConstants.grey;
    Color buttonColor = selected ? ColorConstants.brown : Colors.white;
    final buttonBorderColor =
        selected ? ColorConstants.brown : ColorConstants.grey;

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
