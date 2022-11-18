# 잡플래닛 코딩테스트

- 아키텍처
    - MVVM, 클린아키텍처 적용
    - NetworkPlatform : Data Layer (API를 통한 네트워킹 및 캐싱을 통한 데이터 처리)
    - Domain : Domain Layer (비즈니스 로직)
    - 앱 모듈 : Presentation Layer (MVVM)
        - Model(Domain Model)
        - ViewModel (데이터 바인딩, 로직 담당)
        - View, ViewController, Cell (화면 표현 담당)
        - Navigator (뷰컨트롤러 이동 담당, Coordinator)
- API는 고정적인 JSON 데이터를 불러오고 있어 현재 구현은 한번 API 호출 후 캐시에 담아서 캐시에 담긴 데이터를 통해 검색을 구현하였습니다.

- 테스트
    - 프로젝트를 클론하거나 다운로드 받아주세요
    - Jobplanet-test → Jobplanet-test.xcodeproj 파일을 통해 프로젝트를 실행해주세요.
    - 첫 빌드 시 오류가 발생하면 Xcode 상단의 File → Packages → Resolve Package Versions를 진행한 뒤 빌드해주세요.
