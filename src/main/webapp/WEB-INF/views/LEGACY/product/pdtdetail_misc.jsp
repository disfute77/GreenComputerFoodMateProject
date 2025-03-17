<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />  

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 상세 페이지</title>
<style>
	#wrapper {
	  margin: 10px auto;
	  max-width: 1200px;
	}
	
    /* 부모 컨테이너 */
    .tab-container {
        display: flex; /* 수평 배치를 위한 flex 사용 */
        width: 1200px; /* 고정 폭 */
        margin: 100px auto; /* 가운데 정렬 */
        background-color: #dbdbdb; /* 탭 배경색 */
        border-top: 2px solid black; /* 위쪽 검은선 */
        border-left: 1px solid black; /* 좌측 검은선 */
        border-right: 1px solid black; /* 우측 검은선 */
    }

    /* 각각의 탭 */
    .tab {
        flex: 1; /* 모든 탭이 동일한 너비를 가짐 */
        font-family: "Noto Sans KR", serif;
        font-size: 1rem;
        font-weight: 500;
        text-align: center; /* 텍스트 가운데 정렬 */
        line-height: 2.5rem; /* 탭 높이 조정 */
        border-right: 1px solid black; /* 각 탭 사이에 경계선 */
        padding: 5px 0 5px;
        cursor: pointer;
/*         display: flex; */
/*         justify-content: center; */
/*         align-items: center; */
    }

    .tab:last-child {
        border-right: none; /* 마지막 탭의 우측 경계선 제거 */
    }

    .tab.active {
        background-color: #ccc; /* 활성화된 탭 강조 */
        font-weight: bold;
        color: #000;
    }

    /* 탭 콘텐츠 */
    .tab-content {
        display: none; /* 기본적으로 모든 탭 내용은 숨김 */
        padding: 20px;
        border-top: 2px solid #dbdbdb;
    }

    /* 탭 컨텐츠 활성화 시 표시 */
    .tab-content.active {
        display: block;
    }

    #tabContent1 img {
    	margin: 10px auto;
    	width: 100%;
    }
    
    /* #tabContent2 내부의 모든 리뷰 컨테이너 */
#tabContent2 .review {
    background-color: #f9f9f9;
    border: 1px solid #e2e2e2;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 15px;
    font-family: Arial, sans-serif;
}

/* #tabContent2 내부의 리뷰 작성자와 날짜 표시 */
#tabContent2 .review-header {
    display: flex;
    justify-content: space-between;
    font-size: 14px;
    color: #555;
    margin-bottom: 10px;
}


#tabContent2 .review-author {
    font-weight: bold;
}

/* #tabContent2 내부의 날짜 */
#tabContent2 .review-date {
    color: #888;
}

/* #tabContent2 내부의 별점 영역 */
#tabContent2 .review-rating {
    margin: 10px 0;
}

#tabContent2 .stars {
    color: #f39c12;  /* 별점 색상 */
    font-size: 18px;
}

/* #tabContent2 내부의 댓글 내용 */
#tabContent2 .review-comments {
    font-size: 16px;
    color: #333;
    line-height: 1.5;
}

/* #tabContent2 내부의 별 모양을 위한 스타일 */
#tabContent2 .stars {
    display: inline-block;
}

#tabContent2 .stars span {
    font-size: 20px;
    color: #f39c12;
}

    
</style>

<% String pdt_id = request.getParameter("pdt_id"); %>
<!-- pdtdetail에서 넘겨준 상품id 쓸수있게 준비 -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

$(document).ready(function() { // 페이지가 준비되면
	
    const pdt_id = "<%=pdt_id%>";
    const contextPath = "${contextPath}";
    
    // 상품 설명 데이터 로드
    $.ajax({
        url: contextPath + "/product/miscDescription",  // 서버로 Ajax 요청
        type: "GET",
        data: { pdt_id: pdt_id },
        success: function(response) {
            $("#tabContent1").html(response);  // 받은 데이터를 화면에 표시
        },
        error: function() {
            alert("상품 설명 이미지를 불러오는 데 실패했습니다.");
        }
    });
    
    // 상품 후기 데이터 로드
    $.ajax({
    	url: contextPath + "/product/pdtreviews",  // 서버로 Ajax 요청
    	type: "GET",
    	data: { pdt_id: pdt_id },
    	success: function(response) {
    		$("#tabContent2").html(response); // 받은데이터 탭콘2에 표시
    	}, error: function() {
    		alert("상품 후기를 불러오는 데 실패했습니다.");
    	}
    });
    
}); // 여기까지 페이지가 준비되면 할것들
 
</script>

</head>
<body>
<section id = "wrapper">

<article class="tab-container">
    <div class="tab" id="tab1">상품상세설명</div>
    <div class="tab" id="tab2">상품후기</div>
    <div class="tab" id="tab3">상품문의</div>
    <div class="tab" id="tab4">교환/반품문의</div>
</article>

<!-- 각 탭의 내용 -->
<article id="tabContent1" class="tab-content">

</article>

<!-- 상품 후기 탭 -->
<article id="tabContent2" class="tab-content">
    <h3>상품 후기</h3>
    
    <hr class="comment-separator">
    
</article>
<!-- 상품 문의 탭 -->
<article id="tabContent3" class="tab-content">
    <h3>상품 문의</h3>
    <div id="qnaSection">
        <h4>상품에 대해 문의하기</h4>
        <textarea id="qnaText" placeholder="상품에 대한 질문을 작성해 주세요."></textarea>
        <button id="submitQna">문의 작성</button>
        
        <h4>기존 상품 문의</h4>
        <ul>
            <!-- 기존 문의 리스트 출력 -->
            <c:forEach var="qna" items="${qnaList}">
                <li>
                    <p>문의: ${qna.question}</p>
                    <p>답변: ${qna.answer}</p>
                </li>
            </c:forEach>
        </ul>
    </div>
</article>

<article id="tabContent4" class="tab-content">
    <h3>교환/반품문의</h3>
    
</article>

</section>

<script>
    // 탭 클릭 시 내용 전환
    const tabs = document.querySelectorAll('.tab');
    const tabContents = document.querySelectorAll('.tab-content');

    function showTab(tabNumber) {
        // 모든 탭 내용 숨기기
        tabContents.forEach(tab => tab.classList.remove('active'));
        // 모든 탭 비활성화
        tabs.forEach(tab => tab.classList.remove('active'));
        
        // 클릭한 탭 내용 보이기
        document.getElementById('tabContent' + tabNumber).classList.add('active');
        // 클릭한 탭 활성화
        document.getElementById('tab' + tabNumber).classList.add('active');
    }

    // 각 탭에 이벤트 리스너 추가
    tabs.forEach((tab, index) => {
        tab.addEventListener('click', () => showTab(index + 1));
    });

    // 기본적으로 첫 번째 탭을 활성화
    showTab(1);

    
</script>

</body>
</html>
