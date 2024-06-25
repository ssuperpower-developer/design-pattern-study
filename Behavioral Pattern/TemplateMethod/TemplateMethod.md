# 템플릿 메소드 패턴

## 개념

추상메소드를 사용하여 코드의 공통적인 부분을 정의하고, 하위 클래스에서 구체적인 부분을 구현하는 방식이다.
우리가 지금까지 가장 쉽게 자주 접하는 방식이며, 쉽게 이해 가능하다.

## 예제 코드

```java

// Game.java
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

// Football.java
class Football extends Game {
    @Override
    void initialize() {
        System.out.println("Football Game Initialized! Start playing.");
    }

    @Override
    void startPlay() {
        System.out.println("Football Game Started. Enjoy the game!");
    }

    @Override
    void endPlay() {
        System.out.println("Football Game Finished!");
    }
}

// Cricket.java
class Cricket extends Game {
    @Override
    void initialize() {
        System.out.println("Cricket Game Initialized! Start playing.");
    }

    @Override
    void startPlay() {
        System.out.println("Cricket Game Started. Enjoy the game!");
    }

    @Override
    void endPlay() {
        System.out.println("Cricket Game Finished!");
    }
}

// TemplateMethodPatternDemo.java
public class TemplateMethodPatternDemo {
    public static void main(String[] args) {
        Game game1 = new Cricket();
        game1.play();

        Game game2 = new Football();
        game2.play();
    }
}
```

## Hook Method

### Hook Method 개념

훅 메서드는 서브클래스가 선택적으로 오버라이드할 수 있는 메서드입니다. 기본적으로는 아무 작업도 수행하지 않지만, 서브클래스에서 필요에 따라 기능을 추가할 수 있습니다. 템플릿 메서드 패턴에서 훅 메서드는 알고리즘의 특정 지점에서 추가적인 동작을 삽입할 수 있는 유연성을 제공합니다. 이를 통해 서브클래스는 알고리즘의 구조를 변경하지 않고도 특정 단계를 확장하거나 수정할 수 있습니다.

### Hook Method 예제 코드

``` swift
// BaseViewController
import UIKit

// Base class defining the template method and steps for setting up a view controller
class BaseViewController: UIViewController {
    
    // Template method
    final func setupViewController() {
        setupViews()
        loadData()
        setupBindings()
        viewDidAppearCustomization()
        customizeAppearance()
    }

    // Steps of the algorithm to be implemented by subclasses
    func setupViews() {
        fatalError("Must override setupViews")
    }

    func loadData() {
        fatalError("Must override loadData")
    }

    func setupBindings() {
        fatalError("Must override setupBindings")
    }
    
    // Hook method with default behavior (optional)
    func viewDidAppearCustomization() {
        // Default implementation: do nothing
    }

    // Hook method with default behavior (optional)
    func customizeAppearance() {
        // Default implementation: do nothing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearCustomization()
    }
}

// UserProfileViewController
import UIKit

class UserProfileViewController: BaseViewController {
    
    override func setupViews() {
        print("Setting up views for user profile")
        // Add UI elements like labels, image views, etc.
    }

    override func loadData() {
        print("Loading user profile data")
        // Fetch user data from a server or database
    }

    override func setupBindings() {
        print("Setting up bindings for user profile")
        // Bind data to UI elements, setup actions and observers
    }

    override func customizeAppearance() {
        print("Customizing appearance for user profile")
        // Custom appearance settings like setting colors, fonts, etc.
        view.backgroundColor = .lightGray
    }
    
    override func viewDidAppearCustomization() {
        print("View did appear customization for user profile")
        // Custom behavior when the view appears, e.g., starting an animation
    }
}

class SettingsViewController: BaseViewController {
    
    override func setupViews() {
        print("Setting up views for settings")
        // Add UI elements like switches, sliders, etc.
    }

    override func loadData() {
        print("Loading settings data")
        // Load settings data from user defaults or a server
    }

    override func setupBindings() {
        print("Setting up bindings for settings")
        // Bind data to UI elements, setup actions and observers
    }
    
    // No need to override customizeAppearance if no custom appearance is required
    // No need to override viewDidAppearCustomization if no custom behavior is required
}

// Usage in the application
let userProfileVC = UserProfileViewController()
userProfileVC.viewDidLoad()
// Output:
// Setting up views for user profile
// Loading user profile data
// Setting up bindings for user profile
// Customizing appearance for user profile

let settingsVC = SettingsViewController()
settingsVC.viewDidLoad()
// Output:
// Setting up views for settings
// Loading settings data
// Setting up bindings for settings
```

## Hollywood Principle

- 헐리우드 원칙은 "우리가 당신에게 전화할 테니, 당신은 우리에게 전화하지 마세요" (Don't call us, we'll call you)라는 문구로 요약될 수 있습니다.
- 이 원칙은 상위 수준의 구성 요소가 하위 수준의 구성 요소를 제어하는 디자인 원칙을 의미합니다.
- 즉, 하위 수준의 구성 요소는 상위 수준의 구성 요소에 의해 호출되기 전까지는 아무런 행동도 하지 않습니다.
- 이 원칙은 의존성 역전 원칙(Dependency Inversion Principle)과 관련이 있으며, 객체 지향 프로그래밍에서 유연하고 확장 가능한 시스템을 설계하는 데 중요한 역할을 합니다.
- 쉽게 말해 상위 수준의 구성 요소가 하위 수준의 구성 요소에 의해 호출되기 전까지는 아무런 행동도 하지 않는다는 뜻입니다.
- concrete 클래스의 메소드가 super 클래스의 어떠한 부분에도 호출하지 않는다는 말로 생각할 수 있습니다.
