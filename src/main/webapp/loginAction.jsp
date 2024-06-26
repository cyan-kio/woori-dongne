<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="woori.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="woori.User" scope="page" />
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리 동네 커뮤니케이션</title>
</head>
<body>
	<%
		String userID = null;   
		if(session.getAttribute("userID") != null) {  // 세션 확인
			userID = (String) session.getAttribute("userID"); // 세션이 존재하면 userID에 해당 세션 값 부여
		}
		if(userID != null) {  // 세션이 부여된 상태
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인하셨습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if (result == 1) {
			session.setAttribute("userID", user.getUserID());   // 세션 부여
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인하셨습니다.')");   // 로그인 성공 알림
			// script.println("history.back()");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("location.href = 'main.jsp'");  // 이전 페이지로_login.jsp
			script.println("</script>");
		}
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>