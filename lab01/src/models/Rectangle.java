package models;

class Rectangle extends Figure {
    double a;
    double b;

    public Rectangle(double a, double b) {
        this.a = a;
        this.b = b;
    }

    @Override
    public double calculateArea() {
        // TODO Auto-generated method stub
        return a * b;
    }

}