# design-pattern-study
디자인 패턴을 공부하는 레포지토리입니다.

### 1. 모든 스터디원은 매주 하나의 발표를 준비해옵니다.
- 스터디 진행 기간은 여름방학이 끝나기 전까지로 잡겠습니다.
- 한 주에 발표 1개 준비 * 4명 -> 일주일에 4개의 디자인 패턴을 공부하는 것으로 합니다!
- PR은 스터디 전날 자정까지 올려주세요! 마크다운 언어를 기반으로 깃허브 PR을 통해 제출합니다. (md 파일에 발표 장표 이미지로 대체 가능)
- 스터디는 대면이 원칙이며, 스터디에서 다음 주 맡을 패턴을 고릅니다.
- [헤드 퍼스트 디자인 패턴](https://m.yes24.com/Goods/Detail/108192370) 도서를 참고해도 좋고, 이외 자료를 참고해도 좋습니다.

### 2. 세션은 하나의 디자인 패턴을 스터디원들에게 설명하는 것으로 진행됩니다. (10~20분 정도 분량)
세션은 아래와 같은 목차로 구성해주세요!

- 우선, 예시(디자인패턴 책 참고)를 들면서 언어에 상관없이 모든 스터디원들이 이해될 수 있도록 설명해주세요!
- 예시 설명 이후에, 공통 언어(Java)로 예시 코드 혹은 실제 프로젝트에서 해당 패턴을 사용한 사례를 가지고 소개를 해주세요. (공통 언어 필수 + 다른 언어로 구현하는 것은 자유입니다. 단, 너무 너무 소개하고 싶다면 다른 언어를 사용해도 괜찮음. )  
- 마지막에는 간단하게 해당 디자인 패턴을 조사하면서 어떤 점을 배우고 느끼게 되었는지에 대해서도 설명해주세요.

### 3. 레포지토리 사용 컨벤션
- Design Pattern 선정은 선착순입니다. Issue에 `[주차] 패턴 이름` 이름으로 등록한 하면 선점~
  -  `[1주차] 빌더 패턴`
- 브랜치명은 `이름/주차수`로 해주세요! 머지하고 브랜치 지워주기~
  - `jin/week1`
- 커밋 컨벤션 `유형: 작업 사항`
  - 유형: add/update/delete
  - `add: builder pattern code`

## 👥 함께 공부하는 사람들

| 유진 | 국혜경 | 최지웅 | 임형규 | 
|:--------:|:-------:| :-------:| :-------:| 
|<img width="150" src="https://github.com/objet-team/objet-backend/assets/94737714/7a0a7377-9533-43da-814b-3118cbe47a40">| <img width="150" src = "https://github.com/objet-team/objet-backend/assets/94737714/b7fc017c-7c90-4056-b9dd-049b7f994322"> | <img width="150" src="https://github.com/ssuperpower-developer/design-pattern-study/assets/82222245/19892b21-0c46-4556-83f6-a3150fa0f376"> | <img width="150" src = "https://github.com/ssuperpower-developer/design-pattern-study/assets/97347625/659d9dfd-6bf1-40f0-9a16-5197e33cd46f">
| [HI-JIN2](https://github.com/HI-JIN2) | [k0000k](https://github.com/k0000k)  | [jayn2u](https://github.com/jayn2u) | [Gusionling](https://github.com/Gusionling)
<br>

## 📁 세션 진행 기록 모음
### 생성 (Creatinal) 패턴
| Design Pattern | Java |
| :--: | :--: |
| 빌더 (Builder) |O|
| 추상 팩토리 (Abstract Factory) ||
| 팩토리 메서드 (Factory Method) |O|
| 단일체 (Singleton) |O|
| 모노스테이트 (Monostate)||
| 원형 (Prototype)|O|

### 구조 (Structural) 패턴
| Design Pattern | Java |
| :--: | :--: |
| 적응자 (Adapter) |O|
| 장식자 (Decorator) | |
| 퍼사드 (Facade) | |
| 복합체 (Composite)||
| 프록시 (Proxy) |O|
| 가교 (Bridge)||
| 플라이급 (Flyweight)||

### 행동 (Behavioral) 패턴
| Design Pattern | Java |
| :--: | :--: |
| 감시자 (Observer) |O|
| 전략 (Strategy) |O|
| 명령 (Command) | |
| 해석자 (Interpreter)
| 반복자 (Iterator)
| 중재자 (Mediator)
| 방문자 (Visitor)
| 상태 (State) | |
| 템플릿 메서드 (Template Method) |
| 추억거리 (Memento)
| 플럭스 (Flux) | | 
