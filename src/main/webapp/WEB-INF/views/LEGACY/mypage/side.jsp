<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" ></script>
<head>
<meta charset="UTF-8">
<title>사이드 메뉴</title>
</head>
    <style>
        .sidebar {
            background-color: #f8f9fa;
            height: 100%;
            padding: 20px;
            border-right: 1px solid #ddd;
        }
        .sidebar h3 {
            color: #74b243;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .sidebar h3 a {
		    color: #74b243; /* 기본 텍스트 색상 */
		    text-decoration: none; /* 링크의 밑줄 제거 */
		}
        .sidebar a {
            display: block;
            margin: 10px 0;
            color: #87c058;
            text-decoration: none;
        }
        .sidebar a:hover {
            color: #87c058;
            text-decoration: underline;
        }
    </style>
<body>
    <div class="col-12 sidebar">
        <h3><a href="${contextPath}/mypage/mypageForm">마이페이지</a></h3>
        <hr>
        <h5>메이트관리</h5>
        <ul>
	        <li><a href="${contextPath}/mypage/mateManage/myrecipeForm">내 레시피</a></li>
	        <li><a href="${contextPath}/mypage/mateManage/myrecipereviewForm">레시피 리뷰</a></li>	
	        <li><a href="${contextPath}/mypage/mateManage/myShoppingReviewForm">쇼핑 리뷰</a></li>
        </ul>
        <hr>
        <h5>내 정보관리</h5>
        <ul>
	        <li><a href="${contextPath}/mypage/myInfoManage/profileEditForm">프로필 수정</a></li>
	        <li><a href="${contextPath}/mypage/myInfoManage/memberEditForm">회원정보 수정</a></li>
	        <li><a href="${contextPath}/mypage/myInfoManage/deliveryManageForm">배송지 관리</a>
        </ul>
        <hr>
        <h5>쇼핑 관리</h5>
        <ul>
	        <li><a href="${contextPath}/mypage/ShoppingManage/orderlist">주문목록/배송조회</a></li>
	        <li><a href="${contextPath}/mypage/ShoppingManage/canclelistrequestManageForm">반품/교환 내역</a></li>
	        <li><a href="${contextPath}/mypage/ShoppingManage/refundManageForm">환불/입금 내역</a></li>
	        <li><a href="${contextPath}/mypage/ShoppingManage/wishlistManageForm">찜 리스트</a></li>
        </ul>
        <hr>
        <h5>혜택관리</h5>
        <ul>
	        <li><a href="#" onclick="alert('서비스 준비 중입니다.'); return false;">쿠폰</a></li>
	        <li><a href="${contextPath}/mypage/rewardManage/pointManageForm">포인트</a></li>
        </ul>
        <hr>
        <h5>고객센터</h5>
        <ul>
	        <li><a href="${contextPath}/support/inquiryLists">1:1 문의</a></li>
	        <li><a href="${contextPath}/mypage/customerManage/cancleAccountForm">회원 탈퇴</a></li>
        </ul>
    </div>
</body>
</html>