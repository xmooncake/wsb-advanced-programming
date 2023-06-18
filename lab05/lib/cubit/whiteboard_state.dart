// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'whiteboard_cubit.dart';

@immutable
class WhiteboardState extends Equatable {
  const WhiteboardState({
    this.brushSize = 4,
    this.selectedColor = Colors.black,
  });

  final Color selectedColor;
  final double brushSize;

  WhiteboardState copyWith({
    Color? selectedColor,
    double? brushSize,
  }) {
    return WhiteboardState(
      selectedColor: selectedColor ?? this.selectedColor,
      brushSize: brushSize ?? this.brushSize,
    );
  }

  @override
  List<Object> get props => [brushSize, selectedColor];
}
