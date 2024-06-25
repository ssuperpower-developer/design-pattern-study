package src;

abstract class Game {
    // Template method
    public final void play() {
        initialize();
        startPlay();
        endPlay();
    }
    // Steps to be implemented by subclasses
    abstract void initialize();
    abstract void startPlay();
    abstract void endPlay();
}