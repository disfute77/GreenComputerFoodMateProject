<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<style>
	   .signUp-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
        }
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
	function toggleCustomInput() {
	    const select = document.getElementById('email_domain');
	    const customInput = document.getElementById('customMail');
	    
	    if (select.value === 'custom') {
	        customInput.style.display = 'block';
	        select.style.display='none';
	        customInput.focus();
	    } else {
	        customInput.style.display = 'none';
	        customInput.value = ''; // 입력 필드 초기화
	        select.style.display='block';
	    }
	}
	window.toggleCustomInput = toggleCustomInput;
	});
	
	function fn_overlapped(){
	    var _id=$("#slr_id").val();
	    if(_id==''){
	   	 alert("ID를 입력하세요");
	   	 return;
	    }
	    $.ajax({
	       type:"post",
	       async:false,  
	       url:"${contextPath}/member/overlapped",
	       dataType:"text",
	       data: {id:_id},
	       success:function (data,textStatus){
	          if(data=='false'){
	       	    alert("사용할 수 있는 ID입니다.");
	       	    $('#slrid_overlapped').prop("disabled", true);
	       	    $('#slr_id').prop("readonly", true);
	          }else{
	        	  alert("중복된 ID입니다.");
	          }
	       },
	       error:function(data,textStatus){
	          alert("에러가 발생했습니다.");
	       },
	       complete:function(data,textStatus){
	          //alert("작업을완료 했습니다");
	       }
	    });  //end ajax	 
	 }	
	
    function prepareFormSubmission() {
		
		if(!document.getElementById("slr_id").readOnly){
			alert("아이디 중복검사를 진행해 주십시오.");
			return false;
		}
		
		if(document.newSeller.password.value != document.newSeller.password_confirm.value){
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
		
		if((document.newSeller.email_domain.value == "custom") && !document.newSeller.customMail.value){
			alert("이메일 도메인을 입력하세요.");
			return false;
		}
        return true;
    }
    
    $(document).ready(function() {
        $("#searchBtn").click(function() {
        	
        	// JSP에서 전달된 serviceKey 변수 저장
            var serviceKey = "${servicekey}";
            
            // 사업자번호 입력값 가져오기
            let bsnum1 = $("#bsnum1").val().trim();
            let bsnum2 = $("#bsnum2").val().trim();
            let bsnum3 = $("#bsnum3").val().trim();

            // 입력값 유효성 검사
            if (bsnum1.length !== 3 || bsnum2.length !== 2 || bsnum3.length !== 5) {
                alert("올바른 사업자번호를 입력하세요 (예: 123-45-67890)");
                return;
            }

            // 사업자번호 조합
            let businessNumber = bsnum1 + bsnum2 + bsnum3;

            // .env에서 serviceKey 가져오기 (백엔드에서 처리 필요)
            $.ajax({
                url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=" + serviceKey,
                type: "POST",
                data: JSON.stringify({ "b_no": [businessNumber] }), // 사업자번호 배열
                dataType: "json",
                contentType: "application/json",
                accept: "application/json",
                success: function(result) {
                    console.log("조회 결과:", result);
                    alert("사업자 조회 성공! 콘솔을 확인하세요.");
                },
                error: function(xhr) {
                    console.log("오류 발생:", xhr.responseText);
                    alert("사업자 조회 실패! 콘솔을 확인하세요.");
                }
            });
        });
    });
</script>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
<div class="d-flex justify-content-center align-items-center">
	<div class="signUp-container">
	    <div class="row justify-content-center">
	        <div class="col-md-8">
	            <h1 class="mb-4 text-center">판매자 회원 가입</h1>
	            <form name="newSeller" action="${contextPath}/member/addSeller" method="post" onsubmit="return prepareFormSubmission()">
	                <div class="mb-3 row">
	                    <label class="col-sm-3 col-form-label text-end">아이디</label>
	                    <div class="col-sm-6">
	                        <div class="d-flex align-items-center">
		                        <input name="slr_id" id="slr_id" type="text" class="form-control me-2" placeholder="id">
		                        <input type="button" id="slrid_overlapped" class="btn btn-secondary" value="중복확인" onClick="fn_overlapped()">
		                    </div>
	                    </div>
	                </div>
	                <div class="mb-3 row">
	                    <label class="col-sm-3 col-form-label text-end">비밀번호</label>
	                    <div class="col-sm-5">
	                        <input name="password" type="password" class="form-control" placeholder="password">
	                    </div>
	                </div>
	                <div class="mb-3 row">
	                    <label class="col-sm-3 col-form-label text-end">비밀번호 확인</label>
	                    <div class="col-sm-5">
	                        <input name="password_confirm" type="password" class="form-control" placeholder="password confirm">
	                    </div>
	                </div>
	                <div class="mb-3 row">
	                    <label class="col-sm-3 col-form-label text-end">성명</label>
	                    <div class="col-sm-5">
	                        <input name="name" type="text" class="form-control" placeholder="name">
	                    </div>
	                </div>
	                <div class="mb-3 row">
	                    <label class="col-sm-3 col-form-label text-end">업체명</label>
	                    <div class="col-sm-5">
	                        <input name="nickname" type="text" class="form-control" placeholder="별명">
	                    </div>
	                </div>
	                <div class="mb-3 row">
	                    <label class="col-sm-3 col-form-label text-end">사업자번호</label>
	                    <div class="col-sm-7">
	                        <div class="row">
	                            <div class="col-sm-12">
							        <div class="d-flex align-items-center">
							            <!-- 사업자등록번호 입력 -->
							            <input type="text" id="bsnum1" name="bsnum1" maxlength="3" class="form-control me-2" placeholder="" style="width: 55px;">
							            <div class="col-sm-1 d-flex justify-content-center align-items-center me-2" style="width: auto; padding: 0 5px;">
		            							<span>-</span>
		        						</div>
		        						<input type="text" id="bsnum2" name="bsnum2" maxlength="2" class="form-control me-2" placeholder="" style="width: 45px;">
		        						<div class="col-sm-1 d-flex justify-content-center align-items-center me-2" style="width: auto; padding: 0 5px;">
		            							<span>-</span>
		        						</div>
		        						<input type="text" id="bsnum3" name="bsnum3" maxlength="5" class="form-control me-2" placeholder="" style="width: 75px;">
		        					</div>
							    </div>
	                        </div>
	                    </div>
	                </div>
					<div class="mb-3 row">
					    <label class="col-sm-3 col-form-label text-end">이메일</label>
					    <div class="col-sm-8">
					        <div class="d-flex align-items-center">
					            <!-- 이메일 입력 -->
					            <input type="text" id="email_id" name="email_id" maxlength="50" class="form-control me-2" placeholder="email">
					            <div class="col-sm-1 d-flex justify-content-center align-items-center me-2" style="width: auto; padding: 0 5px;">
            							<span>@</span>
        						</div>
        						<!-- 직접 입력 필드 -->
					            <input type="text" name="customMail" id="customMail" class="form-control me-2" placeholder="직접 입력" style="display:none; max-width: 200px;">
					            <!-- 이메일 선택 -->
					            <select id="email_domain" name="email_domain" class="form-select" style="max-width: 200px;" onchange="toggleCustomInput()">
					                <option value="naver.com">naver.com</option>
					                <option value="daum.net">daum.net</option>
					                <option value="gmail.com">gmail.com</option>
					                <option value="nate.com">nate.com</option>
					                <option value="custom">직접 입력</option>
					            </select>
					        </div>
					    </div>
					</div>
	                <div class="mb-3 row">
	                    <label class="col-sm-3 col-form-label text-end">전화번호</label>
	                    <div class="col-sm-5">
	                        <input name="phone_num" type="text" class="form-control" placeholder="phone">
	                    </div>
	                </div>

						<div class="mb-3 row">
						    <div class="col-12 text-center">
						        <input type="submit" class="btn btn-success" value="회원가입">
						        <input type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/member/signUpSelectForm'" value="취소">
						        <input type="reset" id="resetBtn" class="btn btn-success" value="다시입력">
						    </div>
						</div>
	            </form>
	            <script>
	            		document.getElementById("resetBtn").addEventListener("click", function() {
	            		// 1. 중복 검사 버튼 다시 활성화
	            	    document.getElementById("slrid_overlapped").disabled = false;
	            	    document.getElementById("slr_id").removeAttribute("readonly");

	            	    // 2. 직접 입력 이메일 필드 리셋 및 비활성화
	            	    document.getElementById("customMail").value = "";
	            	    document.getElementById("customMail").style.display = "none";

	            	    // 3. 이메일 도메인 선택을 기본값(naver.com)으로 변경
	            	    document.getElementById("email_domain").value = "naver.com";
	            	    document.getElementById("email_domain").style.display = "block";
	            	});
	            </script>
	        </div>
	    </div>
	</div>
</div>
</body>
</html>