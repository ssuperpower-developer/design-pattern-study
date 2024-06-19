# 어댑터 패턴


어댑터 패턴 = 적응자 패턴


## 용도
> 호환되지 않는 인터페이스들을 연결하는 디자인 패턴

쉽게 생각하면 돼지코 같은 느낌이다.  
일본에 가면 우리나라 가전 제품은 220V이기에 110V으로 낮추기 위해서 어댑터를 쓴다. 

![돼지코](https://img.danawa.com/prod_img/500000/237/018/img/2018237_1.jpg?_v=20240229170319)


- 기존의 클래스를 수정하지 않고도, 특정 인터페이스를 필요로하는 코드에서 사용할 수 있게 해줌
- 클래스의 인터페이스를 다른 인터페이스로 변환할 수도 있음


- 호환성이 없는 인터페이스를 사용하고 싶을떄에 어댑터를 끼워서 연결한다. 
호환성 및 신규 기능 확장의 용도!

> - 기존 시스템 > 업체에서 제공한 클래스
> - 기존 시스템 > 어댑터 > 업체에서 제공한 클래스

> 추가로, 래거시 인터페이스를 감싸서 새로운 인터페이스로 변환하기 때문에 Wrapper 패턴이라도고 불린다.

## 그전에, 상속과 합성에 대해 알아보기

상속을 해서 호환작업을 해주냐,
합성을 해서 호환작업을 해주냐

둘다 코드 중복을 제거하여 재사용을 함으로서 변경과 확장을 용이하게 만드는게 목적


|상속|합성|
|--|--|
부모클래스와 자식 클래스 사이의 의존성은 컴파일 타임에 해결| 두 객체 사이의 의존성은 런타임에 해결|
|is-a 관계|has-a 관계|
|부모클래스의 구현에 의존 결합도가 높음|구현에 의존하지 않음. 내부에 포함되는 객체의 구현이 아닌 인터페이스에 의존|
|부모 클래스 안에 구현된 코드 자체를 물려받아 재사용|포함되는 객체의 퍼블릭 인터페이스를 재사용

### 상속 Inheritance

- 객체 지향 4가지 특징 중 하나. 많이 배웠음 ㅎㅎ
- 부모한테서 상속 받아서 다른 부분만 추가하거나 재정의함으로서 기존 코드를 쉽게 확장할 수 있다.
    - 부모 클래스에 메소드 하나 만들어놓고 상속을 통해 부모의 것을 가져와 사용한다는 기법으로 코드의 재사용이라고 말한다.
- 하지만 상속은 그저 코드 재사용을 위한 기법이 아니다.
    - 상속은 제너럴한 클래스를 이미 구현해 놓고, 좀 더 구체적인 클래스를 구현하기 위해 사용되는 기법이며, 그로 인해서 상위 클래스의 코드를 하위 클래스가 재사용할 수 있다. 요쯤으로 받아들이면 될듯.
    - 그렇기 때문에, 상위 클래스가 확장할 목적으로 설계되었고, 문서화가 잘되어 있는 경우에 사용을 추천한다. 
    - 하지만 부모 클래스의 내부를 잘 알아야한다는 단점과 그렇기에 부모-자식 간의 결합도가 높아진다는 문제가 있다. (결합도는 낮게 응집도는 높게!)
    - 상속은 컴파일 타임에 결정되며, 고정되기 때문에 코드를 실행하는 도중에 변경할 수 없다.
    - 개인적인 견해로는, 사실 상위 클래스를 미리 설계를 하고서 개발을 진행을 해도, 기획이 바뀌거나 등등 진행되면서 상속이 의미가 없는, 상황이 벌어질 수도 있다. 초반에 기획한 거랑 달라서 차라리 상속을 안받고서 각각의 클래스로 만드는게 나을 수도 있고, 부모-자식 관계를 처음에 설계했는데 자식에서 정의하는것만 수두룩 빽뺵해진다면 결국은 부모 클래스를 상속 받는 의의가 없어질 수도 있다.


```java
class Engine {
    String EngineType; // 디젤, 가솔린, 전기

    Engine(String type) {
        EngineType = type;
    }

    void drive() {
        System.out.printf("%s엔진으로 드라이브~\n", EngineType);
    }

    void breaks() {
        System.out.printf("%s엔진으로 브레이크~\n", EngineType);
    }
}

class Car extends Engine {
    Car(String engineType) {
        super(engineType); // 부모 클래스인 Engine의 생성자를 호출
    }

    // Car 클래스에 다른 메서드나 필드를 추가할 수 있음
}

public class Main {
    public static void main(String[] args) {
        Car myCar = new Car("가솔린");
        myCar.drive();
        myCar.breaks();
    }
}
```




### 합성 Composition
- 합성, 조합, composition
- 기존 클래스를 상속으로 확장하는 것이 아닌, 필드로 클래스의 인스턴스를 참조하게 만드는 설계
- 학생-수강과목, 자동차-엔진종류와 같이 아주 연관이 없지는 않지만, 상속하기에는 애매~한 것들을 합성으로 처리하면 좋다.




```java
class Car {
    Engine engine; // 필드로 Engine 클래스 변수를 갖는다(has)

    Car(Engine engine) {
        this.engine = engine; // 생성자 초기화 할때 클래스 필드의 값을 정하게 됨
    }

    void drive() {
        System.out.printf("%s엔진으로 드라이브~\n", engine.EngineType);
    }

    void breaks() {
        System.out.printf("%s엔진으로 브레이크~\n", engine.EngineType);
    }
}

class Engine {
    String EngineType; // 디젤, 가솔린, 전기

    Engine(String type) {
        EngineType = type;
    }
}
```


```java
public class Main {
    public static void main(String[] args) {
        Car digelCar = new Car(new Engine("디젤"));
        digelCar.drive(); // 디젤엔진으로 드라이브~

        Car electroCar = new Car(new Engine("전기"));
        electroCar.drive(); // 전기엔진으로 드라이브~
    }
}
```


- main 클래스 함수를 들여다 보면, new 생성자 안에 new 생성자를 넣는 방법으로 구현.
- 클래스 인스턴스 변수에 저장하여 가져다 쓴다는 원리
- 이런 방식을 포워딩이라고 함.
- 필드의 인스턴스를 참조해 사용하는 메소드를 포워딩 메소드라고 부른다.
- 그래서 클래스 간의 합성 관계를 사용하는데 이걸 has-a라고 한다.
- 합성을 이용할 때 꼭 클래스 뿐만 아니라 추상 클래스나 인터페이스로도 가능하다.


### 상속의 다사다난한 문제점
1. 결합도가 높아짐
2. 불필요한 기능 상속
3. 부모 클래스의 결함이 그대로 넘어옴
4. 부모 클래스와 자식 클래스의 동시 수정 문제
5. 매서드 오버라이딩의 오동작
- 부모의 Pulic 메소드는 외부에서 사용하도록 노출한 메소드임, 그런데 상속하게 되면 자식 클래스에서 부모 클래스의 public 메소드를 이용할 때의 의도하지 않는 동작을 수반할 수 있게 될 수 있다. -> 캡슐화를 위반함 
- 캡슐화는 단순히 private 변수로 getter/setter를 얘기하는 것이 아님. 내부적으로 어떻게 구현되어있는지를 감추는것이 바로 캡슐화. 단순히 클래스의 메소드를 쓸 때에 가져다 쓰기만 하면 되는거지, 내부 따위는 알 필요가 없다~
벋, 이 말은 즉슨 (몰라도 될만큼) 신뢰성이 보장되어야 한다.
- 캡술화가 깨졌다 = 신뢰성이 깨진다. 
6. 불필요한 인터페이스 상속 문제
7. 클래스 폭발
8. 단일 상속의 한계

### 그래서 합성을 사용해야하는 이유
- 결합도를 낮출 수 있다.
- 또한 상속 관계는 클래스 사이의 정적인 관계인 데 비해 합성 관계는 객체 사이의 동적인 관계이다.
코드 작성 시점에 결정한 상속 관계는 변경이 불가능하지만(컴파일 타임), 합성 관계는 실행 시점에 동적으로 변경할 수 있기 때문이다 (런타임).
    - 그래서 합성을 사용하고 인터페이스 타입을 사용한다면 런타임시에 외부에서 필요한 전략에 따라 교체하며 사용할 수 있으므로 좀 더 유연한 설계를 할 수 있다.


## 어댑터 패턴 구조

### 객체 어댑터
- 합성된 멤버에게 위임을 이용한 어댑터 패턴 
- 자기가 해야 할 일을 클래스 맴버 객체의 메소드에게 다시 시킴으로써 목적을 달성하는 것을 위임이라고 한다. 
- 합성을 사용했기 때문에 런타임 중에 adapter가 결정되어 유연하다.
- 그러나 Adapter 객체를 필드 변수로 저장해야하기 때문에 이에 따른 공간 차지 비용이 든다.

```java
// Adaptee : 클라이언트에서 사용하고 싶은 기존의 서비스 (하지만 호환이 안되서 바로 사용 불가능)
class Service {

    void specificMethod(int specialData) {
        System.out.println("기존 서비스 기능 호출 + " + specialData);
    }
}

// Client Interface : 클라이언트가 접근해서 사용할 고수준의 어댑터 모듈
interface Target {
    void method(int data);
}

// Adapter : Adaptee 서비스를 클라이언트에서 사용하게 할 수 있도록 호환 처리 해주는 어댑터
class Adapter implements Target {
    Service adaptee; // composition으로 Service 객체를 클래스 필드로

    // 어댑터가 인스턴스화되면 호환시킬 기존 서비스를 설정
    Adapter(Service adaptee) {
        this.adaptee = adaptee;
    }

    // 어댑터의 메소드가 호출되면, Adaptee의 메소드를 호출하도록
    public void method(int data) {
        adaptee.specificMethod(data); // 위임
    }
}
```

```java
class Client {
    public static void main(String[] args) {
        // 1. 어댑터 생성 (기존 서비스를 인자로 받아 호환 작업 처리)
        Target adapter = new Adapter(new Service());

        // 2. Client Interfac의 스펙에 따라 메소드를 실행하면 기존 서비스의 메소드가 실행된다.
        adapter.method(1);
    }
}
```

### 클래스 어댑터 
- 클래스 상속을 이용한 어댑터 패턴
- adaptee를 상속했기 때문에 따로 객체 구현 없이 바로 코드 재사용이 가능하다.
- 상속은 대표적으로 기존에 구현된 코드를 재사용하는 방식이지만, 다중 상속이 안되기 떄문에 전반적으로 권장하지는 않다. 

```java
// Adaptee : 클라이언트에서 사용하고 싶은 기존의 서비스 (하지만 호환이 안되서 바로 사용 불가능)
class Service {

    void specificMethod(int specialData) {
        System.out.println("기존 서비스 기능 호출 + " + specialData);
    }
}

// Client Interface : 클라이언트가 접근해서 사용할 고수준의 어댑터 모듈
interface Target {
    void method(int data);
}

// Adapter : Adaptee 서비스를 클라이언트에서 사용하게 할 수 있도록 호환 처리 해주는 어댑터
class Adapter extends Service implements Target {

    // 어댑터의 메소드가 호출되면, 부모 클래스 Adaptee의 메소드를 호출
    public void method(int data) {
        specificMethod(data);
    }
}
```

```java

class Client {
    public static void main(String[] args) {
        // 1. 어댑터 생성
        Target adapter = new Adapter();

        // 2. 인터페이스의 스펙에 따라 메소드를 실행하면 기존 서비스의 메소드가 실행된다.
        adapter.method(1);
    }
}
```

## 특징
- 레거시 코드를 사용하고 싶지만, 새로운 인터페이스가 레거시 코드와 호환되지 않을 때 
- 이미 만든 것을 재사용하고자 하나 이 재사용 가능한 라이브러리를 수정할 수 없을 떄
- 이미 만들어진 클래스를 새로운 인터페이스 API에 맞게 할때
- 소프트웨어의 구 버전과 신 버전을 공존시키고 싶을 때

=> 기존 클래스를 수정하지 않고 새로운 인터페이스에 맞게 호환작업을 해줌. 

### 장점
- 단일 책임 원칙
- 개방 폐쇠 원칙
- 생산성 
  - 추가로 필요한 메소드가 있을때 어댑터에 빠르게 만들어서 적용 가능!
  - 버그 발생시 기존 클래스에서는 발생할 확률이 없으므로, 어댑터만 보면 됨. (디버깅 쉬움)

### 단점 
- 새로운 인터페이스와 어댑터 클래스를 세트로 도입해야하기 때문에 코드의 복잡성이 증가한다.
- 서비스 클래스를 변경하는 것이 간단할 수 있는 경우가 있기 때문에 신중히 선택해야 한다. 

## 참고

[어댑터 패턴 제대로 배워보자](https://inpa.tistory.com/entry/GOF-%F0%9F%92%A0-%EC%96%B4%EB%8C%91%ED%84%B0Adaptor-%ED%8C%A8%ED%84%B4-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EB%B0%B0%EC%9B%8C%EB%B3%B4%EC%9E%90)

[객체지향의 상속 문제점과 합성 이해하기](https://inpa.tistory.com/entry/OOP-%F0%9F%92%A0-%EA%B0%9D%EC%B2%B4-%EC%A7%80%ED%96%A5%EC%9D%98-%EC%83%81%EC%86%8D-%EB%AC%B8%EC%A0%9C%EC%A0%90%EA%B3%BC-%ED%95%A9%EC%84%B1Composition-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0)