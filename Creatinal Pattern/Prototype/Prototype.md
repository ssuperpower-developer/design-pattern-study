# Prototype Pattern

## 개념

기존에 존재하는 인스턴스를 복제합니다.

## 샘플코드

``` java
Employees emps = new Employees();
emps.loadData();

Employees empsNew = (Employees) emps.clone();
Employees empsNew1 = (Employees) emps.clone();
List<String> list = empsNew.getEmpList();
list.add("John");
List<String> list1 = empsNew1.getEmpList();
list1.remove("Pankaj");
```

`Employees` 클래스 객체를 하나 생성하고 `clone` 메소드를 사용해서 인스턴스를 깊은 복사하여 새로운 변수에 할당하고 있다.

## 원리

![원리](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Prototype_Pattern_ZP.svg/1920px-Prototype_Pattern_ZP.svg.png)

`Cloneable` 인터페이스를 구현한 클래스에서 `clone` 메소드를 오버라이딩을 하면 된다. 오버라이딩된 `clone` 메소드에서 깊은 복사가 동작하는 코드를 생성하면 된다.
