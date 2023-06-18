import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'whiteboard_state.dart';

class WhiteboardCubit extends Cubit<WhiteboardState> {
  WhiteboardCubit() : super(const WhiteboardState());

  void selectColor(Color color) => emit(
        const WhiteboardState().copyWith(selectedColor: color),
      );
  void changeBrushSize(double size) => emit(
        const WhiteboardState().copyWith(brushSize: size),
      );
}
