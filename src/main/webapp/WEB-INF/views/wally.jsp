<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>윌리를 찾아라 룰북 | 추적자들</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="/assets/css/main.css" />

    <style>
        .rulebook-wrap{
          max-width: 900px;
          margin: 3rem auto;
          padding: 0 1rem;
          font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }
        .rulebook-header{
          text-align: center;
          margin-bottom: 2.5rem;
        }
        .rulebook-header h2{
          font-size: 2rem;
          font-weight: 800;
          margin-bottom: 0.4rem;
        }
        .rulebook-header p{
          color: #555;
          font-size: 0.95rem;
        }

        .rule-card{
          background: #ffffff;
          border-radius: 16px;
          padding: 1.8rem 1.6rem;
          box-shadow: 0 10px 25px rgba(15,23,42,0.08);
          border: 1px solid #e5e7eb;
          display: flex;
          flex-direction: column;
          gap: 0.75rem;
        }
        .rule-card h3{
          font-size: 1.4rem;
          font-weight: 800;
          margin: 0;
          display: flex;
          align-items: center;
          gap: 0.4rem;
        }
        .rule-meta{
          font-size: 0.86rem;
          color: #4b5563;
          font-weight: 600;
        }
        .rule-label{
          display: inline-flex;
          align-items: center;
          padding: 0.22rem 0.7rem;
          border-radius: 999px;
          font-size: 0.76rem;
          font-weight: 700;
          background: #ecfeff;
          color: #0e7490;
          margin-bottom: 0.3rem;
        }
        .rule-icon{
          font-size: 1.2rem;
        }

        .rule-section-title{
          font-size: 0.9rem;
          font-weight: 700;
          margin-top: 0.5rem;
          margin-bottom: 0.15rem;
          color: #111827;
        }
        .rule-card p{
          font-size: 0.88rem;
          line-height: 1.6;
          color: #374151;
          margin: 0;
        }
        .rule-card ul{
          margin: 0.15rem 0 0.35rem 1.1rem;
          padding: 0;
        }
        .rule-card li{
          font-size: 0.86rem;
          line-height: 1.5;
          color: #4b5563;
        }

        .rule-footer-note{
          margin-top: 1.5rem;
          font-size: 0.8rem;
          color: #9ca3af;
          text-align: right;
        }
    </style>
</head>
<body>
<div id="site-header"></div>
<script src="/assets/js/header.js"></script>

<section class="rulebook-wrap" id="rulebook-wally">

    <article class="rule-card">
        <span class="rule-label">탐색 · 인증 게임</span>
        <h3><span class="rule-icon">🕵️‍♂️</span>윌리를 찾아라</h3>
        <p class="rule-meta">인원 제한 없음 · 제한 시간 없음 · 탐색/인증형 미션</p>

        <div>
            <div class="rule-section-title">게임 개요</div>
            <p>
                축제장 전역에 숨겨진 ‘월리’를 찾아다니며 QR을 스캔해 인증하는 탐색형 게임입니다.
                가족, 연인, 친구들끼리 함께 즐길 수 있는 가벼운 걷기·찾기 콘텐츠입니다.
            </p>
        </div>

        <div>
            <div class="rule-section-title">목적</div>
            <ul>
                <li>지도와 힌트를 활용해 지정된 '월리'를 모두 찾아 QR 인증을 완료하는 것이 목표입니다.</li>
            </ul>
        </div>

        <div>
            <div class="rule-section-title">진행 방식</div>
            <ul>
                <li>시작 지점에서 기본 힌트 지도 또는 첫 번째 힌트를 제공합니다.</li>
                <li>참가자는 힌트를 바탕으로 축제장 내 여러 지점을 이동하며 '월리'를 찾습니다.</li>
                <li>각 포인트에서 QR을 스캔하면 인증이 완료되고, 일부 포인트는 추가 힌트나 퍼즐 요소를 제공합니다.</li>
                <li>정해진 개수의 포인트를 모두 인증하면 완수로 인정되며, 기념 뱃지나 이벤트 보상을 받을 수 있습니다.</li>
            </ul>
        </div>

        <div>
            <div class="rule-section-title">승리 조건</div>
            <ul>
                <li>정해진 시간 안에 지정된 개수의 '월리' QR을 모두 인증하면 클리어</li>
                <li>팀전인 경우, 더 짧은 시간 안에 완료한 팀이 승리</li>
            </ul>
        </div>

        <div>
            <div class="rule-section-title">추가 요소</div>
            <ul>
                <li>SNS에 인증샷을 업로드하면 추가 포인트 또는 이벤트 혜택을 제공할 수 있습니다.</li>
                <li>초급/중급/고급 루트로 나누어 난이도 선택형 운영도 가능합니다.</li>
            </ul>
        </div>
    </article>

    <p class="rule-footer-note">
        ※ 실제 운영 시 포인트 수, 힌트 난이도, 소요 시간은 축제장 상황에 맞게 조정할 수 있습니다.
    </p>
</section>

</body>
</html>
