package src;

public class TemplateMethodPatternDemo {
    public static void main(String[] args) {
        Game game1 = new Cricket();
        game1.play();

        Game game2 = new Football();
        game2.play();
    }
}