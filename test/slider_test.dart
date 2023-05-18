import 'package:flutter_test/flutter_test.dart';
import 'package:number_slider/model/slider.dart';

void main() {
  test('Coordinates can be added and subtracted', () {
    const Coord a = Coord(1, 2);
    const Coord b = Coord(3, -4);
    
    expect(a + b, const Coord(4, -2));
    expect(a - b, const Coord(-2, 6));
  });

  test('newly created slider puzzle starts solved', () {
    SliderGame sliderGame = SliderGame(size: 3);
    expect(sliderGame.isSolved(), true);

    sliderGame = SliderGame(size: 8);
    expect(sliderGame.isSolved(), true);

    sliderGame = SliderGame(size: 1);
    expect(sliderGame.isSolved(), true);
  });

  test('an upward move should be legal on a new puzzle', () {
    final sliderGame = SliderGame(size: 3);
    const Coord upMove = Coord(-1, 0);
    
    expect(sliderGame.canMove(upMove), true);
  });

  test('making one move on a new puzzle should unsolve it', () {
    final sliderGame = SliderGame(size: 3);
    const Coord upMove = Coord(-1, 0);
    sliderGame.move(upMove);

    expect(sliderGame.isSolved(), false);
  });

  test('moves in opposite directions should be inverses', () {
    final sliderGame = SliderGame(size: 3);
    const Coord leftMove = Coord(0, -1);
    const Coord rightMove = Coord(0, 1);
    sliderGame.move(leftMove);
    sliderGame.move(rightMove);

    expect(sliderGame.isSolved(), true);
  });
}