<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />  
<html>
<head>
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/pdtaddform.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var contextPath = "${contextPath}";
console.log(contextPath);

$(document).ready(function() {
    var lastCategoryId = null;  // 마지막 선택된 카테고리 ID

    // 1단계 카테고리 선택 시
    $('#category_1').on('change', function() {
        var selectedCategory = $(this).val();
        console.log(selectedCategory);

        // 이전 하위 카테고리 초기화
        $('#category_container').empty();

        if (selectedCategory) {
            lastCategoryId = selectedCategory;
            loadSubCategories(selectedCategory, 2);
        }
    });

 	// 하위 카테고리 로드 함수
    function loadSubCategories(parentCategoryId, level) {
        var url = contextPath + '/product/getSubCategories/' + parentCategoryId;
        console.log(url);

        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                if (data.length > 0) {
                    var select = $('<select>')
                        .attr('name', 'category_' + level)
                        .attr('id', 'category_' + level);

                    select.append($('<option>').attr('value', '').text(level + '단계분류'));

                    $.each(data, function(index, category) {
                        select.append($('<option>').attr('value', category.category_id).text(category.name));
                    });

                    $('#category_container').append(select);

                    select.on('change', function() {
                        var selectedSubCategory = $(this).val();
                        if (selectedSubCategory) {
                            lastCategoryId = selectedSubCategory;
                            $('#category_' + (level + 1)).remove();
                            loadSubCategories(selectedSubCategory, level + 1);

                            // 선택된 카테고리의 recommend_unit 찾기
                            var selectedCategory = data.find(category => category.category_id == selectedSubCategory);
                            if (selectedCategory && selectedCategory.recommend_unit) {
                                $('#unit').val(selectedCategory.recommend_unit);
                            } else {
                                $('#unit').val(''); // 값이 없으면 초기화
                            }
                        }
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error('자식 카테고리 로드 실패:', error);
            }
        });
    }

    // 마지막 선택된 카테고리 ID 반환
    function getLastCategoryId() {
        return lastCategoryId;
    }

    // 폼 제출 이벤트(공개)
    $('#submit_public').on('click', function(event) {
        event.preventDefault();

        // 마지막 카테고리 ID를 hidden input에 설정
        $('#category_id').val(getLastCategoryId());

        // 폼 제출
        $("form").submit();
    });
    
    // 폼 제출 이벤트(비공개)
    $('#submit_hide').on('click', function(event) {
        // 마지막 카테고리 ID를 hidden input에 설정
        $('#category_id').val(getLastCategoryId());
        $('#status').val('N');

        // 폼 제출
        $("form").submit();
    });
    
    
    
});
</script>

</head>

<c:set var="pdt" value="${ProductDTO}"/>

<body>
<main class="bodywrapper">
<article class="form-container">
	<form action="${contextPath}/product/pdtedit" method="POST" enctype="multipart/form-data">
	<div id="task_Name">상품 수정</div>
	    <div class="form-Box">
			<div class="form-Leftbox">
				<div class="row">
				<label for="productName">상품 이름</label>
				<input type="text" id="pdt_Name" name="name" value="${pdt.name}">
				</div>
			
				<div class="row">
				<label for="productPrice">상품 가격 (₩)</label>
				<input type="text" id="pdt_Price" name="price" value="${pdt.price}">
				</div>
			 
				<div class="row">
				<label for="productDescription">상품 설명</label>
				<textarea id="pdt_Dscrpt" name="description" rows="4" required>${pdt.description}</textarea>
				</div>
	
				<div class="row">
				<label for="category">카테고리</label>
					<select name="category_1" id="category_1">
					    <option value="" disabled selected>1단계분류</option>
					    <c:forEach var="category" items="${categories}">
					        <option value="${category.category_id}">${category.name}</option>
					    </c:forEach>
					</select>
					&#8251;카테고리를 정확히 설정해야 구매자에게 상품이 노출될 확률이 올라갑니다.
					<div id="category_container"></div> <!-- 자식 카테고리들을 넣을 div -->

				</div>
				<input type="hidden" id="pdt_id" name="pdt_id" value="${pdt.pdt_id }">
				<input type="hidden" id="category_id" name="category_id" value="${pdt.category_id}">
				<input type="hidden" id="status" name="status" value="${pdt.status}">
				
				<div class="row">
				<label for="productWeight">묶음당 수량 또는 무게</label>
				<input type="number" id="pdt_Weight" name="qty" value="${pdt.qty}">
				</div>
			 
				<div class="row">
				<label for="unit">무게 또는 단위</label>
				<input type="text" id="unit" name="unit" value="${pdt.unit}">
				&#8251;카테고리 선택 시 제공되는 단위를 사용해야 상품이 구매자에게 자주 노출됩니다.<br>
				만약 정확한 카테고리가 없거나, 단위가 적절하지 않을 시 관리자에게 문의해 주세요.
				</div>
				
				<div class="row">
				<label for="stock">재고</label>
				<input type="number" id="stock" name="stock" value="${pdt.stock}">
				</div>
				
			</div>
      
		<div class="form-Rightbox">
			<div class="row">
				<label for="introImage">상품 이미지</label>
				<input type="file" id="pdt_img" name="pdt_img" accept="image/*" required>
				상품 이미지를 변경할 때만 입력!!
			</div>
			
<!-- 			<div class="row"> -->
<!-- 				<label for="introImage">소개 이미지</label> -->
<!-- 				<input type="file" id="pdt_DscImg" name="pdt_DscImg" accept="image/*" required> -->
<!-- 			</div> -->
<!-- 소개 이미지는 나중에 만들거야 -->
		</div>
		
		</div>
		
		<div class="row">
	        <button type="button" id="submit_hide">상품 등록</button>
	        <button type="submit" id="submit_public">상품 등록 후 공개</button>
	        <button type="button" id="cancel" onclick="window.history.back();">취소</button>
	    </div>
	</form>
	
</article>
</main>
</body>
</html>