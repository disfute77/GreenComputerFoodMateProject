<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
<style>
.container1 {
    width: 1100px;
    height: 120px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

#sitelogo {
    width: 120px;
}

.search-bar {
    flex-grow: 1;
    margin: 0 20px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.search-bar input[type="text"] {
    width: 70%;
    height: 40px;
    padding: 0 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.search-bar button {
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

.action-buttons {
    display: flex;
    gap: 10px;
    align-items: center;
    margin-left: auto;
}

.action-buttons a {
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

/* 새로 추가한 스타일 */
.welcome-message {
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

.welcome-message .username {
    color: #ff4500; /* 사용자 이름 색 */
    font-size: 20px;
    font-weight: bold;
    text-decoration: none;
}

</style>

</head>
<body>
<div class="container1">
    <a href="${contextPath}/main"><img id="sitelogo" src="${contextPath}/resources/images/foodmatelogo.png" alt="푸드메이트로고"></a>

	<%
		String currentPath = (String) request.getAttribute("javax.servlet.forward.request_uri");
		if (currentPath == null) {
	        currentPath = request.getRequestURI();  // fallback (예외 처리)
	    }
	    String contextPath = request.getContextPath();
    	String searchAction = (currentPath.equals("/FoodMate/product/pdtlist")) ? "/product/pdtlist" : "/recipe/recipe_list";
	%>

	<form action="${contextPath}<%= searchAction %>" method="GET" class="search-bar">
	    <input type="text" name="keyword" placeholder="<%= currentPath.equals("/FoodMate/product/pdtlist") ? "식재료 검색" : "레시피 검색" %>">
	    <button type="submit"><i class="fas fa-search"></i></button>
	</form>



    <div class="action-buttons">
    	<!-- 로그인된 사용자 확인 -->
        <c:if test="${not empty sessionScope.buyerInfo}">
            <div class="welcome-message">
                <i class="fas fa-user"></i>
                <span>환영합니다, <span class="username">${sessionScope.buyerInfo.name}</span>님!</span>
                <!-- 로그아웃 버튼 추가 -->
                <a id = "myPageLink" href="${contextPath}/mypage/mypageForm" title="로그인 및 마이페이지">
            		<i class="fas fa-home"></i>
       			</a>
                <a class="logout-button" href="${contextPath}/member/logout">
                    <i class="fas fa-sign-out-alt"></i>
                </a>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.sellerInfo}">
            <div class="welcome-message">
                <i class="fas fa-shop"></i>
                <span>환영합니다, <span class="username">${sessionScope.sellerInfo.name}</span>님!</span>
                <!-- 로그아웃 버튼 추가 -->
                <a id = "myPageLink" href="${contextPath}/mypage_seller/mypage_sell_main" title="로그인 및 마이페이지">
            		<i class="fas fa-home"></i>
       			</a>
                <a class="logout-button" href="${contextPath}/member/logout">
                    <i class="fas fa-sign-out-alt"></i>
                </a>
            </div>
        </c:if>
        <c:if test="${empty sessionScope.buyerInfo and empty sessionScope.sellerInfo}">
            <a href="${contextPath}/member/loginForm" title="로그인 및 마이페이지">
                <i class="fas fa-user"></i>
            </a>
        </c:if>
        
               
       	<a id="recipeLink" href="javascript:void(0);" onclick="checkLoginAndRedirect()" title="레시피 작성">
		    <i id="write" class="fas fa-pen"></i>
		</a>
		<script type="text/javascript">
			function checkLoginAndRedirect() { 
				
			var buyerInfo = "${sessionScope.buyerInfo}";
			var sellerInfo = "${sessionScope.sellerInfo}";
		    
			if(sellerInfo != null){
				window.location.href = "${contextPath}/product/pdtaddform";
			}
			
		    if (buyerInfo == null || buyerInfo === "") {
		        console.log("현재 세션에 buyerInfo가 없습니다.");
		    } else {
		        console.log("현재 세션의 buyerInfo: " + buyerInfo);
		    }
		    // 세션에 buyerInfo가 없으면 로그인 페이지로 이동
		    var isBuyerLogOn = "${empty sessionScope.buyerInfo}";
		    var isSellerLogOn = "${empty sessionScope.sellerInfo}";
		    if (isBuyerLogOn == 'true' && isSellerLogOn == 'true') {
		        alert("로그인 후에 레시피를 작성할 수 있습니다.");
		        window.location.href = "${contextPath}/member/loginForm";
		    } else {
		        window.location.href = "${contextPath}/recipe/recipe_Add";
		    }
		}
		</script>
		
        <a id = "cartLink" href="${contextPath}/member/loginForm" title="장바구니">
            <i id ="cart" class="fas fa-shopping-cart"></i>
        </a>
    </div>
</div>
<script>
	
	let currentPage = window.location.pathname;
	
	if(${sessionScope.isBuyerLogOn ? 'true' : 'false'} == true){
		document.getElementById('recipeLink').href = "${contextPath}/recipe/recipe_Add";
		document.getElementById('cartLink').href = "${contextPath}/cart/cartlist";
		if (currentPage.includes('/product_list')) {
	        document.getElementById('write').style.display = 'none';
	        document.getElementById('recipeLink').style.display = 'none';
	    }
	}
	
	if(${sessionScope.isSellerLogOn ? 'true' : 'false'} == true){
		document.getElementById('recipeLink').href = "${contextPath}/product/pdtaddform";
		document.getElementById('recipeLink').title = "상품 등록"; //이거 추가함
	}
</script>
</body>
</html>
