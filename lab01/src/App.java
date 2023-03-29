
import java.util.Arrays;
import java.util.List;

import models.Circle;
import models.Figure;
import models.Square;
import models.Triangle;

public class App {
    public static void main(String[] args) throws Exception {
        List<Figure> figures = Arrays.asList(new Square(5.0), new Triangle(3, 4), new Circle(2));

        System.out.println(figures);

        for (Figure figure : figures) {
            System.out.println(figure);
        }

        System.out.println(figures.get(0).calculateArea());
    }
}
