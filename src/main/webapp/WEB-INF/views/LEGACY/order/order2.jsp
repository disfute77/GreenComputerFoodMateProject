<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
   	<!-- Google Fonts 사용 -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Arial', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 40px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .slider-container {
        	width: 45%;
            margin: 20px auto;
        }

        h1 {
            text-align: center;
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 30px;
        }

        .order-summary {   
            text-align: center;
            margin-bottom: 40px;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .order-summary h2,strong {
            color: #f39c12;
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        .order-summary p {
            font-size: 1.2rem;
            margin: 10px 0;
        }

        .order-summary img {
            width: 120px;
            height: 120px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 1.6rem;
            color: #333;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .info-box {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            width:48%;
        }

        .info-box .label {
            font-weight: bold;
            color: #333;
        }

        .info-box .value {
            color: #555;
        }

        .info-box img {
            width: 200px;
            height: 200px;
        }
        
        .centerd-message-box{
	        width: 100%;  /*  가로 전체 차지 */
		    text-align: center;  /*  텍스트 중앙 정렬 */
		    display: flex;
		    flex-direction: column;  /*  세로 정렬 */
		    align-items: center;  /*  가로 중앙 정렬 */
		    justify-content: center; /*  세로 정렬 */
        }

        .payment-info, .order-info, .payment-summary {
            margin-bottom: 30px;
        }
        
		/* 결제 정보 박스 스타일 */
        .payment-summary-box {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-size: 1.1rem;
        }

        table th {
            background-color: #f2f2f2;
            color: #333;
        }

        table td {
            color: #555;
        }

        /* 결제 수단 컨테이너 스타일 수정 */
        .payment-methods-container {
            width: 100%;  /* 100%로 너비 설정 */
            margin-top: 20px;
            text-align: center; /* 이미지 가운데 정렬 */
        }

        .payment-methods-container .method {
            display: inline-block;
            width: 100%;  /* 100%로 너비 설정 */
            text-align: center;
            padding: 20px 0;
            background-color: white;
            border-radius: 8px;
            border: 1px solid #ddd;
            transition: box-shadow 0.3s ease;
        }

        .payment-methods-container .method:hover {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .payment-methods-container .method img {
            width: 60px;  /* 카드 이미지 크기 설정 */
            height: 60px;
            margin-bottom: 10px;
        }

        .button-container {
            text-align: center;
            margin-top: 40px;
        }

        .button-container button {
            width: 15%;
            background-color: #f39c12;
            color: white;
            padding: 15px;
            font-size: 1.1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin: 0 10px; /* 버튼 간 여백 추가 */
        }

        .button-container button:hover {
            background-color: #e67e22;
        }
		
        .delivery-info {
            font-family: 'Roboto', sans-serif;
            font-size: 1.1rem;
            color: #555;
            line-height: 1.6;
            text-align: center;
            margin-top: 20px;
            margin-bottom: 40px;
        }
        
        .msg {
        	color: #333;
            font-size: 1.2rem;
            font-weight: 800;
        }
        .msg span {
        	color: #f39c12;
        }  
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<%
    String merchantUid = request.getParameter("merchant_uid");
%>
<body>
    <div class="container">
        <!-- 주문 완료 알림 -->
        <div class="order-summary">
            <i class="fas fa-check-circle" style="font-size: 50px; color: #f39c12;"></i>
            <h2>주문이 완료되었습니다!</h2>
            <fmt:setLocale value="ko_KR"/>
			<fmt:formatDate var="currentDate" value="<%= new java.util.Date() %>" pattern="yyyy.MM.dd" />
            <p>${currentDate} 주문하신 상품의 주문번호는 <strong>#<%= merchantUid %></strong> 입니다.</p>
        </div>

        <!-- 주문 상품 정보, 결제 정보 가로 정렬 -->
        <div class="order-info" style="display: flex; justify-content: space-between;">
			<div class="slider-container">
			<c:set var="totalPrice" value="0" />
			<c:set var="totalqty" value="0" />
			<c:set var="totalShippingFee" value="0" />
			<c:set var="uniqueNicknames" value="," />
			<c:forEach var="orderitems" items="${orderItems}">
				<c:set var="totalPrice" value="${totalPrice + (orderitems.price * orderitems.qty)}" />
				<c:set var="totalqty" value="${totalqty + orderitems.qty}" />
				<c:if test="${not fn:contains(uniqueNicknames, orderitems.nickname)}">
				        <c:set var="totalShippingFee" value="${totalShippingFee + 3000}" />
				        <c:set var="uniqueNicknames" value="${uniqueNicknames},${orderitems.nickname}" />
				    </c:if>
	            <div class="info-box">
				    <h3 class="section-title">주문 상품 정보</h3>
				    <table style="width: 100%; border-collapse: collapse;">
				        <tr>
				            <th style="text-align: left; padding: 10px; width: 35%;">상품 정보</th>
				            <td style="padding: 10px; text-align: center;">
				                <img src="${pageContext.request.contextPath}/resources/images/${orderitems.img_path}" alt="상품 이미지" style="width: 180px; height: 120px; object-fit: cover; border-radius: 8px;">
				            </td>
				        </tr>
				        <tr>
				            <th style="text-align: left; padding: 10px;">상품명</th>
				            <td style="padding: 10px;">${orderitems.pdt_name} ${orderitems.qty}개</td>
				        </tr>
				        <tr>
				            <th style="text-align: left; padding: 10px;">개별 판매가</th>
				            <td style="padding: 10px;">₩ <fmt:formatNumber value="${orderitems.price}" type="number" groupingUsed="true" /></td>
				        </tr>
						<tr>
				            <th style="text-align: left; padding: 10px;">총 구입가</th>
				            <td style="padding: 10px;">₩ <fmt:formatNumber value="${orderitems.price * orderitems.qty}" type="number" groupingUsed="true" /></td>
				        </tr>
				    </table>
				</div>
				</c:forEach>
			</div>
            <!-- 결제 정보 표 -->
            <div class="payment-summary-box" style="width: 48%;">  
                <h3 class="section-title">결제 정보</h3>
                <table>
                    <tr>
                        <th>주문 금액 (${totalqty}개)</th>
                        <td>₩ <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" /></td>
                    </tr>
                    <tr>
                        <th>포인트 사용</th>
                        <td>- ₩ <fmt:formatNumber value="${used_point}" type="number" groupingUsed="true" /></td>
                    </tr>
                    <tr>
                        <th>쿠폰 사용</th>
                        <td>- ₩ 0</td>
                    </tr>
                    <tr>
                        <th>배송비</th>
                        <td>₩ <fmt:formatNumber value="${totalShippingFee}" type="number" groupingUsed="true" /></td>
                    </tr>
                    <tr>
                        <th>결제 금액</th>
                        <td><strong>₩ <fmt:formatNumber value="${(totalPrice + totalShippingFee) - used_point}" type="number" groupingUsed="true" /></strong></td>
                    </tr>
                </table>
            </div>

        </div>

 

        <!-- 결제 수단 -->
        <c:set var="payMethod" value="${param.pay_method}" />
        <div class="payment-info">
            <h2 class="section-title">결제 수단</h2>
            <div class="payment-methods-container">
            	<div class="method selected">
            	<c:choose>
            		<c:when test="${payMethod eq 'card'}">
		                    <img src="${pageContext.request.contextPath}/resources/images/credit_card.png" alt="신용카드">
		                    <p>신용카드</p>
		            </c:when>
		            <c:when test="${payMethod eq 'vbank'}">
		                    <img src="${pageContext.request.contextPath}/resources/images/bank_transfer.png" alt="무통장입금">
		            		<p>무통장입금</p>
		            </c:when>
		            <c:when test="${payMethod eq 'trans'}">
		                    <img src="${pageContext.request.contextPath}/resources/images/account_transfer.png" alt="계좌이체">
		            		<p>계좌이체</p>
		            </c:when>
		            <c:otherwise>
		            	<p>전달된 결제 방식: ${payMethod}</p>
		            	
						<p>비교실패</p>
			        </c:otherwise>
	            </c:choose>
	            </div>
            </div>
        </div>

        <!-- 배송 안내 -->
		<div class="info-box centerd-message-box" style="display: flex; align-items: center;">
		    <i class="fas fa-utensils" style="font-size: 70px; color: #f39c12; margin-right: 25px;"></i>
		    
		    <div>
		        <p class="msg">주문한 상품은 빠른 시일 내로 배송될 예정입니다.</p>
		        <p class="msg"><span>FOODMATE</span>를 이용해 주셔서 감사합니다.</p>
		    </div>
		</div>
		

        <!-- 버튼 -->
        <div class="button-container">
            <button onclick="window.location.href='${contextPath}/product/pdtlist'">상품 목록<br>으로 이동</button>
            <button onclick="window.location.href='${contextPath}/mypage/ShoppingManage/orderlist'">주문/배송<br>상태 확인</button>
        </div>
    </div>
</body>
    <script>
        $(document).ready(function(){
            $('.slider-container').slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                autoplay: true
            });
        });
    </script>
</html>
