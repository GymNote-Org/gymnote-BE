# GymNote - Backend Service Part
## 💪 프로젝트 소개
**세상에서 가장 쉬운 운동기록 앱 `GymNote`**

> 나만의 운동 루틴을 설정해 진행한 운동을 기록해보세요.  
> 지역별 운동 커뮤니티 게시판에서 서로 소통할 수 있는 운동 루틴 기록 및 커뮤니티 앱입니다.

## 🧑‍💻 개발 참여자
|lgm1007|Chiloli|
|---|---|
|[![lgm1007](https://github.com/lgm1007.png?size=200)](https://github.com/lgm1007)|[![Chiloli](https://github.com/Chiloli.png?size=200)](https://github.com/Chiloli)

## 📚 기술스택 구성
- Spring Boot 2.7.18
- Java 17
- PostgreSQL
- Docker
- GitHub Action

## 🚀 설치 및 실행하기
### 로컬 개발환경 실행
```
# 사전에 Docker Desktop 설치 필요
# docker-compose로 구성된 컨테이너 빌드 및 실행
gymnote-BE > docker compose up -d

# Docker 이미지 빌드 및 실행
gymnote-BE > docker build -t gymnote .
gymnote-BE > docker run -p 8080:8080 -e JAVA_OPTS=-Dspring.profiles.active=local gymnote
```

## 🗂 프로젝트 구조
### 루틴 도메인 예시
```
프로젝트 구조는 계층형, 개발 방법론은 DDD 따름

gymnote-BE
├── routine
│   ├── application
│   │   ├── RoutineService.java
│   │   └── dto
│   │       ├── CreateRoutineRequest.java
│   │       └── RoutineResponse.java
│   ├── domain
│   │   ├── Routine.java
│   │   ├── Exercise.java
│   │   └── RoutineRepository.java  ⬅️ 인터페이스
│   ├── infrastructure
│   │   └── RoutineRepositoryImpl.java  ⬅️ 구현체
│   └── presentation
│       └── RoutineController.java
└── shared
    └── BaseEntity.java
```

## ✨ 주요 기능
- 나만의 운동 루틴을 추가 및 편집한다.
- 오늘 일자로 선택한 루틴에 해당하는 운동을 기록한다.
- 운동 기록이 완료된 일자는 오늘의 운동 완료한 날로 기록된다.
- 그동안 수행해 온 운동 기록의 운동 볼륨을 차트로 확인할 수 있다.
- 운동 커뮤니티의 게시글을 조회할 수 있다. (v2)
- 운동 커뮤니티에 게시글을 작성할 수 있다. (v2)
- 내가 작성한 운동 커뮤니티의 게시글을 수정 및 삭제할 수 있다. (v2)

## 💾 ERD
### 운동 루틴 기록 ERD (기획 중)
```mermaid
erDiagram
    Member {
        varchar(100) email PK "이메일"
        varchar(255) name "이름"
        varchar(20) oauthProvider UK "OAUTH 제공자"
        varchar(100) oauthId UK "OAUTH 고유ID"
        timestamp createdDate "최초가입일자"
        timestamp lastLoginDate "최근로그인일자"
    }

    Routine {
        bigint routineId PK "루틴ID"
        varchar(255) routineName "루틴이름"
        varchar(100) email FK "회원이메일"
    }

    Exercise {
        bigint exerciseId PK "운동ID"
        bigint routineId FK "루틴ID"
        varchar(50) exerciseName "운동이름"
        varchar(30) exerciseTarget "운동부위"
        int repetitions "운동횟수"
        int weight "중량"
        varchar(10) weightUnit "중량단위"
        int sets "세트수"
    }

    Record {
        bigint recordId PK "운동기록ID"
        varchar(100) email FK "회원이메일"
        varchar(255) routineName "루틴이름"
        timestamp startDate "운동시작일시"
        timestamp recordDate "운동완료일시"
    }

    RecordExercise {
        bigint recordId FK "운동기록ID"
        varchar(50) exerciseName "운동이름"
        varchar(30) exerciseTarget "운동부위"
        int volumn "운동볼륨"
    }

    MemberGoals {
        bigint statusId PK "회원상태ID"
        varchar(100) email FK "회원이메일"
        varchar(30) goals "운동목표"
    }

    Member ||--o{ Routine : 1n
    Routine ||--o{ Exercise : 1n
    Member ||--|{ Record : 1n
    Record ||--o{ RecordExercise : 1n
    Member ||--|| MemberGoals : 11
```

### 운동 커뮤니티 게시글 ERD (기획 중)
```mermaid
erDiagram
    Member {
        varchar(100) email PK "이메일"
        varchar(255) name "이름"
        varchar(20) oauthProvider UK "OAUTH 제공자"
        varchar(100) oauthId UK "OAUTH 고유ID"
        timestamp createdDate "최초가입일자"
        timestamp lastLoginDate "최근로그인일자"
    }

    Board {
        bigint boardId PK "게시글ID"
        varchar(100) email FK "회원이메일"
        text content "게시글내용"
        int hits "조회수"
        timestamp createdDate "최초등록일자"
        timestamp lastModifiedDate "최근수정일자"
    }

    BoardImage {
        bigint imageId PK "게시글이미지ID"
        bigint boardId FK "게시글ID"
        text imagePath "이미지저장경로"
    }

    Member ||--o{ Board : 1n
    Board ||--|{ BoardImage : 1n
```
