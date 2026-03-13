## 1. 프로젝트 개요
- 프로젝트 이름 : 추적자들(Chaser)
- 프로젝트 설명 : 전남 축제에서 진행하는 지도 API와 QR 기반 실시간 게임 플랫폼

## 2. 팀원 및 소개

| 팀원 | 역할 |
| :---: | --- |
| **최태림** | <ul><li>프로젝트 총괄 기획 및 일정 관리</li><li>백엔드 아키텍처 설계 및 API 구현</li><li>DB 설계 및 관리</li></ul> |
| **박현우** | <ul><li>UI/UX 기획 및 전반적인 웹 디자인</li><li>프론트엔드 아키텍처 설계 및 컴포넌트 개발</li> |
| **서준원** | <ul><li>맞춤형 축제 추천 알고리즘 설계 및 구현</li><li>전남 지역 축제 데이터 정제</li><li>프로젝트 산출물 관리</li> |
| **신창용** | <ul><li>DB 설계 및 관리</li><li>전남 지역 축제 데이터 수집(크롤링) 및 정제</li> |

## 3. 주요 기능

- **지도 API 기반 실시간 게임**
  - 사용자의 현재 위치를 기반으로 지도 상에서 즐길 수 있는 실시간 인터랙티브 게임 제공
- **QR 코드를 활용한 스탬프 투어**
  - 오프라인 장소의 QR 코드를 스캔하여 온라인 스탬프를 수집하는 O2O(Online to Offline) 경험 제공
- **추천 알고리즘 기반 맞춤형 축제 추천**
  - 사용자의 위치 데이터를 분석하여 가장 적합한 축제를 선별 및 추천
- **웹소켓(WebSocket)을 활용한 실시간 유저 채팅**
  - 웹소켓 통신을 적용하여 지연 없는 양방향 실시간 채팅 환경 구축
- **DB 연동을 통한 종합 축제 정보 조회**
  - 데이터베이스를 기반으로 전라남도 지역의 다채로운 축제 정보를 한눈에 확인할 수 있도록 제공

## 4. 기술 스택
### 4.1 Back-End
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original.svg" width="45" height="45"><br>Java</td>
    <td align="center" width="110"><img src="https://cdn.simpleicons.org/springboot/6DB33F" width="45" height="45"><br>Spring Boot</td>
    <td align="center" width="110"><img src="https://cdn.simpleicons.org/springsecurity/6DB33F" width="45" height="45"><br>Spring Security</td>
    <td align="center" width="110"><img src="https://raw.githubusercontent.com/mybatis/logo/master/logo-bird-ninja.svg" width="45" height="45"><br>MyBatis</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/tomcat/tomcat-original.svg" width="45" height="45"><br>Tomcat</td>
    <td align="center" width="110"><img src="https://cdn.simpleicons.org/socketdotio/black" width="45" height="45"><br>WebSocket</td>
  </tr>
</table>

### 4.2 Front-End
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg" width="45" height="45"><br>HTML5</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/css3/css3-original.svg" width="45" height="45"><br>CSS3</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg" width="45" height="45"><br>JavaScript</td>
  </tr>
</table>

### 4.3 DB
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original.svg" width="45" height="45"><br>MySQL</td>
  </tr>
</table>

### 4.4 Tools
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" width="45" height="45"><br>GitHub</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg" width="45" height="45"><br>VS Code</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/intellij/intellij-original.svg" width="45" height="45"><br>IntelliJ IDEA</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/jupyter/jupyter-original.svg" width="45" height="45"><br>Jupyter Notebook</td>
  </tr>
</table>

### 4.5 AI&Model Serving
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" width="45" height="45"><br>Python</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/pandas/pandas-original.svg" width="45" height="45"><br>Pandas</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/scikitlearn/scikitlearn-original.svg" width="45" height="45"><br>Scikit-learn</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/fastapi/fastapi-original.svg" width="45" height="45"><br>FastAPI</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flask/flask-original.svg" width="45" height="45"><br>Flask</td>
  </tr>
</table>
