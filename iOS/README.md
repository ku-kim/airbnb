# AirbnbApp - iOS


### Developer
  - [Dale](https://github.com/sungju-kim)
  - [Mase](https://github.com/sanghyeok-kim)

<br>

# 프로젝트 후기 및 시도해본 점

- 둘 다 MVC 패턴만 사용해 보다가, MVVM 패턴을 처음으로 사용해보며 해당 패턴이 갖는 장단점을 경험
  - 장점
    - ViewModel이 비즈니스 로직을 담당하여 MVC에 비해 ViewController가 가벼워짐
    - ViewModel은 View와의 의존성이 없으므로 테스트에 용이 ~~(하지만 정작 테스트 코드 작성까지는 못했음... 😅)~~
  - 단점
    - 이벤트 방출 - 관찰 흐름이 복잡해짐
    - ViewModel 안에 ViewModel이 있는 경우가 생겼는데, 리팩토링 과정에서 바인딩 흐름을 찾기가 무척 힘들었음

<br>

- ViewModel - View간 binding을 위해 [Custom Observable](https://github.com/jeremy0405/airbnb/blob/team-13/iOS/AirbnbApp/AirbnbApp/Source/Support/CustomObservable.swift) 구현
  - PublishRelay : BehaviorRelay와 달리 value 프로퍼티를 가지지 않음 -> 생성시 초기값(value)을 설정하지 않아도 됨
  - BehaviorRelay : PublishRelay와 달리 생성시 value 프로퍼티 초기화가 필요, bind하는 순간 value값이 accept됨 
  - `bind(onNext:)` : accept에 의해 실행될 클로저를 등록
  - `accept(_:)` : 등록된 클로저들에 매개변수를 넣고 실행

<br>

# Feature

### 사용자의 현재 위치에 맞게 가까운 여행지 거리 계산
![CleanShot 2022-06-11 at 18 49 35](https://user-images.githubusercontent.com/57667738/173182883-c0d401ad-217e-45ac-b0b2-0779964c2c92.gif)
![CleanShot 2022-06-11 at 18 42 55](https://user-images.githubusercontent.com/57667738/173182647-26c5eb8f-a5d8-4e17-85c4-24d3f8cf0b0c.gif)
- 새로고침시 변경된 위치에 따라 가까운 여행지까지의 소요시간이 변경됨을 확인할 수 있다.

<br>

### 다양한 형태의 컬렉션 뷰 출력
![CleanShot 2022-06-11 at 18 53 35](https://user-images.githubusercontent.com/57667738/173183018-6bcb6239-2f45-4707-bb15-38f9ea683b0a.gif)
- CollectionView + CompositionalLayout

<br>

### 지역 검색 기능
![CleanShot 2022-06-11 at 18 34 28](https://user-images.githubusercontent.com/57667738/173182392-6ef7f725-08a2-4855-a634-55ec71d9ff74.gif)
- MapKit

<br>

### 체크인-체크아웃 기간 설정을 위한 달력
![CleanShot 2022-06-11 at 18 35 50](https://user-images.githubusercontent.com/57667738/173182414-5777d96f-6162-4da0-80d8-6cbeef0e5d1e.gif)
- CollectionView

<br>


### 가격 범위 설정을 위한 슬라이더
![CleanShot 2022-06-11 at 18 37 39](https://user-images.githubusercontent.com/57667738/173182455-2652f1d5-00db-4878-a5f0-f11e7de6cf90.gif)
- Custom Slider
- CoreGraphics - Layer Masking

<br>

### 숙박 인원 설정을 위한 버튼
![CleanShot 2022-06-11 at 18 38 16](https://user-images.githubusercontent.com/57667738/173182485-ab50bbe7-066a-423c-9e75-97ea080588aa.gif)
- 요구사항 반영을 위한 로직 구현
  - 성인과 어린이는 `게스트 n명`으로 처리, 유아는 `유아 n명`으로 별도 처리
  - 성인의 수가 0명인 상태에서 어린이나 유아의 수를 늘릴 경우, 성인의 수가 자동으로 1명 증가
  - 최대 16명까지 선택 가능하며, 이후 `+` 버튼을 비활성화
