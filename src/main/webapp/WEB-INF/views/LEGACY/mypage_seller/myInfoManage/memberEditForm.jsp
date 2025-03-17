<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<style>
	   .signUp-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
        }
</style>
</head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
</script>
<body>
<div class="container mt-1">
	<div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
      		<h5 class="mb-0 fw-bold">회원정보 수정</h5>
      		</div>
      		<div class="d-flex justify-content-start align-items-center">
				<div class="signUp-container">
				    <div class="row justify-content-start">
				        <div class="col-md-12">
				        	<form name="updateSeller" action="${contextPath}/member/updateSeller" method="post">
				                <div class="mb-3 row">
				                    <label class="col-sm-3 col-form-label text-end">아이디</label>
				                    <div class="col-sm-5">
				                        <input name="slr_id" type="text" class="form-control" placeholder="id" value="${sellerInfo.getSlr_id()}" readonly>
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
				                        <input name="name" type="text" class="form-control" placeholder="name" value="${sellerInfo.getName()}" required>
				                    </div>
				                </div>
								<div class="mb-3 row">
								    <label class="col-sm-3 col-form-label text-end">이메일</label>
								    <div class="col-sm-8">
								        <div class="d-flex align-items-center">
								            <!-- 이메일 입력 -->
								            <input type="text" id="email_id" name="email_id" maxlength="50" class="form-control me-2" placeholder="email" required>
								            <div class="col-sm-1 d-flex justify-content-center align-items-center me-2" style="width: auto; padding: 0 5px;">
			            							<span>@</span>
			        						</div>
											<input type="text" id="email_domain" name="email_domain" maxlength="50" class="form-control" placeholder="email" required>
								        </div>
								    </div>
								</div>
				                <div class="mb-3 row">
				                    <label class="col-sm-3 col-form-label text-end">전화번호</label>
				                    <div class="col-sm-5">
				                        <input name="phone_num" type="text" class="form-control" placeholder="phone" value="${sellerInfo.getPhone_num()}" required>
				                    </div>
				                </div>
									<div class="mb-3 row">
									    <div class="col-12 text-center">
									        <input type="submit" class="btn btn-success" value="정보수정">
									        <input type="reset" class="btn btn-secondary" value="취소">
									    </div>
									</div>
				            </form>
			    		</div>
					</div>
				</div>
    		</div>
</div>
</body>
<script>
	document.addEventListener("DOMContentLoaded", function () {
	   
	    function setEmail() {
	    	let email = "<c:out value='${sellerInfo.getEmail()}'/>"; // 서버에서 받은 이메일 값
	    	
	    	if (email.includes("@")) {
	            let emailParts = email.split("@");
	            document.getElementById("email_id").value = emailParts[0]; // 아이디 부분
	            document.getElementById("email_domain").value = emailParts[1]; // 도메인 부분
	        }
	    }
	
	    setEmail();
	});
	
</script>
</html>