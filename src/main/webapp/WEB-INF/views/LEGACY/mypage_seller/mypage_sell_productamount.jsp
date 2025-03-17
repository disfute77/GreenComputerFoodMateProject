<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고관리</title>
<link href="<c:url value="/resources/css/tablepage.css" />" rel="stylesheet">
<style>
    .table-custom {
        border-top: 2px solid #b5b6b7 !important;
    }
    /* 헤더 배경색 */
    .table-header {
        background-color: #f8f9fa;
        text-align: center;
        font-weight: bold;
        min-width: 20%;
    }
    .table td:last-child {
        min-width: 100px; /* 최소 너비 지정 */
        text-align: center; /* 텍스트 중앙 정렬 */
    }
    /* 내용 텍스트 정렬 */
    .table tbody td {
        vertical-align: middle;
        text-align: center;
    }
    th:first-child, td:first-child {
        width: 5%; /* 체크박스 열의 폭 */
    }
    /* 공개여부 일괄변경 버튼 스타일 */
    .batch-change-btn {
        float: right;
        margin-bottom: 15px;
        padding: 10px 15px;
        font-size: 1rem;
        color: white;
        background-color: #007bff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .batch-change-btn:hover {
        background-color: #0056b3;
    }
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

const contextPath = '${contextPath}';
$(document).on("click", ".btn-stockchange", function() {
    let pdtId = $(this).data("pdt-id"); // 상품 ID 가져오기
    let stockInput = $(this).prev("input"); // 해당 버튼 앞에 있는 입력 필드 찾기
    let newStock = stockInput.val(); // 입력된 재고 값 가져오기

    // 입력값 검증
    if (newStock < 0) {
        alert("재고는 0 이상이어야 합니다.");
        stockInput.val(stockInput.data("original-stock")); // 원래 값으로 되돌리기
        return;
    }

    if (isNaN(newStock)) {
        alert("올바른 숫자를 입력하세요.");
        stockInput.val(stockInput.data("original-stock")); // 원래 값으로 되돌리기
        return;
    }

    $.ajax({
        type: "POST",
        url: contextPath + "/product/updateStock", // 서버에서 처리할 URL
        data: { pdt_id: pdtId, stock: newStock }, // 상품 ID와 변경된 재고 값 전송
        success: function(response) {
            if (response.success) {
                alert("재고가 변경되었습니다.");
                location.reload(); // 변경된 정보 새로고침
            } else {
                alert(response.message || "재고 변경에 실패했습니다.");
            }
        },
        error: function() {
            alert("오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
});

// 상품 판매상태 변경
$(document).on('click', '.btn-changestat', function() {
    var pdtId = $(this).data('pdt-id');  // pdt_id 가져오기
    var currentStatus = $(this).data('status');  // 현재 상태 확인

    // AJAX 요청
    $.ajax({
        type: "POST",
        url: contextPath + "/product/changeStat",  // 요청 주소
        data: {
            pdt_id: pdtId,
            status: currentStatus  // 상태 값 (Y 또는 N)
        },
        success: function(response) {
            if (response.success) {
                // 상태 변경이 성공하면 새로고침
            	var newStatusText = (currentStatus === 'Y') ? '판매 중지됨' : '판매 중';
                alert("판매 상태가 변경되었습니다.");
                location.reload();
            } else {
                alert("상태 변경에 실패했습니다.");
            }
        },
        error: function() {
            alert("오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
});


</script>

</head>
<body>
<div class="container mt-1">
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
        <h5 class="mt-2 mb-0 fw-bold">상품 재고관리/공개설정</h5>
    </div>
    
    <!-- 공개여부 일괄변경 버튼 -->
<!--     <div> -->
<!--         <button class="batch-change-btn">공개여부 일괄변경</button> -->
<!--     </div> -->
    
    <table class="table table-hover table-custom">
        <thead class="table-header table-secondary">
            <tr>
                <th><input type="checkbox" id="select-all" /></th>
                <td>상품ID</td>
                <td>상품 대표이미지</td>
                <td>상품명</td>
                <td>재고수</td>
                <td>대기주문수</td>
                <td>공개여부</td>
            </tr>
        </thead>
        <tbody>
        
<c:choose>
<c:when test="${empty list}">
	<p>표시할 내용이 없습니다.</p>
</c:when>
<c:otherwise>
<c:forEach var="product" items="${list}">
        
            <tr>
                <td><input type="checkbox" name="product-check" /></td>
                <td>${product.pdt_id}</td>
                <td>
                    <img src="${contextPath}/resources/images/${product.img_path}" alt="pdt_img" class="img-fluid rounded" style="width: 150px; height: 150px; object-fit: cover;">
                </td>
                <td>${product.name}</td>
                <td>
				    <input type="text" class="form-control form-control-sm" value="${product.stock}" min="0" style="width: 80px; display: inline-block;" />
				    <button class="btn btn-outline-secondary btn-sm btn-stockchange" data-pdt-id="${product.pdt_id}">변경</button>
				</td>
				<td>${product.ord_count}건</td>
                <td>
                ${product.status == 'Y' ? '판매 중' : '판매 중지됨'}
                <button class="btn btn-outline-secondary btn-sm btn-changestat" data-pdt-id="${product.pdt_id}" data-status="${product.status}">변경</button>
                </td>
            </tr>

</c:forEach>
</c:otherwise>
</c:choose>
           
        </tbody>
    </table>
    
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <li class="page-item">
                <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">Prev</span>
                </a>
            </li>
            <li class="page-item active" aria-current="page">
                <a class="page-link" href="#">1</a>
            </li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">4</a></li>
            <li class="page-item"><a class="page-link" href="#">5</a></li>
            <li class="page-item"><a class="page-link" href="#">6</a></li>
            <li class="page-item"><a class="page-link" href="#">7</a></li>
            <li class="page-item"><a class="page-link" href="#">8</a></li>
            <li class="page-item"><a class="page-link" href="#">9</a></li>
            <li class="page-item"><a class="page-link" href="#">10</a></li>
            <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">Next</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
</body>
</html>
