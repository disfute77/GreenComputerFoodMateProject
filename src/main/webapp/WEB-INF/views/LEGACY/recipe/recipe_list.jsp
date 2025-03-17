<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>레시피 목록</title>

	<!-- jQuery, Slick, Swiper 포함 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />

<!-- Swiper CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />

<style>
.recipe-image {
    background-color: #ccc;
    width: 100%;
    height: 150px;
    display: flex;
    border-radius: 8px;
    justify-content: center;
    align-items: center;
    color: #777;
    font-size: 20px;
}

.image-wrapper {
    width: 100%; /* 또는 원하는 고정 크기 */
    height: 100%; /* 이미지 크기를 부모 div 안에 맞추기 */
    display: flex;
    justify-content: center;
    align-items: center;
}

.recipe-image img {
    width: 100%;
    height: 100%;
    object-fit: cover; /* 이미지 비율을 유지하며 잘라내기 */
    border-radius: 8px;
}

.recipe-card {
    display: flex;
    flex-direction: column;
    justify-content: space-between; 
    margin-bottom:20px;
}

.recipe-title {
    font-size: 1.2rem;
    font-weight: bold;
    color: #333;
    white-space: nowrap;      /* 텍스트가 한 줄로 유지되도록 바꿧음 */
    overflow: hidden;         /* 넘치는 텍스트는 잘리게 설정 */
    text-overflow: ellipsis;  /* 잘린 텍스트에 '...' 이거밖에모름 */
    width: 100%;              
    display: inline-block;    
    max-width: 100%;          /* 텍스트가 일정 범위를 넘지 않도록  */
}

.recipe-info {
    font-size: 0.9rem;
    color: #666;
}

/* 최근 본 레시피 제목 스타일 */
.mt-5 {
    display: flex;
    flex-direction: column; 
    margin-bottom: 20px;
}

.mt-5 > strong {
    font-size: 1.8rem;
    font-weight: bold;
    margin: 0 auto;
    margin-bottom: 40px;
}

/* Swiper 슬라이드 컨테이너 크기 조정 */
.swiper-container {
    width: 100%; 
    max-width: 1500px;  /* 최대 폭을 늘려서 공간을 확보 */
    margin: 0 auto;  /* 가운데 정렬 */
    overflow: hidden;
    display: flex;  
}

.swiper-wrapper {
    display: flex;
    gap: 5px;  /* 슬라이드 간격을 조금 더 넓힘 */
}

.recipe-item {
    width: 250px;  
    height: 200px; 
    display: flex;
    flex-direction: column;
}

/*▲여기까지 */
.pagination {
    justify-content: center;
    margin-top: 20px;
}


.btn {
    background-color: #f39c12;
    border:none;
    color: white;
    border-radius: 8px;
    padding: 5px 10px;
    font-size: 18px;
    text-decoration: none; 
    display: inline-block;
}

.btn:hover {
    background-color: #e67e22;
}

.btn:active {
    background-color: #e67e22 !important; 
    border-color: #e67e22 !important;
}


@media ( max-width : 767px) {
    .recipe-card {
        margin-bottom: 15px;
    }
}

.pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.pagination a {
    margin: 0 5px;
    padding: 8px 12px;
    background-color: #bbb;
    color: white;
    text-decoration: none;
    border-radius: 5px;
}

.pagination a:hover {
    background-color: #999;
}

.pagination .active {
    background-color: #999;
    font-weight: bold;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.left-section {
    display: flex;
    flex-direction: column;
}

.search-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
}

.search-container input[type="text"] {
    padding: 8px 12px;
    width: 300px;
    margin-left: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.search-container button {
    padding: 8px 12px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 10px;
}

.search-container button:hover {
    background-color: #0056b3;
}

    .category-section {
        padding: 30px;
        background-color: #f7f7f7;
        border-radius: 15px;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        margin-top: 40px;
        text-align: center;
    }

    .category-container {
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
        gap: 30px;
    }

    .category-card {
        background-color: #fbe28a;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        padding: 25px;
        width: 70%;
        min-width: 350px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        cursor: pointer;
    }

    .category-card h5 {
        font-size: 1.8rem;
        font-weight: 800;
        color: #e67e22;
        margin-bottom: 30px;
    }

    .category-content {
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
        gap: 20px;
    }

    .category-category {
        text-align: left;
    }
    
    .category-category h6 a {
		color: #f39c12;
		font-size: 1.2rem;
		font-weight: 800;
		margin-bottom: 10px;
		text-decoration:none;
		text-transform: uppercase;
    }
    
    .category-category a:hover {
            color: #d57e13;
        }

    .category-category ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .category-category ul li {
        font-size: 1rem;
        color: #777;
    }

    .category-category ul li a {
        color: #fff;
        text-decoration: none;
        font-weight: 800;
        transition: color 0.3s ease;
    }

    .category-category ul li a:hover {
        color: #e67e22;
        text-decoration: none;
    }

    .category-card:hover {
        transform: scale(1.05);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
    }

@media (max-width: 1024px) {
    .category-card {
        width: 100%;
    }
}

@media (max-width: 767px) {
    .category-card {
        width: 100%;
    }
}




</style>

</head>
<%-- 현재 페이지 정보 가져오기 (기본값: 1페이지) --%>
<c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
<c:set var="itemsPerPage" value="8" />
<c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" />
<c:set var="endIndex" value="${currentPage * itemsPerPage}" />

<%-- 전체 데이터 개수 구하기 --%>
<c:set var="totalItems" value="${fn:length(recipeList)}" />
<fmt:parseNumber var="parsedTotalPages" value="${(totalItems + itemsPerPage - 1) / itemsPerPage}" integerOnly="true" />
<c:set var="totalPages" value="${parsedTotalPages}" />
<body>

<div class="category-section mt-4">
    <div class="category-container">
        <!-- 모든 카테고리를 한 박스에 담기 -->
        <div class="category-card">
            <h5>원하는 레시피를 찾아보세요!</h5>
            <div class="category-content">
                <!-- 한식 카테고리 -->
                <div class="category-category">
                    <h6><a href="${contextPath}/recipe/recipe_list?categoryId=1">🥘한식</a></h6> <!-- 대분류 ID = 1 -->
                    <ul>
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=5&parent_Id=1">국/찌개</a></li> <!-- 카테고리 ID = 5, 부모 ID = 1 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=6&parent_Id=1">구이</a></li> <!-- 카테고리 ID = 6, 부모 ID = 1 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=7&parent_Id=1">전/부침</a></li> <!-- 카테고리 ID = 7, 부모 ID = 1 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=8&parent_Id=1">볶음류</a></li> <!-- 카테고리 ID = 8, 부모 ID = 1 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=9&parent_Id=1">조림/찜류</a></li> <!-- 카테고리 ID = 9, 부모 ID = 1 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=10&parent_Id=1">반찬류</a></li> <!-- 카테고리 ID = 10, 부모 ID = 1 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=11&parent_Id=1">면류</a></li> <!-- 카테고리 ID = 11, 부모 ID = 1 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=12&parent_Id=1">전통 디저트</a></li> <!-- 카테고리 ID = 12, 부모 ID = 1 -->
                    </ul>
                </div>

                <!-- 양식 카테고리 -->
                <div class="category-category">
                    <h6><a href="${contextPath}/recipe/recipe_list?categoryId=2">🍽️양식</a></h6> <!-- 대분류 ID = 2-->
                    <ul>
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=13&parent_Id=2">스테이크</a></li> <!-- 카테고리 ID = 13, 부모 ID = 2 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=14&parent_Id=2">파스타</a></li> <!-- 카테고리 ID = 14, 부모 ID = 2 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=15&parent_Id=2">피자</a></li> <!-- 카테고리 ID = 15, 부모 ID = 2 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=16&parent_Id=2">수프</a></li> <!-- 카테고리 ID = 16, 부모 ID = 2 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=17&parent_Id=2">리조또</a></li> <!-- 카테고리 ID = 17, 부모 ID = 2 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=18&parent_Id=2">오믈렛</a></li> <!-- 카테고리 ID = 18, 부모 ID = 2 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=19&parent_Id=2">샌드위치/버거</a></li> <!-- 카테고리 ID = 19, 부모 ID = 2 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=20&parent_Id=2">치킨 요리</a></li> <!-- 카테고리 ID = 20, 부모 ID = 2 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=21&parent_Id=2">디저트</a></li> <!-- 카테고리 ID = 21, 부모 ID = 2 -->
                    </ul>
                </div>

                <!-- 일식 카테고리 -->
                <div class="category-category">
                    <h6><a href="${contextPath}/recipe/recipe_list?categoryId=3">🍣일식</a></h6> <!-- 대분류 ID = 3 -->
                    <ul>
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=22&parent_Id=3">회</a></li> <!-- 카테고리 ID = 22, 부모 ID = 3 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=23&parent_Id=3">스시</a></li> <!-- 카테고리 ID = 23, 부모 ID = 3 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=24&parent_Id=3">라멘</a></li> <!-- 카테고리 ID = 24, 부모 ID = 3 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=25&parent_Id=3">전골</a></li> <!-- 카테고리 ID = 25, 부모 ID = 3 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=26&parent_Id=3">튀김</a></li> <!-- 카테고리 ID = 26, 부모 ID = 3 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=27&parent_Id=3">덮밥</a></li> <!-- 카테고리 ID = 27, 부모 ID = 3 -->
                    </ul>
                </div>

                <!-- 중식 카테고리 -->
                <div class="category-category">
                    <h6><a href="${contextPath}/recipe/recipe_list?categoryId=4">🍜중식</a></h6> <!-- 대분류 ID = 4 -->
                    <ul>
                    	<li><a href="${contextPath}/recipe/recipe_list?categoryId=28&parent_Id=4">볶음밥</a></li> <!-- 카테고리 ID = 28, 부모 ID = 3 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=29&parent_Id=4">딤섬</a></li> <!-- 카테고리 ID = 29, 부모 ID = 3 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=30&parent_Id=4">해물</a></li> <!-- 카테고리 ID = 30, 부모 ID = 4 -->
                        <li><a href="${contextPath}/recipe/recipe_list?categoryId=31&parent_Id=4">육류</a></li> <!-- 카테고리 ID = 31, 부모 ID = 4 -->
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container mt-4">
    <div class="mb-3 text-end">                          	<!-- param값 sort로 불러올 목록 정렬 분류 -->
		<a href="${pageContext.request.contextPath}/recipe/recipe_list?sort=latest" class="btn btn-outline-primary me-2">최신순</a>
		<a href="${pageContext.request.contextPath}/recipe/recipe_list?sort=rating" class="btn btn-outline-primary me-2">평점순</a>
    </div>

    <div class="row">
       
        <c:forEach var="recipe" items="${recipeList}">
            <div class="col-md-3 col-sm-6">
                <a href="${contextPath}/recipe/recipe_Detail?rcp_id=${recipe.rcp_id}" class="text-decoration-none">
                    <div class="card recipe-card">
                        <div class="recipe-image">
                            
                            <img src="${contextPath}/resources/images/${recipe.mainimg_path}" alt="Recipe Image" class="img-fluid">
                        </div>
                        <div class="card-body">
                            
                            <h5 class="recipe-title">${recipe.title}</h5>
                            <p class="recipe-info">
							    <!-- 작성자 -->
							    작성자: ${recipe.nickname} <br>                                
							    <c:choose>
							        <c:when test="${recipe.rating > 0}">
							            평점: ${recipe.rating}
							        </c:when>
							        <c:otherwise>
							            평점: 미등록
							        </c:otherwise>
							    </c:choose>
							    <br> 
							    조리시간: ${recipe.req_time}
							</p>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>

	<div class="pagination">
	    <!-- 이전 페이지 -->
	    <c:if test="${currentPage > 1}">
	        <a href="?page=${currentPage - 1}">Prev</a>
	    </c:if>
	
	    <!-- 동적 페이지 생성 -->
	    <c:forEach var="i" begin="1" end="${totalPages}">
	        <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
	    </c:forEach>
	
	    <!-- 다음 페이지 -->
	    <c:if test="${currentPage < totalPages}">
	        <a href="?page=${currentPage + 1}">Next</a>
	    </c:if>
	</div>
</div>



	<!-- 최근 본 레시피 제목과 레시피 아이템 -->
	<div class="mt-5">
	    <strong>🏷️ 최근 본 레시피</strong>
	    <c:if test="${not empty recentRecipeList}">
	        <!-- Swiper 컨테이너로 최근 본 레시피 출력 -->
	        <div class="swiper-container">
	            <div class="swiper-wrapper">
	                <c:forEach var="recipe" items="${recentRecipeList}">
	                    <div class="swiper-slide">
	                        <div class="recipe-item">
	                            <a href="${contextPath}/recipe/recipe_Detail?rcp_id=${recipe.rcp_id}" class="text-decoration-none">
	                                <div class="recipe-image">
	                                    <div class="image-wrapper">
	                                        <img src="${contextPath}/resources/images/${recipe.mainimg_path}" alt="Recipe Image">
	                                    </div>
	                                </div>
	                                <h6 class="recipe-title">${recipe.title}</h6>
	                            </a>
	                        </div>
	                    </div>	                    
	                </c:forEach>
	            </div>
	        </div>
	    </c:if>
	
	    <!-- 최근 본 레시피가 없을 경우 -->
	    <c:if test="${empty recentRecipeList}">
	        <strong>최근 본 레시피가 없습니다.</strong>
	    </c:if>
	</div>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
const swiper = new Swiper(".swiper-container", {
    slidesPerView: 'auto',  // 슬라이드 수를 자동으로 조정
    spaceBetween: 20,  // 슬라이드 간격

    breakpoints: {
        1024: {
            slidesPerView: 4, 
        },
        768: {
            slidesPerView: 2, 
        },
        480: {
            slidesPerView: 1,
        }
    }
});


</script>


</body>
</html>