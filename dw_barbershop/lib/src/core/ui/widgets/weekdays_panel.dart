import 'package:dw_barbershop/src/core/ui/contants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  final ValueChanged<String> onDayPressed;

  const WeekdaysPanel({super.key, required this.onDayPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os dias da semana',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDay(label: 'Seg', onDaySelected: onDayPressed),
                ButtonDay(label: 'Ter', onDaySelected: onDayPressed),
                ButtonDay(label: 'Qua', onDaySelected: onDayPressed),
                ButtonDay(label: 'Qui', onDaySelected: onDayPressed),
                ButtonDay(label: 'Sex', onDaySelected: onDayPressed),
                ButtonDay(label: 'Sab', onDaySelected: onDayPressed),
                ButtonDay(label: 'Dom', onDaySelected: onDayPressed),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonDay extends StatefulWidget {
  final String label;
  final ValueChanged<String> onDaySelected;

  const ButtonDay({
    super.key,
    required this.label,
    required this.onDaySelected,
  });

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorConstants.grey;
    final buttonColor = selected ? ColorConstants.brown : Colors.white;
    final buttonBorderColor =
        selected ? ColorConstants.brown : ColorConstants.grey;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: buttonBorderColor),
          ),
          child: Center(
              child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          )),
        ),
        onTap: () {
          widget.onDaySelected(widget.label);
          setState(() {
            selected = !selected;
          });
        },
      ),
    );
  }
}
