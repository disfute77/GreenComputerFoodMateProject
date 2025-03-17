<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

<style>
header {
    width: 1100px;
    height: 120px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

header #sitelogo {
    width: 120px;
}

header .search-bar {
    flex-grow: 1;
    margin: 0 20px;
    display: flex;
    align-items: center;
    justify-content: center;
}

header .search-bar input[type="text"] {
    width: 70%;
    height: 40px;
    padding: 0 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

header .search-bar button {
    height: 40px;
    width: 50px;
    background-color: #fa9820;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}

header .action-buttons {
    display: flex;
    gap: 10px;
    align-items: center;
    margin-left: auto;
}

header .action-buttons a {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #ccc;
    border-radius: 50%;
    text-decoration: none;
    color: black;
    font-size: 18px;
    background-color: #f9f9f9;
}

header .welcome-message {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    font-weight: bold;
    color: #fa9820; /* 환영 메시지 색 */
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 10px;
    gap: 10px;
}

header .welcome-message .username {
    color: #ff4500; /* 사용자 이름 색 */
    font-size: 20px;
    font-weight: bold;
    text-decoration: none;
}

</style>

</head>
<body>
<header>
    <a href="${contextPath}/main">
    <img id="sitelogo" src="${contextPath}/resources/images/foodmatelogo.png" alt="FoodMate_Logo">
    </a>

	<form class="search-bar">
	    <input type="text" name="keyword" placeholder="검색어를 입력하세요">
	    <button type="submit"><i class="fas fa-search"></i></button>
	</form>

    <div class="action-buttons">
    	<c:choose>
    	
        <c:when test="${not empty sessionScope.sessionDTO}">
            <div class="welcome-message">
                <i class="fas fa-user"></i>
               	<span class="username">${sessionScope.sessionDTO.userName}</span>님
               	
				<c:when test="${sessionScope.sessionDTO.userRole == 'buyer'}">
					<a id="myPageLink" href="${contextPath}/mypage/main" title="마이페이지">
	            		<i class="fas fa-home"></i>
	       			</a>
				</c:when>
				<c:when test="${sessionScope.sessionDTO.userRole == 'seller'}">
					<a id = "myPageLink" href="${contextPath}/mypage_seller/main" title="판매자 마이페이지">
	            		<i class="fas fa-home"></i>
	       			</a>	
				</c:when>
               	
                <a class="logout-button" href="${contextPath}/member/logout">
                    <i class="fas fa-sign-out-alt"></i>
                </a>
            </div>
        </c:when>
        
        <c:otherwise>
		<a href="${contextPath}/member/loginform" title="로그인">
		    <i class="fas fa-user"></i>
		</a>
		
		<a id="recipeLink" href="${contextPath}/recipeform" title="레시피 작성">
		    <i id="write" class="fas fa-pen"></i>
		</a>

		
        <a id = "cartLink" href="${contextPath}/cart" title="장바구니">
            <i id ="cart" class="fas fa-shopping-cart"></i>
        </a>
        </c:otherwise>
        
        </c:choose>        
	</div>

</header>

</body>
</html>
