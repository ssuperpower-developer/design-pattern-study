
# 개요

전략 패턴? -> 쉽다~~
무언가를 갈아 끼울 때 어떻게 갈아 끼울 것인가 이것에 대한 고찰이다라고 보시면 될 것 같습니다. 

### 전략 패턴의 정의

실행(런타임) 중에 알고리즘 전략을 선택하여 객체 동작을 실시간으로 바뀌도록 할 수 있게 하는 디자인 패턴이다. 

**"전략"**
왜 전략일까요? 
-> 일상생활에서 사용하는 전략과 비슷한 개념입니다. 

전략 : 다양한 상황이 있을 때 그 상황에 적용할 수 효과적인 방법이죠

![[Pasted image 20240528204035.png]]

> 어떤 점에서 실행 중에 변경할 수 있다고 하는 것인가? 

>언제 적합할까? 

알고리즘 변형이 빈번하게 필요한 경우에 적합한 패턴이다. 

# 구조

![[Pasted image 20240528204539.png]]

`전략 알고리즘 객체들` : 알고리즘, 행위, 동작을 객체로 정의한 구현체
`전략 인터페이스` : 모든 전략 구현체에 대한 공용 인터페이스
`컨텍스트(Context)` : 알고리즘을 실행해야 할 때마다 해당 알고리즘과 연결된 객체의 메소드 호출
`클라이언트` : 특정 전략 객체를 컨텍스트에 **전달**하면서 전략을 등록하거나 변경하여 전략 알고리즘을 실행한 결과를 누린다. 

### 전략 패턴은 OOP의 집합체 

![[Pasted image 20240528204831.png]]

합성에서 런타임에 변경될 수 있다가 나온 것이다. 

**GoF 디자인 패턴 책에서 정리하는 전략 패턴**
1. 동일 계열의 알고리즘 군을 정의하고
		`전략 구현체로 정의`
2. 각각의 알고리즘을 캡슐화하여 
		`인터페이스로 추상화`
3. 이들을 상호 교환이 가능하도록 만든다. 
		`합성(Composition)으로 구성`
4. 알고리즘을 사용하는 클라이언트와 상관없이 독립적으로 
		`컨텍스트 객체 수정 없이`
5. 알고리즘을 다양하게 변경할 수 있도록 한다. 
		`메소드를 통해 전략 객체를 실시간으로 변경함으로써 전략을 변경`

# 전략 패턴 흐름

### 클래스 구성

![[Pasted image 20240528222251.png]]
```java
// 전략(추상화된 알고리즘)
interface IStrategy {
    void doSomething();
}

// 전략 알고리즘 A
class ConcreteStrateyA implements IStrategy {
    public void doSomething() {}
}

// 전략 알고리즘 B
class ConcreteStrateyB implements IStrategy {
    public void doSomething() {}
}
```

```java
// 컨텍스트(전략 등록/실행)
class Context {
    IStrategy Strategy; // 전략 인터페이스를 합성(composition)
	
    // 전략 교체 메소드
    void setStrategy(IStrategy Strategy) {
        this.Strategy = Strategy;
    }
	
    // 전략 실행 메소드
    void doSomething() {
        this.Strategy.doSomething();
    }
}
```

클래스 흐름

```java
// 클라이언트(전략 교체/전략 실행한 결과를 얻음)
class Client {
    public static void main(String[] args) {
        // 1. 컨텍스트 생성
        Context c = new Context();

        // 2. 전략 설정
        c.setStrategy(new ConcreteStrateyA());

        // 3. 전략 실행
        c.doSomething();

        // 4. 다른 전략 설정
        c.setStrategy(new ConcreteStrateyB());

        // 5. 다른 전략 시행
        c.doSomething();
    }
}
```

![[Pasted image 20240528222400.png]]

### 세부 특징

**전략 패턴 사용시기**

- 전략 알고리즘의 여러 버전 또는 변형이 필요할 때 클래스화를 통해 관리
- 알고리즘 코드가 노출되어서는 안 되는 데이터에 액세스 하거나 데이터를 활용할 때 (캡슐화)
- 알고리즘의 동작이 런타임에 실시간으로 교체 되어야 할때

**전략 패턴 주의점**

- 알고리즘이 많아질수록 관리해야할 객체의 수가 늘어난다는 단점이 있다.
- 만일 어플리케이션 특성이 알고리즘이 많지 않고 자주 변경되지 않는다면, 새로운 클래스와 인터페이스를 만들어 프로그램을 복잡하게 만들 이유가 없다.
- 개발자는 적절한 전략을 선택하기 위해 전략 간의 차이점을 파악하고 있어야 한다. (복잡도 ↑)
