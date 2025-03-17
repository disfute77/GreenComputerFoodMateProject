<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<title>${title}</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<c:choose>
<c:when test="${smallHeader}">
	<%@ include file="header_small.jsp" %>
</c:when>
<c:otherwise>
	<%@ include file="header.jsp" %>
</c:otherwise>
</c:choose>    

<c:if test="${empty hideNavbar}">
    <%@ include file="navbar.jsp" %>
</c:if>

<c:if test="${showSidebar}">
	<jsp:include page="${sidebar}" />
</c:if>

<!-- 사이드바 유무에 따라 바디위치를 바꿔야 하는가? -->
<main>
	<jsp:include page="${body}" />   
</main>

<c:choose>
<c:when test="${smallFooter }">
	<%@ include file="footer_small.jsp" %>
</c:when>
<c:otherwise>
	<%@ include file="footer.jsp" %>
</c:otherwise>
</c:choose>

</body>
</html>