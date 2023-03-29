package models;

public class Triangle extends Figure {
    double a;
    double h;

    public Triangle(double a, double h) {
        this.a = a;
        this.h = h;
    }

    @Override
    public double calculateArea() {
        return a * h / 2;
    }

}