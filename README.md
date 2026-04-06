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
  <br> 사용자의 현재 위치를 기반으로 지도 상에서 즐길 수 있는 실시간 인터랙티브 게임 제공
- **QR 코드를 활용한 스탬프 투어**
  <br> 오프라인 장소의 QR 코드를 스캔하여 온라인 스탬프를 수집하는 O2O(Online to Offline) 경험 제공
- **추천 알고리즘 기반 맞춤형 축제 추천**
  <br> 사용자의 위치 데이터를 분석하여 가장 적합한 축제를 선별 및 추천
- **웹소켓(WebSocket)을 활용한 실시간 유저 채팅**
  <br> 웹소켓 통신을 적용하여 지연 없는 양방향 실시간 채팅 환경 구축
- **DB 연동을 통한 종합 축제 정보 조회**
  <br> 데이터베이스를 기반으로 전라남도 지역의 다채로운 축제 정보를 한눈에 확인할 수 있도록 제공

## 4. 화면 구성

## 5. 기술 스택
### 5.1 Back-End
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
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128"><path fill="#0074BD" d="M47.617 98.12s-4.767 2.774 3.397 3.71c9.892 1.13 14.947.968 25.845-1.092 0 0 2.871 1.795 6.873 3.351-24.439 10.47-55.308-.607-36.115-5.969zm-2.988-13.665s-5.348 3.959 2.823 4.805c10.567 1.091 18.91 1.18 33.354-1.6 0 0 1.993 2.025 5.132 3.131-29.542 8.64-62.446.68-41.309-6.336z"/><path fill="#EA2D2E" d="M69.802 61.271c6.025 6.935-1.58 13.17-1.58 13.17s15.289-7.891 8.269-17.777c-6.559-9.215-11.587-13.792 15.635-29.58 0 .001-42.731 10.67-22.324 34.187z"/><path fill="#0074BD" d="M102.123 108.229s3.529 2.91-3.888 5.159c-14.102 4.272-58.706 5.56-71.094.171-4.451-1.938 3.899-4.625 6.526-5.192 2.739-.593 4.303-.485 4.303-.485-4.953-3.487-32.013 6.85-13.743 9.815 49.821 8.076 90.817-3.637 77.896-9.468zM49.912 70.294s-22.686 5.389-8.033 7.348c6.188.828 18.518.638 30.011-.326 9.39-.789 18.813-2.474 18.813-2.474s-3.308 1.419-5.704 3.053c-23.042 6.061-67.544 3.238-54.731-2.958 10.832-5.239 19.644-4.643 19.644-4.643zm40.697 22.747c23.421-12.167 12.591-23.86 5.032-22.285-1.848.385-2.677.72-2.677.72s.688-1.079 2-1.543c14.953-5.255 26.451 15.503-4.823 23.725 0-.002.359-.327.468-.617z"/><path fill="#EA2D2E" d="M76.491 1.587S89.459 14.563 64.188 34.51c-20.266 16.006-4.621 25.13-.007 35.559-11.831-10.673-20.509-20.07-14.688-28.815C58.041 28.42 81.722 22.195 76.491 1.587z"/><path fill="#0074BD" d="M52.214 126.021c22.476 1.437 57-.8 57.817-11.436 0 0-1.571 4.032-18.577 7.231-19.186 3.612-42.854 3.191-56.887.874 0 .001 2.875 2.381 17.647 3.331z"/></svg>
### 5.2 Front-End
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg" width="45" height="45"><br>HTML5</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/css3/css3-original.svg" width="45" height="45"><br>CSS3</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg" width="45" height="45"><br>JavaScript</td>
  </tr>
</table>

### 5.3 DB
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original.svg" width="45" height="45"><br>MySQL</td>
  </tr>
</table>

### 5.4 Tools
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" width="45" height="45"><br>GitHub</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg" width="45" height="45"><br>VS Code</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/intellij/intellij-original.svg" width="45" height="45"><br>IntelliJ IDEA</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/jupyter/jupyter-original.svg" width="45" height="45"><br>Jupyter Notebook</td>
  </tr>
</table>

### 5.5 AI&Model Serving
<table>
  <tr>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" width="45" height="45"><br>Python</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/pandas/pandas-original.svg" width="45" height="45"><br>Pandas</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/scikitlearn/scikitlearn-original.svg" width="45" height="45"><br>Scikit-learn</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/fastapi/fastapi-original.svg" width="45" height="45"><br>FastAPI</td>
    <td align="center" width="110"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flask/flask-original.svg" width="45" height="45"><br>Flask</td>
  </tr>
</table>
