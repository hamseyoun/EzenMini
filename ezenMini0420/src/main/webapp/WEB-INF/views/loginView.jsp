<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/> <!-- 페이지위조요청을 방지를 위한 태그 --> 
<title>JSP</title>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!--latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style>
/*브라우져별 상이함을 통일 */
html,body {
	height : 100%;
	margin : 0px;
	padding : 0px;
}

#mainRegion {
	height : auto;
}
.navbar {
	border-radius: 0px;
	margin-bottom : 0px;  
}

/*캐러셀 박스를 FULL로 채우기 */
.carousel-inner img {
	/*RWD를 위해 처리 */
	width: 100%;
	height : 100%;
}

.wordArtEffect { /*워드아트 형태글자로 줌 */
	color :white;
	text-shadow : 0px 0px 3px darkBlue;
}
.threeDEffect { /*3d효과 */
	color : white;
	text-shadow : 2px 2px 4px black;
}
.multiEffect {  /* 3개의 효과 동시 적용 */
	color : yellow;
	text-shadow : 2px 2px 2px black,0 0 25px blue,0 0 5px darkblue;
}

.fakeimg {
	height: 200px;
	background: #aaaaaa;
}
</style>
</head>
<body  onload="noBack();"  onpageshow="if(event.persisted) noBack();" onunload="">

<!-- 로그인 id반환 var값 user_id를 EL 로 사용 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />		
</sec:authorize>


<div class="container mt-1 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h4 id="hjumbo" class="text-center multiEffect">
		Home페이지로 BS4, jQuery, Ajax, RWD를 이용하고 있으며 서버는 스프링,시큐리티,마이바티스,오라클을 사용합니다
		</h4>
	</div>
</div>

<nav class="navbar navbar-expand-md bg-dark navbar-dark container font-weight-bold sticky-top">
	<a class="navbar-brand" href="#">
		<img src="images/bird.jpg" alt="Logo" style="width:40px;">
	</a>
	<!-- 컬랩스용 버튼(화면 축소시 생기는 상병 계급장 표시 -->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			 <li class="nav-item">
			 	<a class="nav-link" href="home"> <!-- ajax안하고 전체창 -->
			 		<i class="fas fa-home" style="font-size:30px;color:white;"></i>
			 	</a>
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link" href="#">핫 플레이스</a>
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link" href="main">핫 레시피</a> <!-- 로그인후 첫번째창 -->
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link" href="#">핫 애완동물</a>
			 </li>
			 <li class="nav-item dropdown">
			 	<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
			 		알림판
			 	</a>
			 	<div class="dropdown-menu">
			 		 <a class="dropdown-item" href="#">공지사항</a>
			 		 <a class="dropdown-item" href="board">게시판</a>
			 		 <a class="dropdown-item" href="#">Q&amp;A</a>
			 	</div>
			 </li>
			 <li class="nav-item">
	 			<a class="nav-link" href="dash">DashBoard</a>
	 		 </li>
	 		 <li class="nav-item">
	 			<a class="nav-link" href="util">Utils</a>
	 		 </li>
			 <li class="nav-item">
	 			<a id="lAbout" class="nav-link" href="about">About...</a>
	 		 </li>
	 		 <sec:authorize access="isAnonymous()">
		 		 <li class="nav-item">
		 		 	<a id="joinView" class="nav-link" href="joinView">회원가입</a> 
		 		 </li>
	 		 </sec:authorize>
	 		 <sec:authorize access="isAuthenticated()">
	 		 	 <li class="nav-item">
		 		 	<a class="nav-link" href="#">${user_id}</a>
		 		 </li>
	 		 </sec:authorize>
	 		 <sec:authorize access="hasRole('ROLE_ADMIN')">
			  	 <li class="nav-item">
		 		 	<a id="adminView" class="nav-link" href="adminView">Admin</a> 
		 		 </li>
			 </sec:authorize>				
		</ul>
		<ul class="navbar-nav ml-auto"> <!-- login,logout창은 ajax안되니 별도 창 -->
			<sec:authorize access="isAnonymous()">  <!-- 로그인 안한 상태면 로그인 버튼 보임  -->
				<li class="nav-item">
					<a id="loginView" class="nav-link" href="loginView">로그인</a>
				</li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()"> <!-- 로그인 한 상태면 로그아웃버튼을 보여줌 -->
				<li class="nav-item">
					<a class="nav-link" href="logoutView">로그아웃</a>	
				</li>
			</sec:authorize>
		</ul> 
	</div>	
</nav>

<div class="container mt-1 border border-dark p-0">
	<!-- 캐러셀을 구현하는 콘테이너 클래스 carousel slide와 data-ride="carousel"속성이 필요 -->
	<div id="demo" class="carousel slide p-0" data-ride="carousel" data-interval="4000">
		<!-- 슬라이드의 위치를 표시하는 마커 엘리먼트는 ul을 이용,class="carousel-indicators"를 사용-->
		<!--data-target은 마커 위치,data-slide-to는 슬라이드 번호  -->
		<ul class="carousel-indicators">
			<li data-target="#demo" data-slide-to="0" class="active"></li>
			<li data-target="#demo" data-slide-to="1" ></li>
			<li data-target="#demo" data-slide-to="2" ></li>			
		</ul>
		<!--class="carousel-inner"는 스라이드 사진 포함하는 콘테이너  -->
		<!-- class="carousel-item"은 각각의 스라이드 사진을 나타내는 콘테이너로 이미지사진을 포함 -->
		<div class="carousel-inner">
			<div class="carousel-item active">
				 <img src="images/la.jpg" 
				 	alt="Los Angeles" />
				 <!-- img뒤에 carousel-caption클래스 콘테이너를 마들고 제목과 살명 추가 -->
				 <div class="carousel-caption">
			        <h3>Los Angeles</h3>
			        <p>We had such a great time in LA!</p>
			     </div>   	
			</div>
			<div class="carousel-item">
				 <img src="images/chicago.jpg" 
				 	alt="Chicago" />
				 <div class="carousel-caption">
			        <h3>Chicago</h3>
			        <p>We had such a great time in LA!</p>
			     </div>    	
			</div>
			<div class="carousel-item">
				 <img src="images/ny.jpg" 
				 	 alt="New York" />
				  <div class="carousel-caption">
			        <h3>New York</h3>
			        <p>We had such a great time in LA!</p>
			     </div>   	
			</div>
		</div>
		
		<!-- 좌,우 콘트롤은 a를 사용하고 앞전으로 뒤로 가기를 처리 -->
		<a class="carousel-control-prev" href="#demo" data-slide="prev"> <!-- 앞전 -->
			<span class="carousel-control-prev-icon"></span> <!-- 아이콘처리 -->
		</a>
		<a class="carousel-control-next" href="#demo" data-slide="next"> <!-- 뒤 -->
			<span class="carousel-control-next-icon"></span> <!-- 아이콘처리 -->
		</a>
	</div>
</div>

<!-- ajax로 처리시 나타내줄 메인 페이지 영역 -->
<!-- login화면 -->
<div id="mainRegion" class="container mt-3">	
	<h3 id="linfo" class="text-center multiEffect bg-warning"></h3>
	<h3 class="text-center text-info threeDEffect">로그인</h3>
	<div id="div1" class="text-center text-danger mb-3"></div> 
	<!-- 로그인 관련 매새지를 서버에서 받아 작성 -->
	<form id="frm1" name="frm1" method="post" action="login">
		<!-- security에서 action은 login으로 기본 설정하면 콘트롤라로 요청하는게 아니고 security의 login-processing-url = "/login"으로 요청-->
		<!-- csrf를 방지하기 위한 헤더 부분을 숨겨서 추가 -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="form-group">
			<label for="uId">아이디</label>
			<input type="email" class="form-control" name="pid" placeholder="E-Mail주소 입력" 	id="uId" required/>			
		</div>
		<div class="form-group">
			<label for="uPw">비밀번호</label>
			<input type="password" class="form-control" name="ppw" id="uPw"	placeholder="비밀번호 입력" required/>
		</div>
		<!-- 로그아웃 안하고 접속 단절후  일정시간 로그인 없이 재접속 -->
		<div class="form-group form-check">
			<input type="checkbox" class="form-check-input" id="rememberMe" name="remember-me" checked>
			<label class="form-check-label" for="rememberMe" aria-describedby="rememberMeHelp">remember-me</label>			
		</div>
		<!--aria-describedby는 스크린리더에서 설명을 할 내용  -->
		<button type="submit" class="btn btn-success">로그인</button>&nbsp;&nbsp;&nbsp;		  
		<a id="lJoinView" href="joinView" class="btn btn-danger">회원가입</a>			
	</form>
	<div class="d-flex mt-4">		
		<a id="klog" href="${kakao_url}" class="btn btn-primary">
 			<img width="130" src="images/kakao_login_large_narrow.png"/>
 		</a>&nbsp;		
 		<a id="nlog" href="${naver_url}" class="btn btn-primary">
 			<img width="130"  src="images/naverid_login_button_short.png"/>
 		</a>&nbsp;  	
 		<a id="glog" href="${google_url}" class="btn btn-primary">
			<img width="130" src="images/btn_google_signin.png"/>
		</a> 		
	</div>	
</div>

<!-- footer영역 -->
<footer class="container mt-5 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h3 class="text-center threeDEffect">Online Store Copyright</h3>
		<form action="#" method="POST">
			<div class="form-group">
				<label for="email">&nbsp;&nbsp;주문 문의</label>
			    <input type="email" class="form-control" placeholder="Enter email" id="email"/>
			</div>
			<button type="submit" class="btn btn-danger">Sign Up</button>
		</form>
	</div>
</footer>

<!-- modal -->
<div class="container mt-2">
	<button id="modal" type="button" class="btn btn-primary d-none" data-toggle="modal" data-target="#myModal" >
		 Open modal
	</button>
</div>

<div class="modal fade" id="myModal">
	 <div class="modal-dialog">
	 	<div class="modal-content">
	 		<div class="modal-header bg-info">
	 			<h4 class="modal-title multiEffect"><i class="fa fa-info-circle" aria-hidden="true">Info</i></h4>
	 			<button class="mclose" type="button" class="close" data-dismiss="modal">&times;</button>
	 		</div>
	 		<div class="modal-body">	 			
	 			<h4><i class="fa fa-user-circle fa-3x multiEffect" aria-hidden="true"></i></h4><h4 id="mbody" class="text-center multiEffect"></h4>
	 		</div>
	 		<div class="modal-footer">
	 			<button class="mclose" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	 		</div>
	 	</div>
	 </div>	
</div>

<script>
$(document).ready(function(){ 
	$("#hjumbo").text("로그인창으로 스프링시큐리티를 이용하여 로그인을 처리합니다.");
	<c:choose>
		<c:when test="${not empty log}">
			$("#linfo").text("welcome");
		</c:when>
		<c:when test="${not empty logout}">
			$("#linfo").text("Logout 성공");
		</c:when>
		<c:when test="${not empty error}"> 
			$("#linfo").text("로그인 실패");
		</c:when>
		<c:otherwise>
			$("#linfo").text("welcome"); 
		</c:otherwise>
	</c:choose>
	
	$("#joinView").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#joinView").attr("href"),
			type : "GET",
			date : "",
			success : function(data) {				
				$("#mainRegion").html(data);
				$("#hjumbo").text("회원가입창으로 ajax와 암호화를 사용합니다.");
			},
			error : function() {				
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}			
		});
	});	
	
	$("#lAbout").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#lAbout").attr("href"),
			type : "GET",
			date : "",
			success : function(data) {				
				$("#mainRegion").html(data);
				$("#hjumbo").text("우리회사 정보창입니다.");
			},
			error : function() {				
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}			
		});
	});
	
	$("#lJoinView").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#lJoinView").attr("href"),
			type : "GET",
			date : "",
			success : function(data) {				
				$("#mainRegion").html(data);
				$("#hjumbo").text("우리회사 정보창입니다.");
			},
			error : function() {				
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}			
		});
	});	
});
</script>

<!-- back방지 -->

<!--
<script>
history.pushState(null, null,location.href); 
window.addEventListener('popstate', function(event) {
    history.pushState(null, null, location.href); 	 
});
</script>
 -->
<script>
window.history.forward();
function noBack() {
	window.history.forward();
}
</script>
</body>
</html>