import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab05/cubit/whiteboard_cubit.dart';

class SelectColorButton extends StatelessWidget {
  const SelectColorButton(
    this.cubitContext,
    this.cubitState, {
    super.key,
    required this.color,
  });

  final BuildContext cubitContext;
  final WhiteboardState cubitState;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => cubitContext.read<WhiteboardCubit>().selectColor(color),
      child: Container(
        width: size.width * 0.07,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: color == cubitState.selectedColor
              ? Border.all(
                  color: const Color.fromARGB(255, 15, 230, 22),
                  width: 2.5,
                )
              : null,
        ),
      ),
    );
  }
}
