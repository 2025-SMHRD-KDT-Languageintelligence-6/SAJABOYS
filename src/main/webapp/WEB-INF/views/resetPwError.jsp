<%@ page contentType="text/html; charset=UTF-8" %>
 <!DOCTYPE html>
 <html>
 <head>
     <title>비밀번호 재설정 오류</title>
 </head>
 <body>
     <h2>비밀번호 재설정 오류</h2>
     <p style="color:red;">
         ${tokenError}
     </p>

     <a href="/findAccount">되돌아가기</a>
 </body>
 </html>
