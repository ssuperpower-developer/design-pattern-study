## 추천하는 선행 개념

1. 추상 클래스
2. 인터페이스
3. 상속

위 3가지 개념이 어떻게 작동하는지만 알고 있으면, 팩토리 메소드 패턴을 공부함으로써 각각의 차이점과 용도를 이해할 수 있습니다.

## 정의와 한줄 정리

> 객체를 생성할 때 필요한 인터페이스를 만들고, 어떤 클래스의 인스턴스를 만들지는 서브클래스에서 결정하는 패턴이다.
> 

→ 따라서 클라이언트는 객체가 만들어지는 구체적인 과정을 알지 못하기 때문에 **느슨한 결합**이 가능해진다.

**인스턴스를 생성 하는 과정**을 유연하게 만들고, 인스턴스를 만드는 쪽과 받는쪽의 결합도를 낮추기 위한 방법

## 구조

Factory라는 이름에 걸맞게 인스턴스를 생성해서 넘겨준다. 이 이미지를 기억하시면 좋습니다.

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/c8d27b19-e396-4990-8812-37f7041e3724/009c941f-271f-48bf-8b7f-a1d063cd11f7/Untitled.png)

---

### Product

팩토리 메소드 패턴을 통해 만들고자 하는 인스턴스의 **인터페이스**입니다.

- 인터페이스로 만들어야만 Product를 받은 클라이언트가 Product의 실제 타입에 상관없이 일관되게 Product를 다룰 수 있습니다.
- 예시로, “Pizza” 인터페이스라고 생각하시면 좋습니다. 그 세부 구현인 고구마 피자, 베이컨 피자가 있지만, 클라이언트는 피자의 타입에 상관없이 이를 일관되게 다룰 수 있어야 합니다.

### Concrete Product

**Product를 구현한 실제 Class**입니다.

- 위 예시와 같이 고구마 피자, 베이컨 피자 Class가 해당합니다.

### Creator

Product를 만들고 다루는 **Abstract Class**입니다. 

- 피자를 자르고, 포장하는 등 피자를 다루는 메소드는 어떤 피자에나 동일하게 적용되므로 여기에서 정의하고 구현합니다.
- 피자에 따라 토핑을 올리는 등 만들어지는 방법은 모두 다르기 때문에 해당 메소드는 abstract으로 만들어서 구현의 책임을 하위 클래스로 위임합니다.

### Concrete Creator

**Creator 추상 클래스를 상속받아 구현한 Class**입니다.

- Creator를 상속 받았기 때문에 피자를 다루는 메소드는 모두 동일합니다.
- 피자를 만드는 메소드만 여기에서 원하는대로 구현합니다.

## 예시

### 우당탕탕 피자가게 창업

```java
Pizza orderPizza(String type) {
        Pizza pizza;
        
        if (type.equals("cheese")) {
            pizza = new CheesePizza();
        }
        else if (type.equals("greek")) {
            pizza = new GreekPizza();
        }
        else if (type.equals("pepperoni")) {
            pizza = new PepperoniPizza();
        }

				// 아래 메소드들은 모두 각각의 피자 클래스에 구현
        pizza.prepare();
        pizza.bake();
        pizza.cut();
        pizza.box();
        return pizza;
    }
```

 야심차게 3가지 메뉴를 가지고 피자 가게를 창업 했습니다. 메뉴가 여러 개여도 준비하고, 굽고, 자르고, 포장하는 과정을 거쳐야 하니 Pizza 인터페이스를 도입하고 이를 구현한 치즈피자 등의 클래스를 만들었습니다.

### 신메뉴 출시 & 안 팔리는 메뉴 정리

```java
Pizza orderPizza(String type) {
        Pizza pizza = new Pizza();

        if (type.equals("cheese")) {
            pizza = new CheesePizza();
        }
        // 삭제
        ~~else if (type.equals("greek")) {
            pizza = new GreekPizza();
        }~~
        else if (type.equals("pepperoni")) {
            pizza = new PepperoniPizza();
        }
        // 추가
        **else if (type.equals("clam")) {
            pizza = new ClamPizza();
        }**
				
				// 이 아래는 변하지 않습니다.
        pizza.prepare();
        pizza.bake();
        pizza.cut();
        pizza.box();
        return pizza;
    }
```

 장사를 하다보니 새 메뉴를 만들거나, 팔리지 않는 메뉴는 정리 하는 일이 발생합니다. 그럴 때마다 위와 같이 if-else 부분은 계속해서 코드가 수정되는 것을 알 수 있습니다. 반면, 준비하고, 굽는 과정은 모든 피자가 거치는 과정이므로 변화가 생기지 않습니다.

**이제 바뀌는 부분을 캡슐화 하면 됩니다.**

### 피자 공장(Factory) 생성

```java
class PizzaStore {

    SimplePizzaFactory factory;
    
    public PizzaStore(SimplePizzaFactory factory) {
        this.factory = factory;
    }
    
    Pizza orderPizza(String type) {
        Pizza pizza;

        pizza = factory.createPizza(type);

        pizza.prepare();
        pizza.bake();
        pizza.cut();
        pizza.box();

        return pizza;
    }
}
```

```java
**// 피자 공장을 만들겠습니다!**

public class SimplePizzaFactory {

    public Pizza createPizza(String type) {
        Pizza pizza;

        if (type.equals("cheese")) {
            pizza = new CheesePizza();
        }
        else if (type.equals("pepperoni")) {
            pizza = new PepperoniPizza();
        }
        else if (type.equals("clam")) {
            pizza = new ClamPizza();
        }
        
        return pizza;
    }
}

```

피자를 만드는 일을 하는 클래스를 만들어서 객체 생성을 위임하였습니다. 이를 통해 느슨한 결합을 만들었습니다. 이제 피자 생성 코드가 변함에 따라 여기저기에서 수정이 일어나지 않아도 됩니다. 여기서 factory를 static으로 선언하면 정적 팩토리 메소드 패턴이 됩니다.

### 프랜차이즈 피자가게 회장 되기

```java
class PizzaStore {

    PizzaFactory factory;
    
    public PizzaStore(PizzaFactory factory) {
        this.factory = factory;
    }
    
    Pizza orderPizza(String type) {
        Pizza pizza;

        pizza = factory.createPizza(type);

        pizza.prepare();
        pizza.bake();
        pizza.cut();
        pizza.box();

        return pizza;
    }
}
```

```java
**// 뉴욕의 피자공장입니다.**

public class NYFactory implements PizzaFactory {

    public Pizza createPizza(String type) {
        Pizza pizza;

        if (type.equals("cheese")) {
            pizza = new CheesePizza();
        }
        else if (type.equals("pepperoni")) {
            pizza = new PepperoniPizza();
        }
        else if (type.equals("clam")) {
            pizza = new ClamPizza();
        }
        
        return pizza;
    }
}

```

이렇게 저의 사업이 잘 되어서 저는 프랜차이즈 가맹점을 둔 피자 회사 사장이 되었습니다. 하지만 지역마다 고객들은 모두 입맛이 다르기 때문에, 한 개의 공장에서 나오는 피자로는 이들을 만족시킬 수 없게 되었고, 지역마다 공장을 만들 필요가 생겼습니다. 하지만 공장이 다를뿐! 같은 피자 프랜차이즈이므로 준비, 포장 등의 과정은 모두 동일해야 합니다. 따라서 Factory를 **인터페이스 또는 추상클래스**로 만들고, 이를 세부 구현한 NYFactory, CAFactory등의 클래스를 두게 되었습니다. 위 코드에서는 Factory를 인터페이스로 만들고, NYFactory 클래스를 구현하였습니다.

## 결론

- Client인 PizzaStore는 받은 Pizza 객체가 어떤 클래스를 통해 만들어진것인지 알 수 없습니다.
→ 느슨한 결합! 의존성이 낮아졌다는 의미
- 팩토리 클래스의 세부 구현을 하위 클래스로 위임하는 방법은 인터페이스와 추상클래스 사용이 있습니다.
→ 상황에 맞게 선택!
