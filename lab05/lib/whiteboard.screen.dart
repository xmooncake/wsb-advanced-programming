import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab05/cubit/whiteboard_cubit.dart';
import 'package:lab05/widgets/widgets.dart';
import 'package:whiteboard/whiteboard.dart';

class WhiteboardScreen extends StatelessWidget {
  const WhiteboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WhiteBoardController whiteBoardController = WhiteBoardController();

    final colors = [
      Colors.black,
      Colors.green,
      Colors.blue,
      Colors.amber,
      Colors.yellow,
      Colors.orange,
      Colors.grey,
      Colors.pink,
    ];

    return BlocProvider(
      create: (_) => WhiteboardCubit(),
      child: BlocBuilder<WhiteboardCubit, WhiteboardState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: () => whiteBoardController.undo(),
                  heroTag: 'undo',
                  icon: const Icon(Icons.undo),
                  label: const Text('Cofnij'),
                ),
                const SizedBox(height: 5),
                const FloatingActionButton.extended(
                  onPressed: null,
                  heroTag: 'saveImage',
                  icon: Icon(Icons.save_alt),
                  label: Text('Zapisz'),
                ),
                const SizedBox(height: 15)
              ],
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  WhiteBoard(
                    backgroundColor: Colors.white,
                    controller: whiteBoardController,
                    strokeWidth: state.brushSize,
                    strokeColor: state.selectedColor,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (Color color in colors)
                          SelectColorButton(
                            context,
                            state,
                            color: color,
                          ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Slider(
                            value: state.brushSize / 2,
                            onChanged: (double val) => context.read<WhiteboardCubit>().changeBrushSize(
                                  val * 2,
                                ),
                            label: '${state.brushSize / 2}',
                            min: 1,
                            max: 6,
                            divisions: 5,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
