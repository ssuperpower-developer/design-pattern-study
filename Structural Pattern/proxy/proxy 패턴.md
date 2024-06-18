
# Proxy Pattern 

프록시 패턴은 대상 원본 객체를 대리하여 대신 처리하게 함으로써 로직의 흐름을 제어하는 패턴이다. 

client가 진짜 객체를 쓰는 것이 아니라 프록시(대리인)을 거쳐서 쓰는 코드 패턴이다. 

> 아니 그냥 객체 쓰면 되지 왜 굳이?

기존 클래스가 민감한 정보를 가지고 있거나 객체를 만들기에 너무 무거운 경우, 혹은 기능 추가 해야하는데 찐 객체를 수정할 수 없는 상황일 때 쓰면 좋다. 

형식적인 장점은 아래와 같다. 
1. 보안 : 프록시는 일단 클라이언트가 권한 있는지 물어본다. 
2. 캐싱 : 프록시에 내부 캐시를 유지하여 데이터가 캐시에 아직 존재하지 않는 경우에만 대상에서 작업이 실행되도록 한다. ( 동일한 요청에 대해 실제 객체에 반복적으로 접근하는 것을 막는다. 이미 캐시에 있는 데이터인데 찐 객체까지 다녀올 필요가 없으니까 )
3. Validation : 찐 객체로 전달 되기 전에 유효성 검사를 미리할 수 있다. 
4. Lazy initialization : 객체를 생성하는 것의 cost가 너무 비싸다 하면 그 객체가 진짜 필요할 때까지 생성을 미룰 수 있다. 
5. Logging
6. Remote object : 프록시는 원격 위치에 있는 객체를 가져와서 로컬처럼 보이게 할 수 있다. 

## 프록시 패턴 구조

찐 객체를 보통 Subject라고 한다. 
프록시를 만드려면 interface를 만들어서 subject와 proxy가 동일한 인터페이스를 가지고 있어야 한다. (분신인데 당연하지 )

![[Pasted image 20240618200513.png]]
- subject : Proxy와 RealSubject를 하나로 묶는 인터페이스 
- RealSubejct : 찐 객체
- Proxy : 말 그대로 proxy
	- 프록시는 대상 객체를 Composition한다. 
	- 프록시는 대상 객체와 같은 이름의 메서드를 호출하며 별도의 로직을 수형할 수 있다. 
	- 프록시는 흐름제어만 할 뿐 결과값을 조작하거나 변경시키면 안된다. (대리자가 그러면 안되지)
- Client : subject 인터페이스를 이용하여 프록시 객체를 생성해 이용한다. 
	- 클라이언트는 프록시를 중간에 두고 프록시를 통해서 RealSubject와 데이터를 주고 받는다. 

## 프록시 패턴 종류

Proxy 패턴은 종류가 참 많다. 

### 기본형 프록시 (normal Proxy)

```java
interface ISubject {
    void action();
}

class RealSubject implements ISubject {
    public void action() {
        System.out.println("원본 객체 액션 !!");
    }
}
```

```java
class Proxy implements ISubject {
    private RealSubject subject; // 대상 객체를 composition

    Proxy(RealSubject subject) {
        this.subject = subject;
    }

    public void action() {
        subject.action(); // 위임
        /* do something */
        System.out.println("프록시 객체 액션 !!");
    }
}

class Client {
    public static void main(String[] args) {
        ISubject sub = new Proxy(new RealSubject());
        sub.action();
    }
}
```

### 가상 프록시

- 지연 초기화 방식
- 가끔 필요하지만 항상 메모리에 적재되어 있는 무거운 서비스 객체가 있는 경우
- 이 구현은 실제 객체의 생성에 많은 자원이 소모 되지만 사용 빈도가 낮을 때 쓰는 방식이다. 
- 서비스가 시작될 때 객체를 생성하는 대신에 객체 초기화가 실제로 필요한 시점에 초기화 될 수 있도록 지연할 수 있다. 

```java
class Proxy implements ISubject {
    private RealSubject subject; // 대상 객체를 composition

    Proxy() {
    }

    public void action() {
    	// 프록시 객체는 실제 요청(action(메소드 호출)이 들어 왔을 때 실제 객체를 생성한다.
        if(subject == null){
            subject = new RealSubject();
        }
        subject.action(); // 위임
        /* do something */
        System.out.println("프록시 객체 액션 !!");
    }
}

class Client {
    public static void main(String[] args) {
	    //이때 실제 객체를 생성하는 것이 아님
        ISubject sub = new Proxy();
        //진짜 필요할 때 생성하게 된다. 
        sub.action();
    }
}
```

### 보호 프록시 (Protection Proxy)

- 프록시가 찐 객체에 대한 자원으로의 엑세스 제어(접근 제한)
- 특정 클라이언트만 서비스 객체를 사용할 수 있는 경우
- 프록시 객체를 통해 클라이언트의 자격 증명이 기준과 일치하는 경우에만 서비스 객체에 요청을 전달할 수 있게 한다. 

```java

class Proxy implements ISubject {
    private RealSubject subject; // 대상 객체를 composition
    private boolean access; // 접근 권한

    Proxy(RealSubject subject, boolean access) {
        this.subject = subject;
        this.access = access;
    }

    public void setAccess(boolean access) {
        this.access = access;
    }

    public void action() {
        if (access) {
            subject.action(); // 위임
            /* do something */
            System.out.println("프록시 객체 액션 !!");
        } else {
            System.out.println("접근 권한이 없습니다.");
        }
    }
}


class Client {
    public static void main(String[] args) {
        RealSubject realSubject = new RealSubject();
        Proxy proxy = new Proxy(realSubject, false);

        // 접근 권한이 없을 때
        proxy.action();

        // 접근 권한을 설정
        proxy.setAccess(true);

        // 접근 권한이 있을 때
        proxy.action();
    }
}

```

### 로깅 프록시

- 대상 객체에 대한 로깅을 추가하려는 경우

```java
class Proxy implements ISubject {
    private RealSubject subject; // 대상 객체를 composition

    Proxy(RealSubject subject {
        this.subject = subject;
    }

    public void action() {
        System.out.println("로깅..................");
        
        subject.action(); // 위임
        /* do something */
        System.out.println("프록시 객체 액션 !!");

        System.out.println("로깅..................");
    }
}

class Client {
    public static void main(String[] args) {
        ISubject sub = new Proxy(new RealSubject());
        sub.action();
    }
}

```

### 원격 프록시 (Remote Proxy)

- 프록시 클래스는 로커레 있고 찐 객체가 원격 서버에 존재하는 경우
- 프록시 객체는 네트워크를 통해 클라이언트의 요청을 전달하여 네트워크와 관련된 불필요한 작업들을 처리하고 결과 값만 반환
- 클라이언트 입장에선 프록시를 통해 객체를 이용하는 것이니 원격이든 로컬이든 신경 쓸 필요가 없으며, 프록시는 진짜 객체와 통신을 대리하게 된다. 

![[Pasted image 20240618211018.png]]

> 프록시를 스터브라고도 부르며, 프록시로부터 전달된 명령을 이해하고 적합한 메소드를 호출해주는 역할을 하는 보조 객체를 스켈레톤이라고 한다. 


### 캐싱 프록시 (Caching Proxy)

- 데이터가 큰 경우 캐싱하여 재사용을 유도
- 클라이언트 요청의 결과를 캐시하고 이 캐시의 수명 주기를 관리 

## Proxy 패턴 장점

OCP (개방 폐쇄 원칙 준수) 
- 기존 찐 객체의 코드를 변경하지 않고 새로운 기능을 추가할 수 있다. 
SRP (단일 책임 원칙 준수)
- 찐 객체는 자신의 기능에만 집중하고, 그 외의 부가 기능을 프록시 객체에 위임한다. 
	- logging이나 protection이런거 다 짬 때리잖아 


## CODE

> 어떤 코드? 

이미지 뷰어 프로그램을 만든다고 가정해보자, 이미지 뷰어는 고해상도 이미지를 불러와서 사용자에게 보여준다. 

고해상도 이미지 경로를 인자로 받아 메모리에 적재하고, showImage() 메소드가 호출되면 화면에 렌더링하는 HighResolutionImage클래스를 구성해준다. 

```java
class HighResolutionImage {
    String img;

    HighResolutionImage(String path) {
        loadImage(path);
    }

    private void loadImage(String path) {
        // 이미지를 디스크에서 불러와 메모리에 적재 (작업 자체가 무겁고 많은 자원을 필요로함)
        try {
            Thread.sleep(1000);
            img = path;
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.printf("%s에 있는 이미지 로딩 완료\n", path);
    }

    @Override
    public void showImage() {
        // 이미지를 화면에 렌더링
        System.out.printf("%s 이미지 출력\n", img);
    }
}

```

```java
class ImageViewer {
    public static void main(String[] args) {
        HighResolutionImage highResolutionImage1 = new HighResolutionImage("./img/고해상도이미지_1");
        HighResolutionImage highResolutionImage2 = new HighResolutionImage("./img/고해상도이미지_2");
        HighResolutionImage highResolutionImage3 = new HighResolutionImage("./img/고해상도이미지_3");

        highResolutionImage2.showImage();
    }
}
```

이렇게 사용한다 치면 
showImage가 느리다. 왜냐하면 로딩하는데 시간이 오래걸리기 때문에 
이를 해결하기 위해서 Proxy 패턴을 적용해보자 

Lazy Initiatialisation 

우선 인터페이스를 만들어주자 
```java
// 대상 객체와 프록시 객체를 묶는 인터페이스 (다형성)
interface IImage {
    void showImage(); // 이미지를 렌더링하기 위해 구현체가 구현해야 하는 추상메소드
}
```

```java
// 대상 객체 (RealSubject)
class HighResolutionImage implements IImage {
    String img;

    HighResolutionImage(String path) {
        loadImage(path);
    }

    private void loadImage(String path) {
        // 이미지를 디스크에서 불러와 메모리에 적재 (작업 자체가 무겁고 많은 자원을 필요로함)
        try {
            Thread.sleep(1000);
            img = path;
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.printf("%s에 있는 이미지 로딩 완료\n", path);
    }

    @Override
    public void showImage() {
        // 이미지를 화면에 렌더링
        System.out.printf("%s 이미지 출력\n", img);
    }
}
```

```java
// 프록시 객체 (Proxy)
class ImageProxy implements IImage {
    private IImage proxyImage;
    private String path;

    ImageProxy(String path) {
        this.path = path;
    }

    @Override
    public void showImage() {
        // 고해상도 이미지 로딩하기
        proxyImage = new HighResolutionImage(path);
        proxyImage.showImage();
    }
}
```

```java
class ImageViewer {
    public static void main(String[] args) {
        IImage highResolutionImage1 = new ImageProxy("./img/고해상도이미지_1");
        IImage highResolutionImage2 = new ImageProxy("./img/고해상도이미지_2");
        IImage highResolutionImage3 = new ImageProxy("./img/고해상도이미지_3");

        highResolutionImage2.showImage();
    }
}
```

ShowImage를 할 때 객체를 찐 객체를 생성하게 해서 다른 것들 로딩하는 시간이 안 걸린다. => 실제 메소드를 호출하는 시점에 메모리 적재가 이루어진다. 

# Spring Proxy

### Spring AoP

스프링에서는 Bean을 등록할 때 singleton을 유지하기 위해서 Dynamic Proxy 기법을 이용해 프록시 객체를 Bean으로 등록한다. 
또한 Bean으로 등록하려는 객체가 interface를 하나라도 구현하고 있으며 JDK를 이용하고 Interface를 구현하고 있지 않으면 CGLIB라이브러리를 이용한다. 

### Dynamic Proxy

자바 JDK에서는 Dynamic 프록시 객체 구현을 지원한다. 

개념 : 개발자가 직접 프록시 객체를 생성하는 것이 아니라, 애플리케이션 실행 도중에 java.long.reflect.Proxy 패키지에서 제공해주는 API를 이용하여
동적으로 프록시 인스턴스를 만들어 등록하는 방법이다. 

```java
// 대상 객체와 프록시를 묶는 인터페이스
interface Animal {
    void eat();
}

// 프록시를 적용할 타겟 객체
class Tiger implements Animal{
    @Override
    public void eat() {
        System.out.println("호랑이가 음식을 먹습니다.");
    }
}
```

```java
public class Client {
    public static void main(String[] arguments) {
		
        // newProxyInstance() 메서드로 동적으로 프록시 객체를 생성할 수 있다.
        Animal tigerProxy = (Animal) Proxy.newProxyInstance(
                Animal.class.getClassLoader(), // 대상 객체의 인터페이스의 클래스로더
                new Class[]{Animal.class}, // 대상 객체의 인터페이스
                new InvocationHandler() { // 프록시 핸들러
                    @Override
                    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                        Object target = new Tiger();

                        System.out.println("----eat 메서드 호출 전----");

                        Object result = method.invoke(target, args); // 타겟 메서드 호출

                        System.out.println("----eat 메서드 호출 후----");

                        return result;
                    }
                }
        );

        tigerProxy.eat();
    }
}
```


```java
@Service
public class GameService {
	public void startDame() {
    	System.out.println("이 자리에 오신 여러분을 진심으로 환영합니다.");
    }
}
```

```java
@Aspect
@Comonent
public class PerfAspect {
	@Around("bean(gameService)")
	public void timestamp(ProceedingJoinPoint point) throws Throwable {
    	System.out.println("프록시 실행 1");
        
        point.proceed(); // 대상 객체의 원본 메서드를 실행
        
        System.out.println("프록시 실행 2");
    }
}
```