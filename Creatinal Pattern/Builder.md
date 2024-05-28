# Builder (빌더 패턴)
빌더 패턴은 간단합니다. 그냥..
### What?
객체를 생성한다.

### How?
빌더패턴을 통해!

끝입니다.

## 일반적으로 객체를 생성하는 방법


- new(생성자)를 통해 생성
- 순서를 맞춰서 한 번에 와르르 넣었는다.
```
Bag bag = new Bag("name", 1000, "memo");
```






## 빌더를 통해 객체를 생성하는 방법

- 빌더를 이용해 생성
- 각 멤버 변수에 항목에 맞춰서 넣는다.
```
Bag bag = Bag.builder()
        	.name("name")
            .money(1000)
            .memo("memo")
            .build();
```


### 예시
- 스프링부트에서의 빌더
```
    public static ShortenedUrlDto from(ShortenedUrl shortenedUrl) {
        return ShortenedUrlDto.builder()
            .id(shortenedUrl.getId())
            .shortUrl(shortenedUrl.getShortUrl())
            .originUrl(shortenedUrl.getOriginUrl())
            .createdAt(shortenedUrl.getCreatedAt())
            .build();
    }
```
Dto의 클래스 앞에 @Builder 어노테이션을 붙임



- 안드로이드에서의 빌더

사실 저는 빌더 이름 보고 그냥 생성만 해주는 구나 싶었습니다..

```
    fun createDialogWithMessage(message: String, context: Context) {
        var builder: AlertDialog.Builder = AlertDialog.Builder(context)
        builder.setMessage(message)
        builder.setPositiveButton("확인") { dialogInterface, i ->
            dialogInterface.dismiss()
        }
        builder.create().show()
    }
```



### 장점
장점이 매우 크다.

캡슐화를 할 수 있다. 객체를 생성자를 통해서 만들게 되면, 모든 멤버 변수를 순서대로 넣어줘야한다. 파라미터의 순서나 개수가 다르면 안된다. 하지만 빌더를 통해 객체를 만들게 되면 각 멤버 변수항목에 해당하는 값을 괄호에 바로 넣어주기 때문에 상관 없다. 

그런 점에서 캡슐화라고 한다.   
=> 상세한 행동이 무엇이든 하나로 커버칠 수 있다. 


### 단점



객체 생성을 위해서 알아야 하는 정보가 많다.


### 참고자료
https://mangkyu.tistory.com/163 
