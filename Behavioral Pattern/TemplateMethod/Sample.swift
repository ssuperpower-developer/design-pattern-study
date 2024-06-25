import Foundation

// Abstract class defining the template method and the steps
class Game {
    // Template method
    final func play() {
        initialize()
        startPlay()
        endPlay()
    }
    
    // Steps to be implemented by subclasses
    func initialize() {
        fatalError("Must override initialize")
    }
    
    func startPlay() {
        fatalError("Must override startPlay")
    }
    
    func endPlay() {
        fatalError("Must override endPlay")
    }
}

// Concrete class implementing the steps
class Cricket: Game {
    override func initialize() {
        print("Cricket Game Initialized! Start playing.")
    }
    
    override func startPlay() {
        print("Cricket Game Started. Enjoy the game!")
    }
    
    override func endPlay() {
        print("Cricket Game Finished!")
    }
}

// Concrete class implementing the steps
class Football: Game {
    override func initialize() {
        print("Football Game Initialized! Start playing.")
    }
    
    override func startPlay() {
        print("Football Game Started. Enjoy the game!")
    }
    
    override func endPlay() {
        print("Football Game Finished!")
    }
}

// Client code
let game1: Game = Cricket()
game1.play()

let game2: Game = Football()
game2.play()
