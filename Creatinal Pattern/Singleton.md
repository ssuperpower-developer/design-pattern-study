# 싱글톤 패턴

## 정의와 한줄 정리

> 특정 클래스가 단 하나의 인스턴스만 생성하여 사용하도록 보장하는 패턴이다.
> 

→ 여러개의 인스턴스가 만들어지면 혼란이 생기는 경우

→ 여러개가 필요하지 않으면서 오버헤드가 큰 인스턴스를 만드는 경우

## 사용 예시

- 스레드풀
- SQL connector

## 코드

```java
public class Singleton {

    private static Singleton singletonObject;

    // 생성자를 외부에서 호출 할 수 없게 막기
    private Singleton() {
    }
    
    // static 메소드로만 객체를 생성하도록
    public static Singleton getInstance() {
	// 이미 생성 되어있으면 아무것도 안하고 지나감!
        if (singletonObject == null) {
            singletonObject = new Singleton();
        }
        
        return singletonObject;
    }
}
```
