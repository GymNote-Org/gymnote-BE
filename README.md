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
- OAuth2
- GitHub Action

## 🚀 설치 및 실행하기

## ✨ 주요 기능
- 나만의 운동 루틴을 추가 및 편집한다.
- 오늘 일자로 선택한 루틴에 해당하는 운동을 기록한다.
- 운동 기록이 완료된 일자는 오늘의 운동 완료한 날로 기록된다.
- 운동 커뮤니티의 게시글을 조회할 수 있다.
- 운동 커뮤니티에 게시글을 작성할 수 있다.
- 내가 작성한 운동 커뮤니티의 게시글을 수정 및 삭제할 수 있다.

## 🗂️ ERD
### 운동 루틴 기록 ERD
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
        varchar(100) email "회원이메일"
        bigint routineId "루틴ID"
        timestamp recordDate "운동완료일자"
    }

    Member ||--o{ Routine : 1n
    Routine ||--|{ Exercise : 1n
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
