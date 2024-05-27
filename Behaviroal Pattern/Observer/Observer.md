# Observer Pattern (감시자 패턴)

## 배경

감시자 패턴을 결정하게 된 이유는 Swift로 앱 개발을 하다보니 UI 프로그래밍에서 반응형 프로그래밍을 안할수가 없었습니다. 가장 쉽게 접하는 엔트리포인트인 버튼 액션을 구현하는 것과 사용자의 반응에 의해 변화하는 데이터 값에 대한 UI의 변화를 구현하는 부분이 있습니다. 그래서 자연스럽게 감시자 디자인 패턴에 대해서 하고 싶어 선정하게 되었습니다.

## 감시자 패턴은 무엇인가?

감시자 패턴의 정의는 다음과 같습니다.

> 옵저버 패턴은 한 객체의 상태가 바뀌면 그 객체의 의존하는 다른 객체에게 연락이 가고 자동으로 내용이 갱신되는 방식으로 일대다 의존성을 정의힙니다.

위에 정의를 중심으로 상태가 바뀌는 객체를 `Observable(또는 Subject)`라고 부르고 의존하는 객체를 `Observer`라고 부릅니다. 지금 용어에 집중하는 것이 중요한데 옵저버 패턴에 이어 반응형 프로그래밍을 할 때도 계속 등장하기 때문입니다.

저는 개념 자체는 쉽다고 생각합니다. 프론트 엔드 뿐만 아니라 백엔드에서도 데이터가 변화함에 따라 다른 데이터들이 변하는 현상은 개발자들이 많이 접하고 자주 접한다고 생각하기 때문입니다.

그래서 저는 이번에 실질적으로 옵저버 패턴을 사용해서 어떻게 코드레벨에서 어떻게 활용하는지, 이 부분에 집중했습니다.

## 동작원리

옵저버 패턴의 [UML Diagram](https://en.wikipedia.org/wiki/Observer_pattern#UML_class_diagram)을 참고해보면 동작원리가 이해가 될 것 입니다.

![Diagram](https://upload.wikimedia.org/wikipedia/commons/0/01/W3sDesign_Observer_Design_Pattern_UML.jpg)

Subject 속성의 객체가 Subject를 의존하는 Observer에게 정보를 전달하고 있습니다. 위에서 Observable(Subject)라고 작성했는데, 이렇게 두 키워드를 복합적으로 사용하더라구요. 그래서 두 가지 모두 알고 있어야 합니다.

## 실질적 구현

옵저버 패턴을 채택하여 실질적으로 구현하는 것은 간단합니다. `Subject(Observable)` 인터페이스와 `Observer` 인터페이스를 바탕으로 `Concrete Subject(Observable)` 클래스와 `Concrete Observer` 클래스를 구현하면 됩니다.

UML 다이어그램에서 볼 수 있듯이 필요한 메소드를 추상적으로 선언하고 해당 인터페이스를 implement 해서 구현하는 클래스에서 실질적인 코드를 작성하면 됩니다.

`Concrete`라는 키워드는 두 인터페이스를 채택한 실질적인 클래스를 말하는 것 입니다. 그리고 클래스가 모두 완성이 되면 내가 사용하고자 하는 로직의 위치에서 `Sequence Diagram`을 참고해서 완성하면 됩니다.

## java.util.Observable & java.util.Observer

이 두 라이브러리는 헤드퍼스트 디자인패턴에서 사용했던 옵저버패턴을 위한 라이브러리입니다. 하지만 java9에서 `deprecated` 되었기 때문에 이제 사용하지 않습니다. (지금 자바가 벌써 java22더라구요? 이번에 자바 버전이 6개월에 한 번씩 배포된다는 사실을 처음 알았습니다...댑악..)

위 두 라이브러리는 인터페이스로 구현되어 있습니다. 어떤 객체가 Observable 특성과 Observer 특성을 가지기 위해서는 두 인터페이스를 implement 해야 하죠.

그런데 이제는 두 인터페이스를 사용하지 않기 때문에 후속 조치에 대해서 어떤지 궁금했습니다.

## Reactive Programming

옵저버 패턴은 반응형 프로그래밍과 아주 긴밀한 관계에 있습니다. 특히 반응형 프로그래밍을 위한 많은 라이브러리가 옵저버 패턴을 기반으로 만들어졌죠. 그래서 Java에서도 `java.util.concurrent.Flow` 라이브러리를 사용하라고 권장하는 Linter의 메시지과 커뮤니티 글을 많이 보았습니다. `concurrent`라는 키워드에서도 볼 수 있듯이 동시성 프로그래밍의 라이브러리 중 하나입니다. 동시성 프로그래밍은 반응형 프로그래밍과 함께 사용되는 프로그래밍 패러다임입니다.

> For a richer event model, consider using the java.desktop/java.beans package. For reliable and ordered messaging among threads, consider using one of the concurrent data structures in the java.util.concurrent package. For reactive streams style programming, see the java.util.concurrent.Flow API.

위의 문장이 Java linter에서 제시하는 조언입니다. Java에서 사용하는 `Observable`이랑 `Observer` 라이브러리는 사용 목적이 애매하다고 합니다. 이걸 좋게 말하면 범용성이 넓다고 할 수 있는데, 시간이 지나면서 목적에 부합하는 라이브러리를 직접 사용하는 것이 낫다고 개발자들이 생각해서 더 구체적인 라이브러리를 사용하나봅니다.

## 샘플코드

`Observer` 폴더 안에 헤드퍼스트 디자인 저서에서 제공하는 샘플 코드를 넣어두었습니다.
