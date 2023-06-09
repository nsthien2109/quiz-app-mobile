// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quiz_app/utils/theme.dart';

class RadioButton extends StatelessWidget {
  String? value;
  int? radioId;
  int? selectedValue;
  String? answerTitle;
  Function onChanged;
  RadioButton(
      {super.key,
      required this.selectedValue,
      required this.value,
      required this.radioId,
      required this.answerTitle,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () => onChanged(),
          child: Card(
            elevation: 3,
            color: Colors.transparent,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: const BoxDecoration(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.grayLight,
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        '$value',
                        style: const TextStyle(
                            color: AppColors.redLight,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Flexible(
                      flex: 1,
                      child: Text(
                        "$answerTitle",
                        overflow: TextOverflow.visible,
                        maxLines: null,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )),
          ),
        ),
        Positioned(
          right: 20,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  selectedValue == radioId ? Colors.green : Colors.transparent,
              border: Border.all(color: Colors.green),
            ),
            child: selectedValue == radioId
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
        )
      ],
    );
  }
}
